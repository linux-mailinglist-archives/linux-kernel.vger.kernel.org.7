Return-Path: <linux-kernel+bounces-764623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3303B2253A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6375B503E02
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2214D2EAD15;
	Tue, 12 Aug 2025 11:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksO+RRwk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F832571DA;
	Tue, 12 Aug 2025 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996708; cv=none; b=a8IbPo2WRZcYeAw/bXS7iAKqNzwY+ZYfUiAW9+n8M5p9ntCKqS3SSFkvzyL2+rhPYwOiekHSGKOLYuPRppHCUhSFACoOmzI3o04NxBXGsKl4C2XfRVVibC3jnhIAPqErue2huxuNYnFNRXbee9Q1jfJcEOPAbYjFBJgtytXMi5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996708; c=relaxed/simple;
	bh=i83FLRORzAWaY4/0VoGrVVs4sujsdhDnKVLh/tbKi9w=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XysUf4SIULKYT7cuETKQCljIttZ+BcypTWm6Kzqm6IjtBbpSBEvxYsNsj9I9gwJwcdE2AWGS0kvCkol8d6lRmvmM7KKdLwDsFVkH4zKB6OaPvUT1i+tOTOkUl+gkTpEGwIBYz+/2ew3qCuSIoCpDuu9VH3YGZ/LXrW6/UM5wtVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksO+RRwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B503C4CEF7;
	Tue, 12 Aug 2025 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996708;
	bh=i83FLRORzAWaY4/0VoGrVVs4sujsdhDnKVLh/tbKi9w=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ksO+RRwkquDBtc2qSEkIsY/W/9oVsvewgkKCETs1psFyO9oYhSWYxdccqvf6GA6in
	 HRkUSrLa5aLliSCE+jS4ZD+DF2Ch3QEcYdz9L6Z2lPAYVDTX2g9vEWRV+c7u/7XMlW
	 yt4zdzN/jPn8++9RuiOKa8bKh96MRVDp+JA17/WN6ITyEKRR3fG2+46XUl1MWjmLNZ
	 o3rh4TASDUNFSuORrZa/O2jGsnedZafT5ftzABpJlPWkTGzJtfwZ2A5JKLihQj6r5K
	 puX+wAbXHxgfPaWqy1H9ZOuucI/LyDeRKV7hIfmBzbkkWj0OVN9qAxnRfl36G0rqsP
	 pqf8DydXndMRg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250807020318.2143219-1-shengjiu.wang@nxp.com>
References: <20250807020318.2143219-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: replace regmap_write with
 regmap_update_bits
Message-Id: <175499670591.16031.7607194509968600371.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 07 Aug 2025 10:03:18 +0800, Shengjiu Wang wrote:
> Use the regmap_write() for software reset in fsl_sai_config_disable would
> cause the FSL_SAI_CSR_BCE bit to be cleared. Refer to
> commit 197c53c8ecb34 ("ASoC: fsl_sai: Don't disable bitclock for i.MX8MP")
> FSL_SAI_CSR_BCE should not be cleared. So need to use regmap_update_bits()
> instead of regmap_write() for these bit operations.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: replace regmap_write with regmap_update_bits
      commit: 0e270f32975fd21874185ba53653630dd40bf560

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


