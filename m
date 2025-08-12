Return-Path: <linux-kernel+bounces-764632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C89B22556
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F723A5A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C432EF66C;
	Tue, 12 Aug 2025 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTfoyzgO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BE2ED151
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996740; cv=none; b=I/pnhTQjfgqVzaNsqICdToKpFSGIbakUds/kIj3rPgxebjsmIBPsJQcrv5UZrH066farNAZQWkppnAIMAlZqYEdlhF8lV9vYxHqyp5UGM6evqWfjItlZbXH1nOQWD6sLmqeCeynyQ0gp30zrKdtaBqZn1F54nscF2ckNV8xCSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996740; c=relaxed/simple;
	bh=2cUFhLna+InO0Uo3BDah2CW0KE/A0VIzKG0Q/8MMW/M=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=syMJPsMUzcUsyIiYVlvpAo2d7U6zaDefS14+UxmjT8p92IzAo1ZXxFy4bBS0NAsZLSjzZI/9eQRRmZ+SGpVNttgSKpUQdPQHogm68PpqwsY9grnd5avXLBKAbLvpZcGDwLlaTvySNqDUylelbRY3x7CJPwd1vfzZE6Pp+P+cgC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTfoyzgO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7492AC4CEF4;
	Tue, 12 Aug 2025 11:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996740;
	bh=2cUFhLna+InO0Uo3BDah2CW0KE/A0VIzKG0Q/8MMW/M=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ZTfoyzgO9p1vOajz4E6JjxxItDTgsm6YIT3G/KJv9XlHRPmI/OM2GyjuXJ67+ysg3
	 IY+YoSi9dyRKYmdCyLuiVCQ2UBmNhp0JXKjr1vlq+ISeGQi5gi3CPpcDmhF/SxxYl5
	 3Jh6aeIYrqOVzkA0YglT/fmA2OcWTecq7mYu+sJp9x81gvn8syQkUQIbBMmFQVAa3i
	 sOJHPlVuABzkl8jQdW5A4poGwCBj5VRvN1pwj526HkLmNvHwSoz9j8Uo9GJZeqspNc
	 L5SsNWAyb1JQ23cfyz/LY4qfyW9HfO3eoCUIbuJVstbbgMD25RmkZjf2Z0XrKPPMKt
	 Q1Ash7abK5yGg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <20250807123949.495193-1-liaoyuanhong@vivo.com>
References: <20250807123949.495193-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] regulator: Remove unnecessary memset
Message-Id: <175499673922.16220.2125715399762886540.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 07 Aug 2025 20:39:49 +0800, Liao Yuanhong wrote:
> devm_kzalloc() has already been initialized to full 0 space, there is no
> need to use memset() to initialize again.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Remove unnecessary memset
      commit: f6cc4140e161831e5796f099f5abc3af953ae2b8

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


