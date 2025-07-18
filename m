Return-Path: <linux-kernel+bounces-736894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B345B0A4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26784188C25B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408222DBF69;
	Fri, 18 Jul 2025 13:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TsxhWYWz"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCB218EA8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843896; cv=none; b=uvmXqs/qzwTZ9B0u1bq6DqbD/Yr/2PXyVP5ZMZZjMtGaRfpsyPM9J4tE9TpjHIroqWeFqFvTHmZBikzAkrmntwz/1q6LZkioBKYKVSbAP1gwveBrPetnSPfRN9W7MV5rZcRmVnWqragK3D7hgp/YpWYCigFa8RcmnqJA+3ggHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843896; c=relaxed/simple;
	bh=sozEw8FyWyDjapcwikfsnTLYtBoVTtIi2agNNPNo3lU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAmbOFHpI1NdpUxlTAkLBNTmXuIIS5W7znIky5yI8KzbNFPcy10kvERsWw5YW60NQDJA48GxKmVLayXwPWAiLLVkwQhkb1PeIVSHQW0Zc+vDkAABRNTBcLi+B3QAr8y6Z6cIcpXd4ONWWZnr30zhyd4VNJ1sKxjL0GYLWYcu750=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TsxhWYWz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7086dcab64bso20469587b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752843894; x=1753448694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cjbUkrtlM4UaM9lc1BaVPt7R7JS/MDa+VxvwtUnNho=;
        b=TsxhWYWztpDmEV+Jhylaoj/hUSk5G3+WDp/q3NryGUBHlcu331aStE02VAmR8IgKHF
         mXNcadTwzsqDc8AZPO9RBPVqy6nKj8FGkV6PM2GlX7VmM7stpvPoq59NPJr0NmFNjewe
         y9/Y/f7z8FHUSOf/9aMAL+5eezFf64l5X1csZoAUVUHSskKiIHWB7i1ybybYDpcVoe7W
         z5T51oI47lgdemsICdy4sLmhIQTQEbCwPcF5TSoxXC1yJrnVzXxacaV9qhkaRIxb2scw
         b9EfSktvgG67FcGucIW9D6Tfo5AEMAERGHDbyM+cJcXIaTHIvzLJx0yO4zsIMXaYHnb2
         aq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843894; x=1753448694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cjbUkrtlM4UaM9lc1BaVPt7R7JS/MDa+VxvwtUnNho=;
        b=jO7t1VcM3bdmrpyMmRgfN3Ae6f4lA36DjCh6QLLON6BYQWl5z1Aq6Q2UV2hok31hoH
         skbIeFof4WiYZPHn+ETFtYZthXSYkjmv+azko97ShfF/xNYbNOtOaw7mYb+pXLqFSrvK
         Y/dBhqHdDhsxmGqPbJ7u5U65L7a9zbHjDPxMOI2HW39LaPjvX+VZf/9onBNks0gf8yCj
         F7PiFcOu0+9tBTd/AGMkMPq62MpH85E2oK8yZ3OvcXDGb3RnXy7Qa8Ae0lVsIM8uYsvV
         9IiZUQYPtIIvbtdnyxPikJi/TEurzf6OGIU99hTKsR5U+VIBGMUn94nr8gf61uc84+yi
         bn6w==
X-Forwarded-Encrypted: i=1; AJvYcCXkTonchkSO+oQ88r2YoePkWo4kULhGaeYPZYDDEQw8wsEiCxQcHbR5NyLURCjmAZMnyXkqbvcgCSm+wDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YziEu/aCTw7v9sbqYAyL05Mpis8hWPARcyZVJfg87HygdyMF0aB
	8+4Vq/85cIYJer9iWyKV4xmy2ieukj4cdymVQGkHKV058wm0we38UWeMObyhxAYj+kjSPE1b+wC
	0QREjzIjqDjB4Er2heFsIliOJ/Ug9oCfn5zIfyCPcig==
X-Gm-Gg: ASbGncsZIuVGLE3buWsVSI2VCsVXOOEy4l2+PlKxoF33dQCkDK8ky4l6XvLiScJ5sI6
	T8cuZrRjqAfJ92w5CGHZ1PvNoFBKTYDshPrruP6zrMGP87JlSzK7bKKmaeb/UH+BxiGZ4gIwDvQ
	DmxOwoh6iLXGQO58cTigB0/FWXw+z0gPzHMbXhXHG0LKsYH8QGtxjXLrO88etD/wN6pLmoXqItB
	PVNNk9i
X-Google-Smtp-Source: AGHT+IHAREX9jlEB7DDQFJly6tT608RByxRGCuonOYwIH/zjWk609eGj2ygFHsSBmEbKSc/+O98hZVdjh7b1hxqPJfQ=
X-Received: by 2002:a05:690c:6611:b0:719:5675:5ef1 with SMTP id
 00721157ae682-719567560camr21315517b3.23.1752843893829; Fri, 18 Jul 2025
 06:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
In-Reply-To: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 18 Jul 2025 15:04:18 +0200
X-Gm-Features: Ac12FXxVwAQXB6b2VTbpgI0Tf9IffZ9HFaLLM_9W8621oBuAcd55DDCIeBmgDuY
Message-ID: <CAPDyKFqa6ut25uaDN6pP50wGi2+DZ8MJ6_OZ6ujtgjfHz4hxzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] mmc: introduce multi-block read gap tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Jul 2025 at 17:47, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
wrote:
>
> This patchset implements the multi-block read gap tuning for the SDHCI
> cadence driver.
>
> The first two patches introduce helpers to check for CMD23 support by
> MMC card: mmc_card_can_cmd23 for support proper and mmc_card_blk_no_cmd23
> for the NO_CMD23 quirk.
>
> The next two patches use the new helpers in mmc/core/mmc_test.c and
> mmc/core/block.c.
>
> The next patch add mmc_read_tuning to read blocks from MMC as part of
> the tuning. This function does not return the data read to the caller,
> only the status of the read operation. It also takes an optional card
> argument, not used when called from execute_tuning() but present in
> execute_hs400_tuning() and prepare_sd_hs_tuning().
>
> Finally the last patch uses mmc_read_tuning to implement the multi-block
> read gap tuning in the cadence host driver, by doing a multi-block read
> and increasing the gap delay until the read succeeds.
>
> v2 -> v3:
> Move the changes related to CMD23 support by MMC card to separate patches
> at the beginning of the series.
> Change the mmc read function to be less appealing to reuse/abuse
> outside of tuning context.

A quick review made me feel a lot better about this, thanks!

Although I will need a few more days for review and possibly it's
getting too late for v6.17 for me, but let's see, I will do my best.

Kind regards
Uffe

>
> Link to v2:
> https://lore.kernel.org/linux-mmc/cover.1751898225.git.benoit.monin@bootl=
in.com/
>
> v1 -> v2:
> Split the code between the core and the driver by adding a generic
> function to read blocks from the MMC.
>
> Link to v1:
> https://lore.kernel.org/linux-mmc/2a43386ffef4012530ca2421ad81ad21c36c8a2=
5.1750943549.git.benoit.monin@bootlin.com/
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
> Beno=C3=AEt Monin (6):
>       mmc: core: add mmc_card_can_cmd23
>       mmc: card: add mmc_card_blk_no_cmd23
>       mmc: mmc_test: use mmc_card cmd23 helpers
>       mmc: block: use mmc_card cmd23 helpers
>       mmc: core: add mmc_read_tuning
>       mmc: sdhci-cadence: implement multi-block read gap tuning
>
>  drivers/mmc/core/block.c         | 12 ++----
>  drivers/mmc/core/card.h          |  9 ++++-
>  drivers/mmc/core/core.c          |  9 +++++
>  drivers/mmc/core/core.h          |  1 +
>  drivers/mmc/core/mmc_ops.c       | 79 ++++++++++++++++++++++++++++++++++=
++++++
>  drivers/mmc/core/mmc_test.c      | 10 +----
>  drivers/mmc/host/sdhci-cadence.c | 69 ++++++++++++++++++++++++++++++++++=
-
>  include/linux/mmc/host.h         |  2 +
>  8 files changed, 171 insertions(+), 20 deletions(-)
> ---
> base-commit: 4ad9e44c76b301e786eb4cdab890eac8c7eebd42
> change-id: 20250716-mobileye-emmc-for-upstream-4-40ef552c3b59
>
> Best regards,
> --
> Beno=C3=AEt Monin <benoit.monin@bootlin.com>
>

