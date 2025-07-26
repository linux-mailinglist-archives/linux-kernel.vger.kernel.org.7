Return-Path: <linux-kernel+bounces-746705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8039FB12A3A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D6F561531
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D998F239E8D;
	Sat, 26 Jul 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwoAFDKA"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46AA19C54B;
	Sat, 26 Jul 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753528032; cv=none; b=JYq9AGxX3ikMe0HPLjaEu/hTmwOUAu9cCLbXEJRMaAJXAgBDTR/om462I+cUh22eEEUakQKeBk6fRbLXsjtpeK8e6Uy4XL83RPl1VbnlThLrag0r+1nrkRvHCE21jqtetu02AgnUPJPSkJyCZ+l+3Rln9rToKaqi3Dy8WvGUbn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753528032; c=relaxed/simple;
	bh=gQD4wP/MZwBjNfJaUuiV6gs8Sb6uZrf6XElQOONS5ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaLCIbhx43UjsLbl9UNJms/IwK9RSA2cViar/+WefHisARRUYtUddUZCos8Zxcnl+EoX/4JDwYwWTNTiJJbBtp/yhWOmm4Tfbxs7FZlhBPkHVgTGw2zP/nqL41bcb2X9liBIo1OG/SsGqqbWbO1NuHKiLAosrgjs+2dq5I71jd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwoAFDKA; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b77a4ad84cso248925f8f.2;
        Sat, 26 Jul 2025 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753528029; x=1754132829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNa3qU18en9WzZnFesAoBlTJYBP5hk4MnfgIv/faVHU=;
        b=RwoAFDKAIcf5rCQnRy2JWyxYzYA6Wc6KyvauSpklK47QuA97NmL57d6ABcyYqJYeBs
         UaEzCqGy+3lIOIjFYlR1034JxKzfCclJ15jxVxrF21MRTTLXvnNH2PUmJ/SwAvdZkJfL
         NT4ag8CdpujiKHxPRvXcU2AZqi4E84fFHT4xRVbtXUm9LMstmaBp8fDbU9dPbUuJ3Emw
         BiVGyhw3vtWEYREuWsdWfSMGdK7KF11dTyZuyZvx7Vp7kWBPU0FVAAPjrrBerEI+2Z0I
         KRbYsWXlYFObHgTJN0en6ZpVlgdlDpY3Kovb6ST3RDcGttfVt9vLtcaCZFErMNq88zNt
         ti7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753528029; x=1754132829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNa3qU18en9WzZnFesAoBlTJYBP5hk4MnfgIv/faVHU=;
        b=xL2GzoROv+pCFJfyMT2sjpkRmzJMxU52ZWPtjfbuB8nSbhHGpL2o0sXYsdkekeYNVy
         +vWBuiNVH2EXHODW+CtstKYe1uE2az13+KzWMHnB9xg7wLsG7mQe2Vrkczu8MI8vg3sI
         sRNBWSbmsWrnxi9oARjgdId0pGng8zMjGhbkxfASvV3HshHeBUYiEkpQoj+8uuC4xcth
         quiYfZShdHAgYRxEKTGIaLDmqpxr+f2FxitZwC/VuB26OOtfb5WbpOaL4jJWeZEwsA26
         J51r46Cd6HupG6jGbnj2DVKEJfoP0Y+c8y3SOHJtmD9Uc9ud9IKz7ug5hd/B+18lHrH1
         7Rdg==
X-Forwarded-Encrypted: i=1; AJvYcCUbKETXf136FnD7OYE4cvXaP51A7g9jDOMlciQKNwWGWpGH4A42/b+zAPcStCtH82EYSRA1P302+3Yr6fA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+3KXHJeIbC5MT6WCz8FfoLgcD2sbB/3T51khVZz2/YViTDhk
	tE6DBJuE3xxhO9LjdHQr2HtnC21d3QY2bWqfDt5ZKsIZmu+QKe4hmyM=
X-Gm-Gg: ASbGncszpsdcR/u2+P67geghCAF86appusUR2wyKr/NkJ3S3m71hBBKNNDA3I2yS2Wx
	7aSvHpI7U8NE81Axm3x7gBZ7envyl7l57g3dVp1sAeDZyPYTyjH6X6TyeC5uSQDuA2zBRO61FCX
	b3Tutos5pCjGcaJUBVGqoIR/bv5dtmlpO4sJVd89T78m5ERJ9GIml/AwS3qNxZBvL4Z3LNdZd2k
	ajE6fijlmDH1bC988/uGrNj2NeEhZwgKX52+amaCjCo+fH/7GA2XJcFjqV8ufOnNDxa0Zs4Kbg1
	eMoCX4Z79apU0M9jyL02zvWSHD8MEHsZjj8LynuKupZ+lIwZHHBIqKHcjF5GkYke7Qw7envgShf
	NMIrGDvCJrXFHruSZ/llQJ9vlRKJ6esN6OnJSqYpXOjiDmvxcANWqCRQiUz//rMt1JMTf
X-Google-Smtp-Source: AGHT+IErIrHwPR1r+j+7XXM0CCTaccjvC5i4ORfw15B6NsxaP8RzwsKAVSUb6nuEIQdtcDZU3WEVog==
X-Received: by 2002:a05:6000:40df:b0:3a5:3a03:79c1 with SMTP id ffacd0b85a97d-3b776676d43mr4216161f8f.48.1753528028455;
        Sat, 26 Jul 2025 04:07:08 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:7a8a:e7b9:25b7:a4f6? ([2a02:810b:f13:8500:7a8a:e7b9:25b7:a4f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b778f03436sm2513217f8f.51.2025.07.26.04.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 04:07:08 -0700 (PDT)
Message-ID: <6f62d1a8-0e5b-4e66-bbe2-53a355df3c1e@gmail.com>
Date: Sat, 26 Jul 2025 13:07:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] arm64: dts: rockchip: Add ROCK 2A/2F, Sige1 and
 NanoPi Zero2
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: devicetree@vger.kernel.org, heiko@sntech.de, jonas@kwiboo.se,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, ziyao@disroot.org
References: <6d93c92d-2bba-4247-960d-5f2e5e12b594@gmail.com>
 <20250723134019.1076352-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20250723134019.1076352-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> Hi,
>
>> Nope.
>>
>> Are you really questioning my picture? Ridiculous ... see [0]
> No, I mean some boards of this model have SoC silkscreen RK3528 and
> others have RK3528A. The same is true for another Hinlink H28K SBC.
>
>> I'm sort of impressed on with which conviction you continue to claim
>> plain wrong things: [1], [2], [3].
> If you spend a few minutes running mainline u-boot or BSP kernel
> on your RK3528 board before blaming me:
I can't see the point here: I don't think it matters wether you or I
actually have this version on any of our boards. It exists: you may like it
or not.

This picture was actually a reply to your claim "... so we have never seen
the silk screen printed with RK3528 ... "  in your mail dated 2025/07/19.

Initially my only question was, why we don't use "rockchip,rk3528a" as
compatible when working on boards where the silkscreens says exactly that.
It was obviously copied from vendor and now it's "too late", "too
complicated" or something, idk and I'm fine with it.
> BL31:
> INFO:    rk_otp_init finish!
> INFO:    RK3528 SoC (0x101)
>
> mainline u-boot:
> ------
> U-Boot 2025.07-...
>
> Model: Generic RK3528
> SoC:   RK3528A
> ------
>
> BSP kernel:
> [    0.768514] rockchip-cpuinfo cpuinfo: SoC            : 35281000
> [    0.768990] rockchip-cpuinfo cpuinfo: Serial         : ...
>
>> I'm fine if upstream decides not to care. But it is and remains wrong
>> to claim that the other version does not exist
> Unless Rockchip says they fused the wrong OTP during production.
> Regardless of the SoC silkscreen, the chip type on OTP is the same,
> so how does Rockchip distinguish these chips?
Please read the rest of my previous reply where I sent code locations 
where and how they do.
>
> --
> 2.25.1
>
>

