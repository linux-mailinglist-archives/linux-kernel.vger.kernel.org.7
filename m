Return-Path: <linux-kernel+bounces-837273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67CBABD5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC201C5179
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821BE22E004;
	Tue, 30 Sep 2025 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UOX/ZHeh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB23BA3D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217557; cv=none; b=djy25sbwdK1cszoWIpZE/4uoCEpv4h/0qFMlvgNfILNCy1hDG1Tl33SFkfAT5jW6zWE+4SLm/BalQ2Gk/Y23WjkH4oO9Nvy/HNnsi//CCRXfAZKv9vw3G7FcFG8uElTMmEsqOnJiY4L+N+lkfvesNYV++4eg4vFFT0n3BZ8TkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217557; c=relaxed/simple;
	bh=LSJgZ2k4kElpwy/HyK+EMEHJoHsGvbnjGGOha0cBPTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1gpvhO6YmvKem2r/hiKskImolDUWe7ruHvzex64uI1XTK6zG0mX6nOE1SZVz6IJFQnApS1B+QLmNrK7BxNiTOQHLCfdgKG4LW9DdzkxB9xxKgPIWigqzoV57/5Yf7mNJsPG69YcerQs5eDfU/7c3NnC7mT4n707Z0Tdcfzqyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UOX/ZHeh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759217555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kx5kJD47lwmwEdMug0EQxUJ+vdmo/Qnc4VmJ84EJ4d0=;
	b=UOX/ZHehliwyePGx2Szef/b3VoDmfLQdhvuxbmcnxNTv7Q0ZWMKJ+OT970AZhkLJ6UWfIt
	TWseXhxqihZ5f95gkkiK/4auRIDdhpSP6+trnTc0R8iXQ9MKaBICevjZtR/kKvqunjZoyN
	HY2HZ+g7dvNw1Y6/TtvtaQ7ZOWBM8GA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-3DHNUBkYPq28F2zXwKzS8w-1; Tue, 30 Sep 2025 03:32:33 -0400
X-MC-Unique: 3DHNUBkYPq28F2zXwKzS8w-1
X-Mimecast-MFC-AGG-ID: 3DHNUBkYPq28F2zXwKzS8w_1759217552
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso11822355e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217552; x=1759822352;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kx5kJD47lwmwEdMug0EQxUJ+vdmo/Qnc4VmJ84EJ4d0=;
        b=s8XYJ4PRG7NbR5p+JJt3Md3Vb/5fbkLgM+SGnxvyvLbmMqS90EFeoUnxJ66MycKZWe
         7lqoG50ozxpj3KyuyptW6zmRO6+ETnx2W4EIWMv5IWxAdKajVL7GaoA2x8bKXUCEXwEU
         WF6q7VoljjG2KU88j6+rC77iAGSFJOnzIpnGJpTV9U+da5o6fJKmU2TiGsMyssahu6Am
         FyJ/WIloq7AX+/cPqH7lOP9WpQ4wyKURHFRBd9C1hOV0DYX1NKjs97FarBTDBMeS2ANe
         PzSPUxxwUms3DsAJmbMxs5ljO5IUDyNs65k/u4kQyfQD4HpSDvzJbY3XUOwfcALnKa3F
         2ong==
X-Forwarded-Encrypted: i=1; AJvYcCXnVGQZOiOHfzkCLCY+uYWVJyH+RMEhOhqa73R6eInGOELTwBu2UnCJLnOkNpDnj4Y+tZqk/Zdej5BRupc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys7J9DyTDdqSwcDvf5/S9zeeQgOGfgITES+NxUgAD8666F3Yqx
	t9MYo1DeBE/CFqaAP/CarAZR7rriQNUu0509IrjqwipsrCszx9nUO/A3J2u3KaO1tLfi2J2UE7W
	N/bPKVJTozxWT7Lk80EJoFva24hwswyGaQMcM5f/yYcsS22YACmzBgL6RKGGQ5BT12g==
X-Gm-Gg: ASbGncuaNHuG3KwwJHBWgRSNMd5k8ubPLPGIklwDQW4Iw8Hv5L8z0Jx23OdQFjRtVkA
	YnYpRklEXORQH+JxAwqtBp85OVHUX+0ImYgNA6p/hsbFXwMz2qfhdU0VKBDNf1AMLbXDSRvflyS
	b6n+7DF+B85L7H9L3o3oBVigt++hYc81zK7Iuxs7+hKb/NpZ6loTcoMcfYjCtf4sjaA/by35WE7
	YWfeyGg2FfWCk6a8DRMsB4+9EWQ+tF9Iqs1eUdxNCfG/MQ78UyT3kHx39b4IvkOnJacrpiH99yY
	2fG/j1QcoWXppb5DZBEZUym06TJcrr1ggNdZmC7R3pq3tfTUnHOHpn6Zjw7b6iXauU2KfzIMr6M
	bF3h3kr9c5Q==
X-Received: by 2002:a05:600c:3b10:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-46e3299a5aamr165320495e9.7.1759217552124;
        Tue, 30 Sep 2025 00:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4B7drdL4EeWrqkWa+uMSppFVKBycAsK4wlNYE6Vh0G6TeYmxyF48M7zZXFvsuApXLRvCrnQ==
X-Received: by 2002:a05:600c:3b10:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-46e3299a5aamr165320325e9.7.1759217551698;
        Tue, 30 Sep 2025 00:32:31 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:acad:d401:ae54:edf3? ([2a01:599:901:4a65:acad:d401:ae54:edf3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e56f64849sm43391315e9.11.2025.09.30.00.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:32:31 -0700 (PDT)
Message-ID: <02c8cf41-116d-46ab-9d40-803cc26dbbf8@redhat.com>
Date: Tue, 30 Sep 2025 09:32:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/ksm: fix spurious soft-dirty bit on zero-filled
 page merging
To: Lance Yang <lance.yang@linux.dev>
Cc: xu.xin16@zte.com.cn, chengming.zhou@linux.dev, ran.xiaokai@zte.com.cn,
 yang.yang29@zte.com.cn, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ioworker0@gmail.com, akpm@linux-foundation.org
References: <20250928045207.78546-1-lance.yang@linux.dev>
 <e74ae9da-9dfb-4673-ae9f-c0b27b796cf0@redhat.com>
 <8476e9be-3f80-4d7a-9a38-f910661e61c6@linux.dev>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <8476e9be-3f80-4d7a-9a38-f910661e61c6@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29.09.25 12:08, Lance Yang wrote:
> 
> 
> On 2025/9/29 16:25, David Hildenbrand wrote:
>> On 28.09.25 06:52, Lance Yang wrote:
>>> From: Lance Yang <lance.yang@linux.dev>
>>>
>>> When KSM merges a zero-filled page with the shared zeropage, it uses
>>> pte_mkdirty() to mark the new PTE for internal accounting. However,
>>> pte_mkdirty() unconditionally sets both the hardware dirty bit and the
>>> soft-dirty bit.
>>>
>>
>> Right, that's one think we should clean up at one point.
> 
> Got it. I’ll take a look when I get a chance ;)
> 
>>
>>> This behavior causes false positives in userspace tools like CRIU that
>>> rely on the soft-dirty mechanism for tracking memory changes.
>>
>> IIRC, false positives are not a problem. We get them all of the time
>> when merging VMAs etc.
> 
> Right, Indeed.
> 
>> So I am not sure if this here is really worth fixing. Soft-dirty is not,
>> and never will be false-positive free.
> 
> Makes sense to me. It doesn’t seem worth the trouble to fix. Let’s go
> ahead and drop it.

Yeah, I would prefer if we can just decouple soft-dirty from dirty 
handling at some point. I recall I had a use case around 
PageAnonExclusive at some point.

-- 
Cheers

David / dhildenb


