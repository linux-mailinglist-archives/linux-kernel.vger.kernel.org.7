Return-Path: <linux-kernel+bounces-896174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CACC4FCDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758DD189D8F7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C471D555;
	Tue, 11 Nov 2025 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pAsqxUDG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFB35CBD1;
	Tue, 11 Nov 2025 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762895416; cv=none; b=Qu9Ps+JQxqg9+TjZKfyMwlnJXgPy8K0QxD2UyMgORfi7hlrZwDQlHBbIxafgwkr9NnCFgVDOBxq7MlGrV/KtGNoy6woQut8V4z21vyhKvfXRwsgU0TAVLLnbz2oPMO86pnKkfCWfYUeedj87NR9edTcgbMCD+utKKvwVytorsWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762895416; c=relaxed/simple;
	bh=FKb72lpm/18YW0XXtCd3Eg+Kz3XQ78Aqfk0uHseaOLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SdZ+pCPkPfK0dE2bNgknq+qYVl/ar+Ww1bHCHBzupzljoEiGPdMUzcQBfp0V2ZBB5P0uHe1ZTVkX8O25zmnWzA7WxDwafvaB+gGCv146S3lgNOocccAwvGaRxg6K5DEEE1yukL1rLYx/lKdXyDFHjmd4Vr/NWwjL0MdwL9zJyDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pAsqxUDG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A61C19422;
	Tue, 11 Nov 2025 21:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762895415;
	bh=FKb72lpm/18YW0XXtCd3Eg+Kz3XQ78Aqfk0uHseaOLs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pAsqxUDGatPP22zZBwR7R4cFAYyDd1taPRhRNbO3Ptc20t0Nynn1wGej7TyHVkviA
	 3gK14VdRFWayHnPrYExEHInTabh/crbhYRsBPNgQ1Cl3lZKj8XM8EAczZKOLIBARR4
	 KLtg+2lHn+oF64gdg/TaLmaOBqF9jPbm9J/cnlxd4etzdJe3ZIBSOj3CwOW7Xw/1z6
	 4o3MWWIRt1Ey7fsPQ/WrGRuq6Z/8gDUQDzj8oz9UxW/FkSHwonU5bznVWP4wfUQtXG
	 8ROqqOroQ49MeohQriNKiCOuUAxnAgWKVe/18J+BKDj5GzzK91mhtZLs7xad1BVP0n
	 /EEyMGZhb4k2Q==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com
In-Reply-To: <20251111130850.513969-1-rf@opensource.cirrus.com>
References: <20251111130850.513969-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH 0/2] ASoC: cs35l56: Support for restoring calibration
 on ChromeOS
Message-Id: <176289541450.189249.18194357046497579090.b4-ty@kernel.org>
Date: Tue, 11 Nov 2025 21:10:14 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Tue, 11 Nov 2025 13:08:48 +0000, Richard Fitzgerald wrote:
> These two patches add ALSA controls to support restoring factory calibration
> during OS boot on ChromeOS.
> 
> ChromeOS applies calibration during boot using a process that has restricted
> access permissions. This process needs ALSA controls for all settings that
> it must restore.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: cs35l56: Add control to read CAL_SET_STATUS
      commit: 69f3474a01e9867dd99fc4b703fa834ea1835c7d
[2/2] ASoC: cs35l56: Allow restoring factory calibration through ALSA control
      commit: 32172cf3cb543a04c41a1677c97a38e60cad05b6

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


