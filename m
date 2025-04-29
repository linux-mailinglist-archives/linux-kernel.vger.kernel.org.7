Return-Path: <linux-kernel+bounces-624818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA29AA0816
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 12:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 957031B64B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Apr 2025 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4002BEC2B;
	Tue, 29 Apr 2025 10:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVod8pq8"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6EA2BF3EA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921229; cv=none; b=SuplPkwmAGy763kP+xOflBBrrYgvI9aJuY2mh0T8hGyL8zgKdG3yFYeybNau9oUq4KWcV5IzuaXK6Xbf8Z4CJ2u3HFfthCU6n6Y1x9BQog+fi+bQwJKaFSJL3aSvwpAcD+veJjYOKeZ0uSr19PkAHzvNGoD5b54OIUJDtJ9tQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921229; c=relaxed/simple;
	bh=g1tVxbnLGk3i5P6Pxoj8Qjo6872iN8ITjCbgI2W21Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nnsrWundi+kALLqklEEqvYk8QciYebJ/k8dG3qgnuH//O2P++VHt6YczP2ijqvK2DWrESmazBwV3h3urnCRDiYgLU5lk528GVqls+VxopEGIjPnTSaMlR80uhWaASTGMqlSgojNdKKYD+4KDndQa1xViZLDfbcKCSuQBaXZ96ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vVod8pq8; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70427fb838cso47566587b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Apr 2025 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745921227; x=1746526027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=emtwuLYFhq/+dXPJNX/QT8Hgt+pr1K3s+G1bwQ8o3u0=;
        b=vVod8pq8yoTc4wRQ69nfOjuZRgRLkxnYuLitHdLrdyp+BHWUVuzsh08veAufytzWmm
         1vBq2hxdPjNcHkQGNx2YUWrEH8AaeSqWtoozELJ2Iu0LVC2mh/MAr9qj/gP6m6quNqQk
         ilIj1S8TcVxs6422qjARIzFlUDGvx9rpmF0NtwH5q8WxXmBq6VazeNAhvZ3xGtsCwBmC
         dvZvDsVnfv/33Wivv36hjJTIj1JijaBjm1KW+6MnoemrcvEuwu9eaIZLDcpJ/jZ9wbJh
         yqMnlN6Ki5Z7vUcdrcN06PEkRYawYpaGsM9lqe/5hmxsbelP7fBef8+i6JoZnI7ulJxn
         qeaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745921227; x=1746526027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=emtwuLYFhq/+dXPJNX/QT8Hgt+pr1K3s+G1bwQ8o3u0=;
        b=oobeJuZzKMy92u5HgDnHx4bCpoW0iZCoGmjN2I+5DpLtzQQquy5GpdUGsHBCeR+1tG
         8esIy4svAbrAQBghxAVnydmfAeKhVWLacX1qSD/a9G8Ky/wAjpcCEk7PBaQfgeJXG+3s
         wivSo2uSbpa0rv0OqLh++BkZm/Z/X0U9R5ouknDUu6A55Zxn5yn4VkYM0d0kipzSzZFn
         nZqSokEm9YXJYTg1/DW3xmihupO+bGWH+3hAZ0ZBLJk7r5vU07kR/cGxY5eb0ZnvspGx
         WqaR+2RZcmP8uhvftIkKEj9D1C93LZZOTAsyMKKLfeTbT+qLekWXBBl2X8f0C2xvvBLE
         4HtQ==
X-Gm-Message-State: AOJu0YyTcTndiyHKSFg3ltIvsGW/X3jhl4nFTWy7srN5Tz0ZWBQSU5fc
	g5uxM8Cf+xUiw1tVEYQlC6laBVXek9QUPcxWlH2NJ+lZ/rEaGzh1dihDKMWIIbsxh8n5G2380WR
	ENtUp1fdd9ashpHRZH5HeicvfjmbZ9pLs93yYJQ==
X-Gm-Gg: ASbGnctIRi5Kd1AE1G92AuStid9RcrJzWo/1RJz4FUE4oCafLsAdTUjblA89fn0SYqA
	2xRgYJvyPFuvo14E9ntkle08dwT5/3FAXXwN20IBxNTCX307ENx+MwCADutpTkhVsiQP/bLxzon
	bTfx0/ix3+44FSB3GVuWXUrlk=
X-Google-Smtp-Source: AGHT+IE+KQ5mhqCdAicmf7a28zsguJznUEdy53WKuiHnYymLVfd0/ONr455swN8mCtn+15YDbEpXrpy4cOjvjDDAfZo=
X-Received: by 2002:a05:690c:a90:b0:6fd:33a5:59a with SMTP id
 00721157ae682-7089af99460mr31745177b3.18.1745921226784; Tue, 29 Apr 2025
 03:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424034610.441532-1-rdunlap@infradead.org>
In-Reply-To: <20250424034610.441532-1-rdunlap@infradead.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Apr 2025 12:06:30 +0200
X-Gm-Features: ATxdqUGe1f7BXwgk8BKhjbgMOwlPjLa7A1c1xzU9Uqd9tqasf9-fMmdsvIXz7aE
Message-ID: <CAPDyKFr3EN+Ss5qaFmQ1+42=t_cZ55PtggXMq8uVHPkYQy-uyw@mail.gmail.com>
Subject: Re: [PATCH -next] mmc: sdhci-esdhc-imx: fix defined but not used warnings
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Luke Wang <ziniu.wang_1@nxp.com>, 
	linux-mmc@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev, 
	s32@nxp.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Apr 2025 at 05:46, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix warnings when CONFIG_PM=y and CONFIG_PM_SLEEP is not set by
> surrounding the 2 functions with #ifdef CONFIG_PM_SLEEP.
>
> drivers/mmc/host/sdhci-esdhc-imx.c:1659:13: warning: 'sdhc_esdhc_tuning_restore' defined but not used [-Wunused-function]
>  1659 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
> drivers/mmc/host/sdhci-esdhc-imx.c:1637:13: warning: 'sdhc_esdhc_tuning_save' defined but not used [-Wunused-function]
>  1637 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
>
> Fixes: 3d1eea493894 ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Luke Wang <ziniu.wang_1@nxp.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: Haibo Chen <haibo.chen@nxp.com>
> Cc: imx@lists.linux.dev
> Cc: s32@nxp.com

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> --- linux-next-20250423.orig/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ linux-next-20250423/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1634,6 +1634,7 @@ static void sdhci_esdhc_imx_hwinit(struc
>         }
>  }
>
> +#ifdef CONFIG_PM_SLEEP
>  static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -1688,6 +1689,7 @@ static void sdhc_esdhc_tuning_restore(st
>                        host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>         }
>  }
> +#endif
>
>  static void esdhc_cqe_enable(struct mmc_host *mmc)
>  {

