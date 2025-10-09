Return-Path: <linux-kernel+bounces-847148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBDEBCA186
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149F11A64484
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91A62F7461;
	Thu,  9 Oct 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y92Yl9SI"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CB82D0C79
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025761; cv=none; b=TWzsDxrexhl7pm4Nx90mCV41wUHtVN0fb0mG6j/uaeToFu4V/mV+WYedjjcnD3n88f4Jw3bg82Ega4jbcq1Ny93JkQtffpsqS0kbX8jOEnX6jhptoHJ0tl5aRkU/8eo3N9s3mOCdOvKBwsCDTPXpQxqDsGImdcu7yeroJPV69gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025761; c=relaxed/simple;
	bh=jxdpz4z0eM6ClXzOVHMEjorGvW7pkfxKg6u+c3A4wl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G60hJepub5jEbcdGsYlU7m1sVp8ui2TLuNyPCwWZJrW6XmV016gyrGp8JjQa8jjnJAfzHOEZhil8ExnAGFIl1rFsgWcoRUe0UzzArJvC8h4CZ/J4jv9JwzLWO5VXHG7LioKLgciVBFq20tGgyPuDo7qxpCOQvse3z3/Kh9TaKs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y92Yl9SI; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b57bf560703so758727a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760025759; x=1760630559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UK7qLQ7DrVHDNX6/UeRsdr0It6OAo9C3d2TsWRzNSsw=;
        b=y92Yl9SI6LgUKeRCdxTSv816yWCCEntDATpQSMcZOlsWB9M7vqQBehDtWuoaUoEJrq
         WqbvT/woqn/hlv1XdjA1yH1z+IhQxv2i+nDfE0CIdtzzZZY6TnmBUfOfzgzRHoLlf/td
         0GQGBIZxx6Oomjks+4y+MBOfZbiwbkmQJ2z71C8DkdBGWIs2E0TCtWb7QLzRVGeKN+xZ
         RG9Biqf7sLGD/7tbi03mAgblpYWsthvkndQRA0V2V2R14r+TaCbs6npeSsfu/pdjz8So
         78/1vH9xd2euIuI7ZOnVvUi056SUZfWns9VLdAt7ehJE/Q+WUfrse83MeBG+HNbws/LI
         +eeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760025759; x=1760630559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UK7qLQ7DrVHDNX6/UeRsdr0It6OAo9C3d2TsWRzNSsw=;
        b=CZW8kEyCgh2zdZ1ZBz2caDrE9NbxUsPLV1RD6fkWrO46FQCbrDRJtwyi10XJl184Aa
         0FpYzQTly2OUavP+o+6cxQI/+nZgE/AW+7yTfcHDFyIoRFOwcVAlyPfl/6Nm4qur97YR
         EJsV+GBnIJ39jWWsBRe7ccQ63zrbYIAR39P186Rhr9gKUXiJGrwX4Z2OXFwEHFwaAryG
         zz8UaehVNkIMFkuZjWvEPOs5xHhVbCuWYrcfn5PJXWRqWx5QJ/aDDC6884JXfrDnSnnm
         CaNnsYCtn2C0zjPROL6V7smDdCfF5+99h/g6f/Cpu2R1XmmDodYmJre5I5kRYMI1ffZG
         tlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhjX49UjkEAl9xEjpEKNTedDyCfzjNzTJOsSqdUFe46/XthH9zh69SKgtbydhWatOd7ZnDQkTok9NXAzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaxHT5pP6Xmjx/Kx7oAAWx0b+1IOi7PcvYdNaYfxEzgseBFj0
	IGgUZiaxelHY25/JDYik3c8PqeM1Vlb0fw8qQNzsutDJek5vL2SskEDO4HPHhVGsDtCckXY4Yfp
	WI1it+AsxgIeLNRSLU5hXWwlygOvFP6IGZorn6/u00w==
X-Gm-Gg: ASbGncsjyMMUJVyAztvC87FtUa1oA/eJfWPO59ior2PbAGso9WKvrUNT5MEWkwRtoAC
	IxjHVnmGGwmi+TYJixyYUK/TCuIo6t4yraCdT67yswk5vp+yd26EDRrDZMACEXC8f8s6CvHqTXe
	m7IT+hAwlLCALCAlmtzIA4herrlkG6eQjNLGw1PAIerZ8qDK64G+Ew2z4bgFqxnIauHdMBwtox4
	+S29M5RbyJKGmFdBCyHiR8Y3ClPWEdVCodr
X-Google-Smtp-Source: AGHT+IFk2+oFjBX0FUI9xGHk5+npGcvoo8+sDSLunoKRP1avhlzQkFed7GtNaKkkQvR2+f85UlJinfdviLW8apq2dpg=
X-Received: by 2002:a17:90b:4b11:b0:32e:d600:4fdb with SMTP id
 98e67ed59e1d1-33b5127ab2cmr11376058a91.18.1760025758649; Thu, 09 Oct 2025
 09:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002-james-cs-syncfreq-v3-0-fe5df2bf91d1@linaro.org> <20251002-james-cs-syncfreq-v3-3-fe5df2bf91d1@linaro.org>
In-Reply-To: <20251002-james-cs-syncfreq-v3-3-fe5df2bf91d1@linaro.org>
From: Mike Leach <mike.leach@linaro.org>
Date: Thu, 9 Oct 2025 17:02:27 +0100
X-Gm-Features: AS18NWAqASYty10mDPHcL3j3-ueXqb1JUGB1t6tWlPog_IHSQ8KPeyNIz3iX8e8
Message-ID: <CAJ9a7VgOO1pmS0chOXugC7eR06v_Tu8onjJA7rnbqcBdZ2m1iA@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] coresight: Refactor etm4_config_timestamp_event()
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Leo Yan <leo.yan@arm.com>, coresight@lists.linaro.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James,

On Thu, 2 Oct 2025 at 11:09, James Clark <james.clark@linaro.org> wrote:
>
> Remove some of the magic numbers and try to clarify some of the
> documentation so it's clearer how this sets up the timestamp interval.
>
> Return errors directly instead of jumping to out and returning ret,
> nothing needs to be cleaned up at the end and it only obscures the flow
> and return value.
>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 95 ++++++++++++++--------
>  drivers/hwtracing/coresight/coresight-etm4x.h      | 20 +++--
>  2 files changed, 77 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 020f070bf17d..920d092ef862 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -609,18 +609,33 @@ static void etm4_enable_hw_smp_call(void *info)
>   * TRCRSCTLR1 (always true) used to get the counter to decrement.  From
>   * there a resource selector is configured with the counter and the
>   * timestamp control register to use the resource selector to trigger the
> - * event that will insert a timestamp packet in the stream.
> + * event that will insert a timestamp packet in the stream:
> + *
> + *  +--------------+
> + *  | Resource 1   |   fixed "always-true" resource
> + *  +--------------+
> + *         |
> + *  +------v-------+
> + *  | Counter x    |   (reload to 1 on underflow)
> + *  +--------------+
> + *         |
> + *  +------v--------------+
> + *  | Resource Selector y |   (trigger on counter x == 0)
> + *  +---------------------+
> + *         |
> + *  +------v---------------+
> + *  | Timestamp Generator  |  (timestamp on resource y)
> + *  +----------------------+
>   */
>  static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>  {
> -       int ctridx, ret = -EINVAL;
> -       int counter, rselector;
> -       u32 val = 0;
> +       int ctridx;
> +       int rselector;
>         struct etmv4_config *config = &drvdata->config;
>
>         /* No point in trying if we don't have at least one counter */
>         if (!drvdata->nr_cntr)
> -               goto out;
> +               return -EINVAL;

As you mention elsewhere - TS will always be output for at least every
4096 bytes - so if we have no counter perhaps we can live with that.
Previously we where trying to get as fast as possible, now we want to
slow them down - so every 4096 looks a decent compromise if the
hardware has no counters.
TRCTSCTLR will be 0 - which selects the false event - so only the
non-event timestamps occur. Returning 0 here will enable the non event
timestamps

What this means is if the user selects timestamps, there will always
be at least some timestamps output.

Alternatively, TRCTSCTLR = 0x1 selects the TRUE event - which might
result once again in the etm attempting to insert timestamps at every
available opportunity. - though never tried this!

>
>         /* Find a counter that hasn't been initialised */
>         for (ctridx = 0; ctridx < drvdata->nr_cntr; ctridx++)
> @@ -630,15 +645,17 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>         /* All the counters have been configured already, bail out */
>         if (ctridx == drvdata->nr_cntr) {
>                 pr_debug("%s: no available counter found\n", __func__);
> -               ret = -ENOSPC;
> -               goto out;
> +               return -ENOSPC;
>         }
>
>         /*
> -        * Searching for an available resource selector to use, starting at
> -        * '2' since every implementation has at least 2 resource selector.
> -        * ETMIDR4 gives the number of resource selector _pairs_,
> -        * hence multiply by 2.

Well - from ETMv4.3 that statement is not true - there can be no RS
pairs - but no RS pairs forces no counters so should not actually get
here.
Needs comment to reflect this.


> +        * Searching for an available resource selector to use, starting at '2'
> +        * since resource 0 is the fixed 'always returns false' resource and 1
> +        * is the fixed 'always returns true' resource. See IHI0064H_b '7.3.64
> +        * TRCRSCTLRn, Resource Selection Control Registers, n=2-31'.
> +        *
> +        * ETMIDR4 gives the number of resource selector _pairs_, hence multiply
> +        * by 2.
>          */
>         for (rselector = 2; rselector < drvdata->nr_resource * 2; rselector++)
>                 if (!config->res_ctrl[rselector])
> @@ -647,13 +664,9 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>         if (rselector == drvdata->nr_resource * 2) {
>                 pr_debug("%s: no available resource selector found\n",
>                          __func__);
> -               ret = -ENOSPC;
> -               goto out;
> +               return -ENOSPC;
>         }
>
> -       /* Remember what counter we used */
> -       counter = 1 << ctridx;
> -
>         /*
>          * Initialise original and reload counter value to the smallest
>          * possible value in order to get as much precision as we can.
> @@ -661,26 +674,42 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
>         config->cntr_val[ctridx] = 1;
>         config->cntrldvr[ctridx] = 1;
>
> -       /* Set the trace counter control register */
> -       val =  0x1 << 16        |  /* Bit 16, reload counter automatically */
> -              0x0 << 7         |  /* Select single resource selector */
> -              0x1;                /* Resource selector 1, i.e always true */
> -
> -       config->cntr_ctrl[ctridx] = val;
> -
> -       val = 0x2 << 16         | /* Group 0b0010 - Counter and sequencers */
> -             counter << 0;       /* Counter to use */
> -
> -       config->res_ctrl[rselector] = val;
> +       /*
> +        * Trace Counter Control Register TRCCNTCTLRn
> +        *
> +        * CNTCHAIN = 0, don't reload on the previous counter
> +        * RLDSELF = true, reload counter automatically on underflow
> +        * RLDTYPE = 0, one reload input resource
> +        * RLDSEL = 0, reload on resource 0 (fixed always false resource, never
> +        *             reload)
> +        * CNTTYPE = 0, one count input resource
> +        * CNTSEL = 1, count on resource 1 (fixed always true resource, always
> +        *             decrement)
> +        */
> +       config->cntr_ctrl[ctridx] = TRCCNTCTLRn_RLDSELF |
> +                                   FIELD_PREP(TRCCNTCTLRn_CNTSEL_MASK, 1);
>

if we are eliminating magic numbers - the '1' here should be something
like RESOURCE_SEL_TRUE?

> -       val = 0x0 << 7          | /* Select single resource selector */
> -             rselector;          /* Resource selector */
> +       /*
> +        * Resource Selection Control Register TRCRSCTLRn
> +        *
> +        * PAIRINV = 0, INV = 0, don't invert
> +        * GROUP = 2, SELECT = ctridx, trigger when counter 'ctridx' reaches 0
> +        *
> +        * Multiple counters can be selected, and each bit signifies a counter,
> +        * so set bit 'ctridx' to select our counter.
> +        */
> +       config->res_ctrl[rselector] = FIELD_PREP(TRCRSCTLRn_GROUP_MASK, 2) |
> +                                     FIELD_PREP(TRCRSCTLRn_SELECT_MASK, 1 << ctridx);
>
> -       config->ts_ctrl = val;
> +       /*
> +        * Global Timestamp Control Register TRCTSCTLR
> +        *
> +        * TYPE = 0, one input resource
> +        * SEL = rselector, generate timestamp on resource 'rselector'
> +        */
> +       config->ts_ctrl = FIELD_PREP(TRCTSCTLR_SEL_MASK, rselector);
>
> -       ret = 0;
> -out:
> -       return ret;
> +       return 0;
>  }
>
>  static int etm4_parse_event_config(struct coresight_device *csdev,
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 813e7208ad17..a06338851ef5 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -225,6 +225,16 @@
>  #define TRCRSCTLRn_GROUP_MASK                  GENMASK(19, 16)
>  #define TRCRSCTLRn_SELECT_MASK                 GENMASK(15, 0)
>
> +#define TRCCNTCTLRn_CNTCHAIN                   BIT(17)
> +#define TRCCNTCTLRn_RLDSELF                    BIT(16)
> +#define TRCCNTCTLRn_RLDTYPE                    BIT(15)
> +#define TRCCNTCTLRn_RLDSEL_MASK                        GENMASK(12, 8)
> +#define TRCCNTCTLRn_CNTTYPE_MASK               BIT(7)
> +#define TRCCNTCTLRn_CNTSEL_MASK                        GENMASK(4, 0)
> +
> +#define TRCTSCTLR_TYPE                         BIT(7)
> +#define TRCTSCTLR_SEL_MASK                     GENMASK(4, 0)
> +
>  /*
>   * System instructions to access ETM registers.
>   * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
> @@ -824,7 +834,7 @@ struct etmv4_config {
>         u32                             eventctrl0;
>         u32                             eventctrl1;
>         u32                             stall_ctrl;
> -       u32                             ts_ctrl;
> +       u32                             ts_ctrl; /* TRCTSCTLR */
>         u32                             ccctlr;
>         u32                             bb_ctrl;
>         u32                             vinst_ctrl;
> @@ -837,11 +847,11 @@ struct etmv4_config {
>         u32                             seq_rst;
>         u32                             seq_state;
>         u8                              cntr_idx;
> -       u32                             cntrldvr[ETMv4_MAX_CNTR];
> -       u32                             cntr_ctrl[ETMv4_MAX_CNTR];
> -       u32                             cntr_val[ETMv4_MAX_CNTR];
> +       u32                             cntrldvr[ETMv4_MAX_CNTR]; /* TRCCNTRLDVRn */
> +       u32                             cntr_ctrl[ETMv4_MAX_CNTR];  /* TRCCNTCTLRn */
> +       u32                             cntr_val[ETMv4_MAX_CNTR]; /* TRCCNTVRn */
>         u8                              res_idx;
> -       u32                             res_ctrl[ETM_MAX_RES_SEL];
> +       u32                             res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
>         u8                              ss_idx;
>         u32                             ss_ctrl[ETM_MAX_SS_CMP];
>         u32                             ss_status[ETM_MAX_SS_CMP];
>
> --
> 2.34.1
>

Regards

Mike

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

