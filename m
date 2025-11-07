Return-Path: <linux-kernel+bounces-890722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFC5C40C12
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9491C4F402A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9232E147;
	Fri,  7 Nov 2025 16:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqpGROoV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C2632AAD9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531580; cv=none; b=GJIHl9xLIdyTCEZRfDtcRo+Lo/Gkr6GI7ts0Ai8iYaB3ZuNfFSX1MhXkDkYriLGEYw+QPkFPa663+0z/EmI6a9B1cUbU4S2ub68pwkoZ04lx9Lr/+WTV+Z8swEvhwCUT0IVbOulZzEGr3ran9plDK+ooS/k3zr2VWq+ZVrrNbmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531580; c=relaxed/simple;
	bh=iwD/lIpL8OI5hfUM+FYdmY/1KSRk0/qZ6JwCV0ieico=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lNZe5+vNLyz+iBXjHn3i1BEBnfrBsU0ij2rG9BvCaR5QTfxcOC9dk6ZeQWOpTMsvuJDMGqF1mFhtqp+LCQTll+icJyBINJglmlyxV2BpxJCD/iPorb4Xx5WCnR4vLb0nuVlLdVEeqQ85Lm7l/VO1kTCK3BY7WKXBayU26A9rEk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqpGROoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F80FC16AAE;
	Fri,  7 Nov 2025 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762531580;
	bh=iwD/lIpL8OI5hfUM+FYdmY/1KSRk0/qZ6JwCV0ieico=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UqpGROoVQwaezRxKKgR5nJKyKdtk+NWn2myynx05W7PIM5ncbNZ4t5E4wJjJADldr
	 8Jj3JsdahcJPAZiZyDuajZgn8sPxfEnOPDPuOt3KBYrK/QBXHzaIxlSYx9Jv/bnyj/
	 C415MXFsORPCUxF6YTnWvXg5Xrkdwa2fn3khce6k1ZLr/xIe5tKRa4ne0BJYe1isrS
	 6iyWUcaA7CwicaxR1+3Wh4HSfPJBurswY1v7O3d2q9QtTPQEZpVdJtNFJ8xkBV4L48
	 Evp/totEi5DT4/P+13pQOqkuQO35kXxe5Qi1O0d9bruB3zW5BXkPEEVuWGlYp6DJFs
	 zo/E80gFT7gXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C0C39EFFCF;
	Fri,  7 Nov 2025 16:05:54 +0000 (UTC)
Subject: Re: [GIT PULL] slab fix for 6.18-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <2dfea88a-5ba1-4311-87d2-e1e66c2f885e@suse.cz>
References: <2dfea88a-5ba1-4311-87d2-e1e66c2f885e@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2dfea88a-5ba1-4311-87d2-e1e66c2f885e@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc5
X-PR-Tracked-Commit-Id: c379b745e12a99f0a54bafaaf75fc710614511ce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a80abfbb1013ffec7aa7e574b5ba9bcf02bd5462
Message-Id: <176253155283.1077315.9187782143764376643.pr-tracker-bot@kernel.org>
Date: Fri, 07 Nov 2025 16:05:52 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Nov 2025 09:53:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a80abfbb1013ffec7aa7e574b5ba9bcf02bd5462

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

