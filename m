Return-Path: <linux-kernel+bounces-801440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D99B444FF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E237BC0CE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC674338F24;
	Thu,  4 Sep 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsMt3fT0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E43154654
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757009118; cv=none; b=hcymrFtRqHXO32olQNPNVOD+CgEgzuqqTvNBJZ9aJ3psh/rkmzKNiWq914q/iwWuwEYglgNGOT3G2EkpBCdIiFNAtr7Dub2q3khk+IQuqBaCHXh6Qx1uiDUJViYxIwbcy6JdgldJWe6na0IIO2a7Q5YSGlS9pMdlkaRqI4A2FC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757009118; c=relaxed/simple;
	bh=8ulsMfA/KMzKbG7c59/17M8ZAo7RjHes/979ig8CJtU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=u3yh384cZ7opqu9CMjNjzgpdoH7glpBM/jPS//8fnxEr7HhduR1a+Tt/KjlTAVElWgEhSZY/XMPU/MHjPhd1+nJYpSxwSNSnqCzcFaokpfwFL0RpnZajWL+64pWmZMaqeMaK7Bw4bgRq3eqevIenhfSEEZ0lKnmpduFeOaraI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsMt3fT0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E680FC4CEF0;
	Thu,  4 Sep 2025 18:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757009117;
	bh=8ulsMfA/KMzKbG7c59/17M8ZAo7RjHes/979ig8CJtU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AsMt3fT0X7R+RG7pnW72ce1cRwGeubeoQGIUJsJfvQ2/+oq0+EIkhqpa6zugO4CiF
	 nNQn/s3qUBSrkLM3OEsulmDl2IS38zMyyiME9YrzICwQ8TY/3aOFoUsDHzaRv9rJlC
	 jSs2L3G8si2Y6ZABVogcFcCNa8PlouazAzLvo+8TpBPRPXKHhyqj9fISCWCIkpjwbl
	 MCU98LzT9D+pdJHIYT9MD6S4S2dytQZRIlc7kODqlsPycNzT4bSXaHnX8fnMirbxTS
	 XoRnUKWWILwsVVNe2I5lkzDXg/qE5x74MJ5pG5jYKgwhRq68Phlffw3f7UMvIk2mfo
	 7e+B5kyxs9KUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB007383BF69;
	Thu,  4 Sep 2025 18:05:23 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.17-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <c15d56f1-b1f9-4ed2-8f20-1d8111ac1115@suse.cz>
References: <c15d56f1-b1f9-4ed2-8f20-1d8111ac1115@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c15d56f1-b1f9-4ed2-8f20-1d8111ac1115@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.17-rc5
X-PR-Tracked-Commit-Id: 850470a8413a8a78e772c4f6bd9fe81ec6bd5b0f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 68f285e2647814754b9ba77b79cb32c9be2146aa
Message-Id: <175700912239.1902706.2859418068871650704.pr-tracker-bot@kernel.org>
Date: Thu, 04 Sep 2025 18:05:22 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 4 Sep 2025 10:56:09 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.17-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/68f285e2647814754b9ba77b79cb32c9be2146aa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

