Return-Path: <linux-kernel+bounces-890941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 332C0C416D1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 350CB4EF207
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146AF2D5944;
	Fri,  7 Nov 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxtfJ+4t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8603009FA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543180; cv=none; b=CLni422xE3D4rbpAmZ/QwjGKpWweZU0/kBmr5DJBNd2mBSK75NBxCbwYPGrRsHqeVrRcWhG7RzK5hm7qDWHkGCLPmxJJt/HzGx7mA6Jv5MYDACyUBcMXJoNw+LpEAIcOsOAe5YbnTfpB9CRFUdoLCD2F1GAyXajwdmIjSrQq7ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543180; c=relaxed/simple;
	bh=hNTOGT0G8LFqlfJl5zTl5sDRGSwPe+5si79U0NoK4zI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kDih6oGt9Do6f1RXqvoWagrSzURuQ+ZRM6JVuJcj0fIQJxCttQZwiJJgDv86m7iKF7fYGbvv6mFcl4rdKsOD4Iv1C0XJb9x+mKyaO1jbxLxPA5VXuo/IZJRx+Mbz/ajstuOhnmclrOVzWqv1NHhIk1RXN9FlofDE0rUyosyIQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxtfJ+4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DB7C116C6;
	Fri,  7 Nov 2025 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762543178;
	bh=hNTOGT0G8LFqlfJl5zTl5sDRGSwPe+5si79U0NoK4zI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rxtfJ+4tbYays6v8eIAk1xmcLQhDQhEnWQBjtvOgERcG4o+eKOrJFYniVAZ7fLmKm
	 K2Cn7b86QYcOsW8/zxZ5LT2FSpDRFlnuj37cBbogqmIT2a2bzKpT/xqHeeebjgqQBO
	 t1LR0uQ367OgLVQnje5xA3noeM0PqLfaHs6WTGL74P4RBr8QYhcLsr/wlhCXg7MAgg
	 LYX+iZ8eKJLZt5iNNverZwF9HZKg7Da3mg6/MMobJWOSPK4fX9C+n1njAQju2dmEy3
	 EwnKZrZ/pRqoNgQneGd7RrPDaaM0etWSfNWDDvNdY3mDyj2Vc6GrgIrmtZDGOjSBxx
	 8/h+KiYW0Y8gQ==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20251107104551.1553526-1-ckeepax@opensource.cirrus.com>
References: <20251107104551.1553526-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] regmap: sdw-mbq: Reorder regmap_mbq_context struct
 for better packing
Message-Id: <176254317709.12269.17989872302995356094.b4-ty@kernel.org>
Date: Fri, 07 Nov 2025 19:19:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Fri, 07 Nov 2025 10:45:51 +0000, Charles Keepax wrote:
> Avoid a hole in struct regmap_mbq_context by shuffling the members
> slightly. Pahole before:
> 
> struct regmap_mbq_context {
>         struct device *            dev;                  /*     0     8 */
>         struct sdw_slave *         sdw;                  /*     8     8 */
>         struct regmap_sdw_mbq_cfg  cfg;                  /*    16    32 */
>         int                        val_size;             /*    48     4 */
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: sdw-mbq: Reorder regmap_mbq_context struct for better packing
      commit: 6985defd1d832f1dd9d1977a6a2cc2cef7632704

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


