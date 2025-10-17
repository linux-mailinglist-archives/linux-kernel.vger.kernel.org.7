Return-Path: <linux-kernel+bounces-858335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C90BEA3CF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76110585EB5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A4330B27;
	Fri, 17 Oct 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ose9EbSA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE05330B06
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715882; cv=none; b=tV0KO8KKhXXR4g46WU03FuMSetV60xhsZwmsBcwVGogHR59PQ1XQsPOCFcfNcHZtBn/CHt26qEBA/dWqtdo+cAJHNoOcXKJ6pNGItanigGDzYNkOjlPJ8F1O9Wys5N8uDZwFdnN3dgp3bB6vl7YOQ06dzg1qOPPmEOl2trSRlJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715882; c=relaxed/simple;
	bh=bGtbCnbiNYfu/OBFIkZWRYaRZr6OHjnynr2Y3yqci5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnuSVeodC/xfPlnsJQxb7C1zQTQ9otSECPtSw+cdG9oo6DeRr2zBbYE1OfyoJ7depeV/02rycCjHgC3ZQG5SZA+Z6REZQC16Uhlfrxnp2Ifnd9XzNWYFHsZ+XVhcBuPjsalA8P61LBKcvgT3Xs0w1nejHUnl5PmxeNkXqvw9sB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ose9EbSA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760715879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BVJziZzaH8Jv89B+615n1DyHlPylee7tmV2DtP3EtTE=;
	b=Ose9EbSAGA6Pm+j7K4gVMuE84M+vObpEvXrEcOOkF1ZqJBFZYRrVPEuQBpi939UL0E/Mdo
	4SWTkuU4fJ0HFf2y1q8X1a9ESIuD2lF3lLxQnWRR6TFe2LuSZSjbrvfBrvi/9ZQIWIKgbB
	5O83yDCJv2oIjRiNhv0OSOwpSaawLxo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-b2Fy_nzpN8ah3yMMBfnzVA-1; Fri, 17 Oct 2025 11:44:36 -0400
X-MC-Unique: b2Fy_nzpN8ah3yMMBfnzVA-1
X-Mimecast-MFC-AGG-ID: b2Fy_nzpN8ah3yMMBfnzVA_1760715875
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-471144baa7eso11746205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760715875; x=1761320675;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVJziZzaH8Jv89B+615n1DyHlPylee7tmV2DtP3EtTE=;
        b=NIauFFjww4nxBmYFwwrAtrFU5/Lqp/+dPA9xgV+gZ/hkRqkeNE73rvQjG2l9qXMKgT
         30jgpOxUjUWj2vGElfbxbfQ3XphODa3iq0dXNJXfXx2HNVLkmgmplBt4CTDCcaA3VlUO
         XR/uKjosBdZEHApAqhW48LbXfY8SKnTVoVBnoHIAGRNfTmBu+OwMYZrdfwcoQmALkYMb
         Mlhzc+0yIPE/geY2Xudu517r/WIRSduYcOL7wmZokKAWSS5Rngm0JZ//sHr6lMoSBsUa
         ts2FGYT2M1yoGuZo0t5GDlUhkSFLO+YuUj2/0wCV5f2uiu83HKEYYg5ts/lY83miBvCb
         UAxA==
X-Forwarded-Encrypted: i=1; AJvYcCV2BQeqW3pPxWRL9gLXDrbP8osQT658BDFhdOKYnUVUKLjlTajr4rQhIQkYywE6yyOA15fEk0kO9obyjVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZiPVcg1g9HpTmNve3WYU+zeNVxcx2O2sK8FJcOTKJhOJqen0
	IUu7hz6I3URh6jhhfM2Pn7Cp4cQt2AMEz08OL5xLpa9J32bu7dEnCm+EvL7F6XBQMNQUc06N7Jv
	+O3Ca1ggDlCtQ7CF+T2od3KLpteDRDiaCoXPI2wr0ZIBKXexdiKVVGF8H7z4wfDSJCQ==
X-Gm-Gg: ASbGncu15W1n8Q18iv1QUtYZE/KOj75UkQHlw31lx/19P5H4qJs5WakwfwSa6AKUJsr
	qoXHZ//XAQI2KmTxRwiStto80bT7yauvKV/D0LbFdByOg5fXzNWVKShSVDhe8Ha1DkYoNOd121G
	y+d4q951QRFa+JhONDT7JPwNV+GOKXEtj2vKF/4eB5wgNul7cutBCZwkO13fWTYobQmKYmwiP32
	EL1IVpu97goWvvBaeTqUeK4aEZEYyVnOoMZFdwRdMLRVnChcv3hmCf10CmAwA0ZyuJn6N5QcjXJ
	ERQFDdsa0IqiX+6A+ac6FG5JXZ/HK1J4+qi5AXmE4Sxqg2le9JbmzenDzYNlog8jwJrtL1dEHJ4
	aX3IqyWdNAryQbl/Y7FFlp5pHGXTNg6ZNFCR8UwG2SJdLJnjTxlreVqwCXgWh0vK4Cqy2TyN5/J
	kDL6l4Zicl4Q//MqKCM3z4DZAFeE8=
X-Received: by 2002:a05:600c:3e07:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-47117872663mr35610855e9.8.1760715874966;
        Fri, 17 Oct 2025 08:44:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWDJkKYZFsSRK7pMNDsTpLGIPelR6vKhzx3DtGXCZ7HvQlAugOuQJ9QMdp4RVSWaVNvGYxXA==
X-Received: by 2002:a05:600c:3e07:b0:46f:b32e:5292 with SMTP id 5b1f17b1804b1-47117872663mr35610695e9.8.1760715874606;
        Fri, 17 Oct 2025 08:44:34 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4715257d90bsm1082715e9.2.2025.10.17.08.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 08:44:34 -0700 (PDT)
Message-ID: <05d7832e-7bbc-4c73-b293-f512b4776aeb@redhat.com>
Date: Fri, 17 Oct 2025 17:44:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, craftfever <craftfever@airmail.cc>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251016012236.4189-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.10.25 03:22, Pedro Demarchi Gomes wrote:
> Currently, scan_get_next_rmap_item() walks every page address in a VMA
> to locate mergeable pages. This becomes highly inefficient when scanning
> large virtual memory areas that contain mostly unmapped regions.
> 
> This patch replaces the per-address lookup with a range walk using
> walk_page_range(). The range walker allows KSM to skip over entire
> unmapped holes in a VMA, avoiding unnecessary lookups.
> This problem was previously discussed in [1].
> 
> [1] https://lore.kernel.org/linux-mm/423de7a3-1c62-4e72-8e79-19a6413e420c@redhat.com/
> 
> ---
> 
> v3:
>    - Treat THPs in ksm_pmd_entry
>    - Update ksm_scan.address outside walk_page_range
>    - Change goto to while loop
> 
> v2: https://lore.kernel.org/all/20251014151126.87589-1-pedrodemargomes@gmail.com/
>    - Use pmd_entry to walk page range
>    - Use cond_resched inside pmd_entry()
>    - walk_page_range returns page+folio
> 
> v1: https://lore.kernel.org/all/20251014055828.124522-1-pedrodemargomes@gmail.com/
> 
> Reported-by: craftfever <craftfever@airmail.cc>
> Closes: https://lkml.kernel.org/r/020cf8de6e773bb78ba7614ef250129f11a63781@murena.io
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---

This patch will need some more work.

@Andrew, please drop it for now.

-- 
Cheers

David / dhildenb


