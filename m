Return-Path: <linux-kernel+bounces-737811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC232B0B0DB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8CD85652D7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3201A23313E;
	Sat, 19 Jul 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAlWG7i5"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C9B1EB39;
	Sat, 19 Jul 2025 16:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752941270; cv=none; b=NdvXr0uTF30moI+6ulQd/He56kWjXpexDUz37DvcFYEVehavNcM2rBzc1vJoXFPeSoFm2+swJPtdUXjxHlCZyFvXRIhkm6va/Zue2rkMXSow1aBwjNwI1A0PMJoAsP5yPmx1Oov6XFgHXM2LcFP7XjCkejjpp+7mgMgLGW4ll00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752941270; c=relaxed/simple;
	bh=34Fl013avGLIxojThvGclQvDHH9D0XOpk1JKH4QnB8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZedV3cF6BxJ+FBoGi7ARuAqEOu/pFHD5/qK+AivVuq3M6Rx9N/lDQ3GHIgE+gmas3OiBMygIy1isarw4stBdzMY5iB88bVDMiurcuM+ayDJYpM9CnlBRIh0xjUuhmp+AS3UetA92mUZwW6o8trTP4p70GlUNA2NvE37C3AwG7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAlWG7i5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so30851285e9.0;
        Sat, 19 Jul 2025 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752941267; x=1753546067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=34Fl013avGLIxojThvGclQvDHH9D0XOpk1JKH4QnB8s=;
        b=IAlWG7i5+uSQE/V6QfoDU9XhihguJNjJEHNDuhxNyHpPXABVXbAAMGjNqTUsEeA8Up
         mWD/QAf32si3bIkYTqjQ+iGJUqqshnZxzNXNSze/9xET7x6GzzA+Nds9DAUcBXR//4OG
         74ZOz1EAAXEi/142Tm+5EFTVdalPBiHfeTGl4ytV8KTO3WFlfm5bYmiL3zZ6xlcXkBAF
         rbLmUfatijVXtfRuUq7BBAobOlRBfLUDVd7vgLgpbftwEkZnXMVdBOUeMjOlKDd2l1hR
         lb3dG79neM5CWNcYPy8jGe19rjDq3oOQhtnKeqCMuSmkwEy98YygNvH5NgEBCE5nWGFU
         XuaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752941267; x=1753546067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=34Fl013avGLIxojThvGclQvDHH9D0XOpk1JKH4QnB8s=;
        b=qX6/uvtvwM2YxPD841dE5fNzGZtZ6MimxciFy3BTTk1uq38zQsB+wT4DprzKKaECjS
         qw98nWOlupTcwiIJzOelC0K745vm5tQ2/I8vC3hGCQ0nROdHNgB8GeNppqGn58Cp+VIP
         U0/hhO1ex2u45rw3f8vB0Eau4zFmYtKD3b59aHuajsYP/45md4HDDeYlEojiwvrAZGC1
         DAnr/JByRmOhD0TMHaGlAEqKB4M+yMa6mlZB9q+P76rh09cn3gCR7xV2rDRRNccg/oMr
         AsVpGIVyMTpdC5MxP9eiXcj/YhE6qPqPxPre01c2P15ZuXX3i6pcBX2z8r3gFTvpBbAL
         o0Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU2DqR2poYF5bjHG1RL+W4B1aLb12VNZpqHkwKyZKwL9CkwBNUmEhdvozJ50OwspiZ42YYyNSpuLIZ4rk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP5lfnxTx8qc5j31pX1b6V56dO0XG91xhs2W6oz6d8cP0nUC8R
	t5Q4tO9xDS0bz6XuqsPT8c11KJkfvnKAvKoV4FPR8Wnr5zadX1CsnGE=
X-Gm-Gg: ASbGncvM8LhVJZdwJEfz+ow/C4gqUXT1CX1TKqliWl04S84YG0nOQ/LceecVnE0hZ/R
	Gm0V/CfcM4AIzEhchrxPkIAj5q0hD4hThJvWr2XG4lgsXeUFtBliLXbzaFH3aCEahDuI9Y7vJ4W
	U4lyaxXCaUx9X81iVt/lIVcRL/46TqQmv2mkcYY52X9LXsFu97WYT6Yos7TJH9lzyStZbE6AibE
	hEGq0osZeOz0DY9jEO0kM8boDL+jNY94BRvlvXqZspUK7EhRSs8hJMBrZg4iYMzLefa8/JuqSz2
	sor2fggNE2yTqb/Pgcru0VT1Y4fLwON76ouOFF3OaKc1xSRbJ4iPtaU9hg09hSZup2mLFRfU/Rf
	of8NsTG1cJ/Inze+qUo7pAPnaJHfz3AwnUMLIqJ4shOfoVtFc2S/1rcZNkOO1nJonwBOozvedX2
	lw
X-Google-Smtp-Source: AGHT+IES9oPDKMYKkdduvhO3yIdGJjlII97bZjjl594Nemv+AquGEt84ATf4PGSkJI2nAQVKAHXu9g==
X-Received: by 2002:a05:600c:1c88:b0:455:fc16:9ed8 with SMTP id 5b1f17b1804b1-4562e3b9144mr146586165e9.30.1752941266695;
        Sat, 19 Jul 2025 09:07:46 -0700 (PDT)
Received: from ?IPV6:2a02:810b:f13:8500:9864:6cd6:911:3e03? ([2a02:810b:f13:8500:9864:6cd6:911:3e03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f4289sm110158655e9.7.2025.07.19.09.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Jul 2025 09:07:46 -0700 (PDT)
Message-ID: <24ef5e60-dcea-4102-b87f-8a5572c7497f@gmail.com>
Date: Sat, 19 Jul 2025 18:07:45 +0200
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
References: <104a501d-b9b2-494e-b073-932ddadd7129@gmail.com>
 <20250719143008.54288-1-amadeus@jmu.edu.cn>
Content-Language: en-US
From: Alex Bee <knaerzche@gmail.com>
In-Reply-To: <20250719143008.54288-1-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Hi,
>
>> The issue I was seeing is that there actually *is* a variant called
>> 'RK3528' which at least according to the latest datasheets slightly differs
>> from 'RK3528A'. We are doing development based on 'RK3528A' and calling it
>> 'rockchip,rk3528' which might make it hard to add the non-A-variant in
>> future (unless we call it 'rockchip,the-actual-rk3528').
> I think this can be ignored, because rockchip only provides RK3528A chip.
> RK3528A should be a revised version of RK3528, which solves some bugs,
> so we have never seen the silk screen printed with RK3528.
Thanks for sharing that inside.
I wonder why there's an v1.4 of "Rockchip RK3528 Datasheet" dated
2024-05-12 which differs from v1.4 "Rockchip RK3528A Datasheet" dated
2025-05-12. Anyway: If everybody is happy as-is I guess it's fine.

> Thanks,
> Chukun
>
> --
> 2.25.1
>

