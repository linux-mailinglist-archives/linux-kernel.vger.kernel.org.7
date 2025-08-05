Return-Path: <linux-kernel+bounces-756289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7DDB1B258
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D892A3A8EF8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1824166E;
	Tue,  5 Aug 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ikehwb5b"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06331F872D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754391366; cv=none; b=rNeaktdw4KxSHmQgnnGD/yBViGmdf8U0ni/D5HNAoLmV8eGubO4q/y/vLxGGmMR0lpeWZfuOLpIvTh2Usdewn5i7GQEuha1IKasof94OGrvVUOb1nJbI0QXP+s39Pb53E7F/4T8hkafBj3QkHjH7GDT3GgirUDgdX8qzHsbNB5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754391366; c=relaxed/simple;
	bh=K7JVWH9FEAdiV5ONo6KkoRRny+1Zsd4FN9fmvpF6eRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyMWUl2YvkKQQCOEdnljrNncANp2h9VEcdWbfjSDhhd8Ir9++g8dSu3imtfGUvVQfyzIXzReqAIr1Vg9Gck1azSdxyc0h0wS20tEPlYEXm9ujPIvnrRBM5aORdcMuKsPoiyGOo8/WZ8zKLnrcdgow0va9o47dIQnYc4EzC/FU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ikehwb5b; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-31f314fe0aaso4596600a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754391364; x=1754996164; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d/VeXe/l5rldBgts5OXynawp98C/Mo434FuRGJxE2aI=;
        b=Ikehwb5byiGd6fjKJ+QnXyYHL5Jpc2t1Pbf88oUiS+9KYmeCuGOYRE3ldc+KrwyfyO
         mS/IHjOyu6RNsApzQGcjYYTx/lNO/BDQPIUbhOiz4iPar5VxNM2HFQyt2FO5tgD85R8q
         YYlAihBOpDwKimLIe78r3I5XUPRdR0uYgWEJih7su0TO/sPX9XgoSlTpMjFyX0+z76sd
         NenGf1i/V8sjF0AhY+UUfOTx4VD4vMTMtDBdAPwgdyWV7feMZWAjMbwwM3YDuGr1mz0f
         OdhCZTJhSqWaLKaSCoN/JzqneGAO3MU/vQR6TjmSj/9U7v90eJh+p44bg/CevT1a+EA2
         r/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754391364; x=1754996164;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/VeXe/l5rldBgts5OXynawp98C/Mo434FuRGJxE2aI=;
        b=vB/VgZWnNGG/94sAcO+QqUB92dmxdussd287tOBH0ZKtqBNEIFdhQIELFJAc5N5Ugw
         IJleAhS+S+4FZmX3ahIkMAao6yDmnbNA9KV0LbDG9ibDCNjQ17FcbXWknOf2acSaVj/H
         imN1vc3dDaA1lKA+Vq0VFogIphQEsz+5wOxJ64WcpG0FymmnlJ8eKLq4H9PMuaQwD/tK
         q8vl7rHy15kPzTjCYjKltlRxRFaLTcQWXBZadnyj3gbPBB2wJdQbXxP3nh1gmME/yh/P
         LSi8Xqlurvg5S3ELn8yZ5NmU1Fsc+2wopmAlY9MCyX4hcdoBE76FxKBl+EfIJkMGoMlR
         XXEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZrD9GJI3e3Tpt8MdJLIKVtmw/IJm8eREG6lCyNBbz1kAeL6S61sOgMyUQH1f+uEzDVLrTICBn47d5SjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPki+Qke+hWqNHtRWyorVJ1FLVqUcdnntSEQmmfoNo+Y9ZCjt
	mVsJdeRhr00BvmwVD/LlpO+5ers/W88V7kqELgzxKGBCfPe27dOUHopAzcepQllscSIlUEIYE6F
	BJoAm8xhPPeB4AGX9OVDJYUixBqd0ipy4Hc9EyG+u3Q==
X-Gm-Gg: ASbGncvsyUCtxpP4fOesafu3LN19/wWgPdr2Omvc9AM6xiXeOSzxW0zp97WgkNym4bj
	7i5GoQ48DnVA30YnkGMoghdRWFCGYUrOrLjfNgt/ERTc+UglfRkkTMb3aMROGg9ZxHhOMFelvqG
	ROP3FpgKdyAyFfpwjnmwuIF1GfzjZX58QTBM7hrWam6bpeNkG/5+35V3VnA8ZtYIutlV1p9ahWy
	tnQ9A==
X-Google-Smtp-Source: AGHT+IEarYHV4A5AvxOCETGjSWGuUOG+XoZBKhChS1CnqUYMruWNrncS7P2ua9m9JrHio5YV96s8YEul/OYU+9TpaN0=
X-Received: by 2002:a17:90b:37cd:b0:313:1769:eb49 with SMTP id
 98e67ed59e1d1-321162037c2mr18706130a91.8.1754391364067; Tue, 05 Aug 2025
 03:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com> <20250725100806.1157-6-jie.gan@oss.qualcomm.com>
In-Reply-To: <20250725100806.1157-6-jie.gan@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 5 Aug 2025 11:55:53 +0100
X-Gm-Features: Ac12FXzy9skcWLeiWYzpEUCVA6zwaFefbT-SOpZQ5EoCrDUgJmWE8FSLWcnmKIg
Message-ID: <CAJ9a7VgYTUsBn8=qtfwmkoS6Lib-8LgESLBDxXrRVqLnScLKZA@mail.gmail.com>
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
	devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
> Introduce tmc_read_ops as a wrapper, wrap read operations, for reading
> trace data from the TMC buffer.
>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-core.c  | 50 +++++++++----------
>  drivers/hwtracing/coresight/coresight-tmc.h   | 17 +++++++
>  2 files changed, 40 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 4d249af93097..f668047c5df4 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -232,17 +232,10 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
>  {
>         int ret = 0;
>
> -       switch (drvdata->config_type) {
> -       case TMC_CONFIG_TYPE_ETB:
> -       case TMC_CONFIG_TYPE_ETF:
> -               ret = tmc_read_prepare_etb(drvdata);
> -               break;
> -       case TMC_CONFIG_TYPE_ETR:
> -               ret = tmc_read_prepare_etr(drvdata);
> -               break;
> -       default:
> +       if (drvdata->read_ops)
> +               ret = drvdata->read_ops->read_prepare(drvdata);
> +       else
>                 ret = -EINVAL;
> -       }
>
>         if (!ret)
>                 dev_dbg(&drvdata->csdev->dev, "TMC read start\n");
> @@ -254,17 +247,10 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
>  {
>         int ret = 0;
>
> -       switch (drvdata->config_type) {
> -       case TMC_CONFIG_TYPE_ETB:
> -       case TMC_CONFIG_TYPE_ETF:
> -               ret = tmc_read_unprepare_etb(drvdata);
> -               break;
> -       case TMC_CONFIG_TYPE_ETR:
> -               ret = tmc_read_unprepare_etr(drvdata);
> -               break;
> -       default:
> +       if (drvdata->read_ops)
> +               ret = drvdata->read_ops->read_unprepare(drvdata);
> +       else
>                 ret = -EINVAL;
> -       }
>
>         if (!ret)
>                 dev_dbg(&drvdata->csdev->dev, "TMC read end\n");
> @@ -291,13 +277,8 @@ static int tmc_open(struct inode *inode, struct file *file)
>  static ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata, loff_t pos, size_t len,
>                                    char **bufpp)
>  {
> -       switch (drvdata->config_type) {
> -       case TMC_CONFIG_TYPE_ETB:
> -       case TMC_CONFIG_TYPE_ETF:
> -               return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
> -       case TMC_CONFIG_TYPE_ETR:
> -               return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
> -       }
> +       if (drvdata->read_ops)
> +               return drvdata->read_ops->get_trace_data(drvdata, pos, len, bufpp);
>
>         return -EINVAL;
>  }
> @@ -769,6 +750,18 @@ static void register_crash_dev_interface(struct tmc_drvdata *drvdata,
>                         "Valid crash tracedata found\n");
>  }
>
> +static const struct tmc_read_ops tmc_etb_read_ops = {
> +       .read_prepare   = tmc_read_prepare_etb,
> +       .read_unprepare = tmc_read_unprepare_etb,
> +       .get_trace_data = tmc_etb_get_sysfs_trace,
> +};
> +
> +static const struct tmc_read_ops tmc_etr_read_ops = {
> +       .read_prepare   = tmc_read_prepare_etr,
> +       .read_unprepare = tmc_read_unprepare_etr,
> +       .get_trace_data = tmc_etr_get_sysfs_trace,
> +};
> +
>  static int __tmc_probe(struct device *dev, struct resource *res)
>  {
>         int ret = 0;
> @@ -818,6 +811,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>                 desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
>                 desc.ops = &tmc_etb_cs_ops;
>                 dev_list = &etb_devs;
> +               drvdata->read_ops = &tmc_etb_read_ops;
>                 break;
>         case TMC_CONFIG_TYPE_ETR:
>                 desc.groups = coresight_etr_groups;
> @@ -831,6 +825,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>                 mutex_init(&drvdata->idr_mutex);
>                 dev_list = &etr_devs;
>                 INIT_LIST_HEAD(&drvdata->etr_buf_list);
> +               drvdata->read_ops = &tmc_etr_read_ops;
>                 break;
>         case TMC_CONFIG_TYPE_ETF:
>                 desc.groups = coresight_etf_groups;
> @@ -839,6 +834,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>                 desc.subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
>                 desc.ops = &tmc_etf_cs_ops;
>                 dev_list = &etf_devs;
> +               drvdata->read_ops = &tmc_etb_read_ops;
>                 break;
>         default:
>                 pr_err("%s: Unsupported TMC config\n", desc.name);
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 3cb8ba9f88f5..2ad8e288c94b 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -223,6 +223,8 @@ struct etr_buf_node {
>         struct list_head        node;
>  };
>
> +struct tmc_read_ops;
> +

declare the entire structure here rather than later.

>  /**
>   * struct tmc_drvdata - specifics associated to an TMC component
>   * @pclk:      APB clock if present, otherwise NULL
> @@ -259,6 +261,7 @@ struct etr_buf_node {
>   *              Used by ETR/ETF.
>   * @etr_buf_list: List that is used to manage allocated etr_buf.
>   * @reading_node: Available buffer for byte-cntr reading.
> + * @tmc_read_ops: Read operations for TMC device.
>   */
>  struct tmc_drvdata {
>         struct clk              *pclk;
> @@ -290,6 +293,20 @@ struct tmc_drvdata {
>         struct tmc_resrv_buf    crash_mdata;
>         struct list_head        etr_buf_list;
>         struct etr_buf_node     *reading_node;
> +       const struct tmc_read_ops       *read_ops;

probably should be named sysfs_read_ops to be consistent with the
perf/sysfs differentiation within the rest of the structure

> +};
> +
> +/**
> + * struct tmc_read_ops - read operations for TMC and its helper devices
> + * @read_prepare:      prepare operation.
> + * @read_unprepare:    unprepare operation.
> + * @get_trace_data:    read operation.
> + */
> +struct tmc_read_ops {
> +       int (*read_prepare)(struct tmc_drvdata *drvdata);
> +       int (*read_unprepare)(struct tmc_drvdata *drvdata);
> +       ssize_t (*get_trace_data)(struct tmc_drvdata *drvdata, loff_t pos,
> +                                 size_t len, char **bufpp);
>  };
>
>  struct etr_buf_operations {
> --
> 2.34.1
>

with the above changes:-

Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

