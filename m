Return-Path: <linux-kernel+bounces-610171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B41A9316F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 07:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790AE447BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 05:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25192268C50;
	Fri, 18 Apr 2025 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqmRi236"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0242686AD;
	Fri, 18 Apr 2025 05:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744953947; cv=none; b=a9sUjntYRuawQDHLb43Telr/zMY352S4tAaYoH3S9wpZFcd7e0SRwhznWdXiwqf5CWU3dX7qeZmw4otiGjYMi2UpXhsmxnGnm0o8RKVia4lI/iKP5mUDMim/mSG+XjSFsJeqbZEXpshzbiyMyw6a9fRH7Q/HcdroDAxQyLLtxLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744953947; c=relaxed/simple;
	bh=3ycu4SVEVJphDdSWmpQ0hhT1PNOc7FzyrIzTFy3KRcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ufD/1/z1wUvYoAfhqJRZM9LGFktDOHfp2+uYE4N10QfjJhIzgTFbKP6bo7/15nlxdwPETOF+2wXF4Dsc7PAblwnW6Kg5LcjSE3d6MgesEba+7HyEl5VH0sH9wZUSJJkfWjctGvcRLS1gJNk0N+dg7WLpbpTnhRoMKjdgc18AEWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqmRi236; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D1C4CEEB;
	Fri, 18 Apr 2025 05:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744953946;
	bh=3ycu4SVEVJphDdSWmpQ0hhT1PNOc7FzyrIzTFy3KRcE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BqmRi236yPX9q0A5XJS8Eb+GAn+OIevR413q1ih05vugGZOOccqHW7IMfLVMeOPcZ
	 Ppa6I+tWNb2DpqE7e7X4k2aOblY7D1fgBJApTIOz8cEZ268aPek2BFTLrtUMOpJ5bg
	 D8YpNNK24bMp6Dy2gnkOjTClITPfRFVU82fQzeEz10cpIKIbTeg2U+3P0x90uvTbKQ
	 aDhlVDOEGgK+A+M3GO/Kj8jsPZ5Mg1jKojSNMRHbktr9C8chImdfK6uCzG7J71Nfpy
	 eAZygwLMlbfy40zPWBRsqOR3qyJy6DZaNDLY1SmDIkugJ0cHHapLhZ8UIuocly/B9+
	 kipHGa7waNIfw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
References: <20250417152529.490582-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 0/2] spi: Introduce and use spi_bpw_to_bytes()
Message-Id: <174495394579.356683.10284081275062136675.b4-ty@kernel.org>
Date: Fri, 18 Apr 2025 06:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 17 Apr 2025 18:24:45 +0300, Andy Shevchenko wrote:
> Recently in the discussion with David the idea of having
> a common helper popped up. The helper converts the given
> bits per word to bytes. The result will always be power-of-two
> (e.g. for 37 bits it returns 8 bytes) or 0 for 0 input.
> More details are in the respective code comment.
> 
> This mini-series introduces it and replaces current users
> under drivers/spi and we expect more (and possibly some
> lurking in other subsystems).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: Add spi_bpw_to_bytes() helper and use it
      commit: 163ddf1fea590229c30a8dc4c29ff4febfb895c3
[2/2] spi: dw: Use spi_bpw_to_bytes() helper
      commit: e30b7a75666b3f444abfabed6a144642fa9994d8

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


