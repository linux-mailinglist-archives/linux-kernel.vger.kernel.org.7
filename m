Return-Path: <linux-kernel+bounces-776618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0966B2CF97
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8632A6066
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 23:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E72231830;
	Tue, 19 Aug 2025 23:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtNUdg7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D44353377;
	Tue, 19 Aug 2025 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755644594; cv=none; b=ohSe0h/wRYbPlhpqQ+t+V4orcojbcsG/ra/ADvc5MBFQDBlIKBdxuDrJ+RGVnPoG1ROjkNKJ9aBQ2z4boF2RFIBWXbHboom1RAsxA74rK4IygA18GpZtXgFbhN7ZppKixtkuVk3f0WJiDn9facA0rcDoix0Z5A4rz5NHZ/Jkx+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755644594; c=relaxed/simple;
	bh=Ixf1JrBTr7/vnBjVCGUxiZ3p8HV6MKyK33odXby8GG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ADkPqKG71cF/ougypYlp56zS+i7wRT04Hn+/DXnHnEL092FxqwB3BGsKinGfCbkZatzBkQmyVCloLTHMPjefv/OyGygW1LepUh64QTHUl2d1NjZqq6lCQQrZjVlPeDJEn3OCiuPNGudbYINTQ5JbHbQQZuPJLaZAVKnNjMUk1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtNUdg7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A681C4CEF1;
	Tue, 19 Aug 2025 23:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755644593;
	bh=Ixf1JrBTr7/vnBjVCGUxiZ3p8HV6MKyK33odXby8GG8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JtNUdg7NqQm88XpHU+egXs5vuX5wZ8ShuIhmqcbwb+s7e1GqltjsYaF6N6TaCAd/a
	 cm/zn2rbu5eEbwkXLb+5B37kbQuadyZiA5qE3I5FxdlMYSgpOa6crWMtaxfWgOUej9
	 OKh2q3JTKYaeAO3gUYhga4a0NNzBETL3W25Ct/AoRhbXaQ3itKg0IsiVmMFrMCZlOu
	 M+bKS8v+t9GCgn32Z95LFVGiqeFkgOTigsFgHjyzKb4UrkWhChnhj8ybDKpxgoxBu2
	 ypXS++d9kx85s85z7bpnulsjMNuHJ1rvxKAUdBAh6Jtgk94iqV9ycGTMmVUFFZvW+5
	 dPzKMw/KGTcSw==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, 
 Zhang Yi <zhangyi@everest-semi.com>
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
In-Reply-To: <20250815024729.3051-1-zhangyi@everest-semi.com>
References: <20250815024729.3051-1-zhangyi@everest-semi.com>
Subject: Re: [PATCH] ASoC: codecs: ES9389: Modify the standby configuration
Message-Id: <175564459128.355815.11034514640865008612.b4-ty@kernel.org>
Date: Wed, 20 Aug 2025 00:03:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 15 Aug 2025 10:47:29 +0800, Zhang Yi wrote:
> Modify the standby configuration
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: ES9389: Modify the standby configuration
      commit: af24c20c4633a667ac5b5e20cf9d96f6176a0ca3

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


