Return-Path: <linux-kernel+bounces-849329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37CBCFD78
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 01:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0993BE994
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 23:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682172566F2;
	Sat, 11 Oct 2025 23:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt4dJEtN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395F24C676
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760224248; cv=none; b=s6VF+KAOT0BF81R+PLo1p+DsxRZbFZyZ6GpfU8Tz+0qWeoJ8zz8WgTelSLI/cBd+j6GDQiZIaDiqptCN743Lntk50h0ELsTWgjLWOCqxhhRDWvu1j6wKQIZqKRBIwMmfIfjlk68PHCfjXanzuK4BlpesR/7XYQb0m+Yagq9AAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760224248; c=relaxed/simple;
	bh=KvUbpQfKpOcx51XmUv1XgVSJGEgCpdOktT0pxys2cFE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FMNyv9VXvsoGfKEFIm9CqCUk+o5120CIeOUPpGyTR151byFlbfIp03g6texGQ4E5xG9l5lZvI+PfWQGg9ohs8ZfHMh3ZHNXunhUfqzSDZcAfIURFSn/z+HnS+pg2xoCHZbD4aNv6WicuqMQ4O/joYX0nREkGaUf34uqYyuCyYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt4dJEtN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0894C4CEF8;
	Sat, 11 Oct 2025 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760224248;
	bh=KvUbpQfKpOcx51XmUv1XgVSJGEgCpdOktT0pxys2cFE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=jt4dJEtNIyMN/a1JewhbkrFmdRX7HlJcSShPhAdXSw0XBTRlggt1e+efU7TTQCrQI
	 zig64+7RGyYv4jzDPMczFpv/BE6x+5FaUxkd8BEaedP2CjuWA7WAAMEAAswtpb723Z
	 omJeZEcTEmwrLuA+DnpsBjVtqmOTM6jhnYekK3ikXn+EP3hw8IrG6w3orRCnli6LBf
	 BGlp0cggnrWnnizW2Xq9Q7ui2C4M6xMoMperQzEJgA30cldEsgGZwAzaZP4ZnyusFt
	 90HOdHzIIOqxa2oo8OrRUOXDKmgf3qGuVbLveQqmUK1eZxDLyrNeatRgRn7CCqXyEj
	 f7JksobAYu0WA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCD43809A18;
	Sat, 11 Oct 2025 23:10:36 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: A couple more fixes to v6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251011155240.59f0ff07@gandalf.local.home>
References: <20251011155240.59f0ff07@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251011155240.59f0ff07@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18-3
X-PR-Tracked-Commit-Id: 54b91e54b113d4f15ab023a44f508251db6e22e7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67029a49db6c1f21106a1b5fcdd0ea234a6e0711
Message-Id: <176022423537.1477897.9671339462604332251.pr-tracker-bot@kernel.org>
Date: Sat, 11 Oct 2025 23:10:35 +0000
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Oct 2025 15:52:40 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.18-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67029a49db6c1f21106a1b5fcdd0ea234a6e0711

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

