Return-Path: <linux-kernel+bounces-872296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A26C0FD8A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C479F4E297B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91463168EC;
	Mon, 27 Oct 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD9SBQWj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8533081AE;
	Mon, 27 Oct 2025 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588344; cv=none; b=SgVlyvTOQu44yX+ThA8TeHQaXgcE62q0IVBTPnDBG+BS2NEk6XAFgRrzaZbAX/BJ3R0n34ChjEGBSuI69WabQr9CrmGuGGlrOCMC1kRfzKWsGdhh9U6TBJO9tFDh1PpiR8a7s+KCQ2HPOuyRo/UU76Lsw274TmlLlZvpIJhTkqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588344; c=relaxed/simple;
	bh=wgCi9Ns6pB1FTZmXRyJMfiJCFeTw2qdaAWD8i3X6+3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZIkF4mHC2PXV8Lj6+da54TokySUE64D66bV6qRXwcC1SBSWu3DGU4vESkwldZaC2KLuVc50h88P8/EgO1BuIPgsFHisrMi8zwRCSwlSj0ErWEthzrhgaRXNOV3u5nHHnaY3wbCx0YO23ViwKfNE/NP6e++LPQhDBEDYnLI3TV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD9SBQWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8E5C4CEF1;
	Mon, 27 Oct 2025 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761588343;
	bh=wgCi9Ns6pB1FTZmXRyJMfiJCFeTw2qdaAWD8i3X6+3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tD9SBQWjeGLzTQ0V0fy/F5g6P0M7mpQhxtv48ZD1BUZYmVA+CAfI6FdaAmBRMU+mv
	 bWXgRTuLYzmNNOTTRQz/dvilHw9YmuN+1prbpvn+o06FvQqP2YWhq2s7k+XRHNCob+
	 PowKNv6neni87VctfY8gZMsRXnLcSWNP4SG5Bmkq4GKV50TRrN4NHZC5j7mIHNmJsF
	 3zsLgqsNe5TeT4Qf0v7IIDKtVjO9y8Z7b2LKjEkJxfTk19IcaMDBccp36me3Xt0I6F
	 fjAvcOwGYraZKPWTgNyBiQNy/TuyN/GOaYYmOV0p5yXKJQvUuZtJ/H+DvjeW4FO/0g
	 fpoxCwZ7gF10Q==
Date: Mon, 27 Oct 2025 08:05:42 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <andrea.righi@linux.dev>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, Wen-Fang Liu <liuwenfang@honor.com>
Subject: Re: [PATCH 3/3] sched_ext: Allow scx_bpf_reenqueue_local() to be
 called from anywhere
Message-ID: <aP-0dkIQa7iwHv5e@slm.duckdns.org>
References: <20251025001849.1915635-1-tj@kernel.org>
 <20251025001849.1915635-4-tj@kernel.org>
 <20251027091822.GH3245006@noisy.programming.kicks-ass.net>
 <aP-XAGrWQY1d6Bq9@slm.duckdns.org>
 <20251027174953.GB3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027174953.GB3419281@noisy.programming.kicks-ass.net>

On Mon, Oct 27, 2025 at 06:49:53PM +0100, Peter Zijlstra wrote:
> > That's what I thought too and the gap between balance() and pick_task() can
> > be closed that way. However, while plugging that, I realized there's another
> > bigger gap between ttwu() and pick_task() because ttwu() can directly
> > dispatch a task into the local DSQ of a CPU. That one, there's no way to
> > close without a global hook.
> 
> This would've been prime Changelog material. As is the Changelog was so
> vague I wasn't even sure it was that particular problem.
> 
> Please update the changelog to be clearer.

Oh yeah, good point.

> Also, why is this patch already in a pull request to Linus? what's the
> hurry.

Hmmm? It shouldn't be. Let me check again. No, it isn't. What are you
looking at?

Thanks.

-- 
tejun

