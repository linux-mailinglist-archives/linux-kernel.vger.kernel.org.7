Return-Path: <linux-kernel+bounces-861522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF5BBF2F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93F3F4E5354
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 18:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053B1DE4E0;
	Mon, 20 Oct 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae/21XYz"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15801A262A
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 18:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760985141; cv=none; b=RorvvSF/cjbUD+di0JxMEqpFI6aweKjPePPPL+pR2fTnU6Y3kFomGjcH7y+CeBLwFAXcXPME8Pfa2IuDAZggZvgjXm1f1QHND2j0rAE63zjzFqfnnXs2GQ5C15KBxWrxBTd5q85o8pA5tQpMPPWlERD+CbvfVQn+ASmSYzeoi7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760985141; c=relaxed/simple;
	bh=VkqneVDbsyT0IzlYqd3SDo8bA2HKS26W3MsXwZnzK6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ljHB6cbedOfomYZyVuKr6ljWWoAdzUYYj+7kda7pMyGlodwb47fjQ16aXFvtXr/T4l/gASRo3S9XHQcf0w25SD37hJL3OhxAH/9w7n7MKmMSNfVR9FdF0y1X6EE4yyFEFHeVp3cQcF/Aii6qolOOUzvD5Llq7Fs9Q97dm9ENdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae/21XYz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781001e3846so4335461b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760985139; x=1761589939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kThRqoFCTjPJKmH3oIqpB9iPzfqXX/RIxNab4q9zYLg=;
        b=Ae/21XYzGGnVTsrb5xrVuMfidWBTP30immWqmqDFJ0BZFBOYiM9zU7xBZnjhwR5gVF
         MelWxu546oTMWpDgkq5pz8GhN1omVTqOXvkey1W3B77Qdy0nRUf9rhpe3z53G3Dz0c4Z
         vBPMtafY2wp3w4aUX5vYE0CIk+MJcxig6s6Ds5vWTFTJJ/6/IwSlFxV6TuzVOsJra/Rj
         SyV516jM566OC1H33y/jYesfP2bxG2cekaL0bpNqcJmWFMiCC3Xxg4Rfz/5os2EyxVhM
         e+ja8dF02xFE6JP87g3lGlaX5riL+FJDGMw7tyY2xbKXfhRCtBkkFoeLud3oYwHxqUb4
         gYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760985139; x=1761589939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kThRqoFCTjPJKmH3oIqpB9iPzfqXX/RIxNab4q9zYLg=;
        b=Zmj/303X1ukaBDlxpkTNft/JBYKR3xTLIcH69qisY5TQhy+KQyccVhbgh+sQeFC1Tr
         g1at/ozlBoUS2m0/BNr3YMzZypLjOqq5aTd52aOjvNrzOsyo9kP+CCw0rFfKAD6eoKYJ
         R6A+x/ZY0jivlzWmk6jPI52buefwe4vhoqj3Lae1jcIR71xkxwpqbZSjfYcePlDD0HaT
         NKwdk2Ca3H/THqX1dalPHMR4K1dTSAF0TVtSk8EYZwzMEI0gSot5Mu46gEOfBjcsOj4V
         Zo4xMcsPRRgnJgMxtAQvNEQp8CynK9edULcvLdYND3NoIy7MNqoKRfV2dxAjpiMNcKrH
         +Y6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhjSRws2tFIP6hcNJkjYin/aTS0Wp9mHIiOxPnHlvHPi2/FuipRVOsLE0TOqtpRj15RwPeL9FvPWwETGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/anr8lwtYo6U/2Npcn8/4TR4ePPrMvN5SkrfoXGS1qNT+FFG
	32IxZoDvmNCJP/SppHkE1cPIvKoD+iGrtONwZp0kFkIe/F2b5evovfUZ
X-Gm-Gg: ASbGncuwZQBzfxBxKxwu0oZerDzhTjG1DR2ZyOy0CIBHTJPfcnpaUe9qQzznLtngfjW
	j+VrLKS9ub1tVYMVB0Z7W21c5/hN/y/ZfjvN28iO1y3/DIf9Rgneek81yBByFL5tbUrBszXDuuM
	Tq+7z0/hQMKkBw4eIoC/mITRy2oLx4Pcn5ZBkZkjENgB5UxHAOMVjLv1hGRpwKQitQq2vepypV9
	Mve2j11vO9Z+GaLa846yWZ8wRUdW7APEkBgQKxYDMwCAjHeaC/7LbUYCYliHxeLl/xMsgDhrLUR
	SogR749IPS6iQfpkxojBRyOxhote1FuRbSDxBURpqkFyRixIHNva2Ry4n8kyzIRG5K38Wk4wrNP
	cgsVwrjqYU+9mK3kWXUs5lcagqCoxs07l9QjtK1X2Zc5ONxKdXGTVnvsIZ8rh56Oi2DhHo8tl+3
	Mk3fSvsQ==
X-Google-Smtp-Source: AGHT+IFHpDDSC/ec/z6gP3yDF0Lq0IAw+hvtA6O/sngS65F0b6ioDK/6RnHMjz5+qa4OG9b5X3ZwEQ==
X-Received: by 2002:a17:903:b10:b0:280:fe18:847b with SMTP id d9443c01a7336-290caf85191mr169484515ad.33.1760985138937;
        Mon, 20 Oct 2025 11:32:18 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:3002:6efb:47d0:40b1:d5b:bf65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fd9e8sm86645795ad.85.2025.10.20.11.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 11:32:18 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Tue, 21 Oct 2025 00:02:07 +0530
Message-ID: <20251020183209.11040-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: o55ujlbvxwezsf3ogqx33pcbg5b2lviy6bv5ufnz6t7yi4v23t@i6uiafh6no6c 
References: <o55ujlbvxwezsf3ogqx33pcbg5b2lviy6bv5ufnz6t7yi4v23t@i6uiafh6no6c>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 16 Oct 2025 at 14:20, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
>
> On Wed, Oct 15, 2025 at 12:16:57AM +0530, Rakuram Eswaran wrote:
> > This patch refactors pxamci_probe() to use devm-managed resource
> > allocation (e.g. devm_dma_request_chan()) and dev_err_probe() for
> > improved readability and automatic cleanup on probe failure.
> >
> > This eliminates redundant NULL assignments and manual release logic.
> >
> > This issue was originally reported by Smatch:
> > drivers/mmc/host/pxamci.c:709 pxamci_probe() warn: passing zero to 'PTR_ERR'
> >
> > The warning occurred because a pointer was set to NULL before using
> > PTR_ERR(), leading to PTR_ERR(0) and an incorrect 0 return value.
> > This refactor eliminates that condition while improving overall
> > error handling robustness.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> > Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
> > ---
> >
> > Changes since v1:
> > Following Uwe Kleine-König’s suggestion:
> > - Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
> >   channel allocation devm-managed and avoid manual release paths.
> > - Used dev_err_probe() for improved error reporting and consistent
> >   probe failure handling.
> > - Removed redundant NULL assignments and obsolete goto-based cleanup logic.
> > - Updated commit message to better describe the intent of the change.
> >
> > Testing note:
> > I do not have access to appropriate hardware for runtime testing.
> > Any help verifying on actual hardware would be appreciated.
> >
> > Build and Analysis:
> > This patch was compiled against the configuration file reported by
> > 0day CI in the above link (config: s390-randconfig-r071-20251004) using
> > `s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`.
> >
> > Static analysis was performed with Smatch to ensure the reported warning
> > no longer reproduces after applying this fix.
> >
> > Command used for verification:
> >   ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- \
> >   ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c
> >
> >  drivers/mmc/host/pxamci.c | 57 +++++++++++++++------------------------
> >  1 file changed, 21 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> > index 26d03352af63..d03388f64934 100644
> > --- a/drivers/mmc/host/pxamci.c
> > +++ b/drivers/mmc/host/pxamci.c
> > @@ -652,11 +652,14 @@ static int pxamci_probe(struct platform_device *pdev)
> >       host->clkrt = CLKRT_OFF;
> > 
> >       host->clk = devm_clk_get(dev, NULL);
> > -     if (IS_ERR(host->clk)) {
> > -             host->clk = NULL;
> > -             return PTR_ERR(host->clk);
> > -     }
> > +     if (IS_ERR(host->clk))
> > +             return dev_err_probe(dev, PTR_ERR(host->clk),
> > +                                  "Failed to acquire clock\n");
> >
> > +     /*
> > +      * Note that the return value of clk_get_rate() is only valid
> > +      * if the clock is enabled.
> > +      */
>
> The intention of this comment in my WIP suggestion was to point out
> another thing to fix as the precondition for calling clk_get_rate()
> isn't asserted. If you don't want to address this (which is fine),
> drop the comment (or improve my wording to make it more obvious that
> there is something to fix).
>

Hi Uwe,

Sorry for the delayed reply as I was in vacation. 

Ah, got it — I’ll drop the clk_get_rate() comment since it was only a reminder
from your WIP suggestion.

Just to confirm, are you referring to adding a call to clk_prepare_enable()
before clk_get_rate()? I can move the clk_get_rate() call after
clk_prepare_enable(), or drop the comment entirely.

If my understanding is correct, I’ll keep v3 focused on the current set of
fixes and handle the clk_get_rate() precondition (by moving it after
clk_prepare_enable()) in a follow-up patch. That should keep the scope of each
change clean and review-friendly.

> > -out:
> > -     if (host->dma_chan_rx)
> > -             dma_release_channel(host->dma_chan_rx);
> > -     if (host->dma_chan_tx)
> > -             dma_release_channel(host->dma_chan_tx);
>
> I was lazy in my prototype patch and didn't drop the calls to
> dma_release_channel() in pxamci_remove(). For a proper patch this is
> required though.
>
> To continue the quest: Now that I looked at pxamci_remove(): `mmc` is
> always non-NULL, so the respective check can be dropped.
>

Understood. Since pxamci_remove() is only called after successful allocation
and initialization in probe(), mmc will always be a valid pointer. I’ll drop
the if (mmc) check in v3 as it can never be NULL in normal operation, and
remove the dma_release_channel() calls as well.

I’ve prepared a preview of the v3 patch incorporating your previous comments.
Before sending it out formally, I wanted to share it with you to confirm that
the updates look good — especially the cleanup changes in pxamci_remove() and
the dropped clk_get_rate() comment.

static void pxamci_remove(struct platform_device *pdev)
{
	struct mmc_host *mmc = platform_get_drvdata(pdev);
	struct pxamci_host *host = mmc_priv(mmc);

	mmc_remove_host(mmc);

	if (host->pdata && host->pdata->exit)
		host->pdata->exit(&pdev->dev, mmc);

	pxamci_stop_clock(host);
	writel(TXFIFO_WR_REQ|RXFIFO_RD_REQ|CLK_IS_OFF|STOP_CMD|
			END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
			host->base + MMC_I_MASK);

	dmaengine_terminate_all(host->dma_chan_rx);
	dmaengine_terminate_all(host->dma_chan_tx);
}

Please let me know if anything still needs adjustment before v3.

Best Regards,
Rakuram

