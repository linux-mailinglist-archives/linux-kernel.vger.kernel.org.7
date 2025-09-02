Return-Path: <linux-kernel+bounces-796310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41BB3FED5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0264A3B20C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 11:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039603002DC;
	Tue,  2 Sep 2025 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC7JCwXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0672FFDF7;
	Tue,  2 Sep 2025 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813870; cv=none; b=PW4iOMxhLfqj06HykMdTW94o+0aI9miSh89HW1IG45UkCfkK+l7Rofvw+Dci8WbeeVzsRvp2Lo4vdDyYA7Q/mVrtYBY0fMGHt2FI03zoaqCVQFJfrBbLepKjO24GBrQsUG1CNrI7nadJxfJVxKoE7fNkyisAlK0YfhKAay7U9JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813870; c=relaxed/simple;
	bh=Ug/wWUINd85myksx78WxXPqysEphL175GhQfhSFnuy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ebAPK4ls9Wl2DIhFjZr2Z5XH8ax3wefgTsWF16QuxVz03hBD3lRXL0eurM2uO0Bpoh5C9g4NZyKAhGtRaIyXF54Gq+ylVpInZqtX9I0S7IdLzPc1A8jqtaPGaFSsWNXEtnOwpYArpP5V6RWpxAbE+eW2aarpnTyiB1I4KVJgDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EC7JCwXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73824C4CEF7;
	Tue,  2 Sep 2025 11:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813869;
	bh=Ug/wWUINd85myksx78WxXPqysEphL175GhQfhSFnuy4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EC7JCwXODM0nM7nuTlj9s4n7nMZ0EMCVMovF5YB1C1Hx7wxZh5PycNCOBK8Q2zdXB
	 7QFsKI9/YOlqbB+HTmI/gY12fsWx3HYgqOurHbf+N8ab66TXCDy9m0Ykfb1fxufXl8
	 huyxPCv8pzavRuj1BcZMWbfoDGCku/w2LXpZ4QmGnoCsBNtN/bYyktSBM/qGcZJOgQ
	 ti5QJ6KSkXyjb9FK5ybi4qx8DEuZooTbm4IHtZr3h+NMQ0NPHEjYAw0Udx501nk8CP
	 wZezcoOpP95Bc+pArtMq735/OShpDMPPBroySTVEMsKKtYnOnSmYgdEKSpbylgjhhR
	 7l3G4dOTG9PrA==
From: Mark Brown <broonie@kernel.org>
To: Kiseok Jo <kiseok.jo@irondevice.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aLGjvjpueVstekXP@stanley.mountain>
References: <aLGjvjpueVstekXP@stanley.mountain>
Subject: Re: [PATCH] ASoC: codec: sma1307: Fix memory corruption in
 sma1307_setting_loaded()
Message-Id: <175681386702.70970.9510307338795400264.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 12:51:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 29 Aug 2025 15:57:34 +0300, Dan Carpenter wrote:
> The sma1307->set.header_size is how many integers are in the header
> (there are 8 of them) but instead of allocating space of 8 integers
> we allocate 8 bytes.  This leads to memory corruption when we copy data
> it on the next line:
> 
>         memcpy(sma1307->set.header, data,
>                sma1307->set.header_size * sizeof(int));
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: sma1307: Fix memory corruption in sma1307_setting_loaded()
      commit: 78338108b5a856dc98223a335f147846a8a18c51

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


