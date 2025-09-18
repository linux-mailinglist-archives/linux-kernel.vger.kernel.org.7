Return-Path: <linux-kernel+bounces-822816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7347CB84BBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36581C25793
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407D306498;
	Thu, 18 Sep 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="pcGmz+f8"
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EB830749E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200608; cv=none; b=o7bTVcqpVp/OT5DYeK1P5czGPqC2v6JAzwtEnGoScahCBpVqS5vadzMt374htwsIAdgfWTgEIhbQsZCXX11/JV3rskA+ePbAXlj8fW3MDGOqnsySI6QGzb6IeVXlYng5/rm8jhfiAaX5f45fCTdo5R9kyJsj5N7NPb8y5qIZ3ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200608; c=relaxed/simple;
	bh=oZQ71Yy3FFXzAfFjGRoYoDt9iQTanIC3d59za0gF9uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5bqp2tzhak6WdihZ/UCneBw2Odb19+U/PLPjDyNPx/ano3JE0/fHCn/26J9BQj0xtU/JfeLjNHcUzY4qw5ydUpir7pX7UNREcp/kv/5CpiIcD0F/FKS67TYup9QvfzqVp9wGttoHXUP/YzI84oR5w1O/0bx68zEdKoq+jEbYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=pcGmz+f8; arc=none smtp.client-ip=115.124.28.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1758200601; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=FkGC7xMtyZHkHFCU8at9IRUS9IWm3LClfP+d5+rXRK8=;
	b=pcGmz+f8AdGlNYbumyyyXwyo9jfry9hSWihyLQclpBQcmjTCTXqdxe6WDnt9qjIeTdPMAKOfPQi2LDKddsqPN7kqy5dXBsnkhcZCNsOUyq5/fjhJ3HX7ZvCLnOwO0SN/VouzkL+e0m4qHo9iAbz5pAj6U3gdMQKdC8e/EPJsG38=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.ei7pEXX_1758200600 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 21:03:20 +0800
Date: Thu, 18 Sep 2025 21:03:20 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Ensure GA log notifier callbacks finish
 running before module unload
Message-ID: <20250918130320.GA119526@k08j02272.eu95sqa>
References: <20250315031048.2374109-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315031048.2374109-1-seanjc@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Mar 14, 2025 at 08:10:48PM -0700, Sean Christopherson wrote:
> Synchronize RCU when unregistering KVM's GA log notifier to ensure all
> in-flight interrupt handlers complete before KVM-the module is unloaded.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/iommu/amd/iommu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b48a72bd7b23..b314523d9194 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -982,6 +982,14 @@ int amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
>  {
>  	iommu_ga_log_notifier = notifier;
>  
> +	/*
> +	 * Ensure all in-flight IRQ handlers run to completion before returning
> +	 * to the caller, e.g. to ensure module code isn't unloaded while it's
> +	 * being executed in the IRQ handler.
> +	 */
> +	if (!notifier)
> +		synchronize_rcu();
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(amd_iommu_register_ga_log_notifier);
> 
> base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 
>
Hi Sean,

Sorry to bother you. I'm reworking the hardware_setup() path in our
internal multi-KVM, but I didn't see any usage of
'amd_iommu_register_ga_log_notifier(NULL)' in the KVM code for now. Has
it not been committed?

Thanks!

