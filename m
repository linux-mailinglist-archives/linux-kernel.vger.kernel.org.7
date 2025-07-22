Return-Path: <linux-kernel+bounces-740768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE022B0D8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2091692C1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBD2E499F;
	Tue, 22 Jul 2025 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ImHw6M2L"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8D21E32D3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753185898; cv=none; b=OVgccYF8CPmoI7G0ftLZ+IeUsF0t8zqpLkd/BOclCgn6UHKq4wRt87YuCG4GYcYjT11j3lln8LFQ1/UQ+E9Jpg3Tm5WFg7tK/ZTLA4NsBgaLt7kj8ICK1WufU/bLljJkXjj/AyN8aD2/T/t66GvJ87PYFxbSbwPtmznR1JcS4ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753185898; c=relaxed/simple;
	bh=nbyIpft8djPZrtb8ThK8M3ReonlR2H0hGR8xu4IjR1w=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=SbMzrr2CTtf/45xIy4qUqUQMbkzS2Ks8okYac+AixHKifrvEcOIZ1TxC8TzSdwSK4BUv85tCrDnmDVgNWBxt2h4qbaD+XnP4NuA+D+mTLciWD4wsDTHOMWAdQnsJjarMxXXOLW4/uSm17FlIndJzAugPm446o7NI5pc3P8Q5V5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ImHw6M2L; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so24799485e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753185895; x=1753790695; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wpi/p9fCXy5/a0jR7mIeMlMhneDcTDMyjTiv0Pm3Vxc=;
        b=ImHw6M2LB/KreMWIz7c2wwUhGkOnviyJTKkdyTtYjuAi2jT1LMpuisZ/xjNMX7hXab
         lbPOYzW+L6k5OKtULn6pqSQflBAAZTFyr7U8rU15VEX60tbRvInpA6OZ/bf0g33eTaHE
         dTlyQRA3VslwTqqdmaufKsz2CEwKXYAg5sY7FZmFtKH0Bl7we67KqyRcHsXdikWnZdD/
         wXfgSpiMXXJlQrD0jF50Kb59RD1c5np3otq2q059NjKjpi9Om/4WiCaWsxUNA/BydUBp
         SgYFQOk7usQZz3ObuFq+T9bSuJCOiCV18qdk972oveyBS+FbM71WtK55SOGUKRXbDi4U
         fEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753185895; x=1753790695;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wpi/p9fCXy5/a0jR7mIeMlMhneDcTDMyjTiv0Pm3Vxc=;
        b=sMdudFNa/mRNb3FvqQ6qWYmrcOcM4KAv6nr3dmemMla4W1rahFdj43kbDU0cqIgBGA
         j4THhcPrePrb/3YY5nwHNJNihst8Ep6LfONe8LW+R4hMBxc+JgzIqPwM7ovM94cI3IhW
         EgtMBwdN6oLKV5Ypnd1k+qj8KeqUpGL3NaeiyXT8vcdNHccDAULUMRxjTrGGybDNYaf0
         P5asPglEjyZVPpdkuTbZ+/Sp4m1RUesyhil8j10WGG6ncLFpZNNb6svHov55E5rLaPyn
         tpc1UM9axamXnvZE9m3xCXq9ZmlC6NYKKu9Z2j1xbZneIfknkX57RucDoisg6qOHCEb3
         qaxw==
X-Forwarded-Encrypted: i=1; AJvYcCXSuJM5TDEutX/+J4xOUyXJkFPYQGsDomoi7lz7e/z10KUBAg/fCbkgoCpmY16P7qq12C8tNo6wdaGhxO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAruE2cGHB31HuB7IbfTTRlI3E1RwJVgOVJQwQTJFXeJnGLy7F
	tp5q0Ae7xadVjfe+PQ6fm1SBlX87WXy1ffDhvT5/GqV6o4OLIXsHMYhWuPnxTrUxp4g=
X-Gm-Gg: ASbGncvm27mCl2CWEp5pHh/ndIjBPx4UuMt4FBnR5Ai8OlcsgBnvKvF3sqAGmBSV7N8
	nTutgSNQvAQDWQC/1w/Ekh/gWbHP+IYkz0JrJAp5sb7LClZGToaFjAa9rXkn6kdJKfaPEDrDqRi
	lvu+YySjw0QvdfVsGOIxlCTG/t0dnxHrUS5M5+l3ZkRUPSuEHSlrLds/XAvLVs7NbEH7P3QlMFH
	JteX8qgX/+zamRp8PUwOWcncnxcGT0Pfjp57qBox5vfUkw11LMidNzeZ7Utx5+Qo0XW53dNlcrV
	wU/xeuJaYqt0n/qLo+VXrXUVWzCwgL1hhcA79PW16TjGVoenw8IRP9XAo5//AaQLT4/CZnoEv3k
	OxKfj153Uxtx3W2POa7M3OpXqB6X2Y/INFwZJm7FN15XG/eZjLI4srKmhB1k=
X-Google-Smtp-Source: AGHT+IHKGGQiBGHC/lZvh9QmUqgGiyupYCkQAkEaoPTX8mU+rea8xDmE81eZvOU0q9A8pejyeiN5dQ==
X-Received: by 2002:a05:600c:a306:b0:453:84a:8cf1 with SMTP id 5b1f17b1804b1-4562e30bb16mr142762415e9.33.1753185895103;
        Tue, 22 Jul 2025 05:04:55 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c9e2sm13523548f8f.89.2025.07.22.05.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 05:04:54 -0700 (PDT)
Message-ID: <f8829843-111e-460f-9081-ee46c1f96ebc@linaro.org>
Date: Tue, 22 Jul 2025 14:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Mason Chang <mason-cw.chang@mediatek.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 David Collins <david.collins@oss.qualcomm.com>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Aaron Kling <webgeek1234@gmail.com>,
 Linux PM mailing list <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] thermal drivers for v6.17
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider the following changes since commit 
d7b8f8e20813f0179d8ef519541a3527e7661d3a:

   Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.17-rc1

for you to fetch changes up to 1d264d3a198839c7483580acdce17e1015d0ef91:

   dt-bindings: thermal: tegra: Document Tegra210B01 (2025-07-21 
22:23:39 +0200)

----------------------------------------------------------------
- Enable the stage 2 shutdown and support to more SPMI variants
   (Anjelique Melendez)

- Constify thermal_zone_device_ops structure when possible in the
   different thermal drivers (Christophe Jaillet)

- Use the dev_fwnode() helper instead of of_fwnode_handle() which is
   more adequate wherever is possible in the thermal drivers (Jiri
   Slaby)

- Implement and document One-Time Programmable fuse support for the
   Rockchip driver in order to increase the precision of the
   measurements (Nicolas Frattaroli)

- Change the way the Mediatek LTVS driver stores the initialization
   data sequence to support different sequences regarding the current
   platform. Introduce the mt7988 support with a new initialization
   sequence (Mason Chang)

- Document the QCom TSens Milos Temperature Sensor DT bindings (Luca
   Weiss)

- Add the fallback compatible string for MT7981 and MT8516 DT bindings
   (Aleksander Jan Bajkowski)

- Add the compatible string for Tegra210B01 SOC_THERM driver (Aaron Kling)

----------------------------------------------------------------
Aaron Kling (1):
       dt-bindings: thermal: tegra: Document Tegra210B01

Aleksander Jan Bajkowski (1):
       dt-bindings: thermal: mediatek: Add fallback compatible string 
for MT7981 and MT8516

Anjelique Melendez (4):
       thermal/drivers/qcom-spmi-temp-alarm: Add temp alarm data struct 
based on HW subtype
       thermal/drivers/qcom-spmi-temp-alarm: Prepare to support 
additional Temp Alarm subtypes
       thermal/drivers/qcom-spmi-temp-alarm: Add support for GEN2 rev 2 
PMIC peripherals
       thermal/drivers/qcom-spmi-temp-alarm: Add support for LITE PMIC 
peripherals

Christophe JAILLET (2):
       thermal/drivers/loongson2: Constify struct thermal_zone_device_ops
       thermal: Constify struct thermal_zone_device_ops

David Collins (1):
       thermal/drivers/qcom-spmi-temp-alarm: Enable stage 2 shutdown 
when required

Jiri Slaby (SUSE) (1):
       thermal: Use dev_fwnode()

Luca Weiss (1):
       dt-bindings: thermal: qcom-tsens: document the Milos Temperature 
Sensor

Mason Chang (3):
       thermal/drivers/mediatek/lvts_thermal: Change lvts commands array 
to static const
       thermal/drivers/mediatek/lvts_thermal: Add lvts commands and 
their sizes to driver data
       thermal/drivers/mediatek/lvts_thermal: Add mt7988 lvts commands

Nicolas Frattaroli (4):
       thermal/drivers/rockchip: Rename rk_tsadcv3_tshut_mode
       dt-bindings: rockchip-thermal: Add RK3576 compatible
       dt-bindings: thermal: rockchip: document otp thermal trim
       thermal/drivers/rockchip: Support reading trim values from OTP

Ye Zhang (1):
       thermal/drivers/rockchip: Support RK3576 SoC in the thermal driver

  .../bindings/thermal/mediatek,thermal.yaml         |  27 +-
  .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   2 +
  .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
  .../bindings/thermal/rockchip-thermal.yaml         |  62 +++
  drivers/thermal/armada_thermal.c                   |   2 +-
  drivers/thermal/da9062-thermal.c                   |   2 +-
  drivers/thermal/dove_thermal.c                     |   2 +-
  drivers/thermal/imx_thermal.c                      |   2 +-
  .../intel/int340x_thermal/int3400_thermal.c        |   2 +-
  drivers/thermal/kirkwood_thermal.c                 |   2 +-
  drivers/thermal/loongson2_thermal.c                |  15 +-
  drivers/thermal/mediatek/lvts_thermal.c            |  76 ++-
  drivers/thermal/qcom/lmh.c                         |   3 +-
  drivers/thermal/qcom/qcom-spmi-temp-alarm.c        | 596 
++++++++++++++++++---
  drivers/thermal/renesas/rcar_thermal.c             |   2 +-
  drivers/thermal/rockchip_thermal.c                 | 251 ++++++++-
  drivers/thermal/spear_thermal.c                    |   2 +-
  drivers/thermal/st/st_thermal.c                    |   2 +-
  drivers/thermal/tegra/soctherm.c                   |  13 +-
  drivers/thermal/testing/zone.c                     |   2 +-
  20 files changed, 921 insertions(+), 145 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


