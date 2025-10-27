Return-Path: <linux-kernel+bounces-871570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E469FC0DA13
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBD7819C0F66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627AB3101DF;
	Mon, 27 Oct 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WS1YGRHi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB86E3101AD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568738; cv=none; b=cqDpr6a0eHwct+PlKAEZUYyrIhl9Odu23zTp/ZJh2pDUUN6ec+x6c+fCXdvkoFjHOX0dmczSUDZWLOjQAa4ks6hv2zLiqz18te0QHlteFsMT9v1QDo/yxvmPuy8Efi9E5C9PWNxY26AjW8C2WkUwstNy90suP6gaXYUWmTL/fTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568738; c=relaxed/simple;
	bh=4aoKoN5RbG7AvfZ2MgAIZ3SKeXxBVSUKkFoVfsWrXxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jt/HqQEyabN8yuhGIFcGGl7CNMRcmrhx9YXFl2A7th89k0qOnP9IYbWpj6dQxsxa2Wratq1wGvITNHXdLtPj56od9g18JCASMkU73AVJPWkBRCeGkiripjSxK3Q13/m/0S1FZ5Sc+q60+4Wse1oQlBAR7eoCF27UCn1q1t0eoMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WS1YGRHi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471d83da4d1so1706415e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761568735; x=1762173535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2m2cwzlH5wpE3kdOpcqs/uIBHJrsaPfS9kVRJa4lNf8=;
        b=WS1YGRHifSzbYL+jjwkaiXDVI2p6ebEcloavnYYevqSIYV9TqA118aWJnAHfbVY7oD
         F9XMyFzby8Q1uFLeabT7lMwnTGj2a6SBxRNhYusuwhtQK/7BLCXO4DsmP+nkvuMR0kNI
         DAVYETwqOw1QTY4CEv1NHpCp8eFwZSMY3gLxHBx5FqNMm5LlsvEAxXQe8Lmk+zbilLmI
         uSPmUewus4fETznS2Ew2oY+gZg+y59/n0wCMTqajpJBw7yRp8DFjKpDZ207B5IETpdsm
         6DWPpa+Egt/xw2o/31rO040bopYoIYNmdPE5I6Ev4dGvGJjHcjh+QW3l1xGjQYqmjoLR
         iL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568735; x=1762173535;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2m2cwzlH5wpE3kdOpcqs/uIBHJrsaPfS9kVRJa4lNf8=;
        b=BpdUfGJ8z1kqqX9bxutnkgdSJrZ7BJDlL65dJkr9PERP9vQF3brwqCG2L72Nzulshf
         /yGnq78v9ZO+foVcpijPFmaRWgsvfZerocK2JLjn2L38RqRs99JxNoyFIuUPEMyQ1DpY
         /ONjeBD2Bo28yTxmHx8ilkctL7xX2gE5NORrMoTeTyEZPcVG/OPy4AvNOeLAA8HH48YE
         FK88yd+iuWTz2Qbe5yPhqYwjgfTXcXmBKfQf2vAE59W97Ao44w5vy6ze0+NBLUjWseM9
         wbdDHrYDEvVO1yftaZjR3N9o3pQAwPlfqwi9wdxYkD2NnBCOznH1uyfZYQCaiwK+QxrB
         INWw==
X-Gm-Message-State: AOJu0Yy+FlN8ppzN9ENtnZXAVzEEiNGGdz5Ygtxw26LSaix2XSS4p74l
	6/BqtVDOS1X7ULzkoatBJjObLYIOCezQOz/YlIC009LWGU3A2+Tc/SXu/ptlq3kM2zcgWT9LTwG
	HPOnf
X-Gm-Gg: ASbGnctQQGzkhl54kqVAOVGPZsZiIfKowrSmkF5fiCnC4JCNRaBagEmct04eDAifTC8
	z0P0BofCmvdN5JIxG6zuGTHHCh1r3jvYKAdnjvKKI4KlOq4zknJcIEqEX9jw998QfViSkYWNXOg
	ASTlRznU916nF4Hqbtn5BjZVc4ThznQAcXJqAbiXdc1EvVtV6zeymxLMkg1T3rTm5OydQ3wSYJZ
	Nk52t/1C7ImTAxQgRIhKMYXZPYM/UGP9TN+KkofF6yEmm2jxL8V+k5g/5vHCfnCdFJLpCWD82SN
	GsHXl1yZ3aV/W0cc7Wot6s0VNQaK5fHrDQ6n+8MSVzB64D0sspeb3ByQ+eZvIIuVbZ2WEwCrY5K
	UROi4t6uJyoizkfqoTMFyVdVrdGNh+hR2cD6kezs+Gvh69EWKz2GGa1w1zhF1b5UeSYQ4FBxKlU
	qTsfY3KJug9KQcI7rkDhdo
X-Google-Smtp-Source: AGHT+IGnHN2+LGUXtGZpCqzNe4bVcec3o9TIo+eb2g4z7PQMElWw3oVzoXNocGieyNl5ZXcDJZ9cgA==
X-Received: by 2002:a05:600c:350d:b0:471:3b6:e24 with SMTP id 5b1f17b1804b1-474944c2050mr86946005e9.8.1761568735253;
        Mon, 27 Oct 2025 05:38:55 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd37467esm139395695e9.10.2025.10.27.05.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 05:38:54 -0700 (PDT)
Message-ID: <d97899d2-ce6c-4ef3-99f8-946a3c9ab74c@linaro.org>
Date: Mon, 27 Oct 2025 13:38:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: Enable i.MX95 drivers for pinctrl,
 Ethernet and PCIe
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 imx@lists.linux.dev, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>
References: <20251027-upstream-imx95-smarc-defconfig-v2-1-0f664b08d553@toradex.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20251027-upstream-imx95-smarc-defconfig-v2-1-0f664b08d553@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/10/2025 13:17, João Paulo Gonçalves wrote:
> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
> 
> Enable i.MX95 pinctrl driver necessary for booting. Also enable the
> missing drivers required for Ethernet and PCIe functionality. These
> drivers are used on i.MX95 boards, including the NXP i.MX95 19x19 EVK.
> 
> The below configurations were enabled (listed with their DT nodes on
> imx95.dtsi):
> 
> * CONFIG_PINCTRL_IMX_SCMI for the `scmi_iomuxc` pinctrl.
> * CONFIG_CLK_IMX95_BLK_CTL for the HSIO domain clock controller
>   (`hsio_blk_ctl`) used by the PCIe controller.
> * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
>   (`netc_blk_ctrl`).
> * CONFIG_NXP_ENETC4 for the Ethernet controller (`enetc_port*`).
> 
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
> ---



Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

