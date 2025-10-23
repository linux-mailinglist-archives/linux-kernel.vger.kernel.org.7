Return-Path: <linux-kernel+bounces-867289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78765C02209
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9EEB34ECD18
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EA233B97D;
	Thu, 23 Oct 2025 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9x60syI"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338CC337BBF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233538; cv=none; b=knjH1d163UXfF54gmZo1IyTv4V0WNMRIIulr7NkSlXQDmUSa+Xqg4j7+5m1KpXmo6hCpzTUe2oNuczk/3xGhjsE8YgkM2qTyxly8QIFhrYEVUmTTAY3QtYaJmRTbxh1SZZgFg1yFMDlJvukquSfJ0ph6voq96ldt9ZNrUMcahKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233538; c=relaxed/simple;
	bh=6qlk4nACBjTFHVmCeQpiAs38WK2qZahzOD5QvJNtZRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kErvuV+CxKq6wXHfzLK+snWlcgnmFyueytkn90ynw3lYAYlnXI1otvvd0HBv7sImCJCivWqrnHFdi9GB+IKQLk4mMU8R6hq1sD73c3lGf3WgvseJ7A8M6BgmM3rE3g+a6MiP3u2qHriZ1GiDjbFRzCmsZ37VZq7KPAG/ob0hrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S9x60syI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-414507aa5e1so48503f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761233534; x=1761838334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dbwrRJKkkNFLeqovxQS4IPzGLJx9ngeRhTx/g2bfwPo=;
        b=S9x60syIIUGANo3A/G3XQNZYII7ZKFX0UhaQZ7RSb2WMDEbu/DjtFWhFuXwYy0dehy
         UrqOueXZdlLWE0qCkPQ2fFD6lPxUPLBer59sk/SNwdFcuH4kvTvCFjDNdL0eFyQEeNgJ
         ks4KWYVMG9wkWDA9Y8FTOjRNnk+t+Q9z0to8/XgaISx6jda3Zlsy9Q7/OUBhGSI5I3Nu
         dlFTh9WCQEJtkrz6RKc2t4BaHGjjjjazUeLkOt5yY88kmtjKbnwcg8YO5YWj5XbqKNRG
         6rsI0SzeeQw2OXkElANW18szvk/R4v3SAt1uXI8es8k4gvc3mOMloTRgRCWj5oaaRyFD
         yuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761233534; x=1761838334;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbwrRJKkkNFLeqovxQS4IPzGLJx9ngeRhTx/g2bfwPo=;
        b=ePPNny07Y/iqE1BrS055XFKaQ7gZDWpRLw2nlQm0EaA6vRo1uPlGHjIkuyfuwSarmy
         uVrMHibyFVS6uuv+HqIP71oq5hzYVMGQJTekMlBvt/1cxveEB28Dd9svOKqh/UVtCQbV
         CvtLrTSBgMzCq9z1ifdzSh/V3Rln6MFQGiILArtKSL+rFtoDMr6tsAFqLJ1mdp+GHtWB
         3z3vCkz0jUB88i5WcI6jMPAV36DePA5RC0nclW9HVUmh8fmKBEY6aAASQrHXxjHm0pLh
         rQ3OO82PaAzZ5wkdJC/t4pycM2HVgerI3lqhIq5g9K0kp5mwupr8GLsiDXR/D0LMdo/u
         u4rw==
X-Gm-Message-State: AOJu0Yx6tVoXBldRlU3mQx5mIiXalFSTlOd/Gw2WeLfqzaEYwwmtaZfz
	MJ8wb60lcOGBkYlm3MrWkME5LOKWNsd9v628PoT3NKm60M2M/rMKAXf860YFkXcqmDI=
X-Gm-Gg: ASbGnctla0cTIGU+7jNCUktj0X6Nos91LrQSqNPE9HgE3FjQsl6rv2ngbn6c9zEGva6
	B+FgfpVBJAW4Z3KsOdiHqVQ9x10lgGcBXu4/RpUBAzFseUkEzA7A1mu7bggXDG6Ejbnrpe43/7R
	PwYuGTWPFLtq4mDVzhJluwF6PGoWA4RBTEgdJT6DP4ZI0O1bp9icrQA905QeuBwnWyN375tp9RH
	kATwqz/G20rU3kXdbUKu74Xbjj3FrNtUNxTwN/6hSrbOSAlo8Q6G6GJUPDV17+qpB9xENlbObSS
	w1eJSF+NAbER3niT84qOQ26UOww2+jYUH96+5DlFrwHigoKNIa+f13Pbi2kNZKdA9iedpbjQGl5
	8DsiyMKce4kThrjJ6129v1ZmmbKST5o6DHdBNzwIK90UmSOMQWelAeItQCZlpaVvlD4scTVHKbp
	IWffZJZQPJ/YsUJu4/gA53
X-Google-Smtp-Source: AGHT+IFPHg1v9+i+gqiKzz1Nbhq9G7P/do1zPfceuEHk+KkuwX3X+eKsges00ohxbfnsgHg5ARUM8A==
X-Received: by 2002:a5d:6191:0:b0:429:8b52:828b with SMTP id ffacd0b85a97d-4298b528529mr782411f8f.9.1761233534420;
        Thu, 23 Oct 2025 08:32:14 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898acc6esm4443389f8f.25.2025.10.23.08.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:32:13 -0700 (PDT)
Message-ID: <00555ed7-1aee-459a-ae60-0242809d7b85@linaro.org>
Date: Thu, 23 Oct 2025 17:32:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] arm64: defconfig: Enable i.MX95 configs for booting
 and Ethernet
To: Marek Vasut <marek.vasut@mailbox.org>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
References: <20251023-upstream-imx95-smarc-defconfig-v1-1-62c6e6f5b315@toradex.com>
 <3381308.aeNJFYEL58@steina-w>
 <e6b282cf-e9de-43b7-a8d4-30e67cefe430@linaro.org>
 <5d042f21-274e-4b69-849a-3342d77942eb@mailbox.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <5d042f21-274e-4b69-849a-3342d77942eb@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/10/2025 17:27, Marek Vasut wrote:
> On 10/23/25 5:22 PM, Krzysztof Kozlowski wrote:
>> On 23/10/2025 16:03, Alexander Stein wrote:
>>> Hi,
>>>
>>> Am Donnerstag, 23. Oktober 2025, 14:19:15 CEST schrieb João Paulo Gonçalves:
>>>> From: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>>
>>>> Enable the necessary missing configs for the i.MX95 to boot and also
>>>> have Ethernet working:
>>>>
>>>> * CONFIG_NXP_ENETC4 for the network controller driver
>>>> * CONFIG_NXP_NETC_BLK_CTRL for the NETC hardware domain controller
>>>> * CONFIG_PINCTRL_IMX_SCMI for the pinctrl driver
>>>> * CONFIG_CLK_IMX95_BLK_CTL for the shared hardware domain controller
>>>>
>>>> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
>>>> ---
>>>>   arch/arm64/configs/defconfig | 4 ++++
>>>>   1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>>>> index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..787d3ae3f5afeac486a905e0943e7b0e1dcee3a9 100644
>>>> --- a/arch/arm64/configs/defconfig
>>>> +++ b/arch/arm64/configs/defconfig
>>>> @@ -354,8 +354,10 @@ CONFIG_FSL_FMAN=y
>>>>   CONFIG_FSL_DPAA_ETH=y
>>>>   CONFIG_FSL_DPAA2_ETH=y
>>>>   CONFIG_FSL_ENETC=y
>>>> +CONFIG_NXP_ENETC4=m
>>>>   CONFIG_FSL_ENETC_VF=y
>>>>   CONFIG_FSL_ENETC_QOS=y
>>>> +CONFIG_NXP_NETC_BLK_CTRL=m
>>>
>>> Are you sure this should be module? Shouldn't NFS boot be supported by
>>> default? I might be wring here though.
>>
>>
>> NFS root is supported already with this being module. Yes, it must be a
>> module, cannot be built in.
> It seems I am using it as built-in on MX95 Verdin (patch is posted on 
> the ML), and yes, I do boot from NFS root without any initrd/initramfs. 
> It has to be built-in for that use case to work.


Every arm64 platform is supposed to use initramfs and we already use all
over the place. Actually, even on arm32, so that use case is not
something defconfig is supposed to support. Your own product config of
course can.

Best regards,
Krzysztof

