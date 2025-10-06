Return-Path: <linux-kernel+bounces-843020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14835BBE39B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E978D189768D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76122D3228;
	Mon,  6 Oct 2025 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqKwDz69"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A604C1F03D8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759758596; cv=none; b=f0lgfQAfW2GDTKoYqypvEUgwKlioiG16C3qWUD901SgNQfT3jkgsumS0Vha4uIc7gDjNjbrWyWptA2vL8LYWpqkjpg08A2vwWzcR2+xuQosHXjkIEQmrJNEcY5pc4w4K3VEjUeKPg1fH/WKlFAFCXP9XoMlCKjer87/8mcCkb1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759758596; c=relaxed/simple;
	bh=naBllE4IE535a1UhrtE/NG5vtCFsBFvSt2Qvtj+AiGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kB7kmLWSnHwTH57Q2A7bJLxTcUPe/8WZqo5KO+5BcVKVzXiwLP24Y5CGkLZ47OeDCWQDpxVSj+V/8qU5LfcoRj5zGwQQk46dXdgQLTDYIUfgw0vYvpal2L3HJPi2ONf+OB3Y8V+HxDR8mPjpbk6WmJxUtS5bEywAzTNGS4HVvaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqKwDz69; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d6051aeafso52084227b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 06:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759758594; x=1760363394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=naBllE4IE535a1UhrtE/NG5vtCFsBFvSt2Qvtj+AiGw=;
        b=kqKwDz69EMTkAiOT48gl3EkdLcxLEW+2AaLRD/FgOmZAGr/u0yS2tmwWJHaZO7bj7K
         PiK/mP38jF55AT7Mxh4XzJVd2gp+hwLaC9qm8n4ej5onsIzAFgV64zlUnumPgotrIdwE
         s1CXY8DOvfgebKMJT7Z3QZA53DtpAfONZiFnEK0Q/fDQDNdhr6gkvecpruyThzpVmq6L
         Z9h0Wjcgsed+JIhMVTkdnZZpVR26sq7QTbomXALfKcPommsgmLDtWE0UeYDBgARo8PEE
         sN5itGGBkMlm2mCHNBr0fBMgjestyv8SvwW/3dkaKByjrMm2/wyMdJuNlwsJNHWCSFEM
         IdrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759758594; x=1760363394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naBllE4IE535a1UhrtE/NG5vtCFsBFvSt2Qvtj+AiGw=;
        b=XgR8b64c6OYTjWYVB+7YQRIScuXZWAi8UVYZPQYQRigzeM9OPsdO77JSUvcz63aEie
         URjKBaqptf6YnXjsPhu5SNTQ0goTjgesIk51MysH7l9Q5dJ0I7fgRKnTGOvpjZ6ETEan
         M14ICmo+PecwT2MzETlG8t6CjBVeM/rP8qvRlPa6W8ki5AWWx7ctvD+y5bC0jw1voYLt
         CS0ISistjKPuK5GuchEkHJrs/aMHKNxhg4B2y+/DDphrr6caWWwj18/TUvACURy8cIHh
         lU7i2ozzuFnUpnDgQSEvOWM+eg6bh/Ui/2xeS8UA+pdzUpC6VsFA9AdZklUo2iy88Nd5
         /6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzzK2tI+WX3w26JDOtSGpOIAWg34+3lkQwuCg/qSM3ud+5/SKvkz5SnBLC/BZguRrPKhFT8bfvxvhrcwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Bbj6MOb9n0jkq1m3yODFdvrfUCvZvfKT+gca/y70eUSV1YGx
	8z6U1MfAONcZmNB2SNb+eJElVaJar4n0ZBYnOlXKBBitkhqof8X0ghSk
X-Gm-Gg: ASbGncvOR31WaeW3t5SWqvXOuB08YGxs7Ci56vYT+lS6xvbPoAgO8Owrtq3fKur0JDN
	EHA8EWEjQaXQ3XTQ9hUgX45uZbhhgv3fbGboKVXS/s6sNZjxpV/sD3PrdkLBy3f8zQ5k8etmPeM
	/zrtR2edquVRZa4YCyrK90KfR6ggH4gLbY9rjP0NWo2eK0cx0SNcpnLPtuAYI++7MuHjJmLvxGP
	zetRwpNBpg+u9K/5f7d3oAeKCzr9HUlOb3WHCK9PwUhE8G/3AlIJdXprTfktgSqfdIuV2BYOZoW
	b69YnNBwHcz2PiOX2BTWSKZynOEk/myU5+OLNoGOXMCqW6LFz0LSSC8emywPrr6c9jT66zQUAKZ
	ErYCtjzlLodFPyaZus7W5fUj0ryDf+gV8vIItkYuaw5OmITY4KaGlsUEelYDmcvcjICEDUTc5mh
	6cODFrRaF98qtADMUoD3pQj25y53mRtg==
X-Google-Smtp-Source: AGHT+IF95I/GWMOy7K0yQH9P573Gh61Ga6VWxZPEu4GIRjFsPKAyfm6hJudD/c1aH+Spd7nOuM10XA==
X-Received: by 2002:a05:690c:f8f:b0:731:76db:a5e0 with SMTP id 00721157ae682-77f946a89e6mr163041287b3.25.1759758593563;
        Mon, 06 Oct 2025 06:49:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:6165:1c10:83e:4131:1b09:7d81? ([2600:1700:6165:1c10:83e:4131:1b09:7d81])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-77fa19a7d6asm27562527b3.55.2025.10.06.06.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 06:49:53 -0700 (PDT)
Message-ID: <51030f00-48c6-49b6-a4be-0b4e238f71bd@gmail.com>
Date: Mon, 6 Oct 2025 09:49:48 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: sukrut heroorkar <hsukrut3@gmail.com>
Cc: kernel test robot <lkp@intel.com>, Helge Deller <deller@gmx.de>,
 Bernie Thompson <bernie@plugable.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Randy Dunlap <rdunlap@infradead.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org
References: <20250924175743.6790-1-hsukrut3@gmail.com>
 <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
 <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/25 02:35, sukrut heroorkar wrote:
>>> kernel test robot noticed the following build errors:
>>>
>> Did you compile and test this code before submitting this patch?
>>
>>
> Yes, I had compiled & loaded the udlfb module with no errors. Please
> let me know how to proceed
> in this case.

Hey Sukrut,

When you make code that deletes something from the kernel, you need to
make sure that all other code that references that code will still
function properly.

When you surround things in the #ifdev, depending on the config file,
the compiler strips those things out and compiles without them. That
means that you actually need to compile and test under two conditions.
Once when CONFIG_FB_DEVICE=y and another time when CONFIG_FB_DEVICE=n.

The test robot gave you a sample config file that you can use. Please
ensure that you have the proper version of Clang on your Host machine
for that particular config file, if you choose to use it.

Also, I strongly recommend that you run the code on a sufficient
hardware or emulator after you test it so that you can verify that the
code does what you think it does.

Thanks,
David Hunter




