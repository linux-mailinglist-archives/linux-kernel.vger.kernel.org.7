Return-Path: <linux-kernel+bounces-756497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAF4B1B519
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3D918A50D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC89275113;
	Tue,  5 Aug 2025 13:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlGjzxLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD327274658
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401244; cv=none; b=Zw3ASKoj07dBEH+ruTwLiENh4zkgGURtwSq87C0Kfy6lgAgSl2EZEa375u+sRt1rV4cGWU92X9PLDnces2JSrmH8snNrFalsFaOHdPyg1nmhXz8QdKJ+iT/YbghNUEnaOZ1ada12CFDavmX2kfxhZ1i025Mjb+mbXFUQlqJ9RFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401244; c=relaxed/simple;
	bh=VdXv8h92daDvfqFJWetpnXgmOW9Zh4YomDOFI+IIztA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XnXojSUuiuSU50jujGw3s/pKXd9G3Cne+l4S+8ppcXUOxjREtEpFXS1+o+aDat/j5pDEUeWgFIUCCHbZGqiU24fB7S5LsAhknWa54pPXpzd6/i5wRkCiLT+g8ekvkfr/DVQL/wFtdQnhyzY7iOqJGYZsPmeZXvlFpGtxfZY9b1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlGjzxLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D028C4CEF0;
	Tue,  5 Aug 2025 13:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754401244;
	bh=VdXv8h92daDvfqFJWetpnXgmOW9Zh4YomDOFI+IIztA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=IlGjzxLnti3rcPJtSM//l3sN5B4SPb9y9w+Y3i6zDjsvCQB3sGXOS0zaQMPodrfEn
	 yVPBl1YnrAWeK95WXJm44Cv+E6FS1Ol6s5XaT+g/GKJVoSwSJtF32wsuekUkZyKUg+
	 +EmH237m4ukmQ0k4vOKG7bxu3w0E6n1+XhlTaT59+Y0+z7yAZfCOzOimmKuELsU/2g
	 M1TJktx2/KJRAr2ELnwF659WQ7Ny9wRe8QESbu1m6zomww9oaNPZovnIkEoIvU6nII
	 dXiMOuS+TRPih8TeXNGMnIoWVZoE4Q9MpMRSm/Ebp8fXoD4dx+UVAePBkxM9RF3giz
	 sHrXKDdPyBUQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB51E383BF56;
	Tue,  5 Aug 2025 13:40:59 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd9Lv6B+f1pzMW_yfQfANXNs1HYuD0h-5zixf3xVNUy6pA@mail.gmail.com>
References: <CAKYAXd9Lv6B+f1pzMW_yfQfANXNs1HYuD0h-5zixf3xVNUy6pA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd9Lv6B+f1pzMW_yfQfANXNs1HYuD0h-5zixf3xVNUy6pA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.17-rc1
X-PR-Tracked-Commit-Id: 99f9a97dce39ad413c39b92c90393bbd6778f3fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5998f2bca43e071e9c5a26cc7e7e00f9a78791c4
Message-Id: <175440125865.2024406.7106868574154993966.pr-tracker-bot@kernel.org>
Date: Tue, 05 Aug 2025 13:40:58 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 5 Aug 2025 15:46:40 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5998f2bca43e071e9c5a26cc7e7e00f9a78791c4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

