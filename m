Return-Path: <linux-kernel+bounces-725212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF01AFFC0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC1E1C4478B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B0E28CF4A;
	Thu, 10 Jul 2025 08:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ti6DJ4Fs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D9728C5D9;
	Thu, 10 Jul 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135634; cv=none; b=rcQ0mOE/KVNM0NuJKpmyRJByaajcTHv0B8USVnvJto3qJmwK2tdFDGM7DfE/BqeAq9OzS7Me6Dd/lYPfRywDGW9eP22ycag5CuK8YI+7vWF2H7KCzDlxVBAcG9R0cBIcunF2ldkFQ54EYanW/1NyjPDbNKnphQkax+RMGzstHXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135634; c=relaxed/simple;
	bh=SqtRfeiUXcib0SH8ipAhyDaU+0NUvYEUF7Xt1ugMyns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gjc+BcFdKOV10oQaYTfbjCAdrM5FKmYsAgLfbaY9HZEJDV4onsJj+Hu3XzZmseF6n1toLdVmTxkYwDGxv5KmGcFCGHmSbKx6GJRXuR+0Em/tNTD70Q03JAihR3QcyPLzAglWTUOgyFGDtR1sSygauU4SVep+dKcZBaWNi91ZXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ti6DJ4Fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF10C4CEE3;
	Thu, 10 Jul 2025 08:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135634;
	bh=SqtRfeiUXcib0SH8ipAhyDaU+0NUvYEUF7Xt1ugMyns=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ti6DJ4FspcZcJJJ4Rmyv73TOHLxdaNHaKYr6MAxY2IsjGTI5Eic79rauHUkaQe71I
	 9qQd0iGUypZ1gtxC2/VwT3u/gkgnwAGBf78Bv2ztdanUAFMdEstN0uh5mmbIQ9Faon
	 WeUk83vxurZiSoRTuQsObS9ilrzX2a3KTCDyGcEo4YYMvjNfKl9SOlFGW/1vuqo8Pw
	 Gu3+qrzKr25YfzVhOeZ1i+Hy71DoZJ1K23clt14L+YBX+nCSj1P02Tc9PwSAQ8mknu
	 zdrXFfsp5OUi9UkwKU9ybMuA24inOxd+/aqT6b6JQOOjC53REQ9Pc8FhZH6z+EvHMq
	 LIomg0NS8khKw==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Shuming Fan <shumingf@realtek.com>, 
 Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250709152430.1498427-1-arnd@kernel.org>
References: <20250709152430.1498427-1-arnd@kernel.org>
Subject: Re: [PATCH] [v2] ASoC: SDCA: fix HID dependency
Message-Id: <175213563013.707140.7674050291151836280.b4-ty@kernel.org>
Date: Thu, 10 Jul 2025 09:20:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-07fe9

On Wed, 09 Jul 2025 17:24:17 +0200, Arnd Bergmann wrote:
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


