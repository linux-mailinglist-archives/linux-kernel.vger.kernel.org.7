Return-Path: <linux-kernel+bounces-757315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D19B1C0BA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B339517B319
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2958C214807;
	Wed,  6 Aug 2025 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LvVSb9Bf"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DBD21171D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463406; cv=none; b=Po8kO65dzAOoESHdtzkEpjVEwH/qgvnOBGikuHyWenA3b09leUEjfYxQtAza/jukfoJDltz1qtFeWP9Tx80EWJ5ZUndS1l4vELdJbiIBFemPZ548A2T3qG5eawmmwNNCcUahx9c5KCY51FBPCTp57bGiE607pdsMiqjNEmzLx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463406; c=relaxed/simple;
	bh=8SW3rfTL8/OejY6ueCEYcCpI7x2u8v0/UM2RH/6/+wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mS3UWTEPYHF1m0rwSqWLSbzrr7zFDvqKisXv3mGl1aMbqDbfb5cBZKePMOAB/rS2NvxGR7h4BTFXy3suU81pWNQk9JrfBDyVYzQ1oPMfa2LxCJIuNYkKcDSjjVnA07Bzj5VUAU2eGIjvnqt/roov34k2HBG49sMQtBb6oKIqzDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LvVSb9Bf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so2950586b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 23:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754463404; x=1755068204; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YF//15yqZSlqqumHm5+I1dKqkACpOoAiiur9eCb1Jyo=;
        b=LvVSb9BfcpNwyhxrQGZ+/5mklNvCLJl1qc92Tlg7+Hkz/kWJ2D/+qFS7yqLtoPAgjN
         LW4tMt+5KjJedBQgbcqWvBqdW0j71Gll+M+Kd0punr43BQcamhIRtZHIWNNwXRHMEmn6
         3CNHhHHAXSvTGmfetiKCXyCbRIKJw/WoovSO/+pbWqa0oYbOQCa0cFfNB9J4N1p0qHma
         zhF8bIgtGMNW2YDERxN6QnHJVyi+/EPjIu9IDQJa303MoMl8XMEnaZIMOZzKiRLiDZxP
         Kuv18RGthy4impbqKQGD6py1iCBd3CRWcJbP3E2aOy5JK8XQLyOBRwtuMmhQwB9r09SD
         RbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754463404; x=1755068204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YF//15yqZSlqqumHm5+I1dKqkACpOoAiiur9eCb1Jyo=;
        b=SPVXYXb0anYcSBH8yVHh4cgPWp43gQubBjdE/nSgRJXchHPM6ymWdFtPeQi+Zo3zub
         IA39qiCEXdKKpxJSnmakFKyLHevIMMePjz1pWAnzBxwBO24O3NcDNJk+P5eMsVqJAW5g
         OHMZk5SisopXKvJjw6OAkbHrU3TW9hFvoxR7nfIesTbDzZer4zqhnBw7AD/HO7NEJqPH
         rwOmDIRqtfsPfl/kZcBTdMUFxH371UjQ0x9AsXrrqgqIpeCRLpO4qlgLxJeUoyPUiE2v
         eScxX9OaW5vp9DsD8rFMUvW19X1cQBNAFxUOs3n+hD7G230yg08F2DI83gr+vTs3WqO5
         uiqg==
X-Forwarded-Encrypted: i=1; AJvYcCUdKjqh4afYeMh0301+y5nk1sVXD09sRd1Tm/RC10ZyBKjdOQsdpJHYHjbptPCVfnZlO2HKTzTs3fwPtlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCbZVNUAKg3Fur5zw4dQZennNL3A06kqTUY1oJiqo++iSR9jK
	Y4nxVOIQZrfvBuoHfny8PItt/syXMCxnxwO9Fx2DUU5lYuEkjsUcEHcMNmkGvWOUJhuMx9F5ETp
	6LYzO0VV9TVOVMNfjwXDiSOvyHppvdb3s4/Yl/cLXpw==
X-Gm-Gg: ASbGncsl7eeFmxEab53HYfH+xY7d9Vh4eKh63kTIZJHr1ri9QMK7O1Y4g+H0VFdIl69
	daT59ta+203AJm1OWo0zMq0ZznlzeWu9SbAgOI7xnUADCCOaVjdWNLtGarDdhZmWeU2XCW1W1HX
	rxLqJdZgzWLW0maVxBABqI2uB3Ro8e11KGvd+BRgPig/bHOwWcC6Y9U/VTAgM/bFk0E0itlHa2t
	iKE0uTbIbua4kb/COGjboSj+wQcXm7ELxN3gZo3
X-Google-Smtp-Source: AGHT+IG/NnFO90EFyREBzeUJTQVnE81eCptHFDA8wq6F7FCqcH2EFp5FH3fAorJsFe129JIXWBiwYYR+36/rIKv43Tg=
X-Received: by 2002:a05:6a21:339c:b0:233:927b:3ffa with SMTP id
 adf61e73a8af0-2403131d8b2mr2874171637.12.1754463403646; Tue, 05 Aug 2025
 23:56:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
 <20250725100806.1157-6-jie.gan@oss.qualcomm.com> <CAJ9a7VgYTUsBn8=qtfwmkoS6Lib-8LgESLBDxXrRVqLnScLKZA@mail.gmail.com>
 <70bf0c0c-4a78-4caa-ab86-76a2c99c113a@oss.qualcomm.com>
In-Reply-To: <70bf0c0c-4a78-4caa-ab86-76a2c99c113a@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Wed, 6 Aug 2025 07:56:32 +0100
X-Gm-Features: Ac12FXwaby67uLz0_UOrF1Ong2A1ayI6v2u4tME5WMfEjkOI4dnPs8iNbSSg6cs
Message-ID: <CAJ9a7VjTYSePycUrL7jODLD7Vgj-qFHz0rUtfBPDhgKx59xKJA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] coresight: tmc: Introduce tmc_read_ops to wrap
 read operations
To: Jie Gan <jie.gan@oss.qualcomm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, James Clark <james.clark@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>, Jinlong Mao <jinlong.mao@oss.qualcomm.com>, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Aug 2025 at 07:30, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
>
>
> On 8/5/2025 6:55 PM, Mike Leach wrote:
> > Hi
> >
> > On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
> >>
> >> Introduce tmc_read_ops as a wrapper, wrap read operations, for reading
> >> trace data from the TMC buffer.
> >>
> >> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> >> ---
> >>   .../hwtracing/coresight/coresight-tmc-core.c  | 50 +++++++++----------
> >>   drivers/hwtracing/coresight/coresight-tmc.h   | 17 +++++++
> >>   2 files changed, 40 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> >> index 4d249af93097..f668047c5df4 100644
> >> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> >> @@ -232,17 +232,10 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
> >>   {
> >>          int ret = 0;
> >>
> >> -       switch (drvdata->config_type) {
> >> -       case TMC_CONFIG_TYPE_ETB:
> >> -       case TMC_CONFIG_TYPE_ETF:
> >> -               ret = tmc_read_prepare_etb(drvdata);
> >> -               break;
> >> -       case TMC_CONFIG_TYPE_ETR:
> >> -               ret = tmc_read_prepare_etr(drvdata);
> >> -               break;
> >> -       default:
> >> +       if (drvdata->read_ops)
> >> +               ret = drvdata->read_ops->read_prepare(drvdata);
> >> +       else
> >>                  ret = -EINVAL;
> >> -       }
> >>
> >>          if (!ret)
> >>                  dev_dbg(&drvdata->csdev->dev, "TMC read start\n");
> >> @@ -254,17 +247,10 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
> >>   {
> >>          int ret = 0;
> >>
> >> -       switch (drvdata->config_type) {
> >> -       case TMC_CONFIG_TYPE_ETB:
> >> -       case TMC_CONFIG_TYPE_ETF:
> >> -               ret = tmc_read_unprepare_etb(drvdata);
> >> -               break;
> >> -       case TMC_CONFIG_TYPE_ETR:
> >> -               ret = tmc_read_unprepare_etr(drvdata);
> >> -               break;
> >> -       default:
> >> +       if (drvdata->read_ops)
> >> +               ret = drvdata->read_ops->read_unprepare(drvdata);
> >> +       else
> >>                  ret = -EINVAL;
> >> -       }
> >>
> >>          if (!ret)
> >>                  dev_dbg(&drvdata->csdev->dev, "TMC read end\n");
> >> @@ -291,13 +277,8 @@ static int tmc_open(struct inode *inode, struct file *file)
> >>   static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
> >>                                     char **bufpp)
> >>   {
> >> -       switch (drvdata->config_type) {
> >> -       case TMC_CONFIG_TYPE_ETB:
> >> -       case TMC_CONFIG_TYPE_ETF:
> >> -               return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
> >> -       case TMC_CONFIG_TYPE_ETR:
> >> -               return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
> >> -       }
> >> +       if (drvdata->read_ops)
> >> +               return drvdata->read_ops->get_trace_data(drvdata, pos, len, bufpp);
> >>
> >>          return -EINVAL;
> >>   }
> >> @@ -769,6 +750,18 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
> >>                          "Valid crash tracedata found\n");
> >>   }
> >>
> >> +static const struct tmc_read_ops tmc_etb_read_ops = {
> >> +       .read_prepare   = tmc_read_prepare_etb,
> >> +       .read_unprepare = tmc_read_unprepare_etb,
> >> +       .get_trace_data = tmc_etb_get_sysfs_trace,
> >> +};
> >> +
> >> +static const struct tmc_read_ops tmc_etr_read_ops = {
> >> +       .read_prepare   = tmc_read_prepare_etr,
> >> +       .read_unprepare = tmc_read_unprepare_etr,
> >> +       .get_trace_data = tmc_etr_get_sysfs_trace,
> >> +};
> >> +
> >>   static int __tmc_probe(struct device *dev, struct resource *res)
> >>   {
> >>          int ret = 0;
> >> @@ -818,6 +811,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
> >>                  desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> >>                  desc.ops = &tmc_etb_cs_ops;
> >>                  dev_list = &etb_devs;
> >> +               drvdata->read_ops = &tmc_etb_read_ops;
> >>                  break;
> >>          case TMC_CONFIG_TYPE_ETR:
> >>                  desc.groups = coresight_etr_groups;
> >> @@ -831,6 +825,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
> >>                  mutex_init(&drvdata->idr_mutex);
> >>                  dev_list = &etr_devs;
> >>                  INIT_LIST_HEAD(&drvdata->etr_buf_list);
> >> +               drvdata->read_ops = &tmc_etr_read_ops;
> >>                  break;
> >>          case TMC_CONFIG_TYPE_ETF:
> >>                  desc.groups = coresight_etf_groups;
> >> @@ -839,6 +834,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
> >>                  desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
> >>                  desc.ops = &tmc_etf_cs_ops;
> >>                  dev_list = &etf_devs;
> >> +               drvdata->read_ops = &tmc_etb_read_ops;
> >>                  break;
> >>          default:
> >>                  pr_err("%s: Unsupported TMC config\n", desc.name);
> >> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> >> index 3cb8ba9f88f5..2ad8e288c94b 100644
> >> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> >> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> >> @@ -223,6 +223,8 @@ struct etr_buf_node {
> >>          struct list_head        node;
> >>   };
> >>
> >> +struct tmc_read_ops;
> >> +
> >
> > declare the entire structure here rather than later.
>
> There is an issue of declare the entire structure here because the
> function pointer needs use the struct tmc_drvdata which is not defined
> at this point and it will cause a compile error.
>

Understood.

Mike

> Thanks,
> Jie
>
> >
> >>   /**
> >>    * struct tmc_drvdata - specifics associated to an TMC component
> >>    * @pclk:      APB clock if present, otherwise NULL
> >> @@ -259,6 +261,7 @@ struct etr_buf_node {
> >>    *              Used by ETR/ETF.
> >>    * @etr_buf_list: List that is used to manage allocated etr_buf.
> >>    * @reading_node: Available buffer for byte-cntr reading.
> >> + * @tmc_read_ops: Read operations for TMC device.
> >>    */
> >>   struct tmc_drvdata {
> >>          struct clk              *pclk;
> >> @@ -290,6 +293,20 @@ struct tmc_drvdata {
> >>          struct tmc_resrv_buf    crash_mdata;
> >>          struct list_head        etr_buf_list;
> >>          struct etr_buf_node     *reading_node;
> >> +       const struct tmc_read_ops       *read_ops;
> >
> > probably should be named sysfs_read_ops to be consistent with the
> > perf/sysfs differentiation within the rest of the structure
> >
> >> +};
> >> +
> >> +/**
> >> + * struct tmc_read_ops - read operations for TMC and its helper devices
> >> + * @read_prepare:      prepare operation.
> >> + * @read_unprepare:    unprepare operation.
> >> + * @get_trace_data:    read operation.
> >> + */
> >> +struct tmc_read_ops {
> >> +       int (*read_prepare)(struct tmc_drvdata *drvdata);
> >> +       int (*read_unprepare)(struct tmc_drvdata *drvdata);
> >> +       ssize_t (*get_trace_data)(struct tmc_drvdata *drvdata, loff_t pos,
> >> +                                 size_t len, char **bufpp);
> >>   };
> >>
> >>   struct etr_buf_operations {
> >> --
> >> 2.34.1
> >>
> >
> > with the above changes:-
> >
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> >
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

