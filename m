Return-Path: <linux-kernel+bounces-884812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4830C3137A
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5F4610C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5073B3254BA;
	Tue,  4 Nov 2025 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9FAST3n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4585325480;
	Tue,  4 Nov 2025 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262697; cv=none; b=AcgqQ5HHYgcliMoSKBYQ6bAm3HCmqg9J+fxkYjcI22SupYufLFbVspCIKeFwbCyIHQ1dcs1ACRDBJH9HnvvhfOmn1iTUHYmEq71UVLcZV+yrnih1SStGi2Liw/zT+CzOPM9lJd3JGfODMD3G/lUZO/j+R4v98ju5TfdXvATldFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262697; c=relaxed/simple;
	bh=OgT8GX4BTKq9o4++Ukknmcl8Gkeh69TUQ/5cGTM9a80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AcxWsvqe6LQClcRhFaj1dbXotZWOjVI7YmQZMIaNhi94S4KMOCH6TU82gyv8N6LyHPCsPEbJjDrkhZpFA4JkQ7cwfvk/T8H0JYNrFIqtH6fMsqce5L/DnVcKvdVq8Tmd6FFYj3VZY5kxr/dRRm8hALm4HwruQz53ppoS3AKTXxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9FAST3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E442C4CEF7;
	Tue,  4 Nov 2025 13:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262697;
	bh=OgT8GX4BTKq9o4++Ukknmcl8Gkeh69TUQ/5cGTM9a80=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P9FAST3nOnvRCM35LKxG51aiTKotgZW+aaknZOjf0Icbvo/JjdQ24fucz6HKAjuUN
	 zEzNQxntkCHpr2zwK8MU1WEKOKGEb7TLm920t8J8acm/9W+zoSjE5G6HEjw+EsaUVv
	 YvK4m+++rJsMcNvrV8gYRJM6dssSuPbqTM73J/d4pYTkNenqqRr1NlAxHtLjzWYRNh
	 N9F4vUR3z0RSQOoe/RK6wZXgIWUthZxqH4/bS7L6Bt6EC/irdqUJEl62ozGmbozwb9
	 KzKn0QVct9nPQ+9rF4hBzvix8bbX/U3JPBpuLmF+v03T8buy53meok+ID0oFTlYkrS
	 USWJDlJP/mpOA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>, 
 Marco Crivellari <marco.crivellari@suse.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aQYKxl2f-zGVdYFC@stanley.mountain>
References: <aQYKxl2f-zGVdYFC@stanley.mountain>
Subject: Re: [PATCH] ASoC: codecs: aw88261: pass pointer directly instead
 of passing the address
Message-Id: <176226269445.2215600.15081607722114405841.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 13:24:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Sat, 01 Nov 2025 16:27:34 +0300, Dan Carpenter wrote:
> It's a little bit cleaner to just pass "aw88261" instead of the address
> of it "&aw88261".
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: aw88261: pass pointer directly instead of passing the address
      commit: 84194c66aaf78fed150edb217b9f341518b1cba2

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


