Return-Path: <linux-kernel+bounces-886399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F8C3570C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F25F94FB1AE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039D93101D3;
	Wed,  5 Nov 2025 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fi6jhYeI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA5F30F80D;
	Wed,  5 Nov 2025 11:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762343035; cv=none; b=Z3acRkXQhDFez6Ru4xbPZA3TQdV78eLBltUiGkpN4wYu01aXbV1R/jGD09DG+vrdohpNGoiJHLlsc3eXMdYlwDgNmtWesGx9XOoL1S2D4YaZMoShdCW8Id9NtF0IKgjt6j/qa+mpxry5eYm81kOs9zP5VT84KQLZtoCOPELI6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762343035; c=relaxed/simple;
	bh=GQ+ObrRyg9ornm+HOtGZCigymeSFO3TCh9lPuvFGW0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tmAwUpVRprCteTXu8EiNvkGnKqYHId5jkdo6IonBnr/K5qHRgESQfAwSe9E0SHa6vzHEn3Rzo0sjiT5cv6B51ayrq7J9yQ4rAKoXOl9VMxa7Ys80zRkOI/DqYyaVJUehjOrN8Kcgx6PfjYhWyVYHIG5Bvp7qAtfQKOcpf7lrPJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fi6jhYeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D00C4CEF8;
	Wed,  5 Nov 2025 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762343034;
	bh=GQ+ObrRyg9ornm+HOtGZCigymeSFO3TCh9lPuvFGW0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Fi6jhYeIpqknc6/1Bn2EZlXzdSGcf1Ly+OILqPqNlk1xgNQVO6hEErMM2kJFDw4qy
	 xpnl+7HtjfFkpZWOZWAjyRctTGb7xawxlN8ZyB7EBGkOkmExZxKZ+dpMehQJpKA2N9
	 i5S7e4z/DzYCexMash2f4EROw8zcaPX2WkHaFIb3sQVdoAzOStn2jt8WUFxUSxCR9Q
	 0eHOVX34IPWiSe8SNocBmebW+D9rwkAS/6lUfeAaDygACazF6sSK/u1LxyAoZTxPTE
	 wdp+MuenqNW8sPkktMywpXvXrAWwMP/xX0STgNYuH1cAVRcDKrEZjUSTVwlhSXOOAE
	 3vPdsfW7WraFA==
From: Mark Brown <broonie@kernel.org>
To: shenghao-ding@ti.com, kevin-lu@ti.com, baojun.xu@ti.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 hariconscious@gmail.com
Cc: khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251104054257.9953-2-hariconscious@gmail.com>
References: <20251104054257.9953-2-hariconscious@gmail.com>
Subject: Re: [PATCH] ASoC: tas2781: Replace deprecated strcpy() with
 strscpy()
Message-Id: <176234303118.2251668.5368163491744892647.b4-ty@kernel.org>
Date: Wed, 05 Nov 2025 11:43:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Tue, 04 Nov 2025 11:12:58 +0530, hariconscious@gmail.com wrote:
> strcpy() is deprecated,use strscpy() instead.
> No functional changes intended.
> Link: https://github.com/KSPP/linux/issues/88
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: tas2781: Replace deprecated strcpy() with strscpy()
      commit: 3b071bdd26849172101081573a18022af108fb21

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


