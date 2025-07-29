Return-Path: <linux-kernel+bounces-749792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F930B152F6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71EF85612A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E9229ACE8;
	Tue, 29 Jul 2025 18:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2LPOI8Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801C1293462;
	Tue, 29 Jul 2025 18:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814417; cv=none; b=HtBJ1jYrrxwsDv+WBDwsX8VVHfo5LfhingdRi+5iVp3BaGmOs37RTB7dRevuf8w2keoqORJqvfVMNIhP4g6EA1LBVkjhd/81qIlUN2zBl9Zz+5rMjawheUuHJLlHj0cF92ygQF4OSuGFlxu6YXpNlcs3jlp5S6zhykzPlP0yRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814417; c=relaxed/simple;
	bh=HwMOw29Nvr/6NOTZbdz/XHDZl3bQXBT8WmERD6AYZaY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MvCG+xpeKuTA9SuPv+WkQqDTmmbmgb2TUK7OWYJNbRUo72z2xgjI99Jfgr2gSZPn07CZgYmdiJYNvHgppvO/dXIVqcge8NXE/20/TmFo4hfXZj295Injr9jKjKxTzDaX2U7RLS0Imz58VLdA3t/JwimSfKJXWETzUhp6+OaiTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2LPOI8Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6574EC4CEEF;
	Tue, 29 Jul 2025 18:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814417;
	bh=HwMOw29Nvr/6NOTZbdz/XHDZl3bQXBT8WmERD6AYZaY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=i2LPOI8QEMVBOJ5FIx3IdcbEEm3PEwodE/BSAvsuQhqMvjBiUqz5ahLsNQddHFydP
	 ljTOaJlP23n2cxJ6WBXAXMLYFBWrgH25WDOBzXe405eVikZL0y+1UR9QrV7ld8VeOw
	 HA7ogL+C893kkXF6pcF7lTSyirPTb9/jQVmVvX5UIZkxvXah3dNd4Y/EIEnZegUtsS
	 VXn+niYQETjXEgTNw7wqlnwgbuzoIQn6R8zgCxuVXVrRd5i6shnCyS/IFpsT8vYXFW
	 3RnkU20wzVrT6Eo4X7mzaPcOzSQpjMrwt296a0zqT1ccXMBVb1j9GH/iN39FgLMxE/
	 a6z0vmw4OgnaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB38C383BF5F;
	Tue, 29 Jul 2025 18:40:34 +0000 (UTC)
Subject: Re: [GIT PULL 4/5] soc: defconfig updates for 6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <b64f7af2-f61d-4ebb-9815-73efd8a1a682@app.fastmail.com>
References: <564b7ace-bb5f-430e-a7f1-9f6a41305e10@app.fastmail.com> <b64f7af2-f61d-4ebb-9815-73efd8a1a682@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <b64f7af2-f61d-4ebb-9815-73efd8a1a682@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.17
X-PR-Tracked-Commit-Id: 5cfe03e1ca42fa97341fde7a8ad53be86a51d789
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c10d2221122a62f7c181f0c433bc43bfd6f5d3d
Message-Id: <175381443371.1585410.3122912678073878928.pr-tracker-bot@kernel.org>
Date: Tue, 29 Jul 2025 18:40:33 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, soc@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 26 Jul 2025 12:32:20 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-defconfig-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c10d2221122a62f7c181f0c433bc43bfd6f5d3d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

