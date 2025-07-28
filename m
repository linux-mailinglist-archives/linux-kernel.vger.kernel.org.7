Return-Path: <linux-kernel+bounces-747771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5A5B137EA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 11:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ACA51883E35
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7D2561C5;
	Mon, 28 Jul 2025 09:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBo757Ca"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19281B0F1E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 09:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695786; cv=none; b=MJkRmIjzYgVH38/KoH6l9dm4lrVsFwqy8nIgqlarP1HXYEaaVu/92cHmwle5Kd+PGfWsHsQbHkYCUXOGDCG17gNHokRZ/W1EEW/3QqLPb9hipj+ivULHZa91oOBB2IMqIt9NAHBABFk6K/oa6eYHfiUIHyXTpPt/3f9wJblRoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695786; c=relaxed/simple;
	bh=VdET8ty/NA2kCkGF9fpFw/8BLYGw+VxVnTxo7lg7mHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ssNdlFnjuZSfk6nxjZHn0V3zPwvPQ89FJjadkMBSe/jR2mvtMKT1wbGz56n9PILt1mxq5lxGC+aOP0lGSqR4N0ZXjzkdSNz0VvVI1ucODZoexEW3bnvN/f+gN70ZVNTs5/0wEAlKGSvJpyt8jY2dT1pWO/etLq0WZtqrfbUhJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBo757Ca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753695783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0nzT7thxG2Q5khJ7T1QqJPd4Hx2iM3VFFGAgQnzoXws=;
	b=gBo757CaXoi/yG4JO0PqgIBxE9X+XfsJxZRIO6X0yKCMkzrnXEKCGHKjpWEFqYaC58adwP
	a/cgvgZOIxmzO/CkhbVpa+10nDxv7FhGc7Xmrwd9EWhqFlmPX0seTrRceHjJwX1hiJgA7U
	tXAjZecr6RDF/+5M8NWwNYLtsgPJkjc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-YktGp9h0Oba2-hdbvhN9lQ-1; Mon, 28 Jul 2025 05:43:01 -0400
X-MC-Unique: YktGp9h0Oba2-hdbvhN9lQ-1
X-Mimecast-MFC-AGG-ID: YktGp9h0Oba2-hdbvhN9lQ_1753695781
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-451d2037f1eso23548975e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 02:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753695781; x=1754300581;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0nzT7thxG2Q5khJ7T1QqJPd4Hx2iM3VFFGAgQnzoXws=;
        b=mEfyB3EV0dNjk7iaxG5kJpOz+vQT4wkwCrWorvc/JBsfaEQ6XzQsr4bf1aLMv0ENJB
         x3Wecj0RTTd7nISeQ1nHX/bjyi6gEKUE9jrx8oYbhIN4GRZn0058sxh4iWYGzGe6Rj4n
         wO20EpOOg0sQzDMhlwF5t30OxDKFWa5PGR8xgNjXPB8f2E8H/xmCjgZa+RLQk6Bk9HYo
         xXQm8hCq1PO2V2w9k3/FqyZEpRDDHeMhlz0dQK1huCokmyYo1sr2LZLekUbu92e5yCTU
         rRMpGaelhF/W4kPO2q/Lpdab/4M37xNGWYSkyrFLujrna1r4GgG63Oc9/A3qxtU9qN74
         J+Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUAapN1nEHn8rxdXBHQeKPztCpZ7aKDE7bG9j7NoajdreaBnK/r+ZQsImCNokOuS9JsUsP8lUVYDcV+HT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcH2+5A+c6ts9fyRUA6TnmTSSHeWFC+ppLNboFWlpqbEZ1DVW0
	e/Eax161LL/Ywv6Alv2N+ChtUQsEa0JYKVpsqm0jdD84nG9VAZF+FfJK5vYsnQ8RAMBrAfBUdcS
	a8zW0mxnaAFiZPq1fSMhdP1SUkgEYPnhdcvw+3lMnSxgONvyDcrCRf+ndLzUSD9ICWQ==
X-Gm-Gg: ASbGnctokgrxacH+lYIIUR1f/5ElTkiwZgszISjhrGLMEvy749fvreeu1PNOQU3dthf
	u6bXNV176Wnds3uFaEt5lka28q9OtOavYdZYqZKZm1n2aKkyLHYgTlBvNvZo0YeoJIcLLAwLYuD
	5KFJ6AFh5SbJINd+YfebT9j6UEJ2SUnk2tCDaWK2k2Ar2mOmF5GMaOOyx/KIzE9M/IrZ3p8eo0q
	ahYbDdGvEGdj8cmqVtd4EtvDx9f8UlpfXkpbLtcEC/EJQmbd8coK7rGHRSuYUnndyV+HEIBU8Za
	tOJfjHOeaHYBl/C3017oI4wFLo3u2BuiVgjbjB/M8b6IoN6zZH7wdqvi5jY88UwdFAqhiFhbUiu
	BXuv5XOAYkDaSd8PMNnaysukOOpA9uhUuB7GH706D674it2uMMcGcP5k9+ofJE7dCkkk=
X-Received: by 2002:a05:600c:4f05:b0:456:1e5a:885e with SMTP id 5b1f17b1804b1-45876303792mr101602905e9.3.1753695780564;
        Mon, 28 Jul 2025 02:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEingAcXyTOBXyXI2FH2HU1bPKlgnUliTyZ1KFbdz1Pmdrg7JnI9WdU+fqH+RQT9Lwk6ikS+Q==
X-Received: by 2002:a05:600c:4f05:b0:456:1e5a:885e with SMTP id 5b1f17b1804b1-45876303792mr101602505e9.3.1753695779981;
        Mon, 28 Jul 2025 02:42:59 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f47:2b00:c5f3:4053:2918:d17c? (p200300d82f472b00c5f340532918d17c.dip0.t-ipconnect.de. [2003:d8:2f47:2b00:c5f3:4053:2918:d17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b781d2fc1csm6194995f8f.5.2025.07.28.02.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 02:42:59 -0700 (PDT)
Message-ID: <9e152d8d-4b39-4a6c-93be-694a28686c07@redhat.com>
Date: Mon, 28 Jul 2025 11:42:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Disable auto_movable_ratio for selfhosted memmap
To: Hannes Reinecke <hare@suse.de>, Oscar Salvador <osalvador@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, Hannes Reinecke <hare@kernel.org>
References: <aIcxs2nk3RNWWbD6@localhost.localdomain>
 <4057479d-6ece-49a2-b823-99748e8c9c35@redhat.com>
 <273a3376-c45a-4d41-85b4-9c4f3428f268@suse.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <273a3376-c45a-4d41-85b4-9c4f3428f268@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28.07.25 11:28, Hannes Reinecke wrote:
> On 7/28/25 10:44, David Hildenbrand wrote:
>> On 28.07.25 10:15, Oscar Salvador wrote:
>>> Hi,
> [ .. ]
>>>
>>> One way to tackle this would be update the ratio every time a new CXL
>>> card gets inserted, but this seems suboptimal.
>>> Another way is that since CXL memory works with selfhosted memmap, we
>>> could relax
>>> the check when 'auto-movable' and only look at the ratio if we aren't
>>> working with selfhosted memmap.
>>
>> The memmap is only a small piece of unmovable data we require late at
>> runtime (a bigger factor is user space page tables actually mapping that
>> memory). The zone ratio we have configured in the kernel dates back to
>> the highmem times, where such ratios were considered safe. Maybe there
>> are better defaults for the ratios today, but it really depends on the
>> workload.
>>
> Point is, the ratio is accounted for the _entire_ memory.
> Which means that you have to _know_ how much memory you are going to
> plug in prior to plugging that in.
 > So to make that correct one would need to update the ratio prior to> 
plug in one module, check if that succeeded, update the ratio, plug
> in the next module, check that, etc.

I am confused. We know how big a DIMM is at the time we plug it. I 
assume you talk about CXL?

Can you describe how that workflow would look like with tools like daxctl?

(what is a "module"? A DIMM?)

> 
>> One could find ways of subtracting the selfhosted part, to account it
>> differently in the kernel, but the memmap is not the only consumer that
>> affects the ratio.
>>
>> I mean, the memmap is roughly 1.6%, I don't think that really makes a
>> difference for you, does it? Can you share some real-life examples?
>>
>>
>> I have a colleague working on one of my old prototypes (memoryhotplugd)
>> for replacing udev rules.
>>
>> The idea there is, to detect that CXL memory is getting hotplugged and
>> keep it offline. Because user space hotplugging that memory (daxctl)
>> will explicitly online it to the proper zone.
>>
>> Things like virtio-mem, DIMMs etc can happily use the auto-movable
>> behavior. But the auto-movable behavior doesn't quite make sense if (a)
>> you want everything movable and (b) daxctl already expects to online the
>> memory itself, usually to ZONE_MOVABLE.
>>
>> So I think this is mostly a user-space problem to solve.
>>
> Hmm.
> Yes, and no.
> 
> While CXL memory is hotpluggable (it's a PCI device, after all),
> it won't be hotplugged on a regular basis.

I've been told that with dynamic memory pooling it is supposed to get 
much more dynamic.

> So the current use-case I'm aware of is that the system will be
> configured once, and then it will be expected to come up in the
> very same state after reboot.
> As such a daemon is a bit of an overkill, as the number of events
> it would need to listen to is in the very low single-digit range.

I am mostly concerned with all the use cases that existed before CXL (in 
particular, virtio-mem, standby memory on s390x, DIMMs) where you see 
memory hotplug way more frequently and also would want to deal with 
things such as memory onlining failing in some environments more 
gracefully (e.g., retry).

What I realized is that
(1) udev rules are not a good for all use cases
(2) auto-onlining in the kernel is not good fit for all use cases

The goal of the daemon will be to configure auto-onlining in the kernel 
where possible (e.g., only virtio-mem, only CXL), but fallback to manual 
onlining in case mixtures might be possible (CXL and virtio-mem etc). I 
expect the latter to be rare, but sometimes we can't make a fully 
reliable decision of what might get hotplugged in the future ...

-- 
Cheers,

David / dhildenb


