Return-Path: <linux-kernel+bounces-823139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC299B85A6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39465857D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401AC30F946;
	Thu, 18 Sep 2025 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLZHl+z5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E55630F92E
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209475; cv=none; b=VLke8EFNYyEP4hc0K/DxrtYR5cKmB0KF2bRg2FSBcMO45rZmgQGLJD24KOzm4LRBAn9zznHZUEgXMfnCtSpAdcIhGRpPF8cfmVJuHwCDhdqdJrBBgokkb1rwvzV5ko1F237UBu1mSzjdUwvCPYLsY0y7a8b2iLRqTXTSo2ktpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209475; c=relaxed/simple;
	bh=S1v+q/P4cQWTdz964LEDsaZ0Tp9i4slYArkAdfNE5n0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e4+a2I+Hb+XgTeNGz5Uk6X5hCJbmCroldgZrCL7X3WrzblSXJvmfly/Wq64JogvIZx91OgMxEAYOO8rDKfjFmDmvklTlwORliZVvf/TH/5nc758VTNzPQm6O2avQ9+iV0ITLvAy8SQ3vcTMZrIDhrcPflDcH4/dhj6fc2qrOSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLZHl+z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A4EC4CEE7;
	Thu, 18 Sep 2025 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758209475;
	bh=S1v+q/P4cQWTdz964LEDsaZ0Tp9i4slYArkAdfNE5n0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iLZHl+z5sYvTxdG5Gz4KFFo/dxNWwa+2RkDwMl1FLJ1CDkyXnYmml6iVRGbDlwuqJ
	 QucFB9DmQ6bxXoTF0vSXoL2mxIvmAk7OHhECYB1DCmq/LaaZCf9bSn58NTlO+kB2oG
	 oDkC+UY8c3ZZC52wsO5G2ye2s55SRQLWCFQe0zizRNfGdTf1OhuLwGoy8gXZMzgBYz
	 8LL6lsv1yQHAf1dfKtbRjJ8TCHG5bkUofbpb4d5tdcNtRS3OETYHPZxgk6DZO32p4x
	 YjoBt8rxnzkYDt+x82wNgReYF/t8X3zlGT+7YrmVEesmwSnZFaXuLhoJ3K+zcCybc2
	 AYH8+5zv1dSNA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-maxreg-kconfig-fix-v1-1-1369f88d6272@mentallysanemainliners.org>
References: <20250917-maxreg-kconfig-fix-v1-1-1369f88d6272@mentallysanemainliners.org>
Subject: Re: [PATCH] regulator: Fix MAX77838 selection
Message-Id: <175820947396.118308.9417897799910178332.b4-ty@kernel.org>
Date: Thu, 18 Sep 2025 16:31:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Wed, 17 Sep 2025 16:58:28 +0200, Igor Belwon wrote:
> The current entry for the MAX77838 regulator is unselectable (as it
> depended on a non-user-selectable config - REGMAP_I2C). Fix this by
> making it select the config, and not depending on it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Fix MAX77838 selection
      commit: abe962346ef420998d47ba1c2fe591582f69e92e

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


