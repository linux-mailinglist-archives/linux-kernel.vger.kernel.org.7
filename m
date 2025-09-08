Return-Path: <linux-kernel+bounces-805339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE3B48748
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B0741641D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32B82EACE2;
	Mon,  8 Sep 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev+Dr2+o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757C1DDC3F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757320407; cv=none; b=iyhT3ewn0rtF9HWJfo9srRotxMmmD7E/cfGK97W00JaGLxqCMFBHZ3pUX0ho68epeS4HI/zViDTJkmT9//N10WJ++L6n3h6Z2P+jjriwOYCj6oPp42jAFD5sOhiNqCYwUzH2BPSPSNaf6OW1TlMaNdZKwgaITHPF3ZMEJbDWjbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757320407; c=relaxed/simple;
	bh=YqwH95v3WxPKblwXHJFgW9MvFgWs3/w2C+P7HH2uXBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6XznUFOtKE0i+pX3Jm1voevD9lP1ikcYb5jdeMt7WgIGc4MxLVomhQPgYBebem7caHBXiPIZAwOosjJGMYJNbTXw9uL6EWfjvmT6rZv2prwV1+LlzVJAiLaMQl59rzWFULz1up6JebJm1bhpp0zwuzdNVa4P2PM7kJ8x8uboPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev+Dr2+o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757320404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EtnnjkE2sa/VAFor/J7GmB/F8L3NsbnUCYVr2WFGbAs=;
	b=Ev+Dr2+osGRCtaoP5xAv4cWwhwU03TwzEzV1bpIJCfmBT5fV3SnYd8JyXVVciZOK2M9CgJ
	zRordCC7rleIvM8J7flRK/xJJynSFFbVUYXci4j0qGifcYXA9y8um45YEzwwG/Bz1FkpQo
	XXQltXxzPYHRq5ndXvLMHwCmLYF9/v4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-inNCr9ZPOvGkQD77B4IJ8A-1; Mon, 08 Sep 2025 04:33:22 -0400
X-MC-Unique: inNCr9ZPOvGkQD77B4IJ8A-1
X-Mimecast-MFC-AGG-ID: inNCr9ZPOvGkQD77B4IJ8A_1757320402
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45cb4f23156so21914205e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 01:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757320402; x=1757925202;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtnnjkE2sa/VAFor/J7GmB/F8L3NsbnUCYVr2WFGbAs=;
        b=GDrNRQFzbWDJQvYIOxaIqFHOMKMJrW86zghXfT2nOGANsoMio3Hj5Ts0h2R4CV5QCR
         pWPk/dky8GAooEjZS+tXHch8LxuOIZwJh2rdltAmA+g/EpJLolPlZ7bK9+CM58IDlabW
         HUW3P45TvwEEDWVDKeV/FL5IlWlQdeJQcDKl4xFPPeGareb/kmiWRwQEbnzqCldCNKAI
         Adn1+UdJoMCDYfaSVlTYuAZZqjZhifQS2Sy6zp95hqRL/MWN0Qthe+7MkTfdhSpupAwx
         dzmJBQ8eA3Sk+QElTrtVmlTcNXq55MTx+NMbT74xSCBhVIj6KXkmUCo2MKlDGaMon6U6
         4gag==
X-Forwarded-Encrypted: i=1; AJvYcCUtjA0OAErhsIkEHWQIFaPN4TLALtbrhBkPZAiPqyTNMYvNCVrpqEtYBBmM5nV1HKoctblXYAHqKRS8kf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWR1ABQGvb4LOaRgjMfUxPeS+Xk4cm+8ciDG7DJG9lOt02D+Tq
	jszSbuHgscS4RMiNzSHzowv47MrM+6D3yaE9kibFG5n8h/r7Zq80YOlmP1UhLI5XwsS+Q57aR2/
	KLoxt/IFBXyjJx+vtOklFSQCvIz5yDhuh6Ikkbf51NCrPJzSrEk8/u0qcmmbFFtHisA3S9vgVUA
	==
X-Gm-Gg: ASbGnct7D9HmZgmqFaLXYg+MvvGzjDwkghxhT2u5ZKlkGGtI218ZPMU/iddH+JrUGrF
	klQX+vbMCHSnSyA1tg97ZB7fLZBXERvbVurUD5rsaccP+kh6H1/ypsfwXbADyTPMUnZ/GzUEg7h
	RiAOHLFunLXtkCocVrDz3WPiOZK+n8Oy5c8W1yZYdIsvxWqW0It74AnkWMI1us7t4/+rmYjpTkT
	FMtZtcZoLKpfQNIXugnHwN3wdsXry0+1B5WpWIRn1pNKvPva/dEwbn2ZPAKqGQvAeNfzocT6WrA
	dKgmOLdi3ryfCONpvI82iy/io9/EtBfVSiRPo2lKUZxFj/0zUaI2h8PriJYLU2eEXtP3qLg+8Tp
	/3hWu09DNlBaypqD4oWmaXLeJFkO7xZia+CHif1mgHKYszZxgGSZFBwgbnJeVAbg1
X-Received: by 2002:a05:600c:1912:b0:45d:d099:873 with SMTP id 5b1f17b1804b1-45de2547b9emr42261175e9.6.1757320401667;
        Mon, 08 Sep 2025 01:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ92pLEjQluT6SnPXGlHxbIiEKvzSoTm/+xGYPMrbleY5GV6dWcIL/gu8xTjnvzK1RgQmRqg==
X-Received: by 2002:a05:600c:1912:b0:45d:d099:873 with SMTP id 5b1f17b1804b1-45de2547b9emr42260735e9.6.1757320401253;
        Mon, 08 Sep 2025 01:33:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:700:d846:15f3:6ca0:8029? (p200300d82f250700d84615f36ca08029.dip0.t-ipconnect.de. [2003:d8:2f25:700:d846:15f3:6ca0:8029])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd05d0c43sm90946595e9.2.2025.09.08.01.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 01:33:20 -0700 (PDT)
Message-ID: <b30823ea-b987-4284-866b-9e179a2d8eb7@redhat.com>
Date: Mon, 8 Sep 2025 10:33:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm: avoid processing mlocked THPs in deferred split
 shrinker
To: Lance Yang <lance.yang@linux.dev>
Cc: Liam.Howlett@oracle.com, baohua@kernel.org,
 baolin.wang@linux.alibaba.com, dev.jain@arm.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 usamaarif642@gmail.com, ziy@nvidia.com, akpm@linux-foundation.org
References: <20250908040713.42960-1-lance.yang@linux.dev>
 <5a1429ad-3900-404a-bdca-f25623ce603a@redhat.com>
 <bc1182e7-3f70-4645-b8c4-a97898e57041@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <bc1182e7-3f70-4645-b8c4-a97898e57041@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>
>> If I run my reproducer from [1] and mlock() the pages just after
>> allocating them, then I essentially get
>>
>> AnonHugePages:   1048576 kB
>>
>> converted to
>>
>> Anonymous:       1048580 kB
>>
>> Which makes sense (no memory optimized out) as discussed above.
> 
> Yes, my reproducer also shows exactly that. It's clear a lot of work is
> done but no memory is actually optimized out ;)

I'm not really concerned about the scanning overhead. The real harm is 
splitting a THP without any benefit.

-- 
Cheers

David / dhildenb


