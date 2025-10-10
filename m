Return-Path: <linux-kernel+bounces-848851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B72EFBCEB17
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 00:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5EB424E333D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 22:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5942765ED;
	Fri, 10 Oct 2025 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bbt45kRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8123A9BD;
	Fri, 10 Oct 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760135417; cv=none; b=kdn1TJd7qE4elDqgqo1V8zQ2419MW9zuQxrqmUEZ1VJ8r//htYHOaR4U+VH3tl6Vi1UtfHeRwXO5SkgUhf8ZW7epQ4BvlpPZV15TwTraYIBYhOSwyIcp9EgkAja/jDGzH+H9dcCusVUc/uIwgnICEkJxXaWyOlo7faHRr6vmqUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760135417; c=relaxed/simple;
	bh=v1njVSr69cHMTMzNsArVH5NqJS79UIgSmB0tW7QwGM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUt4lrzW5xyrr3j1pJasaPFJpimLYG7+ycZ06B8j/pry3ejD5h2JbYDsYzda2QLy3jRDR4+aFDI+xSrToNHrrcvZCIwogi4FdT0NX/uaorYkf/D+caPHUHv3xBo/o0hgZ5TsoxqVjmUvA7hYmXJSvjcNrbPJFui8x2ULEfIGEpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bbt45kRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D1FC4CEF1;
	Fri, 10 Oct 2025 22:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760135416;
	bh=v1njVSr69cHMTMzNsArVH5NqJS79UIgSmB0tW7QwGM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bbt45kRNGdxuc71IGTA4+bh1dZDrw6TLSkG8rO8p9XdAVudGAls7Ayr0v3nfaKMD/
	 jriQowgFzwh4vYkSgF7PS4w7X2SOxxsOpbP0f1b9hjVCla4CGZ7REzLANc43veIkRd
	 Do6rVFMmMaD7t3HgVLxd1ueEP9PAPTUccxzd0XvaEHGly3OI2Zevh/VsvR/joxOl4O
	 WLKp8TFYeqiw64mFdAgaoZDxhLn3HbfhL4A9tcOetRChZiaNwiisO9eVOWzPR3uBkS
	 vdDJI4rp+4wO1wphuyQEptC227KxBbcK2/28JWuNATBhF8BKJm96Do8PyqMv+cTdND
	 ffaO/xZb8g8LA==
Date: Fri, 10 Oct 2025 15:30:12 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: [tip:x86/core 1/1] vmlinux.o: warning: objtool:
 rcar_pcie_probe+0x13e: no-cfi indirect call!
Message-ID: <20251010223012.GA3597090@ax162>
References: <202510092124.O2IX0Jek-lkp@intel.com>
 <20251010032001.GA3741500@ax162>
 <20251010071032.GE4067720@noisy.programming.kicks-ass.net>
 <20251010074446.GE4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010074446.GE4068168@noisy.programming.kicks-ass.net>

On Fri, Oct 10, 2025 at 09:44:46AM +0200, Peter Zijlstra wrote:
> That's here... and that is indeed broken. Also note how it zeros r11
> right before calling it.
> 
> AFAICT this is:
> 
>         host->phy_init_fn = of_device_get_match_data(dev);
>         err = host->phy_init_fn(host);
> 
> Where it has decided that of_device_get_match_data() *will* return NULL
> and then helpfully emits (*NULL)(); or something like that. And then

Oh duh because it will :)

  $ rg '^(# )?CONFIG_OF' .config
  1528:# CONFIG_OF is not set

which means that of_device_get_match_data() is always NULL:

  static inline const void *of_device_get_match_data(const struct device *dev)
  {
      return NULL;
  }

> forgets to add CFI bits on for extra fun and games.

which means this is another instance of what Sami mentioned happening on
another report of a similar issue

  https://lore.kernel.org/CABCJKue1wCB6jBLYUc-fAEzpyQWHXwbk8R5GBaZCkCao0EQZPA@mail.gmail.com/

which does somewhat make sense because what's the point of setting up
the CFI call if you know nothing can actually make use of it since we
will crash when trying to indirectly call a NULL pointer?

Something like this would avoid this issue then.

Cheers,
Nathan

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index 213028052aa5..15514c9c1927 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -981,7 +981,7 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 
 	host->phy_init_fn = of_device_get_match_data(dev);
-	err = host->phy_init_fn(host);
+	err = host->phy_init_fn ? host->phy_init_fn(host) : -ENODEV;
 	if (err) {
 		dev_err(dev, "failed to init PCIe PHY\n");
 		goto err_clk_disable;

