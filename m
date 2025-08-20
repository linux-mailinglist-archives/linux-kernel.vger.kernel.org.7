Return-Path: <linux-kernel+bounces-778671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE771B2E8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894991CC1921
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188232E1753;
	Wed, 20 Aug 2025 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR5R7c4n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AB92E1722
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732703; cv=none; b=F4vVR/kmLW4SSZ8C1Cbmkk5V3n3EJ7Rlu5iue3qzXOpcf87y4uhXOl0siPS1FgQOgdawQxE4mgeG8YJbsmGaopvU6kObglkax/GeGglJ+Dt3xVAAYLLhZDr5jeoK8Kyzfk8Omz+noHhobRbJRN6lUAuqLf85GP3zAuYoEH+8EXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732703; c=relaxed/simple;
	bh=AGXbdVDFv1IAG9EuD3eJbl2Sxu8jzxHxHveL/4S/Gxs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=toIiIHN5fgQk/AWxy1/06w07wI8sZUhGkecTtMesPM5/nwibaCy4fijYGxT4X1KO6dZOTvUtk9CcybuFGiZ6W60TF65hBqR5etD4qx5cNyDUz1VPoeZGDGKUrMsXNpJ0+Jyi9WDqKmERlWFJOD3ypDQo98UT44FaKWPSBiOCjWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR5R7c4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2827C116B1;
	Wed, 20 Aug 2025 23:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755732702;
	bh=AGXbdVDFv1IAG9EuD3eJbl2Sxu8jzxHxHveL/4S/Gxs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qR5R7c4ndBs9uYw9r3Jys5WiQfIzTrLPNuXnwp5eYaTzTVzwYx1HKIR/SYRqBZbWZ
	 RIPSDCYc/FkjQ7nDJ3IjUQBnUPq5nzrg56mGd4ll0gl1lYTzW2kjwR/MSJa2W/E0NZ
	 QgpfV3VdbiuM5rOPKaAGG7rI777Cp5gA/CqdgKZhpiwR5rEwAlNciYFUeHPG7wvSdo
	 9IWoaDLPWYa0HG/mEcSFqj7MmbQS657rsXUOqQ0FL960AqHwGbKBvynRBlZClVuvEm
	 a7Kb/Iu41g5x7a71eX2+d9LN6+ZOk/wqKHRFxqcdHKuabjZXb/5F8k3S0wxMG8eq9z
	 +yIZ6bABRNQSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BB9383BF4E;
	Wed, 20 Aug 2025 23:31:53 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.17-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250821082129.f12b601c3263e2fd3324b618@kernel.org>
References: <20250821082129.f12b601c3263e2fd3324b618@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250821082129.f12b601c3263e2fd3324b618@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc2
X-PR-Tracked-Commit-Id: ec879e1a0be8007aa232ffedcf6a6445dfc1a3d7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 068a56e56fa81e42fc5f08dff34fab149bb60a09
Message-Id: <175573271228.413930.7300490249159556313.pr-tracker-bot@kernel.org>
Date: Wed, 20 Aug 2025 23:31:52 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Aug 2025 08:21:29 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.17-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/068a56e56fa81e42fc5f08dff34fab149bb60a09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

