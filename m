Return-Path: <linux-kernel+bounces-884811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F90FC31374
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9674617F8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1A9324B1E;
	Tue,  4 Nov 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlhG8rs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48963322DD1;
	Tue,  4 Nov 2025 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262695; cv=none; b=nz9nn3h4TN0Tlz4ekexFcS8kVLq9s6RLx/oNCzEH+hfrBs3/ETjZysmCPObhh3sJuLSRIOtCD5o6O6sXmMZcn0ySC/81mI6e4fAskFlWCsQIqnIF7LQrcO42DjOsI4iJrUnphYpX2SkDJHSSXsmt+4JgVn+UyuVVU8GVf08yOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262695; c=relaxed/simple;
	bh=V9nj42Wi7bW7hCe/y1Z15WmrLwMFMp8Nr4Vmc+OiaTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hKPY04BXaofXtr3DQ1Uw3tIlC92qchxqkUGKHlv+jRQ6loK+I3898dmMjbenO+dGRUvaT8La2GrKHMKaXT4x3AHsptL1Z7wceynmTh2aBiLcm50CancFOkg2/HJ+zlXYiZnBHa9iDUw2P/Re92SkR1zN05YsLkFhAW9j0ANWQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlhG8rs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33D2C116C6;
	Tue,  4 Nov 2025 13:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262694;
	bh=V9nj42Wi7bW7hCe/y1Z15WmrLwMFMp8Nr4Vmc+OiaTY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OlhG8rs17g7gkVRSxSgVcKO4WX497RFQlPnFk6i7IA8boV19F2D+JsKmXJXn0AxGJ
	 uX3CFEBdU3leh+qc1OvtaY/UG3vSn9uV479hAgDqreYSUKKa+olEahwd29DTzHHIRz
	 HhiOIDAh7One+21kcQsrkzERXBAta9b01XNq/cofbEA/kiZvGQSiTnG/9+reTKsm5h
	 1VPiBx2JznUaakoeHG1K5zlaZntIJKXrrI/VPTqudTMBSvw8YFhu8ZRtNlJF81Et8j
	 mM80nDhyAyPe+uqYizxs+laWEqCYQWrFKpNWSKCe3tECwMI9RLumk6p98QIAtb4Hw9
	 9cwoRgHasPBiQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <aQYKuQuKekmoUrHP@stanley.mountain>
References: <aQYKuQuKekmoUrHP@stanley.mountain>
Subject: Re: [PATCH] ASoC: codecs: simplify aw87390_init() argument a bit
Message-Id: <176226269191.2215600.12276233982702118933.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 13:24:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Sat, 01 Nov 2025 16:27:21 +0300, Dan Carpenter wrote:
> Just pass "aw87390" instead of the address of it.  It's a bit simpler.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codecs: simplify aw87390_init() argument a bit
      commit: 164d1037c4f86828b77a15c9071f051c5acddc93

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


