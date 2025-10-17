Return-Path: <linux-kernel+bounces-857945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5315EBE84F3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2751AA44E6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6287343D86;
	Fri, 17 Oct 2025 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ey9lk/9c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DE34321B;
	Fri, 17 Oct 2025 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760700285; cv=none; b=aTlMnVqq1P+6SVafS8v03nl3ibwFBArUR/d+Fngoi06YzeTytSCjQisnB2K6qoK/ZV45hxeLSak6nUt/rM+lp1fd3iA5MZc/FyW6zNuvDkIWi6T7ZFUMBuka/yUonvKstBQCDwmVpgcXwcPynMI9N0V91BHaO0CozzSJ0gnUDQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760700285; c=relaxed/simple;
	bh=NpJFzxCcFayc9t00+SnzWuPNyLNxy1/G27ZnwSAHG+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qduKEgRxPdzTp3xIldJxj2Iw5RQcOEAz7Hn5rxrfOrEH1e9mnb4zGGknZRv2J9eoOsrRbxJOuc5UOLqMaxNcRanmMK1CPXrk3gR16clDngDUcpf+5821kSTTLoj8N/uzcztnw0+auQ6aynrf2JACjwDM74h4u0p0XIJQQfSeTfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ey9lk/9c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8360C4CEE7;
	Fri, 17 Oct 2025 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760700284;
	bh=NpJFzxCcFayc9t00+SnzWuPNyLNxy1/G27ZnwSAHG+4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ey9lk/9cEPHsfTFxHF6dHjMzr+5HY15ilUWSaaZznVNWlEfdyepcGCN/1yRXUJIeX
	 pHZlyUyRB36a4dg74aQPWina5N5d7MtZWkUXOpgRgQkuZyKaGrkK9Z3PkmekNS9FUF
	 mh9BJNicGVBARBJG0cuBFWrm9iVyVN8md9KaxD2GJirZAtL8PHIe2+jb3QCeKECwuv
	 8fwxzzgZ0nUGfxIv/HAnmXAXpzKkhVyiWlC4kow5opraCV8XIjTsQAE6Em17wTJY4i
	 zevlFxT6nms7qEJBS3vMtKLH0+mspvF7B66Cn2Ald54beyYzMSCMEEJZVIRt4+ExbO
	 JqNRe4CMWkVYw==
From: Mark Brown <broonie@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.li@nxp.com>, 
 Andreas Kemnade <akemnade@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
References: <20250917-sy7636-rsrc-v3-0-331237d507a2@kernel.org>
Subject: Re: (subset) [PATCH v3 0/3] regulator: sy7636a: define and init
 all resources needed
Message-Id: <176070027934.36205.12873966810251115615.b4-ty@kernel.org>
Date: Fri, 17 Oct 2025 12:24:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Wed, 17 Sep 2025 09:14:28 +0200, Andreas Kemnade wrote:
> The SY7636A has some pins which can be hardwired or used to have more
> more advanced power management available. As several devices containing
> this regulator have these pins not hardwired, but instead connected to some
> GPIO, enhance the driver to have them defined and initialized.
> Also add the ability to power off the chip completely by defining some
> input power supply.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/3] regulator: sy7636a: add gpios and input regulator
      commit: fb25114cd760c13cf177d9ac37837fafcc9657b5

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


