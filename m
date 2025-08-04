Return-Path: <linux-kernel+bounces-754887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985AEB19E08
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B29FD177412
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8623E243951;
	Mon,  4 Aug 2025 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV1cvWRq"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385F438FA6;
	Mon,  4 Aug 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754297818; cv=none; b=q3OQh6wvzAxJtdUY9IlGCgyZtyznyDsaEFb9EE7XhmcTxTC3hhim6jWCY26dRmW6REPhd+ZswyoV40t3P8gt5kKXDHe/uqe5Fg7gF1xYUW48NnLEyyinnX5ZDIvNwjJEFFYWmXXerAQ53PoojpXiN/oq8MyTFA90X9K4n3k1wY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754297818; c=relaxed/simple;
	bh=3qBZn4w05JGOtMDXOQ7+xMH5EVG6nlTtM3RcZXw7U/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wm8PhuP40hfnP1TbI41dw/rGjLRzyFX0n89YWRKV7/TgsMvxpy1/0RMQ2flU4Sh+vtnII1fC6mrzo07gw7/74AZE5EnnCEev5lCyfopekZmqKbQT6nJlpHXkzxiffKcEgm/NNhDMWWtFbyn9LaLP1wl9OzHro2ycsxDlsooO204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV1cvWRq; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55b8f1a13e9so2947772e87.1;
        Mon, 04 Aug 2025 01:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754297815; x=1754902615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pl4J9DSJdPoU7MePCxJI1iZTtMOValE01c+lvXVqDdY=;
        b=iV1cvWRq0TQBLxI4CvocIpGGWi5N0aW2m6Opc7HyouGVm3EtMuyTqfVwQfK56cqEXo
         6o+vHNekCO9r0stS+Fvu3H/bDq0+yw6NPdyWeAyVZIFhqLWlOCtcvcyzBXImH/RNv/qD
         Eqhou4ragwac9fT/66seIWYsc56XSlLXUMgkUurZGSsetidQL2RFAc2F/UVcnnj/vU8h
         x9cQLYEUu6tJU8nImrOvf6JnhgzQ3KYBfy52IvofdzYuc+pzcRUJffsDqA56sZ59BKeD
         Gsw9goi5gZ3SiedXocBZFEniBFPzN5e/2QLNnWkTeN55gUZ69Q7VRMDnI7obAJEMVroa
         vo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754297815; x=1754902615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pl4J9DSJdPoU7MePCxJI1iZTtMOValE01c+lvXVqDdY=;
        b=MYCJlPSwNfkEMg918HZAMq7No3KhQlHEPZMjVRNaUztSulfroIz2OmBS0Nzv2A5ybm
         ufiJSgyG+GWKLLmUtMu8dau+mePjkfoYmRIyOJYT0V4x7t1/wHJ4wj7WHZoIYvMYEzxc
         8U+UzfK83jf8ZBvLsLNWztDbdmccrqvhENqVuW1LlMla50IxOSFtzc25pOa+dFaxTRq1
         TAMGZ2ub2/eZ4+Pp10l6Ci+YXj5uD/4f+MfOEr+hPzS/DfCXFRff3kycgq/LweTumzHp
         sdBienBqoXPaQgkPBmfGGmm/ITp5IozYZaWLwgM4cB+olJQwglNgvnn5hNycGtZUmK3A
         aHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVek5BLmlKudHyx8iTqOpBYYPRokvjf5d95rC6SlbrrSTu2Q+Y2Kq8rt0m55JcI7UyZSIRmT/Qzq5QarJ9W51g=@vger.kernel.org, AJvYcCVnEq/G2oLA7v8KssI93lGUOvbxTP+glaIgrDE7kdprRA4sAdvhWlmhwMtl1lWaQEYo1z+45kX+m6u52/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyucfyAwv4FprIxV2RxXwbf77E8HYXOCUfGcvccapxI+83Q/7lu
	MV56QOib5xKTz5PH0gbQ/GIGwJyeCFwxhfAmOxC7c4d8XWkrNTennFXm
X-Gm-Gg: ASbGncu010frimLH8CRK7OLPPcqSqIBstDuVZzG8k5nYMvzb7WkP4FujVTAZEHgm7HT
	LcgOTdSYR4p8Pe5Le5rUpP+GD9+vLQUaG2jcmJN8T/07QlZp+eJEHtx/K0TiegBUg7ybF4iLA+J
	/0LLnqPRyIta0tH64U3Dy+L7+0p7zrH0juNQtWC3e5NvK73xgdRMQzx0x/1QzKtLii31HZIDxYe
	p8x9sIh4beh+VAUBeAAW44qmBABsZCgsDLHJFNjlveYzZfnEcMNMAl/A5Rlj0eJueCjE4Av4a3q
	anlq/dfbm3SNqu7LGPA31UZUf9A44xlvsIjByryhUbMN0S6LaH+9vw/1xwNrt6wuAwoa0dDGNJ+
	RM0Guel6xHBIJ7IW01blFeP7SrzaV9a39MpVxAbLRw7hgTV/0xMh96L2loVtMG5Oms5wN1CzcSO
	c=
X-Google-Smtp-Source: AGHT+IG96iIhaKuZo/8tUym8kIXc9FXtyvOtzG3w6vbrarnj3aUq6j46ErJDofXhIYR9H+m0/as0AA==
X-Received: by 2002:a05:6512:a8b:b0:55b:945a:64ee with SMTP id 2adb3069b0e04-55b97b43789mr2299477e87.32.1754297815004;
        Mon, 04 Aug 2025 01:56:55 -0700 (PDT)
Received: from [192.168.1.146] (dsl-hkibng22-54f8dc-251.dhcp.inet.fi. [84.248.220.251])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88daec97sm1580562e87.189.2025.08.04.01.56.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 01:56:54 -0700 (PDT)
Message-ID: <676ac763-cd23-4077-815f-8eaa9bc960fb@gmail.com>
Date: Mon, 4 Aug 2025 11:56:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] rust: add initial scatterlist abstraction
To: Alexandre Courbot <acourbot@nvidia.com>, dakr@kernel.org, jgg@ziepe.ca,
 lyude@redhat.com
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@gmail.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Petr Tesarik <petr@tesarici.cz>, Sui Jingfeng <sui.jingfeng@linux.dev>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 rust-for-linux@vger.kernel.org
References: <20250718103359.1026240-1-abdiel.janulgue@gmail.com>
 <20250718103359.1026240-2-abdiel.janulgue@gmail.com>
 <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <DBK1M000P87N.2HJHDJN1LG5CA@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 24/07/2025 08:40, Alexandre Courbot wrote:
> 
> I see a few issues with the `Item` type here.
> 
> The first one is that `Page` can only be created by allocating a new
> page from scratch using `Page::alloc_page`. This doesn't cover the cases
> where we want to map memory that is now allocated through this
> mechanism, e.g. when mapping a `VVec`. So I think we have no choice but
> return `*mut bindings::page`s.
> 
Just commenting on this bit, still going through the others one by one. 
Anyways, there is already existing code I'm working on that should be 
able to extend Page that are not allocated by it's constructor (e.g. 
those coming from vmalloc_to_page). I think's it's safe at least to not 
expose the raw pointers here if we can? Just a thought.

Regars,
Abdiel

