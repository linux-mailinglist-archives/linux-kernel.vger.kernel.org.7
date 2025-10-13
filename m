Return-Path: <linux-kernel+bounces-851152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3217BD5A99
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4032B1888E7B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB0D2D2397;
	Mon, 13 Oct 2025 18:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4Irdc1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05102459D4;
	Mon, 13 Oct 2025 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379201; cv=none; b=pxPNXkQu1jPE7xxFLUqVzG6pcPM+VBynnA4ihnvEnN/1aflKqJDeRvsUuSBJttfflvlqhUUNeoGKeQYmsj9y1gwT0C7U4JHxFmRvWgj9Kbx3EXLASwOwVV9LzWAwbvNznINV6TMy/N9iPSP6iWAJfinKC45KB6DviMKhbxMITJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379201; c=relaxed/simple;
	bh=1vUka8122ScKWzzigsTJzi2Qub0GB6AMf0pR/3NSdZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+CwIxAfTHYCVXQCIw6IiaHXFErepuv4PgSdaQBy1Xic5kOfo9vHRwRftLNDdUPCasm+7GOn74RPELjvhrc00CNlnKHAcGmqUZ2WTz6M8bKShAxj4wEvOL+BI2cQ+T2BjYPcOSufCh9LLtM3Mm3Y8a2Zj3e/MHMNnk6ix6wsDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4Irdc1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE03C4CEE7;
	Mon, 13 Oct 2025 18:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760379201;
	bh=1vUka8122ScKWzzigsTJzi2Qub0GB6AMf0pR/3NSdZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4Irdc1G0VmUBBzzGPTq3HOKmiAiC7zbBXGZRbgej0am1OVdJGSdrtSqAo8Qrlswl
	 4q/1x7J5c9U4qj4erCoiJuugolf5ZLqnv0/rMDHuz+o2wE4O/fsb0wj+xU06yl/yij
	 h/Sd+VNrzauQgqGUzL4jaDY3UJ2qhciJUQKfcoxJ5Otwv9XKPj5cz6p2KXjHU3d3VR
	 nmZ4OD0qVu0+c6S/7EqEx8vV/9QsdmBCA95lkevv67AhyEQqEG2OlYaG9eKCBa6Xed
	 hW2ay4A2KYy757hGdie+xtJkQB0NK9xBFUYAZtUZb82ndpduMgQV5CASqH+hQncX8z
	 9ZIpbnF1Bs/7w==
Date: Mon, 13 Oct 2025 08:13:20 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18-fixes] sched_ext: Mark
 scx_bpf_dsq_move_set_[slice|vtime]() with KF_RCU
Message-ID: <aO1BQOqGaKnS2qwC@slm.duckdns.org>
References: <aORuaIXJftQDMBIA@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aORuaIXJftQDMBIA@slm.duckdns.org>

On Mon, Oct 06, 2025 at 03:35:36PM -1000, Tejun Heo wrote:
> scx_bpf_dsq_move_set_slice() and scx_bpf_dsq_move_set_vtime() take a DSQ
> iterator argument which has to be valid. Mark them with KF_RCU.
> 
> Fixes: 4c30f5ce4f7a ("sched_ext: Implement scx_bpf_dispatch[_vtime]_from_dsq()")
> Cc: stable@vger.kernel.org # v6.12+
> Signed-off-by: Tejun Heo <tj@kernel.org>

Applied to sched_ext/for-6.18-fixes.

Thanks.

-- 
tejun

