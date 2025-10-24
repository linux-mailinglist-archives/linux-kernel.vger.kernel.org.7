Return-Path: <linux-kernel+bounces-868590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778E9C05961
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1086E3B7EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBBE30C36D;
	Fri, 24 Oct 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7IYKiHt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953730F943;
	Fri, 24 Oct 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761301427; cv=none; b=D1Aq8ecefKP15pu4YdoYj/q2+hinX//zAFvS2GQQUQjF66bVmFCv/1LQVlK7a3dDU7zpaGJTfKwzIj6ZdKDgwfCBwP0OHMjF60/4G5qvfLIeoC3NRmxtxi0UKmnU3HV1QsrA3uUfVAZOxvb5cJ2FeTFs3Jmorv2wYJvX2pIg+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761301427; c=relaxed/simple;
	bh=Ljvetg2fVYvsV5S84YIrfw1dMOgbHyndFwdWVn8d3mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gLSeEpHpqRRdaPag04cLEG3TgenrMIcFJll0aia8njR1+ww1UePzXVKfdUVm53RFjDsU5hMvtfE9ep7RgbMyVt1mk9pdAPCkVbMTvz3rSgkE0niF/Je4BDdAH4oazsP2NYIoI7rHLMYRqOruWszW3Q9WTsp3GybIyjvdyAGzt7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7IYKiHt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE4EC4CEF5;
	Fri, 24 Oct 2025 10:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761301427;
	bh=Ljvetg2fVYvsV5S84YIrfw1dMOgbHyndFwdWVn8d3mg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P7IYKiHt9bKO6xANQumPQiKBSyuwZS6rgRk56fpsCRcYavXuyODYaXKRzaNbn1PyJ
	 mSB+P0QEnf10WG5fgqxrzpY14nZXcH46+GcAZDeEKnexGx/A7/2n7scgy7/mCBULsx
	 0r/1nH+Rz9ULKMg0TJM3c+FDTR+ELvFaP+enB2omwpGkz1fSJJIUbWHaAJhJkKWbbu
	 iP+FteKzElN8XpUAVW7inGesCPX0EvpnqVXDLlXT6WROhKY+mfbrSKpfr/RZojxrc7
	 bFlj6GYnCIavZSSojPtpTKbtOAeU10eiHm0sLvz8VZReZulCfDEOoGuOHSMMbMJy7+
	 lAtRR/QdXE+LA==
From: Mark Brown <broonie@kernel.org>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: yung-chuan.liao@linux.intel.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20251023110824.1587-1-rf@opensource.cirrus.com>
References: <20251023110824.1587-1-rf@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: soc_sdw_utils: add cs35l57 support
Message-Id: <176130142568.10077.8554790639434736675.b4-ty@kernel.org>
Date: Fri, 24 Oct 2025 11:23:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 23 Oct 2025 12:08:24 +0100, Richard Fitzgerald wrote:
> cs35l57 uses the same codec driver as cs35l56.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc_sdw_utils: add cs35l57 support
      commit: 61eb4112a8fbed999e3906a6c35e0731cf688c43

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


