Return-Path: <linux-kernel+bounces-768443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDBCB26119
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E970563F51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65A2FC877;
	Thu, 14 Aug 2025 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eeFcXefv"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059EF2EAB90
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163821; cv=none; b=rN/y7w8JIdEWTIE6eNDdgAbb2s6yLvfsS5JwfQHhwlooTpZPrMfAANrnrFjGqC1eYxSspZY54hpnJN7egDZS0O7p+PlCf6ynkyYxY+odLhIiVRxxnpcMEQuOSYzmS7A4ZPflKnSDFENqj131ArSmEa9MqXLIc1RZ5B017SzRADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163821; c=relaxed/simple;
	bh=J8jMHt5pDvuf9Ksba3L+sKz1blrw/cqZJi3UohVXYKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rGylY1NVKBtmujVawKzibmD0ZaApkXEkvbUWa8YZACVUE4CgxFcv4py0ScMMkgAe95Tam1DS70ppsDALjNSlZbj6c6GCaC1uJIB5VspRMSgblqw0I8dLO3uoXy7FygdBEY1XmaFmLWn5McE0r2BpG/4YNEV9YnCaA+FrZHQIOiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eeFcXefv; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-323266d74b0so657076a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163819; x=1755768619; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KZheZJ/toQQKQqa5gxAgbjscdso3xZ7CnKFaNw4NAno=;
        b=eeFcXefvqraKrAW/GT3eYkSjDxa/Xh5XepjpbIEqkz3LKIuA+Y9mTAoNtXvAU52O2a
         dbPiuEqoefQGe7L7mvCTRFNC3W4R7dllElm0c1yYch9b1RP467SulCjhCLJ5thl5ic4n
         F8t6HH8qg2KFa62Gibp4hwkK6v5yq9ZujqoHLXi9xGiGCvcHOErYzmroqgO5IrK48O9X
         bsXoKrl7rjEuhQNaySNsjnktGhWK8oYiWmnP5xH/r5qUMs3mZh5/reKpptG80sCIVQMr
         ZLCSW0AsmQYRfkJdAYEfIupHqUOU47fO/2A/2GsO3VKTttWiMgdhwZnlPXmfsJSkizBT
         bkXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163819; x=1755768619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZheZJ/toQQKQqa5gxAgbjscdso3xZ7CnKFaNw4NAno=;
        b=MOisOXwc6g2qHAtrFFb2UDS0xBLAuIRU1oq69jEPHfWBdNXDl+YlyiUfJB+eSQAw00
         z4YR8PhcZAklMwunQj8gh0KeIzwSuE2RlO9AgWnz8o0H3B6sCLc6OdgqCytaqAQsrymo
         NpvDAwv46VF/O7c3cvIY1+EAcCa8aKFkvO63kK75tYnFZZawLBOOBCBOWvkGaU5B5BuX
         RrxaquVztbCLCwGpiaGOStEHwGyb45akXRnzvTvHaaKtt6hW35fY71V07122VeDVgrNx
         lkBKPLkjxDVDC/UY/Ih14rfWXpYBcJewTXZkP/LyUg8LYiLtMUyiQWHJoGklZqCFxXG4
         YRkA==
X-Forwarded-Encrypted: i=1; AJvYcCVGpEE6r23sWoJ4gPNl31O+RSlzhk5ww9hkbtuH8BNPSjPuUy+HpEnrF1+gtx7XPZtFG1EHsxjmSk3UErU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLOngOaEloCWaZCylEhluqqwDfMlTVwwE7CAo9+8fDfYoDQ/sR
	1pTaL3nQNjxmhg86ruuT1KNBXUoPIvIAr461tQRxyoToZhe3BMaFhJrYyO3r2BbjBA4ECoCEdvU
	RHVxyPdHYori/TtKrLk0iblcECOnoTFHTeaGtSsTt0w==
X-Gm-Gg: ASbGncvYToh6QMkNrXPET86rQ6HGPYBv/xhmb4s/jc+rqS1XBM3byO9jjje0jDtbLLo
	9fqWDBilu2Oh6Zk1prUXFwKkvcaKjQcw/Kz00CtmPUQDhcmnE6AUF0/gGfPf5Ouvi5rVImKRXoe
	NtGjNmaflB5OhdyEW9J3+lskb0sYhKQach2gD7l+eXF6BzQgs1VIrcUeTmjOoew52IAf/BD6UY8
	GAuAMA7
X-Google-Smtp-Source: AGHT+IGOEqxYvsZ6H2SOjQLeUOjLeH+SKmTZgQK2TnpiOHHbyuDOiYjZUePXxVEDxPdfZaKLRMmpjuASbcHKjV/COxA=
X-Received: by 2002:a17:90a:e7d2:b0:312:639:a06a with SMTP id
 98e67ed59e1d1-32327ad1145mr3548617a91.31.1755163819089; Thu, 14 Aug 2025
 02:30:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com> <c527e86c-916e-45bc-b469-8d5c94e980d2@linaro.org>
In-Reply-To: <c527e86c-916e-45bc-b469-8d5c94e980d2@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 14 Aug 2025 10:30:06 +0100
X-Gm-Features: Ac12FXxe_gY7LdhKZY-w6V0xhWNAIM3JBVo50HcJRl7rKeWflM4wJgRrEwiAOXM
Message-ID: <CAJ9a7ViMZoLUwuvseqRi+mNhfsxq8RVRT=s7ZWkSXZiq=QmJ7w@mail.gmail.com>
Subject: Re: [PATCH v2] coresight-etm4x: Conditionally access register TRCEXTINSELR
To: James Clark <james.clark@linaro.org>
Cc: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>, kernel@oss.qualcomm.com, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Aug 2025 at 10:30, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 12/08/2025 9:24 am, Yuanfang Zhang wrote:
> > The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
> > To avoid invalid accesses, introduce a check on numextinsel
> > (derived from TRCIDR5[11:9]) before reading or writing to this register.
> >
> > Fixes: f5bd523690d2 ("coresight: etm4x: Convert all register accesses")
> > Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> > ---
> > Changes in v2:
> > - Add fixes tag.
> > - Replace "if (drvdata->nrseqstate)" with "if (drvdata->numextinsel)"
> > - Link to v1: https://lore.kernel.org/r/20250811-trcextinselr_issue-v1-1-ed78f3215502@oss.qualcomm.com
> > ---
> >   drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++++++++---
> >   drivers/hwtracing/coresight/coresight-etm4x.h      |  2 ++
> >   2 files changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 42e5d37403addc6ec81f2e3184522d67d1677c04..4e411427303981104d11720d3c73af91030f8df3 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -528,7 +528,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> >               etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
> >               etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
> >       }
> > -     etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
> > +     if (drvdata->numextinsel)
> > +             etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
> >       for (i = 0; i < drvdata->nr_cntr; i++) {
> >               etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
> >               etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
> > @@ -1423,6 +1424,7 @@ static void etm4_init_arch_data(void *info)
> >       etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
> >       /* NUMEXTIN, bits[8:0] number of external inputs implemented */
> >       drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
> > +     drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
> >       /* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
> >       drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
> >       /* ATBTRIG, bit[22] implementation can support ATB triggers? */
> > @@ -1852,7 +1854,9 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
> >               state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
> >               state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
> >       }
> > -     state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
> > +
> > +     if (drvdata->numextinsel)
> > +             state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
> >
> >       for (i = 0; i < drvdata->nr_cntr; i++) {
> >               state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
> > @@ -1984,7 +1988,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
> >               etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
> >               etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
> >       }
> > -     etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
> > +     if (drvdata->numextinsel)
> > +             etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
> >
> >       for (i = 0; i < drvdata->nr_cntr; i++) {
> >               etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> > index ac649515054d905fa365203bd35f1d839b03292f..823914fefa90a36a328b652b0dc3828b9bddd990 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> > @@ -162,6 +162,7 @@
> >   #define TRCIDR4_NUMVMIDC_MASK                       GENMASK(31, 28)
> >
> >   #define TRCIDR5_NUMEXTIN_MASK                       GENMASK(8, 0)
> > +#define TRCIDR5_NUMEXTINSEL_MASK               GENMASK(11, 9)
> >   #define TRCIDR5_TRACEIDSIZE_MASK            GENMASK(21, 16)
> >   #define TRCIDR5_ATBTRIG                             BIT(22)
> >   #define TRCIDR5_LPOVERRIDE                  BIT(23)
> > @@ -999,6 +1000,7 @@ struct etmv4_drvdata {
> >       u8                              nr_cntr;
> >       u8                              nr_ext_inp;
> >       u8                              numcidc;
> > +     u8                              numextinsel;
> >       u8                              numvmidc;
> >       u8                              nrseqstate;
> >       u8                              nr_event;
> >
> > ---
> > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > change-id: 20250811-trcextinselr_issue-f267afa0e5ed
> >
> > Best regards,
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

