Return-Path: <linux-kernel+bounces-841775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC6CBB8356
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 23:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF14C1B217B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 21:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5F2267B89;
	Fri,  3 Oct 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5U00Y3E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564521A9F94
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 21:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759527191; cv=none; b=n/wLTfyXh3rbLXjaB9xgpt8NgFuieCYuMTRn3wDL7xVwdsUuTsiDVgDLVvftRbn1lk1D/Ee0HdcSQd3Zq/YWoVevPyJT+sGmvwmjkribzIKGyqLTa5UFm8b2hcZD6dw9Tp6vDlFQfwjnrdsiOyWNxjlGAMkIl7qBpwAb8ADbfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759527191; c=relaxed/simple;
	bh=lVAKc4XhkaWOm69APq2mXBze5/QaDIcltS6zS1GuMD8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=UnilTazPmFnPIUuCsu9io0ZATPjMCbSXDV9I+synxpBdQ5vYAiIGqLWF6ykA2qCcqbHNSs37TKvyyfJqo5bc9hylDSlSC/ESmn/CrCpv0rYgCo8wHrIPJWv3lVlEhjtSufGn4LdtBdsRKdASjFo/C5NmXzKvovgOW+KaIefU7SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5U00Y3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33812C4CEF5;
	Fri,  3 Oct 2025 21:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759527191;
	bh=lVAKc4XhkaWOm69APq2mXBze5/QaDIcltS6zS1GuMD8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=G5U00Y3EgHsEPvIAOd222zZdR7fOvL3v2DoE8N+3QMqqGu3A8DKpnFcKkfomgZtGo
	 fF0if14bijEostmUO+86wLa0T2pg0tDnaUbxIFYSuoSLqdVze0Y8vKU/vyQptySS9s
	 DMS4Q0ohN0FomPBCJ+iOj3AY9zwtF4liO9tK/yJ458B9lrvUD0NMIl8OzEMID6zof2
	 c6j5n+6nTbQNH2V0Jn+/beO6Oa2U00GBWCDbcxma59/hZUfeF5hssqkUFF03aafAMl
	 BZbCpWPW37RdUPaN6hdmYJmUD19q5EB7IUOHDKowmj8L/TiS9dcLGUM1J7f4fv94YL
	 yUl0W9qepxH7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3239D0C1A;
	Fri,  3 Oct 2025 21:33:03 +0000 (UTC)
Subject: Re: [GIT PULL] configfs for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <87jz1fvtrb.fsf@kernel.org>
References: <87jz1fvtrb.fsf@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jz1fvtrb.fsf@kernel.org>
X-PR-Tracked-Remote: ssh://kernel/pub/scm/linux/kernel/git/a.hindborg/linux tags/configfs-for-v6.18
X-PR-Tracked-Commit-Id: 462272dd734b568f0190d01e24f5257c1a763fae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c1ef408c2bbadd814cc0b1d38d02da42f759584
Message-Id: <175952718242.86168.9089978158388309650.pr-tracker-bot@kernel.org>
Date: Fri, 03 Oct 2025 21:33:02 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao <leitao@debian.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 01 Oct 2025 11:47:04 +0200:

> ssh://kernel/pub/scm/linux/kernel/git/a.hindborg/linux tags/configfs-for-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c1ef408c2bbadd814cc0b1d38d02da42f759584

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

