Return-Path: <linux-kernel+bounces-873643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CADC1450C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A034674CF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C84304BA2;
	Tue, 28 Oct 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO6CObc/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9ED2E6127
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761650257; cv=none; b=XTEy/OOjJLOOW+QzyDUunAJmfCgfcxdb0kzbgcs4ePJHgxId4fV8uEOVifrW9l4rGFLyn73EB7tBpFleMOZtUMG7Tg23BI6Lz0UbkrmIFPgZ5LMRU7Db42AT7ov2OmvKdo/8cLX50YyBbiuWKOl2EX/pM0n7aLgt5ILDwOs+fIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761650257; c=relaxed/simple;
	bh=Iey8nZ7oDYf+JgIX8CvJENmVRD+Gv+5b229SQ6yon8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aPZuji6rt/YP11NNO9OMNJ9TQYim/GE+P1V3offa6YWHhtWtS/YmE5JA0c5ZKbwneIfGtidpqtYWH/p98QVODvRsrPgwY4jEdldvgA6tbrIIrhsUAJUCHKJ3hGy4Ic4U+AdIe5V+NB/HNVQboht6nZHhKF7X5F/7Q+dB0H0RgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO6CObc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A99BC4CEE7;
	Tue, 28 Oct 2025 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761650257;
	bh=Iey8nZ7oDYf+JgIX8CvJENmVRD+Gv+5b229SQ6yon8k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iO6CObc/RnhrhMSrg6AhcAJsYMaUVTsqFjIh1b9AZVwrGStg0tGd1xF23B2+0CiX6
	 GTQeInoxwtkIHSo8TJGC8uIEjeGMzY0btQYbACaUTaq7oDwxRYdGx4jvTw5aiHThSw
	 v9C/88GWi7/ektTs2leEO9jyq0tt0WIad4rCE0iHj3BkEebzHwWIMRW4U+/V0vxSfR
	 PuSGbfYCfAtwd/C2HpGIDx9udIG1QNtt+us70nQRgm+zcph/c9LFo9CwAJQ8hCJMWp
	 MZXpgcc199M126o52HIsoOhfx4z/gprBhAyPp8zO50MBlGj04Bmwz6vKk+EPgkIQ2P
	 G9IqA0x0/bhOw==
From: Mark Brown <broonie@kernel.org>
To: Marek Vasut <marex@denx.de>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Jean Delvare <jdelvare@suse.de>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20251027132219.2f3274f0@endymion>
References: <20251027132219.2f3274f0@endymion>
Subject: Re: [PATCH] regulator: Let raspberrypi drivers depend on ARM
Message-Id: <176165025579.34642.7378909528359924355.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 11:17:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 27 Oct 2025 13:22:19 +0100, Jean Delvare wrote:
> The Raspberry Pi drivers aren't useful on other architectures, so
> only offer them on ARM and ARM64, except for build testing purposes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Let raspberrypi drivers depend on ARM
      commit: 01313661b248c5ba586acae09bff57077dbec0a5

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


