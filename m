Return-Path: <linux-kernel+bounces-836612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B05BAA290
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 19:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E1B3A7B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A430101A;
	Mon, 29 Sep 2025 17:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSVdRBV4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74DE21257F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759166725; cv=none; b=qwQtVzZB26OkuQsvYc7ePcPrTUahQcYMrsFG9I5q/OxA4DG4yZxr7oUVXeJPpx/l56+GLFFcBUu+4zUD2uo/qUtb0uW7gsZEmfy8h7AYFq7Es827R4Hmt4ir8gO6E6szBCs4xQygGHmp6btQmGh/G/Vo/OpA3tfDLj18q7vO80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759166725; c=relaxed/simple;
	bh=hXqBZep4u+fXDeqpqLunHO/Ir7UrJ7Ma8E/YEuLuh58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JFEa8RZC9JX5NNmJW3FznY06+L0l8RoY/2SUuKhq6nWhrTzoFWWwGj84pZo6xY6LN1TpUBb0EzuB132pYaxFTqA0lfmbAFLFkYu3zAUmSdo9fhujgPgZiqmnrKs3PY+KiG9dynXHagujhSH51Uda/U6J/uMPBM2qlIFEXfUiCTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cSVdRBV4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759166722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8p3SZSGj6nAAVmGdvtxrXv4VJmnfEi+0dJCW+oMQs80=;
	b=cSVdRBV4mVi4rsX7jgrL1xg4TXVXtbJ7jKUyN+AFHo8NXoykphaNS8x39mpCxavAuVtUKe
	QVX+PyEbHLIKibARhi4xLx+malhfG8+x6jUA+do4yPXenqDTalMuzCxR73eRbzNiFtF+8a
	iL3ZfdUeiIF5ry8fREpALGeqHHpaiQc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-6C7lB_lYO9a1zpMOQi9dXQ-1; Mon, 29 Sep 2025 13:25:20 -0400
X-MC-Unique: 6C7lB_lYO9a1zpMOQi9dXQ-1
X-Mimecast-MFC-AGG-ID: 6C7lB_lYO9a1zpMOQi9dXQ_1759166720
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece0cb7c9cso3577315f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 10:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759166720; x=1759771520;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8p3SZSGj6nAAVmGdvtxrXv4VJmnfEi+0dJCW+oMQs80=;
        b=hpXk2f62rzX+ehUNn2ffNhBm748ayJIDBJa8jVTfSs6wNio9sv70SDdcmqSj2sg0Hy
         x6TLAMO4t2X62ycMCB0B6mspXkC8leSw41kWBS1SrieFSbQiMXfAVAy/SsOR0yTh+rAd
         +B2tajssYass6NdxgEm5NZkX7BqLE3viqReQVHHJEoM5iT7ILp2OUVpa8zTSYdNeJ2YO
         tfFjJjE3/Hf4fuztj2xsdTHTNRbTt3MgYSHU3+U4LBHR2UqndUK1zmAYDzZqb4h28kjb
         EkQvcmEnPjeBXlDqNd/m0chlRJ1fKezvqnUk/zRDKbPi1FU42s6mCQeAMTJQjSdwK9fD
         GS6A==
X-Forwarded-Encrypted: i=1; AJvYcCVmLd/4J6uPMXfvRo2XGIVQ8haxUpq9DdO6/wj6UoGSG7TJfKdIsDnD4E6kI/MtNAWzVp07YleIYwFRows=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9q75/uHxRYx+UV0a8IxLgTtSGc4TK/8IpSENA3kyLp8j+/Gu
	11GSqRhRXRmSwoV6yIu8rll9CqMHA5+FQ+CO8aghVWhBjoKLAwVGaWA0rb0sz9CKhOxnmuH3o79
	hpN6krgOtR92IZF7LJcNfAPG7wOwqLos/8GV6+rUWH9PtXperc0t14IVdHXXh1EyVYQ==
X-Gm-Gg: ASbGnctVY5mMFgCvMZs7pNBhtcc2jJdmEB2pWN6fY8mcoipmtENNEwIsG6XEk+7QWsX
	ARWtaZkr8L3Fx5mHy3Wga8JJ6rXj3Z7m4jb9XJ0To8fPXBoU0oIHTopsa4YmVuJ77X2ZwgNyqgP
	+C+c/Y0FP1yAXE62NQqRIVCLc9Yy0pBRTWHPoZ1W/4sfu3Y2hK5EQfjtvhO+HxkIfW4PDc6DJ/A
	J0RsMXatTcfuGmFBtXLjpNIHFYVLVCf+zB05SlLpxjW4/xBXSWUB4lQtDY8hpBKr4lyAzpNBODh
	/usHQpKG+kkVLFdqeH6RBdpO31RwhzyJ9hO5b5iSlituohWnaAPkWGgI1YXM491gVIBrIUcSfTn
	itJM=
X-Received: by 2002:a05:6000:4382:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-40e47925a6bmr17792023f8f.25.1759166719599;
        Mon, 29 Sep 2025 10:25:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8yf6V0bJBhN3rZAINkUtJpgJnInOSm7QsAGkazdg2CilMW0OW8WBM+hc28aI5tpTfBIsZFw==
X-Received: by 2002:a05:6000:4382:b0:3d5:d5ea:38d5 with SMTP id ffacd0b85a97d-40e47925a6bmr17791990f8f.25.1759166719130;
        Mon, 29 Sep 2025 10:25:19 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d? ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996c03sm234843445e9.3.2025.09.29.10.25.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 10:25:18 -0700 (PDT)
Message-ID: <c1294b63-eeee-4d99-82b6-93eb3a6d0af9@redhat.com>
Date: Mon, 29 Sep 2025 19:25:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: prevent poison consumption when splitting THP
To: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
 Jiaqi Yan <jiaqiyan@google.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "ziy@nvidia.com" <ziy@nvidia.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "npache@redhat.com" <npache@redhat.com>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "dev.jain@arm.com" <dev.jain@arm.com>, "baohua@kernel.org"
 <baohua@kernel.org>, "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "Chen, Farrah" <farrah.chen@intel.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Zaborowski <andrew.zaborowski@intel.com>
References: <20250928032842.1399147-1-qiuxu.zhuo@intel.com>
 <CACw3F50ijQ20Vg8ycMROSCccf_XtjB_fFvLGxvQZ7eaNQoLwGQ@mail.gmail.com>
 <SA1PR11MB7130ABC25E060D2CC4749E45891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
 <SJ1PR11MB608350E5169EE77F86A51E2FFC1BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SA1PR11MB713082CA93E9B1C5F22CFBBE891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <SA1PR11MB713082CA93E9B1C5F22CFBBE891BA@SA1PR11MB7130.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.09.25 18:30, Zhuo, Qiuxu wrote:
> Hi Tony,
> 
>> From: Luck, Tony <tony.luck@intel.com>
>> [...]
>> Subject: RE: [PATCH 1/1] mm: prevent poison consumption when splitting THP
>>
>>> Miaohe mentioned in another e-mail that there was an HWPoisoned flag
>> for the raw error 4K page.
>>> We could use that flag just to skip that raw error page and still use
>>> the zeropage for other healthy sub-pages. I'll try that.
>>
>> That HWPoisoned flag is only set for raw pages where an error has been
>> detected. Maybe Linux could implement an
>> "is_this_page_all_zero_mc_safe()"[1] that would catch undetected poison
> 
> This sounds like a great suggestion to me.
> Let's see what others think about this and the name (though the name already LGTM 😊).

The function name is just ... special. Not the good type of special IMHO. :)

Note that we'll be moving to pages_identical() in [1]. Maybe we would 
want a pages_identical_mc() or sth. like that as a follow up later.


So in any case, make that a follow-up work on top of a simple fix.

[1] https://lore.kernel.org/all/20250922021458.68123-1-lance.yang@linux.dev/

-- 
Cheers

David / dhildenb


