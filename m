Return-Path: <linux-kernel+bounces-746029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 956BEB1221A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F26D1CC69CC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F242EE97B;
	Fri, 25 Jul 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7n8Lob4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6389C19E83C;
	Fri, 25 Jul 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753461387; cv=none; b=po6wUnsJ3L8f9/jgQfEK7IISmyugts5lYUbNfE2hA5SvVRSvzoN2KQEh0toXwqsCpft3H/eXQcg9L6KKsYF0CXatE+3vZ9thinw+5zV/k+8p5KNBAt9xKwIJ5l4hnIGIVg69IMj0aHiuLbMWwBE52Dd6gb3AJ9clUvAo1jRK/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753461387; c=relaxed/simple;
	bh=68PGpsj8IBEIaD9t411zbBjvKONR3sSiUZwE+hcOFMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y6b+cCxI3oP2YUr5xjNle4yp+PVJw6k4z0Hgba9GbLgKI9rN5a0QvlnrYk/y5CgewqPwfVD2dCCmA8ELUIPCHrm+PAFUzHTCYM/pdcjE94MKl+oqpDbej3rNS0eIh7GFnIbPuzL8e4Wh2sg/SFEuaViCN04tWTPn3cBSUrJ7QM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7n8Lob4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B50FCC4CEE7;
	Fri, 25 Jul 2025 16:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753461386;
	bh=68PGpsj8IBEIaD9t411zbBjvKONR3sSiUZwE+hcOFMU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=B7n8Lob4UaouthKw8LI16Xl5vmrvrF3iw+Y0RGWmPiDWj2LTEeDrJ2EP+YmGl1+xX
	 TxFmAgCVxIOug4+91iq2VMDQPxb6hLdqfwXPx9kU+Nqo2naDwTaVcg1WHtljenO44L
	 1D6tfyoxn4kIS6ATWH5G0Pv9sPCNGON8hn8XURAF7NgV+GnFRRr03F3owzoVNF6lp1
	 DbZ55mjlLWNVK7OV4ZGRO+yqE6ylwPJ+EYPVBxTQZIdtJTzP4NHottBbGjeXTkSPNg
	 aDmWXpULkPcr+94ElHWMgdA+6ZyaDl5n2nwN2cbaHB0PsCt6Nf3BPXmK9uxGJnXI3J
	 I9mlVucZAZqDA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 zhujun2@cmss.chinamobile.com, thorsten.blum@linux.dev, 
 colin.i.king@gmail.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Cc: yijiangtao@awinic.com
In-Reply-To: <20250725094602.10017-1-wangweidong.a@awinic.com>
References: <20250725094602.10017-1-wangweidong.a@awinic.com>
Subject: Re: [PATCH next v1] ASoC: codecs: Add acpi_match_table for aw88399
 driver
Message-Id: <175346138441.1147425.11453205352684074445.b4-ty@kernel.org>
Date: Fri, 25 Jul 2025 17:36:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Fri, 25 Jul 2025 17:46:02 +0800, wangweidong.a@awinic.com wrote:
> Add acpi_match_table to the aw88399 driver so that
> it can be used on more platforms.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: Add acpi_match_table for aw88399 driver
      commit: e95122a32e777309412e30dc638dbc88b9036811

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


