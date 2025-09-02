Return-Path: <linux-kernel+bounces-797051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33579B40B39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 18:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21F53AAF44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B10133EAF3;
	Tue,  2 Sep 2025 16:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjpQLr2z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDFC338F53;
	Tue,  2 Sep 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832087; cv=none; b=s6R8rXW7YOnRZb9RYsXSzKWd+4jElSd3+KQ0dcgI+EUiyUXNKyAwpFkxSi9SyQHRla1qGTkZxjWoJN534G9rb3aB3BQBT4f9VzgV34ULw7cJH59e8dmjifQtadCVuGG8bJv71LKJaO9tR6+A0MGqHiF0YcNGuCag7uKjFtzw1cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832087; c=relaxed/simple;
	bh=mTM+YpD1g9Od8hM/9+t7hEVTQt7NrkDCzwWq1f5Ze48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k2iDa98EmBHZQzA8PfhX6GMDZFFDUITyt02wfzFeI3IeDXnsdGQ9Dh0zfBfqcCLtKl9sA/wzyt1Tuy2QWXysPuD67ppBmX2KRt9HJfjZsvq8jw1F8Yf03dJokxJydqNE/tTMdC6dJ0Kcup0uhfDeYQ4xVuiM9FPO6YWTJD0Oufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjpQLr2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2A0C4CEED;
	Tue,  2 Sep 2025 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756832087;
	bh=mTM+YpD1g9Od8hM/9+t7hEVTQt7NrkDCzwWq1f5Ze48=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FjpQLr2zozKfZlMGw7dQu3uPqvnf3gnORWT6pstgnOKVs5sZkLK+HkUsThnsv4/3Y
	 zWOuaK6gd/TayjK80BAeQxGKH8huJOwi+9VastbB2vIIilaaolwsqUEK/p40Eq1k9P
	 fOQbopYMfoyfKDjsu7PY1jMFlJa2ZUjvEMz3CaAKLl3HK94lE5XkaNzaLbBM61EFLo
	 AI/fYJ2CeY0Gsi9ZpddHv4qIJOCw5wIyWXr7L9f22cwGAUGQ4KxfAmC79L8pHyqvkZ
	 EvKVSmJ+A93EuiMXoQBgWYI9ELrtGoi+Jeo9FxgH1jg6e+2rHPPypxhmxfwqwrbzYN
	 OmR1i0ueisRFQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Keyon Jie <yang.jie@linux.intel.com>, sound-open-firmware@alsa-project.org, 
 linux-sound@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250902120639.2626861-1-colin.i.king@gmail.com>
References: <20250902120639.2626861-1-colin.i.king@gmail.com>
Subject: Re: [PATCH][next] ASoC: SOF: Intel: hda-stream: Fix incorrect
 variable used in error message
Message-Id: <175683208430.1094547.2364937658405011066.b4-ty@kernel.org>
Date: Tue, 02 Sep 2025 17:54:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Tue, 02 Sep 2025 13:06:39 +0100, Colin Ian King wrote:
> The dev_err message is reporting an error about capture streams however
> it is using the incorrect variable num_playback instead of num_capture.
> Fix this by using the correct variable num_capture.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message
      commit: 35fc531a59694f24a2456569cf7d1a9c6436841c

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


