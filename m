Return-Path: <linux-kernel+bounces-811256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EF5B52683
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7781C27B28
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E3A2153D4;
	Thu, 11 Sep 2025 02:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj7RqtUO"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AAE33D8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757558072; cv=none; b=HaHbFbwahp081S+GE1g1e8SL0bi0xST8Ve1kEX3XmSDvGxvkDXId9nnUxNMWUnGaHBbF3B52SlEfw41ahBDGujb7bSFRhSBw29UoQ9MnbPGgRJumkB517xFHdVYm42BELZta3vyiPwx1k94wfjayNxekTcaVieNPDu6gNXtuE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757558072; c=relaxed/simple;
	bh=MWvvuc3jfAfyzlKnoZeVSaRkyj7i/5X/4o1DAbri+Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQfWK4UBPKN+qx7EcPz+OE0rhBgimlAYOHzE5CvodN2f94xSEMiFDh+tD6O8dVevOaFQ/k1nK20nnDlp5U6ae2KkutABejYrH14FYc1af2VLirrMitE25O57kIUU+Yh7okkYRJt9kqIemjcNDqV4fZjfhmTiSLa6cREOlGTZo6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kj7RqtUO; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4cb3367d87so164468a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 19:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757558070; x=1758162870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbjvMTLMYQ5IqUdUYB4xciM9rvUgmKYvmPbUWXnRfRw=;
        b=kj7RqtUO2j/qWIhAuF3SQ59BBhwXapNyufJjNgCABD9E0rcBWohhfSSS/Vnn0VmrP+
         Az4jdrRabkV40VzcqgZXbNn5emQ0umC6HCo0vRw57MxKBbRfZHx0hTsltFA7mnznxKAI
         rSQaWbJcM5WMFkotK0tYbKv4rORzwXrOvSG7xr9+jPstJZAqXRqtKMaLJJLAQIRmR3Rb
         oXPdyBDv9H2Sf0ihjGdON5SwTHm/Ommb96bE9dPxXAS6KvHnDnt0hpYUEHMlmMfmD311
         KlVFb//q/7OWKpKAP7Rs4iBEO7FgLs1HVF2Z2B6kbMTzVqySktYapN4SXm2ExP8fmuU5
         ZuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757558070; x=1758162870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbjvMTLMYQ5IqUdUYB4xciM9rvUgmKYvmPbUWXnRfRw=;
        b=Q8XodbJ6LQoxWnXB3X3i4Fjo7HGv2B8OAtZaTIBvbr9fZq0NsDRla6O/noGe+0MuqK
         EJwsnB56N8nrJQLo3NXJeFCmmZwTHigeSy9Fs7yHiJWna1dJ9Zi8VcgA4uOSBs/+fnRh
         EB8N1KFEFMLrY3rd9R09NUkLnrFUQPe4UFgd4a8LwlxmKTQ4rLXyD1et2qTQwIYt3ViB
         KiWZ0ZtBgSwiOIJCgqVJu0lRnSZ8Yvy9YS9X6sehaMuHfNZWwcH5N+9EZvPKyVNHK3pP
         5yeV/gYA4PBKjZdDA8h27bCKENIJPMMS7YXXVv2CbN9SqxLD5Klxue5xsKz4L8PAIlf4
         O+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUYFLAdWRa/81M1d3zfZDTcxFCRyO/XxjMjXql8kgbSzZJk1lY1aMOY6jdpUHWkES/mpqTxXRrX18QNbU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPYIzSVCoyqJmqWuRFbFXGs3gUdngJv0cEaaoelI57NBm0RNU
	+5HL3t6mnq7c1xsJ4TnEPlu7jPTCo0ySi3JlFZ9I0RCav8UNw+ca+li4
X-Gm-Gg: ASbGncswjSeJaNK1SisuIX/pvfNvLTVLV2btWo0E9lmWf70Mux9YLAMzLl/aD+NA6sG
	sAX8myhs5N1uJsC64Ot5+YiBxiuLqgZu7o29zmYrgLS6sehOIp7bHGp68h/Wf+GGtomg4Y156cI
	E3lcC1RruEF/xfBx+t5kq0u8Am0AvCU/iYcp9D0XUdCBVa8NTu+y5PXhdqn7Ayb3cI0wDBEdVX1
	WJE4lSU6DrblLgcAO8UFdNiwh1Md6x6RvmtqRyduTHV6PUQAmiauIGg4vZCQxr1WK76b69wdSWY
	sTcGeVsXVy2OhgxGWePlYzWxtXQ2ly90gqLPi7OI6av9wxCUAEotgnw+dAkrhUMNw6w9OCUY07h
	c3rJWfwN/AJm3Pw3GJSe8KLNyAvL8BD0w
X-Google-Smtp-Source: AGHT+IGmhoPwl0yTN3S6XXDn8D/2p16bNshd9gAbJyzYn0gd8JsRDnNPTayfBQ9En58oMbJjZeOjhA==
X-Received: by 2002:a17:902:ec8e:b0:24e:6362:8ca7 with SMTP id d9443c01a7336-25173301ddbmr216147035ad.53.1757558069790;
        Wed, 10 Sep 2025 19:34:29 -0700 (PDT)
Received: from localhost ([216.228.125.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b392fcsm270133b3a.87.2025.09.10.19.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 19:34:29 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] sched: fair: drop useless cpumask_empty() in find_energy_efficient_cpu()
Date: Wed, 10 Sep 2025 22:34:25 -0400
Message-ID: <20250911023426.457745-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

cpumask_empty() call is O(N) and useless, because the previous
cpumask_and() returns false for empty 'cpus'.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..7229339cbb1b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8320,9 +8320,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		int max_spare_cap_cpu = -1;
 		int fits, max_fits = -1;
 
-		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
-
-		if (cpumask_empty(cpus))
+		if (!cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask))
 			continue;
 
 		/* Account external pressure for the energy estimation */
-- 
2.43.0


