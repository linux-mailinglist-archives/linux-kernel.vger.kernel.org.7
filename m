Return-Path: <linux-kernel+bounces-773417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CB6B29FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAED85E2411
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633A03101C4;
	Mon, 18 Aug 2025 10:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k48YcGtx"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9133101C3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514516; cv=none; b=AVzmZn7CSHOHXFrJZ+KXocDeINbI6D+QKNeHWweTpKbTPuQJC/0si5ibkds79FOo0sYN9aRS6EbE5nDsMgGFGkubLaQCZcCg5ocW5pCpqk/lwdqPnACrEpRnD0ClHDBPTyK9/QHHFO5sB/aw5ha0w+pBhmXHfGZkB6xbQaroppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514516; c=relaxed/simple;
	bh=FJ519jWH9KWAI2H67Tholf7HmFlB87+jCNjkI7Ma76k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD1oYJVBcA9v3IKO4LAZGV7DQwpyclv1Z4Uanib3I3gTneFJuBjwczZlQLk4l2ucnTB8ZWN/q+MHek1SsarDozw1LJcpiPMGUWX/M+Ez9dO1PaZIVFAJdNDP8xadukb2G2kUX/taVmk8jgc2NIVn7dxbbEKCC+OlJf4n5cdR0Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k48YcGtx; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71d71bcab69so26395917b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514514; x=1756119314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cRZb2JpwGfgK0Dvyni/lGLUSOMBzhH0cIWS+Rzvv3Hw=;
        b=k48YcGtxlfSYR9PBWChf+LVHYtP4S/gAJLeQD4OajBYmJVId/6KgQ2x6S/zCULd3kn
         evIja1kpFM1Jc90MXRQbREk4IArIA7ueaiQLJasEFdBbHgWUCoZXgbmCA8R8XBLJAknD
         AXBI1ZxP5dCN99mlPqMc0TwBxzJ2X/l6mjGBJf0jZ0gE7gMHfe0mTlcKQ8C034cudVWf
         56osERU3gA0G2nhJczJGGQIR5SgXpyT78JC+2u39W1gxUHCOBSz7NEd0q8byFZcY100o
         IbgngaIyJAQ1O8BkFXivZrqjAatAyKSAp7SzGss0o1FdUuCEoTwshQilyi+giCJDbRgr
         te0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514514; x=1756119314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRZb2JpwGfgK0Dvyni/lGLUSOMBzhH0cIWS+Rzvv3Hw=;
        b=eFBNc5rXjE5qI8LnEz0Nj77XZu3PoDLZBi9WWcVa9D3WBHEGQPvSSJLT0AbCCxd9pu
         zU61HAEcOgUHJ/LxlSWRiPhWc5q7Pbj2hfj4p2yk99LuQ/WwRU1F7U4pXvvUeIop9Abo
         xl3JNp+ApMA+gcHMtQGtqHvJhaC1ez8nsLoHSQF4cO6JGV3Xwn0WttrU3Qi13QzmdqJR
         w8k0LLdMr8ar1vIYuvx5B+4qd9X5cwY7avQObKzbPMw2ZgzDVKNqKz30hka2HgHSxEEV
         9vm5+u3FfSR9LlFJGOndGwhlXAIklPV+bX+h7B2zvOPRveKvvV6DcpGOpMNNRcFnetUB
         JQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCU3FUH2qaNmD56L6/4eKsn1TzAxdz2daBW3WgSEDqeX8bxYTVT0IduZBvpO2qSxlG1vrOX3GZZNVvhX2CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqUpVxr7FVM9wXNgFhkLBgn3ZGwE3nJ7xxlud3F0NOQLOqSWfu
	/Kkz+l0TEOHOfyedZHCy95XWFezrLbopjN7ERljjlgLDJedey8lcUpo+jX/ZIbJBfnJ4kxl3rfB
	+Tj1Zp3+dgTrlaBgu2tWhUsfB/EuGO7j5Y5u8nqKeUg==
X-Gm-Gg: ASbGncthI2FCClx+ds4iKinR3yYfSSVA4s8VX0QiLeUn8Dgc9jzbCmWRaH7oXO7MBGs
	8mpw8PFG9aWx+tdg4FYoHZxfwC1pOD8YEVylx+GqsBb2PA8dl7qiedyC/l/PjhBoP2mmUBGOyuQ
	cGlXirkzMeTmilg/gBOurfttfX5DrXvCWe9fXDIZ2HgKNJGl8D4r160bNCGJhNttJB/7j8XUBWI
	FzOhdkj
X-Google-Smtp-Source: AGHT+IESjdzn9W2JnsSauD18554Pkmz/p+/H6LoVzd2oHmARAOOT0+bzfJ7oITTTCicEmYqOeZmBCi19VjziTAWluD4=
X-Received: by 2002:a05:690c:4b8b:b0:71c:1e93:272d with SMTP id
 00721157ae682-71e77506f84mr94612597b3.31.1755514514246; Mon, 18 Aug 2025
 03:55:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731094116.2163061-1-colin.i.king@gmail.com>
In-Reply-To: <20250731094116.2163061-1-colin.i.king@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:54:38 +0200
X-Gm-Features: Ac12FXwmA01YCEQ2jCJwvBR_wmGb3MGLVpLbRcdACzXEkQ4qTCrGPjPh1dPBI50
Message-ID: <CAPDyKFrPhVezQprofCFyP5nbytyBCWsmxAu-ZbO_Bbx+d5aXrA@mail.gmail.com>
Subject: Re: [PATCH][next] mmc: davinci: Remove space before newline
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-mmc@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 11:41, Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a extraneous space before a newline in a dev_err message.
> Remove the space.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/davinci_mmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c691f1b60395..2a3c8058b0fb 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -588,7 +588,7 @@ static void mmc_davinci_request(struct mmc_host *mmc, struct mmc_request *req)
>                 cpu_relax();
>         }
>         if (mmcst1 & MMCST1_BUSY) {
> -               dev_err(mmc_dev(host->mmc), "still BUSY? bad ... \n");
> +               dev_err(mmc_dev(host->mmc), "still BUSY? bad ...\n");
>                 req->cmd->error = -ETIMEDOUT;
>                 mmc_request_done(mmc, req);
>                 return;
> --
> 2.50.0
>

