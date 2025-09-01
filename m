Return-Path: <linux-kernel+bounces-794072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA63B3DC69
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899703BFBE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134E22F83D8;
	Mon,  1 Sep 2025 08:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHtWIOAa"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAFF2F8BDA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756715561; cv=none; b=cXyiS1LcPvnxZ49m0aEHpsLDDRRH7MfUtH5nSpUmc/jxw/LqbgiAQYYBxXLzEM1jc4Dn4gPeIiK3Jdk2XGqKaJV7e+wR8gxPARl7yJuZ1x69yVp0tVZhTmSff1TjTfmzkKKZZ6t6L/GKPnrx3jSkRSNSlHH9GSRcaNcIWhXEblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756715561; c=relaxed/simple;
	bh=eGhJLv3JHxJOYRP+mQRzqV6XCB0hOdyNlVYUQfLbwl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7tIcz6SfEDNgPYFNp1bKNz6PMBLK3vjDxeT4DufqJ6B57Wdd5rep822ZB20aVA0U32uUtTaPiQTRVN06hHua9rxZ99jsngw4MZCK1iOaO8fW7CaXv5OIz0KByAS9/siONey3X9/QYoCMJo5LhNa02ZN2RtwQVa7n78s65CM/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHtWIOAa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756715558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FO75zWx7qwUC6w5oKfEBr0b/vUP3SN++OhAvNFPRXVg=;
	b=hHtWIOAaUpyaIUiTaS96MJ6JfJuIRjum1YHhyneoKTsBu9ZmPJ1BWC0fhqI2wBMELKIa3A
	3ktavFf8K0dQk3oLv3zdyygCFUOjb0vlMo9MI1rrvZfl4PduZQGnEMMnfvNAwiWQvdZH8d
	lTgcP2oi+k+WcTQOaClyHr9ag7psUkY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-cBEVCPgOMg2wQwLz-KayMQ-1; Mon, 01 Sep 2025 04:32:37 -0400
X-MC-Unique: cBEVCPgOMg2wQwLz-KayMQ-1
X-Mimecast-MFC-AGG-ID: cBEVCPgOMg2wQwLz-KayMQ_1756715556
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b7265febdso28104385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756715556; x=1757320356;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FO75zWx7qwUC6w5oKfEBr0b/vUP3SN++OhAvNFPRXVg=;
        b=gC1ZFg773mK5eqr/49MCu2BUTQr/Glisjp0qYyErGON+vYPYotSE8E0dUujiPsXWb+
         +js8GEUPUrjKOMet/eHvGxWqllVzNjYnIZKChc+L+rl8UoIiMTtklm8PWBBr88nGPFA5
         A+OIucTregxekgLS1kkU+LjAEbNFUkW3imdQvwECT3fmss1dgVASvSZN0KlI4xe6uIjc
         OrYoWZeX647ORNOtpaFmBSC9lsgbs37gmAKfrXrSKPU/AwL83akP+qSEewbAx54Nwqhe
         wjE6dF7DokO2wsNS8auCOnEUtTtuRyGGjUVouVSPTjIc/iL6EEPOKRbkVTIJdz33gWw/
         /1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGVXYOsKXVCoaYHtAK8F8v8stIYUfRswh8n/jk9i9eAiGUQKYNm1dPDMpz9h1rhB741naKsOzD0F3ZiCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFzOo4SxufBsIJlXbhl3SMizNBjoUiEfnniLgx5W8k1J26t4tF
	IBY3KGUZMRLX3Yokcpogbiw4EwFJ8EMurIObQFDmdohSkRxxD3mZ8Tn1aWDKqtYPElOE5y9Oo+S
	ss+IktEHhZOdgsG1nLiDUdY2soxY79o2p679GtXwC9zfa0VFEDEv1g5LuVV+dCNFtVw==
X-Gm-Gg: ASbGnct4labExp7BUBb6F1twkSv4lPVyW8k0FjD4PvZ7NZgxYO93fmhHjHfnt+LJkRM
	jlrLidtUvo20O1cxQiLKa8FZAYaIOMOF5AOKq15AV0g3SM9U8B/N1ZjXmlH6nCFlyrM+PH1Kudw
	GDbdBM5k+zYKWcl/ZNzNV76L2XPNyz4GPWxC72mpa5yJukEjjepoqLgDUvhDN+ZJYacGNZxLxY9
	ncxUIwu3XlME6MZGRh0fgLcWDxxIDHvXXPSiaBKyYYWFWsvwJTyPnRIKaSY1V40J2pKI/3JwrqH
	aJMLFuv0sjqMfY2G3JuSvaeHaeHUsXVZdHsV7yUNNxZ/WzleKH+U76PSposAyzBuqJLRExuQLqy
	2ff60uA8FeVHfCLur4m3Tbb/2g8AxHrbYYWPMba7pvupoWw4TzxPa/0A6tt0UVP3+AmQ=
X-Received: by 2002:a05:6000:2302:b0:3d0:820:6814 with SMTP id ffacd0b85a97d-3d1dfa15a98mr5911847f8f.30.1756715556207;
        Mon, 01 Sep 2025 01:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP9dL5XSvBxDQAkLE3hXF8+1bSABcszZ1QfxYOQApyHvl8SuiUtTgdOu/OQu7jJCKZ+Am8HQ==
X-Received: by 2002:a05:6000:2302:b0:3d0:820:6814 with SMTP id ffacd0b85a97d-3d1dfa15a98mr5911809f8f.30.1756715555735;
        Mon, 01 Sep 2025 01:32:35 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d3a7492001sm8035831f8f.42.2025.09.01.01.32.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:32:35 -0700 (PDT)
Message-ID: <9c3a2ecd-ceae-4e87-a6d7-6a7121ab7a15@redhat.com>
Date: Mon, 1 Sep 2025 10:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: Enable khugepaged to operate on non-writable VMAs
To: Kiryl Shutsemau <kas@kernel.org>, Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, hughd@google.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250901074817.73012-1-dev.jain@arm.com>
 <7towtl2pjubgdil4csn5rg3usbai5xvzz73wqkwj5b5awh2iim@wfvahykzjrlo>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7towtl2pjubgdil4csn5rg3usbai5xvzz73wqkwj5b5awh2iim@wfvahykzjrlo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> @@ -676,9 +676,7 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>   			writable = true;
>>   	}
>>   
>> -	if (unlikely(!writable)) {
>> -		result = SCAN_PAGE_RO;
>> -	} else if (unlikely(cc->is_khugepaged && !referenced)) {
>> +	if (unlikely(cc->is_khugepaged && !referenced)) {
>>   		result = SCAN_LACK_REFERENCED_PAGE;
>>   	} else {
>>   		result = SCAN_SUCCEED;
>> @@ -1421,9 +1419,7 @@ static int hpage_collapse_scan_pmd(struct mm_struct *mm,
>>   		     mmu_notifier_test_young(vma->vm_mm, _address)))
>>   			referenced++;
>>   	}
>> -	if (!writable) {
>> -		result = SCAN_PAGE_RO;
>> -	} else if (cc->is_khugepaged &&
>> +	if (cc->is_khugepaged &&
> 
> The only practical use of the writable is gone. The only other usage is
> tracing which can be dropped to as it is not actionable anymore.
> 
> Could you drop writable? Maybe as a separate commit.

I think we should just do it in the same patch.

-- 
Cheers

David / dhildenb


