Return-Path: <linux-kernel+bounces-745030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E246BB113E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A401CE43BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9D423BF96;
	Thu, 24 Jul 2025 22:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1Ek78Qf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86F3233739;
	Thu, 24 Jul 2025 22:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753396134; cv=none; b=fNqA6OnAGeZ0awNOYBqlHxQSp0SRJIlsD6fJ2sK36CcmgR9tilJi1CoZxQVLHy0ANw6XkdSBb/ZzUiJG9qZi+cPu6JWdBexX4jrxMSQSh0Yp/K4Gqriz8/UCrCH7QfjjEovZy+2xb/YSSRHF6L+LBCHXBV+b9IuX3ZDpqz8+gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753396134; c=relaxed/simple;
	bh=6UkftOwnWcxhW5u2uOEGRNPfwKgOe+LwjHtv4z8eR48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iZN8ONJ9KVtYxt0Zj7AQvwFou6SJ9I4S5BSIa2cLmcGAED1GN9LQaA+Afo/gsBSbclJiCBSm+2QxW40YOSxbAiXhKGSNqEmiSzE4N+vAehd5hWEn7atw1F7xB2F4JtvHODEkLsXE3zx0WygJk4yXcMaZ1+FWfIyR3teowV8fWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1Ek78Qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3C8C4CEED;
	Thu, 24 Jul 2025 22:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753396134;
	bh=6UkftOwnWcxhW5u2uOEGRNPfwKgOe+LwjHtv4z8eR48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=b1Ek78QfqtZjdMROv13a3MI9lk2CQb/ZFCPsYltjPEztgLPfASrf3Xm8j7KCVtDFI
	 EMFM3YJnc0GXsXo+fbfc7t8Ain1WcuUUDNgXu9Kvoso/OnGvEMRMo+mmkz7qIXP2iU
	 k8RGxvNDx8PBNfsMvwFQMcyCIqKPonowa+stBQnBmX53chEsl0hu9oNTb3GDs1MMkI
	 npTz7BPnFKg5vu2b5Wdz/wrS/4F2o5phZaHBb2eYDuRiFp44dvlPAiRRmXTnhdGyYW
	 lkxfsoaD38OD7egR8udMRgbLPH0VlIOfkzGMc7EptWAHMuklKzvV2b4c0kOMB83iIi
	 gqCesMrV9NcfQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250724114832.146718-1-colin.i.king@gmail.com>
References: <20250724114832.146718-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] regulator: mt6370: Fix spelling mistake in
 mt6370_regualtor_register
Message-Id: <175339613258.176873.9240561400072710018.b4-ty@kernel.org>
Date: Thu, 24 Jul 2025 23:28:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Thu, 24 Jul 2025 12:48:32 +0100, Colin Ian King wrote:
> The function name mt6370_regualtor_register contains a spelling mistake,
> fix it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6370: Fix spelling mistake in mt6370_regualtor_register
      commit: 0bd042ae771d61ef7ccd5882f7aeca59a25f71d9

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


