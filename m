Return-Path: <linux-kernel+bounces-856203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA7EBE3764
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 070E44FE483
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B883314B0;
	Thu, 16 Oct 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ9Q28+M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F389330D53;
	Thu, 16 Oct 2025 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618532; cv=none; b=IUa1WtWCiF1fOIAozl1Q5Gs/XbmrjZtvEPGZPqF7LeqSvQr98h+cQ8GNjSz1JxsqI7CGaJ+qV/aQTy4wl1Lzipu9jV+Ebsvcz/mFGHis3yRUu58f6CL9I6Z60KZh1vjaGppXO69PpCcX2dzfJC4BaUpaIalliYH/RmORv9sDHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618532; c=relaxed/simple;
	bh=n/TdvkbOHG24o4n+LpNGwRe/RI1k+Osr1HNMAn/RDxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QvPvcjcdy+LiHNHubAjvRdVlMOncng43fuNZxhvvJKP1erM95d4tzFaw99gb1a5/GwDeHiOkiBWde6/D9wDfvXOu1oCS/qGrVr0IN2bekiwa3y4h33nEW/jyUUZkS9liSct6ss0zmnq4KC0qsaddJzgNj2jO43eebostpGjbEXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQ9Q28+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EE9C113D0;
	Thu, 16 Oct 2025 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760618531;
	bh=n/TdvkbOHG24o4n+LpNGwRe/RI1k+Osr1HNMAn/RDxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pQ9Q28+MhCoJVaSQE7JwcWAcx9lcNkCkMOtldDeUAdre04GXPpaaACYcEufzYb8Jr
	 LVhnaSfZfzpFo11bxmQr1PmI/bhDEjn0yWUUfemufWlM+RZKwdV+YTGYlN4AMvM8d1
	 +0BCv72QMZe1uGpl5rdKSF2E+3DlAiwVygyc1YoUlfkPG6wT8sWXwoLJwPZpRNnr55
	 no5SPc3II9Fpf0yLH+je08GRqwlmabN1iBOCyFZriGexhhuYpbwdIzRgwWnOk9yfLO
	 qaiuwZhhH4cLZoYbEihLIrD0vYHwqpidhPak8WcEdLg0qq4Y+XxwcZgGlzRjhBVk67
	 U+mtq7MnZtuKw==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Alex Tran <alex.t.tran@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250929004625.1310721-1-alex.t.tran@gmail.com>
References: <20250929004625.1310721-1-alex.t.tran@gmail.com>
Subject: Re: [PATCH v1] ASoC: codecs: rt5670: use
 SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
Message-Id: <176061852987.55339.14552254610555727404.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 13:42:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Sun, 28 Sep 2025 17:46:25 -0700, Alex Tran wrote:
> DAC2 L/R source selection fields (MX-1B [6:4] and [2:0]) contain non
> contiguous values due to reserved bits documented in datasheet (page 66):
> <https://www.elinfor.com/pdf/RealtekMicroelectronics/ALC5670-VB-
> RealtekMicroelectronics.pdf>
> 
> Switch from SOC_ENUM_SINGLE_DECL to SOC_VALUE_ENUM_SINGLE_DECL
> to handle discrete values.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: rt5670: use SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
      commit: 6621b0f118d500092f5f3d72ddddb22aeeb3c3a0

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


