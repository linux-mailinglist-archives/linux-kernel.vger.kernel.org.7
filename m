Return-Path: <linux-kernel+bounces-861606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 81836BF32BF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7734FA908
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D8E2D4B40;
	Mon, 20 Oct 2025 19:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iB564wGI"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D5225394B
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760987890; cv=none; b=nr/4mnuvfv9F7CV+nvo7aw+6FkxzXU8xaguPgWSTRzEe+EPC+gbWmLkDH54un+Xjlne9Q/4Z3mllwJFxmYqZL1ZPBunb2KwfkR+WfssrYgHR2zJCFH+Pgo5M32sZE2pGJdujUQ2UFwZlWdoTk3epbFM4rs3lP0xNDsefDJqig9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760987890; c=relaxed/simple;
	bh=B2GwWQHb2WNCqgXU+VsEpJ51dyfQjF+xpMUj0xTobyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SCCB7PhczSVqze3yiH3gcTJnK/mVN3Dpah97fMjZWL9T6zt5Oqx42VwqS1f67kHbT1nFVlywpOgcRD4miqpR9s9zgE8ZEwheuHg/GpmAAcGElyT6jmwNvoBcksWIAHrT6MU/kIxJhgkTtp9KDOWEt+Rg4uAty2Tpnbf94/y9c1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iB564wGI; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee130237a8so3082749f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1760987887; x=1761592687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0tsx4KSP77ESIlhthvIKVZRSnX72ewIM/q8+bWb71E=;
        b=iB564wGIPE/WtHO8W6lGQdxqfEpDskJ2S9chg50uyVzySvufkfOldJvvFuwmuWQEnm
         gAGJPMIvM82mwdAPTaH4471CpNK9PaffUsjaceyxnGOVygfKCufQlY5wnLM9kJwwdc2t
         IIBjln+kDrqE0MniMQAyrqTNLEif7vSVN0sjMYpCOZfWjYV3djviGkC+k7zCDN8Ie8SR
         ZIUsmQqRdzuSxy8zWLkAmAwUSuyYzYKCF0hSVY8BbvIJ/Bb67TgIDqR/uBWZwm5Uosxo
         m/gp+DCd+2SWvsrLn7yCs1CdBQHUJ4r9ykSYi+qoY10VnvHW/9iaIw6o3uE9IueTXLyD
         lfow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760987887; x=1761592687;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0tsx4KSP77ESIlhthvIKVZRSnX72ewIM/q8+bWb71E=;
        b=w5a8JV74Kc1xJTUdz2CLWdJahl8NyvI0mRPg/Fh9Rvyf43Ynbc+t2rcXAJ7CpqUx5C
         tpUWqp8BKL48WI6bSEdqEykZfEg4sSKF3PswswerQvlk0JSGzNzuMxIz6SsGoJUdSkhl
         Tt+GFbROM2MZKRoadx7arX5tvw2v/vfKdWQYEc1dPz9pG0S+BxbJwtbHer+wNsVl3byH
         HNexLFJlisQElZnX/q/2BH9vO2cvjGZKGvhNZYGrm5I2in7Dr/QqbnTMdbLsR8lnta0N
         4+rBtSnz/bYYkVcnpycJ8Od4EhgbHpRW1d7JZtTuGpv5gICA8xbGy8pKbbY/JtCvXo0f
         kpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPNUAMBBzsURQv9mSh/L5Era26TOQW5G7hxaHyAwNlwA+0zZGx6pLMiwkI5YBO4vq6LOoH8pe7Aw+0nkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAFjWRNiUiHWLhLvzBenKl6grFS+Lz7wFvyZz1qYtSSWhWh17
	IwC+LOiteraIJ/VOJvlLo2xXp3FMTyhadDpwtLYSpeBm1zI8aJr7JJx4fgMVu4ToyjQ=
X-Gm-Gg: ASbGnctRA7xTAsb6oPVlBFFRGIooKXinGoY+kphLkqARQ18OSamLWO/GCUCQPAj/OnS
	Auu1/fQFomxDGZfMe+sWomhPDXG90QtQa54DQ2MzO+bAWXXlJga/oWS/5/wIl5ED+cSbzHhhb2p
	vQgTbj268FhEZPJScISG2u7ZT7NcOPfuV6oy4gXJRSTukJ9REw69HHzjN+SOLwOjNWk/mMXDNvh
	gStlqDi2e1KCORk0wnnpDmJADnvjUDXXAmTzwA5sL7PSr5GwO+yguvaOGq+nudWiUVYfJtiWU/T
	uvcNAU1+XZ5iXasNOqS0f1GX/+cHp9jEUSyDs/IA0jYaFonokN2+TR36PIW1fZ7ZSSCEka1hgXf
	Vtu4Oxa7iIyTm8xoF159iU6nHJ5J4tc1Bvv376Zucm/LBrcOxhXhitsElfm0lvj9K7aeGeLVEFy
	btEenYpBBg2DwLunIMhQQ=
X-Google-Smtp-Source: AGHT+IFcgqnPdm4nc9BDRoT2IcMx9OPGQN7Qu5Edx1CiNPuj1x/M7ZsidNWYx587c0BBZFL+lcxA7A==
X-Received: by 2002:a05:6000:702:b0:427:51d:1177 with SMTP id ffacd0b85a97d-427051d1222mr8232140f8f.8.1760987887446;
        Mon, 20 Oct 2025 12:18:07 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a976sm16913232f8f.32.2025.10.20.12.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:18:06 -0700 (PDT)
Message-ID: <e9358bd4-c972-4fb0-a11b-fd562e885ac8@tuxon.dev>
Date: Mon, 20 Oct 2025 22:18:05 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/32] clk: at91: clk-audio-pll: add support for
 parent_hw
To: Ryan.Wanner@microchip.com, mturquette@baylibre.com, sboyd@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robh@kernel.org
References: <cover.1752176711.git.Ryan.Wanner@microchip.com>
 <bb2fe895daeeb0815452213a437bf2c9e3f6ebcf.1752176711.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <bb2fe895daeeb0815452213a437bf2c9e3f6ebcf.1752176711.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Ryan,

On 7/10/25 23:07, Ryan.Wanner@microchip.com wrote:
> From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> 
> Add support for parent_hw in audio pll clock drivers.

s/parent_hw/parent_data. Same for the patch title

> With this parent-child relation is described with pointers rather
> than strings making registration a bit faster.
> 
> All the SoC based drivers that rely on clk-audio-pll were adapted
> to the new API change. The switch itself for SoCs will be done
> in subsequent patches.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---

