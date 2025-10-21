Return-Path: <linux-kernel+bounces-863336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FA9BF7955
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C31CD19A64C2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F363431F5;
	Tue, 21 Oct 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nVRnxNoj"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C1E341AC1
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062822; cv=none; b=bVvXheAhiZ+ns+eM1MnNRNs5hs1GtqkBopzToIHN+0RN3PBscmS2Vq27OPBMZOkafv2ilc69tEFLFoSiUqYDUVyXXckMm5gOlR+B2jo7NVlGnpliFvBMf1aHvoitSsXK43RU9x1ZkrZdo9YbxvspORqVTfgWKUCLUcMlD9aeGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062822; c=relaxed/simple;
	bh=YPa1/94TURq8roxAhrQxuI18qIU9jr8OSUQ5t95QSdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XGtzg9zfU4frDzJHT5IUU9qD5BS/YOmw2kXivpenO42VKanNIyOw1Q81f5AJs3Kf4uyiHXN65r8aIMHT80txenKqTnPuV90uwkFU/oUERQDoX0yhEx/CnHJzmD76hn5x7h/sEZ6wZLlThC9YDe/rVQjTaAEbiXtfb3x34V8lCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nVRnxNoj; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761062808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gKIHnWo1D+O0/tFKE4OrfXOjIB0Rx7n+Ag827XUFVcs=;
	b=nVRnxNojJUXxMfIe6tCF/T6+HbJIShaiqMPDWAej3Ron2l966jNcpOzD5bVan7Z7mlvLP1
	TqI+O/5GRqLkL4eMF/bgyTwT1iQZz/qrSrRfK5K0tIFZm+Jw62rsd5XBwsBxQi8/Dhx7cU
	Ct1cq6NpZxRf7eHQa3bDrWNO9efL/ok=
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
Subject: [PATCH bpf-next v4 0/2] Pass external callchain entry to get_perf_callchain
Date: Wed, 22 Oct 2025 00:06:31 +0800
Message-ID: <20251021160633.3046301-1-chen.dylane@linux.dev>
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
But I'm not sure if this modification is appropriate. After all, the
implementation of get_callchain_entry in the perf subsystem seems much more
complex than directly using an external buffer.

Comments and suggestions are always welcome.

Change list:
 - v1 -> v2
   From Jiri
   - rebase code, fix conflict
 - v1: https://lore.kernel.org/bpf/20251013174721.2681091-1-chen.dylane@linux.dev
 
 - v2 -> v3:
   From Andrii
   - entries per CPU used in a stack-like fashion
 - v2: https://lore.kernel.org/bpf/20251014100128.2721104-1-chen.dylane@linux.dev

 v3 -> v4:
   From AI
   - fix double-put issue
 - v3: https://lore.kernel.org/bpf/4c35feba-e075-42c1-82c5-5589c16f088e@linux.dev

Tao Chen (2):
  perf: Use extern perf_callchain_entry for get_perf_callchain
  bpf: Use per-cpu BPF callchain entry to save callchain

 include/linux/perf_event.h |  4 +-
 kernel/bpf/stackmap.c      | 98 ++++++++++++++++++++++++++++----------
 kernel/events/callchain.c  | 13 +++--
 kernel/events/core.c       |  2 +-
 4 files changed, 85 insertions(+), 32 deletions(-)

-- 
2.48.1


