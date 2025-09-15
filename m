Return-Path: <linux-kernel+bounces-816919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D643B57AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91F41AA219C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050E242D88;
	Mon, 15 Sep 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d92NrA21"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE773081D6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938994; cv=none; b=ZRsyw5gAYxbHdvcWvfVd3Px6foB8RwgijeZ5CrtL2UYX4rlpPvGQegpTH1dOTkCcgJtvixFsnZSSusAxdfa4xabQnu8G0r+2Ut/5lpkAbYRIMB+SsydE7bmhKBYV3ClBkzw9Vflmno0hRlIVR8+NUZPSFRw37vXrvO4uZCAACyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938994; c=relaxed/simple;
	bh=5xrfPKBwasccncGpp1riHATGItrRFQA9e7fK5DOChWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bf9KeMvEyNQa96Fz0mQ/IBvPbd2yDFUeTg/lUQagl4PXSn9ESQnsPZwuMaygHUWlS+96hFaMhHp23KzpjYQW0mosCXOkaWxuoOVFq24wSLV25qyY9Fn2GW6sr16W/rE4pS4brtN34u44Om4ByGhnNcLmFtOtk0yo7yRH6GUn6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d92NrA21; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445805aa2eso34149525ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938992; x=1758543792; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLsV2Z+nUo8sMXEFFkNLHMe788HpOvgGfih/dxbv8/Q=;
        b=d92NrA21wzXp3ih/7mn0bssucgDcPyelS4/1QZV7A5WQH0PTmiAvF/VjLvEyIrWxMj
         Lll60/S1SO+dKKSdWKEMGMD+PRDJjas1f/lpuWOZDxJ4qmly5KUMcwx0Li0DS3EG9MBb
         AV3dkyhxyWqRFBsFc39NNm6mE01aHlFJDoZ0YFW1+09PKIq4/dqGm7NABWa8esiG+Gsu
         xIj7yM1BjOqS+AezjL7X5ldNHX724YvR6JDCOTdQxl4vsMu2I/pzvFsP0vgywnEWMooh
         yYljsovinRclSbpmIiyOpscELrlZZsYwD/YqVxXPx85hwRNsnm4Jt3sA/lfgnAa812Hq
         5JUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938992; x=1758543792;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BLsV2Z+nUo8sMXEFFkNLHMe788HpOvgGfih/dxbv8/Q=;
        b=pOLzz/ftpKCHnDDEpyG+SoQHRaAj8r6tt8kPfd8bstu4Q7zn2rBEvP8JFORBT8dCp/
         HSpH07gpQC3LYl95jpMoCQZbm5AYekXtkMIxDMCY3EXpgwiG8y8xcZYf7bmCe6x8ZsRY
         K8VcHYNXoJuqsaHlS41N0KGCMrVNspW/pSc+vlgNKfbMPRTpoVY0RHJl20X0STDHhI6u
         TSU4c5GI4ozyut0VK+eeFwjvs6FkgLlDn9WbqFg6fSCbqQju9op/Kzto6KdWzyNHnCMD
         NzQ3viKB3xPFeXyVIlAvR6m/ez7hsPuFA5tVEYBjPyNppPqHu0XY4Qk5cIKs4fM3Ayv2
         ZW1g==
X-Forwarded-Encrypted: i=1; AJvYcCUWAkFr9uOS0KtPgyJ+M9E0xavRsANyCCMI87FQOPfYGxTsZMPkK98A5mNjB/zDrxPYOBUD55TKSUVsqz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1wPL0Njs/TH7/y4xYnEq8/dL/OEWoGFMz811feS6YqYsbDvll
	EcRGYCk9M6j4gLwNuYsm1Zch+n9yDRxAfocPvVHZtOujjwX/76974k5a
X-Gm-Gg: ASbGncsi8XU/peZLQf6o1+EYLxWp5tA0Ijb+2YM8AhpRqLc58eTAUTl7mDYnw89eVN/
	fGJ086PLJGQFPQo4lIwG6OBfqsrHk0EtDf8/h666ByxjJXWxP2wxymz6WmLBWCddbyp8YhYbW3u
	NZag/o56/irs5V5c3SRcD2H6MNugqogaqiuXY8sNmBq1Wib/1fdPRyFPiycUWDcBb2wWHLamV9H
	3uYgFDVDwXdpcEabOX3h0DO+NnXqJuXNi70n7SfC8gq51ZMWOYrACPJvH+pK81oDZf9isOO/pBm
	NR4VI+iFV8/ODJvXXEZ8rhbb+00JvXKpGgKOkABwo6QmnlHJfRPo7S3QU/GhKcDsxtR0uoYIay+
	7bHK+Z055Nywgq8/naH1S1i5F3hT68h2uBVYV/ahV2dQ=
X-Google-Smtp-Source: AGHT+IHsgD4HtGNllz3TJgLmEZtL9+Q2yo+F+oIRA9Ql5MSTHWjzJksW/qpE9gNeCm4EfBk9gupLBA==
X-Received: by 2002:a17:902:ced2:b0:25c:a9a0:ea60 with SMTP id d9443c01a7336-25d26d4cb18mr154813005ad.42.1757938992402;
        Mon, 15 Sep 2025 05:23:12 -0700 (PDT)
Received: from [172.17.44.75] ([49.249.92.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2623fd4d163sm63722225ad.80.2025.09.15.05.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:23:11 -0700 (PDT)
Message-ID: <42b297e8-b7ab-4527-962d-7689f7efcbdf@gmail.com>
Date: Mon, 15 Sep 2025 17:53:06 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for QCS615 talos evk
 board
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 tingweiz@qti.qualcomm.com
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
 <20250909125255.1124824-2-tessolveupstream@gmail.com>
 <5oytapnerwmttc62q7s2vxlrtmcfg3bhiycpw4enak6zyaioyh@s4drz5x7hoi4>
 <45f1c0b9-d9be-4d95-b27f-e3a1a015d24f@kernel.org>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <45f1c0b9-d9be-4d95-b27f-e3a1a015d24f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/09/25 19:35, Krzysztof Kozlowski wrote:
> On 09/09/2025 16:02, Dmitry Baryshkov wrote:
>> On Tue, Sep 09, 2025 at 06:22:55PM +0530, Sudarshan Shetty wrote:
>>> Introduce the device tree support for the QCS615-based talos-evk
>>> platform, which follows the SMARC (Smart Mobility ARChitecture)
>>> standard. The platform is composed of two main hardware
>>> components: the IQ-QCS615-SOM and the talos-evk carrier board.
>>>
>>> The IQ-QCS615-SOM is a compact System on Module that integrates the
>>> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
>>> SMARC standard, which defines a modular form factor allowing the SoM
>>> to be paired with different carrier boards for varied applications.
>>>
>>> The talos-evk is one such carrier board, designed for evaluation
>>> and development purposes. It provides additional peripherals
>>> such as UART, USB, and other interfaces to enable rapid
>>> prototyping and hardware bring-up.
>>>
>>> This initial device tree provides the basic configuration needed
>>> to boot the platform to a UART shell. Further patches will extend
>>> support for additional peripherals and subsystems.
>>>
>>> The initial device tree includes basic support for:
>>>
>>> - CPU and memory
>>>
>>> - UART
>>>
>>> - GPIOs
>>>
>>> - Regulators
>>>
>>> - PMIC
>>>
>>> - Early console
>>>
>>> - AT24MAC602 EEPROM
>>>
>>> - MCP2515 SPI to CAN
>>>
>>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>>> ---
>>>
>>> This series depend on the below patch changes
>>> https://lore.kernel.org/linux-arm-msm/20250625063213.1416442-1-quic_ziyuzhan@quicinc.com/T/#t
>>> https://lore.kernel.org/all/20241224-fix-board-clocks-v3-0-e9b08fbeadd3@linaro.org/
>>> https://lore.kernel.org/linux-arm-msm/20250604-qcs615-sm6150-v1-0-2f01fd46c365@oss.qualcomm.com/T/#t
> 
> Huge dependency list... basically unmergeable. But some of these were
> applied months ago, so you claiming there is dependency is just
> misleading. Or you are working on some old, downstream fork... In such
> case it would be NAK.
Thanks — you’re right. I mistakenly listed patches as dependencies that are already merged. I’ll rebase
this series on top of current upstream/qcom, remove merged entries from the cover letter, and resend
a cleaned-up series.>>> ---
>>>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>>>  arch/arm64/boot/dts/qcom/qcs615-som.dtsi | 414 +++++++++++++++++++++++
>>>  arch/arm64/boot/dts/qcom/talos-evk.dts   |  42 +++
>>>  3 files changed, 457 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/qcom/qcs615-som.dtsi
>>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>> index 4bfa926b6a08..588dc55995c5 100644
>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>> @@ -117,6 +117,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
>>> +dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
>>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
>>
>> BTW, 'talos' > 'qsc6490'. I think the list is expected to be sorted.
> Yes it is.
> 
> Best regards,
> Krzysztof


