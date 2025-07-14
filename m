Return-Path: <linux-kernel+bounces-730262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC02B04210
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C54A3246
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AE0257AF2;
	Mon, 14 Jul 2025 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tYsinFTu"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A142246773
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752504213; cv=none; b=dXdDsqq1QxQQi3E3om+gwHBPfAtdLSXikJQgOmQT2XmB0rN247tu2wlpzzscEfFR+H/rzTqa93SLDS9Y0kJu4M5gN76OLw2cRgbTDc4GUPfEo4vyZp+P84ntL7qicGPdQpfZDCIJYw2+p3Ehzzcbda1VeT36UixBWgPITwWFmgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752504213; c=relaxed/simple;
	bh=+NdErqoSXalIYrtUeTTaieZr8gJQiDPFDzFk2W/aqPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAvSIOI1JHI2qGUXRpsEVFfesqLfcyaQ7ZNEpb3oXbaQLWiA0S14D4WRQRF//ZNDh4ObKH7QJ/eRqGSmoXLyPJ3R6qWdDmge6hrKUpEOkfaFGMcnqR8PiFPM5VRrug1OmpO05+KQjjM2bRRW71kTW6aKylnvo7SEDsExy92UJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tYsinFTu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d54214adso30143635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752504210; x=1753109010; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tkk2ePHatcopmrnLKR6jR3UX6aWlk9GOwUaArm5vOU8=;
        b=tYsinFTusDPSHTHilP5txIO4lvaxYHJfjN716cxYVJWRH3CwBCjd5ydxPxKwpFURoz
         DOnwaWkbjaImpLAFrEHcegwJgeVN7NUCAl0mnpkwJOVFFUlopnyhDFawnyLKq0C4e19Y
         AGTe+KMx31RfXzXmZUBsOxTSygheh08XpUwe11MbZrweRZYS/3bU6MlgXl5uvcZRiG17
         ac9eeVgabDZQjEzJa/kqLaRskFPRMwM0NDzjR+hz8xQTRVlv9n3iaXestxq6PVe6H0mD
         bSRYY5BlEanyr2J+X/oXVvdFC/Jd07Yl1jhKbtAhkyIoZ1mHynNGnBSNE0MuysM1kCxB
         +ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752504210; x=1753109010;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tkk2ePHatcopmrnLKR6jR3UX6aWlk9GOwUaArm5vOU8=;
        b=RmkT2BaJOKXYzMaryVkiyWFODY36WPOlI8dCbXZKbs9Fckn/VW43RggonKAqn2vLLS
         4M1dKnVsPZaVXshn9ZPmJ8O9T6GA/e2bSpNdYs8BBgUgWzDcVFR7GziYXcUOjuysbHN2
         +kf0NYRACWjcITFgbDZvF8kb/jajx7Jtw8w7AJ2cjnbUCkyAcbiq4MkTr7BOyPhsbmnV
         xY4MTTyI55aYXIDjr6hg2h6Le6CaidbWVSp4T2Sa+E7ZdCfFUqD1v+fxzpWabec7ERc6
         fBpiDLNiVwHefTI9VhYUlyVYK5L5+TY0WtMAEO1W7MJj6CvN4dj4RwbF/pWlCQAvbq31
         8JEA==
X-Forwarded-Encrypted: i=1; AJvYcCW5pp3ZQEeax6zObsuRw0OYEZc4RGVF1zSxXJu1coZTDNLAIqXg7BHtl9060e0snvpSE0dt0FtpJw5WLdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziP1ItZBqI1uFoGv4n9bJA2qo3U8cgYNtnGC7cX4Oun9lsGRdw
	Nnzz9Yh5OHsIwF0+ZXYgQP67mxK9Hmaxs8C0ySxqUxfoiTDW7XJPUU5miJaKYJE0inU=
X-Gm-Gg: ASbGncs/+ul8MzZcOEOvHK+nQWddwwFc6bG68R1uTcw/cqXjW8tDRgWGXG7H1j1Xb9x
	xT5Hm2oHSLcpM5/tsvEbISNEO0tc1IqTo+NfTSYCC9OwIttFiSt97jpjSjKRDQlKgN5RYVemAZV
	KxINWr+NiDkotccMayXx3bV8bz5gk/DZLeR8G68K50rgejiX0qR4fTkKWX07OgnJTYn/3rjMtez
	4pHfvRM5Hpw/fF2jn/WwyJfd566t7iblgDxY3W7jS0hUny8ovuzLa5gV1LD8Ow6uZmz3QnjZZaQ
	2990omTbv+fPfU5q1XEwxorEAPbiRIbw9RdNwFCwzhFiPKSV674+/E+ho5sWwj/o6Jz2hywIjaf
	bEGE8fssEcOzAtwgeKaFC1CiX2prkYcAixcT9y5aLfzmX3eZabHAreZAbaUUhyJ0=
X-Google-Smtp-Source: AGHT+IEtm3tvKJdmPSDwmiLwsHPDpBMJTkK2dAnaXapIl0i2sB2r0hRgPP5EDIr3l5jWUsMP16oQfg==
X-Received: by 2002:a05:600c:3e0e:b0:456:2379:c238 with SMTP id 5b1f17b1804b1-4562379c49fmr14225815e9.17.1752504210032;
        Mon, 14 Jul 2025 07:43:30 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5103c2asm171484605e9.33.2025.07.14.07.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:43:29 -0700 (PDT)
Message-ID: <08261aa4-689b-4d6b-bfd2-221c1976d254@linaro.org>
Date: Mon, 14 Jul 2025 15:43:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2025 15:16, Vladimir Zapolskiy wrote:
>> +#define DEBUG
> 
> Still under debugging?..

oops thanks.

> Well, the phy should be a multimedia device, and this driver is not
> the one, thus you can not use it to connect sensors and put the IP
> into a media pipeline.
Ah no, I don't agree.
Please see my previous email.

---
bod


