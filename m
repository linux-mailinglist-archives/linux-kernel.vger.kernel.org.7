Return-Path: <linux-kernel+bounces-890287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA0DC3FB5C
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA32218906FF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106B321420;
	Fri,  7 Nov 2025 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jPKgscwN"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FC320CD3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514520; cv=none; b=Hv5wOI+7Zwf85psO2jrq1lmZb7/S3CJHKOYmCAIXJCVq0IpAgZMFYhCkOIgt1CU4Aa888ryXAYvuSqaCJdR4miOuMZpA4gryYsEmABJg9BVvE068yUBBFgRvnsZAdlTsxSg4sMsbJh+3xyxldF6C8IQ/6gb/tQj1wA7kvyCGkF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514520; c=relaxed/simple;
	bh=ZJbHZhQ6h1ZtUmMYIH9EfLygLL2UTAD9wKcvsfmHdtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4fB6Jb/GPryaZtIAN7D2GPxMRP2b1Jnd51JO2NTBYyNUhwP/AgqTbFADvB0/9DJQcCLp65gU17Yho0k5rcJuw9xl3SkwOMX9aurFo2VspCO51r/YnyfgWzEwgPIiWm+Ap2D3y109jNYKZw4F63LbmYJPRW+zHt4tPLbCFZrhso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jPKgscwN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E9C2E40327
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1762514509;
	bh=4vu1ZL+qmEbCFgVVYC+Kd3K+ffetq+SNlu+bOuuJkH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=jPKgscwNXrczObXgZcMj3VRGHqCyU+Emua1A/B+wPGaeYBu0KLD7+X03GKaDNPwE/
	 L3OnEiCNu6X6+IT/+Cf3fp3LoiW82L81cHEPq0AEMRwBOVjVAKcGYzHG0B5Ok318Iu
	 r9bXXlRmLHkGg20xkJmgcxP79fnhqrdm6RhmAE9y0AMNGib/6YumPL3r1B47WZSfTV
	 dFAeP2Kz2plg5KEn841zuGUioL90P80k/lIpePteBvYnRzI3xPVKdpNyCyh4Rfnu7Y
	 jKqvD7UPLLd1AoH9OnUJE30NhTgt8O5rcsh04Uc03LTkMbIvpw6wBpDKi2OgpLkHWR
	 MdHGoJ6JlaUM4lJYcQHC5ycTTpKKRe+pR2pJ70/xhRN6y5zQ7mizlV7+Ww9apGYdMZ
	 i078Qb5lsoudGIcDEbhE5YSSc4HhuomMgLcYKBd5e/rnV8Hr4VQ5l5Nak90qv9soAj
	 +bkiRXcANQkrBRcq+94+g8kCE5C1q+hi5GPgDL6ZrgbDbCT6P2QJRKjbs1+kcKcDpH
	 +cPNf9Wx+nfEcvcsZD5JoYFP9hrnmuTASW4nhvAIiDs1nSk1OVZK8unUn99sVxwfvS
	 0AwqZV/oHs5eIzTwZYTrFjtDlKzmLjajfgMXNz0iqhe/SsYCGQmuzsQPGYYvHQXPCf
	 896/Z6PZb5UqjhWiH37XPCVI=
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-592bd7da031so352272e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514509; x=1763119309;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4vu1ZL+qmEbCFgVVYC+Kd3K+ffetq+SNlu+bOuuJkH8=;
        b=F85NxhUxjI7qk+N3wkJd2VrEwJLa5tQTU3X3k2RRAxM8liBJfsqmB7n8Y68qG4r9XU
         EgL2IS5J6Qv7UoXekszytAQbrZ8rWXIzZw72CU/ZfIBhhxNvUQ0FGf3wc3L+sUzFMfzw
         pFDHDNtPZGvQ8IoXxfgQ3rXR+3/NHYjezCCHgNTnem61NEU+wRQJD29PLiX48lX5XFZm
         PdbWvxwJ1Dzv+f2e208qmtQsrcdl4qaTqgkRQfNnnTSvV3BZq+x/FxKAqGGCFslEGObA
         HQpxghWN7hAKmXEPuvTMDByXIvq2YC7dZCC/+9FsITrc4fu3cOPYcSihY95KocGGBls7
         24fA==
X-Forwarded-Encrypted: i=1; AJvYcCWTbAOma9fOR79R195WPpltBFBZSEb8FVpMk3mo4d2LSvxhCdDdJEjXTFFTnXhLLKQP5qwWN1WNRsyCXFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaYUqNYegjrcQbOYRr11vX9CwndV7p7DfqKCPz01uQKZuNIrr
	9CGf8NIEhneDivXlppmSg9tggeG2FyedppYdstPQW8LAW3UkkWOJ6zqsBMrqyni8Q2ZjGtW3UOQ
	ZytovrpV5GGT5eyj/S1eAhCnd0e+53iHK7X4eqcOgvLc6WcXOadQaZLYItS6rPPMxKYrXFJQ2Bo
	ToExdHuw==
X-Gm-Gg: ASbGnctHmeY5ZkiD6axuWrSIrs0vtn6QrAqK++/9+2aIG8b36/N50gzahDiuHC1X37A
	XSuMSCSgAXolmvpcbIUe+C4ZMinAEeJ1cjQ/aSEkIy4kmSHPcAhjii1OPMfwA2Wsnt0wQbmvZN3
	DYJCwXM/Hbk//MXWtRsZERWrKOMPAhQKXa52A9YrMkllriMpN+paxK/3JMkAArtubpXP1LC3txO
	N2nXVePqBgWF9fLpIBKbFholY7ykmkzMDZTe45nWDKKmG3R1hNQogTfkI/SYI7XbJGKZdrpvIv6
	t3+Z28YuEl3ePcVslSLu1qqCHxxCmsgTVBfFpyWapC3kbGOIRnxRTzrMI0G62UOIjCcIMI9UIUU
	RMLlVJEts6WQpuLxd9fnrn2STrc7o6bEOJodQHfZre4tJbw==
X-Received: by 2002:a05:6512:6c9:b0:594:2e9b:f291 with SMTP id 2adb3069b0e04-59456b4d9c7mr941859e87.9.1762514509109;
        Fri, 07 Nov 2025 03:21:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMxJiPYMbXhmyW6GmkAmacMyTL5nlXaV1J2L1emWF3kyohSqrskKsInlGn9YLKNL5Se+Juzg==
X-Received: by 2002:a05:6512:6c9:b0:594:2e9b:f291 with SMTP id 2adb3069b0e04-59456b4d9c7mr941835e87.9.1762514508612;
        Fri, 07 Nov 2025 03:21:48 -0800 (PST)
Received: from [172.25.183.149] ([93.94.208.154])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a019d2asm1378089e87.26.2025.11.07.03.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 03:21:47 -0800 (PST)
Message-ID: <6d0fb6aa-6d88-4069-a5e5-9e910523888e@canonical.com>
Date: Fri, 7 Nov 2025 12:21:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
To: E Shattow <e@freeshell.de>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>,
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <c05d8bcc-3024-45cd-8630-b0595682e778@freeshell.de>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <c05d8bcc-3024-45cd-8630-b0595682e778@freeshell.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 12:11, E Shattow wrote:
> 
> 
> On 11/7/25 01:55, Hal Feng wrote:
>> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
>> SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
>>
>> Board features:
>> - JH7110S SoC
>> - 4/8 GiB LPDDR4 DRAM
>> - AXP15060 PMIC
>> - 40 pin GPIO header
>> - 1x USB 3.0 host port
>> - 3x USB 2.0 host port
>> - 1x M.2 M-Key (size: 2242)
>> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
>> - 1x QSPI Flash
>> - 1x I2C EEPROM
>> - 1x 1Gbps Ethernet port
>> - SDIO-based Wi-Fi & UART-based Bluetooth
>> - 1x HDMI port
>> - 1x 2-lane DSI
>> - 1x 2-lane CSI
>>
>> VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
>> VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
>> More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html
>>
>> Changes since v1:
>> - Drop patch 1 because it is applied.
>> - Rename jh7110.dtsi to jh711x.dtsi.
>> - Move the content of jh7110-common.dtsi to the new file
>>    jh711x-common.dtsi and move opp table to jh7110-common.dtsi.
>> patch 4:
>> - Move the uncommon nodes to jh7110-common.dtsi instead of board dts.
>> patch 5:
>> - Add jh7110s-common.dtsi and include it in jh7110s-starfive-visionfive-2-lite.dtsi.
>>
>> Changes since RFC:
>> - Add jh7110s compatible to the generic cpufreq driver.
>> - Fix the dtbs_check error by adding the missing "enable-gpios" property
>>    in jh7110 pcie dt-bindings.
>> - Rebase on the latest mainline.
>> - Add VisionFive 2 Lite eMMC board device tree and add a common board dtsi
>>    for VisionFive 2 Lite variants.
>> - Add usb switch pin configuration (GPIO62).
>> - Improve the commit messages.
>>
>> History:
>> v1: https://lore.kernel.org/all/20251016080054.12484-1-hal.feng@starfivetech.com/
>> RFC: https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
>>
>> Hal Feng (8):
>>    dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios property
>>    dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Lite
>>      board
>>    riscv: dts: starfive: Rename jh7110.dtsi to jh711x.dtsi
>>    riscv: dts: starfive: Split jh7110-common.dtsi and move opp table to
>>      it
>>    riscv: dts: starfive: jh711x-common: Move out some nodes to jh7110
>>      common dtsi
>>    riscv: dts: starfive: Add common board dtsi for JH7110s and VisionFive
>>      2 Lite variants
>>    riscv: dts: starfive: Add VisionFive 2 Lite board device tree
>>    riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
>>
>>   .../bindings/pci/starfive,jh7110-pcie.yaml    |   4 +
>>   .../devicetree/bindings/riscv/starfive.yaml   |   6 +
>>   arch/riscv/boot/dts/starfive/Makefile         |   3 +
>>   .../boot/dts/starfive/jh7110-common.dtsi      | 653 +----------------
>>   .../boot/dts/starfive/jh7110s-common.dtsi     |  27 +
>>   ...h7110s-starfive-visionfive-2-lite-emmc.dts |  22 +
>>   .../jh7110s-starfive-visionfive-2-lite.dts    |  20 +
>>   .../jh7110s-starfive-visionfive-2-lite.dtsi   | 126 ++++
>>   .../boot/dts/starfive/jh711x-common.dtsi      | 656 ++++++++++++++++++
>>   .../dts/starfive/{jh7110.dtsi => jh711x.dtsi} |  16 -
>>   10 files changed, 879 insertions(+), 654 deletions(-)
>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-common.dtsi
>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite-emmc.dts
>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dts
>>   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-visionfive-2-lite.dtsi
>>   create mode 100644 arch/riscv/boot/dts/starfive/jh711x-common.dtsi
>>   rename arch/riscv/boot/dts/starfive/{jh7110.dtsi => jh711x.dtsi} (99%)
>>
>>
>> base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
> 
> Small nit that "lite-emmc" is confusing together. In patches to U-Boot
> dev mailing list the EEPROM product id is demonstrated to be with "SL"
> suffix when compared to VisionFive 2 (JH7110) so I suggest avoid
> confusion in upstream and use for VisionFive 2 Lite (JH7110S) these
> compatible names:
> 
> starfive,visionfive-2sl-lite
> starfive,visionfive-2sl-emmc
> 
> Also filenames:
> 
> jh7110s-starfive-visionfive-2sl-lite.dts
> jh7110s-starfive-visionfive-2sl.dtsi
> jh7110s-starfive-visionfive-2sl-emmc.dts
> 
> What do you think?
> 

This is a serial number for the Lite board:
VF7110SL-2310-D002E000-xxxxxxxx

Here E000 encodes that we have no eMMC.

The S is part of 7110S which we already have in 'jh7110s'. And the L is 
already decoded as 'lite' in this patch series. Duplicating this 
information as 'sl' as you suggested provides no benefit.

Let's just stick with Hal's suggestion.

Best regards

Heinrich

