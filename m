Return-Path: <linux-kernel+bounces-764621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C6CB2253B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F721B61D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA82ECE8A;
	Tue, 12 Aug 2025 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh0PtAk2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521A82ECD24;
	Tue, 12 Aug 2025 11:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996701; cv=none; b=UU9jtgRKPqxcv9D51mqx0zJ+U24NTrt8lE6vJ96ad/PUwjmNyOrxGwRKBYhwcRc0Z5AtU6ZeOaxOgSCKMWnG06MKj8kIRdNLlqGm9oLIJogVW2m+yCrysEGuJaRt8f8aGyJ/UrYX4kRxSLPhevQE+ddJCDRuEW9ucW+LdA6//F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996701; c=relaxed/simple;
	bh=BVqReh1ZaFY764W9cXwxnQeIdgLpg/NBqDuO0BvLoSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W3jKZ7QOJpjRb1CBh7W1Uzbkl+CFlVdCWoT9wSDUgh5G9Cs4ecQ9usRVJSZOnPWHYLD7tpS7UmFzkbVsAwMAQeKkRG3LVzQS74fnf+kvKAQfzS4P/On369GtaPYL2UMbx08yx5tq75pZn38GrFe/Jxz5f/cG5Zigr7JHnkZjfY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fh0PtAk2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29501C4CEF0;
	Tue, 12 Aug 2025 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996700;
	bh=BVqReh1ZaFY764W9cXwxnQeIdgLpg/NBqDuO0BvLoSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fh0PtAk2K5F8eFq9y6vWQFodqoAOBOJiaGMw0sVTsVn4TbxtFy4DTLiMLpSuswHP0
	 2PQOVEZiZadQnl02aDDcnWbHrtvhk4t0KemiMTidEEPW6PFqobLvSObmMndvXIln2E
	 VpujjTA0MlXIC7Qv0pJgV/bVU61aDCTI//uE4BEstjY0XpqpM9i1RIMPLpE8JbvqA8
	 7uQNVAW/KyAqK1ALsZBO7Cboqiw05k4DgghAoAQ7QUTkeWUhwhkcG59XfapqI9qqHb
	 1Yye+5I29qnf5ECM0njQBKs0Al3f4zV4D7fHluAxVRyxJgi0DTsn5cwUkYzAd6hgtp
	 ZEVcXbg/ccHTw==
From: Mark Brown <broonie@kernel.org>
To: david.rhodes@cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250805090431.117114-1-zhao.xichao@vivo.com>
References: <20250805090431.117114-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] ASoC: cs48l32: Use PTR_ERR_OR_ZERO() to simplify code
Message-Id: <175499669891.16031.14694358981864005208.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:04:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 05 Aug 2025 17:04:31 +0800, Xichao Zhao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs48l32: Use PTR_ERR_OR_ZERO() to simplify code
      commit: 3059067fd3378a5454e7928c08d20bf3ef186760

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


