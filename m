Return-Path: <linux-kernel+bounces-741426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2EDB0E3F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DA71893BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EF5284B26;
	Tue, 22 Jul 2025 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wB3xDbDt"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B51B808
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211673; cv=none; b=qooIGevorPs506JEXAkeKEFDIvSlZnAkHgmL1NpdyUSB1Wt9W//EGJ7UwYZ+lldUVhNZX0vFF0PbLJ4I06C0Pgb33Q76DjomPsXlDJQo/YdTPx8Cb96m6YmzBbrb10bikA1/ksI4alN6ZHgehCMJLPrST+MDHxtUBhvA7gDst3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211673; c=relaxed/simple;
	bh=vIuT1ZfkuI3r1/h+piecmOljQ3iUCBg1dKv/rXqZY6k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=FGWQTlfOB8Sv0KjWEUb4TnJKVxle99N4Ju5GsNraPg1wB2dYz5mD+J7BYlKBWngIbiEo9IqZ7zCz/xdJTDUSwaISQ+VKce71Jwtt2cDKdwUcTjE5GV5AHeV32Ev8QVxVad7+msSfGhV7drhs0/kWU/3GD6G2JwnSmfNNN8NzKhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wB3xDbDt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so60953375e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753211670; x=1753816470; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAtYLZCzlWgt17UGxOoTy+tWuU+4fawpMltXt1hGITU=;
        b=wB3xDbDtpusf5MPJZtNDVI4YrM3ts7hNQk3BRfQjjdVdv9y97e7it5ODFRVfMszs5Z
         pAMv2x8jrHpIHLmYPyBUKV39vH5uDbBW7EW8COQ9p+Ir3JGEkIl/eWAYBa97m/kZyPcL
         fhl3xkY/LUlzYvyhkUtUq6QkPrxYKON7cY5lgK3SupZ7hQikjeanWG3cJeCWdwOLvE6r
         SmhW0/i0pbCnhUeYvSmuGMGiAtn+BeIcM7aXPlSHKq/TiRFjmU0fmncLVnG80TfJagLr
         NBBi2bPdyQR7wh+3aD0TRX5qNcjXucIWYjWp2vqoVFrvVB5s2o8I0bUdonRG7gZRM5tb
         18bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753211670; x=1753816470;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAtYLZCzlWgt17UGxOoTy+tWuU+4fawpMltXt1hGITU=;
        b=RfFGP5d9emkmlJm4uks8DMpNyKVPmrrxa6SKpcCVJgz+30nFnH0oKYdgybEJ3cKIgR
         vyEqz0HiE7AzHdy4tsaZH0WT9gL85sltMMI/Gd5r+dj8dhnXyYtqo7aWuN13xcECKkde
         cHk2cgGFdUr7Zq+VtxdpNDLYxAZkmJcyzsLSo/P8apRyuPdQauMenYxqQnFwqK2AYFra
         uJGnea6wRufEjIBbAblZU5gKXiX+kPjFtocC/hnH/VDEHsgbjxW4Z0ksn89gSWL+/Qkr
         iF8dG5UhSRv1pUJxygg2llc6fmJ3uyLHisNWBMBHY4hFENYpdpfdb/hwJNgyMSRqKlLJ
         f7kg==
X-Gm-Message-State: AOJu0YzR0QoRDkIXf8/u0q/1VX49l7hGeU73E9VfLfOmc+DWmQ0tsyoh
	fUECYi4HTyRhd8wY4YEXBkur5Luc+7igUO7Gm5k0q5p0PmI0B202xl0bnJeSS03MHAw=
X-Gm-Gg: ASbGnctfND3HPFKn/z8KL1WSFq1tPVb227ZdX47Y2H8wqWShpv0PAfcHGgup2PNLs/v
	D/owj46jNSrzDlmWPLONMr572kBzqzp8opF8dKpIcEqkqXI2Qpg6dshU4AjvbKmdi6IikIlt/xR
	hodPEEd9vaGXq0yU1lccC90x+1nIBYwT/TV74Z0mUTIn3VK7HEi601zBfjK9TqzOXfkR0aGcxVm
	h7H86scr8yw4uI4hWABrOQzQGc9qOlF2IV7q1Q42Je4NvffZcBPr1QlJzcoh3ANTJ48CsJdl8RZ
	Balq3LFPOuKoX4cn4/u3w3K18gzJW8+dFOsZMMwFJMGMQb19wTz0NTZh59NgJgP/4xcASs8MMqM
	cm5icmw7XLrAle9NJGsTLZxpDJvLNj5D0WnOiA//qzSZEhdr7QttuOlmqh8I=
X-Google-Smtp-Source: AGHT+IEKNASX/yap70aCiKg2UyO+gi+xOgTdGqsZ43i2og4G40EmxvGnK65Swo33pXJze547zwaxBQ==
X-Received: by 2002:a05:600c:35c5:b0:456:27a4:50ac with SMTP id 5b1f17b1804b1-45868d2a9e7mr92315e9.23.1753211669558;
        Tue, 22 Jul 2025 12:14:29 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4562e886104sm203863965e9.25.2025.07.22.12.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 12:14:29 -0700 (PDT)
Message-ID: <03a99cba-7b63-4816-942f-b99f98779955@linaro.org>
Date: Tue, 22 Jul 2025 21:14:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Max Shevchenko
 <wctrl@proton.me>, Frank Li <Frank.li@nxp.com>,
 Rob Herring <robh+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>,
 willmcvicker@google.com, Chen Ni <nichen@iscas.ac.cn>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v6.17-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

The following changes since commit d7b8f8e20813f0179d8ef519541a3527e7661d3a:

   Linux 6.16-rc5 (2025-07-06 14:10:26 -0700)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux 
tags/timers-v6.17-rc1

for you to fetch changes up to 7e477e9c4eb412cbcaeae3ed4fff22035dc943eb:

   clocksource/drivers/exynos_mct: Fix section mismatch from the module 
conversion (2025-07-15 19:46:23 +0200)

----------------------------------------------------------------
- Add the module owner to all the drivers which can be converted into
   modules in order to have the core time framework to take the
   refcount and prevent wild module removal. In addition export the
   symbols for the sched_clock_register() function to allow the drivers
   to be converted into modules (Daniel Lezcano)

- Convert the faraday,fttmr010 DT bindings to yaml schema (Rob
   Herring)

- Add the DT bindings compatible string for the MT6572 (Max
   Shevchenko)

- Fix the fsl,ftm-timer bindings by using the items to describe a
   register (Frank Li)
Chen Ni <nichen@iscas.ac.cn>
- Add the DT binding documentation for Andes machine timer (Ben
   Zong-You Xie)

- Fix the exynos mct driver to allow the module support. The changes
   include fixing the empty IRQ name, changing to percpu interrupts and
   preventing to use the clocksource as a sched clock source on ARM64
   (Will McVicker)

- Avoid 64-bit divide operation which fails on xtensa and simplify the
   timeleft computation with 32 bits operations on Tegra186 (Guenter
   Roeck)

- Add the fsl,timrot.yaml DT bindings for i.MX23/i.MX28 timer (Frank
   Li)

- Replace comma by semicolon which were introduced when moving the
   static structure initialization (Chen Ni)

- Add a new compatible for the MediaTek MT8196 SoC, fully compatible
   with MT6765 (AngeloGioacchino Del Regno)

- Fix section mismatch from the module Exynos MCT conversion (Daniel
   Lezcano)

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
       dt-bindings: timer: mediatek,timer: Add MediaTek MT8196 compatible

Arnd Bergmann (1):
       clocksource/drivers/tegra186: Avoid 64-bit division

Ben Zong-You Xie (1):
       dt-bindings: timer: add Andes machine timer

Chen Ni (1):
       clocksource/timer-econet-en751221: Convert comma to semicolon

Daniel Lezcano (8):
       clocksource/drivers/scx200: Add module owner
       clocksource/drivers/stm32-lp: Add module owner
       clocksource/drivers/sun5i: Add module owner
       clocksource/drivers/tegra186: Add module owner
       clocksource/drivers/stm: Add module owner
       clocksource/drivers/cs5535: Add module owner
       time/sched_clock: Export symbol for sched_clock register function
       clocksource/drivers/exynos_mct: Fix section mismatch from the 
module conversion

Donghoon Yu (1):
       clocksource/drivers/exynos_mct: Add module support

Frank Li (2):
       dt-bindings: timer: fsl,ftm-timer: use items for reg
       dt-bindings: timer: Add fsl,timrot.yaml

Guenter Roeck (2):
       clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation
       clocksource/drivers/timer-tegra186: Simplify calculating timeleft

Hosung Kim (1):
       clocksource/drivers/exynos_mct: Set local timer interrupts as percpu

Max Shevchenko (1):
       dt-bindings: timer: mediatek: add MT6572

Rob Herring (Arm) (1):
       dt-bindings: timer: Convert faraday,fttmr010 to DT schema

Will McVicker (4):
       of/irq: Export of_irq_count for modules
       clocksource/drivers/exynos_mct: Don't register as a sched_clock 
on arm64
       clocksource/drivers/exynos_mct: Fix uninitialized irq name warning
       arm64: exynos: Drop select CLKSRC_EXYNOS_MCT

  Documentation/devicetree/bindings/timer/andestech,plmt0.yaml  | 53 
+++++++++++++++++++++++++++++++++++++++++++++++++++++
  Documentation/devicetree/bindings/timer/faraday,fttmr010.txt  | 38 
--------------------------------------
  Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml | 89 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml    |  7 +++++--
  Documentation/devicetree/bindings/timer/fsl,timrot.yaml       | 48 
++++++++++++++++++++++++++++++++++++++++++++++++
  Documentation/devicetree/bindings/timer/mediatek,timer.yaml   |  2 ++
  arch/arm64/Kconfig.platforms                                  |  1 -
  drivers/clocksource/Kconfig                                   |  3 ++-
  drivers/clocksource/exynos_mct.c                              | 75 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
  drivers/clocksource/scx200_hrt.c                              |  1 +
  drivers/clocksource/timer-cs5535.c                            |  1 +
  drivers/clocksource/timer-econet-en751221.c                   |  2 +-
  drivers/clocksource/timer-nxp-stm.c                           |  2 ++
  drivers/clocksource/timer-stm32-lp.c                          |  1 +
  drivers/clocksource/timer-sun5i.c                             |  2 ++
  drivers/clocksource/timer-tegra186.c                          | 30 
+++++++++++++++++++-----------
  drivers/of/irq.c                                              |  1 +
  kernel/time/sched_clock.c                                     |  4 ++--
  18 files changed, 290 insertions(+), 70 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/andestech,plmt0.yaml
  delete mode 100644 
Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
  create mode 100644 
Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
  create mode 100644 Documentation/devicetree/bindings/timer/fsl,timrot.yaml


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


