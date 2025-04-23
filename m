Return-Path: <linux-kernel+bounces-616389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6766FA98BD4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 15:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B7E3A70A9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 13:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F5E1A316A;
	Wed, 23 Apr 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsYUVthQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986DC195B1A;
	Wed, 23 Apr 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416175; cv=none; b=o4HdzDEHJsz11KMCJDASG8bNhoEI3q51fwTnNE4yJAloWkBtxg+xYQFV4RGtMwX5une0UD+2yBdZ8UIsy+EdkeHy05XE9qK7yerBsI65geG2ma7898nSX0+O9DWhPtCTA0w02mBFHICgIMCwxBBwgw1MFSCJrWS1926fwnveqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416175; c=relaxed/simple;
	bh=51DzNBedmVdDOpjFygbR61HRvxMoCnaWd7SdEKWH5U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=POjpwaDO1UniEedpbOvqvC3kIHmojrLpezhfnig/KH1ZLUJ1+cmOgfZ5jud5moUB7LC4R7n7qYpzjwPqI66yCfZkxwSzCosUojUKGgd9x8L3m61SHrVOiIB8Q2ExenvggyzxcktKYUzGBhWv7ptXQcalShWHuG6AmwpfVyhiV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsYUVthQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B660FC4CEE2;
	Wed, 23 Apr 2025 13:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745416175;
	bh=51DzNBedmVdDOpjFygbR61HRvxMoCnaWd7SdEKWH5U8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EsYUVthQn5eHDBFy3F8hJkdSDHW4eKpE5otGTPgLVwME+gCj/LVWJ7F9K8cdJpFgv
	 GfBvdOIXH/k0wueLLhbj/+xM/HS6D6N5K2vyQkdYSYbLWIUtYTSAtHQ67HYiVsyN4O
	 +lW8aOZcUFB0I7HrerlPnuLytk6swOjTuz7K0EEQTaLjmmegh6pk+kJFsqDXEzU7oF
	 ra2z1uY/nrDBxxkZ/bkha34OjIudJ9yaMUfX9V9mL93Szus1nsRauA8mAi+YdBBhNz
	 sc0LYLJ6LY4GGIa4mJdQeQ42l+trtUFa73ufHNNeMz+QzIT98myHaS4IH0siGl1P3A
	 LTIwy5f2fG4aA==
From: Mark Brown <broonie@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Watson Chow <watson.chow@avnet.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250420-fix-max20086-v1-0-8cc9ee0d5a08@gmail.com>
References: <20250420-fix-max20086-v1-0-8cc9ee0d5a08@gmail.com>
Subject: Re: [PATCH 0/2] regulator: max20086: Fixes chip id and enable gpio
Message-Id: <174541617346.423530.9368803789321095887.b4-ty@kernel.org>
Date: Wed, 23 Apr 2025 14:49:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-c25d1

On Sun, 20 Apr 2025 15:28:00 -0300, João Paulo Gonçalves wrote:
> I'm working on integrating a system with a MAX20086 and noticed these
> small issues in the driver: the chip ID for MAX20086 is 0x30 and not
> 0x40. Also, in my use case, the enable pin is always enabled by
> hardware, so the enable GPIO isn't needed. Without these changes, the
> driver fails to probe.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] regulator: max20086: Fix MAX200086 chip id
      commit: 71406b6d1155d883c80c1b4405939a52f723aa05
[2/2] regulator: max20086: Change enable gpio to optional
      commit: e8ac7336dd62f0443a675ed80b17f0f0e6846e20

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


