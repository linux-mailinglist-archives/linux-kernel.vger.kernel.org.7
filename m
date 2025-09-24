Return-Path: <linux-kernel+bounces-829902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C911B9826E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 05:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2867F4A364C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9584D232369;
	Wed, 24 Sep 2025 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SBXGZ2/z"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512A21C9F4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758685344; cv=none; b=EtxXlevpS8glJHbeM7sTq/gpGJhswBnT/F4bU4tY5DBXxNYEoYBcTFmm21KgDUCXnTl/FK+Y55QmUJKFmuEBwXVGdPQdS7bvfR5e0ZfkR1xEER45nHI2A6oKPIF2bPXazAhd9HzBAjtg3Tj4QcCuESwLomcxaWtxS45D0Y3gp9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758685344; c=relaxed/simple;
	bh=JfIAWDuN1kKed0FYgT3jkRN7qq4iKlUIG9GpMZNLTHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xvn9lpg0Vr+X25Ulc5q8JD02S9fsK/f0Q9wY3F3wr6HipWXjdBQvXebBaOmEchI9pLUNqUoOJNIkE5NLLaHo1Wm1haiwAFcFsQMmAHZMPsH3+VcMZ5MjlzmPFF9SwP4S/U4kQmk9sOlhjrUtTr5cJHCm9NUMqxswtlFwvxLRhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SBXGZ2/z; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-25669596955so56564175ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758685342; x=1759290142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsJTV5DUFz04JQKhysbzOjs1PoDN4ekmuz2g31Q2mg8=;
        b=SBXGZ2/z/hWy7nePgRqH8oxZEzeaEJs9yMavjspCzkBvWRyR9xlObEeOz4k+Cje6Ok
         W3k8l/oWd8mvxJThE6O7vUR9pY1CKONA2L3J7KRiQ0IWZUiTDpwrfiiJBKttHZ0MAJ9f
         RbRuq3zG8/Lwlot5q+qZIueQsWDJRnHzeQ1K7KeJGCE/TgKDV/UDm3n5lM/k/leUaz6t
         GKqewGmKapr7WeqT3C4oA+MINB/DMV5Xuqg5sss7Z/vTyMPxxbPJjPjUPJOR5kvGbIo8
         ZK0fUuqHhYFQ5timiDiS91iJVs6l4SeaMRnxIi43+snVC8dbKGvanPDBxXJZWM1OSdaG
         g0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758685342; x=1759290142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsJTV5DUFz04JQKhysbzOjs1PoDN4ekmuz2g31Q2mg8=;
        b=cqYfe53FuOwGmrtYSDAZz6dQry46LbVm7SVoUmVJHS2JwdS8h3zo7QMZ8IZD4l14Fs
         rNsVSJNyV30mNKHljvw20cYmpbQ43EC7A+e5dfxR8Gra5caJlEM7TdPVqV/amXHdZ48Z
         S7nFVlHHpvaiWHuiEJ5qZb2qErBBSOLrb/Yr745a8RF/y/TE979tGYSAfXUg4U40xUle
         kLY8r59XdhASVyUnJp2gq5AwepmGHC+RPGr14/VoFonIHowKmsdfdjU3zEcgW0fQzQSF
         ofYr/PhMhxpQs61DlfDdP3jNS81kut/FAweL+d5f6f7vSctYBNPspMdTDxVQtcjWIP6/
         Q2wA==
X-Forwarded-Encrypted: i=1; AJvYcCX9G+mVEzVGMuTspwarUKs10WoCSl+hJXucyzu5gloXnaPtil6ThpJlM6eyMaG+W7tDEXBmLbG/joMD1Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbw3GIDdLIUAbQEENxVkqLtPRh5nS5ojyMn754am9iLpgpFQB
	xLnXRT7X6CMO4mxqhN+bh03QTwTES0JtyBO4QGGyrZ152rxbCfGCVpOvYk3ABGWsRdE=
X-Gm-Gg: ASbGncu1I3c2Jab8xpYMcWQr1dRX3+kzGaFIjdfwSYZnW6zkLA1kmACxnhL4K4Y/3Kr
	9Yc+oXYVb+NY0Zgpgzhp8J+dW7nX2VfQ7smvXoey6QGuz8kh15B0fsH8YTCZBZRY6tZTh9Gwh6t
	112KmFDmZd1Pzh0I7cTd3l9zmb8gUKQsp74eI2O5emp0Ojpeoy+3MWtixph3RKW6GOhOCnaLLfu
	lZarmCT5FdQD/qNr8OMu54FQdEcjCFvTKwYhifY+v2Sau3QJgWNUGmZNblA/cdJCGjQDn69rpRI
	vcVpK3sDpbTzH5y94GwTVaSuQ5Wu0zCZG+Y5zeMBuvrSrzyS0SXKIOMTZz2EsKFn6PzU0CWcJR3
	YIJJOIkvyUH8K69OXR86WH/aBeNrKLanYag==
X-Google-Smtp-Source: AGHT+IGrcT5Ka2xMEBu3sbqKbDUXPNl6amxvjYaBM1CXrmwchGIMFPPAdgNK41sSgXmtBkVzwz8xzA==
X-Received: by 2002:a17:903:8c6:b0:269:82a5:fa19 with SMTP id d9443c01a7336-27cc61bed26mr61207375ad.45.1758685341761;
        Tue, 23 Sep 2025 20:42:21 -0700 (PDT)
Received: from localhost ([106.38.226.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2752328629fsm88067475ad.106.2025.09.23.20.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 20:42:21 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	yangyicong@hisilicon.com,
	will@kernel.org,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	peterz@infradead.org
Subject: [PATCH v2 2/2] memcg: Don't trigger hung task warnings when memcg is releasing resources.
Date: Wed, 24 Sep 2025 11:41:00 +0800
Message-Id: <20250924034100.3701520-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250924034100.3701520-1-sunjunchao@bytedance.com>
References: <20250924034100.3701520-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hung task warning in mem_cgroup_css_free() is undesirable and
unnecessary since the behavior of waiting for a long time is
expected.

Use touch_hung_task_detector() to eliminate the possible
hung task warning.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---

 I didn’t add a fixes tag because there is no actual bug in the
 original code, and this patch is more of an improvement-type one.

 mm/memcontrol.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8dd7fbed5a94..fc73a56372a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -63,6 +63,7 @@
 #include <linux/seq_buf.h>
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
+#include <linux/nmi.h>
 #include "internal.h"
 #include <net/sock.h>
 #include <net/ip.h>
@@ -3912,8 +3913,15 @@ static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
 	int __maybe_unused i;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
-	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
+	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
+		/*
+		 * We don't want the hung task detector to report warnings
+		 * here since there's nothing wrong if the writeback work
+		 * lasts for a long time.
+		 */
+		touch_hung_task_detector(current);
 		wb_wait_for_completion(&memcg->cgwb_frn[i].done);
+	}
 #endif
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_nosocket)
 		static_branch_dec(&memcg_sockets_enabled_key);
-- 
2.39.5


