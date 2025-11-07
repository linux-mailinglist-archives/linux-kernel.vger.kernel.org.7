Return-Path: <linux-kernel+bounces-890748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD7C40D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34BF84EE80A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07F255E43;
	Fri,  7 Nov 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QllFLNns"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243C25A338;
	Fri,  7 Nov 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762532125; cv=none; b=o54PhN3K0boVsvcejaxJye97mWOIqTUamOCObASTNU9LZyI6b9xO8Wn4tebTaZPYI2LaGdhmS6jJFghSkedwpJlb7k0+c357cgl2gsRHXC1FMH3yRm4MIW5NHNfmJ8a60tKG96SK1C7T2LojE7opHYi46DmzajPG+sb0w95LW7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762532125; c=relaxed/simple;
	bh=sFxYci0a74EmQezvGYDdqeP1OKNNTO7qKA8F2rFFiiw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=saghjp1c9qYC04xqDtM8BCsLJUieIJpGxMJel0x5J/zi+tJy9z65OQONtRa3CgSUXkp4uTkZryIvxHDDXgewketVSbOG9wW1TmgDjQOlE6i4r9Yxo+SCkRF/IAzuXgiVaIYXGNRA3m431ffPjnQpxAtVUqiNbdMoV5Ho0MwWAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QllFLNns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA64EC4CEF7;
	Fri,  7 Nov 2025 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762532124;
	bh=sFxYci0a74EmQezvGYDdqeP1OKNNTO7qKA8F2rFFiiw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QllFLNns4JSS8my3dPQtQnPHU308Sz9weaGK+My35HXCiALIHCRBknQw7GLnfpxew
	 t8pgkT/AZ+Uik6kIlTAEgDAx6QhioFLBc1XzlHJ/yspeBSnNmv0NPrnK1gAtKlt2OJ
	 PTxOaxmK+OFIuiEZVaedNaXZhDYaW0I3T5vLaP0BcGkKS8lMfM+sDVKt1tniWcfib7
	 Q8wkRzKcSEqoo72rLT9NH+4y2YeGLrHP3XiFDwlxeRAM8M19rBYP+MQv7yJHbbDJqQ
	 Kw7O4zQGuT0Lhgy9xNqbprzS6tFoxCWaQ0NMVi3iCpyDhayOXGdFjMY7UKyEJZbMXO
	 Aj9YJbB61n1uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C3839F1DED;
	Fri,  7 Nov 2025 16:14:58 +0000 (UTC)
Subject: Re: [GIT PULL] gpio fixes for v6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251107144637.40951-1-brgl@bgdev.pl>
References: <20251107144637.40951-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251107144637.40951-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.18-rc5
X-PR-Tracked-Commit-Id: 4436f484cb437ba28dc58b7f787a6f80a65aa5c3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: da32d155f4a8937952ca6fd55d3270fec1c3799f
Message-Id: <176253209707.1082484.18018390753127869155.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 16:14:57 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri,  7 Nov 2025 15:46:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/da32d155f4a8937952ca6fd55d3270fec1c3799f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

