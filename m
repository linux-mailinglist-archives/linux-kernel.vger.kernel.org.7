Return-Path: <linux-kernel+bounces-844999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB073BC33FA
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 05:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26EA834D78A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 03:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBB92BDC3E;
	Wed,  8 Oct 2025 03:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="js7nAZ8f"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100E28CF5D
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759895205; cv=none; b=ENo7eNnOLAk1Hx91b6/mEoStBwlWYRhhyc8jUURVQgWsIBxfi9COeyWe9KprV0U+2TNtJkH1nguW2m2ZWbQquRrFE6Je2wmuKhC2/n6HaGM0x856hD8rXjE9F3P89rU7VGzUcjWafEYprUp9J9l0RNBA1GCT+tbmuMx+tEtrEMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759895205; c=relaxed/simple;
	bh=3QMft6hFPcBaa/lYo/phTtO2VA+5im+g45tD5qXqah0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NL95aZG1QX1Pgz4jIMMavc3SUmJ9oKZOA7UoOWb+B/hNXfCHOjQW6zSItNy+rj5CGiXo9AQNpCdD0xlzCYMjtqMw+ZoP3b2IHWKyfRW3977mwwahI4U1i29vB9udd6/LPOiRM1hUAUKZ1kfzhN7TWvYFYqHRYCfqE3r5/qCp9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=js7nAZ8f; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so1867802f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759895200; x=1760500000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5BPOIjsWE1/ylQ6v8pAFpShIKTzil2RhB4Wuts88zo=;
        b=js7nAZ8ffIlHrTVFLoS7WfjO3EauE57RmgrC/ZsFFM69mDCxJGBcc8VrrJ0aQ0SyZb
         mOy92PL2apwlKfD4QWN6rnlofkg+++FCCsR25NJ1t387RuvTe9Eit9NDGXuqF8TsSKrG
         4KChDcMps801WCmYCzgAC8Iuof9y0PZ62dLfDf9X1wpw3yTU68Gtv/q36laZlo8du0Is
         PQKsu3yMswSKnL2WfqTMxoOCMrDobtqmG2wt2DILIDnEtGCsn2dm7RxYK29QJdMp3Zan
         JzgpzSaRfdjwLhRR7EIp337EYOWEUJe4ATrmG0zh4w4R1KRN3jrkVq+90sEhbXc1U7Uf
         mAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759895200; x=1760500000;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y5BPOIjsWE1/ylQ6v8pAFpShIKTzil2RhB4Wuts88zo=;
        b=Y2VnQTNHTjuD22gvVliAqwvvdVIgx2nfWyNZWDwfnIQp4nRWOCHvVA59TfTrEQ/2WW
         F9v+a8w2k2gO8kOKoNPmCpIqkwHylhnMQT1t3in4jAQKPymjrZ4OGvq1N/fovBZvyhgK
         47PDoJub/zMjeIVmnQ6DDK27s6wdyYH291aeKUYSPcA+4xuu3qGT5OO27S29oAsJuhOm
         qq/JPR7XdkhI5Z+BY3sR3x+dBPVYUs1rXx3Jv66vVb2LMTx6u1rtWNveyjPpNOXHPvtP
         RAY3aT/lzDhlpCEzKWRNT7hXG7fZieP8ZSrK6XGoOrH7eerg1FzSVSu1/YtLZXIDQPyG
         n11w==
X-Forwarded-Encrypted: i=1; AJvYcCVYI6vSmR+H1AkxS6N0ErYI8/iImUIy40v8ol8vYYLW5OtDApODdHBxsq5Y93fITwkXbkIdLdF7STZ+FOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmRM/VNav5PAjHTFzCZeMDzxfuYnmfrRwNQdvNouKP2AF3axT
	FPkbkPbVBCDqQxqNHOoi8pGugQlkamEolrPKMR0fXL0o5zNrI6KJe3ZzAtIgSl5RIUg=
X-Gm-Gg: ASbGnctHl5vbqOcRkcUPmAFBeosSIxbcKnfmxct0zqLUZEGgquj3AFZk9Op9VKXejqf
	22gL4kkG8IZgPV+ZRmWGYXs2027MmcVWRwgb10TIgqx6s857OEfxhH3kPaiqULHeXzKP+wAk617
	m5bkyTYRnoea5Uwq+Cu6XEHAzSIUVph9gQZ3OBMr3BSpK3ZT0NQBFVsPkh+CVleKuYCkLBAcelb
	b86H7rFH15Wtt7r7rFP9X66BQytaKlgNXqUNx29fdkNbhjyMdATC3XFBiQpoXwuyQzBHLg6e5pK
	pPW0ndgvpx6iJcjqpa9mCDNJua9VfDuvsNBOJ5jFL1ajZt+cbCuWS/ixFuKZy7l0Bowq50JbV11
	hvnt0ncrHpS1nUSchz0NZ/8usDP5aasXQhn1r831ycD2K78YJagYspw==
X-Google-Smtp-Source: AGHT+IGdutdUlJNoGkvkhbfo2LkWoyZ57BkVvhnxY6uM1c5I/D/2/OJ2CJ1R4mSfF296Vl2OkTgIzA==
X-Received: by 2002:a05:6000:40dc:b0:3e9:f852:491 with SMTP id ffacd0b85a97d-4266e8e4b75mr875206f8f.56.1759895200467;
        Tue, 07 Oct 2025 20:46:40 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm27259681f8f.19.2025.10.07.20.46.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 20:46:39 -0700 (PDT)
Message-ID: <91284777-a118-4f79-b9b1-e8c95a1ee53b@tuxon.dev>
Date: Wed, 8 Oct 2025 06:46:36 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/7] Add initial USB support for the Renesas RZ/G3S SoC
To: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, p.zabel@pengutronix.de, geert+renesas@glider.be,
 magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
 biju.das.jz@bp.renesas.com
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20250925100302.3508038-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping. Apart from Geert's comment, could you please let me know if
there are other comments on this series?

Thank you,
Claudiu

On 9/25/25 13:02, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds initial USB support for the Renesas RZ/G3S SoC.
> 
> Series is split as follows:
> - patches 1-2/7		- fixes on bindings and driver for USB PHY
> - patches 3-5/7		- updates the rzg2l-usbphy-ctrl driver and documentation
> 			  with support for setting PWRRDY though SYSC
> - patches 6-7/7		- add device tree support
> 
> Merge strategy, if any:
> - patches 1-2/7 can go through the PHY tree
> - patches 3-5/7 can go through the reset tree
> - patches 6-7/7 can go through Renesas tree
> 
> Thank you,
> Claudiu Beznea
> 
> Changes in v7:
> - used proper regmap update value for PWRRDY
> - collected tags
> - dropped Tb tags from dt-bindings
> 
> Changes in v6:
> - in patch 2/7 dropped the struct rcar_gen3_chan::rstc as it is not
>   used anymore
> - in patch 4/7 used syscon_regmap_lookup_by_phandle_args()
> - collected tags
> 
> Changes in v5:
> - dropped patch "soc: renesas: rz-sysc: Add syscon/regmap support" as it
>   already modified and pubished also at [2] with the latest review comments
>   addressed
> - fixed the documentation
> 
> Changes in v4:
> - replaced "renesas,sysc-signals" DT property with "renesas,sysc-pwrrdy"
> - dropped the "renesas,sysc-signals" property from USB PHY (as proposed
>   in v3) and let only the USB PHY CTRL driver to handle it as on RZ/G3S
>   the USB PHY CTRL driver needs to be probed before any other USB driver
> - dropped the signal abstraction from SYSC driver as there is no need
>   for reference counting it now
> - adjusted the "soc: renesas: rz-sysc: Add syscon/regmap support" to
>   comply with the latest review comments
> 
> Changes in v3:
> - as the basics of the SYSC driver was integrated, only the signal support
>   was preserved in this series, in a separate patch; patch 01/12 was
>   adjusted (by addressing the review comments received at [1]) as it is
>   necessary to build the signal support on top of it
> - after long discussions with the internal HW team it has been confirmed
>   that the relation b/w individual USB specific HW blocks and signals
>   is like:
> 
>                                    ┌──────────────────────────────┐
>                                    │                              │◄── CPG_CLKON_USB.CLK0_ON
>                                    │     USB CH0                  │
>     ┌──────────────────────────┐   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK2_ON
>     │                 ┌────────┐   ││host controller registers  │ │
>     │                 │        │   ││function controller registers│
>     │                 │ PHY0   │◄──┤└───────────────────────────┘ │
>     │     USB PHY     │        │   └────────────▲─────────────────┘
>     │                 └────────┘                │
>     │                          │    CPG_BUS_PERI_COM_MSTOP.MSTOP{6, 5}_ON
>     │┌──────────────┐ ┌────────┐
>     ││USBPHY control│ │        │
>     ││  registers   │ │ PHY1   │   ┌──────────────────────────────┐
>     │└──────────────┘ │        │◄──┤     USB CH1                  │
>     │                 └────────┘   │┌───────────────────────────┐ │◄── CPG_CLKON_USB.CLK1_ON
>     └─▲───────▲─────────▲──────┘   ││ host controller registers │ │
>       │       │         │          │└───────────────────────────┘ │
>       │       │         │          └────────────▲─────────────────┘
>       │       │         │                       │
>       │       │         │           CPG_BUS_PERI_COM_MSTOP.MSTOP7_ON
>       │PWRRDY │         │
>       │       │   CPG_CLK_ON_USB.CLK3_ON
>       │       │
>       │  CPG_BUS_PERI_COM_MSTOP.MSTOP4_ON
>       │
>     ┌────┐
>     │SYSC│
>     └────┘
> 
>   where:
>   - CPG_CLKON_USB.CLK.CLKX_ON is the register bit controlling the clock X
>       of different USB blocks, X in {0, 1, 2, 3}
>   - CPG_BUS_PERI_COM_MSTOP.MSTOPX_ON is the register bit controlling the
>     MSTOP of different USB blocks, X in {4, 5, 6, 7}
>   - USB PHY is the USB PHY block exposing 2 ports, port0 and port1, used
>     by the USB CH0, USB CH1
>   - SYSC is the system controller block controlling the PWRRDY signal
>   - USB CHx are individual USB block with host and function capabilities
>     (USB CH0 have both host and function capabilities, USB CH1 has only
>     host capabilities)
> 
>   Due to this, the PWRRDY signal was also passed to the reset-rzg2l-usbphy-ctrl
>   reset driver (as it controls the USBPHY control registers) and these
>   are in the USB PHY block controlled by PWRRDY signal.
> 
>   The PWRRDY signal need to be de-asserted on probe before enabling the module
>   clocks and the module MSTOP. To avoid any violation of this configuration
>   sequence, the PWRRDY signal is now controlled by USB PHY driver and the
>   reset-rzg2l-usbphy-ctrl driver.
> 
>   As the PHYs gets reset signals from the USB reset controller driver, the
>   reset-rzg2l-usbphy-ctrl is probed before the USB PHY driver and thus,
>   in theory, we can drop the signal support (reference counting of the
>   USB PWRRDY) and configure the USB PWRRDY just in the reset-rzg2l-usbphy-ctrl.
> 
>   However, to have a proper description of the diagram described above in 
>   device tree and ensure the configuration sequence b/w PRWRDY, CLK and MSTOP
>   is preserved, the PWRRDY signal is controlled in this series in all the
>   drivers that work with registers from the USB PHY block.
> 
>   Please provide your feedback on this solution.
> 
> Thank you,
> Claudiu
> 
> [1] https://lore.kernel.org/all/20250330214945.185725-2-john.madieu.xa@bp.renesas.com/
> [2] https://lore.kernel.org/all/20250818162859.9661-2-john.madieu.xa@bp.renesas.com/
> 
> Changes in v2:
> - dropped v1 patches already applied
> - added fixes patches (07/14 and 09/14)
> - dropped the approach of handling the USB PWRRDY though a reset controller
>   driver and introduced the signal concept for the SYSC driver; because
>   of this, most of the work done in v1 was dropped
> - per patch changes are listed in individual patches, if any
> 
> Christophe JAILLET (1):
>   phy: renesas: rcar-gen3-usb2: Fix an error handling path in
>     rcar_gen3_phy_usb2_probe()
> 
> Claudiu Beznea (6):
>   dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
>   dt-bindings: reset: renesas,rzg2l-usbphy-ctrl: Document RZ/G3S support
>   reset: rzg2l-usbphy-ctrl: Add support for USB PWRRDY
>   reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
>   arm64: dts: renesas: r9a08g045: Add USB support
>   arm64: dts: renesas: rzg3s-smarc: Enable USB support
> 
>  .../bindings/phy/renesas,usb2-phy.yaml        |   1 +
>  .../reset/renesas,rzg2l-usbphy-ctrl.yaml      |  41 +++++-
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 118 ++++++++++++++++++
>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  |  57 +++++++++
>  drivers/phy/renesas/phy-rcar-gen3-usb2.c      |  20 ++-
>  drivers/reset/Kconfig                         |   1 +
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c       |  66 ++++++++++
>  7 files changed, 292 insertions(+), 12 deletions(-)
> 


