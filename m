Return-Path: <linux-kernel+bounces-758647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD71B1D206
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8DC18859F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E880621C9E1;
	Thu,  7 Aug 2025 05:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRXoUZw/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57824219E8D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 05:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754544609; cv=none; b=nysmIGpulqwouYzYgSlymTD10p7xskIJTjZyXlBzvshWGqRpwPEB7D5+79pGZD/fGIOa4quzJBiB+iQ+FWGLmzb2yLqg/0STJ/M9JWGUR55SYm92yDsm2hF9wDmg1hG3yEwKt5gjPvyHuF2TBrJyY0tTp6c+uqMGb9rI5GlwyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754544609; c=relaxed/simple;
	bh=eiXNe7qbDEJzJQTh3X6h4ZLWYkDU0msz/BfKtGPKo2A=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lbWtFvnhn7kxWTAUWAanE0drdutbxUxs9MTeUymArYKYkUqGUFwpOEl4WorlU5rge0euG5Nb6+TPlMqF79m66piePBQ13zFXUUfz535MIqUn5ofBv6zuNJ/sXvzGlAL1FA3n2iPR6pzA4KX8Lf8kN3/+1gFpUoAKwy861mBPavw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRXoUZw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10F1C4CEEB;
	Thu,  7 Aug 2025 05:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754544608;
	bh=eiXNe7qbDEJzJQTh3X6h4ZLWYkDU0msz/BfKtGPKo2A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=GRXoUZw/CL6/rqgOSWfObr0PuBqN8OE1LlNIUtEEclCv/dYaKRTV8tEj8nCmzAb5x
	 T8NjT8+33uTtUTJC8PR7F5S+q1sXaoJxRmaaFMrBKL4utLFskGPWy6GPeHRI2uaevl
	 gLrxZVuHdPBW2Wwa80/wK60DkL/ObDXMHUcb/x2LEHYKiPOwWp0u8c223j2xZLLiEU
	 kiDzLXbAjCXrJhRkd5isK1Ex8fdYmhcGY5lfLrMllK5odoc6AgvdFVtia9uWIC9NHS
	 jUo8k4720dDHWWU5wBX6jWcR+scY7TQtGnUwIJQ8ypGgp3o8uS64JafhTOxRV6Cs8d
	 oa0Op0CsY1zQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE01D383BF56;
	Thu,  7 Aug 2025 05:30:23 +0000 (UTC)
Subject: Re: [GIT PULL] IPMI bug fixes for 6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <aJO-ExS1Zz-eMuZe@mail.minyard.net>
References: <aJO-ExS1Zz-eMuZe@mail.minyard.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aJO-ExS1Zz-eMuZe@mail.minyard.net>
X-PR-Tracked-Remote: https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.17-1
X-PR-Tracked-Commit-Id: ec50ec378e3fd83bde9b3d622ceac3509a60b6b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d244f9bb591eb914901a84c79d51975c02f81ea5
Message-Id: <175454462255.3059740.18109529050913962921.pr-tracker-bot@kernel.org>
Date: Thu, 07 Aug 2025 05:30:22 +0000
To: Corey Minyard <corey@minyard.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, openipmi-developer@lists.sourceforge.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 6 Aug 2025 15:41:55 -0500:

> https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.17-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d244f9bb591eb914901a84c79d51975c02f81ea5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

