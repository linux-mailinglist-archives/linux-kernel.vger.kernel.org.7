Return-Path: <linux-kernel+bounces-808519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97FDB500CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FABB1C2805E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E734DCFF;
	Tue,  9 Sep 2025 15:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxAr3SYh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263E7257458;
	Tue,  9 Sep 2025 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757430944; cv=none; b=PlQyhhTSl0J4OHxKIWEq27wvWOgEKGQ36zrsNspx8R7Z26P4JzdU512P5gLMMZMYSNksk+iMDFRkH0FRa9dBY7ZAuRPkgrXXodN9H830Kz+Ry6JtaB/7k6ArU4wlsZ7GNJaTU26y4Vlolglb+SYsVz0RYpNcuP4reoGlUc77sIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757430944; c=relaxed/simple;
	bh=6MLYPQLprIBwnp4Qv84nvYux6xC52Rv+rX5AQz2KTGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AgnSBPiAdzf1/k4/VXvgXmfXq1axJIRirm72jrXdf8atnDeSkmRm0er/iG6gyRVsiRQxnWksnJ6/7k5i7THL0M39GN4zAFackcnkFM9KX2G87PvJO4js9gyaUA1fEdzFxGiMCcz36X3kQDnMePKpLNipRKYLZBAr7hV6q4UKDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxAr3SYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FCEC4CEF4;
	Tue,  9 Sep 2025 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757430943;
	bh=6MLYPQLprIBwnp4Qv84nvYux6xC52Rv+rX5AQz2KTGA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fxAr3SYha/LGO3Q0jpuQ2kzRWrhnT4KPAFD0/9m73KTMgM4L1hUEH7fZ15VrjHswf
	 +G3TPMYe9dVaypD+bh2e2RLhki033mKZREQ34DDUgIEC4rl+EOuBeec2xX0VBQyyfk
	 6UyzXssEzxuYe6lRT81mq2TYRmAt3Q2zXIJNfwRpdmP3mRkr9JcJWZB+aICw/voyD9
	 QjdCvLIZOcJl+wnAjyFK9VMbD1PjWOEDsXPKOeg5+72Tmb3m7M1kgL4UJ3Bp7cwCDO
	 XsrOt7T9cSzcJ3uqXLGBZZoxSgPU2pYc8rPIbdZ0kjv2kKVQQnS1EcrAqFkrWjEvEc
	 w7rdS363ciHhQ==
From: Mark Brown <broonie@kernel.org>
To: Alex Tran <alex.t.tran@gmail.com>
Cc: lgirdwood@gmail.com, shenghao-ding@ti.com, kevin-lu@ti.com, 
 baojun.xu@ti.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250901184008.1249535-3-alex.t.tran@gmail.com>
References: <20250901184008.1249535-3-alex.t.tran@gmail.com>
Subject: Re: [PATCH v3 1/3] ASoC: codecs: tlv320dac33: Remove unused struct
 tlv320dac33_platform_data and header file tlv320dac33-plat.h
Message-Id: <175743094177.224368.14252023546153247015.b4-ty@kernel.org>
Date: Tue, 09 Sep 2025 16:15:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-94e36

On Mon, 01 Sep 2025 11:40:08 -0700, Alex Tran wrote:
> Remove the tlv320dac33_platform_data struct and header file
> tlv320dac33-plat.h as they are not used anywhere in the kernel
> or outside this driver.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: codecs: tlv320dac33: Remove unused struct tlv320dac33_platform_data and header file tlv320dac33-plat.h
      commit: 06aba2126b414248a34b13584f22a78787c95450
[2/3] ASoC: codecs: tlv320dac33: Add default value for burst_bclkdiv
      commit: 960ef523cfe420ae8fdd801f1d12be0fb7ed8719
[3/3] ASoC: codecs: tlv320dac33: Convert to use gpiod api
      commit: 1cf87861a2e02432fb68f8bcc8f20a8e42acde59

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


