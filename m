Return-Path: <linux-kernel+bounces-834997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6C8BA5FF6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4067B1B230C8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED52E11D5;
	Sat, 27 Sep 2025 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVPoSmdD"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1042E090A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981178; cv=none; b=L6MUiTuN5sz9FZYwgx0uFk0jyPBVTfgY4fUT7QpF4dZPc8Dn2F8A4MOPfY9nQS7aK2Zitala5iNCYyNaNESRnZUC9Rvb4pnbUHhDN4D/aOQIP7PaFkv5508obYQAq+rx1uwK3ZikJbQfqusqSS8CfBqIRRivOP1ZtHvjK7B+2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981178; c=relaxed/simple;
	bh=s7xAGJVX+7/SpfJzM9KpN+ZiBOCbGQQ2hWAFAPmv8Zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3+r/8xNUEXEjmeeMq+XBe/3xDy5I0FhKZHgFzjVzUQt4hhhKzWjhfQ7xcFcz2P7QLUVG4WCJtaZ5k1aqBafNs4jsAzrnmue5F5hBROSwfwivAH3nncsY9EaXm+wCJLWxXJh+tU2u4ETyMpR91jGPJlTQ9ePSfLvMdcLrxd5nAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVPoSmdD; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b553412a19bso2375843a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758981176; x=1759585976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3sQOBC6lgm5wwqQEZglJIx1GXGiTvsN3EI8B1cA2h8=;
        b=eVPoSmdDbg2w8PLl0R/Nznkb81WBlpoW8XmYLTxqhhVBJnaIsrKmqwLUJAK/KUSAYb
         PPrCGHPlQ2p5AC10i/FlS15xW0PJlk6PwemJToXf4p0Dsr2hY/LzmFL2V+NU21I8cPW8
         GFZQhq8+YK+6yOZvFdxKTBi8JX424UTJ3Sgafm03ayPqe3QVWQ8mCduPsDbKkNUZsm+u
         ckFvBdFPjtgaKy3AmKGGNIpAyfRTLjaC3sdltJKH2tBcJaunksKPsxrbz6IM4ZNlThnO
         4W5UFm+TaXdX29lVEegYHqK0OTXfVT6xa4QOcfRht86yJj4BxC4oE8Kk2oCokkrtLbtK
         LBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758981176; x=1759585976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U3sQOBC6lgm5wwqQEZglJIx1GXGiTvsN3EI8B1cA2h8=;
        b=HvONZv+C0M3oaNFzTVirJ9c/z/Wp4Bl1emtSgbsRY2h5fLpv4z7mBk9ZAzp2ZEOiSF
         JifQTykck/7U+DyDgYQk7eDDaJJC659WUhlQdWlyMoRuUUD0JTZMpMR0Mt4hPs/LutFR
         mp+r60czKwb/5Vi5r4UKO7FxTyd/WURTgltSUBdPjiU+s7dm8dkCQU256f1KqLlFRohu
         343Wr2VQawhMqYriJo9s52vHtlyH0bh7HWD+8425AqbLFzhDyHY5XRCL0pKr6uqquxrY
         rmY+sI0IqHS4R+pmorwk1723SfbbzAhB2Cp/lvL3EN2ObBToSAFtoB/Tg6B7lvinLLEg
         aGWA==
X-Forwarded-Encrypted: i=1; AJvYcCX4I201eME4mVTimze5DMUcRCczuRtVCBG5/9g+YePPMUGikr5l4XFjokV8L4sRKT3Lvji/nzQZHnAYp/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XuZdHYiOR4LU+S9T6vEgz9EVtvBGN5vGA3ZaaahRcbVra0pU
	nEWXKVb97j5y6GdQPNlIZQ05F5lcBI75MYDGKWcl14jxJWFI6ZofSSz1
X-Gm-Gg: ASbGncs1MVf8/MhTa/+ujWQDGz7FNKi21pI+Vc9dkQH0zGD3OyGTQ9vlILv6KW+nxkB
	w8DJmtZTKezmdD55lX/7iW0neLUTPcra6okTaW848QOAzZZ+jAr/M0kmTNzJsySHOiNy2aTy5EP
	JTsVRyDU8BOsBqLDYbC1MErWX/7sUk0AJf9AFvGkqPnMlhag+43E1u6dr/X/EjXUe4sWMai3ZDs
	zGfB9yneqCLSSntf1x9hdNAylKkBU/bxLqRH9kSTF86VONJ9yN3qQnBYUjyhe5CY2aiCyIwpx2a
	4IjbVWfNhmJXGWSDVt9piEXSqk/sTwDOYDK5G8Lxyzf4qH0+A2PMNCHvD7T93sg7Q1DETSiuz+p
	H9dNUlLim
X-Google-Smtp-Source: AGHT+IGK3h2/r66srXllsDk0MF+E1eFXN/e+nA4aTq6KJiKioeHUCHrtJSdf7ekPUt2zU2bJKgRb5g==
X-Received: by 2002:a17:903:3845:b0:246:2e9:daaa with SMTP id d9443c01a7336-27ed4a09580mr134300995ad.2.1758981175683;
        Sat, 27 Sep 2025 06:52:55 -0700 (PDT)
Received: from CNSZTL-PC.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6adca51sm82134025ad.147.2025.09.27.06.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Sep 2025 06:52:55 -0700 (PDT)
Message-ID: <ad4a7dda-8f6f-4d2a-84d9-838611f2285f@gmail.com>
Date: Sat, 27 Sep 2025 21:52:51 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add devicetree for the
 FriendlyElec NanoPi R76S
To: Dragan Simic <dsimic@manjaro.org>,
 Diederik de Haas <didi.debian@cknow.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Jonas Karlman <jonas@kwiboo.se>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250922091509.2695565-1-cnsztl@gmail.com>
 <20250922091509.2695565-2-cnsztl@gmail.com>
 <DD2V17FJ29MV.3YDX1VUWGKEH@cknow.org>
 <1bb00ad6-ffe1-4783-909b-032dfb984180@gmail.com>
 <DD3EST9Y5UHF.12FJMDJUSZNYL@cknow.org>
 <d0a3d5d4480eac12ba5e2b15bcbc578f@manjaro.org>
From: Tianling Shen <cnsztl@gmail.com>
In-Reply-To: <d0a3d5d4480eac12ba5e2b15bcbc578f@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Dragan,

On 2025/9/27 21:47, Dragan Simic wrote:
> Hello Diederik and Tianling,
> 
> On 2025-09-27 09:37, Diederik de Haas wrote:
>> On Sat Sep 27, 2025 at 3:19 AM CEST, Tianling Shen wrote:
>>> On 2025/9/27 0:07, Diederik de Haas wrote:
>>>> It is recommended to use the labels in the schematics to define the
>>>> pinctl nodes (and thus their references). In quite a lot of cases 
>>>> that's
>>>> indeed the case, but not for gpio-keys (USER_BUT) or these gpio-leds
>>>> pinctls.
>>>
>>> I cannot find any specific naming rules from the gpio-keys[1] and
>>> gpio-leds[2] bindings, did I miss any update?
>>>
>>> I think this naming matches the current practice at least in rockchip's
>>> dt tree.
>>
>> There is an unofficial rule/aim:
>> https://lore.kernel.org/linux-rockchip/5360173.ktpJ11cQ8Q@diego/
>> But granted, there is 'some' inconsistency.
>>
>> And used in f.e.
>> https://lore.kernel.org/linux-rockchip/20250727144409.327740-4- 
>> jonas@kwiboo.se/
>>
>> Where you can just copy the pinctrl labels from the dts[i] and paste
>> that in the schematic document and you're instantly at the right place.
>> Which is the exact purpose of that rule/aim.
> 
> Is the schematic actually publicly available?  I tried searching for
> it, but found nothing, unfortunately.

The schematic for NanoPi R76S is available at 
https://wiki.friendlyelec.com/wiki/images/6/60/NanoPi_R76S_LP4X_2411_SCH.pdf

For more information please move to 
https://wiki.friendlyelec.com/wiki/index.php/NanoPi_R76S.

Thanks,
Tianling.

