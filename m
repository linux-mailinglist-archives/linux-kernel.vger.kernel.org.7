Return-Path: <linux-kernel+bounces-769045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E994B26943
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCB1F603028
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 14:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D01D63F3;
	Thu, 14 Aug 2025 14:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSUrnGOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29BC1C6FF5;
	Thu, 14 Aug 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755181131; cv=none; b=mgyrQo6t8oRHfiOfzPGcoqRJUSyvkNu4ym+31YmCkm3tni82uP2MKTjYCjJck1/pBWWRrOU+RYXOFFiqh3pDfDH5OrnKWK97p+VYGMACs/Ez5CR3jRLcRSuO7FyJw1srCqY4dKdBbR7G0/kR8/2yw+Qn8u7MgZiAK32grZuwbvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755181131; c=relaxed/simple;
	bh=5VVaX6Df0uT1DngpkCmnJlSyCeUn+2FHDvtom5mKH0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KulKOtEdyXbFR6ZZnH9dKtTk+JPgQUpl6VtiRKOvMrwUpsxOzBnC5aDaqcPkT7VUnPEB4FCJszTKhs4rsfPCOIawwg2tNpJzSilXthyOGu0amfrpGqufh6maeUkTWNIEfRx/lDt9p599Hu/1X0EsxXeDCRVQrmLYIETU8AdTE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSUrnGOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1A8C4CEED;
	Thu, 14 Aug 2025 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755181130;
	bh=5VVaX6Df0uT1DngpkCmnJlSyCeUn+2FHDvtom5mKH0Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RSUrnGOJWcMK9UW+ZcsivKKXMsc1HofFnQHJat5gVp6im02jN69TfA85CjCdcerj9
	 puI5VxlBdsM9uU/kN2YdDhZcQ7hpYupVLNBdBAo8uY9bCqH4GnPbkymD4AcoQipw/A
	 zK/exDyFD0yLH/b8eR73RGqfU2ef0tr/KG9bo4ld1m3/Xr6QurbOKJxDv6LShX8AK8
	 S9XuUe5RtId4sMuGkwb/+9QUPwffFe0v8fKrRMRb0CC0PBdcav4ogA/fsRqxb5zjUn
	 f0Xd31PEYgFsTmYt6EdH+xaYRj+CD0MOSYfHQR1Dgg6LSLYlDCoXSeos5hriFOjXZ9
	 U0hW+KJVsJtVA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250814073326.17644-1-colin.i.king@gmail.com>
References: <20250814073326.17644-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] regulator: rt5133: Fix spelling mistake
 "regualtor" -> "regulator"
Message-Id: <175518112938.48229.7330207318440344704.b4-ty@kernel.org>
Date: Thu, 14 Aug 2025 15:18:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 14 Aug 2025 08:33:26 +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rt5133: Fix spelling mistake "regualtor" -> "regulator"
      commit: 6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d

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


