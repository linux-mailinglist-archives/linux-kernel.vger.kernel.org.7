Return-Path: <linux-kernel+bounces-854228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F732BDDDD4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BAB3ACCDB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591A13168FD;
	Wed, 15 Oct 2025 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGpQ39kE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA931C57B;
	Wed, 15 Oct 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521801; cv=none; b=HzvWOue4SV97hvUoHGO4qnlVAgPLYHehfMF1A+wsryIAQtDFREH1Dlv7Mj+niNAuUq+9YOQutdFipjH+7ikSiTo1oBLsVKNhsFcJS4XWxSCNrEbNzxW4QN1hre5DeTJJJD8Cm7vKYBFsi/ErTZ4FRRRYqYz5R39xEhrsFrGt8Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521801; c=relaxed/simple;
	bh=Y6fDlzkFZiguUrcB+UOV5ITtIY9b2JCQdg/KjQL8nZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KwR+C6AOXgjizAs0Fe/TYgeig9xapvjqRMzANVJl9MGMLd5YrHNTl0XkvbS7v4i4iAS0rEzlCSjUv8ph4Ik8XSJhSK9Kium+wlAUpV7MLME3rqaIhRFSHPiOukfcWTINHdjWoBvpaGl61wW1CWJ8oepSaqdAbUoWRBevYt1KW6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGpQ39kE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBE2C4CEF8;
	Wed, 15 Oct 2025 09:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760521801;
	bh=Y6fDlzkFZiguUrcB+UOV5ITtIY9b2JCQdg/KjQL8nZU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=fGpQ39kE+GR/r3gyEq22kJF+jSMSi1b0KokFPzqQkhu1Kri/qbqEEE0vyTQhgrX6m
	 POLlvgssqc41maXK44+mGl/Ij04fyIeAGrRmkEYLcezvRiCi1vzYmwH1Lb/gxPX6ap
	 00/Ya3opMmfWtrP4LWllJltv839PdbxdruG42ZAW9YqduUUmJHypsyCSlexd07qFMj
	 5KQtgbVVk+u9vhKItyiIv9AbBqSCYr/E37Cm1DnGADNqC1hPw0sAZtr+7XktNzsNbV
	 h89+bzlK+S9lAIDQ+Py2vNjOfE+1f/R/5nZnwSY29aOezsdWBb+PhMO7idcmlLhvDR
	 X5fQTDFMGORVw==
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <2bd547194f3398e6182f770d7d6be711c702b4b2.1760029099.git.christophe.leroy@csgroup.eu>
References: <2bd547194f3398e6182f770d7d6be711c702b4b2.1760029099.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] ASoC: codecs: Fix gain setting ranges for Renesas
 IDT821034 codec
Message-Id: <176052179962.20166.8388125443789822839.b4-ty@kernel.org>
Date: Wed, 15 Oct 2025 10:49:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-96507

On Thu, 09 Oct 2025 19:03:13 +0200, Christophe Leroy wrote:
> The gain ranges specified in Renesas IDT821034 codec documentation
> are [-3dB;+13dB] in the transmit path (ADC) and [-13dB;+3dB] in the
> receive path (DAC). Allthough the registers allow programming values
> outside those ranges, the signal S/N and distorsion are only
> guaranteed in the specified ranges.
> 
> Set ranges to the specified ones.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Fix gain setting ranges for Renesas IDT821034 codec
      commit: 6370a996f308ea3276030769b7482b346e7cc7c1

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


