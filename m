Return-Path: <linux-kernel+bounces-799453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D9CB42BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC611886A72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408592EAB60;
	Wed,  3 Sep 2025 21:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgmBoTQX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA0CEEC0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935286; cv=none; b=jMwq7y75iGVFfB3lC0p9WELyDYVY2ygsc3ehxoA8krkKoZup9DQfM9I4pmlUkfh1z4VFzPxaTpibueh17pBU+XyalxWKW5GeCubeow8ZvwHZK3kzG/gRTHcNHqCSoQnzRuTWrDqdVcYkaU2NBnYV/AETMSxXJQ4ol+vbFLlHJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935286; c=relaxed/simple;
	bh=svNgOD63krHvR+PFk6mdx4seXv8DRiPa4oF63GosQGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxzkPJSTpMKfO+nGO37nYfJ5feSzsxJq0XcaSCR2Yfp5dYzjkn3gF5KTmfA+BzO7lKMF1Y9/g3ON2vevd8YF86h3+PJ71Ue+X9CPhZ7i15Uk6tDSMqgu7LBLLmL1Dx98FEt25GGqkVqDzZ45mGMVcSbbtcKRZ9ZuvXU/Hrs/+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgmBoTQX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6CCC4CEE7;
	Wed,  3 Sep 2025 21:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756935286;
	bh=svNgOD63krHvR+PFk6mdx4seXv8DRiPa4oF63GosQGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgmBoTQXLmDZAzu9UKUsmp0rIVNiyMmwJfpkRxiEFGPhhMhHqY7OEJMSBKrYkRPB2
	 jaFlLYBTxaXwt5a/b605vyALMU7waAJS1EbttEh40JjFdOqtHFJQ/aifhr5Gox1ggm
	 6sTFUtru17G3tM+wUI+RS9HIUCsE8j737KZllIyYuQ8m/+IzCDGH/MbNPMUH8VeNVP
	 nce9rx+lwcOZbc4d2QwqLROTSjhf90bxGQ4r5RBPRNwfC45iii6389XuHwOVjaBger
	 +svjZZ7pHCIo/3WK+VvTxFeIosfv9c+kw1N4u2Cvdeagrgi9ISRST4MLRehbYmbRz3
	 hhwmXegTWCKDQ==
Date: Wed, 3 Sep 2025 11:34:45 -1000
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com, arighi@nvidia.com, multics69@gmail.com
Cc: linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCHSET sched_ext/for-6.18] sched_ext: Misc changes
Message-ID: <aLi0dTkYNP6FgMMB@slm.duckdns.org>
References: <20250902234817.279206-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902234817.279206-1-tj@kernel.org>

On Tue, Sep 02, 2025 at 01:48:02PM -1000, Tejun Heo wrote:
> A collection of four misc patches.
> 
> - Make scx_task_iter a bit easier to use.
> 
> - Keep bypass on between enable failure and disable.
> 
> - Move types and accessors into ext_internal.h.
> 
> - Wrap event percpu allocation in a struct to ease adding more percpu
>   fields.
> 
>  0001-sched_ext-Make-explicit-scx_task_iter_relock-calls-u.patch
>  0002-sched_ext-Keep-bypass-on-between-enable-failure-and-.patch
>  0003-sched_ext-Move-internal-type-and-accessor-definition.patch
>  0004-sched_ext-Put-event_stats_cpu-in-struct-scx_sched_pc.patch

Applied to sched_ext/for-6.18.

Thanks.

-- 
tejun

