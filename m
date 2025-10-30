Return-Path: <linux-kernel+bounces-878443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F1C209C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8415E4ED116
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7916137A3C2;
	Thu, 30 Oct 2025 14:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIyo4OWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28242475C7;
	Thu, 30 Oct 2025 14:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834723; cv=none; b=isrb0C+0sahj7WjhsOL0Lad9Yp7wWt/djo/AoZugWI1XX0OymeYAYTponaFx08vTWDx/I42mFGs1JYka1L9EkX52cslVsorJcb0/ci9qDhMVPX7Vah5Y97DQNK8gxyf/GwAAPaDv3Opy1Fo9c8QYddlCy7DfJrqJ/aKjCAzVxBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834723; c=relaxed/simple;
	bh=k3H8jsiZTGUXxdkwpwxpn0XrTdrEfAY+7KJsVjaBrMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=p/3vZufgSu6nvY79H95o1dAGiJ96GjB34w7xU3vXSGy3E/fc9cv0m8j5OUoMRNqPf6Zpc6LHWz0+bjBDftlU0S4QlTGBZlkxE1wa0ma40VVH1RKgo9Nyy4zXYky8EQcp6ey9f+8etL+CAzSslOl/f1N7XO23+jutggc881TZ8qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIyo4OWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E932C113D0;
	Thu, 30 Oct 2025 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834722;
	bh=k3H8jsiZTGUXxdkwpwxpn0XrTdrEfAY+7KJsVjaBrMw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YIyo4OWPjDQedXN6sko3BSB3gvVCNXXFKPSI6H+Y3HhXpja1Hy710ylcrWjcbSA/W
	 GybZP4C+M2CgUktvshYOsCdcYP5lQmnoI7dFcYj2Ahl0eWzkK454HPsyMoKSkXeTzn
	 mlVXhbNj+gBQlV71Vo5bdPQu4z9Wb5dwar1OgodKbNcO+mvUdvPY5YHvUEYvFn2grK
	 2Mv7oHbGpWnuPaZF9WJjc42ePzVdmk7lSXlbDt+5MlbKl8C01cZjtodwyuSYSQLs+H
	 45dRnXT7I08c0+pN5/5R9PQaJGBCmNHWRG745ff0xe2iofI7nQTpJq2H3TYc+R64Xs
	 cqQXhkxL67RSg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 hariconscious@gmail.com
Cc: khalid@kernel.org, shuah@kernel.org, david.hunter.linux@gmail.com, 
 kuninori.morimoto.gx@renesas.com, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251025043011.598300-1-hariconscious@gmail.com>
References: <20251025043011.598300-1-hariconscious@gmail.com>
Subject: Re: [PATCH] ASoC: codec: wm8400: replace printk() calls with
 dev_*() device aware logging
Message-Id: <176183472016.63092.11146848509492024868.b4-ty@kernel.org>
Date: Thu, 30 Oct 2025 14:32:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Sat, 25 Oct 2025 10:00:11 +0530, hariconscious@gmail.com wrote:
> Replace direct printk() calls with the appropriate dev_*() logging
> APIs.Use dev_err, dev_warn, dev_info, or dev_dbg to reflect the correct
> severity level. Pass the canonical struct device pointer so logs
> include device context and become traceable to specific hardware
> instances.Improve log clarity, make messages filterable by device
> and align the driver with kernel logging conventions to aid
> debugging and maintenance.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: codec: wm8400: replace printk() calls with dev_*() device aware logging
      commit: 6ef8e042cdcaabe3e3c68592ba8bfbaee2fa10a3

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


