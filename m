Return-Path: <linux-kernel+bounces-758661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB9FB1D235
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B3A1AA1D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697D02185BD;
	Thu,  7 Aug 2025 05:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U6Oeos/4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADB5BAF0
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754546135; cv=none; b=Kh7q2yqiJ1AYmrtnHpnZ48vVp+s2Zcil6UIOIjeWznR+mxWGvINGZn4MJLqyHXH6T+yRR2heAeID1lBml6Du5eHoEFmakIOUUEqlYs7V9kTvZxhzL6y1BHk1W2Ako2Zc0Aaanas5tpNzRZwGeWmTBqJfXlJtm+PLwO+4YVPwN2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754546135; c=relaxed/simple;
	bh=q91oghgucfy4d/4IJR8jb5aBP3fpyShUx8waoI1W7mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUPfxn8btzGLSC5fKAgcwMOWBWw0Ro+7i6I4VLJ570x5bQyEMJqR1hWsaHRIOhvnwvU1Rbrm91uqMUuU40XRtMlbjSAmQOyJBLqofAsmRLqexe6Yx2pIAopoL3l/aRC7F1jScdSwIbDFBF8r8cvFcbLKU71BFovcJbAa1wB8GHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U6Oeos/4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754546132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=p7T7nHeTlN9HwipzMNJDP8Bfwjs2xG35T+M5i7PC0Cw=;
	b=U6Oeos/4aSMPttyd/8AiqJIH2PymVqeq4g6SdzsZIiBPs/voe0+/C6r4CuxfzgeNcpsk2M
	o2w66/pow6ETWMxSO25C72OwSJI9XUX4CIFK/iI4QFfbUWlFWByXpd/HYfXQNDHKJaLolY
	b0osuL2FoUaoKkj9cAipV2AWRbLCPZ4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-c1__is09NyecKEWetct35Q-1; Thu, 07 Aug 2025 01:55:31 -0400
X-MC-Unique: c1__is09NyecKEWetct35Q-1
X-Mimecast-MFC-AGG-ID: c1__is09NyecKEWetct35Q_1754546130
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b783265641so237206f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 22:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754546130; x=1755150930;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p7T7nHeTlN9HwipzMNJDP8Bfwjs2xG35T+M5i7PC0Cw=;
        b=w3Ns/Ocb88FfGeOjvbIVIcnIOxoGTrKTE4L41/5MQwiyZ3rEkJWB83EjUF4/FWoLNT
         vfRIzzgx9wXf7DNhkS6YRWxHPXakvEMlZUauySqTXW0UERiMTZY4Cs0Kem4J8IkVr02t
         +fAQsgc2fO+5WoVzTDpM3zIh9WXnm19G+QQPUlc4y0onRZpk7JP/p49JPjgUA45hUeRT
         A0WZFtaRLGeXs3PTyoDlNw0Akfa0OAQ9qC4KzYbXYbfeRRoP9ZXiyUpVuRfLcryHfVfi
         vz493RX8F29GMG8OCo3pDs/ThOSPnB3+X4eoUXkBMbYm4XDk5+rqBFw/WYW65/lvIRJs
         YCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw7sDuPObuJsJXnXjwcCeRhuquBX1KpOJV6T38dRgmDv2RC/Yugr8mfbgMK4d+xWML2g2Bu9uoEejYm2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFEF/K1WHHhMz7VLyWhkJVsrgRBV4+HqN7qnQQdTT/RNkCROxk
	4MBOZnfzhcTYpZTNRSJH6xl7jhGgnj9lroAZ39CCL8gLzD8co1CQ0gvFB/pPIR3B8SVDDhVymBH
	uE2INy1sn9pOs0sGmE8kKKWCzDCSBv//pb+Uyt9awIex2AfR/9/WNxI1VJbG+sY2lVg==
X-Gm-Gg: ASbGncvc+1l11zPNfsEWOBpsC6i1Dd/xiS9zGQm3lxTE2NYJjPYkyeuzzDAVZr9oReW
	CMcQdc5cJMjnIuP2KFKrH9N9o2FZTjz2ZbcrhvpnzVAsaR4RiZlGI78nrX2e8/URS+eAVGBmqLT
	53Or04oDGSikVSJYndtLV71J8GwvaG+Jg3sVZyqg2wNmJlfhLp0kmvJ9gAXL9NXGtX1wqT718TZ
	StvxGqKAixMDqfdY2MUMCCf9rGwNmF6SzMn1vmXwj4qG2tNbWfHUHQPZggYzAuoxTtSTBxop1sy
	flvCAq/IsqASiWpeyQ2qDk9fBETXDhvizdNVrpW6T3H0mySXZYvJHnh3vSzYBGbJnkhjTg==
X-Received: by 2002:a05:6000:4308:b0:3b7:99a8:bf6e with SMTP id ffacd0b85a97d-3b8f41d50afmr4804893f8f.51.1754546129991;
        Wed, 06 Aug 2025 22:55:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrCIxSNpL5yXQYQfvCpzINdTrOpqDRRm3qfN0xJSXs+Wik+zOu53yB4YxDQ7mNhDwLqABUIg==
X-Received: by 2002:a05:6000:4308:b0:3b7:99a8:bf6e with SMTP id ffacd0b85a97d-3b8f41d50afmr4804861f8f.51.1754546129574;
        Wed, 06 Aug 2025 22:55:29 -0700 (PDT)
Received: from [192.168.3.141] (p57a1aa57.dip0.t-ipconnect.de. [87.161.170.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac115sm25527853f8f.12.2025.08.06.22.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 22:55:28 -0700 (PDT)
Message-ID: <2fa2f288-bb82-4a9b-8dec-3a4c768fb970@redhat.com>
Date: Thu, 7 Aug 2025 07:55:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, SeongJae Park <sj@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Takero Funaki <flintglass@gmail.com>
References: <20250805002954.1496-1-sj@kernel.org>
 <761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com>
 <CAKEwX=MVBJ+Okfsob4Z30_5Y4P8c2DWoS1dYN4dF5dgp4+CexA@mail.gmail.com>
 <055a8a69-731d-43b8-887e-54d8718877cb@redhat.com>
 <jn2fzoodgcxmyld5c7k6jifigkmbhmq2gftvxx7k4ei2kz6r72@vlrndnijfgrf>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <jn2fzoodgcxmyld5c7k6jifigkmbhmq2gftvxx7k4ei2kz6r72@vlrndnijfgrf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 01:48, Shakeel Butt wrote:
> On Wed, Aug 06, 2025 at 10:14:39PM +0200, David Hildenbrand wrote:
>>
>> But yeah, whether these "as is" pages are movable or not is a good question
>> as well -- in particular when zsmalloc supports page migration and the "as
>> is" pages would not.
> 
> By "as is" page, do you mean the page which the reclaim code is trying
> to reclaim or the page within zsmalloc on which the content of original
> pages are copied as is?

I mean whatever the "dst" is here.

+	if (zswap_save_as_is(comp_ret, dlen, page)) {
+		comp_ret = 0;
+		dlen = PAGE_SIZE;
+		memcpy_from_page(dst, page, 0, dlen);

IIUC SJ correctly, in case of zsmalloc "dst" is just the same page that 
would have stored encrypted data.

If that is the case, nothing should change, really.

Thanks for clarifying, all!

> Most probably you meant the page which the reclaim
> code is trying to reclaim. This page is on its way to get freed after
> [z]swapout is completed and this patch is not changing any behavior for
> that path.

Yeah, that's the "page" in the hunk above I guess.

-- 
Cheers,

David / dhildenb


