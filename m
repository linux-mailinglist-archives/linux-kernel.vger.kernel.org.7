Return-Path: <linux-kernel+bounces-814360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728F7B552EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D486BA2044
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1FE32A3D1;
	Fri, 12 Sep 2025 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RkLKDK64"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90356327A22
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689861; cv=none; b=rfUREESM/uWsaSEUIa0p05ijclwdRM+L8Aen/fxYGBKobDKWeAhvzOmAVZEhOTTam83qX+2ukNa7jKSiO0rLq0d5H95DFqUhF80vpdzD2xILtjCfm7b0cSEqWfo+TMbvVQquqzb9VqJesqTG3mlVzd/DvNx6Y8kmcgtUZCWTMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689861; c=relaxed/simple;
	bh=y6R7JHolSByTQrZMijPqGMycDGbxs6NH+B+6pGvmKpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDwW9U9YR5cJOElFV7q8wNgbKgOh5zjaR8mxW315TXISqtOi2owKvK4GBo9e1HfHDid9bis+6HcItwhFRmdV+As8dpkdbJoEDOh3eEmKBsl/SnUqskCq6yr/wGXWHejtpqOpmkGTTvVYHmSurj58OOHa1U4D5poiyTy23CyJZIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RkLKDK64; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-ea3dbcc5525so628497276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689858; x=1758294658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQyd/J78t59e431BzK+r1hLIHKrEAjBfy36U2OzrJzo=;
        b=RkLKDK648r9G39cYNUgxAOkTYXEi2/89mqteQ158UtaweCw6CikKqdSLRll8g0cHql
         qRxTuJrsWD0ihRSERDZuXzora7vcp8ATffCF4huACVPct1VvjVWD2nq/KK0PEWriuuLE
         V6RC44iPBH1NihSdKirV+JOfyCZ1lTWHtGH0frmoCOX96W1rNDHhysfntO28vlTE38B7
         MdPsuoE0+HqHemQ6VXwnwNc7fBPzUNDAwfWLAquFf2P8I1G/dowEFb/dmQwCyMpk7AcG
         vX13zFnYKk7wUjiGbHMIAQtDvjn0nkWJl9Vyj5D7EYO1n1UyJBw/7tLB2hZ9RB3Fpt4Y
         SWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689858; x=1758294658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQyd/J78t59e431BzK+r1hLIHKrEAjBfy36U2OzrJzo=;
        b=WOQOfsuBydQiVYIZNNF6vB8O9e+/EoXzW6Kez4NLzBXkBL78HKia1Cvtu5V2nLalBp
         qkuYblyhuH7qqNmw4NAMZK6j6zkX7zxijibAraASuhFbRFJYSwPhfJcIYQvAHSzsIg44
         myLoI1j5bwnc5DSK9aaQUMWa90dP5cGSb0yGNu6sSHb/RLaADZ3m3djp+AZPJX6M5KQU
         6bVV6vyrHikdeq1b6PV5mqk0QQmNHfx3Xft9xr2GkJ6ry4iXbpmo/l5ZQOtliuvFqFiX
         wiTt0ft5rF+kHGi/ihXXJqQvqBIAvHxLMx3R+VWHTEKwxJgUIzXz9XocSaXlFcia8EIW
         HjtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlyKHuAp5KIt7fGw1DuEfmqwZg1IgQqWA/Fk4CLUF0/Uby4qfcZm9EWDJ1bIsIErK+7wqs2mqw8IySngM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdgh8h9KBcU/wRXvqiGDOlLXYIji3LHbPMWe0kiaQByuTWM9H1
	xP8glhmb87A5831X3hs7hQtKZrEh3rNSOWkBqc+jzHuCNbQ0ZMKyRIeg83S93SZnwc0=
X-Gm-Gg: ASbGncukVUpRQaofKQGJGsHBtEeA0ok+3GRIODFDQ7tVaXsyI8Jga/l7zhzr784N6jA
	e4iyMo1sWjEesnZErL30Q6yVcEfU8SM21y8NCnxpblK9ezad3hy2Gyb5aLgPXuvtAMdgT0gwNtZ
	6HiEedK1vfK9Np62IDM38W1gEsB070RSgtWGR4Na7R+zslWxUa0+AJdvOZtwmF0koVY6vbw4fFz
	KbdZAPACV7izDWH8GwMdm8Ep1vqbIOdB5tCn8BB6yb0c00YDjzhwHJ1xXRaNBurAUsb5zvFrWj3
	/lyQd0YrLoROwHHLPm6Ho2wvdLlN+jLbFUSUn2PLeNl78BlH/71TlCjnuuP8XFulaQcp61PANvN
	/tDYtfr5qQTFigxKJghWvK+ulFE/5F0C1bQ==
X-Google-Smtp-Source: AGHT+IHiWq2tZ0Zh+6RCMZ5n4YEMDF8GDIlS1UolWn0dcdm4mJQCk7ANF/Eeoayp4tEVnT1oJJ4YdQ==
X-Received: by 2002:a05:690c:6089:b0:723:9ba7:7f9e with SMTP id 00721157ae682-73064cfc375mr30364727b3.25.1757689858316;
        Fri, 12 Sep 2025 08:10:58 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:58 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 13/16] sched: Add sched_get_runqueues_area
Date: Fri, 12 Sep 2025 18:08:52 +0300
Message-ID: <20250912150855.2901211-14-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add simple function to get the runqueues area and size for dumping
purpose.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/sched/core.c  | 15 +++++++++++++++
 kernel/sched/sched.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9af28286e61a..a054dd1fda68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -120,6 +120,21 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+/**
+ * sched_get_runqueues_area() - obtain runqueues area for dumping
+ * @start: pointer to the start of the area, to be filled in
+ * @size: size of the area, to be filled in
+ *
+ * The obtained area is only to be used for dumping purpose
+ *
+ * Return: none
+ */
+void sched_get_runqueues_area(void **start, size_t *size)
+{
+	*start = &runqueues;
+	*size = sizeof(runqueues);
+}
+
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
 static int __init setup_proxy_exec(char *str)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b5367c514c14..3b9cedb1fbeb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1330,6 +1330,8 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+void sched_get_runqueues_area(void **start, size_t *size);
+
 #ifdef CONFIG_SCHED_PROXY_EXEC
 static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
 {
-- 
2.43.0


