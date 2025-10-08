Return-Path: <linux-kernel+bounces-845786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E1BC61A6
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5709019E5201
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3AD2F5A0E;
	Wed,  8 Oct 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwBnVVlK"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F662BEC23
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759942672; cv=none; b=A82VdTVWBc/kZf5viuF8mRVQ46XR82bVzHudRSJMb7mt48epBschJb/Vc4cno4pIxLKMMqvjdpI3tIuOkhk2wQAW/xyGH5/0zYGV2cxa+UUmoI4y3OvRj9kdvs2c/ODfT7G4LPGdLouUlkWZheh1jRfh22EBE8DTf/ZvVTb1DJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759942672; c=relaxed/simple;
	bh=bsb+y9GXaiujW9D0Ry82D5jCo6Sp7m/WH69JdEGt4HU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g20rkh3pK1fe+WnTcYbWKc2D+Y5f6X2XA2pwuXI35SCtSp1FUhREbwVSGm4rLfm3lqdqC6uS/w9dqtmdCJH562RCDsN8lzLOEqSxBQGMMbO8yC8/a2zTgIhorXRBl9SoSRHrE9Pr1h5H6NYs9JSBOiNySIXG/jwNNSpGbjMITQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwBnVVlK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-85780d76b48so4127685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759942669; x=1760547469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JI4x8uT047uus/c8gIMluqpXmcSLrCVGwf/TCPTFBjs=;
        b=LwBnVVlKfY0/9f+jdKAfrVzpOKxomkSrxFH0RAa3Fl3azENZ1a94RPIfUPc/cdQJzb
         nCmbN6+K82cXySFGvr07XOjsnFRepxsztlswnO1elClvqXlrRJ46gGr4WeYne4EsJJlS
         m1hbN30lbWAaY6DMUrdgQadi8bZgOLKrmcvEWd/Jd/VE7AloRHGTlsTlKnv6WT7uV+cw
         BLIzfl7RztSkj+HlqubkDuSrcqruMFYN7kB2OjvtepXZa/FEEoD2otUO3YPy2Qkd+hpv
         VtYeINV6PbeGhWqxfyW97IaPOBtdncO7Ny1w1EUL2Gy6mIkxndwHPZ+F3WnPr1cVJVCA
         mGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759942669; x=1760547469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JI4x8uT047uus/c8gIMluqpXmcSLrCVGwf/TCPTFBjs=;
        b=gXZGce1iZzi6jOxC+xNPL5WMjoIv58MQBVc6VTQVHPXQ1qO6zpbRKsTeWYApcaV1B5
         r09LprFpjOj+vO5v1Ddgv3U2FcGY8LAkth0srodQz6R8nWo01O2riOdebnKka1NZ4mV7
         0vdRb8xM7Fv/ppvIN8dAjzZ/p5egR6pw5aJFS+EUGdeSa3WFHpx73n49d/DZMTve0t9n
         1fbKuY2t1CJ1eFwDUCWg3dL6Jt4nZdKnbcU0fc7pim097l4n+GlWaHzvGKjSH+vlDlJA
         Q7qZlRJgW9EzlFVXiAb6uyyFDd126z1LB3yAtFqJE+xHv8JmAthlTWPEPL8nJf5UQ+7J
         R7vA==
X-Forwarded-Encrypted: i=1; AJvYcCX9qvBej3nhUucSZZdRjLxkPqjizHpToUhyZ7cZdN7Uxv646i4ZeBCJGvUolHSe1nC0ODKycIwo5h5npL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwETEfb3YoPLEshAmaNleNpfVZbm76kKeDpy4TiRXimGIfgOmnL
	LVg9bn0D1J5YgT96+AvXUi28ifx8LnDvq7DbSchVvXVH/y+mdJeswuq3
X-Gm-Gg: ASbGnct1lLpGqCRbbFT/GntKE+d6WjvmVGGUVApdteG3n1OnLXwk3wOVrpGeSmF2NUV
	8SE7PiHa4IZDAHpYX2Dd7bwRTAUYIDwuK9d713CZStQ9WYYW1WxKlhtPyfX9D3+xtFiM3PvNdZx
	lbG7S/lVfJfqx6jG8FGpiCcgp3F2w+NpMrDgEhTaIIPOIvHLYcgMPsQxt1ApshrNyzjVukPclEV
	RVwNPsT5oC7BnNvIKom3sDdEPLn4PG9OqpPhA0/gwdyulG+q8kl1KMvoTrbkfFgDUqA8XASME+5
	aaCcMODuhbh3rCmQR+wCPbI6awS8ycMQ9Itq5VXhnTezlxFPegeK2pT08Fqbn6YnEsoQG+RXiE+
	RP0FQGtclzPUI3SLs3AJaH1+YgU9om+Jc3D1dhldWTa2Ah75FK8vTMQ==
X-Google-Smtp-Source: AGHT+IF7IbP0lx/uab9pODOh9W3eLzJEe+oj9q6RkB0BKPMx0GjbzVTX1N2vVri4J8bQbiVKXX9jAw==
X-Received: by 2002:a05:620a:28ce:b0:835:e5ec:1f54 with SMTP id af79cd13be357-8834fe9987fmr633592085a.9.1759942669234;
        Wed, 08 Oct 2025 09:57:49 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a1ca2f0csm21861785a.32.2025.10.08.09.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:57:48 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smp: simplify smp_call_function_any()
Date: Wed,  8 Oct 2025 12:57:45 -0400
Message-ID: <20251008165746.144503-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The functions calls get_cpu()/put_cpu() meaningless because the actual
CPU that would execute the caller's function is not necessarily the
current one.

The smp_call_function_single() which is called by
smp_call_function_any() does the right get/put protection.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/smp.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 02f52291fae4..fa50ed459703 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -754,17 +754,13 @@ EXPORT_SYMBOL_GPL(smp_call_function_single_async);
 int smp_call_function_any(const struct cpumask *mask,
 			  smp_call_func_t func, void *info, int wait)
 {
-	unsigned int cpu;
-	int ret;
+	unsigned int cpu = smp_processor_id();
 
 	/* Try for same CPU (cheapest) */
-	cpu = get_cpu();
 	if (!cpumask_test_cpu(cpu, mask))
 		cpu = sched_numa_find_nth_cpu(mask, 0, cpu_to_node(cpu));
 
-	ret = smp_call_function_single(cpu, func, info, wait);
-	put_cpu();
-	return ret;
+	return smp_call_function_single(cpu, func, info, wait);
 }
 EXPORT_SYMBOL_GPL(smp_call_function_any);
 
-- 
2.43.0


