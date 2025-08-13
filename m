Return-Path: <linux-kernel+bounces-766975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D20B24D51
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 17:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA76216F57D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FBC2309B3;
	Wed, 13 Aug 2025 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKweogCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F216230268;
	Wed, 13 Aug 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098701; cv=none; b=U2Im8XSxj5dlK5QFjQFtvXDsNPV0+sBkb4TMYt8n/BQF0S3THe10a2TIvub9uj7d0Dfco91CMeOb1jhbxkpX7om7RV+Gdr9+lNmzWg1Scze6yL/OBPQ2uY3HqhNcxYRqi5hq1XMbjhF+7VrQauvxRJ5jj6xxeDYg7sJnaV+t6ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098701; c=relaxed/simple;
	bh=kCTmKDoEly59hCMxT2cX3pWtaBbhm0EDGHi6UIOp1bQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aJG54zSsptV+EdY/dfG8+oZ9dQsDU8MGnmyGqt+Gd34rbFU3lKke9HdJ1COD+rX+sHdSM2r2rTue/tbDm9yICvv6NpSKpsu1I5hHVDzCv5u5jn4bBMPRWxpAPSGF2F1IvLlOHNDz4MxYTK/SlMXElG7b6eAY9NoZFUYwcKpBxAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKweogCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22460C4CEEB;
	Wed, 13 Aug 2025 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755098700;
	bh=kCTmKDoEly59hCMxT2cX3pWtaBbhm0EDGHi6UIOp1bQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=MKweogCpoBrDDx+7e4xPfDmOzZiiMUlP5yOb0SqN4cZz+0ca21jgDV9krrCndb3it
	 19LvfpeNVovYruINmoNzPGdqQdmS8coj00BS4DWBjBKICI8YFpYb0I0O2k0OSsAOkl
	 MQA6wWPiQyB5pg8yGBCkahRVgVW6BD74LeuyA6BRFLbi15i7jIzz1UNUIB+0C7w3va
	 Fw/BaSTHv94dDPOkK0zWyXWjT/PeZETGvEhMNyzDFgiElxJAMjxJCTAPA/a0qgvwKq
	 zTZ3r22mNFOLEqqagzlpH9E3vrC3rzbMA0SefAYT/DImDSwGo2Qgrf5yF/2kootgu3
	 FUANEBKeBFz7w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, jeff_chang@richtek.com
In-Reply-To: <20250731031701.2832994-1-jeff_chang@richtek.com>
References: <20250731031701.2832994-1-jeff_chang@richtek.com>
Subject: Re: [PATCH v6 1/2] regulator: dt-bindings: Add Richtek RT5133
 Support
Message-Id: <175509869887.77898.9838841321961421201.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 16:24:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 31 Jul 2025 11:15:31 +0800, jeff_chang@richtek.com wrote:
> Add bindings for Richtek RT5133 IC Controlled PMIC
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: dt-bindings: Add Richtek RT5133 Support
      commit: d0de6895095356f1cc2d5f9825df220f10d34cee
[2/2] regulator: rt5133: Add RT5133 PMIC regulator Support
      commit: 714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb

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


