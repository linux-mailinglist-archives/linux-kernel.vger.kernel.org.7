Return-Path: <linux-kernel+bounces-849262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5ED3BCFAED
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 20:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DB240635B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4391C27E1AC;
	Sat, 11 Oct 2025 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pI6ooHSW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF61F4C87
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760207948; cv=none; b=a/1CyuptyYTX3J6U/bRkSfOebrKd4K7hctvro1EZbxHpY3HXDu7pl0qCV5i9PH+I2vZvZbkWcE0m7qXVmJrh1/tqFQIIKasjNVm5un8rcWuXb1jyQUkXRPqegGcIqmpkIGHsYqpgP1+SiVqzpQ7DDIXaVQ7ARWrDxTAotiguUY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760207948; c=relaxed/simple;
	bh=KAgZNqLRf6v402fttGAcQQ8JplK5/o1bJIvo50jWFZw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fVS0NR+nSTluOpxnXv+kjEVA4UoFXgF8uZAHkQx4omaClSpJ8myvRyr+FxZa2jv/1GNEqjBiuateohOsiRGSomT04b0q7QAlDgSePWDQ/L/7RAxX2hKsYWnn8mVOatRuKYFQHuGeqn9mtEqqFLLtN3URxhyUHh47TKev38EZqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pI6ooHSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEDAC4CEF4;
	Sat, 11 Oct 2025 18:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760207948;
	bh=KAgZNqLRf6v402fttGAcQQ8JplK5/o1bJIvo50jWFZw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pI6ooHSWAe61lHVuvpCcXL83TGGhCbbfwa81ake47VktMhrjPXtsQxzrdzjpN/io4
	 S8925DkgALTzkjQfxuSNYuyOod1Zzgkh8IuaXBsCRw1WKawzQ/CWuiTF/EjIl4KFau
	 bFVPaYLuutmE+pHvfCyvA8ZdSFSmUvkRCsDYcIB0y0kIx7OB6Z4m/H7kJZyf5tEnCb
	 lN62MH3wPikF66VaRESMX8WOdPdS2lpF/3CUGNNauPXxjWH9IZ7ME/ydLtVAqvas4R
	 beMEtkiEJ/gSmZFJTOrDqmqsw0Ce2ZKbBgfVF4rqahf6+7UII/6yNFkVnp1Y3zKoK9
	 zWySNWCdB+atA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 957993809A18;
	Sat, 11 Oct 2025 18:38:56 +0000 (UTC)
Subject: Re: [GIT PULL] slab hotfix for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <903ea271-9413-40ed-93cd-104062c18a84@suse.cz>
References: <903ea271-9413-40ed-93cd-104062c18a84@suse.cz>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <903ea271-9413-40ed-93cd-104062c18a84@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc1-hotfix
X-PR-Tracked-Commit-Id: fd6db58867924d2bfbc4ece4b0092f697f9fc31c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6bb71f0fe57bb77ca484352a66aeb02e3a8ce697
Message-Id: <176020793526.1422231.5596134982561087922.pr-tracker-bot@kernel.org>
Date: Sat, 11 Oct 2025 18:38:55 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Phil Auld <pauld@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Oct 2025 11:01:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc1-hotfix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6bb71f0fe57bb77ca484352a66aeb02e3a8ce697

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

