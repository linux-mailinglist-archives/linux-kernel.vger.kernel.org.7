Return-Path: <linux-kernel+bounces-814133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B065B54FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78468188C259
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B230EF96;
	Fri, 12 Sep 2025 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sY3wGmzz"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604330C62B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684119; cv=none; b=QS9gtbmtfZwGClEmU9oVGrR7puitO5SH/kNe9p0nOQ/l2H9yvfUU/K5tSZa5ezel+UWJfEBYrJjkJBtxCnHaCNZiZyt37jaoNBAZGGaOSIs5Nh4S1rnAL35/Hv6NENk4uIhxzm5heALk5t8Ukj4OGcALvrA4xvh+xB+95rkwc2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684119; c=relaxed/simple;
	bh=PttHOtNSt54YmkHpxLOxewRDuYl5ElnQt5nSiLj/+UQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liQxzMYPYP2Nb4HzJhcNbzq0d4317MAzpDx7A10cb10wZ3pBsOEjKdhI3+HT4wWVpNVEfoKFEG2UG/Fm+SPlnAS49BGVecrzch0na1sJ1qensjw/8OwPpdLVfkbqU9GPLPSt+/nnnxF5qf+8xSYYHXBGjZfD99cTDHoj/DpO860=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sY3wGmzz; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-ea3e0b4a98aso385066276.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757684116; x=1758288916; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=STW83QuqpPn8naDxab/PdZOErOUZSmZlWHjvyy+1Bc8=;
        b=sY3wGmzzXJ3Wy37ghSS7gCJIq5Tg79SexBUJMEzolfguCgPr+Dt47t+qsomrpLFTmM
         XrFLxd7ZM+kuBR/wNcMmR4hq7qhsMz001QtQFe5ZQoDzpLVX9Ix1dmY3+Bmvc4Uo0sh3
         iwpqhEaS4KOX2cMRAWtoUe5GNgH2i7BvOupOClnnfhM9yQfKq1TlvB/JeC3BEBPLJ5go
         zi0x+3cCsjJ4VuCYCqWES1/J7EVz0+XMW+EIe+0Qcw64LQHopa5AqZmeG+vklHrvLhN8
         YR7bhrJY0mJs/SfhpmWX9+rcw5XTU3ZuYvH0a900csxx6iWtgx6Zfhnryo+ztco+4mph
         SS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757684116; x=1758288916;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STW83QuqpPn8naDxab/PdZOErOUZSmZlWHjvyy+1Bc8=;
        b=IFEMD2rqqK22lQRbzimQ/Ia5w/OV08bqr/7wJVBzpS01NmIHeEpH1a9UblcFW6qaLw
         zDMddzsAkWY5HqLnBbjwYhWX0B9YymNy8fxoHEsjNXm7inv5WrYQyEzQXcln6V0s0Kou
         DS64S8n4oalTBqVPGhpXMCBAkFCNwEdNxbslWk2keewNn6Ip8DC0WKCaBlpR/CFbckzE
         Dl3v9qSQoJsFbBP7Gb1ZRjoECjF5tuLPnqzwgwjcAyRq7xLYRZDP8xZ8cFAGer9SSmAe
         0nYoVeLS/bcMbsIe8yMtXuFMz75DHTBTXjTJFJk7mfC4xHWwpLgp9UTW8pz18/O6D1PR
         cTIA==
X-Forwarded-Encrypted: i=1; AJvYcCW2OCHM8WjJWBEZ+yFZa/3thJ/5rB0KCkGnXaYc31rzHIuYKKlE0MX/xXZq+WbjGUhIveZdaW6ztv3BFJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNO08aM3elvrKbL9Gr6C0UWyfYxtWSUeWupY0kLUcdhHLub2nE
	ybu/MjeT+kreeLXFlZbLupBaQSJQuhRI5UZIgmUnqDeE1duPqnfD1lW3Uoz2sQ4wg0LL5uzRt3N
	f4i16c9oNqrBP3uATmH4V/quoZYc7VDgGMaOPfQIVLg==
X-Gm-Gg: ASbGncuvtiZcraKDEQRloVTT3dSJGK0hv7IkR/PtJTdjOLDLrDLC+oKH0OkTCm/88Ge
	K7V8RklLmVbmYtGC3gIdo55Pkbgj812ucu0FFeG/QEcJMHs+LmsHDyV4ZJhSzbpqxFQqMHaAux1
	H1Ixx+OSIHCLgvCwqMhnvdrlST0I3IIbyDOucmI8CjpCYWItLLXEjC2rxBPS/zjcY3bmROIsPvA
	aT5mhun
X-Google-Smtp-Source: AGHT+IFo+2s4Q86nT2eqhVliAZu16Xq60jFBF+35ttgMF2c4G40bikUsQYD5P2gDHZOjV2sSsnsF8GATwLaYyZPlNu8=
X-Received: by 2002:a53:c485:0:b0:61c:3356:6287 with SMTP id
 956f58d0204a3-6271e75703emr2053628d50.6.1757684115808; Fri, 12 Sep 2025
 06:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
In-Reply-To: <736d7edd2d361f2a8fc01b112802f7c4dd68b7d6.1757557996.git.benchuanggli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Sep 2025 15:34:38 +0200
X-Gm-Features: AS18NWDa8oAmyLB5iGs8tfqz2bWfk_t3a_iJsG9ghkszoFvcQ-b_7YQWIwr5bdU
Message-ID: <CAPDyKFqGWRRii3z-Q3zz2+=48J7BjqdK8ab5qU75x5W==0yBYA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: sdhci: Move the code related to setting the
 clock from sdhci_set_ios_common() into sdhci_set_ios()
To: Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	SeanHY.Chen@genesyslogic.com.tw, victorshihgli@gmail.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Sept 2025 at 04:40, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The sdhci_set_clock() is called in sdhci_set_ios_common() and
> __sdhci_uhs2_set_ios(). According to Section 3.13.2 "Card Interface
> Detection Sequence" of the SD Host Controller Standard Specification
> Version 7.00, the SD clock is supplied after power is supplied, so we only
> need one in __sdhci_uhs2_set_ios(). Let's move the code related to setting
> the clock from sdhci_set_ios_common() into sdhci_set_ios() and modify
> the parameters passed to sdhci_set_clock() in __sdhci_uhs2_set_ios().
>
> Fixes: 10c8298a052b ("mmc: sdhci-uhs2: add set_ios()")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>

The series applied for fixes, thanks!

Kind regards
Uffe


> ---
> v3:
>  * use ios->clock instead of host->clock as the parameter of
>     sdhci_set_clcok() in __sdhci_uhs2_set_ios().
>  * set ios->clock to host->clock after calling sdhci_set_clock() in
>    __sdhci_uhs2_set_ios().
>
> v2: add this patch
> v1: None
> ---
>  drivers/mmc/host/sdhci-uhs2.c |  3 ++-
>  drivers/mmc/host/sdhci.c      | 34 +++++++++++++++++-----------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 0efeb9d0c376..18fb6ee5b96a 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -295,7 +295,8 @@ static void __sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>         else
>                 sdhci_uhs2_set_power(host, ios->power_mode, ios->vdd);
>
> -       sdhci_set_clock(host, host->clock);
> +       sdhci_set_clock(host, ios->clock);
> +       host->clock = ios->clock;
>  }
>
>  static int sdhci_uhs2_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3a17821efa5c..ac7e11f37af7 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2367,23 +2367,6 @@ void sdhci_set_ios_common(struct mmc_host *mmc, struct mmc_ios *ios)
>                 (ios->power_mode == MMC_POWER_UP) &&
>                 !(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN))
>                 sdhci_enable_preset_value(host, false);
> -
> -       if (!ios->clock || ios->clock != host->clock) {
> -               host->ops->set_clock(host, ios->clock);
> -               host->clock = ios->clock;
> -
> -               if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
> -                   host->clock) {
> -                       host->timeout_clk = mmc->actual_clock ?
> -                                               mmc->actual_clock / 1000 :
> -                                               host->clock / 1000;
> -                       mmc->max_busy_timeout =
> -                               host->ops->get_max_timeout_count ?
> -                               host->ops->get_max_timeout_count(host) :
> -                               1 << 27;
> -                       mmc->max_busy_timeout /= host->timeout_clk;
> -               }
> -       }
>  }
>  EXPORT_SYMBOL_GPL(sdhci_set_ios_common);
>
> @@ -2410,6 +2393,23 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         sdhci_set_ios_common(mmc, ios);
>
> +       if (!ios->clock || ios->clock != host->clock) {
> +               host->ops->set_clock(host, ios->clock);
> +               host->clock = ios->clock;
> +
> +               if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
> +                   host->clock) {
> +                       host->timeout_clk = mmc->actual_clock ?
> +                                               mmc->actual_clock / 1000 :
> +                                               host->clock / 1000;
> +                       mmc->max_busy_timeout =
> +                               host->ops->get_max_timeout_count ?
> +                               host->ops->get_max_timeout_count(host) :
> +                               1 << 27;
> +                       mmc->max_busy_timeout /= host->timeout_clk;
> +               }
> +       }
> +
>         if (host->ops->set_power)
>                 host->ops->set_power(host, ios->power_mode, ios->vdd);
>         else
> --
> 2.51.0
>

