Return-Path: <linux-kernel+bounces-764622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823D8B22539
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FCA3A5232
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7EE2ECEA0;
	Tue, 12 Aug 2025 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qidwNdk5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F2E2EBB9A;
	Tue, 12 Aug 2025 11:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996705; cv=none; b=knLlIfx8iIEduOCpR77/4YcpgywT5g0k+A1k01RO3GvTIUd6jPItF7ueESX+2OXD6cBU/7cIx2uT0dqZKhlq1aCW1qHknmP8WsHrQgDLKdr2t1D9gb+tNyXUnqlqleeHVCCjeAx0fWWPGDEiebho+22lA8caeCjNVK3d7st123E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996705; c=relaxed/simple;
	bh=+sjD5DBMwZ01KvsXUAV5SJn+sj8/ohUTnEVYWG/4NUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uhLA1c031KcQZgu1JjsvdqSocIRV4K/HcFjHX8WbMUSca90viWBafeaU3J78KK40y+P5JxEid7/wPKdReDfMHdAUPaZu3jlfTQRr7QMN7Yq4coosl7tKT5HouKg3LXLKfFaeIo8TjVRRUOF8s6TPbxpEjiMVnBjezm4U0jS+8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qidwNdk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443CFC4CEF4;
	Tue, 12 Aug 2025 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996704;
	bh=+sjD5DBMwZ01KvsXUAV5SJn+sj8/ohUTnEVYWG/4NUM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qidwNdk5LLHuh+RkonL10l5tIMuz1EL1iLZsnU6Y4QMR9aGNbmkxH7776FpFuodKp
	 lFELFbWkzrAVpLNGIBxOEgpd5P1I4Oe3lhnyQpWxcckU3Lda8qEusVUL241OWOoVSd
	 R8vI01bQF4eogEX9fkP2VVWKoSZsjvE8oFWxQaZkySPQM7dYCXtMLPZ+AdRq2Z0Vd+
	 UdD3wEDzneXPBzyQV/EEIrdC5FzbbqrjEz9u63C49Q/uE1nub1OMh5Jsz6IN9I8Fl/
	 1ZdChx9KQyQRCsVIpqIGpF0Ma9ajCc60c+ltAWQ3YlwMXN73/vRK8I87rwaBwbKbuQ
	 LkM2p84dzj6wg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Waqar Hameed <waqar.hameed@axis.com>
Cc: kernel@axis.com, sound-open-firmware@alsa-project.org, 
 linux-sound@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <pndpldam7tf.a.out@axis.com>
References: <pndpldam7tf.a.out@axis.com>
Subject: Re: [PATCH v2] ASoC: SOF: imx: Remove error print for
 devm_add_action_or_reset()
Message-Id: <175499670102.16031.12835450413879680065.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 05 Aug 2025 11:33:32 +0200, Waqar Hameed wrote:
> When `devm_add_action_or_reset()` fails, it is due to a failed memory
> allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
> anything when error is `-ENOMEM`. Therefore, remove the useless call to
> `dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
> return the value instead.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: imx: Remove error print for devm_add_action_or_reset()
      commit: 9d6a51651faa577e5d2be9d67915b7621c5c589a

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


