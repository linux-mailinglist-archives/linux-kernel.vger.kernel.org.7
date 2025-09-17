Return-Path: <linux-kernel+bounces-819998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05094B7DE50
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D0C4326B52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72B826E6EA;
	Wed, 17 Sep 2025 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bk7WdYeB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E5276028
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087045; cv=none; b=mtX7BB8dr9TVnppk+gwvVm42YJYH0lWviokTlXWRF+T14KfZrxOCKE6h8CsQujdHC2GJmoZLMgY7nK/Iz9xsMskHw/pUjwKBR6yu1FaUDH7qjrkyNKM+d5LjOBYvSl+o9aqpfFnf6gn6/4Jd7lZypFYqcr105C0SuAdXVCf2YFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087045; c=relaxed/simple;
	bh=ojcEEPJefpnCUVr9pVG02gpYlf8ErQMG41Qqu959wmc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X54EF5StGnWtAFxNeHPI/omTb7D6LHeyR3mJFx2Z8L0nttkoBM0mIKcQGPBy0rqG3EKkJDmqcp2R2b0FWnMudACWQ2Dec8DZTjsNEBuytGXd/pAFFTLtKSFsQw1HPW3ibP6Ij6f18wZ8n7bbpJ3Vm8f+lZiDj8TanWK4VX3w2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bk7WdYeB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-269639879c3so59255ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758087043; x=1758691843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RLDgsVG/9yzmSOd51trY/YU6lrZVjPVVmLXoww2Ukw=;
        b=bk7WdYeBMYO1wwPHYIB9Zo1lF2X916w7ZcDopOCIwQiOG0JdBYt2B15F5w7Lw+re4f
         ygm2zJHU+Eg/aalsGjGn11EZJgt7qMn/qNEpFiU+cuYuuBq0vPIPUwih/qRgpjRGLaR5
         W+Jl4jtQRd7fi+Tt0M4xqDTO6oVrmHg9Rz6td93TYKB/7v1QoqK8BVelg78MU3sq6Fbs
         TeTWsTImQifrb/EbolBNZVi3ZlL2pqzdnH7zxPlK3j1uEId8ARkQLznW6sioN/lmINy9
         6vFg8VfEKvTW5VKu7Ak/wdsrS10jKN9+aBIDRvSy0y+9puativoVvvlHtcWdlGcN6D95
         P6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758087043; x=1758691843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RLDgsVG/9yzmSOd51trY/YU6lrZVjPVVmLXoww2Ukw=;
        b=AtI6rGjRUvkgaSvVf7/xlZCLLMInIZ4fNo5FYTgzb8gzgZ+/dVRLJYiolWrop39RJ4
         e/FWdpCy8vXqmSNzOadARZiMTkcmEt/zKxHEGMjO/alZd3aWvATY0yYC7oW432bBK1TI
         Y7DilOf/zlRr6JB9Ih5fX+3mEWDQ/MG+Kv8zTg8iqm5ZRzCwaRUlNED4l4XP8bPPrfhN
         E/kfyZQ95p2DM5+onITJCuibLta5+Fxl209/PrhLH8kLq9YWpaKSLARloVW7YXkCkbhT
         IQ5ddLHHc/AmemBE6STfqZAbYwew3xVr2RisF9fI1aZxXX53KIrghMEdwAdkwywtVwok
         /ahA==
X-Forwarded-Encrypted: i=1; AJvYcCVl66QepkvHwj94rp0FVHg4AcEy37Ox1P5ceHa1ZeHvrafuQ3uqwMi3c0dpU0jss8iN9G1OavzOYXV80dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPVpGTwpsVpSGBnjUzbRDu1nvAER52IPhMRqnjsPuGZe7y93YY
	dF3cbr7nmdW9EMo/f2f+C3k4hcjY5r7rCmhFiUWGypqyfAEZ4Vnc2dyQqaRf4Q==
X-Gm-Gg: ASbGncupKm3dVDytGeeO+SBPJ4FEIwez8l5kuSTi9lgzk1p3lxXgiSDMQsX3AjHmhma
	zE1yB1BRRUmvhttHKcE5YTYZXi5K7l2eniaS2pXr28rSSnsRBfWeo4fMGW8Z9kPF+/2rxEu1+x6
	C9WyS/z9Z8eoMKFmIxCTDTKGGw4flxvw9vFWmftGJPK7cy/mpeWfL1Q8Qj4iqdhUvyVs9Wnner0
	8ITGI736dup8dvHjCXKJVdHb/X8hT9QAKEwusp3dfl4+3INujC2ZI4DIfRhhYxElsM3nNfcj4KK
	BagRmmgqxP4MqILfML1gmI6T6WsGo3M1BrwI2GZ7wPSrMjL8trPeis03aNCRbNiQJvFTUPL574Y
	EPcSoaBzFvcdO3NOwAoqNLC0EXfDsUaxz
X-Google-Smtp-Source: AGHT+IEAVa+T6fRcCJa37o376SoMU7onInRHzwpwOfD+pCgZlxIWR6i2Ecy3rSFDP4O2WFq9GPHBKQ==
X-Received: by 2002:a17:903:4109:b0:25b:fad8:d7c2 with SMTP id d9443c01a7336-268137f2945mr7319385ad.39.1758087042781;
        Tue, 16 Sep 2025 22:30:42 -0700 (PDT)
Received: from [172.17.44.75] ([49.249.92.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25db018df8bsm142006335ad.151.2025.09.16.22.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 22:30:42 -0700 (PDT)
Message-ID: <3fae286a-dc5b-4024-be28-ab51dc907ba5@gmail.com>
Date: Wed, 17 Sep 2025 11:00:36 +0530
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
 <v2d4e6py34xb2hjrfnmlrmd7xme45equ76zb2c5cmftgylk7w6@5lmexwfupj4e>
 <70c2f78b-c3ce-4b7b-a961-9f3957ce40f8@gmail.com>
 <axtz5euoa5lyg5clwj44jhdn5gvfubic6un3ilndzzoy22rici@rqqk4eyw7yas>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <axtz5euoa5lyg5clwj44jhdn5gvfubic6un3ilndzzoy22rici@rqqk4eyw7yas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16/09/25 15:55, Dmitry Baryshkov wrote:
> On Tue, Sep 16, 2025 at 11:22:02AM +0530, Tessolve Upstream wrote:
>>
>>
>> On 09/09/25 19:28, Dmitry Baryshkov wrote:
>>> On Tue, Sep 09, 2025 at 06:22:55PM +0530, Sudarshan Shetty wrote:
>>>> Introduce the device tree support for the QCS615-based talos-evk
>>>> platform, which follows the SMARC (Smart Mobility ARChitecture)
>>>> standard. The platform is composed of two main hardware
>>>> components: the IQ-QCS615-SOM and the talos-evk carrier board.
>>>>
>>>> The IQ-QCS615-SOM is a compact System on Module that integrates the
>>>> QCS615 SoC, PMIC, and essential GPIO connectivity. It follows the
>>>> SMARC standard, which defines a modular form factor allowing the SoM
>>>> to be paired with different carrier boards for varied applications.
>>>>
>>>> The talos-evk is one such carrier board, designed for evaluation
>>>> and development purposes. It provides additional peripherals
>>>> such as UART, USB, and other interfaces to enable rapid
>>>> prototyping and hardware bring-up.
>>>>
>>>> This initial device tree provides the basic configuration needed
>>>> to boot the platform to a UART shell. Further patches will extend
>>>> support for additional peripherals and subsystems.
>>>>
>>>> The initial device tree includes basic support for:
>>>>
>>>> - CPU and memory
>>>>
>>>> - UART
>>>>
>>>> - GPIOs
>>>>
>>>> - Regulators
>>>>
>>>> - PMIC
>>>>
>>>> - Early console
>>>>
>>>> - AT24MAC602 EEPROM
>>>>
>>>> - MCP2515 SPI to CAN
>>>
>>> No WiFi/BT/ethernet?
>>
>> Networking peripherals such as WiFi/BT and Ethernet will be enabled in follow-up patches.
> 
> Why? WiFi/BT are supported for the RIDE platform. Is EVK using something
> different?

We used a Quectel based AF68E module (PCIe for WiFi and UART for Bluetooth),
which is different from what is used on the RIDE platform. I plan to
enable these in a follow-up patch series.
> 


