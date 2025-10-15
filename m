Return-Path: <linux-kernel+bounces-854227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4EFBDDDD1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC0B3A7EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A07E31C567;
	Wed, 15 Oct 2025 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1Jx6O4o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD331B133;
	Wed, 15 Oct 2025 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521799; cv=none; b=IaSUMKnrWDoOFqoGGvOw+ZzfwcDjNvcOP8hxkR7w2Gz1uNGUSy/2ETdaV/cTCduBUCA/VmSX2xXHp6WOVZebJco83bqoKTTh2tKuNZalnr8Kd26AXVX+LZh1kdsYCcH0LY5RXlHHM24CjNmUOIRMArzh5J42q9P4iYHF5ExC5+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521799; c=relaxed/simple;
	bh=M61CuQSh2IqQfl/E7LQgk8UCEqyJxBhl3XXYHKg/4w8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R2VOjU7+SMWpNtz0nB4Yo3taBo4HiE/0QHUt+pTb5j5zF7/mvhbpYvHIjd7en2NlesUPOp6WPZ6iGbAl1Y/uhHbjVgphzLOVq2w7KFRGiZYFoVh+z3m5+lVLjDK7XjrxNaAUW0M+E+eBey8qY2HSyO6EyjRvEF0Jp2W7f7kX2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1Jx6O4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45A9C4CEFE;
	Wed, 15 Oct 2025 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521799;
	bh=M61CuQSh2IqQfl/E7LQgk8UCEqyJxBhl3XXYHKg/4w8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=D1Jx6O4oZqW0l4V5NpbyQXGPy9T1UE9qAODVUeD1tVp++GQgC9OigGWviTD1z6ZRy
	 LT0lVwHeuwobTlFc8dDWJHKNftvPihwMKw9bq/ZJ17aD5Pf2mj2CSCp7fkbmoykGHP
	 bVq7v819cp15f6WjbFXAsUlWjpvjoMkJQlvF5lvanzCKb9Na0kGI/S4di90uvA/WxH
	 DWh3dOmMUblYMIb23hk5i1WiuefC+uCVfshDqkW/xVoou+bnbTSlCaK1+FX63Mmkef
	 L+m+V4PEWXOjymU3FXPk2tXQmdeG7nU5H6xydqNZ1RSQN6kZrB6W7VSMdxfyFxBpEp
	 k+B6jEYohatVQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.de, Baojun Xu <baojun.xu@ti.com>
Cc: andriy.shevchenko@linux.intel.com, 13916275206@139.com, 
 shenghao-ding@ti.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 k-yi@ti.com, henry.lo@ti.com, robinchen@ti.com, jesse-ji@ti.com, 
 will-wang@ti.com, jim.shil@goertek.com, toastcheng@google.com, 
 chinkaiting@google.com
In-Reply-To: <20251008045500.44477-1-baojun.xu@ti.com>
References: <20251008045500.44477-1-baojun.xu@ti.com>
Subject: Re: [PATCH v5 1/2] ASoC: tas2781: Support more newly-released
 amplifiers tas58xx in the driver
Message-Id: <176052179545.20166.14128164480099821391.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 10:49:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Wed, 08 Oct 2025 12:54:58 +0800, Baojun Xu wrote:
> TAS5802/TAS5815/TAS5828 has on-chip DSP without current/voltage feedback.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: tas2781: Support more newly-released amplifiers tas58xx in the driver
      commit: 53a3c6e222836a23e8e0693395584aefc456dca6
[2/2] ASoC: dt-bindings: ti,tas2781: Add TAS58XX
      (no commit info)

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


