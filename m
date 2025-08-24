Return-Path: <linux-kernel+bounces-783662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1199B3305A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09CAF7A5ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724A2DECB7;
	Sun, 24 Aug 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOjuNMvn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BD1E1DE3
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045151; cv=none; b=crOM0x5OQJNAQn5/VkKP1NOe6hEaHah6DdePKo96gsaQQuHbuZdd+Gm5z91pUXA3zDJMAS2E2PpewS/1fdG5sticocPK5yeQb36k+4dI2O6lT60G9azbIFIhhrqzrNSPOMurmak6CX5HwSsZPucf1vDghxmZx7Jqa/KM63Zv/PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045151; c=relaxed/simple;
	bh=6y+VfP/3McCZM7lhaPCZaNi4qgksNS08RYjb/w35gMU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eqo8/TPHvf9vpg2dT/R9JCPbPv/9RVJvkhxh5cmWNDd2w8oGyBpSSKiCze3nihEye75KOE0Kr74k8H1VACqK2QM+nRI0eX1uWiJAmI3DwsbXtt7LoLnvw+W7Yb7Fu9jPYCccDGLtbkOzzk/rAal8mZ7zvsl6fVjNCBII2ZhOJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOjuNMvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5802FC116B1;
	Sun, 24 Aug 2025 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756045151;
	bh=6y+VfP/3McCZM7lhaPCZaNi4qgksNS08RYjb/w35gMU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=QOjuNMvnc+XxA1TD7LOVdlon39i8Ks40ttPxE06SbKarF8VBkKCDiyNrmJ18+OaPW
	 2NuYeDLyvUo2PlK1GJ+cchDkPC2LYbidckX2DX96BBfc9bYGT84ajXTpadoJ1EojuZ
	 7tdkfWds1rmW2G3mYnpHWHykTOvurId1j6eurdkxJxraKt50MdCopYFxIz59d1lRex
	 MTftbiE+oVY9xLMqvwCx4EtmBtJQSpG7Mxcv+4EgqEgWWSf8ZrTexlL1XkZZTqFDhj
	 8e+NE5wBU6arso+Qqda3u5sEuZRbl4JZtbgLg7sitfk2qrLexL4CO+fkhDAnSQcB+w
	 1MaXgkX5/fgMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABEE383BF69;
	Sun, 24 Aug 2025 14:19:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250824101926.GAaKrnLixrYKcVosGm@fat_crate.local>
References: <20250824101926.GAaKrnLixrYKcVosGm@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250824101926.GAaKrnLixrYKcVosGm@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc3
X-PR-Tracked-Commit-Id: d4932a1b148bb6121121e56bad312c4339042d70
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0f74d9cf52f5f4437c92dd94a3b2ef007450d419
Message-Id: <175604515955.2399738.6784866464129223996.pr-tracker-bot@kernel.org>
Date: Sun, 24 Aug 2025 14:19:19 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Aug 2025 12:19:26 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_urgent_for_v6.17_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0f74d9cf52f5f4437c92dd94a3b2ef007450d419

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

