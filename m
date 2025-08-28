Return-Path: <linux-kernel+bounces-790602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF27B3AAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98DB58323E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E54513E41A;
	Thu, 28 Aug 2025 19:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6IncRoI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3921862A
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 19:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756408546; cv=none; b=klyaPGWKS4ovJ0X4QucA2Ncs85vhFR4ROToXTCpP20oBoY8/amUkFUX+/GvIzBlCTTOuGy9lxvbj1XgOsDIjl9p0DJkNp/dfkz0wltJ/qAxz40bN22hHzWLq0Uk+wH8vNHX+mNXhWgMZE5sex4Edu1ZuoEqWjsBjjgleaGJB9As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756408546; c=relaxed/simple;
	bh=1SDDWYJvQBRB4TuIR07ah9bIeYVAkP+Sjkr2wP8iO4Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ndwVOJvn/bO8hUhIV/rD7ic1WZOLZk+Ptjdfz+86shAev0jn/M0ihnBjKiUKUJT7W4RLa71RpAmhAYCBT46TfreddApOmyeM8qKTav+nLasol3a/57OkO9U9x7V5I61BO9G/ps4naRKSxyaCoV3E+lp5RhVJOVPE2fLmH5NuFl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6IncRoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B8DC4CEEB;
	Thu, 28 Aug 2025 19:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756408546;
	bh=1SDDWYJvQBRB4TuIR07ah9bIeYVAkP+Sjkr2wP8iO4Y=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=t6IncRoIZg2QDNPk1G6q+InKgZnlOQpgzqNRukaZhs9qcqzXAIGEzmomAsw2+nbB2
	 xvQBg16Gn0dFau49zb4/nCQIols1c0RkyIZz+s0qFtsx/wCfy3Vp0+wer2Gn5c5xh3
	 7nBLuW6IJ8wC+8i1GfNlWPpNn7gkOy8RuffbXKfoZYfnj6miS0Aa2mScfrVRfWwnfQ
	 OgySyNE/JvSvgQOMvvg6ojJQrXtkUifAGQ9r2dUkXI4pC446e+9qW6PHM0jfA2d7de
	 ZsslYj6ixZoGJgryZ1QylHUHGf9HIOqTHZ8hPSwqSQqeENxpbQ+ukHb3GfYp3I5Sfk
	 gHkIdqf3gOUnQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, 
 Liao Yuanhong <liaoyuanhong@vivo.com>
In-Reply-To: <20250828122737.43488-1-liaoyuanhong@vivo.com>
References: <20250828122737.43488-1-liaoyuanhong@vivo.com>
Subject: Re: [PATCH] regulator: core: Remove redundant ternary operators
Message-Id: <175640854442.350972.7184246926941820534.b4-ty@kernel.org>
Date: Thu, 28 Aug 2025 21:15:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a9b2a

On Thu, 28 Aug 2025 20:27:37 +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted. Remove
> redundant ternary operators to clean up the code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: core: Remove redundant ternary operators
      commit: 899fb38dd76dd3ede425bbaf8a96d390180a5d1c

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


