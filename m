Return-Path: <linux-kernel+bounces-733235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D783DB07201
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 536A97B4A94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6B72EF67E;
	Wed, 16 Jul 2025 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="1luv8TCi"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6A92F2376
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658655; cv=none; b=kFIwO3AuwY7qIsZSi0Pk7iA5Nzx+JxVtZvHN3R27W8OVb/DoWXxwMT074tVb70DxISzr9pIDy0+6IxlRR54c+LlbKxFbOslmzYYzKUygdgAThuwitWEmkn7WcyfvWQfhrWUK0NyaOLhKWgM1SB0iKEx8Y0Zf0F98hQ9I8YsxbTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658655; c=relaxed/simple;
	bh=Rv1WGu71RvsH+PoMrbT5bMaAhPBIVdTsoAe+rkNha0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLWccNk1mkhbuv2MK1kbjy2HmJw6cIUlwtKLlVjpsTzFBvLdrdpNuH1nUNMaCo650tjTQq2OeQLw7Fg0z5ki+i2WYvQHWWW15qxDc4wgfVoUBiFAwLGyi22nef9uSyod+mpuoSVPyMrBhuEwWCYSl7NDCN+tP6vd0LSoa2fFMyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=1luv8TCi; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3916258f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1752658651; x=1753263451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRIwbcS0H9zdmv+BDkzGsQ7wEXHGjYbRxt2gj93AB+0=;
        b=1luv8TCinIPAqm6y0GvFkkN/Uq4zkmU7iVaZIQ1CrQMScBpSXdox/ZZ+eJS6NYIl7x
         GLdGOH3nx3rk/Z9nAWgRXbokcTJ4lqW6viKHwj376UI/fRdgKYInYZy2YVDhUg64Tr57
         KY5U3Ik0kFXcSHjHLmVj77frsjd42geFdGMOFnOFNryuzPbAQJ+f1VETun1fttVsGtQ0
         z4nnEG/L2wKHpze9JlSKJp6eKlNdQThinFuYW+CxFI0qCIfV88qugGw52koZtUWa05mI
         PSQ9lc1i91yUU6Z/Ir8/OVyIh5y6PkJUHbB42zb/kR+2fgi6IXvA8wgl4kEJU2i83Wci
         DTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658651; x=1753263451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRIwbcS0H9zdmv+BDkzGsQ7wEXHGjYbRxt2gj93AB+0=;
        b=fbqljExPiqTFyMow2tf9s9VOwx04urvKRZaA0tQok0NdJ/eWQLqrFZoysMYnwZXzy/
         QKoaGjNIeH/xBQJh+Sih6tazYFYUJBkaIL6hyuKisyu5nbMo7DvJyB1KZlu2cAt+RATc
         z1W1iq+KRl2oxbxXihOWw7enw34F1J36yR0RvEFf+bWnBtFwGYYFLI7znX8xKWGRyzeG
         /XGGoQavZAkSiogTHhLxZH4CpyZn8Yut8ZG/b0WC1mprr7nxkpmmOFxYW8SGruEIhgV7
         oaLDzaCHO+xC+A5r9jisIsM1FuCSz275J02hPIwZPMsNhnBerbb+IXwsqD9sa5YfVNMQ
         QB7w==
X-Forwarded-Encrypted: i=1; AJvYcCWSUOwreSXJwPsd7l1EFW5iPLmGXArDHbc/kQnKqTAQ9QpOUWAeyjZOkStVEOypinRWFwPjMOA2lbKYgeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8k1RF/aL25m8+JqaLJZ7F1Dp0EEtEtnJofi6UNJKbh5Yznid
	IlT+FWPD7+3u/BUBpTgeJL2tKgsXacWz5vgIgLWT+61kyanlwk51bcmQ4Km/FvtF0z8=
X-Gm-Gg: ASbGncu0mcR7K3N89JsUf+xcKhVnCjCYkmVD7YXq8S3t5Jo38R2PhWf2AXwRPKUgcX9
	PnJSLLwkk07ZJyPPZFHVCjhGyk7b8M7SxvLG85gGjW8ZCIkqE9KvMwsx/C7oTCtdWiCEfd+9yfx
	M4ol9paz9tTurL/+8sLoYdfQ2eS7MUW5M1lqoCg48fsgJjUVzN9VbWyI9rMLZzoXm6pLcuCa0Z3
	S+knVBPI8KPFQi5xKdFrOPhlj7hfi3PB+7oIoah9ZkY6L/9WQhx8khJ8C1WdQRC6WDu+JAiDtVJ
	jW04NQXLY1y6kz0q/oQUNVT3pUCQUJOWK+aYJhm9S5EzUhwiLuRVLRk0fnJU7du0ClyTR/y0n61
	wPXemLHp1HtCni4D8Y0TkDGCbBcIpzCAa2T1dbdAM8yGbj+1qzrS4NErQ/IoE9/ne6YFXadhNB1
	H8MLrqLlOfHcdIRqi3aNfu
X-Google-Smtp-Source: AGHT+IE4uVb9YKbrx3ndRNHKiFm08G4TVQtoQIPhB1Z5lx2K3LriBMWvhlHyxvUwMMKUbX/m2DA1HA==
X-Received: by 2002:a05:6000:43cc:20b0:3a5:39be:c926 with SMTP id ffacd0b85a97d-3b60dd7aab1mr1328671f8f.32.1752658651434;
        Wed, 16 Jul 2025 02:37:31 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:5da9:c53:46d0:bd62? ([2a02:1807:2a00:3400:5da9:c53:46d0:bd62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f2f28sm15619335e9.2.2025.07.16.02.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 02:37:30 -0700 (PDT)
Message-ID: <95125019-8eaa-4242-8e68-78771ce85947@hammernet.be>
Date: Wed, 16 Jul 2025 11:37:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: dts: spacemit: Add OrangePi RV2 board device
 tree
To: Yixun Lan <dlan@gentoo.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
 palmer@dabbelt.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250711183245.256683-1-hendrik.hamerlinck@hammernet.be>
 <20250711183245.256683-3-hendrik.hamerlinck@hammernet.be>
 <20250715102534-GYA542593@gentoo>
Content-Language: en-US
From: Hendrik Hammernet <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250715102534-GYA542593@gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

Thank you for the review.

On 7/15/25 12:25, Yixun Lan wrote:
> On 20:32 Fri 11 Jul     , Hendrik Hamerlinck wrote:
>
>> +/* Copyright (c) 2023 Ky, Inc */
> Copyright should cover current year, which is 2025..
> what's "Ky" stand for? Can you give a full description here
Regarding the original copyright:
This file was based on a version from the Ky, Inc downstream kernel, which
itself appears to be adapted from earlier SpacemiT sources (dated 2023).
The Orange Pi RV2 board, however, was only released in 2025, suggesting
that the Ky version was likely copied and renamed from earlier generic
SpacemiT files.

In reviewing the Ky downstream tree, I also noticed that several files had
their copyright statements overwritten with "Ky, Inc", while the original
years (e.g., 2023) remained unchanged. This makes the provenance a bit
unclear.

Since I've significantly reworked the file for the actual Orange Pi RV2
hardware, I’d prefer to attribute it under my own name, unless retaining
the original "Ky, Inc" is required.

Please let me know what would be appropriate here.

>> +	memory@0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x00000000 0x0 0x80000000>;
>> +	};
>> +
>> +	memory@100000000 {
>> +		device_type = "memory";
>> +		reg = <0x1 0x00000000 0x0 0x80000000>;
>> +	};
>> +
> for the memory nodes, there are 2/4/8GB variants from the Link [1], and
> you couldn't cover all of them in one dt
>
> besides, I thought bootloader (u-boot) will populate these info, right?
> so the above nodes isn't really necessary
>
You're absolutely right, U-Boot does populate this information correctly
at runtime. I will remove the memory nodes in the next version.

I also noticed that the aliases section is missing in this version, which
means the chosen.stdout-path = "serial0" reference won’t resolve unless
serial0 = &uart0; is defined. I didn't encounter issues during testing
because I'm overriding the boot command in my Buildroot setup, but I’ll
add the proper aliases node in the next version to ensure upstream
compatibility.

Kind regards,

Hendrik

