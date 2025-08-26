Return-Path: <linux-kernel+bounces-786156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5083EB355BD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C231686C04
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 07:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020D42F6594;
	Tue, 26 Aug 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwxPwsCu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7782874F7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193821; cv=none; b=O8MNkAk8I0VmnDO/oLZkSNsDktwPcSvkJYFIJjcrpoS4AKAmOhmqrg9w+AaqBBdAFxKfgc7cOD7/43vTWNco2HXUbnprvtn5G4z6dAQUpRr0ajd+0jUNnlTdl3bQoUKDDTl6MJog4DMexjL3ENUDhJNJjPAolj3916PGiJBLsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193821; c=relaxed/simple;
	bh=CmdXdOVkVWdsax2q8zskOqRRI1SaOPVcdJHfJE4kSBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOAmy+88YecOfbfLwiiWSR8NE54DAMN3HRCJg12QyDOapgdMBhhnPWGPeVlFt+jfxb0VOyvK8nK82HCqjujwIrMOZlhoS+eaBPGuSXfj6ERrRXxVvzV1mhxmh2ZA+vC6uvk5YfKyoBD07EFfuvaD2Z0HPR6ZhWjJ/LVy3w7ivEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwxPwsCu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756193818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/DqKcew5Rz/o9MXbzchAR4oz9Jo4JF0aUKr1yU928n0=;
	b=BwxPwsCuJqf6ROoCRjlkrHW9dnAsgXXzdlY7vIGS5khyhgpwVyFo8TD7v4uYeaJuuu9TjY
	fmymruqbWD64mbPcZmBt7pnfV6q9Yh3bfxhNCfnYPbArfjRJG1MiCGbxpMDgb65wjIZnci
	L2vmYupIWH3BZhpM0LB2xupYFXRIZ9E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-G80itf4-MMmEjqctSWU6Og-1; Tue, 26 Aug 2025 03:36:56 -0400
X-MC-Unique: G80itf4-MMmEjqctSWU6Og-1
X-Mimecast-MFC-AGG-ID: G80itf4-MMmEjqctSWU6Og_1756193815
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3c75de76cacso2050058f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193815; x=1756798615;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DqKcew5Rz/o9MXbzchAR4oz9Jo4JF0aUKr1yU928n0=;
        b=Da3Jl1prPoAJnkVEAHvRkfvKZUc1ufYN5C8qvMBAB4DHXgDFEbH0j4LrjSUjFtx5dN
         YHimCk2wV+tn4QlahDAskFLI1udH/4srTZZNPZZS4gujdWddrpJRhwP40Ll39VkI3tCl
         9bPoFuKF6zOke83BEayXCz0dmrJrnyHZyO6RSoKSmd2nmd51uotiaaV3imiwTLA2lfQl
         QgC6LAOJrXXoIzp/M7x4c+rNy+wU07JiuAkeTv0twZlSTZag4CeFmBmaNAm3V5PsmmEf
         M3cdUN9OnZ89J3jDxshH/1PuqQ+UPQGYXaI0vCWkKpxoyFzHzi77eLgfimUX20e5yFPT
         8tWA==
X-Forwarded-Encrypted: i=1; AJvYcCXV1oOFG4Dn7zvTN68XGzCmVdU4M0krewIB7saaGPDzcJISGdtDlRZE17lsjapyOCz14ziu1aI89S4rkc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV1UhTSXwb6Mrxsi2pbNBaKc1/2XihgKE0wB9D9RH7qonmcULZ
	S1MWTCGJh/sLq3b3ta1UPyVoPkSDTeHInh9GuxHzQkv7CiCrQA0qRXmCiKFrDNrDb9aLO4XsXZa
	187TdmEJB/ClOY38q42mYF5nmmjFqIySvtkv32SiPcXaw1mRI6BCKk0jvAeVEcZnyETOfk1q+YB
	gy
X-Gm-Gg: ASbGncuwdeZNJ0ssx3n/i4rlqqnLva1ex358junIltBOQGrhy4w00QmtNdc2jt4DJ6i
	sAeSgd7Z/nkWKWeEymu+XMsMljNSmLtP1eCHlm+Pzmb0wpT3NCdniBtkw4LtHimaPqq9dU0y6n8
	+Wslyu2rVNOg/fvS2+TttzI0rwF0HKCQlEeXapEJgQbO6W128o2nNwH1l7cDLt/hyH+X8o8wQIP
	HMSQmgA7zA0ktRuh0QcwVOb8G0Ax4K+L9Jp7K8QL0yQiJGCdC2fpirfu8F3vkBgWLO2SlWfSuT+
	5sJi2ySW8cgb8Ch3UBfROwovFggflgExT+BisqbvwG9rYUXq9I/1ElxXqF3fOY+Sdf57j3dtHA=
	=
X-Received: by 2002:a05:6000:4211:b0:3c7:95cb:baae with SMTP id ffacd0b85a97d-3c795cbc786mr7756339f8f.36.1756193814705;
        Tue, 26 Aug 2025 00:36:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsBN52r2cwxKT8YU6u0g1yU35TW6zYizCEwIpjz1zfPH23ZIMqoMpz6jBaY5R0HVd+02BGDQ==
X-Received: by 2002:a05:6000:4211:b0:3c7:95cb:baae with SMTP id ffacd0b85a97d-3c795cbc786mr7756316f8f.36.1756193814278;
        Tue, 26 Aug 2025 00:36:54 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba41bsm15565515f8f.10.2025.08.26.00.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 00:36:53 -0700 (PDT)
Message-ID: <2ff628c7-dc0b-4af9-98e2-8abf6d0708bb@redhat.com>
Date: Tue, 26 Aug 2025 09:36:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memblock: fix kernel-doc for MEMBLOCK_RSRV_NOINIT
To: Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
References: <20250826071947.1949725-1-rppt@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250826071947.1949725-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.08.25 09:19, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> The kernel-doc description of MEMBLOCK_RSRV_NOINIT and
> memblock_reserved_mark_noinit() do not accurately describe their
> functionality.
> 
> Expand their kernel doc to make it clear that the user of
> MEMBLOCK_RSRV_NOINIT is responsible to properly initialize the struct pages
> for such regions and add more details about effects of using this flag.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   include/linux/memblock.h |  5 +++--
>   mm/memblock.c            | 15 +++++++++++----
>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index b96746376e17..fcda8481de9a 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -40,8 +40,9 @@ extern unsigned long long max_possible_pfn;
>    * via a driver, and never indicated in the firmware-provided memory map as
>    * system RAM. This corresponds to IORESOURCE_SYSRAM_DRIVER_MANAGED in the
>    * kernel resource tree.
> - * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are
> - * not initialized (only for reserved regions).
> + * @MEMBLOCK_RSRV_NOINIT: reserved memory region for which struct pages are not
> + * fully initialized. Users of this flag are responsible to properly initialize
> + * struct pages of this region
>    * @MEMBLOCK_RSRV_KERN: memory region that is reserved for kernel use,
>    * either explictitly with memblock_reserve_kern() or via memblock
>    * allocation APIs. All memblock allocations set this flag.
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 154f1d73b61f..46b411fb3630 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1091,13 +1091,20 @@ int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
>   
>   /**
>    * memblock_reserved_mark_noinit - Mark a reserved memory region with flag
> - * MEMBLOCK_RSRV_NOINIT which results in the struct pages not being initialized
> - * for this region.
> + * MEMBLOCK_RSRV_NOINIT
> + *
>    * @base: the base phys addr of the region
>    * @size: the size of the region
>    *
> - * struct pages will not be initialized for reserved memory regions marked with
> - * %MEMBLOCK_RSRV_NOINIT.
> + * The struct pages for the reserved regions marked %MEMBLOCK_RSRV_NOINIT will
> + * not be fully initialized to allow the caller optimize their initialization.
> + *
> + * When %CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, setting this flag
> + * completely bypasses the initialization of struct pages for such region.
> + *
> + * When %CONFIG_DEFERRED_STRUCT_PAGE_INIT is disabled, struct pages in this
> + * region will be initialized with default values but won't be marked as
> + * reserved.
>    *
>    * Return: 0 on success, -errno on failure.
>    */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


