Return-Path: <linux-kernel+bounces-851117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD6ABD5951
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936813A3D13
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E529CB2D;
	Mon, 13 Oct 2025 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VxzJxKIC"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC092C1788
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377680; cv=none; b=LYhN+AwS/4P3GeV63CbOSbxJCQZbvKTMp6BpAoFGZg/9vGas2Uaw/uS5vk6UhAmX8uqf1Ub6t0UUDjMuZjqrtYkffhjSWzBsGms6fceid9VCem0PW2kV+SpFNG/C2iRJIO7vfUWlZKhIQ7iccebsuu5a5XJ3MJ7mhp2tZwTt9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377680; c=relaxed/simple;
	bh=Fz2Z0NVg/DpxS1jweNIyZgePAu4cm4J9w/NK89KwvTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F+GcUXYrmYqz7nhNmRPxUXjbFk4y91Cwfa2vsPB9XcZJPxND+Fjpk6JtvhIrBsOpJirsJp4YSZorJSH2fSE1r+XMZYUv5k37FrhqeoJ7FfG4+lEtGIUu1nvcbCdNdhFKqHoToLSpa3dAwUQqruueeSVQo98wVOjHspDeMrNqAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VxzJxKIC; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760377675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dQog++Z4DABPXGobwnLJdN42FYEo1zhiAYhURAKlFOI=;
	b=VxzJxKICuu2V++rKVk+ZLlHlcziBjDWagVThwUkaCtfBN/Y7aJ0ivBFRXpZz05k6xpy8c5
	xR4H4gPdQuOcUUiTsAeWifhnn4AV1wthnL304+12V5T7qzviNz329dKXh4BjsI7Q4e5pZd
	keogQh+6AEcYloTIOsY1Y3ZrscMkOnk=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next RFC 0/2] Pass external callchain entry to get_perf_callchain
Date: Tue, 14 Oct 2025 01:47:19 +0800
Message-ID: <20251013174721.2681091-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Background
==========
Alexei noted we should use preempt_disable to protect get_perf_callchain
in bpf stackmap.
https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO-bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com

A previous patch was submitted to attempt fixing this issue. And Andrii
suggested teach get_perf_callchain to let us pass that buffer directly to
avoid that unnecessary copy.
https://lore.kernel.org/bpf/20250926153952.1661146-1-chen.dylane@linux.dev

Proposed Solution
=================
Add external perf_callchain_entry parameter for get_perf_callchain to
allow us to use external buffer from BPF side. The biggest advantage is
that it can reduce unnecessary copies.

Todo
====
If the above changes are reasonable, it seems that get_callchain_entry_for_task
could also use an external perf_callchain_entry.

But I'm not sure if this modification is appropriate. After all, the
implementation of get_callchain_entry in the perf subsystem seems much more
complex than directly using an external buffer.

Comments and suggestions are always welcome.

Tao Chen (2):
  perf: Use extern perf_callchain_entry for get_perf_callchain
  bpf: Pass external callchain entry to get_perf_callchain

 include/linux/perf_event.h |  5 +++--
 kernel/bpf/stackmap.c      | 19 +++++++++++--------
 kernel/events/callchain.c  | 18 ++++++++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 27 insertions(+), 17 deletions(-)

-- 
2.48.1


