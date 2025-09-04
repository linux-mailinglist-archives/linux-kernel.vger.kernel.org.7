Return-Path: <linux-kernel+bounces-801450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 421A8B44516
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1028A1884729
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A79342C99;
	Thu,  4 Sep 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpRAKSu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105B831A56A;
	Thu,  4 Sep 2025 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009384; cv=none; b=SO9YkBzCTvgg5EBc1c1esvkGyx2jdF1diKniF4OEAF+bulOhRE3V9ZalXPOJQtYfGl9F2F2mZ9tbVY/hlO4gFjpYYxWcWaHf3TkI6bjwuJdJwL4nuodsEpzAwigD8bD8SP3PRdXuk2p4+4ksfjDJpMLvziRoRplQ07fgKItg/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009384; c=relaxed/simple;
	bh=Dzf/E0myGWwuHVTtzSDrAX9V7VK8/NJWwMdaP/xXb50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J89hBECQd81KoWgJFXFwYEiKcXbq5CRu39E9S+zTxxGPwUgwr+0zLVbtQ1e+SEqrrArfnMBwNADK/w6BbWXDfGHhsASTSlsrDr31hmXZpP1VZdpIpP20V8mLErsXrchvtuQuaylkqq5jLCVzo2R1DSjWbCZlq2dxgSGuxEYW5tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpRAKSu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CB4C4CEF0;
	Thu,  4 Sep 2025 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757009383;
	bh=Dzf/E0myGWwuHVTtzSDrAX9V7VK8/NJWwMdaP/xXb50=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GpRAKSu6oZa+akQ77ToHMpbGcEvDkFGHsjxn2CupWY/U8XNnM/GPb3jgvvvzM7iLp
	 sDXntqT7zk4FF9LugCVVEtamnX99GxQGvwmnJLvH7h4rvQsv0olRjO0NusTvkdpIi+
	 ycnUqmqc2rO7bDW+RHSohH2wc+gk3D+QIOLjF6QK7MGqDWOF1M4p/qoy/MpIv8tVvh
	 tDR7jF7RarHIzQcFQagvrwdeCfsEr0W9dc74X1ACeqF6Vjo+UcZdUizSTdgs6Gm5Y5
	 crkoBBVu0J8Bn5SHK0Ju+fhNpVtgFrzPBLpwVM80hcUiXaFK0hseo8T8kDUi59wQh+
	 Lwijjr4JbWLoQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, krzk+dt@kernel.org, 
 Jihed Chaibi <jihed.chaibi.dev@gmail.com>
Cc: lgirdwood@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
 drake@endlessm.com, katsuhiro@katsuster.net, matteomartelli3@gmail.com, 
 zhoubinbin@loongson.cn, KCHSU0@nuvoton.com, patches@opensource.cirrus.com, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, shuah@kernel.org
In-Reply-To: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
References: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
Subject: Re: [PATCH v2 0/3] ASoC: dt-bindings: Document routing strings for
 various codecs
Message-Id: <175700938092.120028.16133127000007382726.b4-ty@kernel.org>
Date: Thu, 04 Sep 2025 19:09:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-dfb17

On Wed, 03 Sep 2025 18:01:16 +0200, Jihed Chaibi wrote:
> The series adds pin names for the es8316, wm8960, and nau8825
> codecs to their respective binding files to improve the user
> experience for board developers.
> 
> This v2 series addresses maintainer's feedback to rephrase the
> description to refer to the device's pins and ports rather than the
> driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: dt-bindings: everest,es8316: Document routing strings
      commit: acd2fa47aac568052bd8321586be64958e3e93b2
[2/3] ASoC: dt-bindings: nuvoton,nau8825: Document routing strings
      commit: 118ddab8bb4a06fd5e13446d11d69e301044087d
[3/3] ASoC: dt-bindings: wlf,wm8960: Document routing strings (pin names)
      commit: 0ccc1eeda155c947d88ef053e0b54e434e218ee2

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


