Return-Path: <linux-kernel+bounces-884813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53679C3137D
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C2A461AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79192325736;
	Tue,  4 Nov 2025 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovtupvph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC56322C66;
	Tue,  4 Nov 2025 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262700; cv=none; b=fK+ZRsTdYMug+OOu5/zY+dvusAtPGBOXb3lV6u45/010fLjk/wXJYETLfEkH6z3BJouyQ+ofs5zsVc1yLd4V0rOe7W8CA8vNeegD4eVpZW71Aa3vejconjsSaKxFIwrOaULE3LoGrRwkKTwoqQh47PVhSZmQYnnmoFnAYjsUm1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262700; c=relaxed/simple;
	bh=Y38eEqKX315O/hK8GM4uxaI+ySMw+eyVY1SFmRr/Zgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fbUK7m+mstcRVfB0lTSGWNe1isN88AFIXm7lT7/fscHSSJ82gl/WTBnSOwChDI359tSFlKa+jmRzovR8taoj99OYkM7LmaqzJaM7qaGgwWfDXmdaGvau0ZDCT+fxgktoz+nVBMQR0QlQkbsbbj+IwIPE+6bYlIq8rGiGyvsi6No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovtupvph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E12C116C6;
	Tue,  4 Nov 2025 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262700;
	bh=Y38eEqKX315O/hK8GM4uxaI+ySMw+eyVY1SFmRr/Zgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ovtupvphRvOwowH9up9y/0B+7TVWAXgjx2SZCYu0TOyZ+UmdQUhkZyMVY03x2m7BX
	 pt6m2CLV6Le+opzwJ0BKV3LE/gQ4+13sbe7EkP58W+GWgytfhYoNYvsZdwbFo4c/wO
	 zzDuk3gcIV/T9bqXHf6GfyeLCXis5mR1s2/AeJsz+20qnXRKKtfyYDfJkDfzDNpNQB
	 tH6E792kgbrxRHYahYlCN1wvFKmuJeeelv/VF6x3FYNW7OEqUka2jsUyseELJX9V/1
	 aWI36NxsQ6n0mWox3WgitZMadExXZQlrsNK/iD4+wPTCN7WbAhWGrx450mgYLDjBhL
	 kzeB1mmTRkyjw==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <5fe08f028395a6c6f50d11eee8fdb4a90b1f68ab.1762151503.git.christophe.jaillet@wanadoo.fr>
References: <5fe08f028395a6c6f50d11eee8fdb4a90b1f68ab.1762151503.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: fsl_spdif: Constify some structures
Message-Id: <176226269713.2215600.7013778287587240101.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 13:24:57 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Mon, 03 Nov 2025 07:32:03 +0100, Christophe JAILLET wrote:
> 'struct fsl_spdif_soc_data' and 'struct snd_kcontrol_new' are not modified
> in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Constify some structures
      commit: 1a88479436a52452429f6d50ec5bd0a546406485

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


