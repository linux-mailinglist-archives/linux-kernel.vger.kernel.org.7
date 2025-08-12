Return-Path: <linux-kernel+bounces-765003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D17B22A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 16:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DEE1BC4B59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 14:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D13C2D028F;
	Tue, 12 Aug 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSELrmNd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6A6283142;
	Tue, 12 Aug 2025 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755007500; cv=none; b=R0f6rjgI4UkxISln+mM7PMIt4nfk5Ri80ZGQpbrnLoeMTbHcm3sTA77eHJIHJq3cYlxGRz4j70vOemdKf+XN8qVQzRPPHpIcYHX8EcHiz3XzaVhBztXlJiqN5kMNSRM6LoG8MwYQZTZjYZfqe52tWMPtixnYI8ZLDOJlywi90hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755007500; c=relaxed/simple;
	bh=iV0sAQ3Xj3AOnKogGpasLdyXeXQH0sO/pDdrD4YzyAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DDNSQWV2qEnty/HCm2zs/dMWAhjk3jY60YYLI8/S3JzSLdY5SHvpr0313roO9Vs2OMUQowmt7aTszGXm7Ms2jHA9X4k4y2hnV0IpknIOXq0wZHbQavOeWuGurfYG2As2UmhOMrXE+1jZUiabQZz8p9ayMFHnTNz4QfPxZz8t9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSELrmNd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F139AC4CEF0;
	Tue, 12 Aug 2025 14:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755007500;
	bh=iV0sAQ3Xj3AOnKogGpasLdyXeXQH0sO/pDdrD4YzyAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hSELrmNdz5MbuLy734d6l5RPypBn+nT8J9BMtH9dEcI6sBsxJ1w12jimwnIeP/Mc+
	 dE4k+we6PaiUsZ5B848n/70xVLFHEIWUGANPDimAtF30wybT8dwJ7Z975c8sXJ5Zvi
	 Ap7gHZi5WQyrV+2q+GzUNjW9QxBlTMXRdtgJmuQPA5WkquCrKfzfZrWVJr4fUSbFM+
	 pyrXXNbg0lsGd7J9fbeRYI0IbK1UYaRYU3BRBqG3kFhKMAz4BQW1wX7Hl9yqnx8sJe
	 bEN0Q/5w2QQjLDzY79H558ELams+v7tsF3EVnPYqzVypSjsnz0CKLq9iMltO6BTM6N
	 P7xOS4GmojVPA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Weidong Wang <wangweidong.a@awinic.com>, 
 anish kumar <yesanishhere@gmail.com>, 
 Zhu Jun <zhujun2@cmss.chinamobile.com>, 
 Colin Ian King <colin.i.king@gmail.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250810214144.1985-2-thorsten.blum@linux.dev>
References: <20250810214144.1985-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: codecs: Call strscpy() with correct size
 argument
Message-Id: <175500749772.80402.5028150232150193610.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 15:04:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Sun, 10 Aug 2025 23:41:05 +0200, Thorsten Blum wrote:
> In aw8xxxx_profile_info(), strscpy() is called with the length of the
> source string "null" rather than the size of the destination buffer.
> 
> This is fine as long as the destination buffer is larger than the source
> string, but we should still use the destination buffer size instead to
> call strscpy() as intended. And since 'name' points to the fixed-size
> buffer 'uinfo->value.enumerated.name', we can safely omit the size
> argument and let strscpy() infer it using sizeof() and remove 'name'.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Call strscpy() with correct size argument
      commit: dcb82900b12f5809e66835918d4043284ce1d39c

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


