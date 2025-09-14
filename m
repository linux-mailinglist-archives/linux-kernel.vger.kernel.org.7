Return-Path: <linux-kernel+bounces-815688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949C3B569D9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A4FE18995F6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56366246BC7;
	Sun, 14 Sep 2025 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh7Vtmgp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224F91B85F8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757861598; cv=none; b=PiwMfjeyaZaN7JMbeHJYw7XYYOXmw/uto0OfCaDuUf4Nhrk+w8bkj4yzJjPpwEUKG0C1upsM5L2kakQgY4zsDuZ91u9MCoMLQoPN/PtfY5MZCM4JHHuERC0y8rVZsORKY9BzNfq30RtIXbyyCYYckVLLY1wFX6IHM/XPkp6WbZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757861598; c=relaxed/simple;
	bh=tL6wlBCFB4vOJw5IWTJwcLT6dkp65j1Nm3PGC1bWiPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDtS7d+48Dx2ZsSrymSeMqXOTvEOzxJfCppWZYrYKSyySXkn6YnD2RDERHOj6LTJRe8/VDUPqA9bVlQvUrXOvVvtqn+yi2jdz4aS1VpK/Jzf33vO/s9ht/JRKGj2HrBGGYni5xf8+8WKcXaPHCfltEF9eRkgYaw8cCKF99+zYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dh7Vtmgp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso20557335e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757861595; x=1758466395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tL6wlBCFB4vOJw5IWTJwcLT6dkp65j1Nm3PGC1bWiPI=;
        b=dh7Vtmgp+nK4i/tMWmjBis28r4+GBo2spOyzcwtoKwcGthF+Dzix6hBNf1dUrjxopn
         daM9b+0ElFf68roOn9qQOSjMvpQXWS3s4n1p7FUSdPFglgZky9XHPhbeZexaNf8NWIi1
         z3aPGS2Fu8o9WEgHjAsOaawP7glfwVzG1NBlcLt77RQ7InmkWaI+jeeZg4TL5Wc3fEER
         Z20f7+iKJBKWCFxBvcz8zQg+7qTItXU4/qHodU7sgcexnNlcDnvBsjY4+xKy7VBC+Mzd
         jw8HcpX43Cb2gYJ8Xglyi6Ojw9g2D6R3FYIkHX63/N4EswKwcwFbqF9kkCqPrz1pT1hI
         jnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757861595; x=1758466395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tL6wlBCFB4vOJw5IWTJwcLT6dkp65j1Nm3PGC1bWiPI=;
        b=pFncxCiQUMOTUBkABxgRBkWeqHeHc67lYTMqvP13Fdazcw+wg/6xNwRddaaKYQjd2C
         IyoEwr2BSxMBJVs9Mex9jnI0ba6rf8vNMWYngR5zPiRo4WtYMUBI9bu1xM5lobNKJAIx
         3Khnpz961rkVOD0QYEyHlc70AySnUtqFPA2pkz9Hu2rF9UUDwGQ2U+hbmMP7BW/HSg5L
         EiLP+Z763Q7WRnNJnrIQoyCzDOgzcpZ3FNB66LA2p4bwCfrrWr7pkJ7dAAnj65zmRx1U
         L1jdAX6zsDjE+gGt4d0mG8UWuwoHOkIqmHmKwXQBHcrfUroBoDVU84fQC1Vnyto6qLFH
         6hXA==
X-Forwarded-Encrypted: i=1; AJvYcCXeYXw4RqyDFQqMosipY9SY7E/sMnqClJNSNAy4yiwq+3Qe4ZsIRKLlW7m73qvDN7ytex9jeRcOlmavXvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83Q+TZv8NA8Ey9lgP9yi2gOQds/YPhmGLbBFIMxteGBcpDCpn
	21ufqyOajJCjqsgHAlVC+o+gI/qO77sFO8dIK0UvEDdQWyTVFty2RLM2
X-Gm-Gg: ASbGncsRnY4ipgG+AswczPrpJGF7zGTmvAvFC/Ou9bHKBzxTRp9eBhIORMMERozLkID
	2XBFX3LTULcHEIaIge0xc5FG8IAcWAaS2jUfq7qixTI0k3UDj/cDL4kOXFQxK3Zcmd8WWY0Fk5L
	q3HYtZeGxg2KKPDo57QyRaj9MMF81gNWAmKvATts0dRDvX3xXOkSI9GzDrRyGnteGGqxxVyOexJ
	wAGy4BKvBShYwTjUper2X1SF+1P5OjFf2hPoXyFN/TFqHMmd/GSCcmgrtIWNC6/VVp5BIYjdxgx
	Cwn7LkiVJCQKmh/u26xuLBX6AJN0r3MNasXuadoegK3xNKPbLQTyxQEAAyo51nhr34f5Bpj7qWK
	+1IqKQztlVNUySsLbgoPZY8WxoWVwbHnIFYTBai3QDIefueoV8SBrsoQ5eof97krhEZ8j3+bcWi
	pxdSe8t5OrS64=
X-Google-Smtp-Source: AGHT+IHu+SHSikTbZPFSm6HoLGcMUpOh+jIhu5e1VvPHaiwyPzzxrrYzsmlOktlqxwgi0m1GZNbZug==
X-Received: by 2002:a05:600c:a45:b0:45b:47e1:ef72 with SMTP id 5b1f17b1804b1-45f21221d5bmr84887375e9.37.1757861595203;
        Sun, 14 Sep 2025 07:53:15 -0700 (PDT)
Received: from [192.168.1.103] (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e03719235sm137436685e9.1.2025.09.14.07.53.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Sep 2025 07:53:14 -0700 (PDT)
Message-ID: <a7d4d219-9f10-4c46-bf89-f0105fcb4bcf@gmail.com>
Date: Sun, 14 Sep 2025 17:53:13 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Input: add fts2ba61y touchscreen driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
 =?UTF-8?Q?Eric_Gon=C3=A7alves?= <ghatto404@gmail.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250911211910.45903-1-ghatto404@gmail.com>
 <a700b0c4-cfaa-42a5-ac87-c2bec8d9bf2a@kernel.org>
Content-Language: en-US
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
In-Reply-To: <a700b0c4-cfaa-42a5-ac87-c2bec8d9bf2a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/14/25 17:47, Krzysztof Kozlowski wrote:
> On 11/09/2025 23:19, Eric Gonçalves wrote:
>> This patchset adds support for the ST-Microelectronics FTS2BA61Y,
>> a capacitive multi-touch touchscreen controller. this touchscreen
>> is used in many mobile devices, like ones from the Galaxy S22 series
>> and the Z Fold 5. Ivaylo Ivanov wrote the driver originally,
>> and I'm upstreaming it on his behalf.
>>
> RFC means patchset is not ready, so please always mention why it is not
> ready or what you expect here.

I'm not sure if naming the compatible as it is currently is correct.
The specific thing about this IC seems to be that it's flashed with
samsung-made firmware, so I need to confirm that:
- we don't want to match compatible with the IC name (the same IC may
be shipped with different fw on other devices)
- maintainers wouldn't want us to merge it with some other driver

Best regards,
Ivaylo

>
> Best regards,
> Krzysztof


