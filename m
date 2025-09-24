Return-Path: <linux-kernel+bounces-830990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D34B9B16F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27A86381094
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8BA315D51;
	Wed, 24 Sep 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="N3MrS6ax"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF9D1C831A
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735645; cv=none; b=IYG7mQDsvMvklBbp3TGm7Yzz9XSYAH5UxIdXkZTTIxzX5lmf7npoG+z2D8x9E7Ldax6kMXFTUWUOJhq+wKsIxQQI6Pin24RuO8dhNdGsu+3wJVZ76Hkxm84f3xExugoLbiv6wiQtXxM9FeoAjJBb/NsUwxFSMwrcoo3eul1D0s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735645; c=relaxed/simple;
	bh=sfaUPYbcUR5uxw3oJbUBesMeB1XFjcRlnsXjLc+qypQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RX6o/8BAvXCjqrFjEVaBWpK1euIQbl856YuO8Lnxjtvfj5hjmbcUMjezi4n2ALmr02nhN9wLXus7kwkdjWzf4vYhOLgXqCnvtjPjbLT38ppMAjnyNAzjafSwPp1m+q7oXrNyu+0jK1xw6vkPC5pOKuMmM6GK3KzZ7FoIJpyg50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=N3MrS6ax; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AKqISWi5pFZ3HfusPO8StEZwUrSgKKkuNFc8w/cbCQM=; b=N3MrS6axRSCDgelm5aqIGeLCWJ
	f/IRkEr9n9u5Q4L1qne/Lkx8FAG7mLkbvfUOlA24oi6dYKPiCgVh/7OP0iyRCwqETWEYymQDWxE5g
	OiFmV3e4AqdS8592P53AQOa0W+9CtzWQ9GgUKGZrk8TPmZU+EKgRip+joyVJ9zavTqK5gkYY61KZs
	z/DcbChyrdhIXbgRs5qrbu2M8IhQeb2+MBhO1aHywbBUocJsfGTsfzgcePU5ISYziIi2G8IjJYtGJ
	EwunbGK1FINF4eops31fkn1YvkkRsDSpy2n/lgNpnT3gSOtf94JOmgL2VwFBi4VnPf8IT8MT1c1zp
	oP2g57LQ==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v1TTj-00Gz9Z-2r; Wed, 24 Sep 2025 19:40:31 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: [PATCH 0/3] mm/page_owner: add options 'print_handle' and 'print_stack' for 'show_stacks'
Date: Wed, 24 Sep 2025 14:40:20 -0300
Message-ID: <20250924174023.261125-1-mfo@igalia.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem:

The use case of monitoring the memory usage per stack trace (or tracking
a particular stack trace) requires uniquely identifying each stack trace.

This has to be done for every stack trace on every sample of monitoring,
even if tracking only one stack trace (to identify it among all others).

Therefore, an approach like, for example, hashing the stack traces from
'show_stacks' for calculating unique identifiers can become expensive.

Solution:

Fortunately, the kernel can provide a unique identifier for stack traces
in page_owner, which is the handle number in stackdepot.

Additionally, with that information, the stack traces themselves are not
needed until the time when the memory usage should be associated with a
stack trace (say, to look at a few top consumers), using handle numbers.

This eliminates hashing and reduces filtering related to stack traces in
userspace, and reduces text emitted/copied by the kernel.

Changes:

This patchset adds 2 options to configure the output of 'show_stacks':
 - print_handle: print the handle number of the stack traces (disabled)
 - print_stack: print the stack traces (enabled)

Now, it is possible to sample with handles/without stacks, and do one last
sample with handles and stacks to associate the handles with their stacks.

Tested on next-20250922.

Results:

Numbers on a freshly booted system (gains should be higher after load,
as more stack traces would be present); average time of 10 runs:

 - Baseline: 
   average = 0.165
   # cat /sys/kernel/debug/page_owner_stacks/show_stacks >file

 - Enable handles:
   average = 0.165 (same)
   # echo 1 >/sys/kernel/debug/page_owner_stacks/print_handle
   # cat /sys/kernel/debug/page_owner_stacks/show_stacks >file

 - Enable handles, remove stack traces in userspace (example):
   average = 0.167 (+1.2%)
   # echo 1 >/sys/kernel/debug/page_owner_stacks/print_handle
   # grep -v '^ ' /sys/kernel/debug/page_owner_stacks/show_stacks >file

 - Enable handles, disable stack traces in kernel:
   average = 0.041 (-75.2%)
   # echo 1 >/sys/kernel/debug/page_owner_stacks/print_handle
   # echo 0 >/sys/kernel/debug/page_owner_stacks/print_stack
   # cat /sys/kernel/debug/page_owner_stacks/show_stacks >file

Mauricio Faria de Oliveira (3):
  mm/page_owner: add option 'print_handle' for 'show_stacks'
  mm/page_owner: add option 'print_stack' for 'show_stacks'
  mm/page_owner: update Documentation with print_handle and print_stack

 Documentation/mm/page_owner.rst | 15 ++++++++++++++-
 mm/page_owner.c                 | 18 ++++++++++++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.48.1


