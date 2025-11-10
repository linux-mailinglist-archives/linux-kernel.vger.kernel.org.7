Return-Path: <linux-kernel+bounces-893715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D93C4838C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 18:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AA523BDAF4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18017322A0A;
	Mon, 10 Nov 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Er2YarxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A180320A2E;
	Mon, 10 Nov 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762792987; cv=none; b=gSlwI4SDII2WA59KysYBacxm65Q8Cndvo0sUT7QQXhV7hOPiffFq012y/Vz2pEVP6nSnfUx0UdspXw/elMY576XAhZFUAqfFMn89aJfQMKAkg9VGKgJS65KUSdKPMBHtgCycfd0KCmpnVAigYRzcEicShNNfPJVfm2+pn2RQ5+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762792987; c=relaxed/simple;
	bh=lR5k0ffZ8jU4/Xw+VkRiv95+frEAZ5l2jlV2iWMLidk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P/8Rd0VhEJnrMFOuvlCvw382fdfn26mbP98eFdHm4g5/dorySdoq0IXGYC8txtWLmyn4hfC/+Q6AAavp3p6eF5ePjtzNewIdlQq0vuehdFLOecTvSN8cZx7iKHG88CgbEnOWVvPpfWwSr53ge3R6DGZwOGcU6llMNQlwOKgSH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Er2YarxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548A5C4FF58;
	Mon, 10 Nov 2025 16:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762792986;
	bh=lR5k0ffZ8jU4/Xw+VkRiv95+frEAZ5l2jlV2iWMLidk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Er2YarxPLinUadkUzGyBawTFXFfv7TnAAmzSL2y2Ns40mv3lyWiafB1ZP3NZvr9Zt
	 o67UqTfCydY9FAvsqH45OB/xESgrk5eEeYgIfI7TFJID/NcAByOwIf1CKbuQGTUzK/
	 3E7kU/M75ts8ZlDGGrwQ8hIsigWPlDT/DJb2WPcxNWnG/0ePMy+eRLqwERXEsthnd3
	 kf6KbMvHeI4FoIy+pl7DpXFmLQB/bgjySs+6MXVA3GSE0YGpYpqt50x7Ax1kb/77It
	 z9iCu9kO330gouiYhnh4qpOUhXzrLOe2zZA0ozz7UgsMJFKO5PBbAeeF3GWNToa+E7
	 CyPTJTluX2qaQ==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Support Opensource <support.opensource@diasemi.com>, 
 Peter Rosin <peda@axentia.se>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, patches@opensource.cirrus.com, 
 Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev
In-Reply-To: <20251031144622.4033833-1-Frank.Li@nxp.com>
References: <20251031144622.4033833-1-Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/1] ASoC: dt-bindings: consolidate simple audio
 codec to trivial-codec.yaml
Message-Id: <176279298201.56837.2266716224330450791.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 16:43:02 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Fri, 31 Oct 2025 10:46:19 -0400, Frank Li wrote:
> Consolidate simple audio codec (one compatible string, one reg, one
> optional reset-gpios and '#sound-dai-cells' 0) to a trivial-codec.yaml.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: consolidate simple audio codec to trivial-codec.yaml
      commit: 4acbfcf11cbe6c46c42091b49875c7002b0bff3d

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


