Return-Path: <linux-kernel+bounces-849670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD0BD09F4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A2A74E883F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 18:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147852EF665;
	Sun, 12 Oct 2025 18:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX4m8CBx"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B8B1F03C5
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294297; cv=none; b=as3d2WMj+u9qU+If1dOaLvVf+J0E31b/wAHhctHUiKLLuwCWTA4JUWJ5ZIZUHL1topIgDoSXOreAccoxKef5NYBhHpF/HiXkgA2KlKFLek8LHnCBnuKMswxIW2ZNZ9vnVN4RpUqlgPedRcCZYpjnCwM8KQvy/V6LVuxSwmFaGkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294297; c=relaxed/simple;
	bh=uQUkzfZR4PJiFUZmTs3kpHMobAqAZ8tDwNcgCtPeYDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGlcSOXBmpKSqCJnNPojoZVEcmzHzFMue9EhBd2pgFVAtJ6bUIhkFj7dsgqk/IVg1X27r6C3zCUQOWggQ5k4dEEJoZm0gopuHmiFfvMFJaAHf+zwjfJqivEnde43+GoHyMrXgUjR/mfGBEAT0BZeEimdSoKbwiav2Cj7Kn0TZQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX4m8CBx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-793021f348fso3121468b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760294294; x=1760899094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdM5hdZmStu6wP/lPTHT68dpyLc/oyOsPR/mfyzBd4E=;
        b=hX4m8CBxcRwbwdrFsawvvRn9lfkltGNw5Y53K1+vTEklk8AcKbwnkt1V14YJviy4Ps
         ULETSycL2VlzKuL8cxa9ZEWljaTRNJJeW4zEzwGonK0EgUAc1FgaTLk/3XFpgYgEWExm
         jWhezLQ+JH0IH/wOR5G2YGBOGYdX77aqBO8heSYxCmV4bQYImRiJDmN3wrLaVewAmmVK
         OgSoa6Yjga8GqRgLnLIdi7f7fM1fDJvECqVVHmkHCxEj3uySBl4ouktArHmjYtaCFKCr
         Qtnt2uSCZpcXBkZvafncCBH3HgyWVKeuc3KKveR19HiWnXrQVtvelOkub5PYZMy6Mwio
         tLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760294294; x=1760899094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdM5hdZmStu6wP/lPTHT68dpyLc/oyOsPR/mfyzBd4E=;
        b=w0tLEaB7g4IcWaTShizyEtpVTK0DIezw6KZhWZfxuqGVQPk5RzPRye4YLvr3bJQQgT
         jf5dxiGsM9PknclfFucrYs/f0cgLiQ4G3lSy+CtGWZTqi810zd69uMPi/+tciE9OxHTg
         jjdl/FPWc/9NDJr2Z81ADUhYjtqjS5sSPbTwmE3WO5KB/qCATSruOyCA4cfZC67KARnl
         1iEwsfBvEmmbW+DMGiAW66gQ9TXLAFeVCLqbl/Ja4fpL+82RSSr+xPZog6qNvVNxTApm
         /sywy+Kz4a8MOuuS9oid4Q6+5thBepOJVsVJZCH9s2WjcSyfaZ2Xo3xiLAqVQFQjWjB/
         1L3w==
X-Forwarded-Encrypted: i=1; AJvYcCWC4PLrNAx93zmGlnk0v2879R2KYQybomTbh/qMbw0+ifqWbBZFZ7RAAq+Jl+fo5VYtpf2zqN6+ZXOzuQE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWT/UQy5pgyhoZk1N5POzXMmC8OFrTE2C89n6DQnI+vEmt/iWh
	0JS4rCd45e1gKEZz6KmNX0cn5y8OJzaHAhOoKy0lxPTchuV5c/TWm1tj
X-Gm-Gg: ASbGncuA0ylFxEHoFjzgJkMM9zXc50Xn4DBSy2ikU78Wiks0SXMuKsOFN3db8OMbS1Q
	Iv4yRpwMRn6kb57cd+ks4HVStKWuF15ysi0r9vn4lPXV7MJKDxewYEKsn5JFVQVoRiO2TzMk/zX
	bepr8DBaOGIhIA4XEJmyesUnxLv9RC0WoKbia2oxlmE8U3TBhELCbUcNgdSU2vgsCVw82x80rw3
	dJN+4s1aP8F6NWqVE4JFhr6cNM+FRmmBUh74C90pBFEk4fzIzX5F20bgDHQB9fDe7tvwrTAtx2i
	NFoQfmHq26wx6tEgW9c9WKrNeXwrSZRsDbLSalMBmcULzeCoiCtUXr81Wg6KCRrK7QzGtYZULmW
	MSoFgYtMP+7s1GeJBsr7q8M4VfhyCh4QQDNNlhO6Y0au3aFyI
X-Google-Smtp-Source: AGHT+IGD4qq0d7J+6TgXoMmi4zHj5Ov0A4tbqkUnz7sBexTic8piA6fopsWY2ndvOzIISYPoIaFSqw==
X-Received: by 2002:a05:6a00:3d52:b0:781:1a9f:aee7 with SMTP id d2e1a72fcca58-79385709970mr22178082b3a.2.1760294294103;
        Sun, 12 Oct 2025 11:38:14 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:310f:1e2f:de73:6871:5bf8:3f34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm8982904b3a.59.2025.10.12.11.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:38:13 -0700 (PDT)
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
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in pxamci_probe() 
Date: Mon, 13 Oct 2025 00:07:52 +0530
Message-ID: <20251012183804.15171-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm
References: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

> >
> > I do not see the need for this code change. "if (host->dma_chan_tx)" will
> > skip "dma_release_channel(host->dma_chan_tx)" since dma_chan_tx is already
> > NULL. This code change does not add anything.
>
> Yes, stand alone this change doesn't make sense, but if we want to drop
>
>         host->dma_chan_tx = NULL
>
> in the error path above, this change is needed. Maybe then even
>
>         if (host->dma_chan_rx)
>
> and
>
>         if (host->dma_chan_rx)
>
> can be dropped.

Hello Uwe, 

I had one quick follow-up before sending v2.

Regarding the devm_clk_get() error path —
you mentioned that setting host->clk = NULL; is redundant since host is 
devm-managed and the function returns immediately afterward.

> I am not sure that sounds right. Looking at the code for
> __devm_clk_get(), if devres_alloc() fails, it returns -ENOMEM. If any of
> the other steps after a successful devres_alloc() fail, code goes
> through possibly clk_put() if needed and then devres_free(). So the
> resources are already freed at this point before the return to
> pxamci_probe(). The only thing left to do is to set host->clk to NULL
> since it would be set to an error pointer at this point.

Khalid pointed out that when __devm_clk_get() fails after allocating a 
devres entry, the internal cleanup (clk_put() + devres_free()) ensures 
resources are released, but host->clk would still hold an ERR_PTR() 
value at that point.

His suggestion was that setting it to NULL might be a harmless defensive 
step to avoid any accidental later dereference.

For now, I have dropped the redundant NULL assignment from 
host->dma_chan_rx = NULL and directly returning the ERR_PTR instead of 
storing in a return variable. 

Below I have appended proposed changes for v2.

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..eb46a4861dbe 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -653,8 +653,9 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(host->clk)) {
+		ret = PTR_ERR(host->clk);
 		host->clk = NULL;
-		return PTR_ERR(host->clk);
+		return ret;
 	}
 
 	host->clkrate = clk_get_rate(host->clk);
@@ -705,7 +706,6 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->dma_chan_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(host->dma_chan_rx)) {
-		host->dma_chan_rx = NULL;
 		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
 				     "unable to request rx dma channel\n");
 	}

Would you prefer that I:

1. Remove the host->clk = NULL; assignment for consistency (as you initially 
suggested), or

2. Keep it in v2 for defensive clarity, as Khalid reasoned?

I just wanted to confirm your preference before resending, to keep v2 aligned.

Thanks again for your time and detailed feedback!

Best regards,
Rakuram

