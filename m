Return-Path: <linux-kernel+bounces-816888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98682B57A07
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C45E16490D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7C6302CCD;
	Mon, 15 Sep 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjiqTl+n"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0A302769
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938274; cv=none; b=a1ntvaxugQGflmTl7+W3aISvHCrxKAirSP6hAdZvRx5Zqdwv2LmiMbAX4qFfT6VpBjmSw75QyP2+S0wGbzQ8ZGDgmyQqbo+zv+3i92NLQVy3h2E8Jc92uUmldv4V3kGEWJ5sQLGZIheYRLAQAgZN/p7s9WDkaZcs/ocri8JL0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938274; c=relaxed/simple;
	bh=jnowZAx2fHqSx18eHGKrmQ0Rthm2IhwhpsW8Fx1aXLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pCbwZBN3LoVqqi7ZJxl7C+9Eyw2ATTAAQj1PyPOYnjxuSICONPX+asAIV1MBJJE0QZzKV/VEu7Y3BGMTCh3bCClvJY8AWcUK8MX8ymJmMJ/sa7f+r/A9x1dalY6+G5wTR0N0q3eMQGNDLifha76bM8l3WY2Mu70EbtL13DCdqeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjiqTl+n; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7725de6b57dso5084380b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757938272; x=1758543072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xBJ7hW0HyQ6ynjUoI/3SjklpUmOb5BgbdzTT4NT3+rE=;
        b=BjiqTl+nVEg9YyDnyxSqq+EkgQi9glCL/H1L/JA4uwtJOhJoaJ7ouK+xDlxsoBX1lw
         Ll2Zk//JJcQPQyCoYm1wHyTohD8eTJZ04p+Q9hN7/09KO2IezoZDWjKXuENR0hZbIpEx
         ISCxc1IvaL5RBzxvM+vr/RQlEXYE8kdeeh9+mOiJy4T51qlM+PLYxIqDtr+g76E6d812
         HTFrGJGiS5LJ7NHTXTM4V4km1DQQPY9SIJIvoL/M8tNYuWLOy4TAfvU96B6jW2ngZ+sH
         xnONOGLlt4wR4b2qDosNO8zLCSO3BlERQuj2hw9x1XmmzIWIrUtadlyTFH7xnEOD8Xrt
         YUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938272; x=1758543072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBJ7hW0HyQ6ynjUoI/3SjklpUmOb5BgbdzTT4NT3+rE=;
        b=IbfYlennAserCRWyMkKxohcxEs+tqZfgrNJqnIbfZnhWWqCbAwjtvER3I41QIkXmF/
         xFLKizmK2SzXOrkP6KuCAbdsdO+w2wVXRikObJvQ+g+l81mEBZ/6cfdzY6VWwbsXIQbU
         FE6eoVizn3SoMaP6BTo/9w23ei0098bBz/QGpebNdiHRjK42O13SjHXZuMKbKNoOifVn
         K0+CBWr0DktsYlK7W+s/jHkwWNknwKVuwzR1GjM+k7w53K9RDI7XKErVCoGhE2eYtVNQ
         WNhvm80vZwM28hHNJUKAMeDoLvRfJOG5hW3JbYqdY+RS9YlpOtTgT30+n8SkCD0mOZjK
         9Ltw==
X-Forwarded-Encrypted: i=1; AJvYcCX3DZocWwtNyL2kvOTIMvqGFsrhgRAmTs0ENqabFiTm1hqbK1EFbJfOo1MnLX2p13KgV/am8TGPPtob+Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9FrLmrcHnJDue2rHR8yRdXPXCZZxBI0hi1hZ0ag3wnz+gIY4x
	dF4gR6Ujv3lHfEmbO5juQ01+sohXl/lSe+vtb0W2sGCprd8srtnHghCq
X-Gm-Gg: ASbGncss/g+vHJloJ7y8Zk0e+XA/0xNTuZbO1r8+Hvh+2PNyhvJN9LGvmRtgd+/OSvC
	aGP5FZlO7ghZFowAwquTtxpOH+6ND48QxMb2O6KrEXvqMUPEKkdiBS3UZp0g4Jq1gKh3tzBgwKE
	1aR+Nn6bD183pkCpJYhFsEA8TSjj7fQKw00/Usxjc8Ff9TiyKEtaJUAFcyFH3eloS9ippxbl/zx
	aiH9W6iWRWGAgSAqJ9g7Q8tUP1vylrUlap6WcotQ43fBpvsL/QhMFmc21VngeTBhkvEq3dAnmjR
	vNOi2qIiG/3JHhgm2bAka9+DZqdA02Vq3CBzJp9ILUX7FkhVOBWMgMuAvIxZe4mP65PBzH3Bzhf
	HtIy5JLDvJ54fIIv2X/NAjfknA8AQPV47
X-Google-Smtp-Source: AGHT+IGYiLnK8D+YAzqCoqA2ve1qHDfTCMke/N8nHhOGzUFWbZ8ycMjs7h+W9c8951UUXTfC5kPIHw==
X-Received: by 2002:a05:6300:408d:b0:262:52de:c576 with SMTP id adf61e73a8af0-26252dec5ebmr9336744637.29.1757938272459;
        Mon, 15 Sep 2025 05:11:12 -0700 (PDT)
Received: from [172.17.44.75] ([49.249.92.90])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36c6091sm11822156a12.18.2025.09.15.05.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 05:11:11 -0700 (PDT)
Message-ID: <887a6141-34a1-4a26-bc97-0bf16738442b@gmail.com>
Date: Mon, 15 Sep 2025 17:41:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Add support for QCS615 talos evk
 board
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 tingweiz@qti.qualcomm.com
References: <20250909125255.1124824-1-tessolveupstream@gmail.com>
 <20250909125255.1124824-2-tessolveupstream@gmail.com>
 <5oytapnerwmttc62q7s2vxlrtmcfg3bhiycpw4enak6zyaioyh@s4drz5x7hoi4>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <5oytapnerwmttc62q7s2vxlrtmcfg3bhiycpw4enak6zyaioyh@s4drz5x7hoi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09/09/25 19:32, Dmitry Baryshkov wrote:
> On Tue, Sep 09, 2025 at 06:22:55PM +0530, Sudarshan Shetty wrote:
>> Introduce the device tree support for the QCS615-based talos-evk
>> platform, which follows the SMARC (Smart Mobility ARChitecture)
>> standard. The platform is composed of two main hardware
>> components: the IQ-QCS615-SOM and the talos-evk carrier board.
>>
>> The IQ-QCS615-SOM is a compact System on Module that integrates the
>> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
>> SMARC standard, which defines a modular form factor allowing the SoM
>> to be paired with different carrier boards for varied applications.
>>
>> The talos-evk is one such carrier board, designed for evaluation
>> and development purposes. It provides additional peripherals
>> such as UART, USB, and other interfaces to enable rapid
>> prototyping and hardware bring-up.
>>
>> This initial device tree provides the basic configuration needed
>> to boot the platform to a UART shell. Further patches will extend
>> support for additional peripherals and subsystems.
>>
>> The initial device tree includes basic support for:
>>
>> - CPU and memory
>>
>> - UART
>>
>> - GPIOs
>>
>> - Regulators
>>
>> - PMIC
>>
>> - Early console
>>
>> - AT24MAC602 EEPROM
>>
>> - MCP2515 SPI to CAN
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
>> ---
>>
>> This series depend on the below patch changes
>> https://lore.kernel.org/linux-arm-msm/20250625063213.1416442-1-quic_ziyuzhan@quicinc.com/T/#t
>> https://lore.kernel.org/all/20241224-fix-board-clocks-v3-0-e9b08fbeadd3@linaro.org/
>> https://lore.kernel.org/linux-arm-msm/20250604-qcs615-sm6150-v1-0-2f01fd46c365@oss.qualcomm.com/T/#t
>> ---
>>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>>  arch/arm64/boot/dts/qcom/qcs615-som.dtsi | 414 +++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/talos-evk.dts   |  42 +++
>>  3 files changed, 457 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/qcs615-som.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 4bfa926b6a08..588dc55995c5 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -117,6 +117,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcm6490-shift-otter.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs615-ride.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= talos-evk.dtb
>>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs6490-rb3gen2.dtb
> 
> BTW, 'talos' > 'qsc6490'. I think the list is expected to be sorted.
Yes it is, Will sort it in v2 patch. Thanks
> 


