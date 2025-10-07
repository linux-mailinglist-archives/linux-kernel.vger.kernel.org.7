Return-Path: <linux-kernel+bounces-844206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF8BC14C7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 14:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5482189D155
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 12:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A72797BE;
	Tue,  7 Oct 2025 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciCSULr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD901922F6
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838587; cv=none; b=ROyuOs53UrO8kfC1bl9gH0rNhj3JTShnbzhrtUYR1gmOFnqUIXcIxIoqiBIIG10KseOiRq76/EafO/4SAsPm6oynkhKLWHHpdKKw5AiVNNKHG28vvcaR7Ltl18qt/q9H++BFB+s5B+b3XOxUB3X+F6b/Zd1dbK7zkFrOojFMzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838587; c=relaxed/simple;
	bh=ShHsLtzBp0UFyd2UTyyStJsy/xQBj/pCfGhkIbuw9mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Flxby5TEHy/4jEVLVJ84dUq8KcSr8PesYSURs4+Qo4uQUm49PzG1f/Fs2MKZURD848rrZ3efsNpzFdWI4xFMz5H/QjX3XLVX9sUQ+eKQRa+iTnGSvnLIpXLEwjWeiCNn2iADXRc3SQsCfghZ0dCAdnJrfjCLPbTUI+xjoYBqrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciCSULr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538A3C4CEF1;
	Tue,  7 Oct 2025 12:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759838584;
	bh=ShHsLtzBp0UFyd2UTyyStJsy/xQBj/pCfGhkIbuw9mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ciCSULr5tpzNkg5xM9BpSdQSxB/98lSK/sYMUAok6ojV/cU00lWV4x7Y2MK+KAnND
	 xBSr6EQ6RMpw01jQVAYgJyXesKdP12GIythjRL+A8ZujlUE0eVz7NupkMUdf6SS6Kt
	 Kx5jDteSZYU4S34WKTxTQ2CRb1amZs8XdDq3ubuh0u8rCugPt6ENME3xAfB7+FAWU1
	 dOAuc4qp5kB2TM5gcsvr7Vqf5jIOPqLGk9WNE+2fFg7fwYnUMHlE943V/mJhnY7LBB
	 VttwLadpgkvHRq4Cg6SgFmysxex5yk+gUQifZTOWx4TrFtjEF3mtQuiwjmAw0FkGBc
	 b9FKARKWza4SQ==
Date: Tue, 7 Oct 2025 14:02:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Demi Marie Obenour <demiobenour@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PID namespace init releases its file locks before its children
 die
Message-ID: <20251007-pause-raunen-b960e62d000c@brauner>
References: <58ac5d49-14a9-4fe6-a5a4-746d6b73f82b@gmail.com>
 <20251003123828.GA26441@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251003123828.GA26441@redhat.com>

On Fri, Oct 03, 2025 at 02:38:28PM +0200, Oleg Nesterov wrote:
> Add CCs.
> 
> I can't really help, just my 2 cents...
> 
> I don't think we can change do_exit() to call exit_files() after
> exit_notify().
> 
> At first glance, technically it is possible to change do_exit() so
> that the exiting reaper does zap_pid_ns_processes() earlier... But
> even if this is possible, I think that this complication needs more
> justification.

I agree. Relying on side-effect of file locks being released isn't exactly
a great idea. I'm certainly don't want to give any guarantee there. It's
doable with cgroups which is the correct solution for this imho.

