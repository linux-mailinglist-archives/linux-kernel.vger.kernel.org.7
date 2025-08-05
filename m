Return-Path: <linux-kernel+bounces-756232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2829B1B187
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E39917FE27
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 09:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54726A0B9;
	Tue,  5 Aug 2025 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ytGhHdJG"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D52D1AA782
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754387717; cv=none; b=BEvis2l8okzoeEx9oF9fvWt7ItabQdK49OW/wngNaAKrjrBxbzbhKD0LamBoD4A3ZXYmzVHm31ija0PEpk4fyXOz8tMSksSWLyW4ak4EZUybgcXm53BuRovbnSNSxDYWsHYEGzok/J0P6RQHAg9ps1Qa67JG6dWCfZL2WxNoBkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754387717; c=relaxed/simple;
	bh=uliqi/KpsDFbM1Htu6H91P/fxhKIHcy/qcSFcOl74+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FOs6O2aFbvZCCPCRzFhwTmnDXbnyANHR7MRslzGSQF2YlaKQ4QioBOso/GpC1vBI974A4sPAF1y/ZtC2Eje1TU1aoMY5rHbz2z2Be6SnPce7On0yvtv4nrk4kgsNp1h5FpFF3Dc6SkCjvSrFhnqrDjpuLcqtOp14dW9USrQwkyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ytGhHdJG; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bd050184bso6104193b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 02:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754387715; x=1754992515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CQUJ+NctrS5XnN4MvLnb/JYO8sbKwmo81SB44CL6l5A=;
        b=ytGhHdJGnzLFYyxYZRdUIdtPQAe/d3HLdQe8znawhlwxne16eaDH6HHD51roxg5UKB
         gGWK8mWHK6h0SMwRsaU9phiN6crx+SAuoHt6qkya6f3Hsw56gWwucuFvxG+Nem+B5SGY
         exj7o/ZULFIIo47F/hFkge2ATTqZlFrZ1ffATk2b6VE0BAOvVhJohIjBFhstKYqlzJyR
         qm+rb/BhxNCC86Rb9Z+CJ5sxj/FtUUj0WgYhQ47wlp84kKGNzj44ONmbOPdh4/NVKmVn
         HYrRPGc0lI+D9+syo2rLsLBB5IfEFATXuO754tONPgsuP1G/8xSuek5CVbeOwk0qD//6
         FFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754387715; x=1754992515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQUJ+NctrS5XnN4MvLnb/JYO8sbKwmo81SB44CL6l5A=;
        b=QIqzTJtFXG3W9EMbWip0avqTwx4X5Y0q4RuT+5b5bpN0cD7OajVgR533HLdXzN8fCQ
         jSNWP/j/sL8O/Bvq8e2KoBTFsMZJvDdFugpm5FUFvXq+fjBaQR4y4k1h0/dDOl41nJ18
         KIRuDUmsfYSNzn1LuPaQUvbzUc5uDgwGJnfyDKfjvD3GbLYsDWXH/6HVB0lyRTpffzHB
         LwshxJmAB5M4d7FtWM2f97GXm+fMp2GWJrFAKzB+VMsg8wiWImnW6FT1r2PUN4UobH4S
         r38Uk/1B2LuOhg8dYXEOW3iN+0USFA6qofvNzPvJy7j6h5uRRjuDlyLnx9Lq/O4s56Yf
         DoZw==
X-Forwarded-Encrypted: i=1; AJvYcCW0i8w5C7usQmjjNwX4aNIaysmgtEFskx0zWIAENH7t6VVlKnWOsopg8uq3mHyMpW5H5il6kGjBijA2Oz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHYYCA3ZxFiae7CYJ8dMNZvyymlH3rO2rYhiFeRBuIYDaFX2Eh
	RBC1ucW6t4gMteIft85ggZCTjlGoMj9w64288k2qjXFRU0S4rFRlJDszf26H2IBiLVmvxnCNiNJ
	qi6v7lmXgvuGyJtxVmvdgMlUP32e8AjUAYh+WVT6R7g==
X-Gm-Gg: ASbGncsAL7RfFzn8wFOcug4C6WBBNYyvDviCPAA3Lz1P0uVXXsRRw/JCVK+u3CzQq3/
	2WYNCuQbA7fMRKKzooEkpmwXSTj18GZjMD/oU2si/Y2LBzrhlduTIJvOXxI08rIVHQmNl1/NMH2
	iVK+5DQaTGpBa7lf5Qz/4F5euykABfDdk+6C/Y2XtHeyjKmj/RMnLkhzdxy+N0IHl3DGBZScmhg
	AQxYw==
X-Google-Smtp-Source: AGHT+IHfcD82/iX99lJflKhjf/q/ameBxbpugvuC2ABURfKeJyVve0DWx3ORf+DO9750X+uIrgMuC05+de0uLf7bNMM=
X-Received: by 2002:a05:6a00:2188:b0:748:e585:3c42 with SMTP id
 d2e1a72fcca58-76bec48fab6mr13243864b3a.15.1754387714705; Tue, 05 Aug 2025
 02:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com> <20250725100806.1157-2-jie.gan@oss.qualcomm.com>
In-Reply-To: <20250725100806.1157-2-jie.gan@oss.qualcomm.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Tue, 5 Aug 2025 10:55:04 +0100
X-Gm-Features: Ac12FXyp4ZO5j-vKmsroGEkmGSaZdhjZTYW6dd1otj-TM37lG1iabpz7_60enUM
Message-ID: <CAJ9a7VhSMf43_GPhVf=He1S2J_Tn4XLi5cOadbCn+K0St+gdfg@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] coresight: core: Refactoring ctcu_get_active_port
 and make it generic
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

On Fri, 25 Jul 2025 at 11:08, Jie Gan <jie.gan@oss.qualcomm.com> wrote:
>
> Remove ctcu_get_active_port from CTCU module and add it to the core
> framework.
>
> The port number is crucial for the CTCU device to identify which ETR
> it serves. With the port number we can correctly get required parameters
> of the CTCU device in TMC module.
>
> Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
> ---
>  drivers/hwtracing/coresight/coresight-core.c  | 24 +++++++++++++++++++
>  .../hwtracing/coresight/coresight-ctcu-core.c | 19 +--------------
>  drivers/hwtracing/coresight/coresight-priv.h  |  2 ++
>  3 files changed, 27 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 1accd7cbd54b..042c4fa39e55 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -580,6 +580,30 @@ struct coresight_device *coresight_get_sink(struct coresight_path *path)
>  }
>  EXPORT_SYMBOL_GPL(coresight_get_sink);
>
> +/**
> + * coresight_get_in_port_dest: get the in-port number of the dest device
> + * that is connected to the src device.
> + *
> + * @src: csdev of the source device.
> + * @dest: csdev of the destination device.
> + *
> + * Return: port number upon success or -EINVAL for fail.
> + */
> +int coresight_get_in_port_dest(struct coresight_device *src,
> +                              struct coresight_device *dest)
> +{
> +       struct coresight_platform_data *pdata = dest->pdata;
> +       int i;
> +
> +       for (i = 0; i < pdata->nr_inconns; ++i) {
> +               if (pdata->in_conns[i]->src_dev == src)
> +                       return pdata->in_conns[i]->dest_port;
> +       }
> +
> +       return -EINVAL;
> +}
> +EXPORT_SYMBOL_GPL(coresight_get_in_port_dest);
> +
>  u32 coresight_get_sink_id(struct coresight_device *csdev)
>  {
>         if (!csdev->ea)
> diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> index c6bafc96db96..3bdedf041390 100644
> --- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
> +++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
> @@ -118,23 +118,6 @@ static int __ctcu_set_etr_traceid(struct coresight_device *csdev, u8 traceid, in
>         return 0;
>  }
>
> -/*
> - * Searching the sink device from helper's view in case there are multiple helper devices
> - * connected to the sink device.
> - */
> -static int ctcu_get_active_port(struct coresight_device *sink, struct coresight_device *helper)
> -{
> -       struct coresight_platform_data *pdata = helper->pdata;
> -       int i;
> -
> -       for (i = 0; i < pdata->nr_inconns; ++i) {
> -               if (pdata->in_conns[i]->src_dev == sink)
> -                       return pdata->in_conns[i]->dest_port;
> -       }
> -
> -       return -EINVAL;
> -}
> -
>  static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight_path *path,
>                                 bool enable)
>  {
> @@ -147,7 +130,7 @@ static int ctcu_set_etr_traceid(struct coresight_device *csdev, struct coresight
>                 return -EINVAL;
>         }
>
> -       port_num = ctcu_get_active_port(sink, csdev);
> +       port_num = coresight_get_in_port_dest(sink, csdev);
>         if (port_num < 0)
>                 return -EINVAL;
>
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 33e22b1ba043..e51b22b8ebde 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -156,6 +156,8 @@ void coresight_remove_links(struct coresight_device *orig,
>  u32 coresight_get_sink_id(struct coresight_device *csdev);
>  void coresight_path_assign_trace_id(struct coresight_path *path,
>                                    enum cs_mode mode);
> +int coresight_get_in_port_dest(struct coresight_device *src,
> +                              struct coresight_device *dest);
>
>  #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM3X)
>  int etm_readl_cp14(u32 off, unsigned int *val);
> --
> 2.34.1
>

Reviewed by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

