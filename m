Return-Path: <linux-kernel+bounces-640940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44359AB0B34
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 09:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8CE1C2116B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 07:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43B272E76;
	Fri,  9 May 2025 07:07:01 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47926FD8D
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746774419; cv=none; b=lrlXxfteRZ2YIPURsfXAFSCcSX1BV0A/3+HO+dIwqo8cDTA+RdREw1DiYlv6yjxlNEvGdFGJXqoqsvEp3dHWZ4y26oT22ybSebLlWUhQrVhZqXEnZHQeb1xM9I74L7jyjLra4JNhhWY2hfitZDTlF6+xB91BFY+LEYMd7o+l/F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746774419; c=relaxed/simple;
	bh=zgA44xH88px7Gc0D+by36IzKENo9XiHp4Sbt3M4HI6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NaGS5hMIe9p1r1FRS0StKa+1/4IyaiyByeaRDiDyj3OCdDOex1Yg4nozb3mXPS1mXFgCJ+5bcIhS1TT3gC8JOqZhmOOZaoCuOOZH4rI2yx1vXgFUCffX8I62vqfvZv+GtVTDPJiK9TKOI0Bcao0riHIb5WZ+aviFT2OxtiaPAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zv0R72V6Fz4f3lVb
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 15:06:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 681201A19E8
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 15:06:53 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP3 (Coremail) with SMTP id _Ch0CgAnesR4qR1ofcXLLg--.60961S2;
	Fri, 09 May 2025 15:06:53 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	paulmck@kernel.org,
	bigeasy@linutronix.de,
	legion@kernel.org,
	roman.gushchin@linux.dev,
	brauner@kernel.org,
	tglx@linutronix.de,
	frederic@kernel.org,
	peterz@infradead.org,
	oleg@redhat.com,
	joel.granados@kernel.org,
	viro@zeniv.linux.org.uk,
	lorenzo.stoakes@oracle.com,
	avagin@google.com,
	mengensun@tencent.com,
	linux@weissschuh.net,
	jlayton@kernel.org,
	ruanjinjie@huawei.com,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [RFC next 0/5] ucount: add rlimit cache for ucount
Date: Fri,  9 May 2025 06:54:06 +0000
Message-Id: <20250509065417.147515-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnesR4qR1ofcXLLg--.60961S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF4fZr15GF48JF4xGr17Jrb_yoWrCF1rpr
	WSv3sxJr4kJFnrAr1S934kX34Sg3yrAF4UGFs5C34fA3Z8GFyFyryxta4FvryDKrZ3Ja4j
	qrWjg3yqka1DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjTRNJ5oDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The will-it-scale test case signal1 [1] has been observed. and the test
results reveal that the signal sending system call lacks linearity.
To further investigate this issue, we initiated a series of tests by
launching varying numbers of dockers and closely monitored the throughput
of each individual docker. The detailed test outcomes are presented as
follows:

	| Dockers     |1      |4      |8      |16     |32     |64     |
	| Throughput  |380068 |353204 |308948 |306453 |180659 |129152 |

The data clearly demonstrates a discernible trend: as the quantity of
dockers increases, the throughput per container progressively declines.
In-depth analysis has identified the root cause of this performance
degradation. The ucouts module conducts statistics on rlimit, which
involves a significant number of atomic operations. These atomic
operations, when acting on the same variable, trigger a substantial number
of cache misses or remote accesses, ultimately resulting in a drop in
performance.

Notably, even though a new user_namespace is created upon docker startup,
the problem persists. This is because all these dockers share the same
parent node, meaning that rlimit statistics continuously modify the same
atomic variable.

Currently, when incrementing a specific rlimit within a child user
namespace by 1, the corresponding rlimit in the parent node must also be
incremented by 1. Specifically, if the ucounts corresponding to a task in
Docker B is ucount_b_1, after incrementing the rlimit of ucount_b_1 by 1,
the rlimit of the parent node, init_ucounts, must also be incremented by 1.
This operation should be ensured to stay within the limits set for the
user namespaces.

	init_user_ns                             init_ucounts
	^                                              ^
	|                        |                     |
	|<---- usr_ns_a(docker A)|usr_ns_a->ucount---->|
	|                        |                     |
	|<---- usr_ns_b(docker B)|usr_ns_a->ucount---->|
					^
					|
					|
					|
					ucount_b_1

What is expected is that dockers operating within separate namespaces
should remain isolated and not interfere with one another. Regrettably,
the current signal system call fails to achieve this desired level of
isolation.

Proposal:

To address the aforementioned issues, the concept of implementing a cache
for each namespace's rlimit has been proposed. If a cache is added for
each user namespace's rlimit, a certain amount of rlimits can be allocated
to a particular namespace in one go. When resources are abundant, these
resources do not need to be immediately returned to the parent node. Within
a user namespace, if there are available values in the cache, there is no
need to request additional resources from the parent node.

	init_user_ns                             init_ucounts
	^                                              ^
	|                        |                     |
	|<---- usr_ns_a(docker A)|usr_ns_a->ucount---->|
	|                        |                     |
	|<---- usr_ns_b(docker B)|usr_ns_b->ucount---->|
			^		^
			|		|
			cache_rlimit--->|
					|
					ucount_b_1


The ultimate objective of this solution is to achieve complete isolation
among namespaces. After applying this patch set, the final test results
indicate that in the signal1 test case, the performance does not
deteriorate as the number of containers increases. This effectively meets
the goal of linear scalability.

	| Dockers     |1      |4      |8      |16     |32     |64     |
	| Throughput  |381809 |382284 |380640 |383515 |381318 |380120 |

Challenges:

When checking the pending signals in the parent node using the command
 cat /proc/self/status | grep SigQ, the retrieved value includes the
cached signal counts from its child nodes. As a result, the SigQ value
in the parent node fails to accurately and instantaneously reflect the
actual number of pending signals.

	# cat /proc/self/status | grep SigQ
	SigQ:	16/6187667

TODO:

Add cache for the other rlimits.

[1] https://github.com/antonblanchard/will-it-scale/blob/master/tests/

Chen Ridong (5):
  user_namespace: add children list node
  usernamespace: make usernamespace rcu safe
  user_namespace: add user_ns iteration helper
  uounts: factor out __inc_rlimit_get_ucounts/__dec_rlimit_put_ucounts
  ucount: add rlimit cache for ucount

 include/linux/user_namespace.h |  23 ++++-
 kernel/signal.c                |   2 +-
 kernel/ucount.c                | 181 +++++++++++++++++++++++++++++----
 kernel/user.c                  |   2 +
 kernel/user_namespace.c        |  60 ++++++++++-
 5 files changed, 243 insertions(+), 25 deletions(-)

-- 
2.34.1


