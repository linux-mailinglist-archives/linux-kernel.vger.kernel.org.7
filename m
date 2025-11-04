Return-Path: <linux-kernel+bounces-884814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A02C313C2
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B584A4FBE48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B96732573E;
	Tue,  4 Nov 2025 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sU0OKzZt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25792F5A1D;
	Tue,  4 Nov 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262708; cv=none; b=oIeEKes+h0ITh9txd53+Ri1gHuEIUGS3JZvWLw8X8v3jOSHOUBKumom86tY75L28Dt310cVdPyTXJyEvYsIQqG3LdSG+JQjKtR4MjwsQCNg3kfhooOqKuHrSrVo87zcQ5w01FCOTYa1ggTq980v0QxPBldNiJRv3XKJ5nQH0avc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262708; c=relaxed/simple;
	bh=iATfAD80ddorotenYSHXywKR7AKJQY/F+ZFnNEwTPEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IBlvh/1VnX/CIX3Ddg/oQ1PiRMzwKhkB/BN8r5dV5jxOgj8zJWys/tUW5cOmTwS0WPvR7bcSEmEwBtWW26XQd4v8Pm+92+vX1i6sAvtiJZeAhon4L1QGCEJtpSi0TghKNllJoaKAxM6mcJQv+4XSFFHuVMcTCHojbZqxQAg+/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sU0OKzZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5619C4CEF7;
	Tue,  4 Nov 2025 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262708;
	bh=iATfAD80ddorotenYSHXywKR7AKJQY/F+ZFnNEwTPEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=sU0OKzZt6g0S+mWgVHBvftuaXH5wuKFhF4Io6tn4K72nZBEf7XYBsZAGiYuyltlg0
	 dLJFxc56flKunbq3fy9rtLkx9VNy/YEnASXLz/vFhLpRAaCX8SDQ8LRAFohUVWzRtD
	 sJclyonKr9c79UdnPVblcjjx6d4Ob2X84AL+fazY+oDhBfXZFvstYoCDWgN3/N1AmL
	 Qizo/w4wHwgnMa1+atMDnkGt1I1XX8b6pI57NqPL75sm5Qjdn67zCTqUGcCx0/Iphh
	 /QqXl2ptvCFvbNEAgOg4fI08StuANm1EgJA9LpOFLkvRTRwfKziEjQXbFlR8M/lEKT
	 q0Qa9eFuG4xWA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aQYKoiivuec3m0Jj@stanley.mountain>
References: <aQYKoiivuec3m0Jj@stanley.mountain>
Subject: Re: [PATCH] regulator: Small cleanup in
 of_get_regulation_constraints()
Message-Id: <176226270691.2215752.9832991675412345735.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 13:25:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Sat, 01 Nov 2025 16:26:58 +0300, Dan Carpenter wrote:
> Just pass "init_data" instead the address of it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Small cleanup in of_get_regulation_constraints()
      commit: 252abf2d07d33b1c70a59ba1c9395ba42bbd793e

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


