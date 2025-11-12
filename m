Return-Path: <linux-kernel+bounces-897323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB5DC52950
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1FF1896092
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AA92517AA;
	Wed, 12 Nov 2025 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="hsdpXgJM"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FF226D18
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955657; cv=none; b=AvuYT5mXEyGogN34Rb/wPK6iaifdukpqVJmhQyaN+AGm34GDVB5dHj9bAqtQAXmw3h5/hsJ35ZDkcuDuQynWX6qjWhi/S41GH0phXVFYaUaBbkG3Q/qlJorjK2H2HsT/H1Z38nZaococlTI1BxrbiKNMfwKKM1m/QAR0BvmAvjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955657; c=relaxed/simple;
	bh=I4I3WIzpcjfsDiSTgOlk8Atq3GBfqXf8GVaWSsFqgPk=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0+2BDXOiWJ23P0LvrA1STbaXyCH/wVOuynyO1yFTNUpQJmNm25ImWW7pnkMRM/D6CNbesWTmPK2us7wyhN3NQsH1h6pCPnRbsHdGOQ3Uk415E8TszA9Dbjeck8lLjFepuNoXVpEyUNP3yNw5GVrWW3l4Ih5iIQYXFklcDL/Fjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=hsdpXgJM; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F30283FE52
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1762955653;
	bh=zw6ziSjkzQiRWUig0BOelMJ1uVjsDF/5GnnR77Yu8HA=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=hsdpXgJMAydUIOB7t7ofMm1qDz0A5vu797vtyyMnP2jp4IsYK4e341ND/8beHfh38
	 hUi7/UpnjGORgczQdqNjPWInsVsQz0YlqcPxcDxkV+rklq4A54dsKca2wIQijmsGuB
	 QST2DEYeq0AiR0vTh/ODHvoA2jxzDIzCohys3fmmpiJfw96yoecfghKxNp/8g38IYv
	 KFegDqO7rXryAXIPpzHIq2akrWGcNHSo68DNQdHASUq35uQ4leuQekv6Oa+Pr+sto2
	 Q3xpB2sjnGzHM6AFEoPDACFxld1ritDzMYIgrlDawC5v6mtGErKffmBbQVfPKkRXmA
	 JBjCgPCmii7EtCkxqa0gH8UCPuRmbliAQIpC+FOcvdpCqS/QIvoLBdJQVbHXRuhvTE
	 cn/48DlIVtVQ9Xu/OxWAoJEqoQTzU7KQo/7OQLgtu3F26DJgoQ/J9QWrsgAR03hciX
	 hQsT1jsVvwuE4PmwcPh2Mp2DOIqj/OGjEWwPILcj5PEanzqtBl21DFxChzQgd9eOWB
	 land2u42aClQ/SnDYcaUFTvhC6rCyZS4Wo+v4Z2qrka5PpkeExWXzsHg+hx0+m5kgr
	 i+rZaI86Z49rt9z759t2RPLez1Rzi/VmQlX3ZK6OG7PpmBEL5VOUKqXIEsa34hVB9k
	 ytBM1dBENuv8wFMyM+Pwncq8=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b7336ad128cso64073966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:54:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955652; x=1763560452;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zw6ziSjkzQiRWUig0BOelMJ1uVjsDF/5GnnR77Yu8HA=;
        b=ZgN7SmVVk+AttWUXda5Eevc3Ur/Ti7hhAnaHWOAPSHoU9P4v4xgCZzEDNiTzsUACiw
         nQxc6iUJEF2YhqgKckmuyZJdSeoKQ6TnzkX4OyGiRuTywqh/DxwXp7M6YQUStiRQo2vU
         bbwD4xsH1vqP20yzD+jnBhVpN7OzSQeZDuzGF1692jEQS+riw3E++Y2wDP9b4RmcUz8M
         3+NUF/a8YfqNi5Uq6bWdVJQHajxwBHurxLrwi1gc6jknma9ttITiN/672Q1yF7zqDkrg
         7lwSVHgHf/oSSQxBXimnDxZPBVVOrxXXSuMGlT792t4+hgIeExelMCGQ9wIDvPVI4OCg
         Manw==
X-Forwarded-Encrypted: i=1; AJvYcCV030U2HAQ/WIBDh3pvujISuttjcLbnCEY7eJnRer46b7KzTcoR1ThSukj0dkQ8+0/jZfkhOgfaW5vSKaw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh14xmY0m1k1i5Xmk8tXq6XT0BEDfj/hnhzzqfjj+lxD9LSn3E
	jCJWsWKYIzItgEn1lugYJpNwZ4ZuhC6Eo0HXj4AnNEF4YpKuQ8wK3OgTQdSODhEqvgVTF4xLasG
	F6YV+6aUwz7i6OJERu8zg1KJOKJU++2e57iiFLcSsJ3bueW1GkjJtxyZ/Kv0q8j1sgPspd8GnEG
	n19SItfXy0TV4aMieGaFqt8/7zSvw066C7OvUCyEOMpQSoSV3psVgnB/ND
X-Gm-Gg: ASbGnctoJR5a0TpLl5wpjbZypAT/XNGkGub7J81gJwYUrJLRePqFvA+4xGgmvAwd8Mr
	YMfGTbZdpTc9WOw3YHsF9zW/5XIPo84fNjCg+Xn8dfgp4DMyqIb1AFtEVh5/rwbLipe9pfqwV5C
	+fI68mdM6777XNhuUSuxTHvhjyunwR5wRWelcSoMFtZeaZHAAzZWTQEwQb26L4PZJuq+3a0j/cW
	jk3NiE81Knd
X-Received: by 2002:a17:907:3f0b:b0:b72:599:5385 with SMTP id a640c23a62f3a-b7331aed080mr274451966b.61.1762955651979;
        Wed, 12 Nov 2025 05:54:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHASu3IyWs8sdfwZaJ3pNAVG0SXfiJ1YnPjXsl7ym/EOc9nMzNozT0R3ShCHNy28iULSDnVopmBypGnnGPw+tE=
X-Received: by 2002:a17:907:3f0b:b0:b72:599:5385 with SMTP id
 a640c23a62f3a-b7331aed080mr274448466b.61.1762955651487; Wed, 12 Nov 2025
 05:54:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 05:54:10 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Nov 2025 05:54:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251107095530.114775-1-hal.feng@starfivetech.com>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Wed, 12 Nov 2025 05:54:09 -0800
X-Gm-Features: AWmQ_bkCo556C5q4g3w_mabHlgyG7zuhHtzy3L72tGDQo2o37ahEt_qsjrthSBY
Message-ID: <CAJM55Z_rczBo4D3HsC90QW1=fp3NWgK-tsEo6LHTZNXEBHTDqA@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
To: Albert Ou <aou@eecs.berkeley.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, E Shattow <e@freeshell.de>, 
	Hal Feng <hal.feng@starfivetech.com>, 
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Hal Feng (2025-11-07 10:55:22)
> VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S industrial
> SoC which can run at -40~85 degrees centigrade and up to 1.25GHz.
>
> Board features:
> - JH7110S SoC
> - 4/8 GiB LPDDR4 DRAM
> - AXP15060 PMIC
> - 40 pin GPIO header
> - 1x USB 3.0 host port
> - 3x USB 2.0 host port
> - 1x M.2 M-Key (size: 2242)
> - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> - 1x QSPI Flash
> - 1x I2C EEPROM
> - 1x 1Gbps Ethernet port
> - SDIO-based Wi-Fi & UART-based Bluetooth
> - 1x HDMI port
> - 1x 2-lane DSI
> - 1x 2-lane CSI
>
> VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
> VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
> More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html


Hi Hal,

Currently the JH7110 device trees are layed out like this, with a nice
separation between the SoC description and board descriptions:

jh7110.dtsi               # JH7110 SoC description
|- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
   |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
   |  |- <VF2 boards>     # Final VF2 board descriptions
   |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
   |  |- <Mars CM boards> # Final Mars CM board descriptions
   |- <other boards>      # Other JH7110 board descriptions

With this series it moves to

jh711x.dtsi
|- jh711x-common.dtsi
   |- jh7110-common.dtsi
   |  |- <jh7110 boards>
   |- jh7110s-common.dtsi
      |- <jh7110s boards>

..which I can't even give clear labels like above. In other words when new
patches are sent in it would not be easy to explain exactly where each change
should go and why.
I'm also worried that you'll find that more of the peripherals on the JH7110S
need special handling and a new jh7110s-... compatible string. Then I guess
they'll need to jump from jh7110x.dtsi two levels down to jh7110{,s}-common.dtsi
which then both describe SoC and board properties.

If you're serious about calling this a new SoC then I'd expect something more
like this:

jh711x.dtsi                  # Peripherals common to both SoCs
|- jh7110.dtsi               # JH7110 SoC description
|  |- jh7110-common.dtsi     # Peripherals common to all JH7110 boards
|     |- jh7110-starfive-visionfive-2.dtsi # Peripherals common to VF2 boards
|     |  |- <VF2 boards>     # Final VF2 board descriptions
|     |- jh7110-milkv-marscm.dtsi # Peripherals common to Mars CM boards
|     |  |- <Mars CM boards> # Final Mars CM board descriptions
|     |- <other boards>      # Other JH7110 board descriptions
|- jh7110s.dtsi              # JH7110S SoC description
   |- jh7110s-common.dtsi    # Peripherals common to all JH7110S boards
      |- <JH7110S boards>    # Final JH7110S board descriptions

I know this will mean some duplication in jh7110{,s}-common.dtsi, but I would
prefer that to not having a clear explanation of what each file describes.

Do you think this layout could work for you?

/Emil

