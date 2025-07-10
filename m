Return-Path: <linux-kernel+bounces-725116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF33CAFFAF9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B598C1C2746C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49928853D;
	Thu, 10 Jul 2025 07:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IQynHqge"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F743288512
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132848; cv=none; b=lAd8RIRjnYBhLgW47Ok/q95FNPdRjuOs6XjHgTlDaJ47Bi45PnT/5pmLHvIZBazxaUbiUQaJUkG9L4P7sK5sG0tob9/FvmXP1cUXSrh+JMkL/Fwg7LrO8HRt81A8qGtToyqWVkRc2EIyFJJgWaMCkq5jK4GQ/L0YrHiuao12g30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132848; c=relaxed/simple;
	bh=vHRxZ7iR9VbaXp7pjVioRMGXRK5cXAtuCkY7JdlvtY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ibVQWFProbEViXhbKiivqrmnW3oWysblczikHSDJFogP0/bDVPlWyA0+bDbR7PSiq7nKNR7/Sjtmdacdq8z8l2tHBZgcvGDl8q4/tTtrQEXStfc/a4vEMJOYJSnuFTVOhHAJ48hBTu7rKtwTqDtLfh8tvcqo3v8d5lTkxnRh4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IQynHqge; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae35f36da9dso123051566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1752132845; x=1752737645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JawF4TGF1j57LNBqwF7f46NzGiGmOvF3HoWhyY7xlVw=;
        b=IQynHqgemBYN/P4qlpKmd79Bj5ITfLKyGAdNOAcJJLmTwhEoXTLrCQVCgE+Esgfap+
         RSiEs6SbTe6C8xNt+WgX9PpydLmnbh5LFNAKhzpLceeKYlRYv2r/iYGsqXBDtEVBfIwV
         GJRFWWakY2JqvE7o0fVGec0Sy1xpC2fNUwrElCtYPbj/ID+5ZsD2C5pfhjobBRBPC4e4
         JSnMk1WDRCpE9rxbjj2QS49FFccEkY7q5ElyVPb1ltRx3DUvDvap/hCURdAzpWMelyf3
         qWQDxpRFpWjxcl6z5QG0Dz0KnN/B7ruz1/zk/mA0bmk7guqNvypwk5008FjzuzRSZiZq
         YDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752132845; x=1752737645;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JawF4TGF1j57LNBqwF7f46NzGiGmOvF3HoWhyY7xlVw=;
        b=Iy+rKvXAnJb6INHy7gfiQmbO0Ab5jmPy03bu9Cpt28PNpqRQRXi6RYgaDy1fRTLG1L
         7j8Jbc/B8jPvV7VsnGPOeJM9duOGAty5FWqYnkHTXozMFzctPIHpeocpe/5BZXuuKpMh
         yeBunMipggu0owryrrBAackD9z2IZoOWc8Udeg9PpMEtYFDH+F0scoU8W4P7fB7jZ8P2
         KpXrII2lfz2pAWPnCAT2yEDdUFqd8wS9Mx2PuQxoRn3aRGESmRBDICaHf8eJBm6P2frQ
         qzDeSvRN+Afx4acwcv1av2Ox4odnQ4WKdqQvE/iaDrDeHu3K35mUAZWuE9TZVV3uS85X
         V8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXre+ExSnnpw8m3dGn40yXNuiRw1XmsHb0gzk5KOxI/9S49fzPkhFrQM81rdzknzVKX1R3CWsg/43jZPxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFNuND7eOI1X8Wrrl41E1SiRkj9lh0ZCIK6FFs4XasgKiGKvy
	eBV17FEPxnx7d0qPJj+x0Jpxfxa3NaR17duyYgRl9zP99gl9iUfnu5jwnGOZiVVld1s=
X-Gm-Gg: ASbGncvCCjpi+nIkZWfgtBf8x9wgNtyIv1N9xPosb197fhuiFLF+t/er0dJHZyaZWW8
	4im5FJi7HCUoJ+u+ayS4ul1oOtRdVWc44RcL9AFQRXHuOT7pzUc1uh/yqKfTVuMJjkkH/g5NqTp
	YJ/eigr48/2kS0Txe5aKKOC6P0tkc+RktPUYIfB3rqZHLuQZEDgF53KQq7TxXtPqpZ7rIpB2BuE
	hdLVZk8TesUkLhz7rKyKbc2cdquffOucz4gnaehtqyZUx8XShdEee0gcISvLq7CYmw5oRBNFsT+
	slW48KBFSjT6cbHJ2IA8PQXLCyiiZCRYyZffrQUTbIVPa2yzuXwIkjZosNM1Y8lkEk/J0vpMeYz
	k0aQh
X-Google-Smtp-Source: AGHT+IGPe11W59uO1omcl8GyG58pyhcK7ZXWq168g/SLScHSinvdniJYkRnoIhmYDGQWOP0mBpiX6A==
X-Received: by 2002:a17:907:3e24:b0:ade:35fc:1a73 with SMTP id a640c23a62f3a-ae6e70f48ffmr163003566b.55.1752132844772;
        Thu, 10 Jul 2025 00:34:04 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82dedd3sm81643566b.150.2025.07.10.00.34.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 00:34:04 -0700 (PDT)
Message-ID: <31ee6752-a898-4cef-b339-9991d9df1580@tuxon.dev>
Date: Thu, 10 Jul 2025 10:34:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add cache configuration for Microchip SAMA7D and
 SAMA7G MPUs
To: Mihai Sain <mihai.sain@microchip.com>, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250619070636.8844-1-mihai.sain@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250619070636.8844-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.06.2025 10:06, Mihai Sain wrote:
> Mihai Sain (2):
>   ARM: dts: microchip: sama7d65: Add cache configuration for cpu node
>   ARM: dts: microchip: sama7g5: Add cache configuration for cpu node

Applied to at91-dt, thanks!

