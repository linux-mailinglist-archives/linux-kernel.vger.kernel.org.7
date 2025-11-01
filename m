Return-Path: <linux-kernel+bounces-881510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0AEC285AB
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 19:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0B664E8BC5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 18:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD88F2FCBF5;
	Sat,  1 Nov 2025 18:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S44t0EF1"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7D27B34F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 18:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762023083; cv=none; b=TSdnXGrGbnD4uNY9TaLf25pX4tCc49MoxEpckCxnpexreON9RlRMVCtg8nVl1cIyRztiW65Bzs9UUpNnnDFgA6QgRQNl4wuVlz3JFFNBQTx3szSSt2f5yJjLp6DO5ChJ717JLqtLKx9fVNNRbnDs/f8L6nNBr1jy0SBi/KtYBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762023083; c=relaxed/simple;
	bh=U3ecrQjQv+yG3xKn7VAsf+r+odNp7rbLe5JfCrxkfYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=stko5kXLh6lFHiP6iM020njJB9xz1sDP/MhmkQxczhbfIMpN3+YHDBa+O6KSFIdyWLl6ty3JF1SgxB9SMO0HwrNsHXKAGhhtDe5wjsp7UhzOdYVLybu70B7dQhPUnrMm9g8+l4mspw50Zo+9GvSHpjTOwF+mMKqJNnuCHvNaj6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S44t0EF1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-426f1574a14so2062803f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762023080; x=1762627880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w0yBSAofgQOyjuw5PvpAMID/+vYPOzSWVbrrAKxMhQU=;
        b=S44t0EF1HOXDPfMUGt6th1OwWTKcPM0KlWohETzFJHpCGqXvaGYOzZ4KmQJQIPEz+t
         xXq9OUCRMYZH7CZjGOYcjHi3yG8mffJ16cZzG3MyclDpL3siNMJTl8PiukAMFXmGXZHM
         oWi+EvQr69N5VrT0QGlxH1CiRi3GOX5Hbn1EdJCjSWPsh5yazc0J0eeeuj3aBwaW4pSr
         Fj3BnKTki69IwMXgbfJvtXnopz9dJQH5X6Bqlqu9YCWOiWzhuq6JePFmW5gU/IitYo8w
         WFMZFK9YB9TFtCMTpyt2U3+YMy6Gd+2XBSSmrMTvm62MSFMGkj+iPd3bqz/9oJqoLkvw
         egFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762023080; x=1762627880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0yBSAofgQOyjuw5PvpAMID/+vYPOzSWVbrrAKxMhQU=;
        b=GO7R2izCggZ9UYAxoDUuARbglS63FkBW8ZLWlPdaIO/HyQN4AMaap+JdYsLWUZh6yS
         QLpnwTX9IcRD45Ar0uirENOTh4V2zQCAARqh1u26+A1vGg4Pl+F/DiO0yX6cUZeN+e9Y
         dzERdJM5ZErrKW/awK7l4PvIclV/zv+fx8F5fNlDunQAHczUo/q9agPfnOeZquMnkE9q
         NytEfkYTBMPNWVn9RJxYwZmlqcGSgyGuGPRFhl9fh6PP0BJ7dZJDROmzpVl1a8mjI4pO
         dsTdohdmBW2D59QPXc+By3kwma70iJWu0GlJTkfw8DJxBd9+lXBCRjYHfsgf2Uxb6YAA
         zkLg==
X-Forwarded-Encrypted: i=1; AJvYcCXRBvrgKQKZMlbJ8ZSXz5AZ7ghRVhzCLW/yO8GcpXFiyoJdyAoakAMqL9ZNWVZ6RD9AI5Ug3oPZZNkErWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMi9bMe4ly/RuwqBQlyX2gGu4E0+bp/NxBxH/Sh9rXmBRY9vJ6
	bcPkjVhfJ50tT71gRnJudPmoqd+LVBH17nZS9/bvSOFqgMDIz01Fp3S9
X-Gm-Gg: ASbGncsj5crH+UGBbH7w5HbtxKupWfV/vFZ4gnUUBVvyT98TEBJZUQQXyC7X3zR815Z
	ifP2LENit9nqk2Tutfn72BjU3XvREBtR9hUPAtybVQEz4pTpsu79NPVwgS6ZZSHa+sfd5tolm/3
	MDXUSewVy/0X8XD5e2/VMxHKWvSbUWtRBY0jbmEmmGxDos2tW9z67BL/6jDxLJn6o86hKfTLAuy
	N6PFcGdbwhiQpTELany5wxfHFKBWNARaBVBZyKfSiAVCRoX7RgEJAEblVQ8VqGwT19H8SfDAuDk
	nM714+S1aJF0b4/I/egej3GXNxNqFYtCegsY/Pd7Q+hZcyGFi1QaaPc8oNpUc6KzMYBd16fBm4e
	4R2OjQbs8eJ1PbmyPaErzVt9z/MYVPz/5uydoqgZ4R/sr44zJFidGfU7L24QTHa443L77t7dq1s
	6qqT0e20AqnTDxRmSuvw5KrL7ZnJpfHUXqNV2BHw9rgBUTPOxWvJ7yBqTrplZXHU2HUHwMRhiRl
	YoZ3uwvMhzIs4oF5J27YabPVVCAF+92ZMND52XuZ/wjRQ==
X-Google-Smtp-Source: AGHT+IHZnuzUsk099QOW4MOvybDJX2Pw811XdLL6RZyljGX0/ACMY03TL3YhEgmFs5GYLczbAtd9SQ==
X-Received: by 2002:a5d:5d09:0:b0:429:ce02:c883 with SMTP id ffacd0b85a97d-429ce02ca54mr2659f8f.14.1762023079376;
        Sat, 01 Nov 2025 11:51:19 -0700 (PDT)
Received: from ?IPV6:2003:df:bf22:3c00:b24b:879f:58a0:f24a? (p200300dfbf223c00b24b879f58a0f24a.dip0.t-ipconnect.de. [2003:df:bf22:3c00:b24b:879f:58a0:f24a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d8bsm10360744f8f.25.2025.11.01.11.51.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 11:51:18 -0700 (PDT)
Message-ID: <7dd6c190-2598-4a68-8431-e03e41b276ea@gmail.com>
Date: Sat, 1 Nov 2025 19:51:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] rust: Move register and bitfield macros out of
 Nova
To: Alexandre Courbot <acourbot@nvidia.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Alistair Popple <apopple@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 joel@joelfernandes.org, Elle Rhumsaa <elle@weathered-steel.dev>,
 Yury Norov <yury.norov@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Andrea Righi <arighi@nvidia.com>, nouveau@lists.freedesktop.org,
 Dirk Behme <dirk.behme@de.bosch.com>
References: <20251003154748.1687160-1-joelagnelf@nvidia.com>
 <20251003154748.1687160-5-joelagnelf@nvidia.com>
 <5a5bd549-f5b7-41ec-b493-bda427d1218f@de.bosch.com>
 <DDDQZ8LM2OGP.VSEG03ZE0K04@kernel.org>
 <DDDR8DIW6K4L.21F81P26KM64W@nvidia.com>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <DDDR8DIW6K4L.21F81P26KM64W@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09.10.25 13:28, Alexandre Courbot wrote:
> On Thu Oct 9, 2025 at 8:16 PM JST, Danilo Krummrich wrote:
>> On Thu Oct 9, 2025 at 8:59 AM CEST, Dirk Behme wrote:
>>> Assuming that register.rs is supposed to become the "generic" way to 
>>> access hardware registers I started to have a look to it. Some weeks 
>>> back testing interrupts I used some quite simple timer with 4 registers 
>>> [1]. Now, thinking about converting it to register!() I have three 
>>> understanding / usage questions:
>>>
>>> * At the moment register!() is for 32-bit registers, only? So it can't 
>>> be used for my example having 8-bit and 16-bit registers as well?
>>
>> Yes, currently the register!() macro always generates a 32-bit register type
>> (mainly because nova-core did not need anything else). However, this will of
>> course be generalized (which should be pretty straight forward).
>>
>> Having a brief look at the TMU datasheet it looks like you should be able to
>> treat TSTR and TCR as 32-bit registers without any issues for testing the
>> register!() macro today. I.e. you can just define it as:
>>
>> 	register!(TSTR @ 0x04, "Timer Start Register" {
>> 	    2:2    str2 as bool, "Specifies whether TCNT2 is operated or stopped.";
>> 	    1:1    str1 as bool, "Specifies whether TCNT1 is operated or stopped.";
>> 	    0:0    str0 as bool, "Specifies whether TCNT0 is operated or stopped.";
>> 	});
>>
>> Same for TCR.
> 
> Patch 2 of this series actually adds support for 16 and 8 bit register
> storage.

Hmm, how to use that with the register!() macro? I mean patch 2 adds
support for different storage widths for *bitfields*. But looking at
patch 4 [2] it looks like *register!()* still uses $name(u32)? With
that it looks like that the register!() macro still just supports 32
bit registers? Or what have I missed?

What I'm looking for is a way to specify if a register is 8, 16 or 32
bit. Using the example from above something like

register!(TSTR<u8> @ ....

Thanks

Dirk

[2]

https://lore.kernel.org/rust-for-linux/20251003154748.1687160-5-joelagnelf@nvidia.com/

...
+#[macro_export]
 macro_rules! register {
     // Creates a register at a fixed offset of the MMIO space.
     ($name:ident @ $offset:literal $(, $comment:literal)? {
$($fields:tt)* } ) => {
-        bitfield!(pub(crate) struct $name(u32) $(, $comment)? {
$($fields)* } );
+        ::kernel::bitfield!(pub(crate) struct $name(u32) $(,
$comment)? { $($fields)* } );
         register!(@io_fixed $name @ $offset);
     };
...


