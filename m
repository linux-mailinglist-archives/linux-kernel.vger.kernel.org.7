Return-Path: <linux-kernel+bounces-760062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447CB1E614
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB7AA18C849A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A193E2741D0;
	Fri,  8 Aug 2025 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDmWQgn9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F16270ED5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754647120; cv=none; b=gNTu1r8wof6n5k4Kn4+9xe33mc284QvTLfUo5rHpMeOXLEhm/PnMHIsfbMsy5Bgz3jq9E4CPbrZGKwPVr6pTmLKiTIWXVqZ5Dajw5vZVOVQLyEerrOkZYxhYH7vJrABInBQH39AEJ+hgQzfsRHFZvEZkfnnNDBClLkEzhPSHorw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754647120; c=relaxed/simple;
	bh=OOa+UuUxRHC/ImbeLSxcOFc8EW1Z14mIlQViw6der2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujZTAhvpdKL4AehNnaqpPkiKRm4zQZEnsN/2Ow/FnjAyA1EL5x+134AiXAn+oW43LgONH9vCu2Qc6frhNwhS93/3vaGv3mdQ+O5cBiIP1j5DxhwdX37dY4Bual7xfk/3nr33u/T+VCxqxd7IAUouqejm4Suy/Uv3miNjIPshaWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDmWQgn9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754647117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A6EIjzr4doiTkMErgQyRymzeoV6Bv5w070CrSlCm7F4=;
	b=TDmWQgn9ZUnIkcidnRM9jZtS3bDSnD7h22H43/iyux0ZclaGJShNUdp95JJNPPJcaHu3r3
	W/gSZmXhwsTws1C2++4FOhUksAH/zeY4qNRENOZdhxdnyU6E65CJrO9HjDdkXKtc01cHrs
	S33d+n016iJviUHcD3F9DWYXUstSd6A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-nzJHWpfDNKSE-crKlfUigw-1; Fri, 08 Aug 2025 05:58:35 -0400
X-MC-Unique: nzJHWpfDNKSE-crKlfUigw-1
X-Mimecast-MFC-AGG-ID: nzJHWpfDNKSE-crKlfUigw_1754647114
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b7806a620cso951109f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 02:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754647114; x=1755251914;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A6EIjzr4doiTkMErgQyRymzeoV6Bv5w070CrSlCm7F4=;
        b=P43dhJbbmBH0PJ9bTOTexs6IjgIssZvDgZCCJSXJR4jD063/EHHAfUT1ZF8xIfUhTX
         vzjJFRWwpEXt/GWy9NahW+3AqestdpPgrRdvJLe9TmoI1d2eFM1LfEpUnBcxrFEWYmLP
         P4ufTy9Xvg7qO2W/RHuYwN9B5jIV9fjmp9zByZVm8Ik7TL/R23mUsdCo6T6riqHPlLdO
         zP/1JRkKjU1/PuID9JNIXG6lWh08vE2fQTiyFWIMf1/+ex6vb2mfz++cI3OWxyM2+iaz
         ZTFPjrtI7J6VAOZt8OFe+Z4H27fktFO8QEgw1RYF/nOBFFLjPxBdAugqca85X8XWBmL/
         w8jw==
X-Forwarded-Encrypted: i=1; AJvYcCXLCgsuDAlkQ25vkf7eDvi6rki+TMh3+/VAz3EncXWa/NVVh55UuMpmZzitziG8TwEE5QDVSsOKyGMuBeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhSHl4rd6V00qQAZUsiWsW7U7GXinOm3b8osDi1xoBo2CW4Ouf
	/k0WN2BhFhZ3iA/U+N3qhMDHHIofKx/ZwcM8DU0IV3/gMIcP54/OPHefYjk7/SPzCFs++a7aWqb
	CAbSzIYFeAoWJm5bLbzEjfpC6hcDbtLqzQI0RvcovsUIvncQH7nwVK0scJ9fGw+lzjw==
X-Gm-Gg: ASbGncvXBjh9BDbeubfTDvO+9pGsxbgoGa1fY3ptbwXcjVboGPVJl10xAq6Q7HEELsq
	szs2U4j4nId3JaTBT7V4DYztAgUwN6Q+H00cC0X9t+V9ZCzrU316uQ5luqSKzgtJrjfYsx7tB3e
	PrM1EdC2JGB14HVVtJKg+uLPrGr/812AEAKk+hqyUR+APZukUidQ0gmHAlPQv4aq7AW0ee58NRu
	K+O1oWPpphOni9F1n3mmr2b2scyj/b7//MsqAam2Pu4ueirbv98eQuYoE6YirpLw0eZ0ZFx0kLu
	DmOWdvO20KNZ387MyeB7mhPhJ4dWsqEKHJe8T93T6QRL2tEkVEkTdmUzBtRnOawbFtQadc43JIX
	N37LzwkDoENO1zAjsE4cGrKnvFbHvI5xfcwjeQWxhNlwKJ4/FWiGboM9Li7mpoOvd
X-Received: by 2002:a05:6000:2481:b0:3b7:94c3:2786 with SMTP id ffacd0b85a97d-3b900b4d3e9mr1836090f8f.34.1754647114339;
        Fri, 08 Aug 2025 02:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVDxTecPK31JPsEvI9Dj75n/o5Afl+u6OQsbq2vBX9FCRah7FVa6oNlXxQHp8K04vDbcolMA==
X-Received: by 2002:a05:6000:2481:b0:3b7:94c3:2786 with SMTP id ffacd0b85a97d-3b900b4d3e9mr1836074f8f.34.1754647113881;
        Fri, 08 Aug 2025 02:58:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm28963366f8f.30.2025.08.08.02.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:58:33 -0700 (PDT)
Message-ID: <985a0cf8-b6d5-452f-9afc-4c04a86bae64@redhat.com>
Date: Fri, 8 Aug 2025 11:58:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix the data type inconsistency issue of min (tier,
 MAX_CR_TIERS-1) in read_ctrl_pos
To: Qingshuang Fu <fffsqian@163.com>, akpm@linux-foundation.org,
 hannes@cmpxchg.org
Cc: mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
 lorenzo.stoakes@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Qingshuang Fu <fuqingshuang@kylinos.cn>
References: <20250808095416.208289-1-fffsqian@163.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250808095416.208289-1-fffsqian@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08.08.25 11:54, Qingshuang Fu wrote:
> From: Qingshuang Fu <fuqingshuang@kylinos.cn>
> 
> Due to the fact that the tier data type in min (tier, MAX_CR_TIERS -1)
> is int,but MAX_CR_TIERS is an unsigned type, directly using
> the min function for comparison will result in an error:
> 
> from mm/vmscan.c:15:
> mm/vmscan.c: In function ‘read_ctrl_pos’:
> ./include/linux/build_bug.h:78:41: error: static assertion failed:
> "min(tier, 4U - 1) signedness error, fix types or
> consider umin() before min_t()"
> 
> Fixes: 37a260870f2c ("mm/mglru: rework type selection")
> Suggested-by: David Hildenbrand <david@redhat.com>

You keep ignoring my feedback and I can only reproduce this with W=2 
where there are like a bunch of other issues, this here doesn't move the 
needle.

So I'm afraid I cannot spend any more time on reviewing this patch.

NAK

-- 
Cheers,

David / dhildenb


