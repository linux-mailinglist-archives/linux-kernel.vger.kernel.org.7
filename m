Return-Path: <linux-kernel+bounces-775856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8283CB2C5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53E116F8BD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127A7340D8E;
	Tue, 19 Aug 2025 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXWYcuVe"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BA33CEB9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610377; cv=none; b=AEAahZmRo40DEoUyoRNN7d2JG7N+t6CArTrVwwnzF5pEiiaas/yMSKlc5u2CkKu/XXYC3outR+iXjOrcruQo9rmp0TNlXCMn51KHhCcNVRqVeTFkp7CsQMs7yk7/f79tGXmhgXvUa6P5FUnr3Un6xafrp+EYrrdMnz4xWNuEjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610377; c=relaxed/simple;
	bh=pSC5IgqyzZtG96ClfbXrgt5sbg1AohobwZVoz25rj/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GfL3yhV2Mhsn651fogw0pok9JyaYa0KcNUK68G1quoqEozOojcl+Qvq3BMpef6L6OD9+DVyUeZC8gidCv+wRWUWCxv6g3ag9mhOXqC8xcdqiHaAaS1lKgLOwhmhX1mC/Ie5rU++Jl8SPA/+s+lzkuUPGlM9WuzBIRI3+aQyzbWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XXWYcuVe; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b004a31so37370585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755610373; x=1756215173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FygJPUitZkmXwlp1RpWscijGjGvi5AqEQa7JO2lBl9w=;
        b=XXWYcuVeZdjKkQpbmgtiXlCYl2P3uKIwc5vk/Jo460Xd8ezzS8QFMCAjkC3CFcBkq5
         VW4Ej+rGwFUzbGHTZiSEUcXRxH6+omwQMCHHQ8UZ8F212Fj5ItogE2fwUBn64JLw3rRc
         8petYKOwLYhlUHEw/L0Z9ZkyRbzgU5K8/LHZhpS/DUO7f0Invi60piAGW9odGopSSq7g
         GVkdZ0Lts9g0aYG0WPYT9hmGl3junTZPCBRSZM25yU8Fk94+YxU6IPQKdt+hzTCB0lnR
         xGN35RYy8u9zLJ95wGvXczvsAiCr7Pkl5/T5dANheglI9ftTOEttnFCJRH/7s+WebjJ0
         VqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755610373; x=1756215173;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FygJPUitZkmXwlp1RpWscijGjGvi5AqEQa7JO2lBl9w=;
        b=H/zieAdtmoaPXzGy/Ih9AauuIx3zKFZrT1kR7jkzQo6zqAgjlv1Q9cvtJwD+3Ftn6J
         1tcbK0aiz4m7iJye5x6JRLxf2cmk2x3/+FBlFWUz1yApw9hz+8dj1CUw2EtYqA7d+4yn
         lLFmDkgxuL1cTQpDcL/cpQ+G2KLTmarWBGX7bzY7XssWAHnEqGQY5bMhwFmfWoLZykfE
         6Ziub5omVyQQOYyIaS84GsYxxQaon/O2L9mXAOgMGQ+qxZC0Fu9iB2L6Uea3XY6OLZ+j
         CsYghnjowwZXOQXu9PkgdG4VUgVpe+xsYGEdElEBAwVijACIJ7h7nzSXHFrVPRx1T8aS
         Lhgg==
X-Forwarded-Encrypted: i=1; AJvYcCXakydsrmSuMnJGlfGdhqiCXHMtuIhRDLNS6MB3SOppgb6gtq153H0xlO0YXWsEdWdlWA4WXBNIlt04tMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNtDvPeUVwQZo+e+UePYoKNfwbhynw8kAr5/itYm835TNbeatN
	bX6QKWdqCIItcH/ffc5ZIOgT0TzHGC8GyhzRInD+lJ5uST6qmaXMo6esPXhLeuPB1yumeMp1Mbc
	wuKC0n4I=
X-Gm-Gg: ASbGnctVwNutNq+OynloQxHyZT2wLjT2mmI8mwDesK1pX05x4ROWi0RJXYdips2KoQ3
	2rUmZv3WhIETUEF+NsS4SSEYsrQGjz6KqxQCrGMEECPrpb6yA5JyEKRPZYddVDmZE2umC3IHLKN
	57Fic99DjgKESKsGMl0V3mmgAxk5ZAbDe8RpPzmEMJ7vf/zehBZ6HerezTQT0P59xqAlG0QOhMe
	e4p8fR+q4koeYOqs41BYvJ0xAEg9/d4qk+NvZd2tfUOxM2FgE6044v0vQUNLDHCiZqlVL8Z+xCo
	zryf/SmtsaJ66rHMTrCI2dka3ezN/9MJw8Ri1UT/ZWJRaqMAmVXSAym2dU8rZVawOW4jBqLfb0G
	Fjr7CZUTqB0HHgpzIKVhY5jkRt1djqWRONRoA3tYlKu6CSYMoG9BycN1yH5ZkouU=
X-Google-Smtp-Source: AGHT+IHE3eWuGDJbAuuWclWDGhvbLd8+Nrm3L1V5+JQsqdxDxBiVDMEcNaBhcDl9yr9xN8B6hHRBKQ==
X-Received: by 2002:a05:6000:24c3:b0:3a4:d64a:3df6 with SMTP id ffacd0b85a97d-3c0ea3cf081mr2302142f8f.3.1755610373108;
        Tue, 19 Aug 2025 06:32:53 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c5776fsm3708064f8f.61.2025.08.19.06.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 06:32:52 -0700 (PDT)
Message-ID: <bee2fce1-facb-44c2-8eed-2bb396f9c204@linaro.org>
Date: Tue, 19 Aug 2025 14:32:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: typec: qcom-pmic-typec: use kcalloc() instead of
 kzalloc()
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250819090125.540682-1-rongqianfeng@vivo.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250819090125.540682-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/08/2025 10:01, Qianfeng Rong wrote:
> Replace devm_kzalloc() with devm_kcalloc() in qcom_pmic_typec_pdphy_probe()
> and qcom_pmic_typec_port_probe() for safer memory allocation with built-in
> overflow protection.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 2 +-
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c  | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index 18303b34594b..c8b1463e6e8b 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -567,7 +567,7 @@ int qcom_pmic_typec_pdphy_probe(struct platform_device *pdev,
>   	if (!res->nr_irqs || res->nr_irqs > PMIC_PDPHY_MAX_IRQS)
>   		return -EINVAL;
>   
> -	irq_data = devm_kzalloc(dev, sizeof(*irq_data) * res->nr_irqs,
> +	irq_data = devm_kcalloc(dev, res->nr_irqs, sizeof(*irq_data),
>   				GFP_KERNEL);
>   	if (!irq_data)
>   		return -ENOMEM;
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> index 4fc83dcfae64..8051eaa46991 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c
> @@ -713,7 +713,7 @@ int qcom_pmic_typec_port_probe(struct platform_device *pdev,
>   	if (!res->nr_irqs || res->nr_irqs > PMIC_TYPEC_MAX_IRQS)
>   		return -EINVAL;
>   
> -	irq_data = devm_kzalloc(dev, sizeof(*irq_data) * res->nr_irqs,
> +	irq_data = devm_kcalloc(dev, res->nr_irqs, sizeof(*irq_data),
>   				GFP_KERNEL);
>   	if (!irq_data)
>   		return -ENOMEM;
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

