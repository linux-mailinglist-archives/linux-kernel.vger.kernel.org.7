Return-Path: <linux-kernel+bounces-764627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2F3B2254B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B5321B63D22
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DD12ECE9A;
	Tue, 12 Aug 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWSKHm9m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBF52EE262;
	Tue, 12 Aug 2025 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996719; cv=none; b=J/8+rM+fFy3iwOWegBUsoxxJHhi44RhooVoS4Bh+K2+KNSpf1jbSvJ0YrUVDVH9B+K0YqCARChDvkA1IBroRFkYgW2f3f9jznctwtq/nF3ZbSJxCtEgM34/WfbqUD/Z/5imgzsi/olR70MES7cvscsmPKh+LQkk1cPhhphw3G9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996719; c=relaxed/simple;
	bh=0BwRILpusAVrivTLcsAixdNdRY4nvTJgi3xEFY4YsN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J7tA/g92PKMh4CpIZoRwkABq5pfV0A1zK8C6aK1BQwVr/aTRm3fMllnX5NTkpTCwVfJvUZNPJo8Vg75QFWHRB5V80nVpC4wekbWCOI0soCRFsMryJWSqnXYLRRT84FoXp7fi4QJbi0fRZdDZiKJzIQrlB0k1I7jTS2vuv7xMHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWSKHm9m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2FDC4CEF0;
	Tue, 12 Aug 2025 11:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996719;
	bh=0BwRILpusAVrivTLcsAixdNdRY4nvTJgi3xEFY4YsN8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PWSKHm9maPZ82AuMYOrCQxHej/6dypc7ijXS9T0jfJ7mV9Ii54WMJrtrYOjOksuVA
	 X4QUGxJMgUrqHN3kw2FSiTDb/mh8v2wPpKJK+etKn6Mj296uUUQm4ZJw1/QUtv/vZO
	 BgQDfr5WgcaFsPh/NajPl62ZKwYH7YBNu3MDpILaW6DabjIrPWv0JVCd5aiBPgHcWQ
	 R00UEF8FIFTq8Xksz44XIfAhxuIDYZ2+TYc65zyroiBhvEqrP4Wt3pctmfgYqESXlL
	 BdONDglSkxV6WWf7ICTwrn3bW9ydDnZ7odVOmgQRiUuRUUNJGKTbcnkaVBiHmjwkE1
	 s9YeWIuV7Y8vg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250807214358.4172451-1-robh@kernel.org>
References: <20250807214358.4172451-1-robh@kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: Drop imx-audio-sgtl5000.txt
Message-Id: <175499671651.16031.1365399416603486475.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 07 Aug 2025 16:43:57 -0500, Rob Herring (Arm) wrote:
> The "fsl,imx-audio-sgtl5000" binding is already covered by
> fsl-asoc-card.yaml, so remove the old text binding.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: Drop imx-audio-sgtl5000.txt
      commit: 605d902bb6b6f5b12a5baeaca0dc359ced7685cb

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


