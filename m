Return-Path: <linux-kernel+bounces-834476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C8BA4C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D861B23118
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE77430C639;
	Fri, 26 Sep 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMrpzE0K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28930A945;
	Fri, 26 Sep 2025 17:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758907537; cv=none; b=UalUfGbMcpj/DOWQZtHCJOXZ3QIEl5pni5AdFhwPCI5Hj5OH1hf7v5YsFTbfI1mEGzBbT1/+jqCTeypmWruf0hXdWlVjDwOh1Xiw2HtT31oGG7EhdSikK0gGoR7pOMwAcNyRBxCP1M/ZDDAZNz6/rmKz5ZaeeZ5FD4QQ+DUlSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758907537; c=relaxed/simple;
	bh=EQ44jFvikMIExluQ1Di2kzZV3iLJT6KNd6LLMZM7S0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nYhUlmh0mk3PCXZCCDAHmwc2HvHUCDBPPvywvBTU+vAkv7OIPAK8n7rt0YZ9sopTqIpHS6PX+vkmunNej2GvhpL/i/YFvzfcwCPQd3n2Bfd4zOWPT9VxJfhRmn6sEVH8K406idIrOJU0tr0UAuigoTL0lp6cQWpoDlwqtznYpmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMrpzE0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85378C4CEF4;
	Fri, 26 Sep 2025 17:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758907536;
	bh=EQ44jFvikMIExluQ1Di2kzZV3iLJT6KNd6LLMZM7S0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HMrpzE0KVFpkJAvdOaEE8KEBxNuuFMCU9wihD60auOrTxEHW6ioy2G0Z4u1Y5AIhE
	 W+qIyaQ+ofRcEopRxO5/2Yv0pK7FAVcmxyYYV++mWLBkPfffpRsP4iZJjcCYU91Xky
	 hq4+xUlJz/rHehtgCcO/q5iUXGP6CWcQw5GOW59UsWodccd7G8Sc3zdfo+E/u0J5Ik
	 a9HxkRr1VqOe+aTXNO9rtU+tF2qzsYSNFMwyePNB4lKOwnZAqOyr3PMzXJFNNSUwlX
	 +ufro9O9sTyFboovWXsOiX5Gs1Au8LokWqezCu1B/xs5ZLiRF823h5/Fq0lbmUwiUd
	 CMfvkhFIBBCfw==
From: Mark Brown <broonie@kernel.org>
To: Niranjan H Y <niranjan.hy@ti.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aNYQf4cyavnku5Nt@stanley.mountain>
References: <aNYQf4cyavnku5Nt@stanley.mountain>
Subject: Re: [PATCH next] ASoc: tas2783A: Fix an error code in probe()
Message-Id: <175890753427.2509416.7801317102009548908.b4-ty@kernel.org>
Date: Fri, 26 Sep 2025 18:25:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Fri, 26 Sep 2025 07:03:11 +0300, Dan Carpenter wrote:
> This code returns the wrong variable "tas_dev->regmap" instead of
> "regmap" so it returns success instead of a negative error code.
> Return the correct variable.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoc: tas2783A: Fix an error code in probe()
      commit: f8b9c819ea20d1101656a91ced843d9e47ba0630

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


