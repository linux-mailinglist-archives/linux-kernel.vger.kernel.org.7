Return-Path: <linux-kernel+bounces-855125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C893BE04F0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 02CA73528E7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936530648D;
	Wed, 15 Oct 2025 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2ys5lgE"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041192FF14D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555318; cv=none; b=kRsBe8ASRWJSmvfrEymfxEx5Vm9rDTRjHTGcvOLCNgVqAfqF0u9dvG7JNNSQiWRASlAtmXgbdm9M5uOXMMnBSlgy98FxCc0fH2WaAI4sV5z3eZAlFW/X1x9LQ0RtqEtXKnxHUNcGMWs4QwgXop8FxoFuqTlkTH7w2/tfgULPZ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555318; c=relaxed/simple;
	bh=Zjie/6h9688PXeDDGg8W8+IR7jPAwonzHziJnGJ5lUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CS8bOFv6VZjnpB2sg8I85OCOjGtRLRUoho8r6iNK4KU//925mUdabnAV6HV3gyO7X3Y6Oyhdxh5tPkf2JCgcus6G6R4hO3SjNS76+u/8Ywq4Bo8SNxWb9EEm750EQAZl5L7jMqepTYs0ous6TqFrx+WHfWu1XVKSl8Jox6AMa8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2ys5lgE; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781251eec51so5720551b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760555316; x=1761160116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4+5aOgvWODOPGtO0hDqGiqO++kewzL0OPl+hME7NKc=;
        b=g2ys5lgEgG7xXvV75IxrLSTh2/nW0796DPJwLOmyOWhJu++bzSJiAHgJtOJnBcincw
         o2eHt6mFnG2Bw7V1Kc+SPq1T1eArnau0oxyynCW17b9w6e1pKLxTbFCWV1KZd6fFALf1
         1rXVNnH0Xrox9xwjHGv2T2shm+YUMidbgeuRvPTnRIVtz8ZkJTin7irmc+T8g8tT8Jrt
         VFd8Xx4bLWKAiuAyflUzBAam0JpwmodfPeHyf/NenovJ0uXM2jM9h72QijcoNA4yLrfj
         2I0hvOIRoemXt+9ypqSCjv6/UHbdgrWsRJbRrO4MwRSufaMEUFgR9MvzIKYd1B1r3yG/
         NwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760555316; x=1761160116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4+5aOgvWODOPGtO0hDqGiqO++kewzL0OPl+hME7NKc=;
        b=m+LsF39E80VsgRwNCup5YRekTOCMKv55xau+TkiSFLuaMR86IYa/eeIstXU7UrHObq
         O8dCRXJhzw+Km+eb4bchBJAXDylicpdaaH3Z/BXMh+AfTCfvvu+AeCaqZt5x9YdVs7kT
         8/w+oCj7NMbMWavxxusUFFNYVJaW6yu7iazbmsnhXt9opovDyesAlxiCwBP+h/sVIGIq
         AkgoEs8qF5TXdKhAkxtYvhOpJksOGiG/s3/pJEpwt7h5a63bv96fdTz6uguQHnYzeCnh
         ki809Uzub1XtD3JKBXpwtV/UXzQt/l3DYIkz9sOtE6vhKr6GIHsJrgq12ttvHPOljt15
         wfWA==
X-Gm-Message-State: AOJu0YwL5MZuMwLzVAXrkcoSzShdUydRo2ViS+eljDSOCyekuTOfqISh
	3gETvpG41iJY87haBq9ZQEnKPCfjcsw8iAIiv42Ph7r25TfB7tYDsLNQ
X-Gm-Gg: ASbGncui2UgF7/+YMmI0Ek1E9duc3ItkERV7ZQwnIqOseIkYJbe6q1Vpb+mO5QqW4Vh
	JZCsThUFj56eqmPQ+kFImwHCXBdb0gR8z7r0d+YVFgfvoLQW5fSv8UmbpMKKR/D2syxIyRTwgNr
	L6/k/N3IrOzc4uZ8t0qH9vBoHN4p0QGdTVByPrJX/F2DK3fGby+tWPaKS0au2urtEWed+ScMnRP
	SfQncfDGcHQ5+2v7steMPmvDy2H03ZVZs52OVMeLCwIl1vveOWGHghk+EyawCoI/48YRDe9gx4Z
	CuiUA8Qj3oX0Fnk+z1tmEiseucNQtGsMYpFoRsA8Sp1Fc0VxUOsQ+biZIq+0fgAqZuAv6OYmFCk
	Sj07YymNtkgGnOkrHC1iTB6L7r/4PxNtxvUCxz3egQFHzH+mKRm8SHTW9jNUObVThwhRsrw==
X-Google-Smtp-Source: AGHT+IFmVjoy0/RXg9J2/ujgSWA6hbqUoUjXe12ni5dKrJHqDFKqV95/Gh1KnAb6dMRdJCKgoA9fqw==
X-Received: by 2002:a05:6a00:182a:b0:781:275a:29d9 with SMTP id d2e1a72fcca58-7938742c7aemr38835163b3a.18.1760555316194;
        Wed, 15 Oct 2025 12:08:36 -0700 (PDT)
Received: from jpkobryn-fedora-PF5CFKNC.thefacebook.com ([2620:10d:c090:500::7:1069])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm19483106b3a.69.2025.10.15.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:08:35 -0700 (PDT)
From: JP Kobryn <inwardvessel@gmail.com>
To: shakeel.butt@linux.dev,
	andrii@kernel.org,
	ast@kernel.org,
	mkoutny@suse.com,
	yosryahmed@google.com,
	hannes@cmpxchg.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 1/2] memcg: introduce kfuncs for fetching memcg stats
Date: Wed, 15 Oct 2025 12:08:12 -0700
Message-ID: <20251015190813.80163-2-inwardvessel@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015190813.80163-1-inwardvessel@gmail.com>
References: <20251015190813.80163-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reading from the memory.stat file can be expensive because of the string
encoding/decoding and text filtering involved. Introduce three kfuncs for
fetching each type of memcg stat from a bpf program. This allows data to be
transferred directly to userspace, eliminating the need for string
encoding/decoding. It also removes the need for text filtering since it
allows for fetching specific stats.

The patch also includes a kfunc for flushing stats in order to read the
latest values. Note that this is not required for fetching stats, since the
kernel periodically flushes memcg stats. It is left up to the programmer
whether they want more recent stats or not.

Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
---
 mm/memcontrol.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4deda33625f4..6547c27d4430 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -871,6 +871,73 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 }
 #endif
 
+static inline struct mem_cgroup *memcg_from_cgroup(struct cgroup *cgrp)
+{
+	return cgrp ? mem_cgroup_from_css(cgrp->subsys[memory_cgrp_id]) : NULL;
+}
+
+__bpf_kfunc static void memcg_flush_stats(struct cgroup *cgrp)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return;
+
+	mem_cgroup_flush_stats(memcg);
+}
+
+__bpf_kfunc static unsigned long memcg_stat_fetch(struct cgroup *cgrp,
+		enum memcg_stat_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_page_state_output(memcg, item);
+}
+
+__bpf_kfunc static unsigned long memcg_node_stat_fetch(struct cgroup *cgrp,
+		enum node_stat_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_page_state_output(memcg, item);
+}
+
+__bpf_kfunc static unsigned long memcg_vm_event_fetch(struct cgroup *cgrp,
+		enum vm_event_item item)
+{
+	struct mem_cgroup *memcg = memcg_from_cgroup(cgrp);
+
+	if (!memcg)
+		return 0;
+
+	return memcg_events(memcg, item);
+}
+
+BTF_KFUNCS_START(bpf_memcontrol_kfunc_ids)
+BTF_ID_FLAGS(func, memcg_flush_stats, KF_TRUSTED_ARGS | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, memcg_stat_fetch, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, memcg_node_stat_fetch, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, memcg_vm_event_fetch, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_memcontrol_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_memcontrol_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_memcontrol_kfunc_ids,
+};
+
+static int __init bpf_memcontrol_kfunc_init(void)
+{
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC,
+					 &bpf_memcontrol_kfunc_set);
+}
+late_initcall(bpf_memcontrol_kfunc_init);
+
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
-- 
2.47.3


