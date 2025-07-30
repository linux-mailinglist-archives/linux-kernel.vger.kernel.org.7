Return-Path: <linux-kernel+bounces-750739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC85AB1607E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2131218C78CE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6FC293C42;
	Wed, 30 Jul 2025 12:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgC1GTTf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF74C62;
	Wed, 30 Jul 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753879379; cv=none; b=u9FpkYjnatJCA3MqbBa+LnY3AA2C/tPslcbyPis30w6SaFThoxdx7tHKrcy0S86/BedsI2YRvB24CmV+Z0DZXfeRm+iYqVuNn2xeNbbRuvpNktFDtXrsDBgJKn4IXJnxRD7rjCWNP5eX2uQwMr8il12xu2t3JaXM2XaBucMuuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753879379; c=relaxed/simple;
	bh=9E53T3gINWVIseYVuX5YVaqbx7wvKPDSTyP36O5S19s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kkUCtYesV4nFATL0yq/VrN4eQeTWbuVcNbNX7HOwQ1/ghabPEF6ANXJllrrZbgiGdqodheM0LViKp/g9n/qsT/eCox0h4sKdj4bf/DKiRaZjMYKl3oHekUFd5C1gl64Pz3wiYXQl+kYVV+uvmT17zUJDcUl0iEAZHzbugo8qJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgC1GTTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1702BC4CEE7;
	Wed, 30 Jul 2025 12:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753879378;
	bh=9E53T3gINWVIseYVuX5YVaqbx7wvKPDSTyP36O5S19s=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UgC1GTTf9RmS3I9y8q+8okLh28584gjWcGoCt17YrepA6OZJQOkMndG8X8kUbN8Hh
	 EgZimhriW9ZN7gO5T17PbREEuTcYyT2Cid0b2jHcdRIGcD3mqUUOYx+dQnUDfNXXui
	 svMi7Vle5blhiEmDnYhHTFjqEhlA96MAk+KUxTdEwmYHzdXVVRFFon9sgtngv18pzf
	 ZIzERnLbVvS807y3906mn7SCwKk6hVZHlgkkBhnEJz9Y1v/8Ijzbe83qMXzFhbrlnP
	 9XFDYwamD+aX3LtFFgr0EUw60xCiXdb4l42OpztW1R0c33FwK6MZJ/APBCzu8aavCS
	 vUGRrvLCA/zsg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20250730064054.3006409-1-shengjiu.wang@nxp.com>
References: <20250730064054.3006409-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: wm8962: Clear master mode when enter runtime
 suspend
Message-Id: <175387937681.30743.3683849760107976731.b4-ty@kernel.org>
Date: Wed, 30 Jul 2025 13:42:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 30 Jul 2025 14:40:54 +0800, Shengjiu Wang wrote:
> The enabled master mode causes power consumption to increase in idle
> state. Clear the MSTR bit in runtime supsend and recover it in runtime
> resume to reduce power.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: wm8962: Clear master mode when enter runtime suspend
      commit: 8d452accd1380e1cb0b15a9876bcd19b14c5fabb

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


