Return-Path: <linux-kernel+bounces-805774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D9B48D3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BB73BAF3A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BD82FB0B7;
	Mon,  8 Sep 2025 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMMjyn/L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162122ACEF
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333904; cv=none; b=T4/shlWZqZJGDVoDGRXxyiQDFB0IJv1ngva6FJb1+c4kwkTZ8NFrbVtvdz9NtaYSNUg4yoiHRYEWDaogpq1nBJ+wpOWZDnv13qTHbYELiEl/fa2ARCNPVcaWS6oA9D4eLDYKQuLZhgbB0nFIAq+pX5XlPigp1SdZ8vXHRb+EXZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333904; c=relaxed/simple;
	bh=ir/X8xp0/pfFWUlrpjbxTrOu6Qdp3aZWRdcFZwAl+Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rxQe9AgMvxI9Uskp6f6dCeAB8cb1Rcegw98KyaUsw4mrkcFnZNfC4XyZ5dWlQJ+xqlWEm23Nv6ohCmN2IdjnfAbYmmhE2XM1Jgf9v1ue60kQ/Ep97bbqDiCFj2fVwBq/NFyMVLiEigELNkjMfJgc9v+uxShiry9w1/2WVSL4l6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PMMjyn/L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757333901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PuXzt75qqZ88CE8il4yCnMJ+l8oPsUDRiV/gr28llhU=;
	b=PMMjyn/LKzaHClIG2ZuRj9hGAS18uVl6z6Sup0UQEq0KveHGk3Eh6LfpGLtAmr3koVCjz4
	0Wn+M8d2KxWLp+25fI6Ws6TlJqbt1YEQdX9IDIydgxAP1fP6pAqW63UVrOsGIV6lu79Pad
	YUEm9Q/uxTFjPDSebCTwWZ2qiduCIF0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-OEBIUlc8Mw2On4IhR6ek2w-1; Mon, 08 Sep 2025 08:18:20 -0400
X-MC-Unique: OEBIUlc8Mw2On4IhR6ek2w-1
X-Mimecast-MFC-AGG-ID: OEBIUlc8Mw2On4IhR6ek2w_1757333899
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b986a7b8aso28581085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333899; x=1757938699;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PuXzt75qqZ88CE8il4yCnMJ+l8oPsUDRiV/gr28llhU=;
        b=ZKqHBR1VZEbzZS8L4Ugyy74hqSJOc9IiP6EZ+z4vqfBCAUdcg9YivT+k92YSgtduMV
         f+EA73AST5DGW7bjuKbSXs8/kgM6klPV5ZJPDAsBUBbi5A/5E1B5BJMIiPJt5NJw6r27
         cA8kIfVMUVf648DYMSVGJQFXz/MR6c+TcS0Psu2HbFf9jXMgMWxGt020v3NwNzfr3qtg
         soJKXiJVebS7jHZF4NS6bbXW2w+8qEhyELZhlJrOnG/xTK5KfqKeAhOB7fAcLftfxKR8
         5xs0Ar1PaJBYdC2e3XOHd7AKKDgmi+mLvnrhEWsaaaFjdmduUyS5FMkNag/MvjzAFSPr
         cw3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXRiQYvPK2F6j7ajiocV1VIjU4i3boITZETUV6WXyAtFH4ijUSxE5v1bEuBohKv6Ndm7iVQeG72FxIPBlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDxBYP3BeBIzdwDWb/qPd/cL807qZ/w8uhIOC+MJFQ4qz6ybs
	dbCk+rrvigBdfoeoTwcLvVUW8/QUN6FYPqt21b/PlZA5FlqsJkFskfF4WFT2UjWMdJjtWg7FQzf
	WMR2ettXRKS9FhTGJXj/gMWFHYrAhhOFrDtJPzaMut0oo1jUsG+hHCJI91OEpA9eEiQ==
X-Gm-Gg: ASbGncsHZyXFS1cxJ3Z6R7vJdxrGoq6Nh4q/hd2YeDi0WugdnM+gOr6HNVRf3sEKpv6
	SuoCLmVQkX/X0RIlB6oTbFRZ1D4e1lQNZvyfqnrHyg1K/W3Q3QXogSECzv8oAOwcg4QTrNBXV3c
	Kkz+wk/gyeYW5vC36cA7EV1GZnKGVodbtQnNQSkReVArc8SnX+bMozbQ9lgO81Uo/GS/beAk43c
	DTMvyO0+E6bTTuG8D+H/zw9qXFq5Uz+blUGGsTQneEFHUxALKvmEFUyIMtseoCFwPy9YsdcQWs1
	QU0mBoH/cqTR+/1vB+4cCYAbGRItvAynSjMT7O0DN2ihTKepir2E7OQY+zuLDdMEzXSxNyKBe/a
	DBusJeYLscqkNnWPjWXUCWQe7cHVoRN6MOvjNMRRDnLJOMh1RMvDu3aJNef7SbSeb
X-Received: by 2002:a05:6000:1449:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e64392b8c4mr7476360f8f.40.1757333899328;
        Mon, 08 Sep 2025 05:18:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+yeVQRYSd8nkCUCllIs0DiL5pm4cULTomNXgzijKtbB7fyh7LoqFBush3PDSaV4UKlqAXEA==
X-Received: by 2002:a05:6000:1449:b0:3e4:ea11:f7df with SMTP id ffacd0b85a97d-3e64392b8c4mr7476311f8f.40.1757333898904;
        Mon, 08 Sep 2025 05:18:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de24ab648sm74672245e9.5.2025.09.08.05.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 05:18:18 -0700 (PDT)
Message-ID: <0bbda135-068a-45bd-afd6-3f5cdf4e570d@redhat.com>
Date: Mon, 8 Sep 2025 14:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] mm, swap: always lock and check the swap cache
 folio before use
To: Kairui Song <kasong@tencent.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
 Chris Li <chrisl@kernel.org>, Barry Song <baohua@kernel.org>,
 Baoquan He <bhe@redhat.com>, Nhat Pham <nphamcs@gmail.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org
References: <20250905191357.78298-1-ryncsn@gmail.com>
 <20250905191357.78298-6-ryncsn@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250905191357.78298-6-ryncsn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>   
>   		folio_lock(folio);
> +		if (!folio_matches_swap_entry(folio, entry)) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			continue;
> +		}
> +

I wonder if we should put that into unuse_pte() instead. It checks for 
other types of races (like the page table entry getting modified) already.

-- 
Cheers

David / dhildenb


