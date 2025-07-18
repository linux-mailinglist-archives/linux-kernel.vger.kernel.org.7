Return-Path: <linux-kernel+bounces-736886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25716B0A4A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F3927B9083
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD46F2DAFDB;
	Fri, 18 Jul 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLmTt+7g"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709372949F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 12:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843557; cv=none; b=oogOnFIKX2gWiPOziBswkftLttyld+E1oHULd6dIe0dBVEw7+vZgv7Ec8P+/ACMYYM6SIi1XBI5YlLR5dS3TXMT0uSR5EdGXSj2B47NzqZxxqmWyVoVz5OoU+7Kf05F1IGSRc2wIY5RaAAoKWY7HCbUiZU0JtZZ9q3Naw9Js98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843557; c=relaxed/simple;
	bh=oU9JFIpnW9IiwP/zLLrdn3UtCIAWt6eXdWUgszQQbz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UG7YbTkXw5eq80WpV95FeI/Be/SkH2ecO0NB7Vefa87qz9uQ5qjKUnSMnhH7WFP5LhjFyULuBtdev6f+L4GMEx2Qk7zzPPgeYcTU1D6CBlHF6tUbcAOE3ehB3gaLoghWs+TTmD2iflQsK3uZSSQ1HhZ7zIosOM6XPz7hanzlLx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JLmTt+7g; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1479376b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 05:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752843555; x=1753448355; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PYpcavPW85ROVk3E1axG+f3muOD/wyEeug4NFZEIWg8=;
        b=JLmTt+7gCJpleS4ivc4h024LObg32opRMy26LFXe26hl3fMoiPHJCc74Ai7EJv7kGt
         csXdNVH2EXZEpV/XR5D3rb3AKllyulCywgF2ifdCEZwQ0cE+m+GFROjQjIUzqsIzMDQL
         rOvB1LsN5/FwZW0JVYMsIySdmQievYyWwCT3WKe2RLmnRVUQH9KMHerj1G/b+wbnUd0x
         D5re06Dt3H+ajHWIqwZIA+aAaztsJbe12HFLC20oBPt8puVpyjPQY6OviP978ZtpX8/q
         tuYUDjHvKfW9Nnt3g9t6T8J9xWtlSKT7zeNlyDzQdA9yANNLPFecrRQA1AIfJMcyJwSl
         6Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843555; x=1753448355;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYpcavPW85ROVk3E1axG+f3muOD/wyEeug4NFZEIWg8=;
        b=fYP5gPUzDRd4n4QIGs5dFfJmI5Nj15rNsGXi83shVIcVM0q/zrKAit71WuB64PzwKD
         luvZOJJPpdAqEwyv8aKEsW+LIhHHOnlOV/4suHhMGTZylI4JbNgLMsqMRRpt1elr6oZH
         rDVu08lmoe5F3RP1j3IMjsaEx6KIa91kEjEYEESV0G1LKoj6K1vpVAHi5RSdgaNwM5Wx
         gzxIsksNKuxS/K8ikkoH/Y1wIntCudugEOeld8kU+46spRTvms2H5IZdMVOCkcGPOcYF
         OURIqdl9ukpL4qyOI83qNUCevj7nfoMN0AYR9E5DbSYWHBhfBhzFk2pBymdLZPdlaVPy
         iGrw==
X-Forwarded-Encrypted: i=1; AJvYcCWeYr84irmGjW8jh+dm5BYF+l9MN2jjeA1izBP6qN/hUdU8X8936hOUZIDUcm1R5tIxOyZQKXBU8x0r09U=@vger.kernel.org
X-Gm-Message-State: AOJu0YztyVFGL7LRvYzfNs/fEskZ6VdaMasVsLSlBTc+eIZDQjSpiyqG
	m4MJaDU+TIcSVZDMWv4yooVt0y14RpKAs6Z6aiyzRigta8I+N7HFE3aWNQeKMJ9psRGzZLATg6B
	c8UL9VHAk2adXikiY5/FajJr02NCrF7ucGw/qG12R+A==
X-Gm-Gg: ASbGncvFnSO2QgKdmlkGpf/GwT9s7DJLAU7+D2fUfhcIIHCdp2D5BA1vPa/4sVq0mmr
	8OsWNr+y9INMU33gCtjLlSf+VpoIWJxHy5c1GV1zkCMbwX2Av012+rTLi0rOrYl7R3wiWG7snIr
	CA4/Cg/Nfkn6c6yL/F7QCp7SSMbgRPvUQU7cWiTL9ZjGI4I2+sKDrV3VjzqAKdlSUWrLOWALL2l
	t71Y4F3+CLhKsvbR8o=
X-Google-Smtp-Source: AGHT+IHDAc74U25eHKTb9aulfz0KG+bpqSbOJrJeexu2ZAbE44hVvJk6HDFdKtlGLhZcV0OjSUhQj942abhhql0IydM=
X-Received: by 2002:a05:6a00:bd84:b0:748:f74f:6d27 with SMTP id
 d2e1a72fcca58-75725480a1bmr16226717b3a.24.1752843554551; Fri, 18 Jul 2025
 05:59:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718094848.587-1-alireza.sanaee@huawei.com> <20250718094848.587-6-alireza.sanaee@huawei.com>
In-Reply-To: <20250718094848.587-6-alireza.sanaee@huawei.com>
From: Mike Leach <mike.leach@linaro.org>
Date: Fri, 18 Jul 2025 13:59:03 +0100
X-Gm-Features: Ac12FXxq5RyQqwd6GSdHy6cONAY5fWKaaHEWBZ5tvug2yoehd6FJ-cPiMbA37wc
Message-ID: <CAJ9a7VjdF0a_5gswt5j+LX9_pxK40ODNpYiYUSmYfsWZYA+Wjg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] coresight: Use of_cpu_phandle_to_id for grabbing
 CPU ID
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jonathan.cameron@huawei.com, coresight@lists.linaro.org, 
	dianders@chromium.org, james.clark@linaro.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linuxarm@huawei.com, mark.rutland@arm.com, robh@kernel.org, 
	ruanjinjie@huawei.com, saravanak@google.com, 
	shameerali.kolothum.thodi@huawei.com, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 10:51, Alireza Sanaee <alireza.sanaee@huawei.com> wrote:
>
> Use the newly created API (of_cpu_phandle_to_id) to grab CPU ID.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 0db64c5f4995..95d46ea08936 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -167,20 +167,7 @@ of_coresight_get_output_ports_node(const struct device_node *node)
>
>  static int of_coresight_get_cpu(struct device *dev)
>  {
> -       int cpu;
> -       struct device_node *dn;
> -
> -       if (!dev->of_node)
> -               return -ENODEV;
> -
> -       dn = of_parse_phandle(dev->of_node, "cpu", 0);
> -       if (!dn)
> -               return -ENODEV;
> -
> -       cpu = of_cpu_node_to_id(dn);
> -       of_node_put(dn);
> -
> -       return cpu;
> +       return of_cpu_phandle_to_id(dev->of_node, NULL, 0);
>  }
>
>  /*
> --
> 2.43.0
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>

--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK

