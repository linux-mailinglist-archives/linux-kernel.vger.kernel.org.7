Return-Path: <linux-kernel+bounces-872532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 14210C1163A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98CA04E8733
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5660D2E6CD0;
	Mon, 27 Oct 2025 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8GoMllV"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0F92E6106
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 20:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596835; cv=none; b=i3pXQzR5epvK1TDH6+QSJt1QzzOOgbVSnwcxEkTeEl9Gze7BzJ5m9W1CJjVlyttYjnd1gTQ1oEoXnOTI6JBEZj7/cFws/l+flKyWbRYs98vFkT98n3faV8IE31+pbQZhSln7DoMaNtMqwUwEDR3PQ3tfMcZ3Z0rUPyNb6fyr9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596835; c=relaxed/simple;
	bh=xBIkf2s19jGAum6y/Qcw+Vx19HVghLeJgDNf8OqHxp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NrcFK2d5IY+GTzHpkKihYVoXP0b1JmMN8TASeJ5T5Id5CQlddHDQwpf/6XgFbvB9cfgN28bsk+aPW/IZmyKLRUKzGnD8U6u9kRVX5z2ExJIjih2cAQ7SHEn1HlVd/nTUGZkaOqUiAJSDd2BZEI/bGBiubJa5J49JmOeryBeRF+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8GoMllV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so51374005e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761596832; x=1762201632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/5uV+7mCTSX0N0X/xuEsWGs4nob4KyxJkGVZJZLREg=;
        b=N8GoMllVTJxvtH44E0XtDZmFLA51PqLaNaZX47a9uh5TThDodyO6SbohrZDKdsFkVf
         C0cyt997/zTmKfiJkbZYaVSZRVEyM/rjn9h56ySFzNHj9SujbhR9coGFPPzxGRwolQpa
         HsWLXXXj3vdYkjaLV/xFaKfc5s5WJuwWi4UZyCn0TAjmMxlwTdJRpkD/jgNMtY4Gs/FB
         Ch5GUN+1E1MglX2mgdfMqf/suiqy76LQ6I/2puD11W0ZZt2hn4mrs7vyaXdm75U0st5O
         dlJ523jU4QTcP/Ie8ymYf4MDE21N0RCiiXMhirBqd/Ivq+gZIh33xzoumXhiI1mxodCg
         TGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761596832; x=1762201632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/5uV+7mCTSX0N0X/xuEsWGs4nob4KyxJkGVZJZLREg=;
        b=k9ECzBhYHFuBkGzf/TovtpoQRE6GfngseCYGESX3k8PlCWNmusvAdtskVv//giMtQw
         u7yk8qq544Dloj9od1vFerKmAfa3AqhbL4YMpfD+0UDYMviwhN71dke2QAFaCUDDd1QQ
         n1YEy5BId4IttPw2/uUwp+/sjKqG2s2y2XOTyn/kHzGWnOR6xmA4lYMU/VktXHoxXdOj
         nCHqRu3Vi/zmld3y3/j3z1Gy6EUb5b/upGAFqz+TrHnzojnD36pWkGvF+zNOTEh0K8lQ
         LuLVb+/GaZsfsFPDTiiYkchGnBt/qcy1wT95pfis0QRx5i1CDVtN8sFXOa5LZ5mgm0Iv
         43Uw==
X-Forwarded-Encrypted: i=1; AJvYcCW/WIzCMft2tqFVJEYrNPP1mLruOwS49mLfoSNaFl7G/No1O8C5dEY4B0eEtB9f49DdbpXhzQnJpoCiFuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZ0+NtDvYSx+9RZIkw8inwLeJGNxkQzysXjvefJt5Rr1+4n1i
	PrEKn8WmGbiRuyELpTGd0mnHFEqiTjtQOn3xlkRQyTdM5ceIjCKYyVXj
X-Gm-Gg: ASbGncvjtrG3KqXH/G0jF8yyrxItLMo0SFCr/ecZF4eAnGimJTrBKO1cERBm5tQ87I+
	wGCgeoC2fu/e5GstZ+RGMFZleAO6RhoKRmjaGexnULdGXBxQYXorQC4L5X0f33d0xDEBEadcr4a
	yHN4jbv26Uis9jMctoaPHQ3eEM2BkdcnOKc50FFAMnddzXYzdwaD/nMzctVn3rXAdvfJF5QiZKH
	s28/5wc0G3scPSGPYknrQ9g5a8o1+T7i8H6lcTRGlUvArJERBI1QeeUDNRbn2N5e25uYAzXotVj
	k/K3wez1ADG+IPDO1ijm/JMtgHT6DCCr7csqMg97NQ410raDCoWq6GNfarUbATqxKUmHDBJll1M
	pzVzmwhOg453Z02uRm14kFMTfYNP4PdjAMA1mU8T650mqrfhJ0VXsXO/AMs5qokvlnAVf5u5SNL
	9xphdrOijXjBvNTFT4mIeA9z1fijv+VRLFclx6SwEWPHZYv29hAKPEoWcKs4sRU6ueikpwEh0Rv
	vw=
X-Google-Smtp-Source: AGHT+IH+W7nemG3RE45vFlhnndfM+ZFQsU0J3+SyKlcMM+ogPfdXhXYhwlm+aGitlh0fItjpuaJb1A==
X-Received: by 2002:a05:600c:154f:b0:471:115e:87bd with SMTP id 5b1f17b1804b1-47717e43167mr8097545e9.26.1761596831863;
        Mon, 27 Oct 2025 13:27:11 -0700 (PDT)
Received: from ?IPV6:2a02:c7c:8b21:7400:5552:7ae5:d21f:98a8? ([2a02:c7c:8b21:7400:5552:7ae5:d21f:98a8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd4a5cc4sm150799415e9.11.2025.10.27.13.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 13:27:11 -0700 (PDT)
Message-ID: <30fbb191-5300-45e9-93d3-8b2ef5cf18ef@gmail.com>
Date: Mon, 27 Oct 2025 20:27:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] rust: i2c: Add basic I2C driver abstractions
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
References: <508bd9a1-c75a-4d1d-bed7-ee759ac5a701@kernel.org>
 <20251026184143.280797-1-igor.korotin.linux@gmail.com>
 <4568187f-ab63-4c86-b327-90720ad20ac9@kernel.org>
Content-Language: en-US
From: Igor Korotin <igor.korotin.linux@gmail.com>
In-Reply-To: <4568187f-ab63-4c86-b327-90720ad20ac9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Danilo

On 10/26/2025 7:20 PM, Danilo Krummrich wrote:
> On 10/26/25 7:41 PM, Igor Korotin wrote:
>> Hello Danilo
>>
>>> On 10/5/25 12:23 PM, Igor Korotin wrote:
>>>> +impl Registration {
>>>> +    /// The C `i2c_new_client_device` function wrapper for manual I2C client creation.
>>>> +    pub fn new(i2c_adapter: &I2cAdapter, i2c_board_info: &I2cBoardInfo) -> Result<Self> {
>>>> +        // SAFETY: the kernel guarantees that `i2c_new_client_device()` returns either a valid
>>>> +        // pointer or NULL. `from_err_ptr` separates errors. Following `NonNull::new` checks for NULL.
>>>> +        let raw_dev = from_err_ptr(unsafe {
>>>> +            bindings::i2c_new_client_device(i2c_adapter.as_raw(), i2c_board_info.as_raw())
>>>> +        })?;
>>>> +
>>>> +        let dev_ptr = NonNull::new(raw_dev).ok_or(ENODEV)?;
>>>> +
>>>> +        Ok(Self(dev_ptr))
>>>> +    }
>>>> +}
>>>
>>> I wonder if we want to ensure that a Registration can't out-live the driver that
>>> registers the I2C client device.
>>>
>>> This should only ever be called by drivers bound to more complex devices, so if
>>> the parent driver is unbound I don't think I2C client device registered by this
>>> driver should be able to survive.
>>>
>>> Hence, I think Registration::new() should return
>>> impl PinInit<Devres<Self>, Error> instead.
>>
>> Maybe I'm missing something here, but as far as I understand, Devres is bound to
>> an existing device. However `Registration::new` creates new device and registers
>> new i2c_client using function `i2c_new_client_device`. Created i2c_client uses
>> i2c_adapter as its parent.
> 
> Correct, but the question is what's the correct lifetime boundary for this
> i2c:Registration.
>> The driver that declares Registration doesn't own that i2c_adapter. `Registration`
>> itself is not part of the new client’s managed resources, so returning
>> `impl PinInit<Devres<Self>, Error>` wouldn’t make sense here.
> 
> It does make sense, it's just not required for safety reasons.
> 
> This is an API that should be used by drivers operating complicated devices
> (DRM, NET, etc.) where there is no point in keeping an i2c::Registration alive
> after the driver that registered the I2C client has been unbound itself.
> 
> For instance, a GPU driver may call this in probe() to register an I2C device
> for some redriver, repeater, multiplexer, etc. So, it makes no sense to allow a
> corresponding i2c::Registration to still exist beyond the GPU driver being unbound.
> 
> Hence, besides not really being necessary for safety reasons, it still seems
> reasonable to enforce this for semantic reasons.

I might be misunderstanding your point, but as I see it, Devres cannot 
apply here
because we can't bind it to i2c_adapter. There's no guarantee that driver
owns it. Registration can't be bound to i2c_client, cause it's kind of 
chicken and egg situation.

Even if we returned impl PinInit<Self, Error>, it wouldn’t prevent other 
code from holding an additional reference to the client.
>> Drop for Registration calls `i2c_unregister_client()`, which gracefully unregisters
>> and deallocates the i2c_client.
> 
> Not quite, it unregisters the I2C client (which is why we call the object
> Registration), but it does not necessarily free the I2C client. Someone else can
> still hold a reference count of the I2C client.

You’re right, it doesn’t necessarily free the client immediately.
However, i2c_unregister_client() calls device_unregister(), which triggers
device_del() and put_device().

So while the memory may remain allocated until the last reference is 
dropped,
the device itself is already unregistered and deactivated at that point.
This aligns with the standard lifetime guarantees of the C driver model:
the structure remains valid only until its refcount reaches zero, after
which it’s released automatically.
That said, could you elaborate a bit more on what exactly you’d like to 
achieve by returning impl PinInit<Devres<Self>, Error> here?
Is the idea to explicitly tie the Registration lifetime to the parent 
device (for example, the i2c_adapter), or is this more about defining a 
general pattern for device-managed helper types in the Rust driver API?
I just want to be sure I’m following the intent of your suggestion 
correctly.

Cheers,
Igor

