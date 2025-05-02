Return-Path: <linux-kernel+bounces-629574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF95AA6E5A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D046C3A635F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 May 2025 09:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C537226D07;
	Fri,  2 May 2025 09:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTUTESF8"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D021FF56
	for <linux-kernel@vger.kernel.org>; Fri,  2 May 2025 09:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178975; cv=none; b=uPMf+EPOMF2LzqthdiOHDZAlQXltacqr05tgtfUqRR6VQwG2x0ajpWHjKlYJc+kGOFfPHIr3bSdkqiMOP1319NfIP2Bn2mg/e+xswAKglE7iuDcCiQGg0vzcv1qCGE3jXxc8BH+tRqxLvOqFeqSqm9GUTKctOy8XPbr6MxTft1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178975; c=relaxed/simple;
	bh=XE7hRm0qUP0PF61AUPQ84APUG//4sM4kzYT+GWRzLUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=rzw5784hc3V0A+eT0hIjy37p3gc3ImWlMHYAuZC8qQBbrm1E1XUDOP3DWUZXDIMJi7oYT+gPkoKwX3CObXdjn40z7isnUx8rBVGTNFzNUjI8qRLJyLlAnR+8dU3edLY8c+ZFxh6BcxPpTOQziq450T96xe+zqCkGztk9uJl9k+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UTUTESF8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso1054491f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 May 2025 02:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746178972; x=1746783772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WX/evLS+DuAe/0hAk5mHgxdHnsJicsKUxinsRE+gIwI=;
        b=UTUTESF8oIlgwT1NlAMe84PQyu+i2zvuu36LEu2IRmlO4C5699pofAS24BZRT+Nd8c
         iPUzLgTYXIqfDrkaxKy+JPlWPSzupqok+ycdPWiJBIL8oIi2Fs9knsc89krO9dLNGfHL
         30gBVBj5VR0c4b8p0xr+QehSMByt3cursARIoWDyCB1kZHTX1NtVQPp1dkPew0kMqpDY
         MlRhcpT8hmIi6pJw2zXwuY9KhYsUI56QYTMjS+Ge+gIQAI9d29MTLYbtIgBsLPuVnnAJ
         xbSDodvCMDzKrHkdQIbQvCeHrJZzsMaMX/cGz8mMiuH1FE8CQSae9DTl4Glky2M31H0k
         cD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746178972; x=1746783772;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX/evLS+DuAe/0hAk5mHgxdHnsJicsKUxinsRE+gIwI=;
        b=O8FsmdSZocE7LLt7GqATt+FmjO7v1fVzSrjPh7jLTbi5OHXCaTwZNSorZT6KXwjADY
         zWoJGw9gmv7lvUDOJEpWo4bnqpWf+Rg3Wkh7QgeGURQJUVBJ4VFic5L3tg3AVl6BFzMq
         GcMqHihAPI2Se/ch+YAPWVyVpvK88S6BjHart8vDylAMW0lhQz+wydqtQFFPHaB0bw3M
         b81aL7qU3BMEEjQxGQC+vgT9SS2QeLqK/ijPhSpL0YJT/qooqEKxR8wNuQRAyRHMTOSD
         SgHa80sHsOgcc4qq6BZAWOiZzlpRpOdaECjOb/Rvo/xRTJBilEBCu5rB5JQK8yyKdkT8
         Y6Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUme3u6Dy4peLlcbQB23VztM+wG60QVEVQduAgqNY4W4AbNzSq9ee2fxglnyfMm8aUQEXER30rOFuo4fZg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6MzVkrNwe1kgOFUch0UPmH0FjjACuCd522BU3uuPyhguHt9Qz
	U7gs4syYZ+Hzt7I4MuNnOck9gLst26l+n4r/rNxyx2QD+Gyqk/wX1lh+yFWJe/w=
X-Gm-Gg: ASbGncvu/6mQtwNQjeh3yzu3+Q0SlJ8apdfv+UzqvM8ky6kYWrvHBGsGinq6NebrBHn
	/EpJmfyCpykZxEzSyB/cmF3Yac8lkr5BFRUt/miuEteGWcz7UhN6oE/6zY5RZgnYtz0zVN//U3e
	N7RCd56zkfckoCOz7c1tQKq1gUA4idpbyWyOH6NaUJKI43jJl4mC9eAu9j0VgHm1hzbbJBkqdQN
	ZX5svTLKqec9zAqCbUcK25Y8+cuCrA8xf2nBeFrkB5KtW/SNRIVRBnauwk52CZxmIWitEc0o9+0
	mvtJ52KLileRE4swCHyzqNoc6SIQS6a273VPZuyo0YIOV3WvCC9DaOM1wZqLXOLts1isBZN7YlZ
	MNnGe
X-Google-Smtp-Source: AGHT+IFiBHhJcjpY8AHYvmDW+6tcszRqTtvHysmH6lFStDCvbCOZgJoVZxZSTCZEdI78/1mXl/L2Pw==
X-Received: by 2002:a05:6000:2585:b0:390:ec6e:43ea with SMTP id ffacd0b85a97d-3a094038f02mr4157873f8f.15.1746178972094;
        Fri, 02 May 2025 02:42:52 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099ae3c1fsm1660874f8f.37.2025.05.02.02.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 02:42:51 -0700 (PDT)
Message-ID: <356bc97a-bd75-4894-98fe-d7fb0e02e1c1@linaro.org>
Date: Fri, 2 May 2025 11:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] thermal: Add support for Airoha EN7581 thermal
 sensor
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: <20250226003608.8973-1-ansuelsmth@gmail.com>
 <20250226003608.8973-2-ansuelsmth@gmail.com>
Content-Language: en-US
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Christian Marangi
 <ansuelsmth@gmail.com>, Zhang Rui <rui.zhang@intel.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20250226003608.8973-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Angelo,

AFAIR, the LVTS driver had issues with the interrupts.

This driver proposed by Ansuel Smith looks very similar to the LVTS and 
there are some comments regarding errors with the documentation below 
which may appy to the LVTS driver too.

Would you mind to check ?

See below.

On 26/02/2025 01:35, Christian Marangi wrote:
> Add support for Airoha EN7581 thermal sensor. This provide support for
> reading the CPU or SoC Package sensor and to setup trip points for hot
> and critical condition. An interrupt is fired to react on this and
> doesn't require passive poll to read the temperature.
> 
> The thermal regs provide a way to read the ADC value from an external
> register placed in the Chip SCU regs. Monitor will read this value and
> fire an interrupt if the trip condition configured is reached.
> 
> The Thermal Trip and Interrupt logic is conceptually similar to Mediatek
> LVTS Thermal but differ in register mapping and actual function/bug
> workaround. The implementation only share some register names but from
> functionality observation it's very different and used only for the
> basic function of periodically poll the temp and trip the interrupt.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

[ ... ]

> +#define   EN7581_HINTEN1			BIT(6)
> +#define   EN7581_CINTEN1			BIT(5)
> +#define   EN7581_NOHOTINTEN0			BIT(4)
> +/* Similar to COLD and HOT also these seems to be swapped in documentation */
> +#define   EN7581_LOFSINTEN0			BIT(3) /* In documentation: BIT(2) */
> +#define   EN7581_HOFSINTEN0			BIT(2) /* In documentation: BIT(3) */
> +/* It seems documentation have these swapped as the HW
> + * - Fire BIT(1) when lower than EN7581_COLD_THRE
> + * - Fire BIT(0) and BIT(5) when higher than EN7581_HOT2NORMAL_THRE or
> + *     EN7581_HOT_THRE
> + */
> +#define   EN7581_CINTEN0			BIT(1) /* In documentation: BIT(0) */
> +#define   EN7581_HINTEN0			BIT(0) /* In documentation: BIT(1) */
> +#define EN7581_TEMPMONINTSTS			0x810
> +#define   EN7581_STAGE3_INT_STAT		BIT(31)
> +#define   EN7581_STAGE2_INT_STAT		BIT(30)
> +#define   EN7581_STAGE1_INT_STAT		BIT(29)
> +#define   EN7581_FILTER_INT_STAT_3		BIT(28)

[ ... ]

> +#define   EN7581_NOHOTINTSTS0			BIT(4)
> +/* Similar to COLD and HOT also these seems to be swapped in documentation */
> +#define   EN7581_LOFSINTSTS0			BIT(3) /* In documentation: BIT(2) */
> +#define   EN7581_HOFSINTSTS0			BIT(2) /* In documentation: BIT(3) */
> +/* It seems documentation have these swapped as the HW
> + * - Fire BIT(1) when lower than EN7581_COLD_THRE
> + * - Fire BIT(0) and BIT(5) when higher than EN7581_HOT2NORMAL_THRE or
> + *     EN7581_HOT_THRE
> + *
> + * To clear things, we swap the define but we keep them documented here.
> + */
> +#define   EN7581_CINTSTS0			BIT(1) /* In documentation: BIT(0) */
> +#define   EN7581_HINTSTS0			BIT(0) /* In documentation: BIT(1)*/
> +/* Monitor will take the bigger threshold between HOT2NORMAL and HOT
> + * and will fire both HOT2NORMAL and HOT interrupt when higher than the 2
> + *
> + * It has also been observed that not setting HOT2NORMAL makes the monitor
> + * treat COLD threshold as HOT2NORMAL.
> + */
> +#define EN7581_TEMPH2NTHRE			0x824
> +/* It seems HOT2NORMAL is actually NORMAL2HOT */
> +#define   EN7581_HOT2NORMAL_THRE		GENMASK(11, 0)
> +#define EN7581_TEMPHTHRE			0x828
> +#define   EN7581_HOT_THRE			GENMASK(11, 0)
> +/* Monitor will use this as HOT2NORMAL (fire interrupt when lower than...)*/
> +#define EN7581_TEMPCTHRE			0x82c
> +#define   EN7581_COLD_THRE			GENMASK(11, 0)
> +/* Also LOW and HIGH offset register are swapped */
> +#define EN7581_TEMPOFFSETL			0x830 /* In documentation: 0x834 */
> +#define   EN7581_LOW_OFFSET			GENMASK(11, 0)
> +#define EN7581_TEMPOFFSETH			0x834 /* In documentation: 0x830 */
> +#define   EN7581_HIGH_OFFSET			GENMASK(11, 0)
> +#define EN7581_TEMPMSRCTL0			0x838

[ ... ]





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

