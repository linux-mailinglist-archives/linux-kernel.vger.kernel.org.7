Return-Path: <linux-kernel+bounces-878565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71271C2103F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84983427E35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F69E2253FF;
	Thu, 30 Oct 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xt73OxI+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352B01D416E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839157; cv=none; b=ogn2Gx2W2ZK1ad6aoc8osfTkg0WGyXKLTJ/27r8wsWukEtR2QokflOtc1xDV+pIlCTNF9anLydZf1mnncKonDg3Alh14oFmk1vxCBh+xpJ5HdExZvwRySV3OjWXgLJTJiEI/5z54G6ooyXxmgPkvGOhZNCQJj8HibfvoHQduGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839157; c=relaxed/simple;
	bh=bTnJj9/u9HbjQIPERYKZPQzCYlY07yc9541XDGI+R0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SEon7rz0Yu386pG4a4k3bUavLdoSKylLrIYD6nRfLVI27VxWKo5yiUny4mQz5bmVAlYJI4tW71fogBrfI9qV0NM+6JFApUn/racjV7eHdN1J4DU/+K8g8tEV4ML0NHNuc23C2sPZyXo6obYa4GHcNWxjdLAJDS66B1yrAmIcEX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xt73OxI+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761839155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T13UVO1/yPlQk6T2PfurpgHZxHJlbT6OmTkCB8QWscE=;
	b=Xt73OxI+zOxx2rjbyPNKl2epf+sKs+DwLjmYCYYAo6FS9nNu/96Zyns9ZWmqPyauBVAKvq
	0/WlVyYxGgn6kStlvFLoQ/SCjgllqzJ+Mp7VBaPJyhgG3b04a77EKbDSch25VVy8aLGaH6
	gLDDw+P9nRcPL5Bzs7YBvF+f28tkbhI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-xqOMh70tMgC_HaSwVC1WTw-1; Thu, 30 Oct 2025 11:45:51 -0400
X-MC-Unique: xqOMh70tMgC_HaSwVC1WTw-1
X-Mimecast-MFC-AGG-ID: xqOMh70tMgC_HaSwVC1WTw_1761839151
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-89ee646359cso333957785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839151; x=1762443951;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T13UVO1/yPlQk6T2PfurpgHZxHJlbT6OmTkCB8QWscE=;
        b=dpmKcsuPIYvNZfICG/3SltQ4AVKb+Swa7koJ6OKEZ5PNBQjYEGXMKIwecamQQe5XWI
         amoHeI+J61h+leCHmFrQmz2Gc00aSTPSMJOmiU+ROfjZxwwSLrrDwimA6Xy0XsfjphMh
         PpZBgyCDRA+XalTuH8uuXUedYQxgY0ObdnmHvY0HK8meFKVqXvnCguQNtAfH4n/DIKmj
         faC3ebaOpM7QghjPTOtOusMJ7dLyX59GEZ+Nk7ibarbvKPHAml39KPX+SS2GWT1BOU29
         HTafq+vPe0QC719Svdc3A6xudTElSENxkW8WMAJoK8X7EUhUYqYNHcMb/2XxbVQZtLmN
         PFGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtf/Gsr1S2OJiNZwR1jcPbhHIl8EmCb1PoyQALrPdGmAdHsL29B+Dj7TcFP/UA1TCQhQptcQzSsCZk/dY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1iS/nZ8IhMZa4PQ9UBCnZwmPtaCIoIJ++OKeoEWalO00tXFiK
	kMMkS1AZw0CGCCONUy7z+MGzXFTf41heGry3kP7DhT9KHbJzlyw6ZGVsUssWW02ao+/yxFNlHNx
	LGgsw3BdRxkbQIiHT55Zdi4JaBBOqDRo8h1j+9mBYSeQLyMJCtxaiZv60Y6O83YP36w==
X-Gm-Gg: ASbGncvUbUMN/CxRESnGoVDcww5XdUexG4jmFXmaoqtQFQxvZneub3/Fpu0mEltrihL
	lQwwTk7eKyTUpQlx6RkGXJTuVUzr/JLc3g/v/3aoJ2N4fvGhGGXVx1DYwQO3ZeS/PtgtBsFLSpG
	CUrS/y9SGCZWfxfIqoN+cIiolOFxuhxUjFmCNii5uwvWi+cSKYPq3hAZl55KhTeJYJ02e3RJ/Eo
	7aahpvXaRdmiZ05ZyPqqcZIcPYSIiyuRArT4OqXTc6S7vrY0ktrtCd/XY29xb9MOJGJxfmi+315
	eTlWXKY0sRKZKPVV1w5yEGZkW4HDlhYwp73xixm2ilTqE1XdmH3lltDjanAeHO+q+uel7Z+P9+d
	Gyg==
X-Received: by 2002:a05:620a:2a07:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8aa2c659146mr496986085a.25.1761839151204;
        Thu, 30 Oct 2025 08:45:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOqRO+7KOnHpcS7rPlmfWuNX0n6FxKFT+Lt8fIFSIFDsOADI0AQRhPYfD/wI22ZJMDrMWM8w==
X-Received: by 2002:a05:620a:2a07:b0:8a3:e51d:63c9 with SMTP id af79cd13be357-8aa2c659146mr496980385a.25.1761839150640;
        Thu, 30 Oct 2025 08:45:50 -0700 (PDT)
Received: from [192.168.2.110] ([70.49.125.126])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f2421fba6sm1289506585a.4.2025.10.30.08.45.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 08:45:50 -0700 (PDT)
Message-ID: <d491b540-8984-4ffa-9a79-ad6855e9c883@redhat.com>
Date: Thu, 30 Oct 2025 11:45:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
To: Heiko Carstens <hca@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Joao Martins <joao.m.martins@oracle.com>,
 David Hildenbrand <david@redhat.com>, osalvador@suse.de,
 aneesh.kumar@kernel.org, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20251030145505.2764038-1-hca@linux.ibm.com>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20251030145505.2764038-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-30 10:55, Heiko Carstens wrote:
> As reported by Luiz Capitulino enabling HVO on s390 leads to reproducible
> crashes. The problem is that kernel page tables are modified without
> flushing corresponding TLB entries.
> 
> Even if it looks like the empty flush_tlb_all() implementation on s390 is
> the problem, it is actually a different problem: on s390 it is not allowed
> to replace an active/valid page table entry with another valid page table
> entry without the detour over an invalid entry. A direct replacement may
> lead to random crashes and/or data corruption.
> 
> In order to invalidate an entry special instructions have to be used
> (e.g. ipte or idte). Alternatively there are also special instructions
> available which allow to replace a valid entry with a different valid
> entry (e.g. crdte or cspg).
> 
> Given that the HVO code currently does not provide the hooks to allow for
> an implementation which is compliant with the s390 architecture
> requirements, disable ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP again, which is
> basically a revert of the original patch which enabled it.
> 
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20251028153930.37107-1-luizcap@redhat.com/
> Fixes: 00a34d5a99c0 ("s390: select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Obvious enough change, but FWIW:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   arch/s390/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index c4145672ca34..df22b10d9141 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -158,7 +158,6 @@ config S390
>   	select ARCH_WANT_IRQS_OFF_ACTIVATE_MM
>   	select ARCH_WANT_KERNEL_PMD_MKWRITE
>   	select ARCH_WANT_LD_ORPHAN_WARN
> -	select ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP
>   	select ARCH_WANTS_THP_SWAP
>   	select BUILDTIME_TABLE_SORT
>   	select CLONE_BACKWARDS2


