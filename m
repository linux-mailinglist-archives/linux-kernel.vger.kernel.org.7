Return-Path: <linux-kernel+bounces-821014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C62B80101
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B69D1C062D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0BC2ED869;
	Wed, 17 Sep 2025 14:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZAzfgnhf"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5090191F91
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119580; cv=none; b=Mkr0r5q/Bo/Kvodb5ma9N6tVj7GB8ld69ECSP+OM4VZ+iOODmheJgHMtwO6AhEcW41ajODDUnHQFwnZigxB+6gDIgOp/YpkX6QKAhf7V8Z2rk+9Apf5Pv2yfq/FxKPut24jPzJxWJV53N362PbBWP3Xn1CDV7zs23yw4lNs8h5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119580; c=relaxed/simple;
	bh=tcnHxortbdFdgmr9duRFABSbgVONmqvd0HPd6fDcn/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCLm1CFy5juhWEKI3iuc/RFcL0agWlDVocBaIchHDVi847Pxm4Quzn9P+OjmDK1fDGb/L0OOU8DlFREUcRjSHC2Nlkq00rdqNZNFRkU6UQYAPLNJNhRoJoS9YgFC5pd5ciIiYr06/lKDYshxYSuUX7ccx6MW32odcu0DRO0zvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZAzfgnhf; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e94d678e116so7157898276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758119577; x=1758724377; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dCz4bFinyR1BieLUIHZQZV0TDdidYv9V2bEcGI7xH7o=;
        b=ZAzfgnhfmlHY3kWDrEgfGpTFDQM5zNLAp4u0yML2KyRy2y6Q+93SKmnEWvz7UEgTWz
         /OcjGzC6pAvm+ddVkNAW9+6YhnW6NQH8JzBVL3qbtFYSLVGQ29mDhQRWIfWJfZrGWLcC
         uQw3fC1w7r70oKqh342UuABIEmEcTD0a4KxehjL+1JoqsUG8pjfQW2C2P3855vWZtMIi
         7LlCwmu5WrBBHAcGh5dIfediBCTeaMJxw6U5DLPItpyZbBq2GNAWTU9ZAPMeIcPoamt2
         QnjFP8rRQf07Oy6+oNw6KkSvrDPLP81G+cRiPcr4p4tnkJi7qYiyJ4W84cCEgHOrDdZs
         423A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758119577; x=1758724377;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCz4bFinyR1BieLUIHZQZV0TDdidYv9V2bEcGI7xH7o=;
        b=uDmDUHR8XT4JOhDVuOnXkvUrFX5gDJMvT+8PtsFwxkp+3V0Z34CbFE0e36cEgdUoNA
         PfBbI6ZkhGa4CE9D7Gd3cnaDgIFJKbAf3yLpqdDlfOqw//HQOd5emkwnmHV+qLOBUB8Q
         YjMoCgP9voZUAYIQemFF7eMlvz+JkyNY6V7y8ys8IHvrxubDBf6O+qYuh8+P6ml1Og8A
         MBiX7qX8SQeuUy1JKVxKmHA9bLFYDquBvjoj7XKHdDLE8aT0Hl9gZ8zC8872JGP50HP0
         C1Yo3SQWOchoR68nrNJaHhQd/W3vMKbISx22qWeowK1kExzwRC+yctGyxtX5/hRrY1Yt
         v6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8bions1lYJdkzDWVNfUpQVq5ZytDO6nw0JVNDJtcZvhVD3W4O4DXfPZXug7hMRpPa7GlnBeMttCm1Gik=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZifgFdk1h5ZiiQ6fjyDyQsMMAdE95dSOA5+Z1FpbT3n0mpEJ0
	AmZhcR0VfGG0REoWlYih4dZ63RTpfyFKyo7v8HCHwwTxDWzT02QsbmhC81s3pGb1QFg/bsat/3e
	VpcdGQ60ikZZRL+UJ0/Jg6qZKjR6SvCKGUxGPAJFOge8dYYWDENck
X-Gm-Gg: ASbGncufzioygyXfpRpOWUlWJycb6mp6HI1tLIaMPkdxYLlEtKsCM/Vp1Wn0L41VbNn
	1iUEnE0jYG0HuqwvWyKd9eovekzVwJMdKG1AlNLahfxrTCJ+KNGsWW3l4nHoTRgvZ9CfWnvO6WO
	lzhvcUpUmOSIhK3HjDW3EaL1Rr53XrGDxvqWRLQMyNwgLC9JhYkpN2BxsVM+w6R9cfEXT3v6ezu
	rcga735
X-Google-Smtp-Source: AGHT+IGYd75X0Qf3WTxoJJzFk2/YdrBkHI2rWEVx/WssCazdqocK2S+85yiq6AsUYraILKbckm2rz5VkDvdIi7Gceg0=
X-Received: by 2002:a05:6902:124c:b0:ea5:c97c:3182 with SMTP id
 3f1490d57ef6-ea5c97c50bcmr1102726276.36.1758119576502; Wed, 17 Sep 2025
 07:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
In-Reply-To: <20250915083317.2885761-1-mikko.rapeli@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 17 Sep 2025 16:32:20 +0200
X-Gm-Features: AS18NWBqAAb3pOa1iLGjs8mbJODRThiYyAWA34gbcKMC5sx254a7Jh6zE5vInCA
Message-ID: <CAPDyKFpR+uueS16P7OZi6-1NVrEyPbizuSnMHWMyROfqzPjarg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] enable ROCKCHIP_PM_DOMAINS
To: Mikko Rapeli <mikko.rapeli@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Heiko

On Mon, 15 Sept 2025 at 10:33, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
>
> Hi,
>
> MMC_DW_ROCKCHIP needs ROCKCHIP_PM_DOMAINS before MMC is detected
> on Rockchip rk3399 rockpi4b and similar devices. Make this dependency
> more visible, or the default with ARCH_ROCKCHIP if possible.
>
> v4: fixed Kconfig whitespace, added select REGMAP_MMIO to MMC_LOONGSON2
>     instead of disabling COMPILE_TEST
>
> v3: use "default ARCH_ROCKCHIP" in ROCKCHIP_PM_DOMAINS as suggested
>     by Arnd Bergmann <arnd@arndb.de>, enable more MMC drivers for
>     COMPILE_TEST and remove MMC_LOONGSON2 which doesn't link,
>     remove PM dependency as suggested by
>     Geert Uytterhoeven <geert@linux-m68k.org>
>     https://lore.kernel.org/linux-mmc/aMQv1V49xa_MThGq@nuoska/T/#md2b3252f9dce14f3f79a493c426f2761cba1dc25
>
> v2: changed from "depend on" in MMC driver to "select" as default
>     on ARCH_ROCKCHIP as suggested by Ulf and Heiko
>     https://marc.info/?i=20250912084112.2795848-1-mikko.rapeli%20()%20linaro%20!%20org
>
> v1: https://lore.kernel.org/linux-mmc/20250911144313.2774171-1-mikko.rapeli@linaro.org/
>
> Mikko Rapeli (4):
>   pmdomain: rockchip: enable ROCKCHIP_PM_DOMAINS with ARCH_ROCKCHIP
>   mmc: add COMPILE_TEST to multiple drivers
>   mmc: select REGMAP_MMIO with MMC_LOONGSON2
>   ARM: rockchip: remove REGULATOR conditional to PM
>
>  arch/arm/mach-rockchip/Kconfig    |  2 +-
>  drivers/mmc/host/Kconfig          | 10 ++++++----
>  drivers/pmdomain/rockchip/Kconfig |  1 +
>  3 files changed, 8 insertions(+), 5 deletions(-)
>

Patch 1 applied for next to my pmdomain tree. Patch 2 and 3 applied
for next on my mmc tree. Thanks!

Heiko, can you pick up patch 4 via your Rockchip tree? Or if you
prefer me to pick it, I can funnel it via my pmdomain tree. Let me
know please.

Kind regards
Uffe

