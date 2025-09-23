Return-Path: <linux-kernel+bounces-829053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B59B962B9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D6B448160
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23CD214210;
	Tue, 23 Sep 2025 14:16:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA2D1A01BF
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637012; cv=none; b=Zqd3VXoST06uBRM5LbygNRa4e8WeeMbN50r+7wKalBqQLmlqahv6eiWf4SE8Ub4w/lgKPc7bgQ9Z9gG/JXFlWt/fdWaoE/ErfUfQSVCvd+qX9yDvBsjw245X9gC3tQEQ7C+u3cFFNPGkRZKZbAfV6yIIXlj2BqEJxIk+lIoEp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637012; c=relaxed/simple;
	bh=q+nJLvi0Ow0ZIonPo3ESGN1uhM16JTeaSAejTrMZtt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0ThlKliVw0DxX63XHq1XJ8EFSIA+IKV3ckspkgHwjxe1QDrm5fnSgz6hy+REnyWsPT5qrhtL4DkVAbDG3dFHsSHge4H5+/NpDxkQxbt3e0NsJ44UPPVMPJ1+bgD9qii6dUYcs84NI8MvNEe866OVZlgSI6Z6nUcVvxxLcaqjP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65227497;
	Tue, 23 Sep 2025 07:16:41 -0700 (PDT)
Received: from [10.163.43.74] (unknown [10.163.43.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5293F694;
	Tue, 23 Sep 2025 07:16:44 -0700 (PDT)
Message-ID: <ecd6cdc5-7503-4fb4-96f2-1264d46e8fae@arm.com>
Date: Tue, 23 Sep 2025 19:46:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory-failure: not select MEMORY_ISOLATION
To: Xie Yuanbin <xieyuanbin1@huawei.com>, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, akpm@linux-foundation.org, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com
Cc: will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250922143618.48640-1-xieyuanbin1@huawei.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250922143618.48640-1-xieyuanbin1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/09/25 8:06 PM, Xie Yuanbin wrote:
> We added that "select MEMORY_ISOLATION" in commit ee6f509c3274 ("mm:
> factor out memory isolate functions").
> However, in commit add05cecef80 ("mm: soft-offline: don't free target
> page in successful page migration") we remove the need for it,
> where we removed the calls to set_migratetype_isolate() etc.
> 
> What CONFIG_MEMORY_FAILURE soft-offline support wants is migrate_pages()
> support. But that comes with CONFIG_MIGRATION.
> And isolate_folio_to_list() has nothing to do with CONFIG_MEMORY_ISOLATION.
> 
> Therefore, we can remove "select MEMORY_ISOLATION" of MEMORY_FAILURE.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> ---
>  mm/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 034a1662d8c1..0e26f4fc8717 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -742,21 +742,20 @@ config DEFAULT_MMAP_MIN_ADDR
>  	  This value can be changed after boot using the
>  	  /proc/sys/vm/mmap_min_addr tunable.
>  
>  config ARCH_SUPPORTS_MEMORY_FAILURE
>  	bool
>  
>  config MEMORY_FAILURE
>  	depends on MMU
>  	depends on ARCH_SUPPORTS_MEMORY_FAILURE
>  	bool "Enable recovery from hardware memory errors"
> -	select MEMORY_ISOLATION
>  	select RAS
>  	help
>  	  Enables code to recover from some memory failures on systems
>  	  with MCA recovery. This allows a system to continue running
>  	  even when some of its memory has uncorrected errors. This requires
>  	  special hardware support and typically ECC memory.
>  
>  config HWPOISON_INJECT
>  	tristate "HWPoison pages injector"
>  	depends on MEMORY_FAILURE && DEBUG_KERNEL && PROC_FS

MEMORY_FAILURE does not need MEMORY_ISOLATION to be selected
(and built) in order to be built independently.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>


