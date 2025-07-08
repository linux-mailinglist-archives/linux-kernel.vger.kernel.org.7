Return-Path: <linux-kernel+bounces-721339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B14AFC7DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258483A73D6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F771E25FA;
	Tue,  8 Jul 2025 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fRCTyowH"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296EF229B28
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751969161; cv=none; b=W4dR3y+FblpU9wdV4Fvbc4VFS/qPp9SAlJGYLsQD3pvZWSLD+Jm4fbVtfENXJGofsOV2XfsvOFSpmrBkriRXpBQQvdOpHRip3ghkEZzjnrsQlf0+zFSmT506vUQ8jaes8/oDpSbRzYtEYj+y1QKTjw3Am+hgmgyElgMN0aFkADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751969161; c=relaxed/simple;
	bh=npw8gRSYyPhizWIvlYkY3o8UycV4g1GzUjZZirfa4LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RuKztcCF4rqPQ7JMQcGly4P3WO89ZEJTSLFkr/XNTiTs/4FXCWTCYYTsdiYXBlXCZJBWxADQoB4V6YLzrGxcxrOTt3tiPwP1+5ap6beQFrWopM/SS0mUNzukzkvxZv2O9neSXEQvSHoyc3ZrVQV9ICoPAZsBIoMAFM3qgFSaFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fRCTyowH; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so6666102a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1751969157; x=1752573957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AFaofTBqf3jJFFOESX3JkhI6vcB/g19rZziWAPYTo4g=;
        b=fRCTyowHGO8N/wndTMW8oRBNnjcF3QarC42ddnyQ5Yjo3OVL3PgbRg1L4dARk0BV/h
         KaAbt5Ivf1fHNkXFDNLQi2TDVADEs/LjBiepF61i4RzLXiY+gP+KLb6KFBWBjY7JRrqT
         +an1vPHAj6t7eG84lSY0xpDQaybNhbi0QETS4JJrbVltAnRwbcfnFwOUOArhB/580CqH
         bgTDtVcurLM4HVr+lCb9FXxfvAKSBcukMmZCHVn5KTe3B1heoYWpmiwrulvdYX4F4a6H
         kiz3k0QVXZUtkaYC9vw3di+M82Po0HFGGHl9ZdnVCIp+9AGjjMT2GELOiySucNQepCLZ
         fG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751969157; x=1752573957;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFaofTBqf3jJFFOESX3JkhI6vcB/g19rZziWAPYTo4g=;
        b=sFPZycySPGeXkFpb6K5BnQXlx+gaDmqguFxtLCwk0rREHbCC//JudzADtIs7zdeEnp
         OsW7Q8f4y4+McDhcPDuQMKkFlJpef4phedoqpeKCrz/MnvufIpWhgo8QpUSyiTn17bBp
         2mtjrlxxel+jnvvImvJ/DGu9YbCsPvLpPW499t8XGTp7GJMUrHlRd/4cwqS31fyMgUnf
         KzBBAftLy972wFrevOnLdlEHUZSiKmSK4nwEukd4DFhrYAz28cfSmm6gtkL8qsKUpc1A
         w1YnoaCSScdX7RFK+qc8IbIkziJOR187ryviW1obOBAFrR3f6cHzh8UZC6ZBSezGKiMq
         Yajg==
X-Forwarded-Encrypted: i=1; AJvYcCXYy0mtFhdD8enA364WQiTvmIx+jAFaogh/4ZPsjOn8Rbmlj86nz1Uj9Z/zVJ/G/Jz8tx4IDtn9qfiKBd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRSS0ZadwCJUtZr15oQSD/EGI8S3am7I8JxEfnXKCyRlCF9ep
	J8aAhNfHU6PBNUeP543zjnosZ9IFi5jUwttckiZldhPJQm19vaoHwFqWEhQqzGDgdO0=
X-Gm-Gg: ASbGncv43BZ9VoNSDB1BaMWWyLSHB+tHlAqrEG/L/XGXNJWqieS/So9DR2g7oMycxNN
	9sGExw/mAamNj/LIUOHOxUSmNC9OARQpsYswb7n8wudQZRMZBp0QPuAhDSalK6VhuMgSjFEPLPI
	54QU159rIlM0CX6SxT+tp4TwjpQg5eo79MbCaEgNGJ3kGuIDStFS4NYcRd/mild/UhdfdQrhsh8
	HLDlVkhupSRnSV32BgPhrK/vIlqH91dNgnnlbrlM2UTw9Ygid4JARz67pbgBTU2L5ll/qELKkoY
	zF5hJ18M7fNajyzdCaOxxuJztl1ZuFyJwXLtYJsfh6HFg+Xec8zcYKvC2zw8VsC5QNNv7g==
X-Google-Smtp-Source: AGHT+IH1qd7qj95HCNmkjaef2cJo2Z48HEAQTcdtLEjCxkTcfgtf7esYUZor7+6jXUs9BBNtYqwt9Q==
X-Received: by 2002:a17:906:24da:b0:ad8:a935:b8ff with SMTP id a640c23a62f3a-ae3fe59934amr1264867466b.31.1751969157067;
        Tue, 08 Jul 2025 03:05:57 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1d4dsm881665066b.178.2025.07.08.03.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 03:05:56 -0700 (PDT)
Message-ID: <4f45e4d3-9b06-4669-ac1c-c277b9402831@tuxon.dev>
Date: Tue, 8 Jul 2025 13:05:55 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/32] clk: at91: clk-sam9x60-pll: use clk_parent_data
To: Ryan Wanner <ryan.wanner@microchip.com>, mturquette@baylibre.com,
 sboyd@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: robh@kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 varshini.rajendran@microchip.com
References: <cover.1750182562.git.Ryan.Wanner@microchip.com>
 <cc085ca99d75fe59c13acd74782d8437bbc1d65d.1750182562.git.Ryan.Wanner@microchip.com>
 <486d447b-9984-4044-a620-1d73ffd54111@tuxon.dev>
 <784f30a8-e524-41fb-8b14-99483116e657@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <784f30a8-e524-41fb-8b14-99483116e657@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,


On 07.07.2025 18:24, Ryan Wanner wrote:
>> Same for the rest of patches in this series following the "Remove SoC
>> specific driver changes" approach.
> Would the best approach be to make every patch atomic and change every
> SoC to match each clock function change 

Yes, this one.

Thank you,
Claudiu

> or put back in the sama7g54
> clock driver changes that where combined?


