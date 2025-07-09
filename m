Return-Path: <linux-kernel+bounces-723924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F74AFEC78
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A33A1888A57
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA842E54DE;
	Wed,  9 Jul 2025 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WrWGlr+d"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60B2E4252
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072444; cv=none; b=LEIebf7t4GnlIuW8Z80aI+BRKFwhWHEaSJ9STC1nwxrhkdxkBfyUvt84W0pDST/bSsU5ocXlVRq3t/7zkTrhUZCnQpPi5m2IhoHGAkV8MhvoZa36juaAGJ/xnYHsUa1z2ztyzKSRyBshRHe/4LIN3EtdetXElei7JnKdnMeeniI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072444; c=relaxed/simple;
	bh=2y9TLBtmYiq/ol8HOFbrUlXzZccEQFXCKvLP2xlDRuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZqaTaHo0wEnWIhAlfzp+TBXIoLZqTpJaLhFgIMrzmu873fdJfUJ9gmlkGbSUMGzRsS6xDhRxMov5/UuCkgq7BhrN6dC3cq8TD9WpO+UK/4zQzCRWxyX0eUIh1/zvLu+jwRb6oYMoCHTSQJbIXgc6u4nxtEFJxo6n2Hrs5WqN7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WrWGlr+d; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7569ccf04cso4667855276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752072442; x=1752677242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8h6N8ymdvLxrPdThRLNevh87P5TYtoxTMzmRdyKUHE=;
        b=WrWGlr+dXnlRLw9lLKSQBSe+X6Pl8zvEzg5gItxkUX1/AIXgaFPx/q9xViqcqgKo9Z
         beEXnPzBa7+Syzfp/LZWkYizI9oABMzJ9jjl0ggv34M2/xah9huUCRMAs2RRjnhzMG/n
         t/YsmyK5r9wv37Z9m6CRxPCb9nzkrTPlTIAmp/SN75W//N0nq+dtQOCkvMPOnDfuMvGr
         PUsbCevXmdua1qTQHm338A/YdBa59bMoH4vtuNAGsbfYmWJDmv+NE1hlwvKrtYdzVU1S
         PdRDOhqxK5uOUIfppWItHxJdrbaRnjlfZ85lPUxZj4p2P9r+DUI4T19D1pz1rIQo5igj
         WLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072442; x=1752677242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8h6N8ymdvLxrPdThRLNevh87P5TYtoxTMzmRdyKUHE=;
        b=I4xFIaaVquTBFgJ11vh4Tp2bQbrmMEOntA6voqB4fS6xgabU1lLZWyOvrilLVy8Y3r
         kuNAl7ZLihJdxiftVrW4zGUiMocN+2c/ttR+SAxyQ0R6TTocKK+b+o8fiO59cq5WPGRn
         nhGAmLC/Y6vZOLhrh1EROOJSrHVAuM0R+1Bb1/K4niD0frfpJ8Jin11ThzWboVPXE73y
         18sdVa9R0qeEQLpBvyzj6PjLS7mQPd14cdFG0/JWfdc6Pyr9qCtVRL9BEl/xmeEDBs15
         EOnaRxxPDo4fgI69tTl5wljnotAM/MDznma9gf0d025Lw8/5TYaG/9z4/0I/2NmRCTNQ
         FwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNQdPaV+1YVFlsMJYdzSJR7WM3oUHnFLjPovmknYHU2keR3hO9rJvbo8KoTd0D1sMMsp6xz7Qp3/hbjSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSp9DrCLZ0x1QBHZ2LDZ+u/Ccda/bkqFs3E2p8Ja/t4SFaVppK
	2/eYLhBCMsiIMmXc+dm5KdSsepIpWvQkwCKFkv1NdZeDnpF1u7WR8ntzNd8JZKDe0Kg+ILX47k1
	6bLdIIzRc2qyoHoYirMaCHPXLUmnMRDT4mtDKMoM17Q==
X-Gm-Gg: ASbGnctIhom4wgkx2sTcYfKvsNRRyNyQDYrG87MdpZ1J7IRn23T5YFJNcGziWbe2T1E
	0PTLSc7MiTgfX3MhFpLQY1jqIVRq7GZEqSTF57hYLaTOtuXActpdu+Vv8sPNYosfn1iYbtQ0t/3
	GNQ700l5K9AZZNWSwrwYvET72iNBPhDzWtS4ywRcwGUjxj
X-Google-Smtp-Source: AGHT+IHm50Q/Wpaz874mY4jdAmqECDmpXqUtZjcjDmDE66JzxsRL46uGd0Mc+kTBorrd8AfqMgZxO/JQZMz1b8Hsw+Y=
X-Received: by 2002:a05:690c:3347:b0:70d:f3f9:1898 with SMTP id
 00721157ae682-717b1a16f3fmr44393627b3.35.1752072441484; Wed, 09 Jul 2025
 07:47:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751898225.git.benoit.monin@bootlin.com> <346c422139b658b2ba6272f7ba7b07374008760f.1751898225.git.benoit.monin@bootlin.com>
In-Reply-To: <346c422139b658b2ba6272f7ba7b07374008760f.1751898225.git.benoit.monin@bootlin.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 16:46:45 +0200
X-Gm-Features: Ac12FXyoOH3Cz2x3GZX3zU25hhNwfDgVI-X6k3TawPF3ZhvpR4wWP9rJxod6_uY
Message-ID: <CAPDyKFp=fvyUhkeiw5TmYbELM+MiC8Do20afrainOyq_pLvSHw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: core: add mmc_read_blocks to mmc_ops
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Jul 2025 at 17:24, Beno=C3=AEt Monin <benoit.monin@bootlin.com> w=
rote:
>
> Add a generic function to read some blocks of data from the MMC, to be
> used by drivers as part of their tuning.
>
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@bootlin.com>
> ---
>  drivers/mmc/core/card.h    | 10 ++++++
>  drivers/mmc/core/mmc_ops.c | 69 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h   |  3 ++
>  3 files changed, 82 insertions(+)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 9cbdd240c3a7d..93fd502c1f5fc 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -11,6 +11,7 @@
>  #define _MMC_CORE_CARD_H
>
>  #include <linux/mmc/card.h>
> +#include <linux/mmc/mmc.h>
>
>  #define mmc_card_name(c)       ((c)->cid.prod_name)
>  #define mmc_card_id(c)         (dev_name(&(c)->dev))
> @@ -300,4 +301,13 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const=
 struct mmc_card *c)
>         return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
>  }
>
> +static inline bool mmc_card_can_cmd23(struct mmc_card *card)
> +{
> +       return ((mmc_card_mmc(card) &&
> +                card->csd.mmca_vsn >=3D CSD_SPEC_VER_3) ||
> +               (mmc_card_sd(card) && !mmc_card_ult_capacity(card) &&
> +                card->scr.cmds & SD_SCR_CMD23_SUPPORT)) &&
> +               !(card->quirks & MMC_QUIRK_BLK_NO_CMD23);

First, please make the above part a separate patch. It makes sense to
add a helper for this, as you show in patch3 and patch4. I also
recommend that these patches should also be re-ordered so they come
first in the series.

Second, I don't think we should mix mmc_card_can* functions with the
card-quirks. Better to have two separate helpers, especially since
CMD23 is used for other things too, like RPMB and reliable writes, for
example. Thus I suggest we add:

mmc_card_can_cmd23() - which looks at what the card supports, similar
to above without MMC_QUIRK_BLK_NO_CMD23. Put the definition in
drivers/mmc/core/core.h and export the symbols, similar to what we do
for mmc_card_can_erase() and friends.

mmc_card_broken_blk_cmd23() - which should only check
MMC_QUIRK_BLK_NO_CMD23. This belongs in drivers/mmc/core/card.h.

> +}
> +
>  #endif
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 66283825513cb..848d8aa3ff2b5 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -1077,3 +1077,72 @@ int mmc_sanitize(struct mmc_card *card, unsigned i=
nt timeout_ms)
>         return err;
>  }
>  EXPORT_SYMBOL_GPL(mmc_sanitize);
> +
> +/**
> + * mmc_read_blocks() - read data blocks from the mmc
> + * @card: mmc card to read from, can be NULL
> + * @host: mmc host doing the read
> + * @blksz: data block size
> + * @blocks: number of blocks to read
> + * @blk_addr: first block address
> + * @buf: output buffer
> + * @len: size of the buffer
> + *
> + * Read one or more blocks of data from the mmc. This is a low-level hel=
per for
> + * tuning operation. If card is NULL, it is assumed that CMD23 can be us=
ed for
> + * multi-block read.
> + *
> + * Return: 0 in case of success, otherwise -EIO
> + */
> +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> +                   unsigned int blksz, unsigned int blocks,
> +                   unsigned int blk_addr, void *buf, unsigned int len)
> +{
> +       struct mmc_request mrq =3D {};
> +       struct mmc_command sbc =3D {};
> +       struct mmc_command cmd =3D {};
> +       struct mmc_command stop =3D {};
> +       struct mmc_data data =3D {};
> +       struct scatterlist sg;
> +
> +       if (blocks > 1) {
> +               if (mmc_host_can_cmd23(host) &&
> +                   (!card || mmc_card_can_cmd23(card))) {
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
> +       data.blk_addr =3D blk_addr;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +       if (card)
> +               mmc_set_data_timeout(&data, card);
> +       else
> +               data.timeout_ns =3D 1000000000;
> +
> +       sg_init_one(&sg, buf, len);
> +
> +       mmc_wait_for_req(host, &mrq);
> +
> +       if (sbc.error || cmd.error || data.error)
> +               return -EIO;
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(mmc_read_blocks);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 68f09a955a902..72196817a6f0f 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -743,5 +743,8 @@ int mmc_send_status(struct mmc_card *card, u32 *statu=
s);
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
>  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
>  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> +                   unsigned int blksz, unsigned int blocks,
> +                   unsigned int blk_addr, void *buf, unsigned int len);

I really think we must avoid exporting such a generic function. This
becomes visible outside the mmc subsystem and I am worried that it
will be abused.

Can we perhaps make it harder to integrate with the tuning support on
the core, somehow? I haven't thought much about it, but maybe you can
propose something along those lines - otherwise I will try to think of
another way to do it.

>
>  #endif /* LINUX_MMC_HOST_H */

Kind regards
Uffe

