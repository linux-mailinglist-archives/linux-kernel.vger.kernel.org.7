Return-Path: <linux-kernel+bounces-777321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DFB2D81F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0290117A419
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1D2E2F14;
	Wed, 20 Aug 2025 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV3ecKr/"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8162E2EE7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681471; cv=none; b=qlhbjY/Yl/pvl1ZgyO0wEczXA3vhWSsETmH4iZEq/uDQOOFAR/SLimVuGUR8oSICMs1kEvdvI15M6WqLXZJZYaDtZRj9aGLy2byfpJSbSqjAB8cC/yCuaJGje1O6TrtO6ejAfHoxQzHRF1MdK91ZkxS/v3a1tixeXl06ZSLOU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681471; c=relaxed/simple;
	bh=zMF4+35icltrT6ocp9qNM4hzWLIgsINDL3VJ9am7I8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW0nWCPcQj6P+sAQZAg1TR+RFU8KwpM1vs17HMSgkabwLn1fspPkJNJgOR1SacH90fgQzRnmxRVjT029jbIh/Vr70vXZ4jFb+2ERk1wtHjtFK60kSpJ/PRi2h1UITbvnUVCAbxyzCFcUq0WTyaq2DTMN9pacztUt72pl2+vfYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV3ecKr/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2ea6ccb7so4676196b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681470; x=1756286270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUGZziHFyGRTqRRgs6RYSgxSLNUu0JjAEretC2ZxQww=;
        b=CV3ecKr/5JLu2igw0MZFv0tz7t0oL8gbZ5JlkPlJViWUlqwbv3XRvV95kXzMICfCMz
         VWostQ23w4nmfuxveFU8pbz1PxedN7pbCG3wfpTfvC2nCiifVHpL5YQGxR5rlpO4KNWD
         +AjP8Rwvskaln31jkRsMxLHE0dZTWLML7EPnEIW4Kb5me8XXk7RLwzeZKfHXwPtNAdfX
         hDvTbjY088mxhlIGLKrCsLIWMBrPMXLq2b0WgLYpk9xdP3bsho3eQMMMzE73zWuLzN63
         4E7ADID0cTIWA8u6IQ+aDa/jPlAy9xB2sJvtjBIochs5+yHS7a8hQRP9EN3+OSp3czFX
         4yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681470; x=1756286270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUGZziHFyGRTqRRgs6RYSgxSLNUu0JjAEretC2ZxQww=;
        b=l3AOiCJhd2DayCBFOwqBxR5u0s3cq80cvGk98mfiIWLqz5Bpab/n4XqlPDMCocg0rQ
         fynSI4LFOmW0Ogr1TlBZFaHSZUgqIpRPfLzHXTfZ5o0IT8Gz2Hmu6yetX+E8AyzlQAwT
         sXUjBpppq+k4oSDZpJR3T1OU72tf1OZFPH5/sxjMLWdMNCjL3GbJEM8MEZWp6OlmSekT
         aSFSweVoQlAcNPQGtE/Mig9MvRL+wtcsL12Gf3hQSrZi0pf1wrKcW2uK+8eDqvyCB9FM
         XgX9FaYsOWDwLlE57dN7k1kCZXWgUj+AIjyAuSQkk1Mn1eQtKaTN/JKlXJRKEE/+zK1M
         4O9Q==
X-Gm-Message-State: AOJu0Yyl1T2gULlic6lY+fA4g+6ezGVydiQ0nemTQU8AZHA0JEzPhWky
	1ZsQXTAkCXK/gNX9bl5eIUag+/4BbU2IMTAJSDptPrTTcEf17aiRjtYe
X-Gm-Gg: ASbGncsUS1wXTCp2Psh004De7eGLB56l6bMxDqbLYwwm31XodOTOJuCOF0Y7lX7+T6m
	dXwz8a+gvDZehOPQtbsiSV4xtqHBo9DOhOhSiQJPjiMG0uuRAhockY8/M3BkFlmfKrQgiE2d/Uq
	t2DxMmcZJMYOlk1QT7nN6JNTIFI8QnKAYPYrqGBCSZPMHucIZtIne8R250kU5qP6TWzadPzqKji
	cFjEj9P8+HRucicZKjDn03noTWiy3v5UrXyMovNRL51olsosrLMGZt/GWLt7JBGVeQexm74tC8o
	GPOX5dguQCUmhAWXHnQW2AvJUuGjPJSqRnGc/KooqdmJd/0a6KEdXvXaiqNTiPgjaQetJwKJmHm
	b2syuqU/0jWhs8wNF0j0W7YhXhGH/+iMCfx2IprvmpmNv7YLFQqDzixjmYYF/MTtqHri/yV/kMM
	o=
X-Google-Smtp-Source: AGHT+IGmdBj9fpWdr2Eh32W7u6JQjjiteNL+4ztkleDD2x9SEO8guwyUBJZn25sVLLGaNKhg88+vVQ==
X-Received: by 2002:a05:6a20:2451:b0:231:620a:4509 with SMTP id adf61e73a8af0-2431b9ac2bemr3568944637.30.1755681469643;
        Wed, 20 Aug 2025 02:17:49 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:49 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Feng Tang <feng.tang@linux.alibaba.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Joel Granados <joel.granados@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] panic: use panic_try_start() in vpanic()
Date: Wed, 20 Aug 2025 17:14:50 +0800
Message-ID: <20250820091702.512524-6-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-5-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vpanic() had open-coded logic to claim
panic_cpu with atomic_try_cmpxchg. This is
already handled by panic_try_start().

Switch to panic_try_start() and use
panic_on_other_cpu() for the fallback path.

This removes duplicate code and makes panic
handling consistent across functions.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/panic.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index cd86d37d124c..5266e195f5ac 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -415,7 +415,6 @@ void vpanic(const char *fmt, va_list args)
 	static char buf[1024];
 	long i, i_next = 0, len;
 	int state = 0;
-	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
 	if (panic_on_warn) {
@@ -452,13 +451,10 @@ void vpanic(const char *fmt, va_list args)
 	 * `old_cpu == this_cpu' means we came from nmi_panic() which sets
 	 * panic_cpu to this CPU.  In this case, this is also the 1st CPU.
 	 */
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
 	/* atomic_try_cmpxchg updates old_cpu on failure */
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
+	if (panic_try_start()) {
 		/* go ahead */
-	} else if (old_cpu != this_cpu)
+	} else if (panic_on_other_cpu())
 		panic_smp_self_stop();
 
 	console_verbose();
-- 
2.43.0


