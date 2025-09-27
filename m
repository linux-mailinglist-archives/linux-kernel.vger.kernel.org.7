Return-Path: <linux-kernel+bounces-834833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F9BA59CF
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1275C188FA04
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFDA25EF81;
	Sat, 27 Sep 2025 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKvZJDAJ"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A53258ED4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 06:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758953541; cv=none; b=Vs/7nLWS3i2m/dt4EVCg4M08Bg1ZqTEMG+n5JvNRDseyw6qAXfCNM7chZ0McWgLRSlgy5MWhD9oV2i4lx+2VfJlQKlB/eoLRrHI899rEa80ghJd/IoDF/qe7b2cIRPBqkcoskKPNu8eaLcGvHE28hHGXSMmaS/bhNQn6JKEkBjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758953541; c=relaxed/simple;
	bh=qEjaAg7MkkdMQDjFjmkDjq7XcLyrEouJluZddB+eNqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPb+DnkCPT0GaTTgCbTt83Jlh9RrCgJvO0i1O2LV0jKY67LmxnPDg1Oqz92RUkdo4lQaCHm/RDsMmf9GMrPb8aqLucrz8BnqicnOOPOK2RnQugnNUmfduE8R6yb9fAVbEyemgtnCkazikFbx0OEbH5nWhHrXDpkRJtsEE/Lx/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKvZJDAJ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781206cce18so1091542b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 23:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758953540; x=1759558340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABDRs5ioZceZJLzcJ8Ewc6tgp2gu+8s+nwYVCmKuGc0=;
        b=nKvZJDAJEfBZ9qKqELDwnXmDXKR8LYAm80xUkxI7LNrZhVvYcu1hjZ9DAGw0XrAuJ9
         ob11EjBKsGd3BSuBvpHhZX+fC+o/IRfUMxdz35E7CqASigxeDHC6UdNlqcB2SkAUSW0g
         TwN41+4+9UfLhOe2/0e+j+DEBbY50h/qVxYWDe20ISQkeQQg4KVQC7NQIPB5mykG95P0
         JWx/wLLgQgswJmqcJS8LU5MhrH6Wdip+HlfFWDjjqNmyWx6jbGDgunIZli6ff4bxHs6R
         jZJYdx/QLkjVAEyU0re1747R8m1Uf6eZI2GV1fbSZOifhkqHKkYMRL6ctmGjh3Y97DiC
         cv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758953540; x=1759558340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABDRs5ioZceZJLzcJ8Ewc6tgp2gu+8s+nwYVCmKuGc0=;
        b=qp5vFxrLGmLMCg4HZ4KyFx/3oo2EKWcfeGhSGQxl3bg4f+xW+X87nV/yH2zSnXmabi
         oqMaErH813x1R2HgoELSQBniOypHjLzQ+37VQrpfBUL6NLjisdD6RSeX4CI46sLRl5tS
         LuOlJ2xcJW0GzKKPBgVqVas9R/0z7FcOrYLWzNRmPX7UFtjy98yafLW4e0Pe7bEo6yVj
         tw7CUAMrvvgD/7f69xI1vkDxLW1fsVS9AC75Bid4trU0HLqKtie1n9apahFgEl2CyJ9y
         Xd8xNxVdz7/LDglFgwjeM8PpqvDxHG4RjCsUtUGQg1bCj9PAZr8t3tQDAFe2VMNrJ+oz
         X8Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUAspp8qPZYQUanCcjJ1wrFr81xCsBC1vqzX1oDdolFuS3lQ+YySkSu4lwKbcsbYgKfPvQhUkPaMmDEWR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8eqjM643fLz4HsTB0Mb746hkmpCNxd5VjZMjzDBx2pL9hd7/
	LTl4muZm4sIZcRED33tYGCBSq7zDnkdezFC77loL3/4mAYQKsFf0w60L
X-Gm-Gg: ASbGncuJdDKTnwCzesbW+YY4Qg/FPUPmfx0TmggMjdNmtreC1iencjXQX+OT1Ylv2Nl
	lYezzbWD3lvgyeLGsLm75ZK1OcqkOB6ifpW1OdujKZSz7u8mhZBQ4Y02AWztZs/SNCbflD6vFNz
	8qifADDV8skLyd7IzA3AhNpg1aeTe/VTK0l14bT6SpB6mfUvNsSgNV0Cb1Ah4yqmFpY4EfoxQ/d
	tuErSHeVtt9HopESjk98VChjv/De55lBG4ub7r4jjllOhSpoc0NebKoXWGkPqSNcmxDpMlQ8eJc
	PK19TAKMtbNWrlnLcJ/arVZryWCQGE0M4qNSnLAqC6KpcLEiuxKx1yBTkPalaeDD+pwqdbFxA4t
	qRGoM2hVX+nJz15jXIlDTo3VaPZNhLw==
X-Google-Smtp-Source: AGHT+IHPDRdOF1EEadfXGYb4KmdSc5RgqVg4fiVWRnpz61eUUanWy9Ud2BWVtzZyZWqIWeSNkD/t/Q==
X-Received: by 2002:a05:6a00:855:b0:77e:eb28:c59d with SMTP id d2e1a72fcca58-78100f77c50mr8198937b3a.5.1758953539680;
        Fri, 26 Sep 2025 23:12:19 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023edda8sm5891178b3a.43.2025.09.26.23.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 23:12:19 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <menglong.dong@linux.dev>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jiang.biao@linux.dev
Subject: [PATCH RFC bpf-next 1/3] bpf: report probe fault to BPF stderr
Date: Sat, 27 Sep 2025 14:12:08 +0800
Message-ID: <20250927061210.194502-2-menglong.dong@linux.dev>
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

Introduce the function bpf_prog_report_probe_violation(), which is used
to report the memory probe fault to the user by the BPF stderr.

Signed-off-by: Menglong Dong <menglong.dong@linux.dev>
---
 include/linux/bpf.h      |  1 +
 kernel/trace/bpf_trace.c | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6338e54a9b1f..a31c5ce56c32 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2902,6 +2902,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 void bpf_dynptr_set_rdonly(struct bpf_dynptr_kern *ptr);
 void bpf_prog_report_arena_violation(bool write, unsigned long addr, unsigned long fault_ip);
+void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip);
 
 #else /* !CONFIG_BPF_SYSCALL */
 static inline struct bpf_prog *bpf_prog_get(u32 ufd)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 8f23f5273bab..9bd03a9f53db 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2055,6 +2055,24 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
 	module_put(mod);
 }
 
+void bpf_prog_report_probe_violation(bool write, unsigned long fault_ip)
+{
+	struct bpf_stream_stage ss;
+	struct bpf_prog *prog;
+
+	rcu_read_lock();
+	prog = bpf_prog_ksym_find(fault_ip);
+	rcu_read_unlock();
+	if (!prog)
+		return;
+
+	bpf_stream_stage(ss, prog, BPF_STDERR, ({
+		bpf_stream_printk(ss, "ERROR: Probe %s access faule, insn=0x%lx\n",
+				  write ? "WRITE" : "READ", fault_ip);
+		bpf_stream_dump_stack(ss);
+	}));
+}
+
 static __always_inline
 void __bpf_trace_run(struct bpf_raw_tp_link *link, u64 *args)
 {
-- 
2.51.0


