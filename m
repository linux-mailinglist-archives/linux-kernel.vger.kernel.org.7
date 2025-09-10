Return-Path: <linux-kernel+bounces-810142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FAFB5168E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCB14E46E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B90B30EF72;
	Wed, 10 Sep 2025 12:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hLCtc/GH"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B9288C24
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506321; cv=none; b=UqdKXoajXQ0RUBqXnQrdfJ6YA5JnBJmtWzRUX5dVMQIHM2sMoOV3BC8T8pfXPUBBj1G3hdTQkijU/klgsoIDby3D1/ruva99X0ztrPLEnZIHBnRFZqplA/ZwzT3HWMTJS34DhOp2sa4CTsgIt1qyGhpJJffd3lbwIaRqeEQ5E5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506321; c=relaxed/simple;
	bh=XYY6Is4eciHff2/7ke6RgKOHML7gf9bwsbSQG6MlfvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+cG07TSmlp3wZndiUez6xGsupwZb7cbgkbbusrMNUJEhiYJTCoB2hQxey9sFnkcFwhS6s/1pZTaU3P7fPlc60O2Jc2zjnZbMm/ujnqOi/cEC6bgIkWf+Xd0ebDMWIzukFpSRf6VRPMMxw0guQj0g039QlBaFyKbopRJ86NHOTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hLCtc/GH; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757506314; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZDj4DQl+HO3T1M/N2ZoddCdWgVHIJmawh7z8IKs+sOI=;
	b=hLCtc/GH9ADupPY76Io9ZX+T8rxIA2qk9a00kvhOYMw+h5iAISnKjWP3QjD64ggScurjYkbvtPtORskBBndN5i6oALGJSvAHKp69dtqyt2LHZxEXjjL7HB9TszNHBlhs8eKnXpvwgbSMsCgE505zxoqxd06g5YQg79RT6ydI/BU=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wni1qAg_1757506310 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 20:11:53 +0800
From: cp0613@linux.alibaba.com
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 1/2] perf vendor events riscv: Add T-HEAD C930 JSON file
Date: Wed, 10 Sep 2025 20:11:20 +0800
Message-ID: <20250910121121.7203-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910121121.7203-1-cp0613@linux.alibaba.com>
References: <20250910121121.7203-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Pei <cp0613@linux.alibaba.com>

Add pmu json file of T-HEAD C930.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 tools/perf/pmu-events/arch/riscv/mapfile.csv  |   1 +
 .../arch/riscv/thead/c930/basic.json          | 117 +++++++++++
 .../pmu-events/arch/riscv/thead/c930/ieu.json |  97 ++++++++++
 .../pmu-events/arch/riscv/thead/c930/ifu.json |  62 ++++++
 .../pmu-events/arch/riscv/thead/c930/l2c.json |  87 +++++++++
 .../pmu-events/arch/riscv/thead/c930/lsu.json | 182 ++++++++++++++++++
 .../arch/riscv/thead/c930/vfpu.json           | 177 +++++++++++++++++
 7 files changed, 723 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/basic.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/ieu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/ifu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/l2c.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/lsu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/thead/c930/vfpu.json

diff --git a/tools/perf/pmu-events/arch/riscv/mapfile.csv b/tools/perf/pmu-events/arch/riscv/mapfile.csv
index 0a7e7dcc81be..93ba00fa5890 100644
--- a/tools/perf/pmu-events/arch/riscv/mapfile.csv
+++ b/tools/perf/pmu-events/arch/riscv/mapfile.csv
@@ -20,5 +20,6 @@
 0x489-0x8000000000000008-0x[[:xdigit:]]+,v1,sifive/p550,core
 0x489-0x8000000000000[1-6]08-0x[9b][[:xdigit:]]+,v1,sifive/p650,core
 0x5b7-0x0-0x0,v1,thead/c900-legacy,core
+0x5b7-0x8000000009201600-0x[[:xdigit:]]+,v1,thead/c930,core
 0x67e-0x80000000db0000[89]0-0x[[:xdigit:]]+,v1,starfive/dubhe-80,core
 0x31e-0x8000000000008a45-0x[[:xdigit:]]+,v1,andes/ax45,core
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c930/basic.json b/tools/perf/pmu-events/arch/riscv/thead/c930/basic.json
new file mode 100644
index 000000000000..afb4bec67af9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c930/basic.json
@@ -0,0 +1,117 @@
+[
+    {
+        "EventName": "cycles.hart",
+        "EventCode": "0x00000001",
+        "BriefDescription": "cpu execute cycle"
+    },
+    {
+        "EventName": "inst.ret",
+        "EventCode": "0x00000002",
+        "BriefDescription": "inst retire num"
+    },
+    {
+        "EventName": "inst.brjmp.spec",
+        "EventCode": "0x00000003",
+        "BriefDescription": "speculative execute br num"
+    },
+    {
+        "EventName": "inst.mispred.brjmp.spec",
+        "EventCode": "0x00000004",
+        "BriefDescription": "speculative execute br mispred num"
+    },
+    {
+        "EventName": "cache.l1i.rd.access",
+        "EventCode": "0x00000005",
+        "BriefDescription": "l1 icache acc num"
+    },
+    {
+        "EventName": "cache.l1i.rd.miss",
+        "EventCode": "0x00000006",
+        "BriefDescription": "l1 icache acc miss num"
+    },
+    {
+        "EventName": "cache.l1d.rd.access",
+        "EventCode": "0x00000007",
+        "BriefDescription": "l1 dcache load acc num"
+    },
+    {
+        "EventName": "cache.l1d.rd.miss",
+        "EventCode": "0x00000008",
+        "BriefDescription": "l1 dcache load acc miss num"
+    },
+    {
+        "EventName": "tlb.l1i.access",
+        "EventCode": "0x00000009",
+        "BriefDescription": "itlb acc num"
+    },
+    {
+        "EventName": "tlb.l1i.miss",
+        "EventCode": "0x0000000a",
+        "BriefDescription": "itlb acc miss num"
+    },
+    {
+        "EventName": "tlb.l1d.access",
+        "EventCode": "0x0000000b",
+        "BriefDescription": "dtlb acc num"
+    },
+    {
+        "EventName": "tlb.l1d.miss",
+        "EventCode": "0x0000000c",
+        "BriefDescription": "dtlb acc miss num"
+    },
+    {
+        "EventName": "tlb.pf.access",
+        "EventCode": "0x0000000d",
+        "BriefDescription": "ptlb acc num"
+    },
+    {
+        "EventName": "tlb.pf.miss",
+        "EventCode": "0x0000000e",
+        "BriefDescription": "ptlb acc miss num"
+    },
+    {
+        "EventName": "cache.l2.access",
+        "EventCode": "0x0000000f",
+        "BriefDescription": "l2 acc num"
+    },
+    {
+        "EventName": "cache.l2.miss",
+        "EventCode": "0x00000010",
+        "BriefDescription": "l2 acc miss num"
+    },
+    {
+        "EventName": "uop.spec",
+        "EventCode": "0x00000011",
+        "BriefDescription": "rename stage issue slots num"
+    },
+    {
+        "EventName": "topdown.frontend_bound.slots",
+        "EventCode": "0x00000012",
+        "BriefDescription": "rename stage no stall and no in recovery, rename stage bubble slot num"
+    },
+    {
+        "EventName": "topdown.bad_speculation.recovery_bubbles",
+        "EventCode": "0x00000013",
+        "BriefDescription": "backend flush, rename stage stall cycle num"
+    },
+    {
+        "EventName": "topdown.frontend_bound.latency.slots",
+        "EventCode": "0x00000014",
+        "BriefDescription": "rename stage no stall, frontend waste slots num"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.load",
+        "EventCode": "0x00000015",
+        "BriefDescription": "issue queue full, and exist inflight load cycle num"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.store",
+        "EventCode": "0x00000016",
+        "BriefDescription": "issue queue full, and exist inflight store cycle num"
+    },
+    {
+        "EventName": "uop.ret",
+        "EventCode": "0x00000017",
+        "BriefDescription": "retire uop num"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c930/ieu.json b/tools/perf/pmu-events/arch/riscv/thead/c930/ieu.json
new file mode 100644
index 000000000000..61e57c0e415b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c930/ieu.json
@@ -0,0 +1,97 @@
+[
+    {
+        "EventName": "topdown.backend_bound.core.barrier_csr",
+        "EventCode": "0x0000003c",
+        "BriefDescription": "Stall cycles caused by CSR barrier at Rename"
+    },
+    {
+        "EventName": "topdown.backend_bound.core.highload",
+        "EventCode": "0x0000003d",
+        "BriefDescription": "Stall cycles caused by high load (ptag full, etc.) at Rename"
+    },
+    {
+        "EventName": "topdown.backend_bound.core.rob_full",
+        "EventCode": "0x0000003e",
+        "BriefDescription": "Stall cycles caused by ROB full at Rename"
+    },
+    {
+        "EventName": "topdown.backend_bound.core.flush_or_rebuild",
+        "EventCode": "0x0000003f",
+        "BriefDescription": "Stall cycles caused by flush or unfinished rebuilding at Rename"
+    },
+    {
+        "EventName": "ieu.de.inst_cnt",
+        "EventCode": "0x00000040",
+        "BriefDescription": "instr nums in de"
+    },
+    {
+        "EventName": "ieu.rn.inst_cnt",
+        "EventCode": "0x00000041",
+        "BriefDescription": "instr nums in rn"
+    },
+    {
+        "EventName": "topdown.bad_speculation.exception_flush",
+        "EventCode": "0x00000042",
+        "BriefDescription": "Flushes generated due to exceptions"
+    },
+    {
+        "EventName": "topdown.bad_speculation.interrupt_flush",
+        "EventCode": "0x00000043",
+        "BriefDescription": "Flushes generated due to interrupts"
+    },
+    {
+        "EventName": "topdown.bad_speculation.other_flush",
+        "EventCode": "0x00000044",
+        "BriefDescription": "Other flushes generated"
+    },
+    {
+        "EventName": "inst.int.alu.spec",
+        "EventCode": "0x00000045",
+        "BriefDescription": "Completed ALU instructions"
+    },
+    {
+        "EventName": "inst.int.mul.spec",
+        "EventCode": "0x00000046",
+        "BriefDescription": "Completed MULT instructions"
+    },
+    {
+        "EventName": "inst.int.div.spec",
+        "EventCode": "0x00000047",
+        "BriefDescription": "Completed DIV instructions"
+    },
+    {
+        "EventName": "inst.int.csr.spec",
+        "EventCode": "0x00000048",
+        "BriefDescription": "Completed CSR instructions"
+    },
+    {
+        "EventName": "ieu.is.siq.stall",
+        "EventCode": "0x000000c0",
+        "BriefDescription": "cycle nums of siq full stall cycles"
+    },
+    {
+        "EventName": "ieu.is.miq.stall",
+        "EventCode": "0x000000c1",
+        "BriefDescription": "cycle nums of miq full stall cycles"
+    },
+    {
+        "EventName": "ieu.is.biq.stall",
+        "EventCode": "0x000000c2",
+        "BriefDescription": "cycle nums of biq full stall cycles"
+    },
+    {
+        "EventName": "ieu.is.lsiq.stall",
+        "EventCode": "0x000000c3",
+        "BriefDescription": "cycle nums of lsiq full stall cycles"
+    },
+    {
+        "EventName": "ieu.is.vfpq.stall",
+        "EventCode": "0x000000c4",
+        "BriefDescription": "cycle nums of fpiq full stall cycles"
+    },
+    {
+        "EventName": "topdown.backend_bound.core.div_busy",
+        "EventCode": "0x000000c5",
+        "BriefDescription": "cycle nums of div busy stall cycles"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c930/ifu.json b/tools/perf/pmu-events/arch/riscv/thead/c930/ifu.json
new file mode 100644
index 000000000000..11057f66f797
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c930/ifu.json
@@ -0,0 +1,62 @@
+[
+    {
+        "EventName": "inst.mispred.branch",
+        "EventCode": "0x00000018",
+        "BriefDescription": "speculative cond br mispred num"
+    },
+    {
+        "EventName": "inst.mispred.uncond_branch",
+        "EventCode": "0x00000019",
+        "BriefDescription": "speculative uncond br mispred num"
+    },
+    {
+        "EventName": "inst.mispred.ind",
+        "EventCode": "0x0000001a",
+        "BriefDescription": "speculative indir mispred num"
+    },
+    {
+        "EventName": "inst.mispred.ret",
+        "EventCode": "0x0000001b",
+        "BriefDescription": "speculative return mispred num"
+    },
+    {
+        "EventName": "inst.brjmp.branch.spec",
+        "EventCode": "0x0000001c",
+        "BriefDescription": "speculative execute cond br num"
+    },
+    {
+        "EventName": "inst.brjmp.uncond_branch.spec",
+        "EventCode": "0x0000001d",
+        "BriefDescription": "speculative execute uncond br num"
+    },
+    {
+        "EventName": "inst.brjmp.ind.spec",
+        "EventCode": "0x0000001e",
+        "BriefDescription": "speculative execute indir br num"
+    },
+    {
+        "EventName": "inst.brjmp.ret.spec",
+        "EventCode": "0x0000001f",
+        "BriefDescription": "speculative execute return num"
+    },
+    {
+        "EventName": "inst.brjmp.branch.tk",
+        "EventCode": "0x00000020",
+        "BriefDescription": "speculative br taken num"
+    },
+    {
+        "EventName": "cache.l1i.rd.miss.latency",
+        "EventCode": "0x000000b8",
+        "BriefDescription": "stall cycle because of l1 icache miss"
+    },
+    {
+        "EventName": "tlb.l1i.miss.latency",
+        "EventCode": "0x000000b9",
+        "BriefDescription": "stall cycle because of l1 itle miss"
+    },
+    {
+        "EventName": "inst.mispred.brjmp.latency",
+        "EventCode": "0x000000ba",
+        "BriefDescription": "stall cycle because of br miss"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c930/l2c.json b/tools/perf/pmu-events/arch/riscv/thead/c930/l2c.json
new file mode 100644
index 000000000000..885c554d5025
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c930/l2c.json
@@ -0,0 +1,87 @@
+[
+    {
+        "EventName": "cache.l2.wb",
+        "EventCode": "0x000000a2",
+        "BriefDescription": "l2 cache wb number, dirty snpresp data included."
+    },
+    {
+        "EventName": "cache.l2.rd",
+        "EventCode": "0x000000a3",
+        "BriefDescription": "l2 cache read access."
+    },
+    {
+        "EventName": "cache.l2.wr",
+        "EventCode": "0x000000a4",
+        "BriefDescription": "l2 cache store miss req from lsu."
+    },
+    {
+        "EventName": "cache.l2.refill.rd",
+        "EventCode": "0x000000a5",
+        "BriefDescription": "l2 cache refill raised by lsu/ifu."
+    },
+    {
+        "EventName": "cache.l2.refill.wr",
+        "EventCode": "0x000000a6",
+        "BriefDescription": "l2 cache refill raised by lsu stream write."
+    },
+    {
+        "EventName": "cache.l2.wb.victim",
+        "EventCode": "0x000000a7",
+        "BriefDescription": "l2 cache write back to next-level cache raised by cache replace."
+    },
+    {
+        "EventName": "cache.l2.wb.clean",
+        "EventCode": "0x000000a8",
+        "BriefDescription": "l2 cache write back to next-level cache raised by CMO or snoop."
+    },
+    {
+        "EventName": "cache.l2.inval",
+        "EventCode": "0x000000a9",
+        "BriefDescription": "l2 cache invalidation to next-level cache raised by CMO or snoop."
+    },
+    {
+        "EventName": "cache.l2.refill.inst",
+        "EventCode": "0x000000aa",
+        "BriefDescription": "l2 cache refill raised by ifu load miss."
+    },
+    {
+        "EventName": "bus.access",
+        "EventCode": "0x000000ab",
+        "BriefDescription": "bus req count."
+    },
+    {
+        "EventName": "bus.rd.access",
+        "EventCode": "0x000000ac",
+        "BriefDescription": "bus read access count."
+    },
+    {
+        "EventName": "bus.wr.access",
+        "EventCode": "0x000000af",
+        "BriefDescription": "bus evict/write access count."
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.demand_read.l3",
+        "EventCode": "0x000000bb",
+        "BriefDescription": "cacheable demand read data from l3"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.demand_read.peer_core",
+        "EventCode": "0x000000bc",
+        "BriefDescription": "cacheable demand read data from peer core"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.demand_read.dram",
+        "EventCode": "0x000000bd",
+        "BriefDescription": "cacheable demand read data from dram"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.demand_ostd_read",
+        "EventCode": "0x000000be",
+        "BriefDescription": "cacheable demand read with l2 miss and already sended bus req cycle"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.demand_read",
+        "EventCode": "0x000000bf",
+        "BriefDescription": "cacheable demand read with l2 miss"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c930/lsu.json b/tools/perf/pmu-events/arch/riscv/thead/c930/lsu.json
new file mode 100644
index 000000000000..5779692951e4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c930/lsu.json
@@ -0,0 +1,182 @@
+[
+    {
+        "EventName": "topdown.backend_bound.memory.store.l2_miss",
+        "EventCode": "0x00000079",
+        "BriefDescription": "store l2 miss and results in issue block"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.store.l1_miss",
+        "EventCode": "0x0000007a",
+        "BriefDescription": "store l1 miss and results in issue block"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.load.l2_miss",
+        "EventCode": "0x0000007b",
+        "BriefDescription": "load l2 miss and results in issue block"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.load.l1_miss",
+        "EventCode": "0x0000007c",
+        "BriefDescription": "load l1 miss and results in issue block"
+    },
+    {
+        "EventName": "topdown.backend_bound.memory.load.struct_hazard",
+        "EventCode": "0x0000007d",
+        "BriefDescription": "load struct hazards and results in issue block"
+    },
+    {
+        "EventName": "topdown.bad_speculation.rar_hazard_early_flush",
+        "EventCode": "0x0000007e",
+        "BriefDescription": "rar hazard results in early flush"
+    },
+    {
+        "EventName": "topdown.bad_speculation.rar_hazard_abnr_flush",
+        "EventCode": "0x0000007f",
+        "BriefDescription": "rar hazard results in retire flush"
+    },
+    {
+        "EventName": "topdown.bad_speculation.raw_hazard_early_flush",
+        "EventCode": "0x00000080",
+        "BriefDescription": "raw hazard results in early flush"
+    },
+    {
+        "EventName": "topdown.bad_speculation.raw_hazard_abnr_flush",
+        "EventCode": "0x00000081",
+        "BriefDescription": "raw hazard results in retire flush"
+    },
+    {
+        "EventName": "inst.load.unalign",
+        "EventCode": "0x00000083",
+        "BriefDescription": "load unalign split"
+    },
+    {
+        "EventName": "inst.store.unalign",
+        "EventCode": "0x00000084",
+        "BriefDescription": "store unalign split"
+    },
+    {
+        "EventName": "cache.l1d.wr.access",
+        "EventCode": "0x0000008a",
+        "BriefDescription": "store access l1 dcache"
+    },
+    {
+        "EventName": "cache.l1d.wr.miss",
+        "EventCode": "0x0000008b",
+        "BriefDescription": "store l1 dcache miss"
+    },
+    {
+        "EventName": "cache.l1d.refill.inner",
+        "EventCode": "0x0000008c",
+        "BriefDescription": "l1 dcache miss and l2c hit"
+    },
+    {
+        "EventName": "cache.l1d.refill.outer",
+        "EventCode": "0x0000008d",
+        "BriefDescription": "l1 dcache miss and l2c miss"
+    },
+    {
+        "EventName": "cache.l1d.wb",
+        "EventCode": "0x0000008e",
+        "BriefDescription": "l1 dcache dirty line eviction"
+    },
+    {
+        "EventName": "cache.l1d.wb.victim",
+        "EventCode": "0x0000008f",
+        "BriefDescription": "l1 dcache dirty line evicted by new cache line refill"
+    },
+    {
+        "EventName": "cache.l1d.wb.clean",
+        "EventCode": "0x00000090",
+        "BriefDescription": "l1 dcache dirty line evicted by cmo or snoop"
+    },
+    {
+        "EventName": "cache.l1d.inval",
+        "EventCode": "0x00000091",
+        "BriefDescription": "l1 dcache line invalidated by cmo or snoop"
+    },
+    {
+        "EventName": "inst.ldst.load.spec",
+        "EventCode": "0x00000092",
+        "BriefDescription": "load inst, not include prefetch"
+    },
+    {
+        "EventName": "inst.ldst.store.spec",
+        "EventCode": "0x00000093",
+        "BriefDescription": "store inst, not include cmo"
+    },
+    {
+        "EventName": "inst.ldst.lr.spec",
+        "EventCode": "0x00000094",
+        "BriefDescription": "lr inst"
+    },
+    {
+        "EventName": "inst.ldst.sc",
+        "EventCode": "0x00000095",
+        "BriefDescription": "sc inst"
+    },
+    {
+        "EventName": "inst.ldst.sc.pass",
+        "EventCode": "0x00000096",
+        "BriefDescription": "sc pass"
+    },
+    {
+        "EventName": "inst.ldst.sc.fail",
+        "EventCode": "0x00000097",
+        "BriefDescription": "sc fail"
+    },
+    {
+        "EventName": "inst.ldst.amo",
+        "EventCode": "0x00000098",
+        "BriefDescription": "amo inst"
+    },
+    {
+        "EventName": "inst.ldst.load_acquire.spec",
+        "EventCode": "0x00000099",
+        "BriefDescription": "load acquire inst"
+    },
+    {
+        "EventName": "inst.ldst.store_release.spec",
+        "EventCode": "0x0000009a",
+        "BriefDescription": "store release inst"
+    },
+    {
+        "EventName": "inst.ldst.fence",
+        "EventCode": "0x0000009b",
+        "BriefDescription": "fence inst"
+    },
+    {
+        "EventName": "inst.ldst.fencei",
+        "EventCode": "0x0000009c",
+        "BriefDescription": "fencei inst"
+    },
+    {
+        "EventName": "inst.ldst.dvm_sync",
+        "EventCode": "0x0000009d",
+        "BriefDescription": "dvm sync inst"
+    },
+    {
+        "EventName": "inst.ldst.vec_load.spec",
+        "EventCode": "0x0000009e",
+        "BriefDescription": "vector load inst(each split inst counts 1)"
+    },
+    {
+        "EventName": "inst.ldst.vec_store.spec",
+        "EventCode": "0x0000009f",
+        "BriefDescription": "vector store inst(each split inst counts 1)"
+    },
+    {
+        "EventName": "inst.ldst.float_load.spec",
+        "EventCode": "0x000000a0",
+        "BriefDescription": "float load inst"
+    },
+    {
+        "EventName": "inst.ldst.float_store.spec",
+        "EventCode": "0x000000a1",
+        "BriefDescription": "float store inst"
+    },
+    {
+        "EventName": "inst.ldst.spec",
+        "EventCode": "0x000000b3",
+        "BriefDescription": "lsu inst cmplt num"
+    }
+]
diff --git a/tools/perf/pmu-events/arch/riscv/thead/c930/vfpu.json b/tools/perf/pmu-events/arch/riscv/thead/c930/vfpu.json
new file mode 100644
index 000000000000..4412e4acc817
--- /dev/null
+++ b/tools/perf/pmu-events/arch/riscv/thead/c930/vfpu.json
@@ -0,0 +1,177 @@
+[
+    {
+        "EventName": "vfpu_ex1_rep",
+        "EventCode": "0x00000059",
+        "BriefDescription": "Number of inst replayed in VFPU EX1 stage"
+    },
+    {
+        "EventName": "topdown.backend_bound.core.rvv_stall",
+        "EventCode": "0x0000005a",
+        "BriefDescription": "Number of stall cycles caused by vfpu blocking execution instructions"
+    },
+    {
+        "EventName": "inst.sca.fp.arith.spec",
+        "EventCode": "0x0000005b",
+        "BriefDescription": "Number of executed scalar floating-point instructions"
+    },
+    {
+        "EventName": "inst.fp.arith.half.spec",
+        "EventCode": "0x0000005c",
+        "BriefDescription": "Number of executed half-precision scalar floating-point micro-instructions"
+    },
+    {
+        "EventName": "inst.fp.arith.single.spec",
+        "EventCode": "0x0000005d",
+        "BriefDescription": "Number of executed single-precision scalar floating-point micro-instructions"
+    },
+    {
+        "EventName": "inst.fp.arith.double.spec",
+        "EventCode": "0x0000005e",
+        "BriefDescription": "Number of executed double-precision scalar floating-point micro-instructions"
+    },
+    {
+        "EventName": "inst.rvv.arith.spec",
+        "EventCode": "0x0000005f",
+        "BriefDescription": "Number of executed vector macro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.spec",
+        "EventCode": "0x00000060",
+        "BriefDescription": "Number of executed vector micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.fp.spec",
+        "EventCode": "0x00000061",
+        "BriefDescription": "Number of executed vector floating-point micro-instructions"
+    },
+    {
+        "EventName": "inst.rvv.arith.fp.spec",
+        "EventCode": "0x00000062",
+        "BriefDescription": "Number of executed vector floating-point macro-instructions"
+    },
+    {
+        "EventName": "uop.sca.fp.arith.bf.spec",
+        "EventCode": "0x00000063",
+        "BriefDescription": "Number of executed bfloat16 micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.vint8.spec",
+        "EventCode": "0x00000064",
+        "BriefDescription": "Number of vector micro-instructions executed with source operands of type int8"
+    },
+    {
+        "EventName": "uop.rvv.arith.vint16.spec",
+        "EventCode": "0x00000065",
+        "BriefDescription": "Number of vector micro-instructions executed with source operands of type int16"
+    },
+    {
+        "EventName": "uop.rvv.arith.vint32.spec",
+        "EventCode": "0x00000066",
+        "BriefDescription": "Number of vetor micro-instructions executed with source operands of type int32"
+    },
+    {
+        "EventName": "uop.rvv.arith.vint64.spec",
+        "EventCode": "0x00000067",
+        "BriefDescription": "Number of vector micro-instructions executed with source operands of type int64"
+    },
+    {
+        "EventName": "uop.rvv.arith.fix_point.spec",
+        "EventCode": "0x00000068",
+        "BriefDescription": "Number of executed fixed-point micro-instructions"
+    },
+    {
+        "EventName": "uop.fp.arith.fdiv.spec",
+        "EventCode": "0x00000069",
+        "BriefDescription": "Number of executed floting-point division micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.idiv.spec",
+        "EventCode": "0x0000006a",
+        "BriefDescription": "Number of executed integer division micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.zvkn.spec",
+        "EventCode": "0x0000006b",
+        "BriefDescription": "Number of executed ZVKN-extension micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.zvks.spec",
+        "EventCode": "0x0000006c",
+        "BriefDescription": "Number of executed ZVKS-extension micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.vmulu64.spec",
+        "EventCode": "0x0000006d",
+        "BriefDescription": "Number of micro-instructions executed in vector 64-bit integer multiplication unit"
+    },
+    {
+        "EventName": "uop.rvv.arith.vmulu.spec",
+        "EventCode": "0x0000006e",
+        "BriefDescription": "Number of micro-instructions executed in vector integer multiplication unit"
+    },
+    {
+        "EventName": "uop.rvv.arith.vdot.spec",
+        "EventCode": "0x0000006f",
+        "BriefDescription": "Number of executed RISC-V and Xuantie dot-extension micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.vfmul.spec",
+        "EventCode": "0x00000070",
+        "BriefDescription": "Number of executed floating-point multiplication micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.vfadd.spec",
+        "EventCode": "0x00000071",
+        "BriefDescription": "Number of executed floating-point addition micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.perm.spec",
+        "EventCode": "0x00000072",
+        "BriefDescription": "Number of executed permutation micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.redu.spec",
+        "EventCode": "0x00000073",
+        "BriefDescription": "Number of executed integer reduction micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.fred.spec",
+        "EventCode": "0x00000074",
+        "BriefDescription": "Number of executed floating-point reduction micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.mask.spec",
+        "EventCode": "0x00000075",
+        "BriefDescription": "Number of executed vector masked micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.arith.vlmax.spec",
+        "EventCode": "0x00000076",
+        "BriefDescription": "Number of vector micro-instructions excuted with max number of element"
+    },
+    {
+        "EventName": "uop.rvv.arith.agnostic.spec",
+        "EventCode": "0x00000077",
+        "BriefDescription": "Number of vector micro-instructions excuted with agnostic policy"
+    },
+    {
+        "EventName": "uop.rvv.arith.idiv_direct.spec",
+        "EventCode": "0x00000078",
+        "BriefDescription": "Number of vector integer division micro-instructions producing special value types"
+    },
+    {
+        "EventName": "uop.rvv.vadd.spec",
+        "EventCode": "0x000000ae",
+        "BriefDescription": "Number of executed vector integer addition micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.vmacc.spec",
+        "EventCode": "0x000000af",
+        "BriefDescription": "Number of executed vector integer multiply-add micro-instructions"
+    },
+    {
+        "EventName": "uop.rvv.vfmacc.spec",
+        "EventCode": "0x000000b0",
+        "BriefDescription": "Number of executed vector floating-point multiply-add micro-instructions"
+    }
+]
-- 
2.49.0


