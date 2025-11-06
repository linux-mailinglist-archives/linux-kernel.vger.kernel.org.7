Return-Path: <linux-kernel+bounces-889556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 433F3C3DE6B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6EBB4E9E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F7A34FF54;
	Thu,  6 Nov 2025 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpsBLZeN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57762350D41;
	Thu,  6 Nov 2025 23:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473254; cv=none; b=NVuzPTqys6Nj6ToDaIBViqVdpN4XFsTjQ2yz2cYQ++ROzS73HehQ0fXu1EP6kA8cn6zrMOWrG0cGmhDHQnIjRTvi5gHM2Xv5X8X0DVRJOcm1n/h98lGs3Vu4rd2ZpynDCadYee3E9q00egXGW0CsPlnSZgvfoslJj4DXC8yOYpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473254; c=relaxed/simple;
	bh=HexTXqxPy9J7UFc3P0dMfP2fPpyqwGnH3MErC+t6RHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GgAfm88I1wCd9Pnr5NyFTXF93XOSZoOGol1TlXyHDyXuSYpBQ89myCGgDUr/6xAo3v3CLKDWqMmV8iCwaEFFN0UYJPZma4jSaWUazH+9MJcbObZxmfiIhX68BYGJEf7FgR+5U3upl0lOQrK86rFeep4Ngfl6QavvzxrEIhSGFfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpsBLZeN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF44FC116D0;
	Thu,  6 Nov 2025 23:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473253;
	bh=HexTXqxPy9J7UFc3P0dMfP2fPpyqwGnH3MErC+t6RHU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CpsBLZeN/fslUcyyCjcFmo2RpE4mQeWZ6aa3JC0Zt9t4i8uIDlHl5pJkQ8bJ+pNq1
	 dCBBDQMyw/ao7l+ThmzbTQCVnYpNK2C9w+Y5Y9yI8+o6/dvq3WjKVWxE4OCZYbWQJ8
	 LuV+wdhn7zpoGxS/3d0OWrTQFtjQ8q0Rgt+3J2/VHDCfM9/HFNp6SkDwPHnaa9XdNE
	 OautGgO+Wtfpb6wqgAGF0nZaK+FWrzgsr4aFOw8axBvitzxFZTD3HeFBeWwDoCxfpt
	 XQUuSi4pPcVNIfSbkYmeBRofNuBhcUaeIhxOx4BWqrM1GuDnlWYX62+oQXlK0f+DeX
	 TMniRZIVcWLqg==
From: Mark Brown <broonie@kernel.org>
To: david.rhodes@cirrus.com, rf@opensource.cirrus.com, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, Haotian Zhang <vulab@iscas.ac.cn>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251105062246.1955-1-vulab@iscas.ac.cn>
References: <20251105062246.1955-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: cs4271: Fix regulator leak on probe failure
Message-Id: <176247325048.2482911.2102661420037899891.b4-ty@kernel.org>
Date: Thu, 06 Nov 2025 23:54:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Wed, 05 Nov 2025 14:22:46 +0800, Haotian Zhang wrote:
> The probe function enables regulators at the beginning
> but fails to disable them in its error handling path.
> If any operation after enabling the regulators fails,
> the probe will exit with an error, leaving the regulators
> permanently enabled, which could lead to a resource leak.
> 
> Add a proper error handling path to call regulator_bulk_disable()
> before returning an error.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs4271: Fix regulator leak on probe failure
      commit: 6b6eddc63ce871897d3a5bc4f8f593e698aef104

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


