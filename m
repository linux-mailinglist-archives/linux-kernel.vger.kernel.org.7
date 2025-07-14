Return-Path: <linux-kernel+bounces-730346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B713AB04356
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4378E7AEABF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012826056E;
	Mon, 14 Jul 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KtpXOjqF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88100260569
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506227; cv=none; b=DxwuQF3+w/vVGyC767QXbvjQRiasijar6kV7OEXlR8+Dw2D3pe78C0HtD2lJBxSFWJpX4LgNxFI+zAy/S8JJZOVUU1UV11i1wkxw4hwIAQK1VEf3b66inLde+Zexlwga+50tjjcuQ5j56qrZasIXSuu+cERk/fLhj/4hT7Nsfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506227; c=relaxed/simple;
	bh=yhMu5T6hzBLMdh1uAFjKTy5PMnMnoPVoGkdLGs7pRlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzJvlQ9CaJCvL6hgndqyjaDdzzSC9xic87cn0ZaHUX3PLfyQAavIzrxPM4ZBhfzhhXkAU54WDcDfH2C0rQyhEg5pl4Xnx3HPG/HbHKpiw7DEvwhhSZA1Ji2caBUfi4NH+K1su4duqW0bO3E5y40GuCFSESq+4PZp1FTVgB0jrIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KtpXOjqF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455fddfa2c3so21975505e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752506224; x=1753111024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCjJs+mAQ+eyQ0cHltxO4UYluhIlp5Nf/WChKLF+U7U=;
        b=KtpXOjqFHopRdm0ZMSLVrZJhmkzxVMzQ9+qU6MtRv8/VcP6gEP8Oni3zy6l+Hr1fjT
         bckbB1+ZTiGUQ3l1PEbxzZ4Eq6/IvNmrrKbsqZcAtNgTMRxlic4fMRgwZdXIQsWcEdvw
         R4bvAQcZLdAEiMxPyT6P5+LgueyJgQdzfD8JNlyttiDK+KIK09iwRgi1ZsduNt8p//dY
         cA8CWv501am2lnfdk/4ASV0Mgt4EsoiZ4GB7CKRtMzDkddosdwd4JL7rt2MbBb80gL2o
         XX8uvibz7RCnpCzhnYn/4ut8WbV2hpa1C8wLyl9TB12Xpcb2aChJnEBiwwuhPrvFGG2n
         opEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506224; x=1753111024;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCjJs+mAQ+eyQ0cHltxO4UYluhIlp5Nf/WChKLF+U7U=;
        b=iR1XF8CXYLrJugfkt7VQSoed1mLDzlTe/KpA8jWpaM/OsSO3KmFURoSVr6R1sQxvz5
         x/llxKXKYpdGEvjzaaYfP0sr45B8hVgoxJbl59ZGmV7/WExPz4LilZSiZVIB3YmpWf+c
         cq8tKhO4bzZjJXSQgZAckGM4iEQsYTqfmzDiuwJ8TZfajueWbBnYhGru9tnxVPSzLAF7
         59nAdpvIS2R0Z2Og67SVDCB9pGEgzKXHQBAoOSnkUhUzgx31Lq0DGwTH4Xg4UTkc2qcz
         Ru373KkSka7xvEWaONXuBtgsVqELTG2wwAswhIuN2L9uEMNVKENkzOkccNIQ16QMp4yi
         ya3w==
X-Forwarded-Encrypted: i=1; AJvYcCXaimi6yDkd+vb75SCwJKUtFTaBWkn7h/aGLJkJvTXjAmQ3iUcAwzqP25wLdZmnIzru47273OkDYb+nAhM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk22rn30sZu/LCpkJV62Nn+MG/3ogOPWSHMs1AgrqI4y4Qwmpz
	Oy3RBaUK9iOYsoV/LkpLBWe2+fDEDfxheGaG8fgX+Zb3XYeLcoPS17cNgfxE6GFtOHwZBt/tBAl
	qojfFhY4u3Q==
X-Gm-Gg: ASbGncuNwd/yWyMx3pRUjQtAiRcLvA65rRsnw5ekQAnAnQe7HMeujyvk2Aph7MIRqRi
	bHLjtuPIGvbGDJ7d3UYdlLWuHX4lseRAUCO8Q7gBrKdO7VHboOTiiVJwSX5z7aUi+qEyZLQ7Qjv
	UfhTR6m8sZ83ZOrsPfYjD7CBtsVta4wcmP98gNZ8mzQ10kDGdIwfdJjEMFuNDTstaigbZfBDEQG
	mi4dn0l6ZCHC87uMXaFWfouzLuoRTr+xjwxtbhvO8RSLWI5GGEr2uCsPyZcqtr/MeXLA8YTB+n3
	Q/yQyEMSUIhUBFGuAKmBfPG0fJbMALvwmFrI9GgxMU8bXz9NRqikRNxk71/rKDzN7QWaprQdXZ0
	Uic56u5EiSwAXxoxwaIujxq6t7z1e9VIwlo9sS8Y5SzsQxbY8Sr7/LTmN4uLIiDI=
X-Google-Smtp-Source: AGHT+IEpin0kK7Y62+zwW4eiqts/4lq2fhVPTieQctRVVCnIYpoH+CSOCtblJicWaiIjBRT5U9/Y+A==
X-Received: by 2002:a05:600c:c096:b0:441:a715:664a with SMTP id 5b1f17b1804b1-455e7890b03mr75864705e9.20.1752506223867;
        Mon, 14 Jul 2025 08:17:03 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd540b52sm135696755e9.28.2025.07.14.08.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 08:17:03 -0700 (PDT)
Message-ID: <c93624bb-ee7b-45ac-8b53-b5391f11c9c9@linaro.org>
Date: Mon, 14 Jul 2025 16:17:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] phy: qcom-mipi-csi2: Add a CSI2 MIPI D-PHY driver
To: Vladimir Zapolskiy <vz@mleia.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250710-x1e-csi2-phy-v1-0-74acbb5b162b@linaro.org>
 <20250710-x1e-csi2-phy-v1-2-74acbb5b162b@linaro.org>
 <11b573d5-ce4d-476c-b94c-216d427cd838@linaro.org>
 <08261aa4-689b-4d6b-bfd2-221c1976d254@linaro.org>
 <a7f64b31-4767-4281-b452-a2bc5351d745@mleia.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <a7f64b31-4767-4281-b452-a2bc5351d745@mleia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2025 15:58, Vladimir Zapolskiy wrote:
> 
> This proposed device node scheme does not solve the known and already
> discussed technical issue expectedly, namely there is no given way
> to describe a combo mode hardware configuration, when two independant
> sensors are wired to the same CSIPHY. This is an unsolvable problem
> with this design.

I think that is genuinely something we should handle in camss-csid.c 
maybe with some meta-data inside of the ports/endpoints..

> 
> Sensors are conneced to CSIPHY IP blocks, CSIPHY is connected to CSID.
My understanding of best practice is data-endpoints go into the consumer 
not the PHY.

These are PHYs with their own SoC pins and voltage rails. They should 
look like other PHYs in qcom and across DT, IMO.

---
bod

