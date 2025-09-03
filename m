Return-Path: <linux-kernel+bounces-799026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21FF5B42602
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99633B0639
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0096328DB56;
	Wed,  3 Sep 2025 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKhXp5jZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A2286D7B;
	Wed,  3 Sep 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914889; cv=none; b=PcaRWyUL/D6yV1EePfxB9fJf8amGihZCCg2TmTDz5CUpTRetixTPMowdU5l/K0prrhJoTui/SLX8qp0zEKzGt3OXmMSPjJIWg6c76rWT/hfBa10oNgEWLvVzmegUGy+7QmQ9m5Zs8BPyjXXkQN1/q2yVWgqTrUKBLc1Q6iBATbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914889; c=relaxed/simple;
	bh=AJEEDVCChpHoUUnjffZQKyPoyFals8oBhyMIl/tiyRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHanM2ExzKck/LLg/RBV45PnhMqlLuC6yY77a0HGE9rV4hvxO5KWInZifiHEYiqHqBJ16vjhy2O5TKcQI0c0ZXTvsSV7IEHuXgoaNBaAAsQxKLnOOPRyQURrlaTm60hpxuB0mrPKoHwiPeyZk0bNj0ZkjBOOCtUoKJJlPuEg8NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKhXp5jZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA81CC4CEE7;
	Wed,  3 Sep 2025 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756914888;
	bh=AJEEDVCChpHoUUnjffZQKyPoyFals8oBhyMIl/tiyRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKhXp5jZHMZGISjz3llpNgEfmyavmyOiKXCBIGJCQ5pjPczhensTPGT35LqKzAmW5
	 Y/Yr22uFARzimyeWgP6j5/6MWBG9gAOrDiFIIO2aUpwxogfc3gqG6HsV/vJNdlIw4j
	 GJViiyTdzYxT1gZb6F95So5SkbeNNaZUpTZ3UsjUC6FXfqXOaLjF128xTVXjPHAsgm
	 1TIt1U6kcWYewSNH6PdmsarbIJA2kgo4j5HZtAsWNYm5MA0Ll31Wiow+1qsyBBEErz
	 NkULMf8Miy5CW6x0lvy9nhcTxOXVTaPFx+/mHVwp783/lyAxbAdDq8oLfccPDpTDZd
	 ofDRHaxHhLa3w==
Date: Wed, 3 Sep 2025 05:54:47 -1000
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
Subject: Re: [PATCH v5 1/3] sched_ext: Introduce scx_bpf_cpu_rq_locked()
Message-ID: <aLhkx1cB0nRttAuT@slm.duckdns.org>
References: <20250901132605.2282650-1-christian.loehle@arm.com>
 <20250901132605.2282650-3-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901132605.2282650-3-christian.loehle@arm.com>

On Mon, Sep 01, 2025 at 02:26:02PM +0100, Christian Loehle wrote:
> Most fields in scx_bpf_cpu_rq() assume that its rq_lock is held.
> Furthermore they become meaningless without rq lock, too.
> Make a safer version of scx_bpf_cpu_rq() that only returns a rq
> if we hold rq lock of that rq.
> 
> Also mark the new scx_bpf_cpu_rq_locked() as returning NULL.
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>  kernel/sched/ext.c                       | 23 +++++++++++++++++++++++
>  tools/sched_ext/include/scx/common.bpf.h |  1 +
>  2 files changed, 24 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 4ae32ef179dd..9fcc310d85d5 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -7430,6 +7430,28 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>  	return cpu_rq(cpu);
>  }
>  
> +/**
> + * scx_bpf_cpu_rq_locked - Return the rq currently locked by SCX
> + *
> + * Returns the rq if a rq lock is currently held by SCX.
> + * Otherwise emits an error and returns NULL.
> + */
> +__bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(void)

How about naming it scx_bpf_locked_rq()? That reads a lot easier to me and
given that it doesn't take @cpu anymore, the _cpu_ part of the name isn't
necessary.

Thanks.

-- 
tejun

