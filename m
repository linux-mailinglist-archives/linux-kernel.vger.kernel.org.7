Return-Path: <linux-kernel+bounces-770884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC13AB27FF0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2541CE73CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692982D0632;
	Fri, 15 Aug 2025 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fuCN4Rkf"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD68286400
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755260655; cv=none; b=qYJzI5WkMXXAh3vfEjBAe3BaS6eMLzUVqC2eixmpFdsbI13ASKDcN5uYvv2OZXO6bxvotTkGSeN9zfaTs63r31vdoyB9lOeCNh1R4at01Sx0X+xev1MgCbFxwK/Jr4f4erQHA9BVaYjT7dSGrsBTnYgT77emzMl1/h7Hw4N6Jx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755260655; c=relaxed/simple;
	bh=DwtYpRH0b7X/lUlfIsy5hJeDIKdwN+1I/IdUDixnATQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrjaD5NbxBzZhULemKZkvwA0Ygker7xDj93kvG+/22HeEQT6eynH00WiqeFAJivfss9z0deT8y2JTG5DEBUbiVOCu3TAlzHVXe+TMeem6YLwZCQ/bDrkFEBLODgK3W6MwFRMgbYSL4YjU2DITqQzzsA7u/rc3Zya8L2GUhzaTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fuCN4Rkf; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d60504db9so16079277b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755260653; x=1755865453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5a1hcAV+aFoGNWJ/TQ9KJVVsUbsqFwHIGVoQOC8GMQ=;
        b=fuCN4Rkf+vpwJhhCq0fGxO5/ng4aPH99iEh80x1rMuRmQ1GHO4jMEo3zNRPnU41z3P
         s2XgW93tzgixlgTMLycK3lizDJdN+wz+MvzQuY+9k1bqmkarAs6y8Pe4qhxc4P4BvChi
         jlJK2/lYncj5zFs6XJlJxk1vpDZqalj3p3H8MpE56nuPuDIdkgwwaExZmw8Bcq13bD4w
         WN6Mo3mrIUsDChhzh+IZKLZn9QtVLI8wdvRCXa3vtK/OrHs8kqlmYl+NgI5VtXsfuDxC
         JIl6KtWQuu8oUwWGoY1AFwkA8G2Rlo+pV/3vUph8VUwKpKdJD+LlmKHUCiGge30NCO/Y
         wqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755260653; x=1755865453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5a1hcAV+aFoGNWJ/TQ9KJVVsUbsqFwHIGVoQOC8GMQ=;
        b=r5i+wFHoslR2KwdR0wHT7n5SqrNz35pD38mdUxQZyzpn/9+YSjBOnKnBQ6y4bHXbSB
         KRm2s053Sau+3BLojpWhKR5BU/UrFIBmRPTysiCrqi75+QuJyhlaVM19CqvCtRYiijqi
         xsO2Q8/oQeLHnmEySY73A9cWqBCQFOOzEWXXkt0CEx3A4ja5d7Kv+n/CudU6DiPPyWd6
         KNE+HD8E1t/LfNQOLVAt+qNg4oXVuIULswwE2XTIzC+mgEJoGky9R2HPR8bKv63Kp5YA
         DUCXiIA5fBT33v7crgxl0Ui2ZuCBzXEF8voEjdt7ddMtPuFKSNGt5v58l08Hm1xYP1gI
         2aSg==
X-Forwarded-Encrypted: i=1; AJvYcCWq4SLmBgQ4dUUV18NXKYG4xi1LEhBJaQxPy1EPYQ3yrgLs6T883U19eVqI+/NcVkHpIP3wUqIDurq/hKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmv0Olg0tJTwky8Zj/m3c7IQ+TgfQLeW9qC33HTiaPQXV0WzBg
	A9mfLBhU49KqFb4tXWIqwX1y65zONWhSwhtbHK/TcUvD0FEtWgayvLW2WiOQI/ds/rY/vPPG5s7
	w6lD/ldR6rz2GPcjv7FG30jAx1IIEEpIAKctPD5WwJQ==
X-Gm-Gg: ASbGncuVrP+qzVO5wFzSgOiFJcwaC8QvRW8hDgjg58cS9Cf5DU1d/MnWws5zyYgYJGX
	hMNi+MVj0ZhzxLCa+qsk0py6BlMo35cVJTiLAd7vqmbqXmge6FZJ/TNZko3wGYjsVumU5uCiOOh
	gPYuV3FhhPj4W4zIjf+CsAirIrLMDlBQ104DQLLweZqIOW1evCaDEySFLgwHVEeZ46+VWVp3jLW
	X7WOb1k
X-Google-Smtp-Source: AGHT+IET0jvBPg59oKauMRn6o6ClybC0fgYZHTLg2pDO7eeUoj22mK437Hop7Rqk1JEhtNNTge2rfC/nIhIs3Pgaue0=
X-Received: by 2002:a05:690c:338e:b0:71d:5438:36d5 with SMTP id
 00721157ae682-71e6df4c581mr20897317b3.40.1755260652902; Fri, 15 Aug 2025
 05:24:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716-mobileye-emmc-for-upstream-4-v3-0-dc979d8edef0@bootlin.com>
 <20250716-mobileye-emmc-for-upstream-4-v3-5-dc979d8edef0@bootlin.com>
In-Reply-To: <20250716-mobileye-emmc-for-upstream-4-v3-5-dc979d8edef0@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 15 Aug 2025 14:23:37 +0200
X-Gm-Features: Ac12FXyI_8ufmFHbQWW66qRqG75PXzoyZ-dSldUZIb8uICL3J9Y4gmA6xP8P8Xo
Message-ID: <CAPDyKFr4urmw75MB48nCOYq+8n1DEufqY9b7EN8mooL2xTY0pw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mmc: core: add mmc_read_tuning
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
> Provide a function to the MMC hosts to read some blocks of data as part
> of their tuning. The card parameter is optional since it is not
> available from the execute_tuning() operation, but present in
> execute_hs400_tuning() and prepare_sd_hs_tuning().
>
> This function only returns the status of the read operation, not the
> data read.
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
>  drivers/mmc/core/mmc_ops.c | 79 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mmc/host.h   |  2 ++
>  2 files changed, 81 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 66283825513cb4ff993a1b2ec1f0b0cac4e74487..d29e5daf3e326ab37e61c9945=
6421b1f66bcb0de 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -1077,3 +1077,82 @@ int mmc_sanitize(struct mmc_card *card, unsigned i=
nt timeout_ms)
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(mmc_sanitize);
> +
> +/**
> + * mmc_read_tuning() - read data blocks from the mmc
> + * @card: mmc card to read from, can be NULL
> + * @host: mmc host doing the read
> + * @blksz: data block size
> + * @blocks: number of blocks to read
> + *
> + * Read one or more blocks of data from the beginning of the mmc. This i=
s a
> + * low-level helper for tuning operation. If card is NULL, it is assumed=
 that
> + * CMD23 can be used for multi-block read.

It makes sense to have a comment for this, but I would just just drop
the "struct mmc_card *card" as an in-parameter. If it turns out to be
needed later on, we would need additional changes to enable the caller
of mmc_read_tuning() to pass the "card" along.

> + *
> + * Note: Allocate and free a temporary buffer to store the data read. Th=
e data
> + * is not available outside of the function, only the status of the read
> + * operation.
> + *
> + * Return: 0 in case of success, otherwise -EIO / -ENOMEM / -E2BIG
> + */
> +int mmc_read_tuning(struct mmc_card *card, struct mmc_host *host,
> +                   unsigned int blksz, unsigned int blocks)
> +{
> +       struct mmc_request mrq =3D {};
> +       struct mmc_command sbc =3D {};
> +       struct mmc_command cmd =3D {};
> +       struct mmc_command stop =3D {};
> +       struct mmc_data data =3D {};
> +       struct scatterlist sg;
> +       void *buf;
> +       unsigned int len;
> +
> +       if (blocks > 1) {
> +               if (mmc_host_can_cmd23(host) &&
> +                   (!card || (mmc_card_can_cmd23(card) &&
> +                    !mmc_card_blk_no_cmd23(card)))) {
> +                       mrq.sbc =3D &sbc;
> +                       sbc.opcode =3D MMC_SET_BLOCK_COUNT;
> +                       sbc.arg =3D blocks;
> +                       sbc.flags =3D MMC_RSP_R1 | MMC_CMD_AC;
> +               }
> +               cmd.opcode =3D MMC_READ_MULTIPLE_BLOCK;
> +               mrq.stop =3D &stop;
> +               stop.opcode =3D MMC_STOP_TRANSMISSION;
> +               stop.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> +       } else {
> +               cmd.opcode =3D MMC_READ_SINGLE_BLOCK;
> +       }
> +
> +       mrq.cmd =3D &cmd;
> +       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +       mrq.data =3D &data;
> +       data.flags =3D MMC_DATA_READ;
> +       data.blksz =3D blksz;
> +       data.blocks =3D blocks;
> +       data.blk_addr =3D 0;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +       if (card)
> +               mmc_set_data_timeout(&data, card);
> +       else
> +               data.timeout_ns =3D 1000000000;
> +
> +       if (check_mul_overflow(blksz, blocks, &len))
> +               return -E2BIG;
> +       buf =3D kmalloc(len, GFP_KERNEL);
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       sg_init_one(&sg, buf, len);
> +
> +       mmc_wait_for_req(host, &mrq);
> +       kfree(buf);
> +
> +       if (sbc.error || cmd.error || data.error)
> +               return -EIO;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_read_tuning);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a902047ac517441b6820fa6e4166a13..5a6471a6219222b199a16afd9=
e6bd5ab74b05c86 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -743,5 +743,7 @@ int mmc_send_status(struct mmc_card *card, u32 *statu=
s);
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> +int mmc_read_tuning(struct mmc_card *card, struct mmc_host *host,
> +                   unsigned int blksz, unsigned int blocks);
>
>  #endif /* LINUX_MMC_HOST_H */
>
> --
> 2.50.1
>

Otherwise this looks good to me!

Kind regards
Uffe

