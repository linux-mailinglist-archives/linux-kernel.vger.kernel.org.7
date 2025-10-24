Return-Path: <linux-kernel+bounces-869390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0521C07C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CEBC34C41F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D809534A3CE;
	Fri, 24 Oct 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LROF3NIp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409DD27587C;
	Fri, 24 Oct 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330804; cv=none; b=uaVyoVVELzVYMFDZKS+GtZY3lw32DVApNyJ0H+eHCm+/8Qw5QWeq5pQxZ7ufwL4gQ1hBxIgvB3sJAmJsVHKDpouKHIovrs/7LNLuEAVdU3JpZYieJPQ6084VM42czpbk9b8hBOPKevHoOXaWgH/xQjGYseBkqBjn7kDkbWnQ/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330804; c=relaxed/simple;
	bh=kspgM17Lcyc7ddAgT65W8C92EWirRENQdIr0lGmQR8g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rrtv3j17sUAS6NG+pscZi7YQ60gncoCxMfagCnwV0HujIzLDnfGPFVCLEcmPTfHrMDRtKXTevJ8mLtnsJmaUQiYeiRuJ2temwJUI7TXU6Dxj3O82yTQB2yGUaKYmwE3qhrf0VZedLZTKS74jezHsjOdGMAIMhKOEKMGIzzWR14M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LROF3NIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 214DAC4CEF1;
	Fri, 24 Oct 2025 18:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761330804;
	bh=kspgM17Lcyc7ddAgT65W8C92EWirRENQdIr0lGmQR8g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=LROF3NIpBwwRuoJBof3JkRVZ5sStv08UmjOE1qgCzN7qAkZL2rKs+kDnyB5yci2MK
	 rvIz5EYicpFbukaUFQeFmto2n9HC83MQakapaqbNoNE/9or9q+NFZtRtZR7VlorswU
	 6QA9eHxNNU8bJXdCFk4f84IvkUl8u/JXmHhNWzNOR6MPmT4lMer3aFC48ygdZzmFdV
	 Y/4yOc2Bgv/XrkAz21SeF/eZtY4x/vjVU+IIxgOEm74U+oUlC2J6fiErfjEksvTku/
	 h8/WYEcYnmB8jt1FFibicldm5+KGyLZSEgFhRwTtuCcozpHc8tgenAr/4xhn08T4qv
	 QMIJP8uCrTMmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C3A380AA4C;
	Fri, 24 Oct 2025 18:33:05 +0000 (UTC)
Subject: Re: [GIT PULL] gpio fixes for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251024120326.48028-1-brgl@bgdev.pl>
References: <20251024120326.48028-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251024120326.48028-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.18-rc3
X-PR-Tracked-Commit-Id: 4c4e6ea4a120cc5ab58e437c6ba123cbfc357d45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1a1c0d32d5b6dd219f9b9e7c51ed4c69882fe62
Message-Id: <176133078372.4023146.17937370738588010008.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 18:33:03 +0000
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 14:03:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1a1c0d32d5b6dd219f9b9e7c51ed4c69882fe62

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

