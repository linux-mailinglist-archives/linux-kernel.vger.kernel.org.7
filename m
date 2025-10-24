Return-Path: <linux-kernel+bounces-869528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C3C08122
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 22:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A9A44EBEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AF72F5A1F;
	Fri, 24 Oct 2025 20:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTd0Kfig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96A2E6CBF
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 20:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761337961; cv=none; b=exdVycbxqy6FOB9eCAqXDcrEuq7R853xC6gTGF5e4Tn8antQ69C26RrVeExhS7ACIUoUZOmlJ1eIiiahfcI/KJZURkzeOMrfiwVf3Nfnj/2ZxLrUyTo80tP53S8R+gpcF5GfDc8+JcBe9a57MrW6pWiao05DlZdkoP7dpTQ78CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761337961; c=relaxed/simple;
	bh=BZrwf98qxnwxNYWQktGux764UPgT3N3tre1nuWcqYwo=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oCmUc7bgbr/YLRURDw/xqmjE9MPR7oSsPDcN2YtMcZ3Q+AoB8bFzFz4f+AOI9BsS8V171ItTDJhjaLYykqIqaCnGJT3XQXj/TNUqkb4+qMLpVw+Uw7abG1RvvygWMnxU/S2sc5HtiCFQrnhPZ25coPKMNv5uktsSDFwln/5z9vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTd0Kfig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC971C4CEF1;
	Fri, 24 Oct 2025 20:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761337961;
	bh=BZrwf98qxnwxNYWQktGux764UPgT3N3tre1nuWcqYwo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uTd0Kfig6cpOSrjY+oomqckgJWAvBxcekuweN5SjcM/Y/ejmUMOTkdSMDLfEVt3Qk
	 LD33Es6AWza2Wx64KTado9kXw07vW6MyylcijRBkdeLGFbkNEOQHw6Q1h24AHqbtSm
	 T0jrsddKhZHIb6bfdMeQ+kOHv13yOS+q163ipwZIfxcs8YnuAPrq1OjnkSWlhc6sWh
	 /z/0WNi6ls+E4rgZ8I3T1/SQeto+jpzxwMerRegp+Eh8W46C/ExhNjuUishXru9arp
	 QPq+kOIhFcrSgg/u4rHJUb5B0qvYwCPRwaStg/XqxfS8El9Rfgmk1dMysyJSCnDJ7O
	 BxciMwfXhXqHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0A0380AA4F;
	Fri, 24 Oct 2025 20:32:22 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.18-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <999cee4d-93f3-4c41-b2c2-7c046d4d3653@suse.cz>
References: <999cee4d-93f3-4c41-b2c2-7c046d4d3653@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <999cee4d-93f3-4c41-b2c2-7c046d4d3653@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc3
X-PR-Tracked-Commit-Id: 7f434e1d9a17ca5f567c9796c9c105a65c18db9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 66cd8e9cb81015a2ec7f9dfb83db7d7915587eef
Message-Id: <176133794129.4053949.3265627509021002796.pr-tracker-bot@kernel.org>
Date: Fri, 24 Oct 2025 20:32:21 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 24 Oct 2025 15:50:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/66cd8e9cb81015a2ec7f9dfb83db7d7915587eef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

