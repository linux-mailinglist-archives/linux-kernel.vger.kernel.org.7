Return-Path: <linux-kernel+bounces-889617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9195C3E0EB
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 504CF3B44B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CDC309EE7;
	Fri,  7 Nov 2025 00:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss0eW0LZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23103093C1
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476615; cv=none; b=L4UeZUs8OSvayVJk2FA0TJrm7hUh4sn8qPLF4qIlnbBGi1Vlh3oc1hZxGum5CtmNXWXU/gojxd9BXLOevitK8jlR/embs1sg68oBD84CI4z0uJIWfEu81lJ8mR081XvxW4WAnsLeo9w1khmbDi02DTc2TjiJaHaVVR+xgP2iSTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476615; c=relaxed/simple;
	bh=zW6YJmZigQszz9l8zhGjFjXPZRDe6D/WKORBAsC9IUE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gXeJah67NyL3bNbqMFxqqB8H8tmiYzwv8NVLQEoPvoa6hJ8Lrb1ZMy2UrnWqoUvre7+6pL5/VVfxN/xSqqiV6defCQN6d9Be0buVBiHh/1wVDi0VOJwRG3O2+qtZ62mTic1+lJ47wKCMZjK7yAw2RQRbpe9lDyt7NQf+8h/Ho7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss0eW0LZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 584B4C16AAE;
	Fri,  7 Nov 2025 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762476614;
	bh=zW6YJmZigQszz9l8zhGjFjXPZRDe6D/WKORBAsC9IUE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ss0eW0LZDBg2uEeT93yGfLcXdvwIdfSgADanQzul6Zn58kAg90IITN7p4Q4ROcj5k
	 p6vZ5xnc6LbcqxYHzNYUkIP5UBGTwoW8W448/KAl4bsRdMmTaVAZMSt8XC6Gw6rLUQ
	 C2LXw4QFu/dZt7V8UYGsYc9aUqHX+WQYTPW9TYZ0PXQID3bchWBsJJrqT7DsL0aBL2
	 0hd4v1lc02eJjlqD+wqolEPZKR+SvlrUH8SeYUTgV7LuclTXylPZTcfV+h6AdZp0zW
	 4oYnzBl9O1P+BoQxKty2w5u0qGIBQx7wv4YXDssc6zeF5m5OqE6ysqbYi0g4+m3SmW
	 ddxOFarSVt91A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 340CD39EF974;
	Fri,  7 Nov 2025 00:49:48 +0000 (UTC)
Subject: Re: [GIT PULL] probes: Fixes for v6.18-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251107090440.388a9fe7b54cfc7264788f12@kernel.org>
References: <20251107090440.388a9fe7b54cfc7264788f12@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251107090440.388a9fe7b54cfc7264788f12@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.18-rc4
X-PR-Tracked-Commit-Id: c91afa7610235f89a5e8f5686aac23892ab227ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a0c9b3391999818e2c5b93719699b255be1f682
Message-Id: <176247658683.436188.16501006486331027764.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 00:49:46 +0000
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, Beau Belgrave <beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Nov 2025 09:04:40 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git probes-fixes-v6.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a0c9b3391999818e2c5b93719699b255be1f682

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

