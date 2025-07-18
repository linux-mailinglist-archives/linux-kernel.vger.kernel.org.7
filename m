Return-Path: <linux-kernel+bounces-736384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E21D1B09C3F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B3C164DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BC213E89;
	Fri, 18 Jul 2025 07:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTcYNVEt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8BE211A28
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823158; cv=none; b=mM/S+ZfOiX1xO5VRiRtFvk+N24rBsm0FSKnyr3AedXhNRSSECo1V+tTeyvJsIPx2dba+oKQeRI3yauhw47CXJANVeuNY+itEY6tam560QXY6snlmVVzeObx1NgPHQW95Tox/tf0TujoTjNqM/9VjM6kgt6oHambJ11Hi2lIJHxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823158; c=relaxed/simple;
	bh=Q4qBNLfdSP5wTM25hg9CJ1KGVy+k2IQXta1aDoPVeRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhaRExR2Fp2eeAuTbyAmqNio4vBatgIaxjbIxIopq/WlPZ//WumIPqakNJn51PhOn/i8+KSGN82U5lHBlcZcELtUV+jRNUsmcTFNsPsZ6NY/b2oirMaXpRtXDT2p0VZVHTqamtAsL5K1P/Abm+Iv67IeyrAimvS4JZqbGpGxjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTcYNVEt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752823154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IUhvR7VOm0WPrltR9SY/XSH6JjtiTjQE95nzmI5fbR4=;
	b=jTcYNVEttRYkzY/xj1SBsoU5wfcA90t5duVx+j7yHNLJSEVgEt0fFimS3mh7RWL9vaPjur
	up07/fhX9UTitk/MemVTh1PFG8z7wG0GRkicSGGBx/oKRc/N7g3ur7QRDvYZEZx9PkBStz
	i+KlyY6aME8RN6e1phP2bA6uS969krI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-byHmF6ZGOE-f7QjnxOBtRA-1; Fri, 18 Jul 2025 03:19:12 -0400
X-MC-Unique: byHmF6ZGOE-f7QjnxOBtRA-1
X-Mimecast-MFC-AGG-ID: byHmF6ZGOE-f7QjnxOBtRA_1752823151
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b5fe97af5fso799996f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752823151; x=1753427951;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IUhvR7VOm0WPrltR9SY/XSH6JjtiTjQE95nzmI5fbR4=;
        b=Nhq+9BdzKw0rJJMWzDbtC6SXalLxjIzva7hN3eRYaCE+ELGMj/sM1zdRRgS3eky+kh
         wupTbEQ4VXpvxQv51PlnFYTf0BEV9egBhec40HkklTd5R+O60XPptGgW+P/qaTR+tIi3
         fVywS9FXZ06vc9t0TTIF4gzAv/GA1C05922uEoxrZJwkOFdE1ZzAiKWTmc1rshvV0Li2
         fRvgMFxtdN2lgXVxfZl0pTnWXopdl2wXeDOmOvTj1d1exrtBpTiSZ3DKx21zIT0T2vHl
         sMS/ksn+k/BDEHEOg0TmzC1+aqmrHU7ETfoZJMDE50twedRoi5O+99QwrFiqkWE1nKAN
         VxjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW8vGHZC4ajkxZEEkACSIYiCDez7k9FbskUIAWQBOrdpBueoOOPcQwWFxMRP66YO1uYSBQ7BLE8j3KWDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjnEzNldbG9DakIvrGBlGhsbcxxphDC3xAsz6ouVLbgAxs4LkX
	9/UixlrZzDo1aGLB+8c7DAf/dDKBbgONenOaperfczk3zN0/VExcC9LXoA6Z9VGsntBZU6p1Afb
	eBRkUOlcV5mVAJED4bBuK6Ob/ouhGBiKmOA1yo+YNRg5+kMvzS5Ib0m50prgQVqhjyw==
X-Gm-Gg: ASbGncvwAtg9Zr2yRZ8s6U7xsEvIb5hvsCx991zmNIP/kP1HHFKU+dnoBpZZrmdCJD7
	7xtPRosPv155Gq2uleNK7fLpHdf2nxda3FzthD7sNGuS6Bis1nMiC0K8Lp72ElvC51owJDhsk3N
	nvjrdoKnGlcf50ZvOE2tO4WvA3D257NNNuseVw9vK+5PxjCe2/UJxOxepD3o/60oNj6LK+C5Zi4
	YPNaz0S9sPqZjlN1HAM/B2QC3dEjpEPoQRFxDvX1dDPdmMAHXpRQAZlsZ55I5tp8YapEIne5zlP
	VIW6tQqnFfldMj3dJTUx1FrKcxwWCr3WcjwmwooKkPW2X5BQ6MzWuiSoDXG4eFeUvx12onEXO7k
	3Kmh94YPZ5wgvBk56JRf0zUXqYrr+xvdB16hdyq3vFsUsTWgng6ewpinbj5YQ2z3xOgY=
X-Received: by 2002:a05:6000:2485:b0:3b5:e2c9:fa05 with SMTP id ffacd0b85a97d-3b60e4d0290mr6272137f8f.18.1752823151327;
        Fri, 18 Jul 2025 00:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVaHQWGhSNDe/SvaSTIIU3JswwI1o5VmpVPWXfPfRYZ43l/Q9U+Bu3DhdqKMwRMYxqDkTb6w==
X-Received: by 2002:a05:6000:2485:b0:3b5:e2c9:fa05 with SMTP id ffacd0b85a97d-3b60e4d0290mr6272108f8f.18.1752823150832;
        Fri, 18 Jul 2025 00:19:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f43:8900:f364:1333:2a67:d49e? (p200300d82f438900f36413332a67d49e.dip0.t-ipconnect.de. [2003:d8:2f43:8900:f364:1333:2a67:d49e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca2dfe0sm1018368f8f.36.2025.07.18.00.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 00:19:10 -0700 (PDT)
Message-ID: <afe785c6-a1c5-4a29-b406-8a39f696efbd@redhat.com>
Date: Fri, 18 Jul 2025 09:19:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
To: Zi Yan <ziy@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Antonio Quartulli <antonio@mandelbit.com>, Hugh Dickins <hughd@google.com>,
 Kirill Shutemov <k.shutemov@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Balbir Singh <balbirs@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, linux-kernel@vger.kernel.org
References: <20250718023000.4044406-1-ziy@nvidia.com>
 <20250718023000.4044406-2-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250718023000.4044406-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.07.25 04:29, Zi Yan wrote:
> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
> splitting unmapped folio operations. Move them out to __folio_split() so
> that __split_unmapped_folio() only handles unmapped folio splits. This
> makes __split_unmapped_folio() reusable.
> 
> Remove the swapcache folio split check code before __split_unmapped_folio()
> call, since it is already checked at the beginning of __folio_split() in
> uniform_split_supported() and non_uniform_split_supported().
> 
> Along with the code move, there are some variable renames:
> 
> 1. release is renamed to new_folio,
> 2. origin_folio is now folio, since __folio_split() has folio pointing to
>     the original folio already.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


