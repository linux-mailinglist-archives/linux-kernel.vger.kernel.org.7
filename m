Return-Path: <linux-kernel+bounces-753284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D174B18106
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762181C229F4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 11:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBC245007;
	Fri,  1 Aug 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="JY/2zdlX"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A1A20F087
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754047488; cv=none; b=Stnomm07NPdrEffFtje2hXe6nsVF8o3D0rPcHPiQDd3XdBYvwZ6IQYP6gNLcHymZBo3X8alZmvrRBdE1E2sOW5cM4n/QedIupyvnQDaNKJ0tc4zYOt5GybTH7i862NHlbjn2P6xS41KrzVpsF/ppJvv9HyP6G1T00zZrjfl6j2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754047488; c=relaxed/simple;
	bh=SRLyX5lnzN18Dbb631IaOjMakdacyZqijP0KLd6j8MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=noDUovvuzfPvyxANrlOI4j5fX7fO5n+OvaJe8rQ1tfPmcr2OhI1Ee31ML4IlzlQG0Pw/ELSUR8AIYF5++biCa6jHFHwEuoKOC8GxfzVc0PKwDN6kmmvWI5fvAPIqpb5kjlNvDpv5EB++27lT2PB8zfqsZXR7WgE4GeXlb+AIqxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=JY/2zdlX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af66f444488so144076066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 04:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1754047484; x=1754652284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WhG5DbnyNiSNFxOr3+CmfhAT0XiWxX1Ob5TAR60O8tE=;
        b=JY/2zdlXPzaJ7SrExmjybACzGdzMZYorgx7SerQWaA/dDOam4xnQilyeksM6txrTta
         /k8rXvrWvmcF4+O/E3MCB9HBW41TAzNmX7KsvtIoXda4PdqIHugPnmSXKn+pinBhvg5B
         NcmCnhK+kH+brGI2U4OdHo4i/C4BYv1CDSukQaKQ3TWo/IvoBvgu4IgLw8FBh7civJvs
         7NrzWodRjsDJBhZiYzqEyvxmqOC0zGoUJMifkaOZPYjihrdA4NtRTYsEWBH0OMFkGXMy
         aK6PiG0QtslPOZqFUA3qFxnwoqLZCKBUKxcRQMarUYpZ01d1A8pHJEJZ5JP2Ifo4E90v
         a8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754047484; x=1754652284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WhG5DbnyNiSNFxOr3+CmfhAT0XiWxX1Ob5TAR60O8tE=;
        b=SEXHKFn4NZGm9SBPby6t+Nd3e9RxOqkviTbjGVElV8l0/qZvO1uTjOaCqYbbJMcDCT
         HlFFpnh3xogxN3X7U/SjLRp63WHRQUfBkm5mV/ozueOzisCQFELEiaexOZ7nb/BWJWys
         h0HCTg8nVstmVQJWO0YDlQeVGgedL/eOQhVHhsoELYOL9lvPkXCsdqsR73MxkkyNLxtB
         zNcNam6RLJeOP5W4xRpjHjKwD6v7WTFCqExmxtF97aAPzsebF+8q0rz80Gmk3pDRyigv
         pV6TRVJppfdLpRSjTZKmu93qhPLlZiH6uNXQ5mEyo99EFbwHA8Dw8aeXCQAJDOC0HouF
         m7ng==
X-Gm-Message-State: AOJu0YyUooQZaAhLgPL+j5Gr1PqUHDd6Hd7LASCoAceEtDw+qXPblOev
	82YFAcP3mMlClZlGKhKo3WablnQulukNBECbtNC3luLQz1yCFjKPS+ga/QD9N4q/sf5oOorhTXR
	GwrSrA1Qa
X-Gm-Gg: ASbGncsXHjYvvP5BZCxV3lMeucX9wTYAoIavZ8n2biPPVkIDTYvNfVF4hvkzWF8ZA45
	6VjGLMZAKhT6y6SASZQnPcdg6rayRoTCxiMN20y2mEsYfNfGaxkoyhWLB4aWXa8hmX3DrENfgqk
	4GmEZneWe8xbe8Ozx66PA9ChPWAjnLmIzkl5SoVlaSjjjEeuXV75x1+d8CYOGiRtxwNOpHfWa3V
	ay0Pl6D6RzhIW7bt+ZJuogkSgX1rEHC12WoMBR/FF6F2bvYIH/Cc+GFTgnrknpc4US7GT0w3gKY
	iLQz+TmGbL590wS/6yANj79JhmVJaLQJXVcLRPgbqPA4AlcXIJywdHL/nR+9SL3Z0EkxUBpjras
	jhzPh1jRpSDCEIwuuC2QpGUiF
X-Google-Smtp-Source: AGHT+IGAEwxmM6s8rcf+dLmLhqgPa7qSr1WrKscGfc7YN47rj1asFrZD+UvRmLT4EZYOZoO7IqhLxg==
X-Received: by 2002:a17:906:c149:b0:af9:35f0:7a0f with SMTP id a640c23a62f3a-af935f07da4mr192102566b.28.1754047484211;
        Fri, 01 Aug 2025 04:24:44 -0700 (PDT)
Received: from [10.254.183.223] ([149.199.62.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c06bsm272442466b.119.2025.08.01.04.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 04:24:43 -0700 (PDT)
Message-ID: <64e24ac1-e0dc-4d0c-a9ab-8bb26f5acdcb@monstr.eu>
Date: Fri, 1 Aug 2025 13:24:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] arm64: zynqmp: Add support for kr260 and kd240
To: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <cover.1752837842.git.michal.simek@amd.com>
Content-Language: en-US
From: Michal Simek <monstr@monstr.eu>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cover.1752837842.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/18/25 13:24, Michal Simek wrote:
> Hi,
> 
> add description for k24 and kr260 with kd240 boards.
> Pretty much both k24 and k26 SOMs can be plugged to other carrier cards but
> not all combinations are tested together.
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (3):
>    dt-bindings: soc: xilinx: Add support for K24, KR260 and KD240 CCs
>    arm64: zynqmp: Add support for kr260 board
>    arm64: zynqmp: Add support for kd240 board
> 
>   .../bindings/soc/xilinx/xilinx.yaml           |  81 ++++
>   arch/arm64/boot/dts/xilinx/Makefile           |  24 +
>   .../boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso | 390 +++++++++++++++
>   .../boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso | 438 +++++++++++++++++
>   .../boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso | 451 ++++++++++++++++++
>   .../boot/dts/xilinx/zynqmp-sm-k24-revA.dts    |  23 +
>   .../boot/dts/xilinx/zynqmp-smk-k24-revA.dts   |  21 +
>   7 files changed, 1428 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kd-g-revA.dtso
>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revA.dtso
>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kr-g-revB.dtso
>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k24-revA.dts
>   create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k24-revA.dts
> 

Applied.
M
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs


