Return-Path: <linux-kernel+bounces-757716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58115B1C5DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C437A82D8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DD828BA99;
	Wed,  6 Aug 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2Ox/f4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF69192D68;
	Wed,  6 Aug 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483466; cv=none; b=E8kgS+6xQdPq7IuyeB06sX6baH+IblbSFWkWGxp1AP0zsFlFLEcuC2/ZwwRbw7aw803/A9OmTmrICFg0BNcuSqIWn+enHzPAuCt0ZvENXinOwLnJgVO9lEHqPpgkCu7KTl2TheWtwuw6nciHGBVq7xsHjf1XLNy2/HdkJC2PZ58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483466; c=relaxed/simple;
	bh=6SYLWigHb/uhY1qfbllUFwByFgGXUgdw9SpyK/xp9QE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TXF35Er5JVonAGgVsChUYO3aktYODPizVKA+/EKj0mdZbsWgTUbTynt8FtLwVU0lXFMcausBogMSjn8Bi3wN2+8uJscyvCWq27BFKtIjnDVDdH9+vKfN2VUzAsiDKUb2Kz2U2skUWtjk7VKDEopfITZMdX/hVR0qIbMNb7lhc4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2Ox/f4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6419BC4CEEB;
	Wed,  6 Aug 2025 12:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754483466;
	bh=6SYLWigHb/uhY1qfbllUFwByFgGXUgdw9SpyK/xp9QE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K2Ox/f4IuqXjL167WZbkptv+L2dD5f913hdOQ13553XhwXUpcapGFS5oCOWLx/Ngo
	 2CdZW0UTNcZr7kON2Dx46Tiu1ruNunTMc/BzedWSmX/ImCTnizndC5YqD0MtVTGn5i
	 aUdQGjK+crRvyK8FnmX70JWd01+dILVdCFNVuAyf0P1DCCWW/aILkRyUQXu4ZxUi5J
	 BDs24FUSjDueW7wnHrcVxNknvxpHb2RBZUMt7fTD5OOH9RdebIBt+1X35N5vBhdlvJ
	 h/ptzvKEwUsOi7q7NJ9MW+OdLeoxA3lL9WBeupj5NTNJnzZqKWpTV/b7yJ9N2H6FpK
	 dUeQBOScJLcSw==
From: Mark Brown <broonie@kernel.org>
To: Baojun Xu <baojun.xu@ti.com>
Cc: tiwai@suse.de, andriy.shevchenko@linux.intel.com, 13916275206@139.com, 
 alsa-devel@alsa-project.org, shenghao-ding@ti.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250801021618.64627-1-baojun.xu@ti.com>
References: <20250801021618.64627-1-baojun.xu@ti.com>
Subject: Re: [PATCH v1] ASoC: tas2781: Fix the wrong step for TLV on
 tas2781
Message-Id: <175448346413.51650.7450659009173444382.b4-ty@kernel.org>
Date: Wed, 06 Aug 2025 13:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 01 Aug 2025 10:16:18 +0800, Baojun Xu wrote:
> The step for TLV on tas2781, should be 50 (-0.5dB).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Fix the wrong step for TLV on tas2781
      commit: 9843cf7b6fd6f938c16fde51e86dd0e3ddbefb12

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


