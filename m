Return-Path: <linux-kernel+bounces-803412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA1B45F88
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0076A5C1294
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9D3306B38;
	Fri,  5 Sep 2025 17:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlYG4nVV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519221FF46;
	Fri,  5 Sep 2025 17:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091964; cv=none; b=F+h5v3KZbEfvwHH/bl1/G9wH3AAdhQoo+niJdesSXUYF4bAOe3jZsn4auC7zcUvhn7Pa77aQDmYV3x5tVN+sclv3Ff3l18KQPU8fTjThgi5BY2BKK7eoOdiiOD/ErtAoR96UYocKcwaWf7kPFC84q2mjvou47bSwRQ7vDI5gE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091964; c=relaxed/simple;
	bh=ox1WUoyvjtTHuR2qBzI6u2/HwnXqXAQJglmbFA97so8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lPxfjbOHT6Vy86eew+F2IIYc4svOIiQ+EUTeMxDFQflhdtAQImMP35RNofZILb7y6mcssn5r+4hYBc5BHnvCUr0PDsiMHKhPGTsjwhznLvlmKUcXMFZL2W3tU6Jr9hfqQs8W7SWaLp0jIFPrgPITaNMwW0jwdf6Xdgz0o4kuoeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlYG4nVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6A1C4CEF1;
	Fri,  5 Sep 2025 17:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757091964;
	bh=ox1WUoyvjtTHuR2qBzI6u2/HwnXqXAQJglmbFA97so8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LlYG4nVVaoqmUnZwtzzM5y/I5tjLHv1ObX60zTuoGSJpPzhJR+xIb7Wpkkt15QjKs
	 2t3pSUY1nwVXSWZmmN3enM6/+lW/bFuSLKWhtXKVq2osRV2QdvOoHKQWNqBC5NgARo
	 TXi/l1dj3Yf4KzZS7lbXwKU/vLTTMboSAFJSWeph/Zk/Wr08ehCvzzNVOS4srmBU6x
	 q+D1pUr1LecrWAjrwlGH0IDyYMTzKUS750OSx077D4xdnOgkgCZ4hG6HeG73W47MJY
	 YsSgGDWI/0Ah3lNpUDFBY8R2R+T5FYqFeONm9P0+O51g+CnSyzEcaDKs5qpmN1Bqlk
	 zTta/SHC8IkLQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Woodrow Douglass <wdouglass@carnegierobotics.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250902-pf530x-v7-0-10eb2542f944@carnegierobotics.com>
References: <20250902-pf530x-v7-0-10eb2542f944@carnegierobotics.com>
Subject: Re: [PATCH v7 0/2] regulator: pf530x: NXP PF530x regulator driver
Message-Id: <175709196201.166280.14844235200399964149.b4-ty@kernel.org>
Date: Fri, 05 Sep 2025 18:06:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Fri, 05 Sep 2025 08:39:41 -0400, Woodrow Douglass wrote:
> I wrote this driver to read settings and state from the nxp pf530x
> regulator. Please consider it for inclusion, any criticism is welcome.
> 
> Thanks,
> Woodrow Douglass
> 
> --
> 2.39.5
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: nxp,pf530x: Add NXP PF5300/PF5301/PF5302 PMICs
      commit: f5d15ff664a32593e0152d21ea747fb77e32ce7e
[2/2] regulator: pf530x: Add a driver for the NXP PF5300 Regulator
      commit: b497e1a1a2b10c4ddb28064fba229365ae03311a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


