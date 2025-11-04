Return-Path: <linux-kernel+bounces-885025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363A6C31C15
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0069A3AE6C5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 15:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CC0224244;
	Tue,  4 Nov 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3xRnEki"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460219644B;
	Tue,  4 Nov 2025 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268771; cv=none; b=P1qfBDd2lzfLWCYs4RbZpsIh8dnio0dmG3nAXZz2Khz+UVdiAZE8G/wWpMGSW4adeOUegMB0Rp6nI7jDV3qn7/6IZ2X65DGfYHyZz+oiWapewJ1S9CYFhohU7IiMmrbGzGuCxrqNJe4mjSbT7XFbu0kjsWMi8fsSbd+tgdg+7Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268771; c=relaxed/simple;
	bh=k+RL3ZBpmUMO+8HQzwjuPhtw5LHaELXUVuJKNb73ce4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ogcj3AvEq2ZSQGEkU/Eu4iwS+vUVTeBLDv0QbJBPEr6LHznJnORzMttaWPHC05+gvZpssQvf7p6CIbquciI44/3Tz1dbeZaZnU3g0qRsmZUSw1QkbFl+3Dw3P8Xv96bcv1gv+CVsk3xUyo78+RTegWFl+uPcF0RTDZudCGtsPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3xRnEki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F982C4CEF7;
	Tue,  4 Nov 2025 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762268770;
	bh=k+RL3ZBpmUMO+8HQzwjuPhtw5LHaELXUVuJKNb73ce4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=R3xRnEkiyd9KfCqwgPRDiw8Tpkgj2/IRUm4eL4YgFVuWMSsUbxEPsATGHpdfHP7yO
	 p8S0f+DqCEvpnpyKBB9HZk5BRmkJ43dU5h7nwTE34NjshzwFd2m/o8QhaCyjd5OjhY
	 2ZjSu1IJPgKILLFT7pZMnEMyzVVECfGrLd1SSBFgdYlCRRBgvM3AzsNVr64qP7jLv4
	 T6TumfXtUBibomL+EkXa6SyYv3wmG+9r6ZXOyC9+G1jzUyUY/8MZWkO2/xmFJjfIhE
	 Ppn6yPfG8G73IUBpUMFjc+985E6RSEv/gau7/e1kC9A84DXGnw8+bL7LSLTMh4CT3a
	 YD3HbbsPkdNiw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Joy Zou <joy.zou@nxp.com>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
References: <20251103-b4-next-pf9453-v1-0-a025d536eee1@nxp.com>
Subject: Re: [PATCH 0/3] regulator: pf9453: optimize PMIC PF9453 driver
Message-Id: <176226876897.2228237.4299470805943237670.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 15:06:08 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 03 Nov 2025 11:26:46 +0800, Joy Zou wrote:
> For the details, please check the patch commit log.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] regulator: pf9453: change the device ID register address
      commit: a2d4691b3fec6a2360e4ec953d06819ea055c3e7
[2/3] regulator: pf9453: remove low power mode
      commit: 0144a2b29d95af8523c308116de65d398d6e935b
[3/3] regulator: pf9453: remove unused I2C_LT register
      commit: 2ecc8c089802e033d2e5204d21a9f467e2517df9

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


