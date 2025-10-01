Return-Path: <linux-kernel+bounces-839406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E44F4BB1904
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E9E3AA6E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE07F2D7810;
	Wed,  1 Oct 2025 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An6OuxfO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EAA2D7803
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759345520; cv=none; b=D9XrCK1vzkqrDve3QLCyX6SO6iDu3znK81pymt+VbGl5YaN5BUE4i2eFl55+DeGln7lI9+8bxI73rE/g5JFF13SiPxnzITUYSswmNIanTrQRV3Ay3fo0XfKySDuUKu2nVq4PJkVMwmar/aZ+VZ83gCee+uz3jeaTMjUBTb2fSec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759345520; c=relaxed/simple;
	bh=B5UYed7NM1OL5uXBOIM+RINyeH3UCeQm5X7iLVZSzAQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eTxw19Emf3MIYKzFmxFy4dukhonQQGQ3B8uJI6GaQbYUF/vU8v1S6gusWLcXJVQVoj2j6DDaMX0OJV2ZDzjZupWp4T4eStRXzYcmSlsXvUueMSRg1VpiabySiwyqr+LGTtlz5Hj/6DxjAfPamZw/DeC4gvZIqlZFKbwXNjf8XFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An6OuxfO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B518BC4CEF7;
	Wed,  1 Oct 2025 19:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759345517;
	bh=B5UYed7NM1OL5uXBOIM+RINyeH3UCeQm5X7iLVZSzAQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=An6OuxfOtKzzES9R5jQwZ/C69sJ8+hmMA/U3mkSq+ZrM+ep0Kntpwztks84IxTAJh
	 e2/7Yf1PsXFrv0zLPqJv7LTI0W7kRVyBUsWK5Y1i8wOzHuswxgxThW1osIgx+YaHcr
	 h6Bm5ViwdXbL4vbMJWtzh3HlUeaTjQYD6zGVE39XrOwnWe+qVooj+J8+oBAl/s0GFg
	 WuaVb0mrqBycoTkQtLTB40mrJCvokkwWceUcJSxUqsr6aVFxTdbGmdTRDkwwc505o4
	 Qf0qC7mwc80l8ZsqOvid3E3hJgMICTqelb/PEth9qwm1mcOi+BdivH1azOhv7IgB1k
	 8XZMlqGdMaMjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCC39D0C3F;
	Wed,  1 Oct 2025 19:05:11 +0000 (UTC)
Subject: Re: [GIT PULL] regulator updates for v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <b4d0f23a75d33f696ba585401a385c2d@kernel.org>
References: <b4d0f23a75d33f696ba585401a385c2d@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b4d0f23a75d33f696ba585401a385c2d@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.18
X-PR-Tracked-Commit-Id: e609438851928381e39b5393f17156955a84122a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad6657804c10f794228461683b6cf1585a313ac9
Message-Id: <175934551022.2583066.1183288908724802943.pr-tracker-bot@kernel.org>
Date: Wed, 01 Oct 2025 19:05:10 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 29 Sep 2025 12:42:27 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad6657804c10f794228461683b6cf1585a313ac9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

