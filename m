Return-Path: <linux-kernel+bounces-853706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 461ECBDC5F8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 084664E5C62
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6671529D289;
	Wed, 15 Oct 2025 03:42:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377CA2D2485
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499764; cv=none; b=mzgzZKEKFZObwUlrjtY2dxVRb1IqWzJZ5LMglWYElGLPvEEGxC3uMK9xwR+p266XIEXGDN6v/NFDt6MqDlEbS7XxEgbFPvq/EkYztFqItWEUdjmvyvjIJarS9pKboUl4/kNNdmLqquh5m0S+iRBy+VABRtUxhK538ShQRVwVMSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499764; c=relaxed/simple;
	bh=mlUZOFWsO6Gw30uOLDJ50mGTqVXsTKxqiPPuV9GSNZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dM3lZL9t+jEtCyLG7gFATHkNKN59dXR9v4uXggX16fY8pk8FKy1Z4rQguTc7RiCWYmunI1SBrfdjVUJoP9IqnxiitNHkXI91bisXUCgFQ4MPACZl0X8PKzs3ZTsWZlqjTb97uH2rfUXOIn7cWAi5Rgpho/pJ7AT1AcWXvJUXLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31CC71A32;
	Tue, 14 Oct 2025 20:42:33 -0700 (PDT)
Received: from [10.164.18.45] (unknown [10.164.18.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F32783F66E;
	Tue, 14 Oct 2025 20:42:37 -0700 (PDT)
Message-ID: <934d3de7-0f46-494a-831f-d04209ea4a8f@arm.com>
Date: Wed, 15 Oct 2025 09:12:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Remove the BOUNCE config option
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-kernel@vger.kernel.org
References: <20251013095620.1111061-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251013095620.1111061-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/10/25 3:26 PM, Huacai Chen wrote:
> Commit eeadd68e2a5f6bfe0bf10 ("block: remove bounce buffering support")
> remove block/bounce.c but left the BOUNCE config option. Now this option
> has no users, so remove it.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  mm/Kconfig | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0e26f4fc8717..e47321051d76 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -695,15 +695,6 @@ config PCP_BATCH_SCALE_MAX
>  config PHYS_ADDR_T_64BIT
>  	def_bool 64BIT
>  
> -config BOUNCE
> -	bool "Enable bounce buffers"
> -	default y
> -	depends on BLOCK && MMU && HIGHMEM
> -	help
> -	  Enable bounce buffers for devices that cannot access the full range of
> -	  memory available to the CPU. Enabled by default when HIGHMEM is
> -	  selected, but you may say n to override this.
> -
>  config MMU_NOTIFIER
>  	bool
>  	select INTERVAL_TREE

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

