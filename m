Return-Path: <linux-kernel+bounces-849564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86836BD066A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D5E13BDF71
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E259D2EC08B;
	Sun, 12 Oct 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/aXtZGp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAB62EBDE0
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284137; cv=none; b=XZ9xdZqQxCitzJPx+lNVn7SvqJt4ldHTwByKZbtFsLHuD7B/Vkb23YtGvxJxCJYBy/z/gu0bD6xVdPyAO3ZgNcNOtotVgGMJuAzUTUdHNv9T4tz5feaMmnuoShRUBSxFFtmIt7nil+/p1Dd4ld+8I18L7vqew0NaEHIlxKf5rUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284137; c=relaxed/simple;
	bh=S+Ew3tLKlqxb4YL6S7ydfD68wBlUOVrrompXqUMYVEY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mAJMsI5auIUbOiihPyuYIK0gLA1Kq6RCgg9y0hZFkDrvCPXT0SH13xJXa/8ai/4UfE3y9/UlwbzDvqa7DO54XCT0+kqZSp7qVWEFvGKLK/Y+6wf1hoIQW6h6VASYH58o/ZF0PSAnqvzlCd085C0KA2eGqKeo3Ca3UMRkYRy/4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/aXtZGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9060CC4CEE7;
	Sun, 12 Oct 2025 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760284137;
	bh=S+Ew3tLKlqxb4YL6S7ydfD68wBlUOVrrompXqUMYVEY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c/aXtZGpBNTwtOidCO+7TtKsA+fmrfZmIu3P3eF0vSFbfdAYPVXlHDkVzk4hkIetD
	 JOWoFIAkAkWHO+oer8IjH9FbRy7NUWL+9CJrM8vCOm1qch+fdzwWd7wYGCbJwDmSEX
	 VsrYOOjph4ixCLBhdwojtD0owSRBVGN5ybkawRqsgEq7ZOjGWV9edbCxuxGhuPIRFu
	 eNnW0P0TCeLd6FcbJ9hJeiKQTczc2j7Ox4nhykvlnqMbjIdMwpWCfAHjOOfdoK7AG7
	 +zXbbkz+MHExVw6qAde4WQOI0RIIPn1iPNX6X3sf4a4WAYGjzyZJsAaRyYK2QfKybh
	 iphmYgcg4nL3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EF23809A1C;
	Sun, 12 Oct 2025 15:48:45 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251012093441.GAaOt2McdE_lAqjRUy@fat_crate.local>
References: <20251012093441.GAaOt2McdE_lAqjRUy@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251012093441.GAaOt2McdE_lAqjRUy@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.18_rc1
X-PR-Tracked-Commit-Id: f75e07bf5226da640fa99a0594687c780d9bace4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8765f467912ff0d4832eeaf26ae573792da877e7
Message-Id: <176028412367.1681778.1072677199351555642.pr-tracker-bot@kernel.org>
Date: Sun, 12 Oct 2025 15:48:43 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 12 Oct 2025 11:34:41 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.18_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8765f467912ff0d4832eeaf26ae573792da877e7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

