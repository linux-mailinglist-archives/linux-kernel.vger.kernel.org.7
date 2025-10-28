Return-Path: <linux-kernel+bounces-873738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA8C14923
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56E3F4E7E39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBFB32BF5B;
	Tue, 28 Oct 2025 12:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBCdbfY+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8A2F25EB;
	Tue, 28 Oct 2025 12:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761653788; cv=none; b=bireS4kG8TBqz/UBO7j9LGOgF7Ry6mPkU6sHK9hWDEHSN8D4MHhx8e3OYmC8rdIy7NqGjUN4Yjcm5A0lDh9KyTc6DeRzkeGoNLKRYGJhITppePusq/+KhOc0MBbkr4+ExO0MuVYX5ZfXjh3S+LHeIpQcb6hPq7FAf7ZWhe+1rWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761653788; c=relaxed/simple;
	bh=nN4z25dwAvqnLckBJ1iVc/pweHE/RVuDJQomSvHcTpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O0aCsW5UgdJAxgIc8OopMqbXLCD5z7Ay7nO3AGbYGbPYxKuLtiRBYJr59ztuIaWuKUQBVxkn4tT+P6QT44yl/GhcKryFzZjin/rtEU8AwXw+uSHt4TiwFfsLtJ3UVqGj0bOf1cjq83baofnGW1DTX2tr1vFpDLhLXw0v+tsiYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBCdbfY+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745BDC4CEE7;
	Tue, 28 Oct 2025 12:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761653788;
	bh=nN4z25dwAvqnLckBJ1iVc/pweHE/RVuDJQomSvHcTpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pBCdbfY+Txv/MBbjHCcYMUd5b+Z2dJUzYCwPiApoRj3IdHl2qB3qxjiQTNcso6OW4
	 KE8dG05jH+5z406gqy3mvIvvgiygKii2ZKZXr63HBhuseHTr5bcEzvZINOojAV2nzS
	 JYdmuWoU2cP42ShHKsULVFytVc6XjE7n+DGYkSJZ/yYK/ygn4xgFbnbGhRAh0VHwtH
	 S9IA77SIgsJ3DBRAQEEU89PfoyAfpikRk+1ZLeULnbiqUNkCvGwhuFkeg4XfS16YmX
	 36sxxm5UyAqkbNmIy4f0Mc+vKHI5TmkOn4cM3XqQQ0tOPxZXt9uDkKf2ztiZ5zFbx7
	 JcHGPrkAj3EXQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robin Gong <yibin.gong@nxp.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
In-Reply-To: <20251027124415.989301-1-o.rempel@pengutronix.de>
References: <20251027124415.989301-1-o.rempel@pengutronix.de>
Subject: Re: [PATCH v1 0/2] regulator: pca9450: add input supply links
Message-Id: <176165378617.53238.7226737509811324588.b4-ty@kernel.org>
Date: Tue, 28 Oct 2025 12:16:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 27 Oct 2025 13:44:13 +0100, Oleksij Rempel wrote:
> This series adds input supply definitions for the NXP PCA9450 PMIC.
> 
> Some systems detect power events such as undervoltage before the PMIC.
> To allow correct propagation of such events, each regulator must define
> its upstream input supply. The first patch updates the devicetree
> binding to document new *-supply properties, and the second patch adds
> matching .supply_name entries in the driver.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/2] dt-bindings: regulator: nxp,pca9450: document input supplies
      commit: 86df0030b71d7172317d957df17524a7fd6232d4
[2/2] regulator: pca9450: link regulator inputs to supply groups
      commit: 4c33cef58965eb655a0ac8e243aa323581ec025f

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


