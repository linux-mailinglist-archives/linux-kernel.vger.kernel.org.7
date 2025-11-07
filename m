Return-Path: <linux-kernel+bounces-890708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86211C40B85
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 331E8188B418
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B7932E74C;
	Fri,  7 Nov 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLUJ/idf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE14A0C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531180; cv=none; b=DX4DStPG09X056QBqsA4uEoPYpHs/DfvMP3H42RNO1zxrjANDicrO8mgzdoH5T43C64Sd6RvQAuUwPc51bOKWZekliUKhVB6bECrpWNuSlhV96D56GrQ3pBvo8zlMjePaf9umY03wVw7MluvL3zsfnHHCM9s596/QJLOyzzwqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531180; c=relaxed/simple;
	bh=CutddtJdxTwBMPiBCGqUeSQ/z6FRLzP4zZy5fTdyK7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IierYS2aRoE4/59KNpkLAER4hcd01OkSK7qSlcRqdhu1up/cUlQCRYnREUbyq3nO4JUZsMlhZF/4Mv+UFrNY1Nebfum9mxTdw19wsf00NanJdlOLG9dt8Vkzs06SG8U17wCwDBY3l6kGKiySxZ1l+sQECxFAFpJ7MjxfhnIN/Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TLUJ/idf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A247C16AAE;
	Fri,  7 Nov 2025 15:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531179;
	bh=CutddtJdxTwBMPiBCGqUeSQ/z6FRLzP4zZy5fTdyK7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TLUJ/idfKTLc/iAjQNurzsGK1lWtnQlcdJbDFIX8Mk+ipdDi2vKPAdI3/v0FMg3FF
	 W8KjmWKoEVDM3rzuX5WCkYKefvW7OOa4I7aOkojVmoMEmVQnRfDHVG3DeJ607o+o4j
	 3UpP7Mq9PaTtn4K6xw6Kz/oJnzWeOEJpZFE+gVqrw1bTaY+eaeABGC/E559P0uzmDo
	 QiOzwGmNakFraaQgRcXDz+X/ThnupkdgnTn2yVEWN7304gKf+w8Azj2mhDziLUzOfr
	 yrPt2HI8rjdBGND4jh5JmqatfeRkK6xKRAH/aMffa4xZSPo3+e0TtRJMzbBRa8OeAp
	 MU7E/TPDxP6DQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, Chen Ni <nichen@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
In-Reply-To: <20251107085109.2316999-1-nichen@iscas.ac.cn>
References: <20251107085109.2316999-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] regulator: mt6363: Remove unneeded semicolon
Message-Id: <176253117500.2510929.10700935899599839032.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 15:59:35 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Fri, 07 Nov 2025 16:51:09 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: mt6363: Remove unneeded semicolon
      commit: 2089f086303b773e181567fd8d5df3038bd85937

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


