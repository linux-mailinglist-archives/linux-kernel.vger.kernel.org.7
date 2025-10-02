Return-Path: <linux-kernel+bounces-840532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C16BB49FA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 19:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E8819E120D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB33267B89;
	Thu,  2 Oct 2025 17:09:46 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5A686342
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424986; cv=none; b=NX2lDemi5Y5EyIq3/59RGVH7jicCwFzCB7DygL0NP+S0bu9fSJhIiCg4ym6uJV/29GACg/qI42JQnSatSL/Sp7NhY63lRGIvGERclIjjWWbaYtBTO/5WYJVN+NO/7qbtxbM3Cl1KD6MW3QmA9NuBkdbD9v9kFxTMfCruiVcg99w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424986; c=relaxed/simple;
	bh=wV3apveSRN76n364Q4Xgge6Ku/7v8/2U94tI1XcIKwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A3m6i+rdo9kZ59/JLkp8OmFB2k4OyVRtNB3b+w5MapRrqRINsNnfxELCswtO3is+4mqlwIStBSlVHAHcSnZrCAbTwz+897v3VCfKo7k7cNNvFbOGRF7Y1D2XySI5j5PsaPKiq8qdEcZybkKS8vs68Bd2pMBQNMpGf3TnOegWBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so6238385e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424983; x=1760029783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALhMC3B+HG9RzOr8Fvsyhus8tagwxCMBXxlTBDad21U=;
        b=jOZKJIR4OAOEmTI+TzFttY8JkKFmZpuCsHRsIOOSSggmfj1Nxh/0b0hEEFnXUrJAWs
         bHPzOMXFxftbkmWGY72vWYZ62dSYEHSZHSFxGGHSvKV/+cnjRTUQXkHbndvUWaRJjJnq
         uuPojzKoYFiDXtRfHq8bnGtPhKsTLGRL5/IiK/zUwUwiRSM2XAdUvzHnEcfqXe0L+7sV
         jqkp2hagdOPhYmPtfgmeMhzYO/9g/LFp+FocYXeu0VGuKofVba0lgvG80acpBL/cDwov
         4isLl92VKCZVSJEofrcxVt96lwdKdLmDlzX3AcA8qc6z61c0j5eKhXXwMdXonAcRlem5
         BwZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvSju21JjBr5ZUWdAdgUs1Nq9eMEj+RtIA58orB/h30DhTvjEWhhnnMSNaMWWX7MSbC1dJWBBeUohG3Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP8DEHfhlVMLg9AgVeBP8fiA6U/FZTN/JsAiweDmKQlAij9v7r
	WltkrLE1k+N7NbdnpUvyWNPbqsP6g6qLC9aJomJr6X4tM1PMuJK3p3xpDul7WuAC01A=
X-Gm-Gg: ASbGncuYz35Rc4g2IDJOihBRcFmLQtwFmcrATgBxP1bGxv+LAk60zcPi/MSmUdVAaNA
	FwUnLrSwVQ8jeWL041zEjXyJR+wFz9SsIEz9sBFk6dP58cTJBXlgv9zelq5NlVUGBFU3n/w7xlK
	yQ0r+qeE++ib7XApROQPw5/Xgo/keyKybQLBHVrs2pqN+Gd8uFLlrAUXpwuDBZKXWiJXawFt46B
	x6FbSmHt45w/IyCh+hnVjXqw5BtYD6+txGdPHH5KOdM5X2SE1+coXqajMvGak4C1Dh4ApzP0Dty
	SFkv4SnHfBvQ7Z7VzmqNn9QvFquDv93Quj8Axu28da8pSrAWMMI8x39TR4B9w+HHJdA8Gn+EIYe
	K0zB8S8UFWKt8B3TmRmE3te9hHzNdR+ihoKwDmBIbRn8tfxnnu/Q=
X-Google-Smtp-Source: AGHT+IEYZDN8Vs/SGTNR8tAG0UxJGfa0XX0wxDzajLCBKTWIabOxTdsv/uzzOyq0NfdbKIuezVvROA==
X-Received: by 2002:a05:600c:3556:b0:46e:4004:a296 with SMTP id 5b1f17b1804b1-46e71109df8mr282575e9.9.1759424982964;
        Thu, 02 Oct 2025 10:09:42 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe90sm4407649f8f.23.2025.10.02.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:09:42 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Fix unassigned nr_cpus
Date: Thu,  2 Oct 2025 20:08:45 +0300
Message-ID: <20251002170846.437888-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In recently introduced timerlat_free(),
the variable 'nr_cpus' is not assigned.

Assign it with sysconf(_SC_NPROCESSORS_CONF) as done elsewhere.
Remove the culprit: -Wno-maybe-uninitialized. The rest of the
code is clean.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/Makefile.rtla  | 2 +-
 tools/tracing/rtla/src/timerlat.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
index 08c1b40883d3..1743d91829d4 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -18,7 +18,7 @@ export CC AR STRIP PKG_CONFIG LD_SO_CONF_PATH LDCONFIG
 FOPTS		:= -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong	\
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS		:= -O -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2		\
-		-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
+		-Wp,-D_GLIBCXX_ASSERTIONS
 
 ifeq ($(CC),clang)
   FOPTS		:= $(filter-out -flto=auto -ffat-lto-objects, $(FOPTS))
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 28ea4f6710c1..df4f9bfe3433 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -213,7 +213,8 @@ void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
 void timerlat_free(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int nr_cpus, i;
+	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int i;
 
 	timerlat_aa_destroy();
 	if (dma_latency_fd >= 0)
-- 
2.51.0


