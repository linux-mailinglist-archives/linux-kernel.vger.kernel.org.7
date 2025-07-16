Return-Path: <linux-kernel+bounces-732927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4B5B06DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF2D18913C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846382857CA;
	Wed, 16 Jul 2025 06:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAvmAHj6"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724A244666
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646795; cv=none; b=W+KLmWkyNJvTmNiDJdeLUU62EI4aY/TmaoEH+FAPt3dh1Q6wV9k0ayp/8AqbZwVq46ECfNuei3bXGWHdblcuIqVyhFYEMBY4TyNROtz7RgkJ+jMPCOtupq89Rmx2lPbAgiL1rJ/IcziOnRuPyRTyYolIs6BTzqMCUmTlhSfdgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646795; c=relaxed/simple;
	bh=N5O7Zmv+CoGIhXmzSjswUPzYw8i+fXXsX2KBPeBEbJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBXPr1DCLfdXMmnsI362yLKGAzm6nJDzByPdgy1ezCpWJ8DWe2s237Gw9FXeampux6meT8K7vSo9JPjpiv6PM0gTCiUymjzm4Sho6ogZOGc5W9qa8HODFd+oWFJ/lT2bvAHyhSYfx5JdhC9SY/Yg5EistNQ5+UAuabrHQxos7mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cAvmAHj6; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b39c46e1cfso778088f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 23:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752646792; x=1753251592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UAF6zkhihHyJEjRriO3U2GgOKlyQi3H90FYrzq25aUU=;
        b=cAvmAHj6RsTXPh+nabXG9G9ZW/8GP2pSzuTMx3vB52i522GjLDXbGjkJaSwwYBlfFg
         RUlqAvae88Ihtqx3hw2AvkG94Qnr3g9fiXbKrVfd6t0AHhNjg5OrXRDhrKVFzc87Nlwj
         LDKSSuHK2mp/55apzkC2ymlhQPt144cw+NmpE6CpXhYHN2ONMMMurOyJrwS3iS5iDhT4
         +1J7cG0dYRTp/6l7BMo0oQARIs1WTurG8lhilBsedFajBQqhVlBT77xdcOl9ojWB4jyt
         Q4nBr2naqLU6khYXXau7LwT/Z+dx7PDsF5HfRjJ2JfvVy6YyA0s4mMKz4KTBZ6ir4/mT
         yN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752646792; x=1753251592;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UAF6zkhihHyJEjRriO3U2GgOKlyQi3H90FYrzq25aUU=;
        b=q0XdX5qKw/0s+mMsmk2sbvwsu6dDVFgOkv+iNXn4CLpaJ1rdNYBarIGGRvlZS3AFRA
         1s3gufELrvIO5ouZhs8/FcoTq5MCXLJlC0Au9vzLcR0l0BCUbefYDqEqztzBu+JwjNgG
         x+ygP1QL4GPkDOhASeHuKvr2Y8mOBuivnoSms2whTXoApy1gnKQ9SYYZLErHBRYDOsoD
         dpgOgJYFf3XZAN9DZmWnuTQ2TdUOdBgoVzWXuRsCwrEZKO7cT7VbTHI30q5wYSnBuLay
         CGU7YaFYfwlVtdmCNrDEvtVXf0kjTTCe4tSYQmHEdC55xqEQRsX74oQxmJcTU3Jl4gyx
         xOCQ==
X-Gm-Message-State: AOJu0Yy2TWcBOcWpDGUa9o5J/bhmueYYhzHb858rbd8BTPswpqX69X8/
	VQ+p0gTuU/Cd7fBzjQK9L/x3lC7Vo/fGrlH4RoibeU4oiIxRiOIQw1+wKNY6iJ5phOo=
X-Gm-Gg: ASbGncu7mUdAtn/PKHaQ+Yn53rmukrxVuE44bUuyDuqqXaSINhLHRWFzIbxlrO9D1RD
	jlJt8g8yn79VaKpiqjVXdIN8iXJOzNcTF5dmAPYCfQfxUR6Doe0wATSM9iaNL+C9PdRqD7+22kL
	3Ak/KTG7kFobIrjAajgCPsH6MNmMXttvM0O6Ezx2RPm4DvVad4iBX29B90E8lOyc8x8J122HrXz
	m+W7stYAab8WezyODrHer/tOgOYGm4h5IWNYl4z04Lyoq9cjI42zDvqhJNJ3Hq5a0fnNqoz6ctJ
	ZrPsFw6G79RigSUx1/OFKsv/Hragdr2vTwKfZHAUbLBV7NyfedvO7yqKqyuDJFw+4s7m3/ooQDE
	uZn+d2oRrScdr6C4NQ6HZvbEScU5MARCwWryoMzcP9g==
X-Google-Smtp-Source: AGHT+IHI0hd/n8NAa98HjZDNO6oTeVz/r9RT2yB1ZLU6gmZTDJajNmBr9/wXERA7va12tk1kFVAPhQ==
X-Received: by 2002:a05:6000:21c5:b0:3a3:6e85:a550 with SMTP id ffacd0b85a97d-3b60dd525aemr353932f8f.5.1752646792292;
        Tue, 15 Jul 2025 23:19:52 -0700 (PDT)
Received: from [192.168.1.110] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e1e332sm16996174f8f.79.2025.07.15.23.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 23:19:51 -0700 (PDT)
Message-ID: <5a000710-516d-462f-8c0d-9e58e4abf4c3@linaro.org>
Date: Wed, 16 Jul 2025 08:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 15 (drivers/cdx/cdx.o)
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>
References: <20250715204504.36f41a8e@canb.auug.org.au>
 <b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <b2c54a12-480c-448a-8b90-333cb03d9c14@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/07/2025 03:32, Randy Dunlap wrote:
> 
> 
> On 7/15/25 3:45 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20250714:
>>
> 
> on x86_64, when
> CONFIG_COMPILE_TEST=y
> # CONFIG_PCI_MSI is not set
> CONFIG_CDX_BUS=y
> # CONFIG_CDX_CONTROLLER is not set
> # CONFIG_GENERIC_MSI_IRQ is not set
> 
> ld: drivers/cdx/cdx.o: in function `cdx_probe':
> /home/rdunlap/lnx/next/linux-next-20250715/X64/../drivers/cdx/cdx.c:314:(.text+0xc8b): undefined reference to `msi_setup_device_data'

Thanks, I can reproduce it.

The driver was never selecting CONFIG_GENERIC_MSI_IRQ and that part was
missing. I wonder why arm64 compile testing without GIC, SMMU and other
drivers, which select it, never reported it.

I'll send a fix.


Best regards,
Krzysztof

