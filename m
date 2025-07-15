Return-Path: <linux-kernel+bounces-732016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2F0B060CE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CF0B7BE7FA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A52F293B42;
	Tue, 15 Jul 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+1//roP"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B42292B57
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 14:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752588576; cv=none; b=Gw+aIIWVJjpaDmzDqtmgfH9Z7DpMzceWH49YHkdTFxJReTyT8S6w1URux3o3t76TLJ0wzo2zHWK1EOMpH7c+TwVPZpyHKJGF2EsFdFQvA/AiTyIp6uqn3nDs8mBwCKnUleWJxOTMSAZMBcKeo4rSQK/oZYZ2GJNjswofPExNuJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752588576; c=relaxed/simple;
	bh=jJTBj4fac1bgJaznP0nVpLk5OWhiPHvmPDoBk2KvbXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzMB1BwttBZM2pwBcZ3fx24I9+iB7NLaerjP4HiXXRpApV6ILETeUQeh46tHnylQ6X8EL1hLBYPERBqdRDbqzHXLSnqGb/h2WmMFbK5bWG2jd17Umxob5bSMzQqT5JKOzWvck8ed8oSgYuSoawcqO7EqlCVEhWJ4hEotGcnrmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L+1//roP; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8275f110c6so4049073276.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752588573; x=1753193373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rdR+LRqRBkJBUvCkbRrJJULDxmBDkmzUM6UrN84Yku0=;
        b=L+1//roPMDgq3RPR8h7Vo/VMdYeqZKj8ooDwz1UOXvNXnxMIqZV7OS4DMPaFYCC7+l
         RLBTcNQM0BO5qgzlAVfg48WLxWQKazZjmRvKNIfDe9BElnzVoVo0LX9O/BFkLhI/IiXG
         zUFzuSaa00lVlxtgBT4/15zl7DaX+um5tn6SCiusvS4jdYNlCigGyX7qSb7jvsmRiz9f
         vLTT006V0lBJz+WRCmU4McG5T1TPZ/EVAWfPR5Ovry+FCSZZfkuEf+YCx8/TCzHMCH8X
         hpBndrn64zUaZ2e9L81AJQWJ5sgTW8fok8B4Xx1lo2zFH8J52UHKCvWQJJlP6DRnCvHk
         xB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752588573; x=1753193373;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdR+LRqRBkJBUvCkbRrJJULDxmBDkmzUM6UrN84Yku0=;
        b=CYS/JuMGMx5BTiPkj8sXSI4/jm2emjiU9djaHwjZWuvan/wXlqfJnIB4ms1zOABsX7
         qJJPylbv7Oic92DZMUfM5tboD7lUuAquSbSMNrWDKqJQLhliFpGQbsxzj9Yx47FtvVcL
         NmOfX8nY97/qUifDZGg7HghJl/w45w2yJpQr1cqa45KhJ5zxmbOrc1y/sBh3t+zZJbhi
         kIveDOk1GTIruFOxfxsWmsEqwtZ/AAOUH29PDcjitIZLcrP6nLAvNCjVzth8AFrHgGtH
         IBP5MCKJxorGFt7xUQPxtctj9MvWwvEl+h5+EZrY/kJxdTAJLPXodansQw7A0lHsZVw8
         wBKA==
X-Forwarded-Encrypted: i=1; AJvYcCXevlEcTglF2DDUz+neOOkC0aJami/P3Q9jmZWfjNo5PgQthnBez3qFXxRwClQM/elJ1cYqzAQY966vF58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk8wDKHhBDFgpJ/TOqxS9tj9h/QEkFYnrThAEtDz3iwgJ4RHAV
	0keerCf3Oh4gx5wP0VxBOvJ1ybdNMAXIqXh0YbSCpadIZB0qFqrmECpPUdhmp/vQ2VTcPcKJAoy
	2IHTiTl42I1fue6tJXIB7dJfUTUBBZo2DZ3WxuuNMeQ==
X-Gm-Gg: ASbGncue5DnzB46bGtIz8aaunYCcsTq2Z/9l81nb8ePXRZOr8K0I8OdjacVsyr4cjO9
	SDdbjJZ1190/j7LHb7O2ufsI++roUKpCHzTm28vfB58A17AsBkbWOT9OMAmwE0ft1c+NfyU785U
	7tOvGkKkigG5FTa5ZF55p7/3dysXmKCzlQUgMIX+M6ldY9kmXwNfIOtPP+RYKIeeu8z6czKMH3P
	h8r/UHy
X-Google-Smtp-Source: AGHT+IFr5aZe129SXty/aUauZ98iCrC5028PDfP3/dwd83DOGHiwFr2/EEOsdifr9IoyiESxKl68x3MmFGTyJODgVvM=
X-Received: by 2002:a05:690c:b82:b0:712:c295:d010 with SMTP id
 00721157ae682-717d5e2848bmr255785147b3.33.1752588573210; Tue, 15 Jul 2025
 07:09:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250712074021.805953-1-wens@kernel.org>
In-Reply-To: <20250712074021.805953-1-wens@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:08:57 +0200
X-Gm-Features: Ac12FXzjyKVG9YpXDr4ujfp7DHXXwLEZE6WjntfBOMpvZOZeuC_qP0opUlbqcZM
Message-ID: <CAPDyKFoSe3sch1ooP7e-TOiB91y=_Q=-FaSooc2ROoMwfEsP+g@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] allwinner: a523: Add power controllers
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andre Przywara <andre.przywara@arm.com>, linux-sunxi@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Jul 2025 at 09:40, Chen-Yu Tsai <wens@kernel.org> wrote:
>
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi folks,
>
> This is v3 of my A523 power controllers series.
>
> Changes since v2:
> - pck600 driver:
>   - Fixed whitespace issue
>   - Added explanation about possible PCK-600 lineage and document
>     references to driver
>   - Changed Kconfig option to tristate
>   - Rewrote Kconfig option help text to make it clear that the driver
>     is required for certain peripherals to work
>   - Made it depend on ARCH_SUNXI or COMPILE_TEST
>   - Made it enabled by default for ARCH_SUNXI
>   - Renamed PPU_PWSR_PWR_STATUS to PPU_PWR_STATUS, and added a comment
>     to note the macro is shared between two registers
> - New patch changing sun20i-ppu driver to tristate, and enable by
>   default for ARCH_SUNXI
> - Fixed pck-600 header path in dtsi file
> - Link to v2:
>   https://lore.kernel.org/all/20250709155343.3765227-1-wens@kernel.org/
>
> Changes since v1:
> - Re-order compatible string entries
> - Fix name of header file to match compatible string
> - Link to v1:
>   https://lore.kernel.org/all/20250627152918.2606728-1-wens@kernel.org/
>
> This series adds the power controllers found in the Allwinner A523
> family of SoCs. There are two power controllers. One is the same type
> as those found in the D1 SoC, just with a different number of valid
> power domains. The second is (I assume) a unit based on ARM's PCK-600
> power controller. Some of the registers and values match up, but there
> are extra registers for delay controls in the PCK-600's reserved
> register range.
>
> Patch 1 adds new compatible string entries for both of these
> controllers.
>
> Patch 2 adds support for the A523 PPU to the existing D1 PPU driver.
>
> Patch 3 adds a new driver of the PCK-600 unit in the A523 SoC.
>
> Patch 4 aligns Kconfig dependencies and default for SUN20I_PPU with the
> new PCK-600 driver.
>
> Patch 5 adds device nodes for both of these controllers.
>
>
> Please have a look. The power controllers are critical for enabling more
> peripherals, such as display output, camera input, video codecs, the NPU,
> and a second DWMAC-compatible ethernet interface.
>
>
> Thanks
> ChenYu
>
>
> Chen-Yu Tsai (5):
>   dt-bindings: power: Add A523 PPU and PCK600 power controllers
>   pmdomain: sunxi: sun20i-ppu: add A523 support
>   pmdomain: sunxi: add driver for Allwinner A523's PCK-600 power
>     controller
>   pmdomain: sunxi: sun20i-ppu: change to tristate and enable for
>     ARCH_SUNXI
>   arm64: dts: allwinner: a523: Add power controller device nodes
>
>  .../power/allwinner,sun20i-d1-ppu.yaml        |   4 +-
>  .../arm64/boot/dts/allwinner/sun55i-a523.dtsi |  18 ++
>  drivers/pmdomain/sunxi/Kconfig                |  19 +-
>  drivers/pmdomain/sunxi/Makefile               |   1 +
>  drivers/pmdomain/sunxi/sun20i-ppu.c           |  17 ++
>  drivers/pmdomain/sunxi/sun55i-pck600.c        | 234 ++++++++++++++++++
>  .../power/allwinner,sun55i-a523-pck-600.h     |  15 ++
>  .../power/allwinner,sun55i-a523-ppu.h         |  12 +
>  8 files changed, 316 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/pmdomain/sunxi/sun55i-pck600.c
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-pck-600.h
>  create mode 100644 include/dt-bindings/power/allwinner,sun55i-a523-ppu.h
>
> --
> 2.39.5
>

Patch 1->4 applied for next (the dt patch is also available on the
immutable dt branch), thanks!

Kind regards
Uffe

