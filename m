Return-Path: <linux-kernel+bounces-873958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D616EC152C7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2217E462BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3273396FA;
	Tue, 28 Oct 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHrQwhd+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCA328617;
	Tue, 28 Oct 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661641; cv=none; b=hqyMBg0xMZk0mrKtYnclqFzqa6z67TqJtlJ6cRjrLiUTzRKW8JdYl0HbhBAJFzZ8AOoANokILSH+U7awogNq9+So2uZqATky2NjqvG5rIZQKKdamLiK/fi9MdjvoZNiS/il6uvJpK+VSoC9htm4aW4Hvu5iIr/7TtaGCQ1C2Cls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661641; c=relaxed/simple;
	bh=Cn66l1Qv7QjpRmpmPqFbyHZ8IgZjug6npKZkYfw0VHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Wmfb03uR72vyK2blWJUPSfu0qO21vs7CLw2V4iKDRPljMzWOZnmjTiLwQeUptntnf68j0Wy9nOrDqDhwgyWw8+ggG6V813UXGGw/fL0f7P75lTM3p107w2iTu2ouGGwe7qUCBFk5ypFPqsDLpK2KN751O9GTaVw36DGG0nj6D+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHrQwhd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F9CC4CEE7;
	Tue, 28 Oct 2025 14:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761661640;
	bh=Cn66l1Qv7QjpRmpmPqFbyHZ8IgZjug6npKZkYfw0VHA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mHrQwhd+PzR/b3pxlQI+F1llOntM62cttQaXI3GvFNREK6BEo5W0yR3kJfGZK87XR
	 xosWHtAjqW8GVdplELPfzR5Qd6HzoirYUYX3twZbOEofe+PV91r2i/V48D+5CfMHHF
	 faVkvKQf//RTmjkThW55csDvGue8GPBa1xWx1K10SfHy7jaaNTNM8V6+eCiKkMnZqD
	 AeVXCts/ABgAYv+iah58sHhpx35uIxILzs3Ik9z99Viazd7FuNav9WI45Nmi8C55i/
	 3BtYV943DTZCXQHYuj/9uiMcdtoRC6qhZvyHAbPsE1/6e4BFGW7LYSXz3RaWFvse7a
	 DyXD/szXZHO6A==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Yixun Lan <dlan@gentoo.org>, 
 Jinmei Wei <weijinmei@linux.spacemit.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20251028-fix-k1-i2s-v2-0-a547c15ed5c3@linux.spacemit.com>
References: <20251028-fix-k1-i2s-v2-0-a547c15ed5c3@linux.spacemit.com>
Subject: Re: [PATCH v2 0/2] ASoC: spacemit: fix build warning and error
Message-Id: <176166163771.85877.16889963338170505917.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 14:27:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Tue, 28 Oct 2025 09:32:08 +0800, Troy Mitchell wrote:
> After the i2s patch for K1 was merged, two issues were identified:
> - Missing error handling for the init_dai() function [1],
>   which is required since the function allocates memory internally.
> - The Kconfig entry ignored the dependency chain of DMA_CMA [2].
> 
> This series fixes both issues.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: spacemit: add failure check for spacemit_i2s_init_dai()
      commit: f034c16a4663eaf3198dc18b201ba50533fb5b81
[2/2] ASoC: spacemit: use `depends on` instead of `select`
      (no commit info)

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


