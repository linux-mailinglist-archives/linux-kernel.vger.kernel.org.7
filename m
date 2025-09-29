Return-Path: <linux-kernel+bounces-836036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9452CBA898D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 11:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66EA91C298A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7792D46A1;
	Mon, 29 Sep 2025 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2GM8HBc"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB12D3217
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759137764; cv=none; b=nb78PBf15uNAePrVhGb3A98toTIUFwusF8JRzF9sOxrrz/taM47UvO01gFrdLxF95ONRrdCRIKjVQu04fplZz/O5z2uxFaAozq/QK+7h/FvMhaofU4ToYVPwcDNcr0eFyrLD5TKeXXrlNfp7AJdIT5dGQ4K9/1vWpRZ3krnu3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759137764; c=relaxed/simple;
	bh=p6tAXc/Gp8y6wh3gHk8uXHEN1wF4RM0QuacVVWEMKGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0yO3kNJ+ThAQArsR9KdwFNNMW4bjHodrbBWpPfCGiTvfAMis7rO5M4S6ABHfRM7mnZt0gcTZXWg4pIYCGbxJSnfT/meHsFq6FYo7BMDistHQuNMr8hA27TwYA2ASIg1/I7nXHRNUDaOLOqVj6u+HHwSY8KPY43xR0JwNIAAXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2GM8HBc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b30ead58e0cso826085066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 02:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759137760; x=1759742560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/O5MDDXltIa3/ZVaUfZG566CA7ZdErQ3dKbXCzebZiM=;
        b=M2GM8HBcmIzIJBu8cZpljU+LbIByobAHjs3QV1SF0IlhabZNqnTBPS8U/IT/xK3d1E
         dVXGHYFcUximxq1HWbKV44KtkTUimZVXK+rU+NtFeBJyyqrsy/V8/rTayH6xKiMMZoYz
         BfcXxb3zQSb9hmhHMA5rlM3zuuLcnyecQFkx28tIkLWm4OM3eCsxRU07hq7S/+LgjvFA
         AcObJUBJyMcOo78uZZgRYN04zsqRrARN6ObuVGPAHZOwbc3xthNQmGeFXzb1YR24DvKx
         lTxyt4mZkm7IZThrbvOlHdglXSrSYhPLfeXnNUxy8nLxg2gndSmHmV4O5+fcxCvnthZO
         f9vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759137760; x=1759742560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/O5MDDXltIa3/ZVaUfZG566CA7ZdErQ3dKbXCzebZiM=;
        b=py1ZSl4qKO+YkoFI/VzJZOo44BJO5B/6+GHAbODJSCGbj3HwdELD1VcUpIvZfj8X8n
         8s2S2H+sTpQMZhlD8wiSL9OC8RGccJUN/I0P0e+JEGo/CDeiObbyoGWOiq3UPIF96w3H
         Z4eF4MYTtGz5lm8s6Y4qNavxAH2BO1NxA0sqdfe4crUCNXk21lqIldD9Hh6xoDfQo2YP
         oV2+hHtysD4GubAh8HuVjZi8az79Y68R6n48uic1Fc8cVhRKgISTH2GMghnX0648w+F7
         Qwl66ywq6gmPUT6PEItk6M/lc/pDgndopoyAKz1QmYkvS5uhqpy4Gs9JLbDMf0LoNOau
         ui1A==
X-Gm-Message-State: AOJu0YyA7+imtCnifjVpDch6DNfC6GTZVLoDYyserO0sjRV/De+NB96n
	Q9EPl8mXKUNIuBN/0TCZg/r8fyl4MxxxA4DD1D8G/9D3fHktZ4DgriJd
X-Gm-Gg: ASbGnctioJLhfIGNfF3W/JHU5Ecc3XCF8Y/s31MZ9DlIQvVR6Cgo1pYbdR0vz2E/kMH
	39eRdEY57jpak0AyTzxPZgKrZPA+rbxHJUpFwqjT2KJNv6yZwqY/s7S1p0FwcCWhTZMmcgul5dM
	VRzLCagW1/A1nY5g4RBM7GbYF+DoC2JLq3Buz2sOz3x66J7jfdUnduXDWmLzpbtkhG4TGxEiSec
	p0cuqLDeepmAEA0V4v45yKEAKwkxnur9ntwnzXTqHR4UTTtrLy6K9S5gCgQOA9MKwN5gdXILp8x
	3h2gc4Eua63vtc+87+UEz/HYgB6b4I8Dyc2PfekFl8lNA50nNG8d+ZiwPEaWcG98ePGP8j4gk56
	YbEzcMTbuCS78mn/FXOaHKcuXSJzJ+UkTU7F9JCld
X-Google-Smtp-Source: AGHT+IG/29r9BZ8hOEFCsztkdALclY5lYFDek6KlTxCKlYpwVc9lYrzesovC7SyxIviINs6huBBI/A==
X-Received: by 2002:a17:907:d93:b0:b3f:cc6d:e0a8 with SMTP id a640c23a62f3a-b3fcc7d24f9mr204587666b.17.1759137760005;
        Mon, 29 Sep 2025 02:22:40 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3e89655b09sm181082366b.77.2025.09.29.02.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 02:22:39 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v3 22/24] sched/deadline: Fix HCBS migrations on server stop
Date: Mon, 29 Sep 2025 11:22:19 +0200
Message-ID: <20250929092221.10947-23-yurand2000@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929092221.10947-1-yurand2000@gmail.com>
References: <20250929092221.10947-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: luca abeni <luca.abeni@santannapisa.it>

Do not unthrottle a non-fair-server dl_server_stop(), since it ends up
being stopped when throttled (we try to migrate all the RT tasks away
from it).

Notes:
This is a temporary workaround, but it will be hopefully removed in
favor of less invasive code.

Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/deadline.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 27a5d5ffd39..6435a94159d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1707,9 +1707,11 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 		return;
 
 	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
-	hrtimer_try_to_cancel(&dl_se->dl_timer);
+	if (dl_se == &rq_of_dl_se(dl_se)->fair_server) {
+		hrtimer_try_to_cancel(&dl_se->dl_timer);
+		dl_se->dl_throttled = 0;
+	}
 	dl_se->dl_defer_armed = 0;
-	dl_se->dl_throttled = 0;
 	dl_se->dl_server_active = 0;
 }
 
-- 
2.51.0


