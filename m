Return-Path: <linux-kernel+bounces-859339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD94BED538
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 19:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0658A19C1146
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E632528FD;
	Sat, 18 Oct 2025 17:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB+os5Vg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBDC246335
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760808464; cv=none; b=BhvtEgwRUlvrYIHjBodj0+XV0mckAmK7nRRWuIktVBK5nZXY0ofiMjciC30bRCiyde2Y5OB83zjGJHfJP1q8teI3GiFRPwtn3R8bwHFWSuDvhYz1mEuJb/AdaamOUu66vTnAX/4Qn1GUY7eZmfwKSMVYUyvbHMJmcY0kBnc7pqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760808464; c=relaxed/simple;
	bh=P7Qw/yJvITNuLpm71Atff/yQqoNnnibg7Q10zpkftI4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Y5e7qWpAlqvx+jbZW5DzRio/S8OLva34PGfIT5/6gAx0M4VThufkXYD+x8EoPVe8LdbVUbBDlLUctIf1iZtuEk/DLZ31E61nE2/vTmRmYXqkTIYQUWYUCLvwvXL79dX4poHlIR3NremDMFLKeSvPTTzNy/3kq0JlhNjujUoYe+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB+os5Vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF5CC4CEF8;
	Sat, 18 Oct 2025 17:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760808464;
	bh=P7Qw/yJvITNuLpm71Atff/yQqoNnnibg7Q10zpkftI4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=hB+os5Vg41gVVlDPIbU7NzMJXtsytksa8SiVFMmXaMXuZJ4mysV2RhR01GzM9Tn3I
	 x0a6H+/VzGjbIuAMkP48xjeJNY1di/K2XEQL71AW5pUw6yf1qZ12LsWA9vUiKlIiOI
	 HMgNK4rYTNGGsQFqmrlz1vT75CJEWhhsKkcwIv9WNZbCTIrYhjDbkylfKXer9inWlo
	 IziJV7UvSYAtbILeudg3vQz4qMysE/N56/WLIP9CUulHUhFsvS0j5h/1jbcuFNPJ6h
	 B3cgkhNb5lqikdk9AMcgLKR77aj0BAnEe7dtDlvD8nYSsDbJu5uRzTGWSkHAKTsU+h
	 D8h/RTExzqOwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB04939EFBB7;
	Sat, 18 Oct 2025 17:27:28 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 6.18-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd8W+qcDYn+37=+ZcmAr0fDCiGHTyQjSWXeViPGCuQgb=Q@mail.gmail.com>
References: <CAKYAXd8W+qcDYn+37=+ZcmAr0fDCiGHTyQjSWXeViPGCuQgb=Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd8W+qcDYn+37=+ZcmAr0fDCiGHTyQjSWXeViPGCuQgb=Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.18-rc2
X-PR-Tracked-Commit-Id: 2d8636119b92970ba135c3c4da87d24dbfdeb8ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 847f242f7a44fba5aab474534fc498033e48fd72
Message-Id: <176080844752.3050468.10402325251218548557.pr-tracker-bot@kernel.org>
Date: Sat, 18 Oct 2025 17:27:27 +0000
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 18 Oct 2025 11:20:10 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/847f242f7a44fba5aab474534fc498033e48fd72

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

