Return-Path: <linux-kernel+bounces-870437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98795C0ACF4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 16:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBF91897D1F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087C2264CF;
	Sun, 26 Oct 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbhP5d2d"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04DA1F4169
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493807; cv=none; b=owLDKhLAPPwn9F2u9uqYLyQx9X2yeWXwT4YIqmDeWNXPqPLurr+naHv5a4BY0WuoNWjNuVZNN0pn39On1r9osoOUR8TaATblLT0mm7v3cpNJGHKk7rZ7havRzipAti34hwvMVShskWVhdvnMdXSmMl0l/ZG4OoAEjha2lVBtNfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493807; c=relaxed/simple;
	bh=BxE4AMPL/vcJ70cwNaercB49PFvdWpZrZz54n4I+Tss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZ2ZfPOu9eOCrjeJSK09s6L2CTnYIaKbc8k+7BbXsrHWopV6Sxx5NFVBxX6mO5Vyo/Y9RPPrdfHpDRebHS+52vLcKjtmm9+K78v4HqGZAisuJ2HroZAJ+CNaxTlNw/Li41C4tgvqudJR/EzorBJYejGtcmxxU2jWejq6rZQ+REo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WbhP5d2d; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47106fc51faso48491245e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761493804; x=1762098604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwoH7I232gTPCmP7qEpxtY2g6Hfq6kq4uW779mwS/Vc=;
        b=WbhP5d2duYs8xkDO7p8JdxampWS/y2CiGTizWyXKgdMfPqLCpnvV+VAsqSVeGVtH0g
         I3BTSqmbj9OonrEdMZhfVw5PGlQj5MnmAKq3tr1jE8aAjP1NOkUx67f5uXWlN/cuxVGa
         q3NmxRlFFW7woW6V86EkXkKC2dIK4LrxVADwtn6lzxIP+42J+TC8MDcFJ59ERCqMWHZ2
         AAu1Xu0VU2NaHsq0hoR6Juc/cfw8EYjxPvcIJYDuxdVHKr1uXH1jX9Gi1p7PaY88V/l9
         Bx6A+NDJ0sFMO2aoloiN8NGY2P+MEMIvh77xiebDeRXFWmfo3LrPj4Ccrg+TbWzUc4ck
         44iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761493804; x=1762098604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwoH7I232gTPCmP7qEpxtY2g6Hfq6kq4uW779mwS/Vc=;
        b=r2ZZqTjGoFfJuBbBZ6XVqr4sLSWsPnbCkGcXZKZh/rBigI4AykVGFBI7ylUxUFfbu+
         /Cu2UEIYM2Z/m2OvqqXSxAP1bJcD3blo0sj+ugP80vZyZ7WaKIACImp3PKaekHx/g/Xl
         dHSMFnshAkM4pksPDw9Qfjb/HTXJxRGGsv5L2bfjD61nbVs5+B3VGA+V1fNUU2Q/bYWS
         HXxeuU8beHxIFD3mRiC5f0TGuGbkaKD234PelkwcyUO4gLtzmB/O6obzG0DFeYHqyYnN
         /DtGiwggXEfkGd1zE8midynAYvYVh/vsG2gKsPBH69Z+Zy9lLc8WVjdBHyYJrmKtP1MJ
         cVtg==
X-Forwarded-Encrypted: i=1; AJvYcCWTuR+31h31JqaJbf5UBHZJOZTMsVHnjgFLwSEhteja85Ci1lGtJLL/sy9Wiz/RC062OQlkB1trzPTrwgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6VVgTsMS9Ii4LSY2zioCb5eB9SLBzzgpQheE6Z2c2xFmCH/3
	HohNpLZoYoUf6hBKF13R7edqTVK68CljJ2ZlTNK39kWTr7DX37o53dqq
X-Gm-Gg: ASbGnctXy6XRfJsl49S7zAQJOdAF01uHSOSdICNFoLm0IQWQzeAPBgwJ6ybHLvvZEwf
	y0Eflp1sAp1BlUWTs++62rlrGvzVj0kxeQ2f52w5AXspe4h5H/fVjwSq/+CQzZwLaipKwocCTNJ
	CHR/lkPWckL4LUKkZsSpn0WA6X5EULhpvtZ9AYWDry0Ij5F0kHyLWKU8Q4+Lfc0wtEroMrvGoCS
	DSXCHL+he74pjteyw5N+oF3/UszcuEWYvvV8c1QsW70I3De3FeuxcA8TBP0tR8L79/DSu/wU7xT
	BNuJeZ1ZUWf8YYqKb0kcHNl9ePxVF5uytLBNUoE/eMYXh8WxY9nnAOupkb/D7GYqR0ADRFmmT2A
	LbfjBVr98rXv8C8kVF9T4cx8z+ASgRI4uXBdv5Cm5QuBTpr6AtrQr8bmemWKUNFnP5AVLDWlWVb
	pYj4HBXcClp1Lm8QVjKO7gP5+l+uMZbX38NqN+x5ToKTkFLSutY6trfRWvX+7Ung==
X-Google-Smtp-Source: AGHT+IHkA2M3SX4HhxxTJ6SEKSHdbNns6ue18wHnx7W7S0nv87PUUK8aoI/2+ta3S9khmo30OxGG8Q==
X-Received: by 2002:a05:600c:3e07:b0:46e:4783:1a7a with SMTP id 5b1f17b1804b1-471178705bbmr270697435e9.3.1761493804087;
        Sun, 26 Oct 2025 08:50:04 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:8b21:7400:c9e:bafa:eeb1:89f7? ([2a02:c7c:8b21:7400:c9e:bafa:eeb1:89f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475de57b156sm77916985e9.13.2025.10.26.08.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 08:50:03 -0700 (PDT)
Message-ID: <0d8cd0ef-01bd-4996-a146-404a677ad935@gmail.com>
Date: Sun, 26 Oct 2025 15:50:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] samples: rust: add Rust I2C sample driver
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Asahi Lina <lina+kernel@asahilina.net>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Hung <alex.hung@amd.com>,
 Tamir Duberstein <tamird@gmail.com>,
 Xiangfei Ding <dingxiangfei2009@gmail.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20251005102226.41876-1-igor.korotin.linux@gmail.com>
 <20251005102348.41935-1-igor.korotin.linux@gmail.com>
 <b09c7c91-b801-40df-8cd8-731837ba2553@kernel.org>
 <72e286cb-7517-494d-a8ed-769b5fb8baee@gmail.com>
 <2d9a8196-8d66-4238-a807-b1ff9fd84519@kernel.org>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <2d9a8196-8d66-4238-a807-b1ff9fd84519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/26/2025 3:43 PM, Danilo Krummrich wrote:
> On 10/26/25 3:06 PM, Igor Korotin wrote:
>> Hello Danilo
>>
>> On 10/26/2025 10:48 AM, Danilo Krummrich wrote:
>>> On 10/5/25 12:23 PM, Igor Korotin wrote:
>>>> +impl Drop for SampleDriver {
>>>> +    fn drop(&mut self) {
>>>> +        dev_info!(self.idev.as_ref(), "Remove Rust I2C driver sample.\n");
>>>> +    }
>>>> +}
>>>
>>> NIT: Please use the i2c::Driver::unbind() callback instead.
>>
>> Thanks for the feedback.
>> I’ll move this into the i2c::Driver::unbind() callback.
>>
>> Should I send v7?
> 
> For such a minor thing I can usually do it when applying the patch, but given
> that for the other patch the change is a bit more significant, I'd say please
> send a v7.

Just for the clarification: by "the change for the other patch" you mean 
rebase and update this patch series based on [1], right?

Thanks
Igor

[1] https://lore.kernel.org/all/20251016125544.15559-1-dakr@kernel.org/



