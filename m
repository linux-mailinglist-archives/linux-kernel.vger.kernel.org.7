Return-Path: <linux-kernel+bounces-751442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6DEB169A9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 02:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A211C6216C5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCE329D19;
	Thu, 31 Jul 2025 00:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvyFqVbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2F372617
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753922095; cv=none; b=B9I4JHIfwOKZh353o7dnpA0kDohxDnosIrQ/TM6qzQ/APi6pm9CFYHfjbJox8z+V7+GkPYvREBMbJ+VptKea7FRqihSylYhRPVA7pOhsF5ZxrSnVj/rdKbtGWCXUCypAlIu7O3EAnp1YDdsSFHd9HFEVP2W516aOc4NpojDfqtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753922095; c=relaxed/simple;
	bh=KMvHFYhoPoWs8oA87IJkNxWfTTKJM98gblqQTAcntEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=nmX2OZCHVYYTY3gNcikh9v3iAVbETUS10OeuQclEqwZ8FxYM01FO5fBTGswva4nZ5DfcoCnUT0u13dSKz7vsPvpuEskUgAMTTd4GNiukBvngIpEQdgmVYb2DkA4gl5ZCxhx9cL4YV8RSQv4I7yEccERTlTOxmMWgD211rq0dI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvyFqVbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5A3C4CEF5;
	Thu, 31 Jul 2025 00:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753922095;
	bh=KMvHFYhoPoWs8oA87IJkNxWfTTKJM98gblqQTAcntEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BvyFqVbeyS15Ul9wL1SlVpnBLQBYDZ27Iw3t7tXAQ7eTghpIU9JeETgJjQ2Kl/Tfx
	 hvb7pqTvkidE+fSX5UXtZTazgijtZVvoP7TofzIboof04tvyWWkJldHDfEJ0qFrCqW
	 kRwb/cjng0IhAKvIgeO0zkp40+yIOBo5MwaPHigJ+CEsL0IBeG5BgP0oHbFNm/KSyr
	 32MPotFFFP7+OWO84iXXgPUC8YF2lZ9bxGlRUGIwx5dQ4TKBqV+ULKbm+xqXgAhKRo
	 uoNGd76Colhu4TJz1u+HE3bZIlDcQvKZvcLo0aDR4L3ZLLf+QEOQukILa6+p2/Iu0k
	 WAnW1Bt+HAukg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD22383BF5F;
	Thu, 31 Jul 2025 00:35:12 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250729193005.348d7df8206d3e9ac438fd57@kernel.org>
References: <20250729193005.348d7df8206d3e9ac438fd57@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250729193005.348d7df8206d3e9ac438fd57@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.16
X-PR-Tracked-Commit-Id: a3e892ab0fc287389176eabdcd74234508f6e52d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a03eec74201251635dede6eb2c3f79c350863d7f
Message-Id: <175392211131.2556608.1119219658863918749.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 00:35:11 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 29 Jul 2025 19:30:05 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.16

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a03eec74201251635dede6eb2c3f79c350863d7f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

