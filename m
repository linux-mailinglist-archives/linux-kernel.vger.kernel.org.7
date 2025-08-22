Return-Path: <linux-kernel+bounces-782288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24230B31E57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF68F1D4190D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3F52E2DF4;
	Fri, 22 Aug 2025 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="KjzXfUhE"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98F2E92D9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875848; cv=none; b=HzkXTzA0sMR5rr9HR4RAVMQ+O2NqehOPBMUY9YU7JHw0s0sHtddJKogTGnXsUaKgsyO5rFDKbwYLV+lk0IHLYfpY3Tqn8hS6EMZqSFcCRzUDOgumQphloib2ghOdmIkLSlHp4M08mi+XWDGLanL2tF8KgrGYlCs9ll1z5BB0wtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875848; c=relaxed/simple;
	bh=qs9a/XOifb3gwYxzXNZ4bFs+sHBqoJ0U3hM8MkBb7is=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7L4wbmmLdnwkpds5jxb2YNY3jfPwHRX79620sWBpr4mJcjapwypwPNL7vDS5NR/sq3gANHcusa+xrg26GH3Rpk+IU+tt80edeXZpRm8nvPMgv7T0m8j0JjfFNxdLYHgZDlx7JBHsqTZJmVjscKvIRHvzxTbrpervZLxHC5D9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=KjzXfUhE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b05ac1eso12859255e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755875845; x=1756480645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ls62rn3dMHOmB2VTWdVw4sYol0IkmBDufKybVQiodmA=;
        b=KjzXfUhEwkzRqI4MztHDFwC5yCjTC3ygY5DcSW1hN18UpGjjk0cs8NwgfCybd4OKb3
         8IvlLKKv9NUARrbJtVzSOSZMhKc1Hr8dwqM5+bg0qGpvbC4iILFQHM35w+VhceUTT49M
         kcZQ26rveiPskfbC22UjgNLrqwTAPBM00HxJz9ujfy4F5x6PNUCL1/crkKTDjlUPxlcA
         CQkDsifuhzWcAKMIbJ4uj3jfRbQEKxXD/xtyEQcgQdZQSrQ/CINaU+EXkJiEn+b6nqEp
         hS45+/kQ+B6i6SAbGRpU0Z12IuLGKP2IXCZCRjZ8+7hGAa5VQKC8/TMuYGKyFIzNI7n5
         9J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755875845; x=1756480645;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ls62rn3dMHOmB2VTWdVw4sYol0IkmBDufKybVQiodmA=;
        b=BO6hNcqIPZvuFeDH66T2DppNItPEtZXO8B7bXvdm9HrhaxlzOsIljey5ZhziBcnYQC
         eIqUyjcgzJOKVokam25CDOb0EAaEfdYJrHsg+tVeiXUkDfnCRkxdMWMP6sbjFuVRa9dx
         +dzPcgLyAdejSKueCtbedUfxpVujVqR1/NM+cu90UZp1njbhAKlX0lZ1rhM3w4kr5Z3X
         yYsQQoWP1fYsbh0y+kwfLLYy3oo2cbUw1XjGciEQPvzXvPI/CVowFPWQRk9D1dc2WRcR
         sKaxOLZOVOpilrA7zkG3lAlZ8xsfNoWcEwDthUz8TVoGq+roekYC7yMYZ7qPvlAbNa2O
         4cxg==
X-Forwarded-Encrypted: i=1; AJvYcCXbyGJS1KIfcdOky0qrK3W37kjbmUrk8nkuBG3A3AgCITljsnB5nANrAYMRf0aThq6JnJy62cOfDsF/ylE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7SY28P/L/FlWw9nXI01icEoUQ/W3DbzablbSEvVV8olq8GTe8
	V4+fF3jYc2C0Qc0VM94b12Atkmr8UQ8hoGE6/3+P/sPKxxkJBh6RZdYGiX0dPERHMtU=
X-Gm-Gg: ASbGncuQPVcuQh+sX9lxIV1KfEYUqCX2fEUQp7ZJoSm2+FlOWJofunLFBunIAHfxxRa
	DTd+tnjGFNrn4uZPrrRMrOu7gulRa6weVet3zw7oLhK04r2lIqGXGlhJpenlTsjKDt8HBv/TjxG
	PLgTsrvw2EArerQ5Vjhi28iXOE2DQb3lwKRaML80/3/YqdKCDbQAIJjToeLkIlYpQZRFHJ5W/5V
	tID59vNzSTiZ5Kkzry5nFBj3SrLHFKY0KFcw1ai1rcGjAvnRtz9pN7r0zVjHAwnXcIZAuDfAxfF
	KxTDOAi3MZJIvxsayGtl00KtTgEMKWCBxhFNBkyKsYd+1kV7klDtqUcA20ubHdeugvam5oNWFJy
	n0KuxUBN9HPlfHnyMUqDflXz/RHoJHw==
X-Google-Smtp-Source: AGHT+IGNN9Z5/+uibhBqThaCgEQTDyJjDZ11Ocq8PmmFMqWdJekg1NPHuZJvr7YSISbg9lI0H3tDRg==
X-Received: by 2002:a05:600c:4fcd:b0:456:133f:a02d with SMTP id 5b1f17b1804b1-45b517cfe71mr35761285e9.17.1755875844711;
        Fri, 22 Aug 2025 08:17:24 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e877e3fsm38312615e9.2.2025.08.22.08.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:17:24 -0700 (PDT)
Message-ID: <93f182c7-572d-4cc6-92a3-3be48fbc3848@tuxon.dev>
Date: Fri, 22 Aug 2025 18:17:21 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] net: cadence: macb: Add support for Raspberry Pi
 RP1 ethernet controller
To: Stanimir Varbanov <svarbanov@suse.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrea della Porta <andrea.porta@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell
 <jonathan@raspberrypi.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Andrew Lunn <andrew@lunn.ch>
References: <20250822093440.53941-1-svarbanov@suse.de>
 <20250822093440.53941-4-svarbanov@suse.de>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250822093440.53941-4-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22.08.2025 12:34, Stanimir Varbanov wrote:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> 
> The RP1 chip has the Cadence GEM block, but wants the tx_clock
> to always run at 125MHz, in the same way as sama7g5.
> Add the relevant configuration.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

