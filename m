Return-Path: <linux-kernel+bounces-802494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C4B452D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DFDC1CC1BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2610A27FD68;
	Fri,  5 Sep 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UooSh1Kc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565B92459E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063586; cv=none; b=GwnB2yzQvTttFcmao+FOxzLtf5alD/pwD7RKn8GYC99XfDAca23hWjJLk7/ggzELTS56tAreOaw+psxtFPkPYQpYPI7PQgUWJRb6q4cPdfXI+DRIaBaNw+d5Ppb3yeKtinOdSNL1roKmUctvgZ/6j9ucQ1tHdDEOmR/eTgn2a60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063586; c=relaxed/simple;
	bh=oSyI9JwvJSs6TyzwFdZYl9UwEU9kXZ+R8bzYFIyhtT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1tsXU7/N0dvePvvPgHtS4RbbqLtXlcFqBhUb4zD7jXNYe4BwCctaf4LgFejm1DKlD5kpE5B1LtgK9TgCDQrEFqZ0BR588AkOmlrmKvcj4MfGeiSgbpNSGTWwXUx4KOzlxhwwqqujMof4HrII4PD22SsDso21ikE5PBnl2Qr7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UooSh1Kc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757063582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QVvTdDDvCrzh90dm3ynP6FAoOKdgvK85lFiJLYQoTss=;
	b=UooSh1KcILmHET49+Frrbfuzd9m9znX1EmJw/+3Fj64i7XtcUtf/QbDjBekb6+rIv9ywD6
	GC0B8yqHXIk7f92lpM+KHOlBT5j/XOaAKUbdR/g/funHF+6KTJaqD9CYSOW+oR/iR366qI
	UYH6XzmPgkoFxx/VDbWbj54JKc42TeE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-bHuLxhfCOfiTK7B1WZkuOA-1; Fri, 05 Sep 2025 05:13:00 -0400
X-MC-Unique: bHuLxhfCOfiTK7B1WZkuOA-1
X-Mimecast-MFC-AGG-ID: bHuLxhfCOfiTK7B1WZkuOA_1757063579
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ce3e098c48so917241f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063579; x=1757668379;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVvTdDDvCrzh90dm3ynP6FAoOKdgvK85lFiJLYQoTss=;
        b=mXKnMGb3K4LQG/3+BEEdG+1dTNux03GevIgJ9tFS3wgOaThpuwpBe0I8A7r+no57/K
         0F/5F6JpREOIzFbJrT527K0fiBU+G61QxdP0vxtR6GcDYBvP1ak+LlOSVi3cKku6CY7D
         KtNg0ZAT2NclOFvlSRu2DKGaLhDBIcocQR4A+Z5qOs3B2VDDsh41fa32JJYfvSI1GMaj
         0vVj+veBTcqHzrPjMTT1lj5m+03Kq4wsNVgsK9kLpTQgjdWX/bmtrTeKT9eaH442FPLi
         EKB81C9J3yID5czdkdA3RbiYT//MWgqi7NzK3XX86/ckJ4guCuQg3fu8cypY/IQx/xZx
         6Bpw==
X-Forwarded-Encrypted: i=1; AJvYcCUtnek8vfp7ikgUe5iDxFAJxeeshevzAAKemyLg50dOlcf7oICCQsvS8khN341PKN3Wz0I0ZrTiZeIXvck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXkxA75E25QjQr99R6Un3sy8BSXv6jfm2kCn0EBnKM+7Ns0wh2
	4vjr0NE6tNu0CrH0JrHewti6vWMyBf/pGlZ8uyR9asw983s6Gs2OjEKJx1uiwZPJUQry8amsJyf
	lWNHcx3d61FuiDwGKjlKHO4olOomY3z6p5/acr6tTuJL3Y633yjI3IvBGhPryaaCo7g==
X-Gm-Gg: ASbGncse1a1q6xgi71V9/cWC8FHRM5O3ngMmI5c371DVk+s47tXCU0VFcf4REReTpAp
	UyGYAfiEUu6Pk5JX+yrI5j84bS9V0ll5PL7nPp8ttjGQt0zGe/x5dNj/Mfx8VbNp/eXHhygHrV0
	ONIYE/CIs2TxbZZ++7n4+db/UW6Ia+3Y3PZkJB7Kh2EWVjjf3z8d7Y3ydgQ1lw+dXA+06Gdczxt
	RO6/59FkGfzK9TtLR3tgYlxDi6O7wa4okV32nUxW6obpUXC2Lb85k1NG8Zq+DFTH+3S4G+DFEkG
	ErXVYck/B20Xl5Uhb60J1hV0Q9TCwcnSHsNmZuLr6BGYejbKMDMZaZonunnUijwO8xiXZiPGLEV
	rjRebszQJxdRktezj7ujpOSriG62W/jnw9Tu0lDcYnrKYt1bRvCyac2ke
X-Received: by 2002:a05:6000:400e:b0:3ca:a70d:5710 with SMTP id ffacd0b85a97d-3d1dfc07359mr16418650f8f.41.1757063579492;
        Fri, 05 Sep 2025 02:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwFJy7qhgjRNCRj3exLbKYmipQkpcRWo8U390ZzooMqsl81hg/STCVqaAiOJLTltnhZ93cNQ==
X-Received: by 2002:a05:6000:400e:b0:3ca:a70d:5710 with SMTP id ffacd0b85a97d-3d1dfc07359mr16418622f8f.41.1757063579054;
        Fri, 05 Sep 2025 02:12:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf34493b8csm30046369f8f.59.2025.09.05.02.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 02:12:58 -0700 (PDT)
Message-ID: <3ed39039-e20b-49b4-a589-665d55105f00@redhat.com>
Date: Fri, 5 Sep 2025 11:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
To: Pankaj Raghav <kernel@pankajraghav.com>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: Zi Yan <ziy@nvidia.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
References: <20250904095129.222316-1-kernel@pankajraghav.com>
 <2psecfvsd4lbgcm6aflifi2kc6gof345txsvk7wtsytre5ehqt@4wyru36aaeel>
 <e8d5eafe-db58-4b78-b029-de6a59fc4fd7@pankajraghav.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <e8d5eafe-db58-4b78-b029-de6a59fc4fd7@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 10:13, Pankaj Raghav wrote:
> On 9/4/25 17:26, Kiryl Shutsemau wrote:
>> On Thu, Sep 04, 2025 at 11:51:29AM +0200, Pankaj Raghav (Samsung) wrote:
>>> From: Pankaj Raghav <p.raghav@samsung.com>
>>>
>>> split_huge_page_to_list_[to_order](), split_huge_page() and
>>> try_folio_split() return 0 on success and error codes on failure.
>>>
>>> When THP is disabled, these functions return 0 indicating success even
>>> though an error code should be returned as it is not possible to split a
>>> folio when THP is disabled.
>>>
>>> Make all these functions return -EINVAL to indicate failure instead of
>>> 0. As large folios depend on CONFIG_THP, issue warning as this function
>>> should not be called without a large folio.
>>>
>>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>>
>> Acked-by: Kiryl Shutsemau <kas@kernel.org>
>>
>> Just curious, did you give BUILD_BUG() a try?
>>
> 
> Yes, I tried BUILD_BUG() but it actually fails the build because truncate_inode_partial_folio()
> calls try_folio_split().
> 
> It won't be called in runtime because there is a check for large folios before we call this
> function. So a runtime warning is better in this case.

Right, folio_test_large() is not compiled out.

-- 
Cheers

David / dhildenb


