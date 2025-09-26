Return-Path: <linux-kernel+bounces-834624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81454BA51FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186E81C03193
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A7B30DEC4;
	Fri, 26 Sep 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDZtipRe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D82330DD1E;
	Fri, 26 Sep 2025 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758919473; cv=none; b=rt7f5S/LbOwBXh4j+Iv4p4m2dT+ChbkkGu/5AhQ7qd+wqA3MoJcOMVqiuZee9xPNggpiC6oS+bSGYgD1T9zUlqcwn+/RplHLaJoL3KmbLdWsH3O0iueT1VpLXfBx0CC/VtOYaeA5Us9jZKuTRrSltrIm+BEc59FRKOSa6SihQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758919473; c=relaxed/simple;
	bh=5z8eh7qoAaoUbSoaeV5Ww06DIQ4yyQAAP+wCxcugZ7k=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=J7RZ/yeSRwt5z9m/pqp6RiUhlJYw9IysuSkmCGkRy0uzxmP4a9j3u3iUcwO3vb7ISmSLs7XatJNHuMOQggrHD8kC13smePfFODrXjCqPEU8OmuURL1bks8/dkJNJp5IQcbBsQlUSBU6lBMbmhr7v/xutQ+R00W+DQdUkZ3ftdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDZtipRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D18C4CEF4;
	Fri, 26 Sep 2025 20:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758919472;
	bh=5z8eh7qoAaoUbSoaeV5Ww06DIQ4yyQAAP+wCxcugZ7k=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bDZtipReG0CnXa35Fq8T2QJ4rwJDYBfiNoz/9bZrMs+QWxJAqoMDiMOKSiK8mv78k
	 DPXDjB5OcK+MWHWXOJbvpsjdlAYodklKxuhT8wH1fKpoy/GWuXTiqkavTf/X4VnITe
	 5yQljw5RjaaCyseE5DVLjZxUEdlYLSVnszEkZl5rISBYxliBkmpbXZz0lgJ+bTNBcn
	 d0Vz8uDw/3aJG5wjXVvQYOq7a6Au0ltq+xEmuTSlNnKXZeJvEPBL4lk3U/T05JZ/sS
	 J2b48/L0jlFGeXg7zHQjyEk+iMOl5rT+6eRrVH4qS0I1VJSJIR9aUqLFjUqsed9LXV
	 YNNy9zn5VNg2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D2E39D0C3F;
	Fri, 26 Sep 2025 20:44:29 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.17-5
From: pr-tracker-bot@kernel.org
In-Reply-To: <pdx86-pr-20250926153552-300446329@linux.intel.com>
References: <pdx86-pr-20250926153552-300446329@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <pdx86-pr-20250926153552-300446329@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-5
X-PR-Tracked-Commit-Id: 3ed17349f18774c24505b0c21dfbd3cc4f126518
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bb97142197df73fbbb0e6f8629dc1f89ef6960f7
Message-Id: <175891946795.51956.17047587010060469677.pr-tracker-bot@kernel.org>
Date: Fri, 26 Sep 2025 20:44:27 +0000
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, PDx86 <platform-driver-x86@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, Andy Shevchenko <andy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Sep 2025 15:35:52 +0300:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.17-5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bb97142197df73fbbb0e6f8629dc1f89ef6960f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

