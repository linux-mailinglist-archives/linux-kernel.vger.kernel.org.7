Return-Path: <linux-kernel+bounces-749494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5AEB14F12
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C838A7A1CFB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FC51D5141;
	Tue, 29 Jul 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmU3SvO5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313854C6D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753798300; cv=none; b=BlstVPYEH60sqov+zbZLky9VyR/i1sX54VxU+dA62d8laEz1OPslvw19ayNebFccXxrBXBwGLjbZOWrT1BUZlCbUG3fHF5VnQUXErBleGvng+uZ+q0UWOfoSqoEKEdRLZ+QUVN129+hyGBSTDh2XJoP8XKHmUasT+SWLleesytA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753798300; c=relaxed/simple;
	bh=Okx9/ZRNuBrHKqJcoVM3t4DqefOZDV9kjoSf1LmlvjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pb704NuqCesX5/moxn0Gh8IaZRs7zWGH/Bx+o9Gwrabe5Ix8uJ3j6ktGXoF/ls2iyzTa0knK4treCGQ0UR0Wl3F5pWMD2aG/flVf6xPD8cpmnph4kSyawKEFUgHNs3BCqwlhfK4axGougfXG3If61IYh83yZ1CE9EoaB9B6PEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmU3SvO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753798298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S1ElpNfWetAncubBW4nULK43vxREFUQ5PC14/2hrshU=;
	b=JmU3SvO5DjLynfw6Dj/otMlYlkwV2EjggTnJf9BrykN+auDet0WHpTgmpVusymNvS115z+
	gmTWqvPsb2mBONQBI5vxPEOEdatzU2jWizH/mDFJLd1iwB+EJvUetVNtV9A6ZofjzcoFTR
	kdc5e7LqaGrkmabZ8Fgi4EL+dKgJVoQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-wFTlWwQ4Ml-RoN7t6HNrCQ-1; Tue, 29 Jul 2025 10:11:36 -0400
X-MC-Unique: wFTlWwQ4Ml-RoN7t6HNrCQ-1
X-Mimecast-MFC-AGG-ID: wFTlWwQ4Ml-RoN7t6HNrCQ_1753798295
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b782c29be3so2158874f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753798295; x=1754403095;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S1ElpNfWetAncubBW4nULK43vxREFUQ5PC14/2hrshU=;
        b=p82mGFrzkJdAuLZIEWCpAfXW2zVMm8V+4hzT5iGQJhwzMv8iQbFblR0vY71pKm8H6M
         kPEY5HIr3CdTCt9nG9dmmYrbuT/d2YxNgRDktPRpxXwQi+fvD0Rxw5wPI17MRNxGlMVw
         h7caZWa0gZ4YEffydZdxSpf3OJIyq7u2qVSO61Bo1xqBreuxJPTrBwKnCFa0otcEmFhZ
         9kQZwqVtn6nEaGR0pseeS/ECROJd9/luXjxYG0c4sxkcEHgQE9hOM+42+LdYOHLkrLJS
         nlG10lRdk7YyLby+8+WOgbh8zOofS6O9HDPM5u48RUa9/FzgghLRGOKAOejDlQB/gqsi
         dvAA==
X-Forwarded-Encrypted: i=1; AJvYcCVB8BGcqwLLnT0R0inVSjfnCNYehiTtiPS6z379NwK3SmI35JsvGM3LCJYp/VTM6l7mCazEeE1BOU9HU4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQpYffp+7Cz1ciHFsfOotiYQ/BjO4YWWglmvzCaLQ1cM602ioT
	icVOm5EffElaQZ2HppNP+6EbFgL+Glmj2ScZ9AifFcZ1eMvMI2pUCRgs6qmBy603AtPYVe4i8Sm
	y52Ho6w3W52gz2pCKhnjlj4FiPOhs3jpa7JVSPxF2/gnNraJ23kM1vYpSEvazvqUHgw==
X-Gm-Gg: ASbGncv+fahL3SracdPBXfTWfrfoqQp1xY35kMNfH7GJIIIMPAVkmccyI/l5WfIBoB8
	HXGsFq+hMMHeYoQ79sTbwTH0eBk/fVhlOSxGLiOiutLxOpgffwW3Pj2fCfV3ukT2DF52NrKXvd+
	+ns14CykL00uawNeGLZJvrpmzKVFmAjAqZNEodnlrPkLha4EjD1l1s6bwB0i2pu+V0HwxKV9kpP
	IpMlHPRRc4InV1mhsGNQtOIkx7obKh5yrNdrfVE9G34kSs8psEQ5jMfmYuB3mlbKd97C2fwE8AX
	//mM4twpoM1WCZAucbdqTzvw3MIxa5mE4ss0EeEQ6rMTbZXvKR2KVRXvO3F8oPVLJLTLYrpO
X-Received: by 2002:a5d:64c3:0:b0:3a5:298a:3207 with SMTP id ffacd0b85a97d-3b77678d462mr11705408f8f.48.1753798295089;
        Tue, 29 Jul 2025 07:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErQBVNkKK40UX2bTpHjNrd42cFNcADA06bXXRBd040/9oIvyVblwFNee5lBXdHixIuozTVFg==
X-Received: by 2002:a5d:64c3:0:b0:3a5:298a:3207 with SMTP id ffacd0b85a97d-3b77678d462mr11705387f8f.48.1753798294683;
        Tue, 29 Jul 2025 07:11:34 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f0c866sm12128869f8f.55.2025.07.29.07.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 07:11:33 -0700 (PDT)
Message-ID: <0cb3d5a5-683b-4dba-90a8-b45ab83eec53@redhat.com>
Date: Tue, 29 Jul 2025 16:11:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] mm/damon: Add damos_stat support for vaddr
To: Yueyang Pan <pyyjason@gmail.com>, SeongJae Park <sj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Usama Arif <usamaarif642@gmail.com>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1753794408.git.pyyjason@gmail.com>
 <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <44a30f700fdcf4470318ef5cd248ba98c59b77a2.1753794408.git.pyyjason@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.25 15:53, Yueyang Pan wrote:
> From: PanJason <pyyjason@gmail.com>
> 
> This patch adds support for damos_stat in virtual address space.
> It leverages the walk_page_range to walk the page table and gets
> the folio from page table. The last folio scanned is stored in
> damos->last_applied to prevent double counting.
> ---
>   mm/damon/vaddr.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 87e825349bdf..3e319b51cfd4 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -890,6 +890,117 @@ static unsigned long damos_va_migrate(struct damon_target *target,
>   	return applied * PAGE_SIZE;
>   }
>   
> +struct damos_va_stat_private {
> +	struct damos *scheme;
> +	unsigned long *sz_filter_passed;
> +};
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static int damos_va_stat_pmd_entry(pmd_t *pmd, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	struct damos_va_stat_private *priv = walk->private;
> +	struct damos *s = priv->scheme;
> +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> +	struct folio *folio;
> +	spinlock_t *ptl;
> +	pmd_t pmde;
> +
> +	ptl = pmd_lock(walk->mm, pmd);
> +	pmde = pmdp_get(pmd);
> +
> +	if (!pmd_present(pmde) || !pmd_trans_huge(pmde))
> +		goto unlock;
> +
> +	/* Tell page walk code to not split the PMD */
> +	walk->action = ACTION_CONTINUE;
> +
> +	folio = damon_get_folio(pmd_pfn(pmde));
> +	if (!folio)
> +		goto unlock;
> +
> +	if (damon_invalid_damos_folio(folio, s))
> +		goto update_last_applied;
> +
> +	if (!damos_va_filter_out(s, folio, walk->vma, addr, NULL, pmd)){
> +		*sz_filter_passed += folio_size(folio);

See my comment below regarding vm_normal_page and folio references.

But this split into two handlers is fairly odd. Usually we only have a 
pmd_entry callback (see madvise_cold_or_pageout_pte_range as an 
example), and handle !CONFIG_TRANSPARENT_HUGEPAGE in there.

Then, there is also no need to mess with ACTION_CONTINUE

> +	}
> +
> +	folio_put(folio);
> +update_last_applied:
> +	s->last_applied = folio;
> +unlock:
> +	spin_unlock(ptl);
> +	return 0;
> +}
> +#else
> +#define damon_va_stat_pmd_entry NULL
> +#endif
> +
> +static int damos_va_stat_pte_entry(pte_t *pte, unsigned long addr,
> +		unsigned long next, struct mm_walk *walk)
> +{
> +	struct damos_va_stat_private *priv = walk->private;
> +	struct damos *s = priv->scheme;
> +	unsigned long *sz_filter_passed = priv->sz_filter_passed;
> +	struct folio *folio;
> +	pte_t ptent;
> +
> +	ptent = ptep_get(pte);
> +	if (pte_none(ptent) || !pte_present(ptent))
> +		return 0;
> +
> +	folio = damon_get_folio(pte_pfn(ptent));
> +	if (!folio)
> +		return 0;

We have vm_normal_folio() and friends for a reason -- so you don't have 
to do pte_pfn() manually.

... and now I am confused. We are holding the PTL, so why would you have 
to grab+put a folio reference here *at all*.

-- 
Cheers,

David / dhildenb


