Return-Path: <linux-kernel+bounces-878611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12884C2118C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63E764EE199
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95A365D3B;
	Thu, 30 Oct 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qjy1QRR1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD680365D2B;
	Thu, 30 Oct 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840415; cv=none; b=upAkfIk1p/vHmM+YmKdXzOW+4MqyZByyK/djyi701ZYJ4CMHPvxq+zCySooCOzSkdP5lepUC6EBjuoElLC8l6phzqSp8fdXLqjpyZDY1Q1srbfjaudEqmv0e2QWOmdXWjZuFVBnKWcQH5vzntKfQF0KuWyJjPHUNN2cIxEDJe7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840415; c=relaxed/simple;
	bh=vSocyJxmK+C8/VLepflVLh997nUzrmbdX63MsbdhqDo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kKrHgKQlJ5ngnsALJYy1r4L1mrFD6J3p58C1nkVjkTxWatep2FrYll0TS6Oc17U96igxFKrxb03IhP5hAxsKaplPF1tS7r/MY2ZJckCubUJAjSPOXDnf5VQ5RMLYgI5Z8G1NutzKidAH9q+/vTdZze3byQU1Ngk0KX6S47TEMT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qjy1QRR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65F9C113D0;
	Thu, 30 Oct 2025 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761840414;
	bh=vSocyJxmK+C8/VLepflVLh997nUzrmbdX63MsbdhqDo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qjy1QRR1xDd+9YQgRMwE1zjXt3ACLmw4tni78W2Qpd+eCPNQNHseRhc/r3lVgER5v
	 /Kqta+exeOWNTyogoEODm5R9MhTVcjSewWYaIP3mUg+iREkHuVnsJlzFNOBgSM/4K4
	 jwJkqPIinymZ1tEp3FwzRPyGVpIhMEbMKL+f4vgFGuUvnsn5uKw17W6cX+cNJone/+
	 9YWT9OkaV0U3hf4SdREyjdM7dARhLAAI8yrufM2M418tRHVqHakfM5PlqwKEoWcz4A
	 HJLI0J0A/cGT+ug6CVN7JtAkTD5pYq/+8QDeWrtCyetI0wkNqrfhTtmcKWuGwweBik
	 /HB/S3Vfr+gNA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 hariconscious@gmail.com
Cc: khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251030105313.32199-2-hariconscious@gmail.com>
References: <20251030105313.32199-2-hariconscious@gmail.com>
Subject: Re: [PATCH] ASoC: soc-core: check ops & auto_selectable_formats in
 snd_soc_dai_get_fmt() to prevent dereference error
Message-Id: <176184041256.112563.18061585609686605525.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 16:06:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Thu, 30 Oct 2025 16:23:14 +0530, hariconscious@gmail.com wrote:
> Smatch reported an issue that "ops" could be null (see
> line 174) where later "ops" is dereferenced to extract
> the dai fmts, also auto_selectable_formats can also be
> null.
> 
> Add a proper null check before accessing both the ptrs
> to ensure a safe execution.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: soc-core: check ops & auto_selectable_formats in snd_soc_dai_get_fmt() to prevent dereference error
      commit: e73b743bfe8a6ff4e05b5657d3f7586a17ac3ba0

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


