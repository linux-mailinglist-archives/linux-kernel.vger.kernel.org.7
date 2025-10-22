Return-Path: <linux-kernel+bounces-865343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D17BFCD81
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9962F1A060D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA334C9B1;
	Wed, 22 Oct 2025 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX6fdOq6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E6347FEC;
	Wed, 22 Oct 2025 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146542; cv=none; b=sIiH6Gay+LWTTs+DUBNI6oNIzlG6G37tudwE/0Lpmf95gD0fySJJvVPErCNVdkp/zxRQVUUSql853bgJZDRnbfNwQ6v4rz0Rd3Hi7skVYjuhVk55MXQBVeg/ZJ7XtZNKBNBUy75kn7701hhrxJV6ojiwys/Ju1Y3jy2VWEtFqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146542; c=relaxed/simple;
	bh=TDV+5R+qF/TXk876EtqWFOl53HD3y5c563rqGsqY63E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MYI2SYQL3pV+5pFJdYW6v9JG5A9NP0FEKta28Rs4yWKpz9sKqu0MW7WUqFumE/26sSTQ7A7p/8K8AJplTKpuot1a0GDFpovThYuYuQL1p0agkzHgEjMIuVYkEXaK5SScqRRVOqSKKf1SWzAh65snya/LtZKvq6zAk2jcaLrIA7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX6fdOq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B340C4CEF5;
	Wed, 22 Oct 2025 15:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761146540;
	bh=TDV+5R+qF/TXk876EtqWFOl53HD3y5c563rqGsqY63E=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SX6fdOq6gtQWhXh6hNkiPY565Ax+qPJDPulbIxW9o090/9dC7x8HpwH8Wt09ToV9l
	 WkpUvdpZTcXNNOtJVfrsLW0fGreCkVlpEhrUohnAPUfDc/sK9uaGsqhD6NG68eETOb
	 YfDOQbLdNlwQIo7qkuACN+edfRdiiNKJlTrs5tGUykmbxiafq5fepOMTPqp2YRd88S
	 OIQScbM+jFJeLlnxgdNWXTjyMN8Rj3wzzXXfrUldufh4GsjXzrG944goxa/w/0x0bu
	 2wKycureZJaQAsiqOc5/KwX+u8nhw/yKVby3HgcI3MUo3r+0hXcb4TU34I93XqV3/A
	 7dpZ779jjKLDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3407D3A78A6C;
	Wed, 22 Oct 2025 15:22:02 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.18-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20251022140349-2206824358@linux.intel.com>
References: <pdx86-pr-20251022140349-2206824358@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20251022140349-2206824358@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.18-2
X-PR-Tracked-Commit-Id: 34cbd6e07fddf36e186c8bf26a456fb7f50af44e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd72c8fcf6d35de5d6d976f20dc1ae84ce7af08b
Message-Id: <176114652068.1975006.9143982855228571607.pr-tracker-bot@kernel.org>
Date: Wed, 22 Oct 2025 15:22:00 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Oct 2025 14:03:49 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.18-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd72c8fcf6d35de5d6d976f20dc1ae84ce7af08b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

