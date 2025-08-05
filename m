Return-Path: <linux-kernel+bounces-756244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2D4B1B1C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EA47AC98F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A7C26C3A0;
	Tue,  5 Aug 2025 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Syr7Re/Y"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D197F269CE6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754388927; cv=none; b=FFYGH8srMd2udHiFpkowmeX+ToBRXX3inkU9GXaqVqVKcpxx2b5wZIuvc1EUgGPoGe3Tm4SV7YJZrC3hHBUJ6M6LCQBZqxHVAJFSsYtY7PtjBrqifM3kelsmg9RJEhb0UmbK11xd3CDyNhTGb92wrKR1YjgiJNQUnWZqdGKN1+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754388927; c=relaxed/simple;
	bh=qS5CvNi/TU2MCEo48xS65HI1PZQRvgnJ+LOTlZEISMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHTzTsnM6O+F9nzfw/oFFxCzeu77Q+kEquaKQtzX70ZzDEejwZHrTyYu7Dl/zIkSigFSO+S31tZz1LIqpw8bgS0y5HzdJ2NdTy7aezDsjxdHDXBQu3v3fSila6cfchrgykTFRZFqUtkeFgvxow2fnTbRUcW0jHBXS/uxqMYS4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Syr7Re/Y; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6153a19dddfso8348935a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 03:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754388924; x=1754993724; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ar0NLemVcS8Q0eL1gYpaDXHf8V6Ud9JA+Ifa04irXg=;
        b=Syr7Re/Y21mT+fieDnD0ZHZTNTO2chrEUQ/ulq2LLd3U2huniISkiBVJEoroQbKtPq
         8z4hA0fOJPM6Wyc50SwEtWLOwRocOAER/2DPlJTu0cLugC90j6IRt08iVQTxR9Cughdn
         h9PBl2duSeXxIiyuu8hfMtnSd15qsdqTGjS1FKPk9Z6SSh8/0HQA/kHtFQjaLeOCzzP4
         rP0Y3WjMm325q5herw2SYkDmXuxV7jA5ruiN5C/WtTzjy2n9KOvslue/vWzcRiknfvQs
         AY6psezAHe3VdWHUt2XtWaIFS7ViKAXjsv5DK4Evq1800lkROtVVJWS2x7q0viq9d1yy
         yb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754388924; x=1754993724;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Ar0NLemVcS8Q0eL1gYpaDXHf8V6Ud9JA+Ifa04irXg=;
        b=Gpl+1UTJIiAXTuRQ7CrsFDOv7QN61n06wIBaEhPfGM9Ulbmv5Xv1c2GRxbTwAkbyYf
         1oTVCxutd9fznr1NgX3lGk98YfmhgyBcYaFgU035PEE/iQKzbIg2dIBiReXDGy3KJwV1
         Pz477n2XRSPVT+TL8HhXfGzAqBS1HX3eo/a7HXRA0izxeb3AsqmPpdFPPC9CbdBrRYyb
         n2Qn8lYOL8DnsMA9juadUHIVWREMm1X7wOx7KvGe0Wv9ThSBxb3Q8Wbzxtr5Hrc0rYFu
         Z1BHOGecSSUkTOy4hbDJK5IDqK3bCF8gAkwTA0uUtlXWRjcIr4DQeyHCCdLXwUsPCsyy
         XckA==
X-Forwarded-Encrypted: i=1; AJvYcCUW+j60feg9EYv+4fZ/wpKOrfG29R9Rk2GYUPl7yeEgTJ9XfRT5it4HKD/dfJgoFDzvMb7KphWZ2FKc7gw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBb0t2g/Z3zxgUYsKftyU+GaIn1u7EeZdN9VPVatqtAc20gLXO
	HkYU38K6XqjCLcaruYjac/4YUQI8QQ9g//oZYWLuZo8xfpZWp3Zzbxp3KOf1L04+cyS6VU70LJX
	+CkUWnvK2SIWfVvexle8iHzKfrsMyMSjgGPmjPAp2iQ==
X-Gm-Gg: ASbGncvneNfI0rJ8xwH6iahlCAJpKXvrt1+jtYn1XUIi8YBLAHr0d/aAonYCOM9JQR6
	6akLh0AtQsc1uClDlcnCvybsm8F+sD74kxWfXbKKXYfcixQXBX7lISB5DVCQrdffwMsus8klnii
	oQ4/2A+7noAuNq8mMrZEyfE6MFk5AP/eUEtU09k6Bfqta01H9u1n2WN2/QudER6SZ8MwFwzlwtz
	2qUzQ==
X-Google-Smtp-Source: AGHT+IHJC0OEe85WEW+uZTa05xouWEVU5GyBHg1A8HxJHnuylCsAviNXR5p7OpzyynSGKKmz7seq3XWzPEvfHkexNis=
X-Received: by 2002:a17:907:9408:b0:ae3:f903:e41 with SMTP id
 a640c23a62f3a-af9402574b3mr1323967366b.54.1754388923827; Tue, 05 Aug 2025
 03:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com> <20250725100806.1157-4-jie.gan@oss.qualcomm.com>
In-Reply-To: <20250725100806.1157-4-jie.gan@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 5 Aug 2025 11:15:10 +0100
X-Gm-Features: Ac12FXxr456QPb-g62XeDYWEW4C_Du37eJm8f_7Mmf5ggFk2nh7e_omeT6qcdRU
Message-ID: <CAJ9a7VijwFKiaZzKsSKPynWapA3ik9d7JLeE+yVNFB0T62iH-Q@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] coresight: tmc: add etr_buf_list to store
 allocated etr_buf
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
> Add a list to store allocated etr_buf.
>
> The byte-cntr functionality requires two etr_buf to receive trace data.
> The active etr_buf collects the trace data from source device, while the
> byte-cntr reading function accesses the deactivated etr_buf after is
> has been filled and synced, transferring data to the userspace.
>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  .../hwtracing/coresight/coresight-tmc-core.c  |  1 +
>  drivers/hwtracing/coresight/coresight-tmc.h   | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index be964656be93..4d249af93097 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -830,6 +830,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
>                 idr_init(&drvdata->idr);
>                 mutex_init(&drvdata->idr_mutex);
>                 dev_list = &etr_devs;
> +               INIT_LIST_HEAD(&drvdata->etr_buf_list);
>                 break;
>         case TMC_CONFIG_TYPE_ETF:
>                 desc.groups = coresight_etf_groups;
> diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
> index 6541a27a018e..52ee5f8efe8c 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc.h
> +++ b/drivers/hwtracing/coresight/coresight-tmc.h
> @@ -208,6 +208,21 @@ struct tmc_resrv_buf {
>         s64             len;
>  };
>
> +/**
> + * @sysfs_buf: Allocated sysfs_buf.
> + * @is_free:   Indicates whether the buffer is free to choose.
> + * @reading:   Indicates whether the buffer is reading.
> + * @pos:       Position of the buffer.
> + * @node:      Node in etr_buf_list.
> + */
> +struct etr_buf_node {
> +       struct etr_buf          *sysfs_buf;
> +       bool                    is_free;
> +       bool                    reading;
> +       loff_t                  pos;
> +       struct list_head        node;
> +};
> +
>  /**
>   * struct tmc_drvdata - specifics associated to an TMC component
>   * @pclk:      APB clock if present, otherwise NULL
> @@ -242,6 +257,8 @@ struct tmc_resrv_buf {
>   *             (after crash) by default.
>   * @crash_mdata: Reserved memory for storing tmc crash metadata.
>   *              Used by ETR/ETF.
> + * @etr_buf_list: List that is used to manage allocated etr_buf.
> + * @reading_node: Available buffer for byte-cntr reading.
>   */
>  struct tmc_drvdata {
>         struct clk              *pclk;
> @@ -271,6 +288,8 @@ struct tmc_drvdata {
>         struct etr_buf          *perf_buf;
>         struct tmc_resrv_buf    resrv_buf;
>         struct tmc_resrv_buf    crash_mdata;
> +       struct list_head        etr_buf_list;
> +       struct etr_buf_node     *reading_node;

Potential simplification:-
do you need both reading_node here and reading in the etr_buf_node?
reading_node handles the logic for which buffer is being read, while
is_free handles the empty/full logic - reading seems unneeded?

>  };
>
>  struct etr_buf_operations {
> --
> 2.34.1
>

regards

Mike

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

