Return-Path: <linux-kernel+bounces-887077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E42C3735A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0129F4EDDE8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628833321CA;
	Wed,  5 Nov 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMtEWUVd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="an49mnF4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354B238D5A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762365070; cv=none; b=Yvj/5YAIMXJkKiEAnltoMdnliiXVXxsMJPqIkYMwFd6ZVvp2j/YtZdcl88XDn8jfxLFYeMlEUh5ADpStwcIBtXY9IQO7uBLf2GdUTu75C/mP8r8RZ3IA65R5PPDXI1ZHuBj8j02fZleaVU5Hv/Y81UDiVL9k+Pr23pJuFSytuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762365070; c=relaxed/simple;
	bh=SwONUGuSY71vfRcaKDOHUIUqyNl2YqXSmOo8uubdyyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuRZqlDOthDU9ukwvojcIdUQHCXBeS1ntAQ5KCSX6iqCTTI5h1mteEQTvWi2t59IXnlvGci9bukqzHyxCoqo4sPawtJ2s5gHbHNZzhvll89UyYaPPwqjL5cCAryeOEgudimUx9FkAk/0l4taEBor1cuFY054NzXhUGX0XXHSi5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMtEWUVd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=an49mnF4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762365065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ISFGpQkJKSZ1BMPwjfpatM1IANu2Zxf0CyPwVpdWe9g=;
	b=IMtEWUVdvUqcUFxE3dTECNzF4EVxg0jlrMXVEUqURsjYoPgtTwjF6gJJzQC1rQrssYbz+z
	3GruAyWJnyzWIiwxd1EDkxd0OB8R5ISZYjFC3vBBLAcCIXjYF9daqdH8dANabiNPQ1pW7c
	Rtqgc7NwKmLEDo4+kF90WbOYNF+VomE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-YWK-g8H6NMC5QAjLL-vW7A-1; Wed, 05 Nov 2025 12:51:04 -0500
X-MC-Unique: YWK-g8H6NMC5QAjLL-vW7A-1
X-Mimecast-MFC-AGG-ID: YWK-g8H6NMC5QAjLL-vW7A_1762365063
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429cd447398so50102f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 09:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762365063; x=1762969863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISFGpQkJKSZ1BMPwjfpatM1IANu2Zxf0CyPwVpdWe9g=;
        b=an49mnF4GEFsJc3l1q8e61XBsvYLyPV8vMhSBIKRnjqUA0flrJlxf9jsyT4ZjPf5U9
         an3UvSe1IZpFySRblvg4ASQVlPbvdJtATxDbQy/uchUNMc1PM8/dPqJ7e28NHFH62Q/I
         Rx3sI/dhfIrPx/DLwbvZJhdQgqBTKeUNvtZugPbOd4UVdYBTg+/c1Oe1z92i5LW8nTrh
         T7vMcuQOWdG4dw4uP9TMozaISw7T3uXGgH3UhBrbs/F3Qig8MbQ9fcqOU5WpPOT+1Abm
         hzfhIK49rTv+/nrldTVXnJ2HzFzbdpxhm7ro5B0PJpESo8EtYA338JMLesdj4CqvsJfm
         771Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762365063; x=1762969863;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ISFGpQkJKSZ1BMPwjfpatM1IANu2Zxf0CyPwVpdWe9g=;
        b=AA4HjpOh4ChLDEaja5XFMMPR4qephEoQRypbc0D7FLaDhQqamS5JTGei7xZxqzf1PY
         uvw+sHyi6v/sJ6g7Pcy0+RWNwZHKTrcV61+eOYwStP9UHN9yUmGFyVb6qmGv6s2yPJ9Y
         rbwPhOrqXKa11fxMcMO6lEKoSnJPmC+m2d2ZDgHUv4Z+uZ5KxRDj47WCKzE/7396v7Gz
         OCJJbsQQydY0+RUXKi02yX3DFpSSVrOmPFrUHeOWoM8t5dzIxcfwpdf9l/qvUeerbKXe
         WaQucPckgKOrydY+bvpx+xL1JISaQR60NXFhsTqPzPHFsmZHd2/1ntX3GaJlY/ceAIBo
         2vzA==
X-Forwarded-Encrypted: i=1; AJvYcCUEHwQJeM1QPYXFcjJyXT2vmVvPiGR2zTvZwCiJn8KVixRR5bCPK8lnCutU4PHd07lC9ECCCzhVb8HOXRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1j4oZR/2mXO5Vh52Ogn39dQQ3swaMO8gKahrqYH8sdBVZQ37j
	cS+48H6yGiqzFodcowkDO0/BvYb2OZVuF6Tiw4YuHN5/qNXrlbe9otd6x26xZCAlZ04UM3lxFL/
	M3rcMLPqQ585RArR9uKvu8yWVHViDd4w/sN81dUjGiAkPoMudx/YyRgS9wshVVoYUEQ==
X-Gm-Gg: ASbGncuetm9yg1JrMwCjjeaOQfdniin4sZgSzv4u06D32DB7MeqQyV470vhRfw2N+gE
	R5zDvlyqErb343iAu17SAeWEkaX4u2GdphcgM5T681GG0dzjhekS5Jjn9bXG6OP6cYKSCxVPWoK
	RSTpru43L0lTI2W7Pfs7U5h5QDTovU6yOXgYrrn+w7aUtomOE74ltTuForrgbq21NDvGxSBuWyz
	kXCT8OnSVPqUAomYKYYx64A+V6uu6uZMIq7RKUNmJtEHQ/xPjHLcgu+MAZdtHNymRrax/ZLe7+z
	rv7kpqENYff09F+ASL4oqshdUfzlI7+dCHN16BBTaks5X04Sx+HZMGWj6HmrTf4j2n+WnL9ZZtf
	SSTctJqSSJNEJvVuvkLoHRbSGbtJRBl/1qLy7LNcddoU1iqjvg7UkJYJWFne0quYwmmvw+NhnuX
	m3pSKSb6b/uyD7QthG8crMtxk=
X-Received: by 2002:a05:6000:22ca:b0:429:c774:dbfc with SMTP id ffacd0b85a97d-429e32c8168mr3732768f8f.12.1762365063484;
        Wed, 05 Nov 2025 09:51:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFewf6v4w5Te5dYAKTDbgxc9eRX6QAlJrRl89/5s4XLBna4xlJJ0Gt+LuAOvKZZlMh4VyOouQ==
X-Received: by 2002:a05:6000:22ca:b0:429:c774:dbfc with SMTP id ffacd0b85a97d-429e32c8168mr3732746f8f.12.1762365063082;
        Wed, 05 Nov 2025 09:51:03 -0800 (PST)
Received: from ?IPV6:2003:d8:2f30:b00:cea9:dee:d607:41d? (p200300d82f300b00cea90deed607041d.dip0.t-ipconnect.de. [2003:d8:2f30:b00:cea9:dee:d607:41d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1fda36sm11649953f8f.40.2025.11.05.09.51.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 09:51:02 -0800 (PST)
Message-ID: <021e8194-14bc-437a-a4ed-5e6abffb9827@redhat.com>
Date: Wed, 5 Nov 2025 18:51:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] Revert "mm/ksm: convert break_ksm() from
 walk_page_range_vma() to folio_walk"
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20251105172756.167009-1-pedrodemargomes@gmail.com>
 <20251105172756.167009-2-pedrodemargomes@gmail.com>
From: David Hildenbrand <dhildenb@redhat.com>
Content-Language: en-US
In-Reply-To: <20251105172756.167009-2-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.11.25 18:27, Pedro Demarchi Gomes wrote:
> This reverts commit e317a8d8b4f600fc7ec9725e26417030ee594f52 and changes
> function break_ksm_pmd_entry() to use folios.
> 
> This reverts break_ksm() to use walk_page_range_vma() instead of
> folio_walk_start().
> Change break_ksm_pmd_entry() to call is_ksm_zero_pte() only if we know
> the folio is present, and also rename variable ret to found.
> This will make it easier to later modify break_ksm() to perform a proper
> range walk.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   mm/ksm.c | 64 ++++++++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 48 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 4f672f4f2140..de10ebcf3509 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -607,6 +607,48 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>   	return atomic_read(&mm->mm_users) == 0;
>   }
>   
> +static int break_ksm_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long next,
> +			struct mm_walk *walk)
> +{
> +	struct folio *folio = NULL;
> +	spinlock_t *ptl;
> +	pte_t *pte;
> +	pte_t ptent;
> +	int found;
> +
> +	pte = pte_offset_map_lock(walk->mm, pmd, addr, &ptl);
> +	if (!pte)
> +		return 0;
> +	ptent = ptep_get(pte);
> +	if (pte_present(ptent)) {
> +		folio = vm_normal_folio(walk->vma, addr, ptent);
> +	} else if (!pte_none(ptent)) {
> +		swp_entry_t entry = pte_to_swp_entry(ptent);
> +
> +		/*
> +		 * As KSM pages remain KSM pages until freed, no need to wait
> +		 * here for migration to end.
> +		 */
> +		if (is_migration_entry(entry))
> +			folio = pfn_swap_entry_folio(entry);
> +	}
> +	/* return 1 if the page is an normal ksm page or KSM-placed zero page */
> +	found = (folio && folio_test_ksm(folio)) || (pte_present(ptent)
> +		&& is_ksm_zero_pte(ptent));

Nit:

found = (folio && folio_test_ksm(folio)) ||
	(pte_present(ptent)&& is_ksm_zero_pte(ptent));

Thanks!

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David


