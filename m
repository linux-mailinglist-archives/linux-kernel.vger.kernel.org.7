Return-Path: <linux-kernel+bounces-893714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1855C48386
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E6C14F5613
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404683064A9;
	Mon, 10 Nov 2025 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDQ4Cz+X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4E286430;
	Mon, 10 Nov 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792977; cv=none; b=BQWzLxb04a791MDl7RZEQXewT6dLOPeDo1V1yJm4RE4ZMvoOXE3s63zDegU1dJfv2dx+ckCtMC1pgudNYenSfOIPZbGXUUe6Olk9qELEbT9eO67W9++i1yABPaxHcgP4e4pjMQQWW6BHTLlThU+/rXGBC+XAqojvHhpuE8xknc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792977; c=relaxed/simple;
	bh=KEsFDWJsiy5zwravyB1N1PHZjjSBjPIwzpM0yYr48Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gETZ3jUXIM1cIp63G/LBxNZJdCsY6vjwTIKKY2sMAxeTotMyD3sWht096JT5VHUOrra8FU/InNlGUc7M9AwLrY4euS4KItPTkeuXP7U7EXhwQaahZisab99q6zL4zXAb7ZDeED7nbBnknMnKUKbfEeekm9gKJMaOv7sCFVGvTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDQ4Cz+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28967C4FF13;
	Mon, 10 Nov 2025 16:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762792977;
	bh=KEsFDWJsiy5zwravyB1N1PHZjjSBjPIwzpM0yYr48Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iDQ4Cz+X3o4xjMw9mAqBUF8bz0qchk/fgc/pwM4bIAX/2jRvYdZVxdsSF8jvccCYt
	 uhJ5KWYLzmISeKuS9vvSw5GblJN3lrnjuQ7r2kTgqTU1kRlUnrhQmtc7RfZ0seUyYO
	 u+glXtO2ViuzhlB45VDYTGZl+2IgKN3/rCkIYK33upHe6PXF9cZdJXg8SbQojwXmRl
	 Vl7uilhnJhzpmQuMYj0w+NcFJQ5LzjxsPwGhL+2myU+dosseH7U5LlZrPCiXZb2A1D
	 8aNBbjrjZ7Kq19cVpQQu2SVAkbnkHZ1YUktQdlcGEOI6sUlRzTHMhJl1SCnfHNvpRw
	 oODsOip/305mw==
Date: Mon, 10 Nov 2025 06:42:56 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <andrea.righi@linux.dev>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Dan Schatzberg <schatzberg.dan@gmail.com>,
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] sched_ext: Use per-CPU DSQs instead of per-node
 global DSQs in bypass mode
Message-ID: <aRIWEBDmjxScAsyP@slm.duckdns.org>
References: <20251109183112.2412147-1-tj@kernel.org>
 <20251109183112.2412147-5-tj@kernel.org>
 <aRGXd0QwgqBVu7Gq@gpd4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRGXd0QwgqBVu7Gq@gpd4>

Hello,

On Mon, Nov 10, 2025 at 08:42:47AM +0100, Andrea Righi wrote:
> On Sun, Nov 09, 2025 at 08:31:03AM -1000, Tejun Heo wrote:
> > Change bypass mode to use dedicated per-CPU bypass DSQs. Each task is queued
> > on the CPU that it's currently on. Because the default idle CPU selection
> > policy and direct dispatch are both active during bypass, this works well in
> > most cases including the above.
> 
> Is there any reason not to reuse rq->scx.local_dsq for this?
...
> > The bypass DSQ is kept separate from
> > the local DSQ to allow the load balancer to move tasks between bypass DSQs.

This is the explanation for that. More detailed explanation is that local
DSQs are protected by rq locks and that makes load balancing across them
more complicated - ie. we can't keep scanning and transferring while holding
the source DSQ and if the system is already heavily contended, the system
may already be melting down on rq locks.

Thanks.

-- 
tejun

