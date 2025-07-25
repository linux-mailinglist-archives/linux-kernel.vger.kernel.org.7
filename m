Return-Path: <linux-kernel+bounces-745393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EC6B11953
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4853AB7D7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9620E2BD59C;
	Fri, 25 Jul 2025 07:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZpJVzVF3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB863262FED
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753429311; cv=none; b=j3eJmhyvlvTIbIPCkzj79IakiCyDiDgDnQTJgQmeW8L0/JuZt9Kphd90G0xpdWgswrcUUclcdgHpEMy0Yd+MbbnR3u4NAnSH8BtiFFmkgl5Gnp7Cea7iTG8OrQ+doUR1j29YUTbHyB2YxEv0WK1NlBk8an0KC0L20etBoED7PSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753429311; c=relaxed/simple;
	bh=n1Yy/vTkWVnAzcoZkx86CwPsntqa+uYX/R9vQ+HZ1ZE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IJHwvZhwsWbwzrYTbABt4d9xB9K1/xM54o3KfO7ndGcj/AXp3rg0wd98nbO7jiZK3gTImL1EuFWjonix6G5vqntNL2+m8gVBi1ikGoX7DC6DTtsq6ceAhVoA1FUFqDny/xBK6r/cjGD7cvwYq064xEG2OQgrcqqJuiXE91aQQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZpJVzVF3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753429308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fojekgEPv9cG6AwX1yoB6wU+2LN4S+SisKL82eDezBY=;
	b=ZpJVzVF3S7wwWyt1XpkL935O9hH1IYZnzEE9bdDezWDTWitRxchm8b8Lbls5HW1nQPYt4G
	DIoXi1Hti9jQj5yroURCtGoVQZGWMiXYo8k18eLqL8Hax66EbtiC8sQdgYTchUyUc0Q6cR
	OkJ7lzVxrZtjiA4JjjPjpzz2eaw8F+k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-MUtMDaxCNGOQTErCrQT8iw-1; Fri, 25 Jul 2025 03:41:46 -0400
X-MC-Unique: MUtMDaxCNGOQTErCrQT8iw-1
X-Mimecast-MFC-AGG-ID: MUtMDaxCNGOQTErCrQT8iw_1753429305
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4562985ac6aso14131665e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:41:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753429305; x=1754034105;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fojekgEPv9cG6AwX1yoB6wU+2LN4S+SisKL82eDezBY=;
        b=aeFMyBkLceidICMMELZbeSr0gOJHjhd93GOAwT55SN/4wfLaUrWALYyCfGISM7fJiL
         dTGklMIVBPZo684C0Xx89bWETCqc3QlYJ5DJOQ7jcMJSn9MONWbMUtDHW3yNP6ryk/5w
         MG+tr8D4iqnd0+vFDJEJi0+kf24oFYRoD0CZA1U89mDY0D0IBEkIvVpm9ls6Susv6caM
         /h9E1CC1t012EZrKuvBH4VT8hBC9qyQmmO5HaDrmA0OfhQWxTJ25fM2JZnpTpR7uHMVu
         rVmdcFvwlhWbO94MTMAP4Un+XEw5JJDPApdeJt8z+nxQJOD/B/luz4mPJy+Mhmj15USe
         VLFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPV0n0abdNRfY4GufLWe9Q6jtfA9PYWQ5FYyNuXyEuH7DALlxDjvYCTdn2hunyH8tBpGJg9NLmbbMMyIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx4boTAPziOMkvs4lpO7E95zDDsdNH4aZFGzLAb+eUOydN9YXk
	k7VRnOb0MQhf+aKjx6zN/FBrYcK5szZR+6umDVseL2Cw045BcRcLcv2fJ83UgstEaWpk+bXypyU
	CqKP5ZhR+06UgfimyOg/AwU3GzuhlbKcviS51VdriOKJ3DfW9Bvz+vNK8/tihHrH2UA==
X-Gm-Gg: ASbGncvPJe8xrRufmh9ejE5fbkFr7xqjYEMXjHyeUlQgy/aga1GKpiRgS3J7tb1Bote
	2WWF60KQ2gQZv4ptGVpW9vGSXqumViHgTu2ph6KGhkoOJwH2j8Kkbzy517lgtsT2jP1zUHhPLEo
	b4UjZACPqSZzLdxuwu/vlRmnDhpc2WrSwZQQ4rPWxR3r6CdzNK2Hgbzz+muFzcEQQh4a+VY2+wl
	z9F+L11H1UbO2NoGzAwbDSq+3e1lfws3arDxwRV4RTOU+r3aq2+LIuSeqcdvAw54iBEySYIVfMZ
	QMHxQQnlBZFC6bI6IVfDheczmq2JgP+ykSjjqONDU+FomJmOe22EZKhXuZc0iJP8QfpioTJGlcU
	izS67Em2zZFQ6yMYR30jLSlCjhhvgoVsGBw/1Sz2V1V6OT65cVNUg7CAxhbiufzpKo2M=
X-Received: by 2002:a05:6000:144d:b0:3a6:f2d7:e22b with SMTP id ffacd0b85a97d-3b7766009c3mr809020f8f.18.1753429304674;
        Fri, 25 Jul 2025 00:41:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIWm3B6b2z+ebRCjowB14VjtygW8iNzKNHxLAdIdSnF3kZaCH9XvX8UiUDWhVKBpKo+7YJVg==
X-Received: by 2002:a05:6000:144d:b0:3a6:f2d7:e22b with SMTP id ffacd0b85a97d-3b7766009c3mr808995f8f.18.1753429304202;
        Fri, 25 Jul 2025 00:41:44 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1? (p200300d82f1af4005a9fb1bf4bb399b1.dip0.t-ipconnect.de. [2003:d8:2f1a:f400:5a9f:b1bf:4bb3:99b1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc6e5e1sm4412643f8f.28.2025.07.25.00.41.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 00:41:43 -0700 (PDT)
Message-ID: <d242b6c4-8be4-4294-a399-ead2339f08b1@redhat.com>
Date: Fri, 25 Jul 2025 09:41:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
From: David Hildenbrand <david@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <202507241352.22634450C9@keescook>
 <e0a22433-541c-40b0-92bb-34b0596db642@redhat.com>
 <ef111032-e108-4771-9202-b8cdab278422@redhat.com>
 <202507241528.A73E1178@keescook>
 <28bf0b31-8b51-4acd-ae09-890a952501f4@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <28bf0b31-8b51-4acd-ae09-890a952501f4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.07.25 00:47, David Hildenbrand wrote:
> On 25.07.25 00:29, Kees Cook wrote:
>> On Thu, Jul 24, 2025 at 11:41:04PM +0200, David Hildenbrand wrote:
>>> On 24.07.25 23:32, David Hildenbrand wrote:
>>>>> As an aside, why should discard work in this case even without step 4?
>>>>> Wouldn't setting "read-only" imply you don't want the memory to change
>>>>> out from under you? I guess I'm not clear on the semantics: how do memory
>>>>> protection bits map to madvise actions like this?
>>>>
>>>> They generally don't affect MADV_DONTNEED behavior. The only documented
>>>> (man page) reason for EPERM in the man page is related to MADV_HWPOISON.
>>>>
>>>
>>> (Exception: MADV_POPULATE_READ/MADV_POPULATE_WRITE requires corresponding
>>> permissions)
>>
>> Shouldn't an MADV action that changes memory contents require the W bit
>> though?
> 

Pondering about this some more, at least MADV_DONTNEED is mostly a 
cheaper way of doing mmap(MAP_FIXED): in other word, zap everything but 
leave the original mapping unchanged.

So if you allow for mmap(MAP_FIXED) -- ignore any permissions bits, of 
course -- nothing really wrong about allowing MADV_DONTNEED.

With mseal(), it got all weird I am afraid, because we have this 
exception list, and apparently, it has holes. :(

-- 
Cheers,

David / dhildenb


