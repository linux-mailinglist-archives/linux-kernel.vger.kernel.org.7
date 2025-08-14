Return-Path: <linux-kernel+bounces-768574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5EB262CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEA85A0A54
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605012E7F1F;
	Thu, 14 Aug 2025 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epl4/Mq9"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7042FC88E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755167131; cv=none; b=jhK8IKc0i5HtBQvlzIXXXDVSsV6z/atZyBgaE0Tf/pqmhhubE48s0Bsv1tS2L3dZUHojj/N2rr0NR7jJlilKXezTIWxT47jC69cwDju7rRq2fUja7LzASVXUcM8iAyF/9bFYzrg8SRQYqsHxMmAoLBU8kAwWPMx+DVQ62JTAp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755167131; c=relaxed/simple;
	bh=Y3sXF5J2XtEmlT3U8RWsY3ND48ZnRlCE1LO+7eUaf60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FeI+nmMpCoiEpzoLrkpkBDNyPFiLQ20efqC/jnWeR/1xWszkQHxYC/1SQOw1rYjmdmEBx/qfmPFZ89FShyBpJc1q9hFXrblfByx6ix4g5S71pYIyx+cR9+NV4GD3n4KLuwThfPCnoefubQab3exsqxsxKtFhTGAZi0PQnRHB83k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=epl4/Mq9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323267b98a4so745761a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755167129; x=1755771929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FpGkbSZTH0YknQyYJZMYGzUvtXXPiBXKw7DK+s5tWTc=;
        b=epl4/Mq967uE0lydvHGABtEneUEbyyPVl7oGm6ffSSQxXSkdtVXhw8xfx8h8yyh/KU
         kjmaGzRlGGX/6C7XZnFV+Ukg9iuKKIYqv55ro5pxt8wEZfuGJ7mgGbeNY2hI1ZQ5KYpV
         Xu++tC3GCNm6mjXGevF6i2O3msUNP5m7574vWFpyyUE0KDCWJ1Ws9uCnR7YCxbusseaN
         vK+GKgHp9xlHoMMzgU9f0UEw4Le1dVVxc2D04wlmwHZCFTRswW3jdAcnVl2Xkb+JSkwa
         2gNwZ7vW8t+KfN45Cc03Y3sNA/jiceTgDz2aWmkk8sFlJarUAfloCqDyOyB2LpABn44p
         5+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755167129; x=1755771929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpGkbSZTH0YknQyYJZMYGzUvtXXPiBXKw7DK+s5tWTc=;
        b=NgwdbTnQtnPgPkFi7neAJYBXiXUXSEdItfZ8z6Y7AmfvTWGUmew1mqxx3bCDeR4kLn
         ADcM/+26z6Vpv/w3MQpXyPdHP+eZpa8BXyFjZYds+7EimHjHQRjKYAsZE5lgl7dtwS5e
         Jlc7W37JpPYDNYsBTItH5+0TFBFln7NYwGxvzxF0hDr0ofgMO4+mY06MTcpPLfZGyWCE
         aJIAj5LpmZguIEJ0lnRvm+e0HeJGz5lRpk1lgKQu0RFb8Yco+SNK51u8LSnikKtAbHmZ
         wmrvFrL/WEpASGfO92DyMrBeVEFjNP4HnPtn4Oay8NBNWHFCpr7noQQyjwEGMUZwfudG
         0P0g==
X-Forwarded-Encrypted: i=1; AJvYcCVQgd51jtXRcSTkiWIuETnnJf/kpwMnD3E5ZtMieD1EIEYy9OQj4nnxkChitTNjR6rMNFJ8fJLj7YIQOgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbqqCuHbbJX1cD57owSjpSJU5E3zbOBJVAA/4Fnese++KPpHD
	PgFjl7b7dWwGdKCe1cBsk4ONmcOX/aIK+IxqdVC0Wu70aF2jt4BXkySCjee9DW4Tx3jkdhnP136
	+AMEEuQyWPKeGkXIVF+1+lb4Mw9iOqwMSpQCgOHq8ag==
X-Gm-Gg: ASbGnctOI4aZdlBqEVGdOZYYl+rd7ZKK2wD1o6vMogOrPOqKEVV7i3PeM27dCtECrk1
	JycebfLoO+FwCJ1iZJNaVPfc4Th+k1MH4Wt/pwJLgLcBmilIYCqiw91cX1bL1BaEFqQVnb019+l
	7gwDW8KSMcUUqHWSYb3bOAuIOq+eCWaRN7nvGBwImrGn7OUNjk++VifCrlf9EGUQ9UjcDGmt4po
	p7Y1jGs
X-Google-Smtp-Source: AGHT+IGz30+Hy3gFiTg1KnKcd85era+jIMkvNCETz576JOwHJ8XIWA/KFX2Wu3mbC41FRqHMX/pJpTpFJUrAJtDL5aM=
X-Received: by 2002:a17:90a:d888:b0:323:284a:5c3f with SMTP id
 98e67ed59e1d1-323284a5ce1mr4106502a91.8.1755167129058; Thu, 14 Aug 2025
 03:25:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com> <272077d5-12b1-4922-b924-a96c34b3b1c9@linaro.org>
In-Reply-To: <272077d5-12b1-4922-b924-a96c34b3b1c9@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 14 Aug 2025 11:25:17 +0100
X-Gm-Features: Ac12FXxwDyviVwWfUtpF9l-HP2Uc7nKXb1Mzv3kyYVuoGcSStUR2CgS_3D4d4W4
Message-ID: <CAJ9a7Vif9__iXasPWi0uUhXNJ63xQBtBksT17MvQ-+rDMVxuAQ@mail.gmail.com>
Subject: Re: [PATCH v2] coresight-etm4x: Conditionally access register TRCEXTINSELR
To: James Clark <james.clark@linaro.org>
Cc: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>, kernel@oss.qualcomm.com, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 10:51, James Clark <james.clark@linaro.org> wrote:
>
>
>
> On 12/08/2025 9:24 am, Yuanfang Zhang wrote:
> > The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
> > To avoid invalid accesses, introduce a check on numextinsel
> > (derived from TRCIDR5[11:9]) before reading or writing to this register.
> >
> > Fixes: f5bd523690d2 ("coresight: etm4x: Convert all register accesses")
>
> This tag isn't right. Although this is where the register accesses were
> last touched, the root issue was present from the introduction of the
> driver.
>

Memory mapped access to unimplemented registers are RES0 so won't fail
- the issue is the system register access where an undefined exception
can be triggered.

Mike

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


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

