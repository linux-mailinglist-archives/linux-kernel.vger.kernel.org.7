Return-Path: <linux-kernel+bounces-732217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A792CB0638D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95FA4A84A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D162C24DCEC;
	Tue, 15 Jul 2025 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UmA8NgHU"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18131F30CC
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752594905; cv=none; b=NSfMPEXNibcGw9oKAHab0byeTdl8OH/utUkWbmIWhty1FN54MGsZ8+xkSeH4ObPpV8mzN2s0Q1c+2g9gCMU+W11ClHrEZyI+E2uk2RtMdSLsQkL6++zWBsCIfUmwOKb/TWMozcWH5DGOube1NKKgc+2wo+EcELh75mrsBPkm/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752594905; c=relaxed/simple;
	bh=8nDABm0QbpFqbV6qcagQDzdLTlD790+/qH/YPHReYvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Im8rXYyly6uo0JjZpS7ecxuSIAF1G0nBfNuU4/+87b2YcDpPSoKJ2MB8d+BveM9Y0izvFnqdaRSFUvLQpKir7Np0ALmwkHJx2lSi+b6CiIhAG03KYWmhI5mmaAap/WDhgLPKeqQ4tj89JeFTiLuJPRu8SYskSFq3JHbU1Bdc+H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UmA8NgHU; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e5e6ab7b8so52421747b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 08:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752594901; x=1753199701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WB3s2HCYz/rePzCmNFi6RGTxoEWHz7E/oKmgCMbGRhw=;
        b=UmA8NgHUuHeRF2Y7PplUKo6i4UyA1oCg0kEXuhc7Fmjz1lKawmFR8IO4aODYLJcErw
         0P21b92+TS7d85yg0GMrChM9eSYEDXDNWSoW2/+w6ruLL6jvt1F1osP4SLIO67q+AkY3
         pnTk17MTWquIYVxV31U+Txnygyd1xbOCVPciTF1hhpHQDRx8Gy6yGZ9+4pst599uHcEn
         3bnkkIhUX5NM4Fp7/QCGgT+MDyH8JpREOtw4PusiFjjOeXBbpD8ieIDb/OreW5Htoig8
         5mRdj5eFoGuB+aneEgpFDbWOEf9HyezOfRwJRtZUWoTZZMdV6UKG5uuh8XeK5PV9f0qQ
         zk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752594901; x=1753199701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WB3s2HCYz/rePzCmNFi6RGTxoEWHz7E/oKmgCMbGRhw=;
        b=Bylde1ZQ77CXQqgftsZUSbTmoJvYpBJtJSUHFQKiLKLLwuCdrTP47Xv5nxcBfTcnj7
         LE696kjKh3Bu7xtmOXK2phgzKtRnOvw2nVKvWs37HSUSabeTVVw0szb3TiRUox6pkl/m
         0x8X0Oh5uUBXCYCDNP0nL2SxbeXHrIZAm1BojkmhBpFj0HazOt2a7LaFOXGC9ghYH0cD
         JzYG+AeP3YHBghTM82b/Fn/QnprU2rpdWS6kaQtPcVpbE7Tzvu9gYDjBWaLehQ70u6F7
         wMvs+4ncOBiRKHAxqwINs+pLnHRlXgVkzLIcUqTZxQtGwPTQlM+It7PeFHMZlxFiah1D
         9LeA==
X-Forwarded-Encrypted: i=1; AJvYcCVzk5RMxoyCpR7Ei3iZAySF8YjUVA6veymX13acB+/PHIbtI5EyxiaugKFWvxffIOBHaHH+Kr3WoQ14mhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1cZWYm8XKhu5hXyNxLFPkijK0CmaukMNJ1vmgP9dLP29Ro7+
	7FcWHp7aiyFO5/C1teCf+x4FNXx4OUdCewqerGRKmG0D2VwIjFpdxB2uaLPVUcUmqmjnePuda+t
	+UARQqRBgprUxRGYL7sezYrYNJmheOe08FAvrHpXmmg==
X-Gm-Gg: ASbGnctjVg+aJwFCw4xGeW68o8IP4Xi454ebO0zCtZQYRsDDdGo6wq/hzv5Aspric7z
	yxDKvcuFc4tgmGVo/ZN7vRIPdH9bMmDa/YB35YTQgk1gZIhIZSmaratowwvoRqi7ISnG47h12Ws
	SAh0tJoJ6xmAm8Ayx1+JTSfXtDmoJ6iRLlR5QN0Q2y6E/5q0PaIKeVwkB2vXA1UScLOt7sHdxx0
	MT3AFJH
X-Google-Smtp-Source: AGHT+IF1zRZ4skb16lO7Hz3y8JhqIcAOzt8qRIIDde8w36pNgo8eApgWcC7+yzMMUrZ+UWRcK6MKeJzPo48e26m579o=
X-Received: by 2002:a05:690c:7107:b0:710:edee:74d1 with SMTP id
 00721157ae682-717dac32e5dmr223745117b3.3.1752594900738; Tue, 15 Jul 2025
 08:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751898225.git.benoit.monin@bootlin.com>
 <346c422139b658b2ba6272f7ba7b07374008760f.1751898225.git.benoit.monin@bootlin.com>
 <CAPDyKFp=fvyUhkeiw5TmYbELM+MiC8Do20afrainOyq_pLvSHw@mail.gmail.com> <9903989.eNJFYEL58v@benoit.monin>
In-Reply-To: <9903989.eNJFYEL58v@benoit.monin>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 17:54:24 +0200
X-Gm-Features: Ac12FXwa445k2oQ0FhDy7MdRUFjaFWJ6sZOak3AH4hAUxkdrNU2ydphifvnNNxs
Message-ID: <CAPDyKFpK11BZDT_NmWyMe6Tvj8P3gJNBpM_hX5d52urG+sn6-g@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mmc: core: add mmc_read_blocks to mmc_ops
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"

> > > +}
> > > +
> > >  #endif
> > > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > > index 66283825513cb..848d8aa3ff2b5 100644
> > > --- a/drivers/mmc/core/mmc_ops.c
> > > +++ b/drivers/mmc/core/mmc_ops.c
> > > @@ -1077,3 +1077,72 @@ int mmc_sanitize(struct mmc_card *card, unsigned int timeout_ms)
> > >         return err;
> > >  }
> > >  EXPORT_SYMBOL_GPL(mmc_sanitize);
> > > +
> > > +/**
> > > + * mmc_read_blocks() - read data blocks from the mmc
> > > + * @card: mmc card to read from, can be NULL
> > > + * @host: mmc host doing the read
> > > + * @blksz: data block size
> > > + * @blocks: number of blocks to read
> > > + * @blk_addr: first block address
> > > + * @buf: output buffer
> > > + * @len: size of the buffer
> > > + *
> > > + * Read one or more blocks of data from the mmc. This is a low-level helper for
> > > + * tuning operation. If card is NULL, it is assumed that CMD23 can be used for
> > > + * multi-block read.
> > > + *
> > > + * Return: 0 in case of success, otherwise -EIO
> > > + */
> > > +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> > > +                   unsigned int blksz, unsigned int blocks,
> > > +                   unsigned int blk_addr, void *buf, unsigned int len)
> > > +{
> > > +       struct mmc_request mrq = {};
> > > +       struct mmc_command sbc = {};
> > > +       struct mmc_command cmd = {};
> > > +       struct mmc_command stop = {};
> > > +       struct mmc_data data = {};
> > > +       struct scatterlist sg;
> > > +
> > > +       if (blocks > 1) {
> > > +               if (mmc_host_can_cmd23(host) &&
> > > +                   (!card || mmc_card_can_cmd23(card))) {
> > > +                       mrq.sbc = &sbc;
> > > +                       sbc.opcode = MMC_SET_BLOCK_COUNT;
> > > +                       sbc.arg = blocks;
> > > +                       sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > > +               }
> > > +               cmd.opcode = MMC_READ_MULTIPLE_BLOCK;
> > > +               mrq.stop = &stop;
> > > +               stop.opcode = MMC_STOP_TRANSMISSION;
> > > +               stop.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> > > +       } else {
> > > +               cmd.opcode = MMC_READ_SINGLE_BLOCK;
> > > +       }
> > > +
> > > +       mrq.cmd = &cmd;
> > > +       cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> > > +
> > > +       mrq.data = &data;
> > > +       data.flags = MMC_DATA_READ;
> > > +       data.blksz = blksz;
> > > +       data.blocks = blocks;
> > > +       data.blk_addr = blk_addr;
> > > +       data.sg = &sg;
> > > +       data.sg_len = 1;
> > > +       if (card)
> > > +               mmc_set_data_timeout(&data, card);
> > > +       else
> > > +               data.timeout_ns = 1000000000;
> > > +
> > > +       sg_init_one(&sg, buf, len);
> > > +
> > > +       mmc_wait_for_req(host, &mrq);
> > > +
> > > +       if (sbc.error || cmd.error || data.error)
> > > +               return -EIO;
> > > +
> > > +       return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(mmc_read_blocks);
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index 68f09a955a902..72196817a6f0f 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -743,5 +743,8 @@ int mmc_send_status(struct mmc_card *card, u32 *status);
> > >  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error);
> > >  int mmc_send_abort_tuning(struct mmc_host *host, u32 opcode);
> > >  int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
> > > +int mmc_read_blocks(struct mmc_card *card, struct mmc_host *host,
> > > +                   unsigned int blksz, unsigned int blocks,
> > > +                   unsigned int blk_addr, void *buf, unsigned int len);
> >
> > I really think we must avoid exporting such a generic function. This
> > becomes visible outside the mmc subsystem and I am worried that it
> > will be abused.
> >
> > Can we perhaps make it harder to integrate with the tuning support on
> > the core, somehow? I haven't thought much about it, but maybe you can
> > propose something along those lines - otherwise I will try to think of
> > another way to do it.
> >
> I agree that the function might be too generic now. Here are some of
> the ideas I have to make less appealing for abuse:
>
> * Rename it to mention tuning (mmc_tuning_read?)

Yes, something like that or possibly "mmc_read_tuning".

> * Drop some parameters:
>   * blk_addr: Reading from 0 should be all that is needed for tuning
>   * other?

Yes, I like that. If we can make it useful only for the tuning case,
that would be great.

I think we should drop struct mmc_card* too. The ->execute_tuning()
host ops takes a struct mmc_host* and during initialization when the
callback is invoked from the core, host->card has not yet been set. In
other words, there are no "card" available for the host to use.

Moreover, do we really need to pass along the data that we have read?
Can't we just alloc the buffer, read the data and free the buffer. The
important part is to provide an error code to the caller, letting it
know whether we succeeded in reading the data or whether it failed,
right?

> * Move its declaration to a header private to drivers/mmc (where?)

Unfortunately not, we currently don't have any other suitable place,
but next to mmc_get_ext_csd().

>
> Let me know what you think.
>

Kind regards
Uffe

