Return-Path: <linux-kernel+bounces-870474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC2FC0AE56
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE63B3BC1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6842E92DA;
	Sun, 26 Oct 2025 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nmo1tES4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF09248886
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 17:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761498050; cv=none; b=VXo9f08coaqjUCPeCk0JWmehDmAD9i3xkbRGznCEyvP8nae4YOQJgKBW8CyFqgqZGM02z4xLdXUP50sGVNIvjSUkY0miExaZkaRgwpie76t7m9AiqKqkB1wxKnfgtMTB1/Us6hTd9uyWTlcRMsAkiebMaOgYuRHUqJ4yrHPjP5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761498050; c=relaxed/simple;
	bh=fsmdg6nYvILLYFfEknm7p9lyh9UPJJ+efBlfHd55MhU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p9FeRSZcbFl+jRRi80/QnwUFZXUFJaVCj3/P2HOL/l1f9Ap+sshPcengj8ph6+N44oppjocxgq5GOO0x9tEhZSYTO2fwH7RFOY0x7ymUL6R9+WZqqg9FWmD7A11a/Is75ahFt8Gl2za8ypoRG12cZMy4MqVGZYaiZuBs/512/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nmo1tES4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2289DC116D0;
	Sun, 26 Oct 2025 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761498050;
	bh=fsmdg6nYvILLYFfEknm7p9lyh9UPJJ+efBlfHd55MhU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Nmo1tES4num7MSZHlFusWGApTOGhO7XTWr8C9gr/u+dF1D78WQDQF8HUqeqJbrU34
	 geloYAT0dr8be54skxWiw2tXATn1w6uaLa/1qadeXL+5bDH1Y3yccxJnu3bd2c/VjT
	 z9ZBk5ili6Tk5rnmdcx91DLymO+1CQYn+Utqu82M4h9y7S0Hi1GvhMHha6F9dSeNR3
	 RhOWZIXp5cYoFUNkyX9P09iMWXenn7/Pu/j9trvd2K2oaheqRk5g5eDQq/fbqsPnS+
	 0Hw/RE5AJnjKSeh90AR26V24PYzn48pQ6WVTu+vrMNlml+liJr4H8M+5oNvCPt7Jxe
	 5ovNgriMq0bEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B56380AA7E;
	Sun, 26 Oct 2025 17:00:30 +0000 (UTC)
Subject: Re: [GIT PULL] objtool/urgent for v6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251026120144.GAaP4NqP3HN06aP34r@fat_crate.local>
References: <20251026120144.GAaP4NqP3HN06aP34r@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251026120144.GAaP4NqP3HN06aP34r@fat_crate.local>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/objtool_urgent_for_v6.18_rc3
X-PR-Tracked-Commit-Id: 49c98f30f4021b560676a336f8a46a4f642eee2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af8159515fe16070aefa3ff56a44a5e7fb179dd2
Message-Id: <176149802875.292745.14553141860685797003.pr-tracker-bot@kernel.org>
Date: Sun, 26 Oct 2025 17:00:28 +0000
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Oct 2025 13:01:44 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/objtool_urgent_for_v6.18_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af8159515fe16070aefa3ff56a44a5e7fb179dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

