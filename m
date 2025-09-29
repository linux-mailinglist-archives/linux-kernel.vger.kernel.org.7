Return-Path: <linux-kernel+bounces-836314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455E5BA949C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428143B0389
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C230596E;
	Mon, 29 Sep 2025 13:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yS81tLhj"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25693054E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759151435; cv=none; b=K0Lv7MMxKcZ/Ydm6srWpYGnd98u5DGeT61DUIxJHC64gq6jzrs6hMbeJJFq6SA8ASvYKijvFs6705iOIgYg01B9MPPSPilMauBbt29FDN/6uoK3boJJKDzA7e+SyFFBgFnkcKKpqIwmfi/OPzIEdXkR+zgMVRRLYNdHaf+l3pU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759151435; c=relaxed/simple;
	bh=zldeIVGYldYbmC65e0hKwaIJnCH6totj0tsfM+V6c/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFuYSA5DaECvgQeW/NJLiq0APllZLwY+2lOiyhvO4Air2d8Ksqf4o6rDaFeShe1wB0OFRCbAb1gNm+xFrcecWtA1EZKB9adq8C2g+XoG/yDnlhKRIhfnyvbVcoEo0tCGGncd1p+vj3mRzRCC2Sco4jGILBGvpjPMnJPMsFtPjpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yS81tLhj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d603cebd9so58643887b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759151431; x=1759756231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TIgtSwakb4S2F49hv2ah0ceDD3kdcrnl68lJO2bz2SI=;
        b=yS81tLhjbLcGbCee8oU5M9P+U1Bnh3ct0b3Dv+9XHlnPLYmGz7JmWx/994FyywBWMj
         69XwkS4+Es4DvYiv082f6PKdNXMAOveZfQS8+BhYX+kmywfaF7hAkSAy3jGSB0E5RG1A
         NzAPNsS1YEprfJf7xncf49UBJBLz+r1j5KiFkobzukxsqq59gaViYC3IuQRUXf45egO7
         q/VRDvSV1kC3DgnoyKSNYCE+lzt2IVCgb8eIMOGIMTVNe06k73RXC0yoM9VDXdV02eXw
         RHHu7TXeSC/Yu09HYHX4a48VyuEjvYJTSJCqgnyuqk+0/MnpC2JLZJGVisBjtLaeQwxR
         kysQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759151431; x=1759756231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TIgtSwakb4S2F49hv2ah0ceDD3kdcrnl68lJO2bz2SI=;
        b=YL6c2AQlE0jUYkP16zYCxsb7aiZjIKbh6nnVX2Rl/DlQVfwwaiH1r2cRfCoygHN+zV
         kvA6xHL6vAvoO9tCneX7fyqeTosczRwW68dIarEeKZI1FhvmPXQ1YydoDDVmdXRxO9Ya
         ZMjbHpAdxe3E8MhLI1k6U7loSbbTEFNM+VrBqvhvATISxtLcXchUgv/HAnJUXiWyE+6I
         m5p6t6J/HAsgFOD9XRCJ57hbBEib8nKq6F5MzL/IZ1xyKOOJbuhqC9IfbjFmPuwpT17m
         MMBILprDuvR5tuhTWWqgNCghVnsSam+rIG0b6JK+yoHM8GqIYew0jWgfncL98k0yryUZ
         BjJg==
X-Forwarded-Encrypted: i=1; AJvYcCUHuxg8BsoGSSWj5e5200Ji/89/wykGGQN4lryK+SnE+H7gPLaAVu4bMT2azDu7LWcnOxKxIIVgZ2PkGLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW8cWg1OmJz7al7SCebqk7fBkqZtMqTB0NdqNfBIPeISrgGEJm
	T6VnavEPYqAEFDQKxBVXMKLIgiffTMuCE+eDK9uE+Y0oRtRuG9ktD/bavhc03cnbK+m6scVWjOR
	P7DN3msTIEhdAC89XgqFe0ANxOm2ZAbZtgk+cr6h9oQ==
X-Gm-Gg: ASbGncvmHYw9AhS06pIg9MkB67hPehXncRsX+SOTB1reDesUpQsLSy7mmb3bT9FubXt
	87wKQLRQACKhP5zAssjbhZftUSWsKbAfmXPjSrsMXXMb9byH8WK3MZzjrKENAnGbqBFeCvp9l3Z
	Mznli/UZ+2lCGzZFPgfqyY8y/13QI9EXXpy4HRucs+3JgjzSiuS2aS7CkwFLCgwiC7ousZADAGE
	0IYx8KpJcRXlJj/PX4=
X-Google-Smtp-Source: AGHT+IEaqhle1COgySgMHCGl7/RAGDslrMpVmtc/WxzU5IvlxnhajJDxwCn8WYXyXNTN50BLyVZqReaPXPJrWYY1F9w=
X-Received: by 2002:a05:690e:154c:20b0:639:2794:3416 with SMTP id
 956f58d0204a3-639279436b2mr3662726d50.19.1759151431542; Mon, 29 Sep 2025
 06:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-imx_rproc_v3-v3-0-4c0ec279cc5f@nxp.com> <20250926-imx_rproc_v3-v3-1-4c0ec279cc5f@nxp.com>
In-Reply-To: <20250926-imx_rproc_v3-v3-1-4c0ec279cc5f@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 29 Sep 2025 15:09:55 +0200
X-Gm-Features: AS18NWBrMVxKi_O1xz826dCqJxNTtrsBYTk49Oo4lKT0mm4rt1UcT29ebmOL9cg
Message-ID: <CAPDyKFqsDjn2+6XxY=Dkv9qZ6weTaeChwsSHvnHFnFzbYQ9bUg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] remoteproc: imx_rproc: Fix runtime PM cleanup and
 improve remove path
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Hiago De Franco <hiago.franco@toradex.com>, Frank Li <Frank.Li@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, linux-remoteproc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 14:33, Peng Fan <peng.fan@nxp.com> wrote:
>
> Proper cleanup should be done when rproc_add() fails by invoking both
> pm_runtime_disable() and pm_runtime_put_noidle() to avoid leaving the
> device in an inconsistent power state.
>
> Fix it by adding pm_runtime_put_noidle() and pm_runtime_disable()
> in the error path.
>
> Also Update the remove() callback to use pm_runtime_put_noidle() instead of
> pm_runtime_put(), to clearly indicate that only need to restore the usage
> count.
>
> Fixes: a876a3aacc43 ("remoteproc: imx_rproc: detect and attach to pre-booted remote cores")
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Hiago De Franco <hiago.franco@toradex.com>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  drivers/remoteproc/imx_rproc.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index bb25221a4a8987ff427d68e2a5535f0e156b0097..8424e6ea5569b9ba6b07525643ce795faaeb2898 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -1136,11 +1136,16 @@ static int imx_rproc_probe(struct platform_device *pdev)
>         ret = rproc_add(rproc);
>         if (ret) {
>                 dev_err(dev, "rproc_add failed\n");
> -               goto err_put_clk;
> +               goto err_put_pm;
>         }
>
>         return 0;
>
> +err_put_pm:
> +       if (dcfg->method == IMX_RPROC_SCU_API) {
> +               pm_runtime_disable(dev);
> +               pm_runtime_put_noidle(dev);
> +       }
>  err_put_clk:
>         clk_disable_unprepare(priv->clk);
>  err_put_scu:
> @@ -1160,7 +1165,7 @@ static void imx_rproc_remove(struct platform_device *pdev)
>
>         if (priv->dcfg->method == IMX_RPROC_SCU_API) {
>                 pm_runtime_disable(priv->dev);
> -               pm_runtime_put(priv->dev);
> +               pm_runtime_put_noidle(priv->dev);
>         }
>         clk_disable_unprepare(priv->clk);
>         rproc_del(rproc);
>
> --
> 2.37.1
>

