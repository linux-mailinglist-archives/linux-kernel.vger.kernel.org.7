Return-Path: <linux-kernel+bounces-773902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A8CB2AC01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B21E189F392
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061FB23815D;
	Mon, 18 Aug 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlC6BW++"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97F2367CD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529047; cv=none; b=jnXC1qUPyoZniH9giGkVekS5HEMzGWIqZP/24CR4kb70EQq6JcpwY+mCkH6CJ1q7FLf0KRtWGXIMm+fFT974lDAIZolYiHjoyEHWDpBRpOB84PAQwVC83DrgfzWjg5c41Pcufw4ENWtg8hmW+MgCeOm3BdIaJUmsAxeABiIqVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529047; c=relaxed/simple;
	bh=zM1QLTJ8d9ktsdYpqAp8azR1zWsMGreYGCU1Y7gItTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnW6xPvlL3jULy/N4Xmph5USan4T3YgGG6E0BNeAjuKL0nInHP5YO+Y/tBthcsBtvje1V96vD5wEDP8lIXCaf46ujF2vusl8wQng0/6o/Pxf5EMkfdin7tpBpTM0Y0X8RDvgCwjXPS+9pOOtA3JlIogC/i3c08DbhH+h0OKFBBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FlC6BW++; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d60501806so36409697b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755529041; x=1756133841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7O0UQ1pCQtHfpFhQ25ojbKTIwk2c1/Y6ODmytP6Xa8=;
        b=FlC6BW++sY58ehg2Cz2eWAKYQ0MmNlzajhMPj7gycznmhYHAatrB2SrMTdknO2Qfrb
         Zl6iWLr+AJa8BQKtocDfif3k827vllpIdTr5IRyKzQbjP13hWEn2iOvMZzWo9mU+ZDAn
         i6nnWlP9VN2XvRZbRZZrZZfQ/9xm2UjqK5Jbjn4UFPAxgnH3JmLDjf4FwdYyVktRCOZP
         1A9oPEWXa3A/sRpNGVDQOg44XF8+qmMMGEdQMyufvwi9zWNQtVLVM9jvk8lILYJJ68mL
         +fSv6Or75vHKJ/eLT1E+Io79eaajY/ApWaoDE64/33+8fyOW9EMfCKm2s1uXVHwf0efy
         7q/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529041; x=1756133841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7O0UQ1pCQtHfpFhQ25ojbKTIwk2c1/Y6ODmytP6Xa8=;
        b=v9HByUS2EfjL4XO4I/hVotXx/VtUQRqCJAP/kSfmVejfUd6KiCruDvclsoGh2PVbS2
         MJ11sJLliBaG04JITk8Z3dPv7a6LJZhQKzqjEbUp7KPcsaMfRqKOh7xiJInuABcs3man
         aq1JO+fcv24uQmJ9lItjPRrEDbzBjXIqW03UjWZbD4l9j9VqXgNfKPaq2bzWUEzeneUc
         WduBe2sj9m7bUvYY00EmDYw4rPaKKnS15TAA8aeDRPSP4PyV+pqWf5let8/U3SCoJa58
         kqfjd2NO9UrJtaQ4kCGc/W11LQDHnm4nuaIUjSFX1Z1sVuKjvbkfsPz2LRFWCYS+/IeN
         5Mpw==
X-Forwarded-Encrypted: i=1; AJvYcCUGx63rlJRVWm/C1uAiHXvcLXsUc8u/AmkVEW2t3PoKzMyhIVIdsj3/XX3gLnFKBBO4dgnJBLCtHl2FEuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMTFiDDhsQH/0pL7m1M2V/D9WgW3f2k2fH4ownvVb0vihqxaP
	Bem/Co3UL6JWd9U7wih+gBNJK41CB6z8CcD8L1YKD0bTlS6karihpyGKzoygm/5t2wmxxDK5LMN
	34zR4aWO/aM1aRSdZgE4ZYPwLOruRWb1FoDFqi6CiW8Ath/ufiQTd
X-Gm-Gg: ASbGncubIklr3S6ezFwMem16auS2DcYtaoaavEzhmIggvoPvLOyQGzFy4eSh8simpzZ
	9YI5JRBHSJkJWhtE9MaRzNNfW3CVlcMIhFWeGYlx+ouznIakmkjNwwO/7ksNbnz4uPKvo14bjd5
	NNIXh/jW4WQCiuFCh97KqXPlKbEz+fN07hOap4scxK8QY2k3uOmD1xPJZCVr/D0MKZmoVlg+zn8
	qsVkZSt
X-Google-Smtp-Source: AGHT+IFrpy3Zh36/3rhDK9Yo1wKEo3VGJNpy/ovwmXZmsLaz1X1Vs5J2QxFrcBYfNMY8dyhO3nn0S7+Gkz85+LoYBJg=
X-Received: by 2002:a05:690c:e0d:b0:71b:69fd:257b with SMTP id
 00721157ae682-71e7740a667mr102425067b3.0.1755529041394; Mon, 18 Aug 2025
 07:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
In-Reply-To: <20250818-mobileye-emmc-for-upstream-4-v4-0-34ecb3995e96@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 16:56:44 +0200
X-Gm-Features: Ac12FXzpIsw7z74y8Gp-wah-Wi-b7dV6r0hRPk1lXGPmvuoz888ocsyHK-dWIPs
Message-ID: <CAPDyKFovFcBX+DwrVfKt_NKbWcTxk8ZOgn5ndo=fVT78Zk=qzQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] mmc: introduce multi-block read gap tuning
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Aug 2025 at 16:03, Beno=C3=AEt Monin <benoit.monin@bootlin.com> =
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
> only the status of the read operation.
>
> Finally the last patch uses mmc_read_tuning to implement the multi-block
> read gap tuning in the cadence host driver, by doing a multi-block read
> and increasing the gap delay until the read succeeds.
>
> In the previous version of this series, mmc_read_tuning had a struct
> mmc_card parameter and was making use of the helpers. This parameter has
> been dropped so the last two patches are now independent of the rest of
> the patchset.
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
> Changes in v4:
> - Dropped the card parameter of mmc_read_tuning.
> - Updated the last patch following the review of Adrian.
> - Link to v3: https://lore.kernel.org/r/20250716-mobileye-emmc-for-upstre=
am-4-v3-0-dc979d8edef0@bootlin.com
>
> Changes in v3:
> - Move the changes related to CMD23 support by MMC card to separate
>   patches at the beginning of the series.
> - Change the mmc read function to be less appealing to reuse/abuse
>   outside of tuning context.
> - Link to v2: https://lore.kernel.org/linux-mmc/cover.1751898225.git.beno=
it.monin@bootlin.com/
>
> Changes in v2:
> - Split the code between the core and the driver by adding a generic
>   function to read blocks from the MMC.
> - Link to v1: https://lore.kernel.org/linux-mmc/2a43386ffef4012530ca2421a=
d81ad21c36c8a25.1750943549.git.benoit.monin@bootlin.com/
>
> ---
> Beno=C3=AEt Monin (6):
>       mmc: core: add mmc_card_can_cmd23
>       mmc: card: add mmc_card_blk_no_cmd23
>       mmc: mmc_test: use mmc_card cmd23 helpers
>       mmc: block: use mmc_card cmd23 helpers
>       mmc: core: add mmc_read_tuning
>       mmc: sdhci-cadence: implement multi-block read gap tuning
>
>  drivers/mmc/core/block.c         | 12 ++-----
>  drivers/mmc/core/card.h          |  9 +++--
>  drivers/mmc/core/core.c          |  9 +++++
>  drivers/mmc/core/core.h          |  1 +
>  drivers/mmc/core/mmc_ops.c       | 72 ++++++++++++++++++++++++++++++++++=
++++++
>  drivers/mmc/core/mmc_test.c      | 10 ++----
>  drivers/mmc/host/sdhci-cadence.c | 63 ++++++++++++++++++++++++++++++++++=
-
>  include/linux/mmc/host.h         |  1 +
>  8 files changed, 157 insertions(+), 20 deletions(-)
> ---
> base-commit: 8936497143de1da7958178d57db6011eceeb14a8
> change-id: 20250716-mobileye-emmc-for-upstream-4-40ef552c3b59
>
> Best regards,
> --
> Beno=C3=AEt Monin, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
>

