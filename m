Return-Path: <linux-kernel+bounces-847339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC5BCA90C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBF964834E1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FAD24BBF0;
	Thu,  9 Oct 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmnG3O0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B472243968
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760034398; cv=none; b=myePMpLmOEAHgTpsevn/x2ZQzvZK2m0t3ncdAjiWpbqy9mI3LUo8bEeHNZagZp+z4OQiu9zPD0Ks3b8tFPp3zMTeJnky+NE4v4kUFU9dL23q8BVXfw93n/7/2gc44rYNpbXKK5hel6mF7rtC6xe/EJQLJA8rsmdQqPKA/HeZajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760034398; c=relaxed/simple;
	bh=UEF4z8j/7wl0UuOCFvHdjudwgZUMGq17X1/dL2f9aaM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Rioeq2Qg4hU/QbN/7Aeh04XuF1DOsStxHb5R6scx+Kqm0Y+ns/wpBo8aOJmW8d8Hwa70iMwkqetM+usJdboKEFjpRBDGuDGU/husWG8Cxe2cg6GnAVKRiMrvJyqkEPIptnaveJwsV1DMcVEnuo5cXa1m1z9F8lfPSLukBnEbfWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmnG3O0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC03C4CEE7;
	Thu,  9 Oct 2025 18:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760034398;
	bh=UEF4z8j/7wl0UuOCFvHdjudwgZUMGq17X1/dL2f9aaM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=JmnG3O0PSMA/yc2wa1hw5xjLnD0YrQHOE3cIGfdFc747xUTsB6Zue7up0bZYnLnxt
	 +14BriRPA29USuRw5ToavPMo7odL42Ui3F+HqRSODqWjSwVSiHmquG4XHLMzSsrwHn
	 ZRR7Whg5gVIHcdEWRTJre5GqE/I1UAT0gxoFpaEmrhOVGsa/TyyY9t/+h5CZaCVd5m
	 yLMXU7OY4kQ83m+4cUt1JYbSjx2MW7jlaCUrWYdnJC4fl1RLKMPQjcy+5zFcaYPofQ
	 ettgjJ1081xOBHOO7+dJNF7/9Rooc0LnNQdUxHTGTtAQJHuzLr8c631U90xQuXJp9P
	 63aDG2ABeyVeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3409C3A55F9E;
	Thu,  9 Oct 2025 18:26:27 +0000 (UTC)
Subject: Re: [GIT PULL] slab fixes for 6.18-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <9ec4a43b-d016-40b2-996a-e8aa098c0001@suse.cz>
References: <9ec4a43b-d016-40b2-996a-e8aa098c0001@suse.cz>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <9ec4a43b-d016-40b2-996a-e8aa098c0001@suse.cz>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc1
X-PR-Tracked-Commit-Id: f7dfa0f31b13ee5f2ba598cdfcab9a831ed8a6b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f6db358deaeafd9830c8bcba8f76f55f8a14b059
Message-Id: <176003438570.230640.3897824331505748265.pr-tracker-bot@kernel.org>
Date: Thu, 09 Oct 2025 18:26:25 +0000
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, "linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 9 Oct 2025 11:36:21 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f6db358deaeafd9830c8bcba8f76f55f8a14b059

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

