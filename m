Return-Path: <linux-kernel+bounces-751534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B49C2B16AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D8718C799C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9F91F4262;
	Thu, 31 Jul 2025 03:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZVtE8rdq"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD8219ED
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931007; cv=none; b=N3O5EppQySfO1LUXLv/Rym+l2chbsOByFhhRf0prxXYvIsooxUBetQPkqt2Lhz1o2k/6r0XoRa+HtJ/t7+n/lTbbZx2823Y1Q0mcVwDNcsFo4UJ90JiEq9pRgsJYkXpv4ssroECxSvWVnN9tQ/9tN4/Hs628sNYCXdmjg+8dL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931007; c=relaxed/simple;
	bh=7Irgzgha0DuZmhmsq5hqVvPdraoFqDxdn9SlLSg0v9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TwC19deMikxJKS4Ute0JiawwUOaAgCH/Aw18hHhepmDfm7O/NmylEpBSWYaNy0HyPbyCIXx/xPJnSZzLufPDeDnhqaW3BkommrYlSoEA8rvlws3iHQXp1AYU3AGwmRce8p4FpWhwsXoWYMdwlu84FQ/pylNREyjCPLFE5GZKB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZVtE8rdq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76aea119891so1372861b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753931005; x=1754535805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7HcVlcPsgEhYoPClv50jryiEw6txeqnarkLjEHm8jWI=;
        b=ZVtE8rdqCm7L41bka5W0JZlD2V7DP4O49azoyjN8wqrUG923rHIq8W15yUdAWc3qrf
         CCkNWtVfkODB6eJN9rM81WeJJUUcRMyAqX633nqX4WlHgif2lufWwD2pQHjk3ZA5gmUy
         8MGHV29/+G0juQwh2Z04sfWMii0zrRG7lrDP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753931005; x=1754535805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HcVlcPsgEhYoPClv50jryiEw6txeqnarkLjEHm8jWI=;
        b=rw12Helh2ZNH9Sv2EnrUqAuy+Jc86+QctQEyRTYNNYPuDaKqa0x5cPUY7DZeiQ05GL
         FPnhi9Bcq3vCPCoqKO2TlUPl9jj+Tmni87xLJiZCgegLg/dX2uWv0I7vM01LLZ5JTUye
         lWFlpMzy1nLd7J8h8FW7lcjZ006zKYAzz3p/nAZfKG4m5WuYec5om9VREsysQ/a1EifD
         oWTVfw9Tc7JoiETjbSoc59zYGysdF8s6wtoYr98k/1JuMSFIQ7w19GtGizUZrFl4uTWP
         NYla1/w3/cV1YZRyFk8eoxYEMmlSP3yAZNp7hs2LoEwtESRlh3TnQxRNX6/99Ch09/u9
         X5Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUxBGrHUYMfX8lpaErblJNPutk7NWhpBMMYJlobqp9dk0qsTkcv3/SRPTLVki+3bleiIIx4U88Z/DPM7QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUp/hf2Pm6YyX498EgzcHbhqpP7L2pBs5cY1NhXF1gtg7Zcm1I
	aFy3iTRCTjAK+4Bs6p0bK6+vStotRB7uXF4NgIGMr9Onyg5Bzifn4NOksmJ8RGyp/w==
X-Gm-Gg: ASbGncsmS/MxT6MVTkp3n5ipj048wjN3qCEtVq77T95Yp+4w+VJAUKlWgraZdwN4b6y
	hJLitE22L/OZQ3LEdYDffL2osxoK6T0oXxsNRmXWZUlVPxNSOfpDs08tqrleKz4u6IMPqAG/QAq
	SParhCN2lt9+EaNm2zAYTe7GgFTwnDaIVuGsVUcfswHO0SmiypmllGxSFnMs8R27DhUGCCohbHs
	LD4kgjXUaTNapDV9d/bjjXE3sZ7vbkBr+zgPHCdMsQTB9iioQ5B4SelEiRsqsvIakyuvMQal58T
	Zav4vYYy7VGsoZ8qfpFMKqVRj0TwfBhRGiwqOVMbQnXR3TfZ/ZM6PztYQgkdz4XQKH8fiYxVt9D
	ylpGtlWrLMcacGeJJsgnYwCwOYB/TEoFK+5QmRrng/iyL7HE=
X-Google-Smtp-Source: AGHT+IEFe8O8zpgMFSy3UVaiG9pKyg3BJpQPtmCfoiUrYUFn7NNWZG2byACseSDNhlWvw6hpdfIgfQ==
X-Received: by 2002:a17:902:f68d:b0:237:e3bc:7691 with SMTP id d9443c01a7336-24200ac174bmr9912585ad.13.1753931005508;
        Wed, 30 Jul 2025 20:03:25 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6490:361:df77:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef67cfsm4628595ad.2.2025.07.30.20.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:03:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] panic: remove redundant panic-cpu backtrace
Date: Thu, 31 Jul 2025 12:02:57 +0900
Message-ID: <20250731030314.3818040-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SYS_INFO_ALL_CPU_BT sends NMI backtrace request to
all CPUs, which dumps an extra backtrace on panic CPU.
Exclude panic CPU from SYS_INFO_ALL_CPU_BT cpu-mask.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 kernel/panic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 27747cecb1af..c08f2695cf42 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -335,9 +335,11 @@ void check_panic_on_warn(const char *origin)
 static void panic_other_cpus_shutdown(bool crash_kexec)
 {
 	if (panic_print & SYS_INFO_ALL_CPU_BT) {
+		unsigned int this_cpu = raw_smp_processor_id();
+
 		/* Temporary allow non-panic CPUs to write their backtraces. */
 		panic_triggering_all_cpu_backtrace = true;
-		trigger_all_cpu_backtrace();
+		trigger_allbutcpu_cpu_backtrace(this_cpu);
 		panic_triggering_all_cpu_backtrace = false;
 	}
 
-- 
2.50.1.565.gc32cd1483b-goog


