Return-Path: <linux-kernel+bounces-605446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF90A8A14E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 16:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34A93BCE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD09297A6B;
	Tue, 15 Apr 2025 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn07Cnu/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A434B28BA8D;
	Tue, 15 Apr 2025 14:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727822; cv=none; b=ssXnhkM7N85fZx11yNOAlGeFs9zGOQLg677vmCrayhrgyd2NJKtNy4WxfLaY+k6SELH4SJqW2Gi3Jb34sFSz3syyNlrRV4BbZO+y5WrRsQlpNh904t5YUn4gopIe331dqzZpfQnwKX+ZhT9fgao1WPSoLqLgctz1wQf+yikh5vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727822; c=relaxed/simple;
	bh=TvQnWFwdFpnb9SYNTlS+cB5AlPbPdOfp9gzg8DWDZWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pPcnV57JMS0z0X0t5e3XIQCK6bAzh7a5ATy+LVbNhjc+OJV6lnDIf916kylOQD6Dr9Pc1aSvFoAoKpEZndYip5YBCm5CaYos22RgBXeLMlhWBsLrJ9BU5vjWSvy/+B8DluNYDzGP+8yskRhjWLKEk28FLZbzEuUWPJO3DxFN6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn07Cnu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195B3C4CEDD;
	Tue, 15 Apr 2025 14:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744727822;
	bh=TvQnWFwdFpnb9SYNTlS+cB5AlPbPdOfp9gzg8DWDZWw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Dn07Cnu/kFBVXv1Hr2tWaO28RVeoLvd4Fil9vomPeVAg5bMrmE7mR1SVX2XhyX9iO
	 6VtAuaklZf9XVZpWUge9CpluAaK9gXzZYVG0IJrWKuk4w4koupzqLa6950XbGFGm6L
	 2btuLdnnaLAcOTNaPCKykNKwulHlhm814Snyt0Au2cY/s3iO8PobHdC0TzDFrriML3
	 S36Bd881s5cEQH0mLdjJXcBVAUpsTBOMdQAyOg6hvclOFVKjx7L1N5k7qxZ1Eqxg2U
	 zEB7lV7JODSsMDNRQMQUhwTbL25z2JfZ/Ip9QiPz3M3Dgxk4YVtT/TvgziiaKfPpU/
	 rH2c556UD42eg==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-sound@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250415090354.92211-2-thorsten.blum@linux.dev>
References: <20250415090354.92211-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data
 with __counted_by()
Message-Id: <174472781982.130155.12727122291223637995.b4-ty@kernel.org>
Date: Tue, 15 Apr 2025 15:36:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 15 Apr 2025 11:03:55 +0200, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> No functional changes intended.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs-amp-lib: Annotate struct cirrus_amp_efi_data with __counted_by()
      commit: fcdf212fd9b36c299d90229e9546c077db2215ce

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


