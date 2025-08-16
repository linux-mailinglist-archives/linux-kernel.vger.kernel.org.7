Return-Path: <linux-kernel+bounces-771790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC1B28B9E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C1B1CC3BE4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 07:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B022B8A6;
	Sat, 16 Aug 2025 07:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT5WM/+n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A122FDEC
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755330600; cv=none; b=E64ZYnwD3cPurdU4HX2XiSaGLPgthBqcVMVY3bmXMIDcqERAcQulm8wbQy6Tpx9QKrp8kW1Q17yTiP4c3ahmzVEuwR6HXOSpagrsXZdp1Jc6FpzR/dAl7ciZlUg5wje5uVZGHN/nheOTqm+r9Vyc7pWR5RVjK2gVl41CQxeCr1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755330600; c=relaxed/simple;
	bh=di8An7TawaTqUEkxNGMHmelvnwSO4urqVxGLiT5rK/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxI9cxNkNfdCttOlSpw6or2kBq3f5xkMrOsnkyrz5HSXoMnOyCx5Q+dE61QYoebK8CQW6eKCUeOmnT2davXCho/yMWAWC248FMmHafnkNX8AFzOUIvUYvs6avaK9rjOLkLnpOu6plGgIdVGRzRjPws6Vn3yKXjrT41quS1DCzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YT5WM/+n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755330597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=17PhsuAKsSKCbFAc67SwRG6K2FiDsT7yekkoNHVBnxE=;
	b=YT5WM/+nakEIQeBpBCROqr6sWdEOISVSM9SyL9yxfbPyOOgyUXP9/FAs6/8GS3i8gr/lZf
	oze4xNsk/QSm9zY5t/MB/us8MpMcNj6Y4irKA7j+RWx5QWpPZFP+kHhw8nPt7LQf8U8G0M
	z6HNSdliavlPtgvSPQVCvSpg9bsEsp0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-DVeLzeEGOk-eEsvWn48vvQ-1; Sat, 16 Aug 2025 03:49:55 -0400
X-MC-Unique: DVeLzeEGOk-eEsvWn48vvQ-1
X-Mimecast-MFC-AGG-ID: DVeLzeEGOk-eEsvWn48vvQ_1755330594
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9e4146aa2so1453030f8f.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755330594; x=1755935394;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17PhsuAKsSKCbFAc67SwRG6K2FiDsT7yekkoNHVBnxE=;
        b=vPdShbg2SJPwH9G9TCtORImA/Ic1qkzAevan64qumSofAWuyHLQEyslNEPgIVQvCSd
         EgOR+bKrI7Kk91bThTKu8wBE+/Zr+W0kqM9Dbu+WUpmBHtjcmBb2MmKK75o3Hfuxho8Y
         b5uhFBqdCm42fjBut4VgXS+Bl9ruZ5Bu+lqI3ivSbZORwqSiqwh95ukyK9bJo4dKncLm
         UX/dDklrh3jg7dsCTFs/z3obbu9oED1D9k4PSqRuooFzuP82NyP1GwlpLnwxZImgnU6V
         DHgP4iDECdeEK+R8HOQ9nP/ysQp4fz/ft/g4mysB1sjbat1VsZZWnh83jA0WdEtGLxNh
         9W8g==
X-Forwarded-Encrypted: i=1; AJvYcCUuCEy7l4so3a5DEToDXd9IighRArhh8xyZjJ/xfpNDCnwYLgQ79LjQbst181bVgQy9ACoYJGYjj3KP1DQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqvNMM1hKoGfUog93t1LhNcdNJwN2iAxjX27HbPcEu9XF5gMC9
	8JA5c6cHRRB5kZ4ue5LQHNiW9YPjek4/d8gKpRoqC5SzJgsyU4xxUkaFiWbvS/WrjKx5gMN73jv
	xZHqpeCOhJbr0dLqJ5f+78A+80s6b9E5kzeaSDZnmHaRgMAX4DYRdk20WkKQTw1J+ug==
X-Gm-Gg: ASbGncvzNFs8AQyJdndeqhFdxDr4ignktV1yT9vLMQSJI/J858m5drkpi3GJU6S/gTM
	pZ0074HSyKEzLaPnl5JfB3qSffKxA0Axvuhu9fU3m4lU/tSd+PlJoJkqKkBmMX9vcbVWEos5YU6
	XGmHafBO9g/tDTN5Bpb0R9IuZNMtIoGf4NN+DX2z4J0UIALQyywnvIxyb1bldT1W7p55o3T5xKi
	XreriPCR5L8Inyqv+Hvqu33AvVc8xajIx91qzju1/V1btxwpyYqR01Ho/pp9ZAKVEzVesU9IpzU
	dAU3y6hOYe6ecjcNlIIyvLA763jE6anOL4ef/2KY4s6HwMRKS8z3iEnJk7ZZ4/VuKGuLe0/WFfl
	mUYiLF281qE8/GDOrJhy8GXrb2AR9LYJaqRIlHQy6mZcQyAAyMMF47JXKpJWuyx5yYa8=
X-Received: by 2002:a05:600c:3b09:b0:459:dbb5:399d with SMTP id 5b1f17b1804b1-45a2183d324mr35149185e9.19.1755330594463;
        Sat, 16 Aug 2025 00:49:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBpn3b3LLsYpviEIlgcbkyUmsfqPLLDuIIrOYOdct8HP+3se8zsc6xjWIyVRDTQ5Qc6vOrKw==
X-Received: by 2002:a05:600c:3b09:b0:459:dbb5:399d with SMTP id 5b1f17b1804b1-45a2183d324mr35148875e9.19.1755330593820;
        Sat, 16 Aug 2025 00:49:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm66592525e9.17.2025.08.16.00.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 00:49:53 -0700 (PDT)
Message-ID: <167acb82-1368-4c8e-89bd-8dbe4877d5bb@redhat.com>
Date: Sat, 16 Aug 2025 09:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: print total and used pages in cma_alloc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Xiang Gao <gxxa03070307@gmail.com>, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20250816042842.3959315-1-gxxa03070307@gmail.com>
 <ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
 <20250815234528.882ab58247cefc96e4137811@linux-foundation.org>
 <701bfbb4-6c12-4614-a322-def3ca923c78@redhat.com>
 <20250816003418.b2a62f6ddbcf9468fde87a18@linux-foundation.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250816003418.b2a62f6ddbcf9468fde87a18@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 09:34, Andrew Morton wrote:
> On Sat, 16 Aug 2025 08:56:47 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 16.08.25 08:45, Andrew Morton wrote:
>>> On Sat, 16 Aug 2025 08:27:39 +0200 David Hildenbrand <david@redhat.com> wrote:
>>>
>>>>> @@ -858,8 +869,8 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>>>>>     	if (!cma || !cma->count)
>>>>>     		return page;
>>>>>     
>>>>> -	pr_debug("%s(cma %p, name: %s, count %lu, align %d)\n", __func__,
>>>>> -		(void *)cma, cma->name, count, align);
>>>>> +	pr_debug("%s(cma %p, name: %s, total pages: %lu, used pages: %lu, request pages: %lu, align %d)\n",
>>>>> +		__func__, (void *)cma, cma->name, cma->count, cma_get_used_pages(cma), count, align);
>>>>
>>>> 		^ one space missing for proper indentation.
>>>>
>>>> But doing another spinlock cycle just for debugging purposes? That does
>>>> not feel right, sorry.
>>>
>>> If we're calling pr_debug() frequently enough for this to matter, we
>>> have other problems!
>>
>> We call it for each and every actual CMA allocation? I really don't see
>> why we want to just randomly make CMA allocation latency worse.
> 
> pr_debug() is 12 million times more expensive than a spin_lock()!
> 
>> Is the existing pr_debug() a problem? Maybe. But who actually has debug
>> messages enabled in any sane setup?
> 
> Nobody, clearly.  If anyone enabled pr_debug() in here, they'd
> immediately have to remove those statements to get any work done.  Kill
> it.

I just learned that pr_debug() on a !CONFIG_DEBUG kernel translates to 
no_printk(), which is just a mostly-empty macro that doesn't really use 
any of the parameters.

I would assume the cma_get_used_pages() would get completely optimized 
out in that case.

So, I don't care, but ... moving to tracing seems much more reasonable.

-- 
Cheers

David / dhildenb


