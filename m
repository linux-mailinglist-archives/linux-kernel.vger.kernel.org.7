Return-Path: <linux-kernel+bounces-791728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4BFB3BAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 14:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 839CE1C81A94
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AD73148AC;
	Fri, 29 Aug 2025 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KOA5jaaT"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912029ACC0
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469849; cv=none; b=Ts5r+UR+VWKnjZZLBmc7GNToJLa7thnJOpf0CCje9KTnax8A0MZShEDsnaqVWMU6EoKInmqL1DyV/zuerfrr6OBNICtz/CK9YgsQrLMqVqVnuUSFmY8VSc+EiWyhggh5Iv8FmU3eYxB8MTItBxom/sD8mr/UQfDjMiW6lqRDaAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469849; c=relaxed/simple;
	bh=OxQBCBaYtXRqV/nlXUYGEiK6hmFucXLwO7u1FoLHWCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XQPtDBUi7Ud1TjRxFCRiB00olFWainhbVFOHTfiDhw1r4yEUPwyulH/iNaqt06yqsFi4eaS6LFSiNqgSs71IfEYQW1hwK6fPPzIesby9vG1+FS/R1hXlzJQduiRK/9dxsMs5IUXlZtnpjuuBi2BNSzCLKu4Otw0b+wCEqXC+f2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KOA5jaaT; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c73d3ebff0so1487310f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756469845; x=1757074645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ghujH3DI//37KbeCX3UN89JJVzHmH+z7daXWxEwMXg8=;
        b=KOA5jaaT//s/QxevuadiYboUKM69pJkUFCkZOWBpecp4/KVzYS02VoGqDJgR73rCth
         2GI6PIbk6pzMf5c3qj452KIvRaRlAMsGJKCjmwynhPlbenXVlOkvMZl9N3M2kMc8Z3yU
         jCHxYkakMQk6Iiy5MoGOnefZNrHuYUstdyaFMV5Oyc512up0hOPLUvdJJSnVd5vmGRKj
         UTm2GHZyGsAQ8zpR23n7RQn/kLKkrSxZeLhtyoiE7Vf19qIPLxTbAp5eqMVaa23ej48t
         V+DQ1uypkyLvlA0RHaeApDgAb0T4G2QnJp5uBqAgp70O6v7o88KY4g3yz/ZOgoMIgfQP
         DEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756469845; x=1757074645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ghujH3DI//37KbeCX3UN89JJVzHmH+z7daXWxEwMXg8=;
        b=PtTd+sIsgpfsngGkDvdjxiv4Y26Ma18d8exUM4A1AnVchyx/Zdf15G90Ap/1+5qk0G
         kne8teJ83QtCKmBsUUDLh90Rc5EvwR5HEE6OncKvgP9HAxSRKdtM4ECSqZ8pQ9+FtbGA
         9cGPlghtoUjmbY6wd8oRr5vkIvGCjsCnhQ7VI45XN8vzIXT7EdgvkJCF2ZyEdBzY3ddF
         U2BipGz9j2/2uHYc/BHYKVSA6fWQ1xOVejl/fcOeNZLtEkXYahWSA9XVAzS7NtqS+G6f
         IIsMESwxCH5uecyvakfa7uTOPifwEI8UNma3VTqYtaFp54TJC5grkB1ORxbMb33u1DdQ
         szfw==
X-Forwarded-Encrypted: i=1; AJvYcCWCo7OQUvf2ktonDMRTBAETM8Hi8XB9RFIYrB81qFnIq/22wE8wzcgw9VNFiCvvanltA+p+P8oTMv2jgl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz965F8AzUQkP33E0CjSX2mRNeBYim/nOrs3vFzrHaZ4DBVyJgc
	SGb2gbspiBN26rBKEkiO7B7wLNdiDn1YkWfh6tvmf5akymhEaZmjatRhu3WSuk1dpMU=
X-Gm-Gg: ASbGncvc0b3SYtJBOc5cO8TtjV/Hb1qEyOppQk6fMdxA/0I8puDXko40oZyk6vkU2xt
	Jcchhzzi1h496upFRPeYAXxvzTgyCkH85XJpF3n3YpRH3eWeTqF9nZQ7WCwhqhN9rQXbTMwJdpv
	nqU8jkhfYCqGsDbyikHhOyjrg55aQ5IDK5YZF0XqJxq8cnbbG2xQ0j0yf1nr/ytVJhxgdXqx/z3
	U/hrs38HIX1To0eM1Xe9QP+QoCwQWIMCOksqbpKN6iAB7AZ+QI1EMRtPzQ/ok9XSfvPr09sX/Yy
	f5XCkcm54giQy0oi7Utcvm96VganGYbUODDR02OslIcPtcXMnDQt2eKiUZg5rjt3Gi7eLNJ4nOh
	ulmftxZJapkileC8+lnC8HP2cwZmWsZ+4I0TQon+pJI0Wl3XA9xCvqQv7mi0PiDmNurC68Zz9j4
	r2QxR+wJtJhavPWJMPlpMJ4YM=
X-Google-Smtp-Source: AGHT+IFYqGiFK1t5MMe09IWoUP29WvEbo5vkf2CXXru7AwbPHex/5v7KOICQ+I5oFXhPL1c8vkkZ4A==
X-Received: by 2002:a05:6000:220b:b0:3c5:921a:f440 with SMTP id ffacd0b85a97d-3cbb15ca670mr10835956f8f.12.1756469845102;
        Fri, 29 Aug 2025 05:17:25 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6202:f400:43c2:4394:d834:def5? ([2a02:2f04:6202:f400:43c2:4394:d834:def5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276c751esm3173107f8f.16.2025.08.29.05.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:17:24 -0700 (PDT)
Message-ID: <3731e13f-d601-4fe4-a3d2-6dd3289b6396@tuxon.dev>
Date: Fri, 29 Aug 2025 15:17:22 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Add initial USB support for the Renesas RZ/G3S SoC
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
 <aLAZprjeKtk4pusw@shikoro> <ae53d367-2ee5-49aa-82ba-86f9e84d4d25@tuxon.dev>
 <aLGGmI8bpKNVaSAa@shikoro> <be706ee5-057c-4b0a-b0d3-54ca24087f3f@tuxon.dev>
 <aLGUJbA0szYQ_gN4@shikoro>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aLGUJbA0szYQ_gN4@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/29/25 14:51, Wolfram Sang wrote:
> 
>>> Yes, I added it and it made the error go away, but still no USB. I
>>
>> The drivers are not probed or you see no activity when connecting USB devices?
> 
> Sigh, I was so sure to have checked OHCI/EHCI but only EHCI was enabled :(
> 
> Checking with the schematics, I get it that only the rightmost USB-A
> connectors on the carrier board are routed. Those two work fine now.
> 
> If that is to be expected, then for the whole series:

Yes, only those 2 are routed on RZ SMARC Carrier II + RZ/G3S SMARC Module.

> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 

Thank you for doing this,
Claudiu

