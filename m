Return-Path: <linux-kernel+bounces-794281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED786B3DF69
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6D257A727B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E39C2FB986;
	Mon,  1 Sep 2025 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYiMGBu/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216925C83A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720930; cv=none; b=YeJNtN90fWXX9K0uEB1rBfxMgFlmxe54Rtqc4XUOimI5NQFNUzwwYlsZGh/61z1QabVPO3AJ3I1eMv3RX+UBBYgIJNv5RRfDObmwwPDn0tmzaB7ZHnVtkL0QXyoq0tGqJRQo2r1cBZpWp57Gy55BFdTpMVsXKDQKkw2PgKaJFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720930; c=relaxed/simple;
	bh=ypTD0sEZG5IOONmhSh4yZK8w8GcKNQIdnI9zf9EhGuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8BQKfY4fr08XSyuRC76bEbBs12eX7pHHgQS3OpEXFZ2XjA8lmw/MNsEWE4iaOfQt978wUek/3eUVTtBCcPV/+ir3w4qY3mZV99saDZzF75ZcxCbSlGq7pOBffOQADILwwilXcAavPrlYoLtXy+dz31cd/IAK5edDyTBN7psbWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYiMGBu/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+lQeSnVszPSSY9ZXSFHEL5gERJYR6xjSMj4HUufxrw4=;
	b=UYiMGBu/8DtldXmiarqBcr5bDtwiR/xfaH14WvSfbRP3Q+4mAHII/Z7bWH9GIUdTuzIKVJ
	6aH52sPffhyxrlDLwuc1zxWIWbIsGqLZVehicsN153WP1Q67N/0e+JFLnjqQB1Qd7uyEcG
	nl3gSo1YwuVBSegzDmOKPDRYnZvVL54=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-HDitIfhZPFSK8g1rBWu1mg-1; Mon, 01 Sep 2025 06:02:02 -0400
X-MC-Unique: HDitIfhZPFSK8g1rBWu1mg-1
X-Mimecast-MFC-AGG-ID: HDitIfhZPFSK8g1rBWu1mg_1756720921
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b869d3582so7635225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720921; x=1757325721;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+lQeSnVszPSSY9ZXSFHEL5gERJYR6xjSMj4HUufxrw4=;
        b=K0K6eW6sGbANIPoLS181bia0NHsaWg7A8WA5SdOCUubyICoroS39KE7IUcYT1XnJX0
         3Xh5QEaP92s5irgpuTnCNL8uqnAR4ULBAjdWbjlykKUqNn7d//B3YfAdmQ2RPOAWXrxI
         8N8YRFOIoyGW7QcIThdLWzJTcKRgUg34p7DFoRIirydXpLRnLKnS8YAe/qW0iXleqmst
         y7DqTBhKjKJcR9bst1Dy8/5+9dgZ8YQqU3Gxj/+Gd7rM8oCemmOlzD+mHR5Rb9/kPjr6
         vZwzehGzaFAtcrwMrDAQ9XSyejRqZIgeLpTmYnpoQ2aJ1kRCy5Aj8rizarW/eyIiX2R6
         bhlQ==
X-Gm-Message-State: AOJu0YweIVxZO8ofJn+ygiId19tDzCV85V2cf+H16/EX9vx4Cr4ZHoVp
	Jnft7RYTSmEx34NT1TTp6yb8ntNWuTRgVfCGOw/mRejFITsagNa3qa6mdfQUnWjvXIMn5VRVl8A
	+5zqm3b67P3P5xCPjP0dV1Tc8nw63hjY/kcsaO3ctRN6ubtGS+YhqAMRBdUnICeotQw==
X-Gm-Gg: ASbGncsW1ogTfg/QSANDXWrJ7ZWMJ7H2WjTsDQCI7Xxd89yEjwsO+WQQv58924i9HqD
	qcKpZc+g86JsonIFBEy+t580JqxQgpqNY+CxKROEk/G2R8jhyW3lZJStTMkyOuJflFGsM4n1smc
	QPY0qpUvS7f1gTjsbIhP5ulTow9lKRcRX/jSBdqwvoiTXO9QvLdS+G1dX0GhD1xT+OKIwj1yh4B
	WlSikWl0FCvzOXg9XEynK22bZ6Gprn63Lbs0FFyFYqBmLA6JNhxzjIrzpx3SKKflZqVSZV5uLV2
	qqrIWBOQHu65P8koADYSnSvcLhWho/0OFMSmsfnriGoR9NW4RxTZ21FkGDNxj1LAPizqYNjB3Qj
	q4cEpW9W/awxA34JTMOf6n4dLtGlHGtCxmzsR7mQPHlKQ9IFH8POEBR6g4tQgmywSNp4=
X-Received: by 2002:a5d:64cd:0:b0:3d1:abf7:e1c8 with SMTP id ffacd0b85a97d-3d1d98d60e1mr4874729f8f.0.1756720920978;
        Mon, 01 Sep 2025 03:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvPsDFpHZYqBUf8mT2gRUFJpfAuTdUtgOPMP4pMlCUZ06zRhnpYdXw7CHR6fjLFikWold/+w==
X-Received: by 2002:a5d:64cd:0:b0:3d1:abf7:e1c8 with SMTP id ffacd0b85a97d-3d1d98d60e1mr4874687f8f.0.1756720920452;
        Mon, 01 Sep 2025 03:02:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf275d2717sm14699314f8f.15.2025.09.01.03.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 03:01:59 -0700 (PDT)
Message-ID: <7e1f4f64-dfc4-4366-8e01-0891b2d4d2b4@redhat.com>
Date: Mon, 1 Sep 2025 12:01:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2 22/29] mm/numa: Register information into Kmemdump
To: Eugen Hristev <eugen.hristev@linaro.org>, Michal Hocko <mhocko@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, tglx@linutronix.de,
 andersson@kernel.org, pmladek@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org,
 corbet@lwn.net, mojha@qti.qualcomm.com, rostedt@goodmis.org,
 jonechou@google.com, tudor.ambarus@linaro.org,
 Christoph Hellwig <hch@infradead.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
 <ffc43855-2263-408d-831c-33f518249f96@redhat.com>
 <e66f29c2-9f9f-4b04-b029-23383ed4aed4@linaro.org>
 <751514db-9e03-4cf3-bd3e-124b201bdb94@redhat.com>
 <aJCRgXYIjbJ01RsK@tiehlicka>
 <e2c031e8-43bd-41e5-9074-c8b1f89e04e6@linaro.org>
 <23e7ec80-622e-4d33-a766-312c1213e56b@redhat.com>
 <f43a61b4-d302-4009-96ff-88eea6651e16@linaro.org>
 <77d17dbf-1609-41b1-9244-488d2ce75b33@redhat.com>
 <ecd33fa3-8362-48f0-b3c2-d1a11d8b02e3@linaro.org>
 <9f13df6f-3b76-4d02-aa74-40b913f37a8a@redhat.com>
 <64a93c4a-5619-4208-9e9f-83848206d42b@linaro.org>
 <f1f290fc-b2f0-483b-96d5-5995362e5a8b@redhat.com>
 <01c67173-818c-48cf-8515-060751074c37@linaro.org>
 <aab5e2af-04d6-485f-bf81-557583f2ae4b@redhat.com>
 <1b52419c-101b-487e-a961-97bd405c5c33@linaro.org>
 <99d2cc96-03ea-4026-883e-1ee083a96c39@redhat.com>
 <98afe1bd-99d2-4b5d-866a-e9541390fab4@linaro.org>
 <c59f2528-31b0-4b9d-8d20-f204a0600ff6@redhat.com>
 <40e802eb-3764-47af-8b4f-9f7c8b5b60c1@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <40e802eb-3764-47af-8b4f-9f7c8b5b60c1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> What do you think ?
>>
>> Looks a bit over-engineered, and will require us to import a header
>> (likely kmemdump.h) in these files, which I don't really enjoy.
>>
>> I would start simple, without any such macro-magic. It's a very simple
>> function after all, and likely you won't end up having many of these?
>>
> 
> Thanks David, I will do it as you suggested and see what comes out of it.
> 
> I have one side question you might know much better to answer:
> As we have a start and a size for each region, this start is a virtual
> address. The firmware/coprocessor that reads the memory and dumps it,
> requires physical addresses.

Right. I was asking myself the same question while reviewing: should we 
directly export physical ranges here instead of virtual ones. I guess 
virtual ones is ok.

What do you suggest to use to retrieve that
> address ? virt_to_phys might be problematic, __pa or __pa_symbol? or
> better lm_alias ?

All areas should either come from memblock or be global variables, right?

IIRC, virt_to_phys() should work for these. Did you run into any 
problems with them or why do you think virt_to_phys could be problematic?

-- 
Cheers

David / dhildenb


