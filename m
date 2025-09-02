Return-Path: <linux-kernel+bounces-796635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AACCB4049B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 690663BBE44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2451033A009;
	Tue,  2 Sep 2025 13:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCfrnnuV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4C2848A1;
	Tue,  2 Sep 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820238; cv=none; b=diW1vXCwUDGSesfpoVcGubBwWbmz3RqXjYO9rTReuaqv4r63pAExl8sMVnkglCXf6nsTQkj959paUyTHkbMy4CRrzHTJegpVL7Hg1I4KoW4fPt3qPV4EJNjzKdM4w5diQAgn/+X4UcI3MLAflWMy4l2IP2aTxTIS2V5g0J5njYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820238; c=relaxed/simple;
	bh=Te5CzzpMDl9FuNFcIn3BKuG3FhHEU09OQccy0nOcUCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oGdySdhaCEfZWdb506VaIgBxYDbet4HxRNHgcCngaaCoaLYCNf14a2wVYt2NESoIrf8yhwKz6PpxvmSAJRSUGviMG/pclWyysJXoUO1iOFGLuw/b4EE36ofuJQBLPLfSnLRK9AwhYAjpo9UVjez9p9z1X/dbGJtfgepEvXzYJlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCfrnnuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEE4C4CEF4;
	Tue,  2 Sep 2025 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756820238;
	bh=Te5CzzpMDl9FuNFcIn3BKuG3FhHEU09OQccy0nOcUCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OCfrnnuVO6Hqtk3HsgT5RqYeJdejCqT1KSw3xGO8sYcRtd9rOSWqtpmkFHwYD+lue
	 oERs3Tq8oX2VIh0EAQdLfF85GWRbNPMXqu3zQ4344EfEVtk57adySD+e+4ZhhznpqA
	 j9t3+LB05FwIuTaEpEu/bmwV5zwaThP0MHoaz9BTGgaR/11N4J6rxIyZviOG2fkN+e
	 RrsfD0qH4TVAQdou0KU5KAhvKjGXv1vQEeNcPRjQvLSv9lBaw6peVESh0FzA/H+wmU
	 Ne7DEBARMdATGDm5DGBsvQXSartHRZrSdALI3TO70ynDHgId8Ge1W3a0AFi4b+EKyW
	 DVQLipU/nOF7Q==
From: Mark Brown <broonie@kernel.org>
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Frank.Li@nxp.com, robh@kernel.org, 
 laurentiu.mihalcea@nxp.com, dan.carpenter@linaro.org, waqar.hameed@axis.com, 
 festevam@gmail.com, kernel@pengutronix.de, lgirdwood@gmail.com, 
 peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com, 
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
In-Reply-To: <20250902102101.378809-1-daniel.baluta@nxp.com>
References: <20250902102101.378809-1-daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] ASoC: SOF: imx: Fix devm_ioremap_resource check
Message-Id: <175682023505.513793.6818545507364756748.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 14:37:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 02 Sep 2025 13:21:00 +0300, Daniel Baluta wrote:
> devm_ioremap_resource does not return NULL on error
> but an error pointer so we need to use IS_ERR to check
> the return code.
> 
> While at it also pass the error code to dev_err_probe
> to improve logging.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: Fix devm_ioremap_resource check
      commit: 0c28431f6fe13f3a3be0978f79c1a7ae8a93d028

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


