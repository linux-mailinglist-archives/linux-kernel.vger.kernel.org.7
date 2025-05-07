Return-Path: <linux-kernel+bounces-636877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3CEAAD132
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 00:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297E41C03690
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 22:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9B21D5AE;
	Tue,  6 May 2025 22:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j0zT8S/k"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEF21CC52
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 22:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572165; cv=none; b=VF2U/5bWs92Po8h59bLM01in6mMmV0D9IQqDaXM5o3stxz/S8VaE/xAT+2/DI1mliE9mMFB3xES3Xw48pxDJ3rKbmlJJxqXGO+y7kb6antuVCtM0ruhuEVRRU8jAuvI/b/hqHO8o4XC3mTiO5F+JjaBhyxiMKc9Myq2c226nkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572165; c=relaxed/simple;
	bh=DFt+ebbbuAZjov8Pb/RuLLERhK4r3FUooBjd2K0GPYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWGQ1mOALLgn/oZwhom+3nfaYxeWWsXDPpKqmHrLphI9+Ra0ykJBQwBAuMmV8wvHq72LgUqDvfbrdEhpCmvVuWoruz7uXTxFsQnqOq3SpY/ayh7oJvD2hibmkcm49bOQCE/YEs7uvQSOe4ffwgs/Lztcizqfek9DH83vNZVW1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j0zT8S/k; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746572151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YWJSQngmYlXWZg+lyZsIjJarzLPqwEAzFpWOWt07a40=;
	b=j0zT8S/kZxVs6fcz9mUMCkHREa6ceRcMgUr9SGpBWgyZqIXtyh5YzKJQe8wW55D8AvAlOE
	4FpYhQnxM1dX8Raal5UOJGQ6318uCvhbtMC+6z6Zal94acKfnrp+jRlzFv6KONxTIwOvNK
	jELyRxOz7CZFsZ+Hn9vtWpwy1rLVcSM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v3 0/4] memcg: decouple memcg and objcg stocks
Date: Tue,  6 May 2025 15:55:29 -0700
Message-ID: <20250506225533.2580386-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The per-cpu memcg charge cache and objcg charge cache are coupled in a
single struct memcg_stock_pcp and a single local lock is used to protect
both of the caches. This makes memcg charging and objcg charging nmi
safe challenging. Decoupling memcg and objcg stocks would allow us to
make them nmi safe and even work without disabling irqs independently.
This series completely decouples memcg and objcg stocks.

To evaluate the impact of this series with and without PREEMPT_RT
config, we ran varying number of netperf clients in different cgroups on
a 72 CPU machine.

 $ netserver -6
 $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

PREEMPT_RT config:
------------------
number of clients | Without series | With series
  6               | 38559.1 Mbps   | 38652.6 Mbps
  12              | 37388.8 Mbps   | 37560.1 Mbps
  18              | 30707.5 Mbps   | 31378.3 Mbps
  24              | 25908.4 Mbps   | 26423.9 Mbps
  30              | 22347.7 Mbps   | 22326.5 Mbps
  36              | 20235.1 Mbps   | 20165.0 Mbps

!PREEMPT_RT config:
-------------------
number of clients | Without series | With series
  6               | 50235.7 Mbps   | 51415.4 Mbps
  12              | 49336.5 Mbps   | 49901.4 Mbps
  18              | 46306.8 Mbps   | 46482.7 Mbps
  24              | 38145.7 Mbps   | 38729.4 Mbps
  30              | 30347.6 Mbps   | 31698.2 Mbps
  36              | 26976.6 Mbps   | 27364.4 Mbps

No performance regression was observed.

Changes since v2:
- Ran and included network intensive benchmarking results
- Brought back the simplify patch dropped in v2 after perf experiment.

Changes since v1:
- Drop first patch as requested by Alexei.
- Remove preempt_disable() usage as suggested by Vlastimil.

Shakeel Butt (4):
  memcg: simplify consume_stock
  memcg: separate local_trylock for memcg and obj
  memcg: completely decouple memcg and obj stocks
  memcg: no irq disable for memcg stock lock

 mm/memcontrol.c | 175 ++++++++++++++++++++++++++++--------------------
 1 file changed, 102 insertions(+), 73 deletions(-)

-- 
2.47.1


