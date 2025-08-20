Return-Path: <linux-kernel+bounces-777311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA603B2D813
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A98C164159
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39DF2DCC1F;
	Wed, 20 Aug 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCxWhvZn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399541A9FA1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681258; cv=none; b=EgRUTmKYRtSvPmQxM4j6VHInTW0Tp0DzWb/dj5O22wrtoWSW1cDAYcn4lUHKUBt+yXNbMHyN8bPmzWK727V+7+Nm175Nwd4VhlUxs3AzOwBUMJOdrz/20waC1b1oES/lbtCguOku2HIxVYMD70aghQpsCa/gdAljjHouDqwkYGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681258; c=relaxed/simple;
	bh=64EwTTs0Jqhe0N2PsVzbaww62Kp290alzwz6JY0DbwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qeh9i8ZAUJvvih3NHeG+XGZH/KW9R4Wxb6WJqgjLR/ZjkMzTAlD486e36xGnjsfYf/b4HM7pU/oVOjKawjzs5bltz1hycmOkKnl95aS6j2u3cOAi2SMGcPOzyBTE8PtMsS+Ou86OmO0PENF3C2tMKzBHMp9sTQNTB8n1I1AE9o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCxWhvZn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755681255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KV2kwuImpZS1M0b+LLJ3StXxExBhEfmetf7Bw7eVxpA=;
	b=XCxWhvZnuGGOHG8q/IvowHuYTJlaVmYKceD/+ChJJdm94rZSv2YmNeTxBBmAKiBfuoBWmo
	4Zb6nDhEabyTOxPSwfa/s5TM9nsGd0acjjMH8q4eWKI0eLSb9SlyQP02eqxUdn1CiZ1jm9
	MormbsCcrUICzKC4YMI/C3cvqj1Wkms=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-SHf2iE-nOceL0Sgt5DWTHA-1; Wed, 20 Aug 2025 05:14:13 -0400
X-MC-Unique: SHf2iE-nOceL0Sgt5DWTHA-1
X-Mimecast-MFC-AGG-ID: SHf2iE-nOceL0Sgt5DWTHA_1755681252
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b05d31cso26711845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:14:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681252; x=1756286052;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KV2kwuImpZS1M0b+LLJ3StXxExBhEfmetf7Bw7eVxpA=;
        b=an7+iJ6G18gclBWgz/fEDBT1456CSuqguaS54jFoza2djehj8/C6dfmdSr4QH/7rU6
         F9LiyGTbEzig9c6dW7xPrXz7CJCy3ufajdxZG0LB6XmPD0ELIReb4IflUjGs7JsLUfpr
         iuycw32BjHFrPIbVUtoccDGmoMZwuc0IvIovCpNj6UYXDaZMkO7dv9FnneHyks1qmEOM
         K153qNiyVfWxZfeVeodC7NzIbhpHEdxn30MC9e9CX+5PoMw3dKK+uL5KtxPax4X5Di25
         VW+UEdYhnNG+AjfLMiNWKT0I2j4LV7qt5GuF85z7mME/Di0LitNuVBGlcoPepWsXvYgP
         t9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO4EdfjsOaeGwDC2vtdrItP8qOobT1GNfVqzZohmCMmgw3Vhe9avERUHwfw920yBDE/WyWVGkieZhc+nU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2dWFTXDm1D5GVzVITizArvEzlajW/nnFLsO/+kCvcLGIpbKR7
	dzXRR9fUOLN83iifUB5NCKUqiaSOT9+TwM/l5wcQOMnvlhPTHwr5hC9DRPO2KHJhyPnswNv5wCx
	dFkdfhYGCmargjpzam/RJs9dfogLN3rE0nStxziHbALPG5g0HT/xiwrvHSNIZIQxZTg==
X-Gm-Gg: ASbGncvnXwW32nrkALOraypfHe+97h6xYdU6MODXcH7Gg7V/wA1+MBhr8PKeSD4cXnO
	H1wDMkK5lEG1HcRmmd2QxWAScS3YhDskMkQwL7JeVzCtQSEzEh/I3Teaw74jlWv54g8o1ybWMz5
	mH6OyoWWMMkcYiY4S4vNYC0YB88sJMHlbsPq0GJfzTUWrnqGQvSGQHjhxwnYsLB3qjMabZy4fmS
	cLV1A7Bx5XZX6pFhF9MgH+l0r817PfKWGbhEUUi1YGDHa6qGqIvyw5ziJL1lxeERIMZC6WmJQEu
	/zKtxg8iIjwVr63dnuBI2ni0td2d12DvhOO8oqx5JiEBtgSwVAER/+NxdvVpaSoazMhryJVtum/
	AQtaNTQg2HVX8DIwK8/JcVroFjEKZJ5kiOm0MjiqOvpt3Qcs46QI71BhPxQfVRzL+
X-Received: by 2002:a05:6000:40cc:b0:3c0:2f7c:faae with SMTP id ffacd0b85a97d-3c32d59d75bmr1500937f8f.12.1755681252316;
        Wed, 20 Aug 2025 02:14:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1ogNAYK45M7HThPL3z133V1jxi/C1YK6zyswt1JB+ty9xY7aaTwxzvDr8S+YygrsAqrQ8jg==
X-Received: by 2002:a05:6000:40cc:b0:3c0:2f7c:faae with SMTP id ffacd0b85a97d-3c32d59d75bmr1500909f8f.12.1755681251855;
        Wed, 20 Aug 2025 02:14:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f13:de00:e9f1:62b4:5bb:5d83? (p200300d82f13de00e9f162b405bb5d83.dip0.t-ipconnect.de. [2003:d8:2f13:de00:e9f1:62b4:5bb:5d83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c54c7bsm23414825e9.17.2025.08.20.02.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 02:14:11 -0700 (PDT)
Message-ID: <24ed0c41-6ec3-47ba-8f63-94c521df995b@redhat.com>
Date: Wed, 20 Aug 2025 11:14:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/cma: add 'available count' and 'total count' to
 trace_cma_alloc_start
To: Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
References: <cover.1755654367.git.gaoxiang17@xiaomi.com>
 <d30f91137e3a296152463ea65474e1ca56f4eda3.1755654367.git.gaoxiang17@xiaomi.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <d30f91137e3a296152463ea65474e1ca56f4eda3.1755654367.git.gaoxiang17@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.08.25 03:53, Xiang Gao wrote:
> From: gaoxiang17 <gaoxiang17@xiaomi.com>
> 
> This makes cma info more intuitive during debugging.
> 
> Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
> ---
>   include/trace/events/cma.h | 19 +++++++++++++------
>   mm/cma.c                   |  2 +-
>   2 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/trace/events/cma.h b/include/trace/events/cma.h
> index 383c09f583ac..5655ac521fb5 100644
> --- a/include/trace/events/cma.h
> +++ b/include/trace/events/cma.h
> @@ -38,25 +38,32 @@ TRACE_EVENT(cma_release,
>   
>   TRACE_EVENT(cma_alloc_start,
>   
> -	TP_PROTO(const char *name, unsigned long count, unsigned int align),
> +	TP_PROTO(const char *name, unsigned long request_count, unsigned long available_count,
> +		unsigned long total_count, unsigned int align),
>   
> -	TP_ARGS(name, count, align),
> +	TP_ARGS(name, request_count, available_count, total_count, align),
>   
>   	TP_STRUCT__entry(
>   		__string(name, name)
> -		__field(unsigned long, count)
> +		__field(unsigned long, request_count)
> +		__field(unsigned long, available_count)
> +		__field(unsigned long, total_count)
>   		__field(unsigned int, align)
>   	),
>   
>   	TP_fast_assign(
>   		__assign_str(name);
> -		__entry->count = count;
> +		__entry->count = request_count;
> +		__entry->available_count = available_count;
> +		__entry->total_count = total_count;
>   		__entry->align = align;
>   	),
>   
> -	TP_printk("name=%s count=%lu align=%u",
> +	TP_printk("name=%s count=%lu request_count=%lu total_count=%lu align=%u",

"requested_count" ?

-- 
Cheers

David / dhildenb


