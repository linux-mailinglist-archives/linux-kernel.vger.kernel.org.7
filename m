Return-Path: <linux-kernel+bounces-694830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3038AE1126
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 04:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4F2176AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 02:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D131B4254;
	Fri, 20 Jun 2025 02:38:12 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10501AD3E0;
	Fri, 20 Jun 2025 02:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750387091; cv=none; b=OyjtMCSvR4ElAauypvkktf5UVI20IWQ73VPQTpwcxfsOfDmAu3BGiGohdmuStd0EhKRC8Kh3fm9DK3mwCUszGtI+t9Vuctf2nK2rtLPCDfMcjJbBH/gAmO1tA3Nh/KgtnpqufrFFUfhW+jH3h1TnV5NT2S8T99FG//OToIHmfkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750387091; c=relaxed/simple;
	bh=fsZnJU1w1z46E3qLipe6bpoW4jfwsbT+X4NrfdnBgoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I54oSRk4egL4y2PkcUQIGmHQE+EycoSjZeF1pm4CBgC3IcNj/Pbhz9J8LbtIJZnCVPpog+5gpZVFd6A46vMd7YmzCe5vA6CqCc1xiD+DxJexYeHh/uUZJAFGk/lErMSyfduqIH+s+sZUpT3UBvj8ixNNzKeErbjD2VNUaCxwDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 956289424d7f11f0b29709d653e92f7d-20250620
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e97684ff-5996-4b3d-8a3b-bee2b959daa4,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:8fd8625ecb253af8884fa45b9a63201d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 956289424d7f11f0b29709d653e92f7d-20250620
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <tanze@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1170090808; Fri, 20 Jun 2025 10:38:01 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id D8AE016001A02;
	Fri, 20 Jun 2025 10:38:00 +0800 (CST)
X-ns-mid: postfix-6854C988-691806657
Received: from localhost.localdomain (unknown [10.42.12.96])
	by node4.com.cn (NSMail) with ESMTPA id 2FBC416001CC7;
	Fri, 20 Jun 2025 02:38:00 +0000 (UTC)
From: tanze <tanze@kylinos.cn>
To: peterz@infradead.org,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	tanze <tanze@kylinos.cn>
Subject: [PATCH v3] perf/x86/zhaoxin: Fix instructions error by missing fixedctr member
Date: Fri, 20 Jun 2025 10:37:57 +0800
Message-Id: <20250620023757.1429898-1-tanze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a6cd3756-5aa7-435f-9ee7-3fde67c29f17@linux.intel.com>
References: <a6cd3756-5aa7-435f-9ee7-3fde67c29f17@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Perf's instructions event tests on Zhaoxin CPUs may exhibit:

  $perf stat -e instructions,cycles ls -l

  ......
  Performance counter stats for 'ls -l':

                 0      instructions                     #    0.00  insn =
per cycle
         9,488,278      cycles

       0.004365407 seconds time elapsed

       0.003303000 seconds user
       0.001099000 seconds sys

The absence of the fixedctr member leads to an incorrect hwc->event_base
value on Zhaoxin CPUs, causing a discrepancy in the instruction count
reported by perf stat. This commit resolves the instruction count issue
by properly initializing the fixedctr member.

Fixes: 149fd4712bcd ("perf/x86/intel: Support Perfmon MSRs aliasing")
Signed-off-by: tanze <tanze@kylinos.cn>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/zhaoxin/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/cor=
e.c
index 4bdfcf091200..3fc3f9abece9 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -467,6 +467,7 @@ static const struct x86_pmu zhaoxin_pmu __initconst =3D=
 {
 	.schedule_events	=3D x86_schedule_events,
 	.eventsel		=3D MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		=3D MSR_ARCH_PERFMON_PERFCTR0,
+	.fixedctr		=3D MSR_ARCH_PERFMON_FIXED_CTR0,
 	.event_map		=3D zhaoxin_pmu_event_map,
 	.max_events		=3D ARRAY_SIZE(zx_pmon_event_map),
 	.apic			=3D 1,
--=20
2.25.1


