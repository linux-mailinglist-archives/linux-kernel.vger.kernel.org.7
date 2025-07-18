Return-Path: <linux-kernel+bounces-737327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBFB0AAF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 22:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22376A47DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 20:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ADE1DEFD2;
	Fri, 18 Jul 2025 20:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uik6Y9Cw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC4FD517
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752869029; cv=none; b=SqWQCMJPOBughzLhWPvFY2u/mbBZL3h0PZhWB/MaGQ2Msw9Yi9ETCwKtTYRyLK2vDdz6eFYBovOV34d2648DvnFX89U0n9lj4FU8Y8y2fFfMvksg5WAyR07Z73/LJtho4c0r/SXFxtt15JahkHLTRwlylrxY5oS2j4mh2mEn/B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752869029; c=relaxed/simple;
	bh=ZpLPqVwT5wlxVe7X2IE9j+q8fi3x5iPHAomAG1wm2mE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QWlNvD1TR1Ga2BSLNyvEvluoO0H9MTS2e55nfNgtUjirK+kYuivb/aNAKBOYZhi3/C94nuSLgH2tpQ/Vlyo3tcTUpaYsiPRRVhJJMyxj49iNeWqvreE8BXlYMjI+KkvXJxJylvzA4SnvuwSlZO2Wpdr2/CiIgr231DNRw2CplC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uik6Y9Cw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6302C4CEF1;
	Fri, 18 Jul 2025 20:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752869028;
	bh=ZpLPqVwT5wlxVe7X2IE9j+q8fi3x5iPHAomAG1wm2mE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uik6Y9CwjgiBNFtjtcWAYF9j76VEn3roFYFagl+WvKw7pIC/X6+StJeTF4RThk7kp
	 KZJKzqvqTHDbOQp2pQoNx0jpikjOs5yx3il/u5JUa0YT+nB1q2McGW+zPhIcD07HoD
	 J3d/JzjBkrdvAFz/3V4nM2iX/8c5YR+0nhoiIfFE379MNnlDwwshgt3qKOTrns2NVG
	 Xe7RFs9RNNuTFWTivEqhUBVbITjmjdT+J5/P+0RIwJ1Vfs9n8y68ym+hlqfmt5Hjrf
	 97n1o66NeZTPbI0Gmf/paTXAn1IgfrZqI6PPCRieO4beFWZiMNgHuPqJFC9ciFyRul
	 p+/hep9Nbz7Zg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Romain Gantois <romain.gantois@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250718-regulator-stepping-v2-1-e28c9ac5d54a@bootlin.com>
References: <20250718-regulator-stepping-v2-1-e28c9ac5d54a@bootlin.com>
Subject: Re: [PATCH v2] regulator: core: repeat voltage setting request for
 stepped regulators
Message-Id: <175286902743.1108772.4362873620041124201.b4-ty@kernel.org>
Date: Fri, 18 Jul 2025 21:03:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 18 Jul 2025 16:11:36 +0200, Romain Gantois wrote:
> The regulator_set_voltage() function may exhibit unexpected behavior if the
> target regulator has a maximum voltage step constraint. With such a
> constraint, the regulator core may clamp the requested voltage to a lesser
> value, to ensure that the voltage delta stays under the specified limit.
> 
> This means that the resulting regulator voltage depends on the current
> voltage, as well as the requested range, which invalidates the assumption
> that a repeated request for a specific voltage range will amount to a noop.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: repeat voltage setting request for stepped regulators
      commit: d511206dc7443120637efd9cfa3ab06a26da33dd

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


