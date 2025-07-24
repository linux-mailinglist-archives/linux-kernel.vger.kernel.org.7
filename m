Return-Path: <linux-kernel+bounces-744942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F50B112D1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4289AC7B32
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C7E2750E7;
	Thu, 24 Jul 2025 21:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amJyI82Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5A1494C3;
	Thu, 24 Jul 2025 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391350; cv=none; b=k41qJwci0PlPd9zYNIIqZP//xqVH1HnUL+LmG2pq1WIwZ4G5sNDZoDlEjkvBGu3nsWVv/Di3aAbGV5TFSCn94PJ4g2ifsT3cf8IDwYKutuUYwahxdMpoNge5sd3BYZZKvrHpkFaMu7Stse/QJRCuM0DFBYJrsuQFKk8MJRN79u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391350; c=relaxed/simple;
	bh=9hBLthfeLJohmBKsdKVC7/N8g1CIumC4Qo8te0kkv2Q=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gwImOWpwoIzTy//4wF0GydvTv7p9Row25nL1IVZGeA+8vg4d0NSsxq74Xot1ly5hfF8fp2VmV5hPtse7tQPUuF0StJwnDxSMUomvLEHu8S6e8lEPOvFbCNfOk3atk2yIPI6T5WvXKfVHMjaNLseyWtK9SyvBvkL7ZNjhIrEgH/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amJyI82Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5043C4CEED;
	Thu, 24 Jul 2025 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391349;
	bh=9hBLthfeLJohmBKsdKVC7/N8g1CIumC4Qo8te0kkv2Q=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=amJyI82YFSXU59uf+xcB/1nflwqoq8fm8g0pbd8MAfhxMdpFCXg6C9Owt45GID8Z9
	 O6qkegnIzv2rzXQISHEExXuRyYMbHpZJdlhYCQlEN0ysPQ9hj711/COZcSZhFzaa8D
	 smZpp6unNhchBAbQt0+kNeQ0ueesDKOjKgQUqsIycVVT1+2qoITqLMOGapk+pscQJX
	 H/Ui85egm+n9Bn3lS9hCQoSF3HcMWT1i8r5aM6gHCy/XHNr9bZvHb4hE6uCGUIc7Zw
	 jbs+izz4PMj4FFDH3MT15/09icj4HhsmAnuTxUSm5sL+OC9uD9g3DYfy7VEC2gZByu
	 4LLhfrHzZeB0A==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20250619062413.3946142-1-chancel.liu@nxp.com>
References: <20250619062413.3946142-1-chancel.liu@nxp.com>
Subject: Re: [PATCH] ASoC: imx-card: Add WM8524 support
Message-Id: <175339134540.153218.11280213676101043795.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 22:09:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 19 Jun 2025 15:24:13 +0900, Chancel Liu wrote:
> WM8524 is a stereo DAC. Add support for this codec in imx-card ASoC
> machine driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-card: Add WM8524 support
      commit: 2260bc6ea8bd57aec92cbda770de9cc95232f64d

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


