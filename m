Return-Path: <linux-kernel+bounces-863741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB67BF8FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 23:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C9D3BDA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA1D296BA9;
	Tue, 21 Oct 2025 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRd9u+dC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10252777FC
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761083792; cv=none; b=ag9A8CwjD0YiA8tPxAz3yYE481Lclq14RRS+WOrgxmQwmYM6hbOzadziMcAm3Y1y6gOaNPjB0P0UYUGP8OC1WWpEPHawtds7RxB2iiGu/WGMoqHx2MbPd+Pe9aDKYxwmIAuY5aT6asdaSgG6rYmitBM/2CsLBdi5470fM+tM15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761083792; c=relaxed/simple;
	bh=tn/a6WHLadou31z535LBNqrmC7LbXls2FWTKbAvQB44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUnTosV80Tq7xWkBm/PO5LZkXRNisY/Qe5uYYF1Dc9iuLdirMp+1SVsTmgVoAP6QRA7/qohG2tjkRsW6ToLq5ZSrXs+VvVXOJTibnow8dDwisq2Iv7NmwusI0fh6pLWDuWh6t3q6GrNYP9R8EjDmzbwOTyHdNfhMF7asKXV5Yjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRd9u+dC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0691BC4CEF1;
	Tue, 21 Oct 2025 21:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761083791;
	bh=tn/a6WHLadou31z535LBNqrmC7LbXls2FWTKbAvQB44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eRd9u+dCJ/osx7ugH9jA/vgDMJ4qfg7fLSAVYvCd02joXklysuKX78fnWaQV+vgk4
	 t/r3vZXaPeXgKlMWM60T1InzHb8BD6S703rZmfcSUVHcVvNiDBf4MJj9oxgJqEMBTg
	 33Hhhs7drXxn7juiKlXZqUofsXzMjboGC0W99Ie87RllxdUIf7j2mm9JUW4nJQA435
	 riMSAIbQp5RYlnyuy6mgEAWJiH0/IN/8/6X6kxDY9QC2jS2dDvU+tAohh2vEbig0kQ
	 E2WDbYVcpjXF/cI1QwlOZFF+p2LYuobBGhlkYLaZLkOuW3yiKevc/ItnxNvbbnqJ5y
	 1Tj9wI0zMt3uQ==
Date: Tue, 21 Oct 2025 11:56:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	simona.vetter@ffwll.ch, christian.koenig@amd.com,
	pstanner@redhat.com, dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] workqueue: Add an interface to taint workqueue
 lockdep with reclaim
Message-ID: <aPgBjmIm6n9H-R_u@slm.duckdns.org>
References: <20251021213952.746900-1-matthew.brost@intel.com>
 <20251021213952.746900-2-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021213952.746900-2-matthew.brost@intel.com>

Hello,

On Tue, Oct 21, 2025 at 02:39:50PM -0700, Matthew Brost wrote:
> Drivers often use workqueues that are in the reclaim path (e.g., DRM
> scheduler workqueues). It is useful to teach lockdep that memory cannot
> be allocated on these workqueues. Add an interface to taint workqueue
> lockdep with reclaim.

Given that it's about reclaim, "memory cannot be allocated" may be a bit
misleading. Can you make the description more accurate? Also, it'd be great
if you can include an example lockdep splat for reference.

> Cc: Tejun Heo <tj@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  include/linux/workqueue.h | 19 +++++++++++++++++++
>  kernel/workqueue.c        |  9 +++++++++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
> index dabc351cc127..954c7eb7e225 100644
> --- a/include/linux/workqueue.h
> +++ b/include/linux/workqueue.h
> @@ -553,6 +553,25 @@ alloc_workqueue_lockdep_map(const char *fmt, unsigned int flags, int max_active,
>  						1, lockdep_map, ##args))
>  #endif
>  
> +
> +#ifdef CONFIG_LOCKDEP
> +/**
> + * taint_reclaim_workqueue - taint workqueue lockdep map with reclaim
> + * @wq: workqueue to taint with reclaim
> + * gfp: gfp taint
      ^@

> + *
> + * Drivers often use workqueues that are in the reclaim path (e.g., DRM
> + * scheduler workqueues). It is useful to teach lockdep that memory cannot be
> + * allocated on these workqueues.
> + */
> +extern void taint_reclaim_workqueue(struct workqueue_struct *wq, gfp_t gfp);
> +#else
> +static inline void taint_reclaim_workqueue(struct workqueue_struct *wq,
> +					   gfp_t gfp)

Would a more direct name work better, maybe something like
workqueue_warn_on_reclaim()?

Hmm... would it make sense to tie this to WQ_MEM_RECLAIM - ie. enable it
implicitly on workqueues w/ the flag set?

Thanks.

-- 
tejun

