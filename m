Return-Path: <linux-kernel+bounces-863554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DBBF8264
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147C218C21EB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23F1351FA8;
	Tue, 21 Oct 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXSxSRno"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470934D904;
	Tue, 21 Oct 2025 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072744; cv=none; b=GqxgoZgKD7hZYu8bhA/cDjhMGjUZIecu5Dkwq6uai8Q6i+I5180fq1U4xlgTGbvG6FkAYzHWmFDqYtP09fZo6t/QCp6Pai6RI4qWlb4P5W10t/FXSkYbFeIVw7NKS+AP85XxQumIxjPEiw/ROX8IwWS+sfJAjIIwm6n7vrJKooc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072744; c=relaxed/simple;
	bh=eqMg6jFMwqPdM5lNUE1xHVGWVzzrn6YTlyIqQLKmAQ8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dnCp4nMqnZCPLLDgLBmCVZjnWwnYersAmkSHQH+jXultMkXBzLGHRInZtU4CormyvPkl8LNBHg41aqEVo7fhEewlo74cbO0wIWz3ZtHhINkc0vWacvdXJ8DFpoMQTay0q+a7/6ZxTuyed2KZaYIwKa/vaFHPXMnnMphuJ6Hvidw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXSxSRno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD29C4CEF1;
	Tue, 21 Oct 2025 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072744;
	bh=eqMg6jFMwqPdM5lNUE1xHVGWVzzrn6YTlyIqQLKmAQ8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=LXSxSRno4MvhDebRqnJuAX/apEAeV7rtpL4n4H6eOn9okI4zQpHymxXmEH37+RkFO
	 nNLV1Fd963qbVFT5vbRn4M2SQfu1zJQlItyPluGA9ht11WTC/kMd63q3ETd3eGyepD
	 L1mzUh17DTBvBVcgNCTVW2fPtcDyUPCG8/UUvKIro2E2UFMkF+92WKCiqQ44D3cOBv
	 AATuKvNSDRwHoflh8PDAvkrOOH9j9ODn7H4+rc/+dSGa62ewOUwDIT+gqgCU3J/au5
	 e1mmfV3mVGBwL/BbkkYXNirIkEb1IG2CxINRPxWS0wl2pn03shA4wh7741f+VDaDte
	 quHK597YDX13A==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20251021090933.3470495-1-shengjiu.wang@nxp.com>
References: <20251021090933.3470495-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_aud2htx: add IEC958_SUBFRAME_LE format in
 supported list
Message-Id: <176107274177.196841.9804075994703178765.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 19:52:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Tue, 21 Oct 2025 17:09:33 +0800, Shengjiu Wang wrote:
> Besides S24_LE and S32_LE, the IEC958_SUBFRAME_LE format is also
> supported by this HDMI audio interface.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_aud2htx: add IEC958_SUBFRAME_LE format in supported list
      commit: ecba655bf54a661ffe078856cd8dbc898270e4b5

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


