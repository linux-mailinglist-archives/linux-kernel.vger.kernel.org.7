Return-Path: <linux-kernel+bounces-793614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20615B3D610
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 01:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7549D1898C2C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 23:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231A7253F13;
	Sun, 31 Aug 2025 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WyYY5Txf"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABD9186E2E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756684426; cv=none; b=CwaTuuLTztyGynipj6Hc+iLRNh545fH6JMj1QstkxUKi0BP8q/y4ByO21DkoefueWy1uOr9Y73PJ4B03ctjMYk+5Z9B2Md2sCQLCO/vKconsqgmoU+RfTj2j9SXbZ98KEAjvEAv+CY69CFMyOLvpR9oErFV2WU3LIrdQL4EJwHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756684426; c=relaxed/simple;
	bh=XRMa5Nyj+EgloZQpXXnlKBtZMQtSW8HakSaIrjYylq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbT26a670HySkzUN2MZIVPwPXeeYeqU4PIS05BEemkXN3fH4sbj6EEhFexTXOcoTeOtVaADnTGRn1eXXy7THNJPbQcA1L37dFFgeg8VrigXOP0LG+1+1zObGp1jE9Sm77j/KlQfF+MQlYoS/lOj0nCOh7ywoO5UmNgRiJZrLZd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WyYY5Txf; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61a8c134609so4727590a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756684423; x=1757289223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZzD5VUgp4Ev3IaBux7GJ+EciqXgORSO/NRjzJxU14E=;
        b=WyYY5TxfZD16+oQWcLRNZOp3lIFjfq+YJ8lojszzWE8stWRL8uXucw/MsdhtudYDko
         H5mH3OSLOfaPVRzBUotRXAxbhtrvzBIe68W90cRV3MDZ053vDnGTs9PGi+bLgwyATU5i
         9QW2H2ZUsZNaYoiSXR2uYw1gltQ1QRDwfeq8wgJ5tQJtiJpbYpKdRB8aXNPms9JHvwtC
         heQ0/hUumb0DDvuO1RW99Lk6xf+MLuMsr5/jRA8dYRWjur9Nh9gZI1pkLqZv25wHjo7i
         /Q3eT3ZfE9e1nFWJ5Smk94GNF+a4mzau+2fK48SDuYeHnCQw1cnPeAz+LhWrLjgHC0JP
         5swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756684423; x=1757289223;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZzD5VUgp4Ev3IaBux7GJ+EciqXgORSO/NRjzJxU14E=;
        b=ioWdpQebwCzjhCBT8ejrf6JAZbiNfjLhS2cY278X+/HqVpBDGsuBFx7rUW9s2RAyww
         OJNfd7qh3oN6LDsRgJ84J8xR/LfQ2D2i4qzgfDArTBmWnLeQyBeY/Eh5oX7pG2Vd2E0Y
         TwLZuS+xborcTgZ8rJlnzpRVoXFZkNqEx0edVXtxOy3aDbmZNhoQoEKUCGS2cHF2t39x
         YUa7CxyQoym5DFgX7jAO37XbNLf+uVXPKy6CSLw2gjYIe0Nb8wzLkTr39nrnKB9WLolA
         kcX8093CxgOnKCpEWl+PRMn2/yxBvu9QUoL36KSU+9hHdtvUxlWLpeDrVi5t6bJWhFib
         BFJw==
X-Forwarded-Encrypted: i=1; AJvYcCXZjJJtCfZmqb8w65geHspLO2fK1FsHHUVRrrEivHAVc4Gc1Pl6uZRwwwm0ZMMbWLeqfVbQe1XPuE77Bn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKOlt4MU85P2TpYCdY1V4fP8X0cK/U9DHEtgbsoRHsiypPXv9
	Td9BFPMzpXVjyKTkfA4MpxSgIDu3oHe7Qn4aHA1pIjAmQ3C75GvWp2ouQBFXDmRdH+Q=
X-Gm-Gg: ASbGncvb7Nb062glPNs4tqBX5ivEdISe1yZ7N+cA52tU6tZ8Sh1TFFia3pgnV6vBabZ
	2fD6NQlAsHKfGRGJhFTBYTzkCT8Z9YZbGJdOKuMCWUq6KbYEFWdXiKqTs5SGdV4Qn4krNfsbLbK
	tSnduPhmfWEmkBYNt7wIG5VYdG3uw9gkDzxKFucOQ5DGG2cDw+CB3yNkEl/QuP7tWfujmlzIjb/
	Q4/1670OLJaoftPyTFUkfFOAQdF0+n4OUY3vGZVRp4cHMQ6E+Z6xRnAtpzJAsbHXtY9rspRC36S
	wqBIFHVycwzluhBcNpW+03Nq/zrIqofWH86648Xh3HX1GUulMkR47h2xN6TaHFUpyWhiuz/9ilR
	IsZDkn/wgeq/w6AxBSQi9FDV8SXjGR7ukIPDvRnx+EifCC/neXANo2M+/OfPVp9b6T5D4ckXgY9
	wRZBy/XpgD/HAkuufIEpYuhTL8BuB2og==
X-Google-Smtp-Source: AGHT+IFVA35Nb2ITQ5xm+F2H5nsoLi18hCULy2IxfZciFpoZhuuHzO03Eo2afLQfaNulmRaf+6lTnw==
X-Received: by 2002:a17:907:72d5:b0:afe:a6d3:b4a2 with SMTP id a640c23a62f3a-b01d8a39b3fmr584547966b.11.1756684423063;
        Sun, 31 Aug 2025 16:53:43 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0432937e0esm59177966b.3.2025.08.31.16.53.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Aug 2025 16:53:42 -0700 (PDT)
Message-ID: <d3161da3-1337-4a39-a16d-ad586f838c0f@linaro.org>
Date: Mon, 1 Sep 2025 00:53:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: platform: Add Lenovo Thinkpad T14s EC
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-arm-msm@vger.kernel.org
References: <20250831-thinkpad-t14s-ec-v1-0-6e06a07afe0f@collabora.com>
 <20250831-thinkpad-t14s-ec-v1-1-6e06a07afe0f@collabora.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250831-thinkpad-t14s-ec-v1-1-6e06a07afe0f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/08/2025 22:28, Sebastian Reichel wrote:
> Add binding for the EC found in the Thinkpad T14s Gen6 Snapdragon,
> which is based on the Qualcomm X1 Elite. Some of the system LEDs
> and extra keys are only accessible via the EC.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
>   .../bindings/platform/lenovo,thinkpad-t14s-ec.yaml | 49 ++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/platform/lenovo,thinkpad-t14s-ec.yaml b/Documentation/devicetree/bindings/platform/lenovo,thinkpad-t14s-ec.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..bab20df2d9ede9a3cb0359944b26b3d18ff7d9b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/platform/lenovo,thinkpad-t14s-ec.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/platform/lenovo,thinkpad-t14s-ec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lenovo Thinkpad T14s Embedded Controller.
> +
> +maintainers:
> +  - Sebastian Reichel <sre@kernel.org>
> +
> +description:
> +  The Qualcomm Snapdragon-based Lenovo Thinkpad T14s has an Embedded Controller
> +  (EC) which handles things such as keyboard backlight, LEDs or non-standard keys.
> +  This binding describes the interface, on an I2C bus, to this EC.
> +
> +properties:
> +  compatible:
> +    const: lenovo,thinkpad-t14s-ec
> +
> +  reg:
> +    const: 0x28
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c1 {
> +        clock-frequency = <400000>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        embedded-controller@28 {
> +            compatible = "lenovo,thinkpad-t14s-ec";
> +            reg = <0x28>;
> +            interrupts-extended = <&tlmm 66 IRQ_TYPE_LEVEL_LOW>;
> +        };
> +    };
> +...
> 
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

