Return-Path: <linux-kernel+bounces-834835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C392BA59DB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4629189251E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B026F2BD;
	Sat, 27 Sep 2025 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD+/9bIz"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06AE266B65
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953546; cv=none; b=SVlnKv5eVjO3gQJXCZZc1n90u/V0roqPBKoj4v8FqKhZjfVChvk5KF0HE6+Cdr/zoyexhmPUY7G/WwDuXeDVsUcKORzTAIz6JWWcGebt6EkINCDEb3cbt1HEzpg2rqygJ+k3vcbrzJLrYywX8ZZv3BWhAf4ZTVm3b1yoHhTYChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953546; c=relaxed/simple;
	bh=fBlHosf2/zvejIv57ZYqYOF60ZxxB1BajuHB1xTY+ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu+TJOsQgBjEt6w/NIYhJuuNDN2Pi019Cdq+2r4qfA29Q4B2P42YvrLtyMw9/2Sj44cv+OIGTOV7Zo1MsiFxe3tcm8qC8Zg8PdZwWHdETEDvhCmZwzhmd+fKy5yvzk6Z67sUNZ3PdyOqjgNrFn8EHY89u6T6izzO3uUu38YXWgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gD+/9bIz; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so3134465b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953544; x=1759558344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Jp+qjVdWMcusFzgtd96nBGosQ9jiWGo0qwLoOLfmA=;
        b=gD+/9bIz5KVyKcbw4Pkk6BwoMcI4Cd0XrbfXxHhllMoOr2QRoB+LvVL39qsa50yjsc
         REFgLyYkqJA8gYOBEelml5tLVZlOH6zajMnKyh4hPdamrDlb+tLHqtUDLpeG6DKWaEo5
         SSMILFd7BP9f7+a8j2ke0R+S3eqOWaIH8wpZoXbgDmkKsDwVEk0cfYe2SFoY74MGQE+3
         luJ0OUNtZP7S8+sKrNzuE4zNAh9Oc6jKBdsgIsDnqGqFo8Mtu6Th8JiuMz1l/XcSRk56
         T5Vc2X3xJonGo858L8rcedz6OMT1j9gKijl/NXR0ro4pfyZDu8QcTs7LYESqEyaOxwBs
         zZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953544; x=1759558344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Jp+qjVdWMcusFzgtd96nBGosQ9jiWGo0qwLoOLfmA=;
        b=tTQ8fanMzNzkDoSh1XnYHLNPe3HXWcc0Wtks7llxXU712iqGfPX7fnK4PS8DTDBqId
         //UgOSyvmSZMtbj/LJ4iajLSaEzvrdOhXUUPI6GpaPYAwdaL9Fi2XOHcz3igv5N3lIzh
         SLReZwlIrSarR1XpOaQNQT0iayGE0WfUtngRgI1WZB/8O4muwZJ4nGfkXVx3oxj+vE5r
         YCSTBfAZ4u+WmJ53n+o2/bWhIwRywjTN0tNLqNSWREsIaz7BV4s0Qr3qGdxQewDVqYWJ
         FMEolETbWGfTvRee37xpSZBI1km5n+eS8sb0dTaMlyc0EWsDuMM0MDepq4qcBr7KPque
         RnXg==
X-Forwarded-Encrypted: i=1; AJvYcCUepRbCW9RfyI2YJauCR39AUH57nQAWg3bEwWJrAfHMAxvdoQED1EqZP4ilGwAru8dQwPVUS0X5Cl7GrAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9sMmE5857j6baE8wAAseN3YfD48CZKKEGlCSw61oiOBoluSoZ
	hS4/L9G3SgbEN/CdkyLagR75cVWid2mKtnEzsO+D4MnC/UijRSh6zzUu
X-Gm-Gg: ASbGncsFOqNtcogvgdG/K9I4vrqFjdSHtwqbCBbgKdn9q6T/B4WPm3vRI8I0o30mCcP
	ALVxq8kVw9dqfvMWKMP0rJlI7BsuP1SRB79ONorXYkwvyZklA+mKDBbv+VYZKveK7ZjorfXOAJw
	RrZMnCaeVorjjctz3KqBqP9HYHdAMU+Ff2iFOHe3gbZY0iFlpjt5DGIZA1BCNJjp5amOwhhCHid
	ZGzXkpyIVdulWmxWOaDydXuS31JOR9mJgJ2rX/nyoPXHySfg8Mm4DqlHeT3pv+Hi0jxfyXJfdAQ
	LmzV5KSJI+/AF4gBU4SEJVLVXlirGTIyzup5g66YeqMEYixG5rZh3IHcxE5/8eXX/jSQiCj5a+Z
	ZHi4+1ma9Pv2saNseMIBLUcxpb/GtBQ==
X-Google-Smtp-Source: AGHT+IEJe1SmIZ4vtGUSEc51qPCpwyaDRPdqeCJcR2WgVyuD1Dm9GF9xuSOGKmCoRI818lwEOUPn3w==
X-Received: by 2002:a05:6a00:3c91:b0:781:1562:1f92 with SMTP id d2e1a72fcca58-781156220e4mr5744775b3a.26.1758953544077;
        Fri, 26 Sep 2025 23:12:24 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:23 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 3/3] selftests/bpf: add testcase for probe read fault
Date: Sat, 27 Sep 2025 14:12:10 +0800
Message-ID: <20250927061210.194502-4-menglong.dong@linux.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250927061210.194502-1-menglong.dong@linux.dev>
References: <20250927061210.194502-1-menglong.dong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add testcase for probe read fault to stream.c.

Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/stream.c | 22 ++++++++++++++++++-
 tools/testing/selftests/bpf/progs/stream.c    | 21 ++++++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index c3cce5c292bd..81fd258b97e0 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -72,7 +72,8 @@ static void test_address(struct bpf_program *prog, unsigned long *fault_addr_p)
 	ASSERT_OK(ret, "ret");
 	ASSERT_OK(opts.retval, "retval");
 
-	sprintf(fault_addr, "0x%lx", *fault_addr_p);
+	if (fault_addr_p)
+		sprintf(fault_addr, "0x%lx", *fault_addr_p);
 
 	ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
 	ASSERT_GT(ret, 0, "stream read");
@@ -106,3 +107,22 @@ void test_stream_arena_fault_address(void)
 
 	stream__destroy(skel);
 }
+
+void test_stream_probe_read_fault(void)
+{
+	struct stream *skel;
+
+#if !defined(__x86_64__)
+	printf("%s:SKIP: probe fault reporting not supported\n", __func__);
+	test__skip();
+	return;
+#endif
+
+	skel = stream__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "stream__open_and_load"))
+		return;
+
+	test_address(skel->progs.stream_probe_read_fault, NULL);
+
+	stream__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 4a5bd852f10c..290c40463522 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -7,6 +7,8 @@
 #include "bpf_experimental.h"
 #include "bpf_arena_common.h"
 
+#define READ_ONCE(x) (*(volatile typeof(x) *)&(x))
+
 struct arr_elem {
 	struct bpf_res_spin_lock lock;
 };
@@ -234,4 +236,23 @@ int stream_arena_callback_fault(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__arch_x86_64
+__success __retval(0)
+__stderr("ERROR: Probe READ access faule, insn=0x[0-9a-fA-F]+")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_probe_read_fault(void *ctx)
+{
+	struct sk_buff *skb = bpf_core_cast((void *)0xFFFFFFFF00000000,
+					    struct sk_buff);
+
+	/* do the memory read */
+	READ_ONCE(skb->network_header);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.51.0


