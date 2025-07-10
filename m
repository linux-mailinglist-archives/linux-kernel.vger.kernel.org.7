Return-Path: <linux-kernel+bounces-725211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4776AFFC09
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95F6A1C4410E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EDB28C5B4;
	Thu, 10 Jul 2025 08:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4FY+TLE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093A28C2CE;
	Thu, 10 Jul 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135630; cv=none; b=ueoG7BDjwFRv8/14/1wgheaG76BIVvLQai6ZGo12GxGkxHL7B32Wln+XwKuf9LOMHYp0KIFpzmBcMZyfXvdihq3j24JIjlRJ8PwpjpPoqUzfx07+13yqaSP07qub9f3GxNIS7yCXqJYmHleI20vpB8xcgFpcD28WYgiNx7U5fNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135630; c=relaxed/simple;
	bh=SckAq/8ZglkacbCo8M+wv0IWE/KtktVB3KLwWlZPwas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sB6avsoUr5fRTmdK4n23M9cUaGiufjqdR6tHAOJneHVVs+rAIRIzmqrrwGCTPyB/HlY2PAjT2SQDOuYxV6quq37S7NaqOZpXUnZYqhwOvhHVATfWa8AdNV1YWPDG+ovpnYvYI1ODhi/pAVaIHfDxIir/u+CfdzjG3i/oZY0klMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4FY+TLE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7076C4CEF1;
	Thu, 10 Jul 2025 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135630;
	bh=SckAq/8ZglkacbCo8M+wv0IWE/KtktVB3KLwWlZPwas=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=E4FY+TLEWIFoEaGzwjpECluLSQHL2YPWu645O2oI2OUSosnp5a8qs5JgUouQRWIgO
	 VmzrOv4ufLRoftNmDfWULJjpqCncmXr15nGqPnHg+98fkA9yQCOPOZy3+6luiatJU6
	 ODVteh5wadsSGXBncHoSo2HHZy/RH5O9QkzfulHn9I11uJSSsa5SyLGHQn14dy7sfj
	 e2Vv/KLgUowgsyeJ0OFuKc+lXyFWkG/kUxboyqjI9ViOtoKy94/jBJw93C3xchjkQ0
	 qjWXNRWsUY6aStFpZ4cP00kR6SM4n/xEKvxlujd96tIbnR4cQJxRAE37xo6CJncfK+
	 azen7rLJ6zr9g==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shuming Fan <shumingf@realtek.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250708184618.3585473-1-arnd@kernel.org>
References: <20250708184618.3585473-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: SDCA: fix HID dependency
Message-Id: <175213562507.707140.12664573653794440974.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 09:20:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-07fe9

On Tue, 08 Jul 2025 20:46:06 +0200, Arnd Bergmann wrote:
> It is not possible to enable SND_SOC_SDCA_HID when SND_SOC_SDCA is built-in
> but HID is in a loadable module, as that results in a link failure:
> 
> x86_64-linux-ld: sound/soc/sdca/sdca_functions.o: in function `find_sdca_entity_hide':
> sdca_functions.c:(.text+0x25b): undefined reference to `sdca_add_hid_device'
> 
> Change SND_SOC_SDCA_HID into a 'bool' option that can only be enabled
> if this results in a working build, and change the Makefile so this driver
> is a loadable module if possible.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SDCA: fix HID dependency
      commit: ad4655653a6c463026ed3c300e5fb34f39abff48

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


