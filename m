Return-Path: <linux-kernel+bounces-754189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C88B18F84
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 19:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4160B179CCC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF81E25ED;
	Sat,  2 Aug 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIZjq0ke"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6099B15530C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754154175; cv=none; b=gtq/DhWx+VcUiW+3AjyfDiHivHci0UBe5+XTm9WTRxoDnuBQisVGGtEMrXVdXGooyW2aWCohq8lRgMQOkfAydYTbzK7WLjEZN0FHymZVBwhltTjiJ0a3DgaSoFEoSC+cPIT3jGiBpGDgJq+maGg2/Exvn7NgjV8kSirq4Te3j24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754154175; c=relaxed/simple;
	bh=Gk4QRDew0mWO39IViY/XkwHEtw9H7KaEJkmZFV+E5cQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EKh5PVD1Dl0A6GoonbMJC+ioGKv8tJWYSrUEh4JlCJKYWLwHEYjl8xRmLYzVGE7DOCFJ1+1p+HzWLQEqikGHSZxQuX9x4z5Ko+MvB5GwhmVFsfk+lqPY3C1mA86rplDJCjBZWw4k++CA3XWZ2miCz147KWrNwSEwPz5lEYV/Dhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIZjq0ke; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D79C4CEEF;
	Sat,  2 Aug 2025 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754154174;
	bh=Gk4QRDew0mWO39IViY/XkwHEtw9H7KaEJkmZFV+E5cQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=cIZjq0ketetZUBtZOFVaU8oKl/+BXpR+99MzMcU9I6/puPROyPU5VcbOByOiS3D54
	 Jmbu52B3qwSr4IScwIH8FWnH2Ml28KNqhk8c2GIhwMz0ZLy17Si8GDFwJOV621k2KI
	 cHceUhj+NT5+krk1gBtRBwJVL+UNiXC/kefuCd6uI6XfxeREDwI3Yq0II8ixvaYE2G
	 dPVkJy1UoJy5Ll8wC9BqSWBE1m/SEkb/HBrHPLzk6mLvQtkbomTZUEZbNzwPATzcWg
	 bBVThwKWN+WaDFdoRqNYoOCpOrOml5uP/RqGtE+Cmxy5IvmmoLH6z282hObom8UCVR
	 m78kVLztOX+cQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CD6383BF57;
	Sat,  2 Aug 2025 17:03:11 +0000 (UTC)
Subject: Re: [GIT PULL] firewire updates for v6.17 kernel
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250802054917.GA127374@workstation.local>
References: <20250802054917.GA127374@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250802054917.GA127374@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.17
X-PR-Tracked-Commit-Id: 95a042a0c8ecd3c1e886648f6f6ab9c7e4403db9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7061835997daba9e73c723c85bd70bc4c44aef77
Message-Id: <175415418967.201848.16198036329889833063.pr-tracker-bot@kernel.org>
Date: Sat, 02 Aug 2025 17:03:09 +0000
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net, edmund.raile@protonmail.com, apais@linux.microsoft.com
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 2 Aug 2025 14:49:17 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-updates-6.17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7061835997daba9e73c723c85bd70bc4c44aef77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

