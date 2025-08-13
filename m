Return-Path: <linux-kernel+bounces-767340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CB7B2530F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9195C0148
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE78623D7FA;
	Wed, 13 Aug 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSYznCPZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC5A303C9D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109836; cv=none; b=Ba8H4YYosQ5ilHOFQfv1XojB+sk0yYuBuI/tPQas2h1By60cLJo21uXVedEg2P6YhmiXfuYXuJhwyCPFZyRTIOXew4nXHEvFHAvp0yT4+p013EH4P95/aEb02+/e1ORwLfeKNb67EUlYZ3GNQf41qtGiLzMwxyjRkss5U9WFqxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109836; c=relaxed/simple;
	bh=X7h6EtN+jHQZOpVuWr9wzyphtGJWyxad/CuXu1/VIo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eJxZuKXcJVazlTIAH2H54vG751b0EROkTHPj0YFCjBRvYJc+aWbGvrcMc/qxWijJuFMImHkQyNKx0uCk4cldMgS9sbnS8CmY3AAhmKCZqvjzVuUvPwEe4QmECMZROt1sp8xZu4zdJMqEdWnXlwpkWf+2BAZljo2SFIHHY/O7Xpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSYznCPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE859C4CEEB;
	Wed, 13 Aug 2025 18:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755109836;
	bh=X7h6EtN+jHQZOpVuWr9wzyphtGJWyxad/CuXu1/VIo4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mSYznCPZVd91R4pyl+YpWStlsNOgkpACPYAPQb+1s5ns5xgKbPupNUT5ekXly61/W
	 ZPoXvY5UAvxt642RZtXBEKHJvXUpg2Peoa1tPhDApNTikazzgb6QXQ6AEZYTByto2U
	 bQeYCQa/PaDxtn8fjWOyWFSIJ4DHS8aOVInECY4Alps7jNRAILk8bEV8vRfli1bKpM
	 N8DMZHsQD+vpLLwJ4XVXDJUcoU5CND9PVTqfQlhEUbXbqzf4J7Bf0dBhUVpS3vRPHx
	 qi3L3IMXUJOHobsUoXDZfSfmrBeX6bfYPEXBlYrxi7ZdK3bYMJs/DV7IjSI3n+WQpl
	 MbSrQsAaGhBCg==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Danilo Krummrich <dakr@kernel.org>, Marek Vasut <marex@denx.de>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a154d9db0f290dda96b48bd817eb743773e846e1.1755090330.git.geert+renesas@glider.be>
References: <a154d9db0f290dda96b48bd817eb743773e846e1.1755090330.git.geert+renesas@glider.be>
Subject: Re: [PATCH] regmap: Remove superfluous check for !config in
 __regmap_init()
Message-Id: <175510983471.240508.14891178592798023061.b4-ty@kernel.org>
Date: Wed, 13 Aug 2025 19:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 13 Aug 2025 15:07:18 +0200, Geert Uytterhoeven wrote:
> The first thing __regmap_init() do is check if config is non-NULL,
> so there is no need to check for this again later.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: Remove superfluous check for !config in __regmap_init()
      commit: 5c36b86d2bf68fbcad16169983ef7ee8c537db59

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


