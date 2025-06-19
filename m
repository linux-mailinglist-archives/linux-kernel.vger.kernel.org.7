Return-Path: <linux-kernel+bounces-693775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD9AE035E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 13:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A2FD4A18B9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA35A22A4F4;
	Thu, 19 Jun 2025 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vRE9x3R+"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94125227B94
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332046; cv=none; b=PYeWUCdFR5ejZw5EvattcxPUJ9o6PWB6Wnd6/1ZAdS/FjHgU43SpIUkI66pZftwUWUaA56PdmwATOtA+o58NrJhinHW5vAGpU2a6aKYg7VZZJtxN8sj08OPow1Ry93v24ANiRP7EMxVHCE+DGdE7EHoLOi6IcDoHEeG4E103YWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332046; c=relaxed/simple;
	bh=pytXLFdnJ1BhbNkSJdYUV6GaM6i+LGpFiP/9N23VDdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z36qBqJIIwWZ82KDYN+UPA4O5vP+tXJ4Wt1GYqEcFwlccF0+3EHPPkspvSPysMsFmgO/sUTRmPLZvxPxIfrM9r3jUfdh+R7NaJMuI0TYyNRLedgeQjCdXIdl9WTM5Fb5wNvIZpaoiqdPxd1+PnmjwnETczJFP+gOkC4l/FSut80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vRE9x3R+; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e81f311a86fso663328276.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332043; x=1750936843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=niIEC24pa2jxdKXkefJ3vkZfAtNqJpvIieuArrIyjOQ=;
        b=vRE9x3R+B147RO+ySAP4qnaE77VTrYq2I+EzieyZAek4dCffhiptE+l6qbguqGI5Mq
         dYKJeWXpAKUp8qGdwu0xm8+LojLtRV9zDgoUm8Qwuhr1Q5l8Tok8QAbCTQ63WAAhG0C3
         pOOG7lOHa7C1fO9yUFHimfbi/quhihRL+uppwBttlFHS4DpK9xioNGjojj3Kd6bG335/
         46GaaXP6YttJ9gMAE+nG9UotDYPvkB8YxR35lOQAV/gMxZXQPIUqz65MqwWVFaNie1ol
         a7VAY6A1tXEuU9B/rtBavjAc687cBDjotUTdWBBRlcxN206l5985SEM9enufSpPWi9dC
         AJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332043; x=1750936843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niIEC24pa2jxdKXkefJ3vkZfAtNqJpvIieuArrIyjOQ=;
        b=ZsylU5kz78NZ0zttqogMK6kNEOoc6yxto8nucqG5SzvqysMSPjRRbs0iZhUrZAjSAb
         2SBiPuKgaq8yhd+vfAkBEhlFUQTbAa7WWvzkEiGSKurJhe+gKFdMt94aVGbIwSio8NiX
         9ODydCiIAPXxtlaPpGDVR6/mEOJUVVX7+r4Dw2EXNUM9TWLbcy0gdqqWhOxjIL0R8Yg/
         TFbgyDW3Rh5UJ463Rh0itkH2sZB2IkUjTJEMKnPlD76f9xNBNt10qnsGe8DwgtH0wILz
         e6Xa9U4nD8ryhXevlv2Y+axgCyl+0pVlYcAhTbIFGjNW7VepSr5eHyS4kqwwrLCFM9jg
         tW1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAW9kE+ZsQF/k0kI32kwb2geoXnIBWQAcjJti/Mt/9Ikcd0k8Yk0BpZH8k8dvx0PSYJ+nn3cN5WzkREww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkfwAgsBxjegXujQ4bjZ0gE5cfkDK4nEnLk0GkYMdqkddEmemm
	+oDar+R3c2en19eVlTx+j2zihF7P4V3GbVF4SyxaDe4RGVOblH7HKPu5AHEXTp7htcdPLAT3TlZ
	b9g1OJN+5GFdzhBPoSvIB8OZ9HyTohoZaalANUJqzGw==
X-Gm-Gg: ASbGncsUDCecQvw7Na5f42sUGBTGwLYsFFqvcWN30uoEBbtVphpRHoV4ne7YY4Hp2a+
	YY+h2dRB/E7eSoKn39pNfj6q+mQpQ9JxxR8CW6LJh7ZBTEP3lGtGkxsDRSx6ZQjoIarbbpAkpHk
	tHQkGqxuS1r+k1KGf3ynLx5TN8rwM36BUpKsSeXlZFf5Dq
X-Google-Smtp-Source: AGHT+IF2iE0ox/gzxKHz5bI8Q+Pkgb8UWe4OY/z3MjCCMZXinEnzR7Rqk/xTiCIm/KwZ4rpmEsnSRUYX7m4o4AQKZbE=
X-Received: by 2002:a05:6902:cc6:b0:e81:7e16:aad7 with SMTP id
 3f1490d57ef6-e822ac7a461mr27597842276.24.1750332043584; Thu, 19 Jun 2025
 04:20:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:20:07 +0200
X-Gm-Features: AX0GCFvXjxV2EcT_wfBSHPu57s1TY2VkiQlHaijGThkd0p21SEv0wZoDeoPKInc
Message-ID: <CAPDyKFpCPLCxp54yjBAaLz2tJK6Ouk-ikpvs9uby7aXnic=U7Q@mail.gmail.com>
Subject: Re: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tomasz Figa <tfiga@chromium.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 13:26, Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> If msdc_prepare_data() fails to map the DMA region, the request is
> not prepared for data receiving, but msdc_start_data() proceeds
> the DMA with previous setting.
> Since this will lead a memory corruption, we have to stop the
> request operation soon after the msdc_prepare_data() fails to
> prepare it.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Applied to fixes and by adding a fixes/stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 3594010bc229..56b4999fe58f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -834,6 +834,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
>         }
>  }
>
> +static bool msdc_data_prepared(struct mmc_data *data)
> +{
> +       return data->host_cookie & MSDC_PREPARE_FLAG;
> +}
> +
>  static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
>  {
>         if (data->host_cookie & MSDC_ASYNC_FLAG)
> @@ -1466,8 +1471,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         WARN_ON(!host->hsq_en && host->mrq);
>         host->mrq = mrq;
>
> -       if (mrq->data)
> +       if (mrq->data) {
>                 msdc_prepare_data(host, mrq->data);
> +               if (!msdc_data_prepared(mrq->data)) {
> +                       /*
> +                        * Failed to prepare DMA area, fail fast before
> +                        * starting any commands.
> +                        */
> +                       mrq->cmd->error = -ENOSPC;
> +                       mmc_request_done(mmc_from_priv(host), mrq);
> +                       return;
> +               }
> +       }
>
>         /* if SBC is required, we have HW option and SW option.
>          * if HW option is enabled, and SBC does not have "special" flags,
>

