Return-Path: <linux-kernel+bounces-694950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4217FAE12CE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 07:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0DB3BD27F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 05:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D4F2036F3;
	Fri, 20 Jun 2025 05:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JOCUVuHm"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ED02A8C1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 05:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750396242; cv=none; b=mnQi2sqMusPLdrNsnpDckemgH9RnyTiC5IceiZuECIMobxIk3GLeISYrTIdx8rG8IANvkb5UL9dQsiJtiuO0wM6z18YwWDWHxrnQuz31MsFMJsvY3DkVxr48wUuL4oQxz0x/ZDTb72hWGcVBJ4H6zR3WvxZ/SM/6ljBc+EqAa6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750396242; c=relaxed/simple;
	bh=wTe9sZu+7w2/u0QZ1g9JhwPm1diF0KdniHSnNJVGwEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQxzzA5uhDJtK66z9FXrZwuZUdPqDGKbtj4D5RHE60aPA2zpfUPcb6Up+Oq+/Zu4YfkN3jz72C7W89qEjO1IIK/8JFNCiiKxPv4SfjxIpGVZ7de0nFXeCDM/Q0aVOKjPL/K54wRfgWL1Iy3zba9raD04h5wm4Ik6XZAuW5DpO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JOCUVuHm; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750396237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EbmDynAdqvSSqw5yXcEWVeaFPATe2PmYKwtuqurNZ0U=;
	b=JOCUVuHmW5dkBwVq9b8di//Jc6GWwZV0X18Wa2ZjO8/HBxPwlx7KZf4CTlql/Ry0gphvjs
	KiGBaPPom/+h1mMUEEwHtxdFAJD+X90F8fsRLIf8MauifA93mm5UsG85JlfV7EdS3O0bWy
	gvwtpEnny7G2yYh/1xO2J93AGUWszKo=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next] bpf: Add load_time in bpf_prog fdinfo
Date: Fri, 20 Jun 2025 13:10:17 +0800
Message-ID: <20250620051017.111559-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The field run_time_ns can tell us the run time of the bpf_prog,
and load_time_s can tell us how long the bpf_prog loaded on the
machine.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/syscall.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 51ba1a7aa43..407841ea296 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2438,6 +2438,7 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 	const struct bpf_prog *prog = filp->private_data;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 	struct bpf_prog_kstats stats;
+	u64 now = ktime_get_boottime_ns();
 
 	bpf_prog_get_stats(prog, &stats);
 	bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
@@ -2450,7 +2451,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "run_time_ns:\t%llu\n"
 		   "run_cnt:\t%llu\n"
 		   "recursion_misses:\t%llu\n"
-		   "verified_insns:\t%u\n",
+		   "verified_insns:\t%u\n"
+		   "load_time_s:\t%llu\n",
 		   prog->type,
 		   prog->jited,
 		   prog_tag,
@@ -2459,7 +2461,8 @@ static void bpf_prog_show_fdinfo(struct seq_file *m, struct file *filp)
 		   stats.nsecs,
 		   stats.cnt,
 		   stats.misses,
-		   prog->aux->verified_insns);
+		   prog->aux->verified_insns,
+		   (now - prog->aux->load_time) / NSEC_PER_SEC);
 }
 #endif
 
-- 
2.48.1


