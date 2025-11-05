Return-Path: <linux-kernel+bounces-886489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D10D5C35BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E040256613B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907943164A8;
	Wed,  5 Nov 2025 12:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAFMjIBt"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F9A3148B2
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347468; cv=none; b=OqHfekwve6In8K7tX0s8l/7oKCHQyIWqPk/kvIXXf508OkVjlZ4Zpbz7NXr4jZuKl0IYmETpj2MF95NHMydnJY6eeRTTlHxkR7gAmSEfXZurJaD12VRQfQRxn9ZVv3PP21WJC1MFpN/5Pe2jqOTGkn0tisSdZkNTRFp+ErcBcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347468; c=relaxed/simple;
	bh=0LJFAwG3uKB8EtkB8F3PX6TJWOV2c6OGA4oCsggctMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6zlWXyIUNxGncRvoJCi1mtVYeOYOkXBXg1+xGQrh7actbbok2aGSwGM2/sDo2fJowXCP97WbzFV9vW+O1a0OdBMPkkbGiNQzjITUMY7flmu2Zh9tDBX9/gGUzE3IGV14sDJzVfPBmYOF0FEMgwfQ8sKErM3lbKGmNqpn8Frog4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAFMjIBt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-339d7c403b6so6415985a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762347467; x=1762952267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vr6PsIqaDjxaH/cpBwS9aE8aleV9ylkOxYVPRloXRC0=;
        b=PAFMjIBtG3CZOsJIak9CwLGWs4lLiDb+JQ/CRMXK1dXDmDs9mBGjroil/+yTkmwJkB
         w5H2QOGjmB45r2lfZiDatpiXrMGNV6EDl3oivuszkEGndUqmoWfvXFxjoILlRW0zYQwA
         uSoF6EpAAjorotuVKZU6VYVH36SybW8Af7yb4A9gYJFdzf0vVGC9k6fLx9wmUPJq87RF
         11I/oGUTiZBceIv+cptDmwfIeq9/4LlA0rsq0Xcd9WhnTAAY5B7eqtTI66wYgjCz/ZPB
         WDHMpKziTG9rSboiOmFEtcEjQApO5IOkLJjmebNmYPi0aKlUVPVw7dlLOwFx8Wlau2ap
         hn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762347467; x=1762952267;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr6PsIqaDjxaH/cpBwS9aE8aleV9ylkOxYVPRloXRC0=;
        b=udCdIkDSq9oYBDjcGA7xkGC5Vhc5BOC1a3bbpMf5Zmkmo9TbVRUUoGk8YGTuKGzNmc
         al0t09Kno8Z0NpIUO00cubueqn9E+QLMwDag6xHfxR9xLQEgUjczd98SKEEQ3mveLtEE
         hKw7lsO7k8wj6NRNOrFkIkjChtU7Sz93LkS4rIiS5yzcYiL1XX40pOChOJvVyaWNV3Dh
         A6s1dWVhQxjBVM9PzSKr2+7eOBli87xQ4UXFZhG4PA5EWjAsHmBuTRnhQvG2vvyKsNEx
         AcJ4cWfsv1AkK2JyGRzvrzFwbBSHvKi2bWb6+TblHMIRtEcpjSRU2UPnw4bT6M7QB5Gm
         Qwsw==
X-Forwarded-Encrypted: i=1; AJvYcCXdfNZ/TB/U2L/ovzdncdgcLTaFL5/r/3qIDvKZQG+2iWnXzpEZ1+nGd6jdJV+Ou0j6DNjAFMmrDLJhm/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxkZzgWVxZ+jxD5p9WWbVWLxirVYttj6oC08VjCPuVcrV3tgyj
	y5N1+USZ8Ld7XAsNd1pMLLyB7xeimGBI6ucLYsqp9ts6jrxBVMjdymZ0
X-Gm-Gg: ASbGncvI9c4MMpTopx4/FRfHbbJenmG0glSlngSe1G9NzETJ4I+a495E74gwM0KGL+b
	hxLsuX5H1A/OOpivCFgFQy0v55ZMv7jr8Zekd/RaOyK0oQBLgkVfD7cwCJwsuT4RaS/ozvBc6nV
	15X85lTOVDan9sToDIehTT19exaeohQB48KsTViUC+7yMYdLbugauRUVHcyYx+M+ZvVDwCsLutB
	YLA1s90UyRtiGUbhDiRdcYDPYNZFXBzBLNQgoCpkvPrHeenYg7JnsnGdI6N+LPomziGEmzdDnGT
	M3s+YFR9/6BYsF/69JaMF8+shRvL9d5mc4AhDxMFhDnruA0XE53USi2PVLIZfX3n13vrOpLm4rO
	AivC0rr3/fINXKySy2Cf3EFumm5eU4JkEaWMa2RvkT3nQ+Ri/UEA4T0xCEZGtV/bHVoWGNmQRNI
	E3M4BQEbn6u6cN9rC6MkJ+sJQ=
X-Google-Smtp-Source: AGHT+IF/tAWCYp/lgefsgtHlbqrg/hhGf8vpbe20agZqQuaywYqcLauuHDzVmD/ISXzLYKlDef5s+A==
X-Received: by 2002:a17:90b:590b:b0:340:2a16:94be with SMTP id 98e67ed59e1d1-341a6c2c740mr3688090a91.4.1762347466974;
        Wed, 05 Nov 2025 04:57:46 -0800 (PST)
Received: from [172.17.49.162] ([103.218.174.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a689ad7fsm2950374a91.2.2025.11.05.04.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 04:57:46 -0800 (PST)
Message-ID: <58afe57b-68e8-4de3-841a-df3dbf04ee64@gmail.com>
Date: Wed, 5 Nov 2025 18:27:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Add Qualcomm Technologies, Inc. Talos EVK SMARC
 support
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251104125126.1006400-1-tessolveupstream@gmail.com>
 <xq4jidiffovpg3armhlzrzxloug4irumlycyyvmfaugajbtq4t@cutuj5736ayo>
Content-Language: en-US
From: Tessolve Upstream <tessolveupstream@gmail.com>
In-Reply-To: <xq4jidiffovpg3armhlzrzxloug4irumlycyyvmfaugajbtq4t@cutuj5736ayo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05/11/25 06:35, Dmitry Baryshkov wrote:
> On Tue, Nov 04, 2025 at 06:21:24PM +0530, Sudarshan Shetty wrote:
>> Hi all,
>>
>> This patch series adds device tree binding and board support for the
>> Qualcomm Technologies, Inc. Talos EVK SMARC platform based on the
>> QCS615 SoC.
>>
>> The first patch introduces the DT binding entry for the Talos EVK
>> SMARC board, and the second patch adds the corresponding DTS
>> files for the platform.
>>
>> Note:
>> USB(usb_1_dwc3) supports host-only mode based on the switch SW1 on
>> the SoM, which is purely a hardware controlled as USB-ID and USB-VBUS
>> is not connected the switching cannot be handled from SW.
>> Hence from SW Host-only mode is supported on Linux boot up.
>>
>> Changes in v5:
>>  - Updated commit message. (suggested by Krzysztof)
>>  - Introduced generic node name for can, dp, hdmi-bridge. (suggested by
>>    Krzysztof)
>>  - Introduced talos-evk-cb.dtsi, which has common carrier board
>>    interfaces.
> 
> Common between what?

Introduced talos-evk-cb.dtsi to define carrier board–specific interfaces
common to both HDMI and LVDS top-level DTS variants.
> 
>>  - No functional change in bindings file.
>>
>> Changes in v4:
>>  - Updated product name to full form per Krzysztof’s feedback in
>>    dt-binding comment.
>>  - Hook up the ADV7535 DSI-to-HDMI bridge to base DTS file.
>>  - Add DP connector node and MDSS DisplayPort controller.
>>  - Added USB note in the cover letter for maintainers' awareness.
>>
>> Changes in v3:
>>  - Addressed comments from Dmitry regarding USB1 `dr_mode` and 
>>    added a DTS comment.
>>  - No functional change in bindings file.
>>
>> Changes in v2:
>>  - Renamed compatible to "qcom,talos-evk" (suggested by Dmitry/Bjorn)
>>  - Merged enum entry with existing `qcs615-ride` block (Krzysztof)
>>  - Fixed subject and commit message to use imperative mood.
>>
>> Thanks,
>> Sudarshan
>>
>> Sudarshan Shetty (2):
>>   dt-bindings: arm: qcom: talos-evk: Add QCS615 Talos EVK SMARC platform
>>   arm64: dts: qcom: talos-evk: Add support for QCS615 talos evk board
>>
>>  .../devicetree/bindings/arm/qcom.yaml         |   1 +
>>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>>  arch/arm64/boot/dts/qcom/talos-evk-cb.dtsi    |  56 +++
>>  arch/arm64/boot/dts/qcom/talos-evk-som.dtsi   | 442 ++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/talos-evk.dts        |  87 ++++
>>  5 files changed, 587 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-cb.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk-som.dtsi
>>  create mode 100644 arch/arm64/boot/dts/qcom/talos-evk.dts
>>
>> -- 
>> 2.34.1
>>
> 


