Return-Path: <linux-kernel+bounces-753361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC4B181E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 14:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66ADB7A2421
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 12:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED5248191;
	Fri,  1 Aug 2025 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg8ntJJ7"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34DA2459F2;
	Fri,  1 Aug 2025 12:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754051766; cv=none; b=bdE+jEn49VfgBI0ootVbI92KBUqgx1jz0cJbbnEPCVgA+cJchgVVRuuDM+AVy3QJekFPz7ovX01imOAzedtcH+p5KFNUUHYNX6yi912yalYiLTIkJAPHj1EfgMYvR6UKZOFWbLj+HNIqZKXFC0/8VelU6nJyKR7z7Zqh+mdpKBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754051766; c=relaxed/simple;
	bh=76YrXol1VadaVpm2rSKGIHqgcLtD5umJrfw747ixCOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a7kTrqL1JSRBWTmO1qfl6YZi3AMpcd5/Ctdwvd3yHGBR0f6gYpKK+P2vUsaYC8B2HBjFZ2GYwllllwlXV7jfY0L2Dd6ac/1UBVC5ypr89iDOMgViIrmJ7FlzhJOzSZAZ7/Vonr9hAEYVbEC9DB5fjc2n7ViHXmml5rfzaJsV9l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg8ntJJ7; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so8321485e9.3;
        Fri, 01 Aug 2025 05:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754051763; x=1754656563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=76YrXol1VadaVpm2rSKGIHqgcLtD5umJrfw747ixCOw=;
        b=Mg8ntJJ7YSolFafYyjoEDGppWNaGb2UbVVi/iokFGInjPVtJInbuMtZ6PmyHefy1IW
         E0GsRUHupbTMDRt88nouWT83bxahJU2ZOjeMP3LVu8CvCl8jAZwFcYx/k/caicmytERK
         MuI2SLtAE1942RPnF/s6VWlqGwC7iOt8uVM/lXcz+/sblU0pRsn7O6rZJQ+EDHMytFIY
         c0rBhU020FU3g5wPyrK02LBmwYBRvSIqT55rwjwFh/6Vbpc8jIO7seEjPehkIHRITNp6
         N9LcyjC3GmdzJUtmSFvanVRsoWkooAHyPDChHjw6Ozrkt2nTePLqqtvG4g/l2uPvJ2bj
         wOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754051763; x=1754656563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=76YrXol1VadaVpm2rSKGIHqgcLtD5umJrfw747ixCOw=;
        b=ZQkjV0h20Xs/5flWzxfviRNTcVqoil/wyAYPp/a47rW1nOcjgTnT2BFNsMAyRutN8h
         9V79mN6lcyZuw8DPBOu2UJUPVv7yDw91Q/oLH0mOka8ylWqQCl5Efev0cU81S+SxN3Dv
         JoBJ56vxuJI4a8rfutsXDrJkUqVUyaFU2c3kJewoxC39uVOxKG3mI+CiC+3HNaihDT+c
         ISiHZv2IpSIJm3B9vkTxqABModRNrGWUAC86GYMqyL0TRnYotDH7IpsFJ1zpMWC+TDNQ
         jNrQ+aAc93HDl9QZH7zpVql9FprrETvRuxdPK7sh+9WK0HKF6TWjKh6udh9p3xghMGmA
         2sIg==
X-Forwarded-Encrypted: i=1; AJvYcCU3DtcF8bwuBLft8zu6SIM2LE9BQPLSn7rjBG6HXzBzsaY603rgdgNv2MUJ0L8K+5NEOh6Zvn7t28Tk@vger.kernel.org, AJvYcCXV0Ld5JLVa80yIrX5j0sBCIL29ratwkQA2n5MIOkG0zLybvu6yXYbmkxARHDBI564yPsuCJCE89T+Zqmq7@vger.kernel.org
X-Gm-Message-State: AOJu0YwLSGjwlos8NnROfayJ4CnTBMNzNG1DWJt8lSWmMFevYFLLXPtz
	FWgaiZrlElNRzPnmQVN4gR5HkernNFCCbB47wZAZW8IBd7v69i+P/DAS
X-Gm-Gg: ASbGncvue32SL51ELNeqXFnOhB/AH2mjCLQQ0eKQDQwN1zYuMzOiIBSCGGGo53IcxQR
	a5c+zci3PYqEZnYdDUxamgkepNvbzxWHOyIG7YiqwVdE5QjMIJMtDdyGdbN7YPlzCqPd8F/RI+k
	Np+3CdpLOjfJ1S6pFmSapuIzZ20Sf/KbS7r5k1Senk+XztfHfWVTcy2mxW01+UBRggPRX0zowbT
	oNFPuniWeps0Tyq3hlxFMMsUBfzbtFtpKPiUNLECrdhiWGdux/kdhSGxaayzjZLObTyHuA+O+lT
	rElKpAp05/rBxdFZyf9uVe3fkWp55V8jzHkwzgd8xxXB5jWNVNiaVe3PaHyNhRbtS4MOkicVpV0
	VN9v8NOoYdBhShzY7yTsSY+Pm2TaFgvfvQ0HgRA+qNhRdV0JZpg==
X-Google-Smtp-Source: AGHT+IFaCtYVTgRwZ19nJjwacjiBxot+B0gOHr5d7RezG9lzzdi5O12mr/cv+SRU8eaUlfGK7m1eYQ==
X-Received: by 2002:a05:600c:4f09:b0:458:affe:a5b5 with SMTP id 5b1f17b1804b1-458affeab35mr15788205e9.24.1754051762846;
        Fri, 01 Aug 2025 05:36:02 -0700 (PDT)
Received: from [192.168.1.129] ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458953eb7acsm100098665e9.28.2025.08.01.05.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 05:36:02 -0700 (PDT)
Message-ID: <69f6a044-be90-490f-b0ad-e7867a4825da@gmail.com>
Date: Fri, 1 Aug 2025 15:36:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/6] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Content-Language: en-US
To: Shawn Guo <shawnguo2@yeah.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>, Shengjiu Wang
 <shengjiu.wang@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Marco Felsch <m.felsch@pengutronix.de>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <20250610160152.1113930-1-laurentiumihalcea111@gmail.com>
 <20250610160152.1113930-5-laurentiumihalcea111@gmail.com>
 <aHDNmVE23O4V4rqJ@dragon>
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
In-Reply-To: <aHDNmVE23O4V4rqJ@dragon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/11/2025 11:38 AM, Shawn Guo wrote:
> On Tue, Jun 10, 2025 at 12:01:50PM -0400, Laurentiu Mihalcea wrote:
>> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>>
>> AIPS5 is actually AIPSTZ5 as it offers some security-related
>> configurations. Since these configurations need to be applied before
>> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
>> be their parent instead of keeping AIPS5 and adding a child node for
>> AIPSTZ5. Also, because of the security configurations, the address space
>> of the bus has to be changed to that of the configuration registers.
>>
>> Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
>> missing 'power-domains' property. The domain needs to be powered on before
>> attempting to configure the security-related registers.
>>
>> The DT node name is not changed to avoid potential issues with DTs in
>> which this node is referenced.
>>
>> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
>> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Hi Shawn and Mark,

> Patch 4 ~ 6 dropped from my tree due to the regression.

How should we proceed with this? The fix for the issue reported by Alexander
Stein was already picked up by Shawn via [1]. We also have [2], which is meant
to fix the Verdin issues pointed out by Mark. However, I'm still unsure about the
EVK issues reported by Mark, which I was not able to reproduce on my local setup.


[1]: https://lore.kernel.org/lkml/20250707234628.164151-2-laurentiumihalcea111@gmail.com/
[2]: https://lore.kernel.org/lkml/20250707234628.164151-3-laurentiumihalcea111@gmail.com/

Thanks,
Laurentiu


