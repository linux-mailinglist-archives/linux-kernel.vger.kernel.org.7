Return-Path: <linux-kernel+bounces-863553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF97BF825E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBDD318C1F77
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631833502B6;
	Tue, 21 Oct 2025 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tfzj5ljG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7D34C834;
	Tue, 21 Oct 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072734; cv=none; b=fCW3PWJ0HYnDZqgrL77HOlW5U8CvU4VmslJBgoeOnHnyfBTXe/SvPcAhhl645UKnpKadg6SyRfyZWEwmJ7Zvt5rLwR6r7TWK1+W9sxLFHZ/4956c1lTRBJw/SHJwHsvY9E6qZkBJUCd/ssdQ4Dbe/7WB5tIz8zGkqxpyO/HtWOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072734; c=relaxed/simple;
	bh=jTJGo1a5Vybzx2bfQmxlWwpD2oIUSFEBoWaTwwHmxsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k5o2P/9pAE8EWlT4UIus35BobCtLsMk7fb21ruiwV4/IhGmZ657TQkWeVBUfqvO9U2meTgumesmSxwBYmzEFIEPpGc91JyItmwJY1t2Ne+mozVYTQJsQ0+wkNvYaszXFMVhf0KPTqyv928ifOro99OX31o8oQSk91nEMxyYOYvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tfzj5ljG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1574C4CEF1;
	Tue, 21 Oct 2025 18:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761072734;
	bh=jTJGo1a5Vybzx2bfQmxlWwpD2oIUSFEBoWaTwwHmxsI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Tfzj5ljGWUHoeehh4LAev6SfHTfBfPTH2HrIPoTSAX7kotdFk94Kehfmox0a8gNYu
	 cfLNIDo58gatBuNcR+cUtFMXuLTQD5MzvYPW/69K2z/c2Dhty+XbaCDEv7P2XMzqq9
	 GNCvdLJU95APeWnRnmxN2XIpNt7OYyuNJ4nSEaFyW0vrD3HaKoQ6hxpqhHxwmHeUbT
	 CTvB97sItty4efTg3GTGNpJhwGwmzGhIQOx+e6Xe/lTEpRz8LpV/xL7/e2jXMjEV5w
	 4hLPT5ylExWfokI8G2XUnYmPYZiTHc+WpnoKFE9bCTHgNEyKnWFJJEPykAsyA65uGR
	 2Tl1nYSTYfmuw==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Colin Ian King <colin.i.king@gmail.com>, 
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>, 
 Colin Ian King <colin.i.king@gmail.com>
In-Reply-To: <115fba03-e8ba-4bc1-84d8-7d483c06208c@web.de>
References: <115fba03-e8ba-4bc1-84d8-7d483c06208c@web.de>
Subject: Re: [PATCH] ASoC: rockchip: i2s-tdm: Omit a variable reassignment
 in rockchip_i2s_tdm_probe()
Message-Id: <176107273158.196841.8935507815109050831.b4-ty@kernel.org>
Date: Tue, 21 Oct 2025 19:52:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-2a268

On Mon, 20 Oct 2025 18:23:27 +0200, Markus Elfring wrote:
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
> 
> The source code was transformed by using the Coccinelle software.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: rockchip: i2s-tdm: Omit a variable reassignment in rockchip_i2s_tdm_probe()
      commit: 900da53226121c1e710ca95857806a136ab281a2

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


