Return-Path: <linux-kernel+bounces-777320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE907B2D820
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6F73B256B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F162E2EEB;
	Wed, 20 Aug 2025 09:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B02ASpJp"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5D2E2EE0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681466; cv=none; b=dP2cDUYps++8mO3RKCuXH2UPWJarm6rKBZQ9F0iLpYqSW4Uqs6khkBAIF1OzgCR9aw74x/fYzHln+i5zjbapUTz3VRC4GactyIDi7MXfHA+m2Y9ExCgnUmm1lLCzPEqIHTa1rxo6hz7eRt/N7XLZ1qQzoaFWrZrBjZJ0CyGeB0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681466; c=relaxed/simple;
	bh=e8vRsU16uY0O6zYApO8WUWA0ENkGlCUP9UYkrvI4Et4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUBrRO9UQNI7k81Qvwh01s6VYeAKNlRPsPBYesJFkw+GfWrj+9wnBC03xRgV2p7MajV62ATNHwwHLizXqhkmbc84Hb9AaKU25IMuND9qhN9tLIR7FUBKT9OvzGr/xTxzB85JtpTe40+cOHkdDdaRxEMJWowDgTIk4KK3b0UaKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B02ASpJp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2e60433eso4715695b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755681464; x=1756286264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJXFg3LbFuaJYryQ6LaEEyZ4K22AwpWjfjuyIZLhVnc=;
        b=B02ASpJpVVatFlqvJE1TJjeUIJ/BHQJR6trGNsXDhffSIV9vFJVp2V2+kLm1xMwAQN
         Y12F7G+suhzlXAKTtx5mhxOduzhYGZ8+mZuNlKH5nGv15P73FIWwXF7bDWzOeQByFTbH
         ekHiXZ57hTo5N5DZrzoK3Bdil8PGpyo+H9YtYWR/exdGkHgsiKeVMMVJZlWJ59SySiFG
         mXPqyxclGw9uKTAa6gjL6gEN9FR3vBHFIiPO8ri6G7r6j8vo11MDXmgAfqMefQ1zXh/+
         gPj1gSo22myU4lnjakSqM8ZtU8dSWBGqgZ9JtVAAWJ3nINSbYTT3Xh3ros5tPjc4+15J
         xRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755681464; x=1756286264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJXFg3LbFuaJYryQ6LaEEyZ4K22AwpWjfjuyIZLhVnc=;
        b=TqOOKZD/UV2jYj5O7ufmz2WbmaJN0QhtGlSfhEbedWz7l3IUDGKDz4LGWLNni0RLY7
         mOYPfnwwiG8mfNtQD7RDHQ14+Ad4wJCmUwdQ4dwkIXmFmJNGEDzK+l5xg1XTmWuDQt60
         1nUDhGfmAgWZqcUWvBw5n6k5kRWmwb6CwLe+I+NqRhIhvaStBKClqJKfohNqVJn/d85C
         UqPxbzXTMgFNbTkXBRx7PbOhfu4GE9Ca7+dusdqIBVH7O/lScqah+YQtEqJElUAVXwQf
         K4HNirYDWVrPALMDiuusWOYYVPdWCGoDTfLLczVelY3O4P7TorNCFDXV0GM2rnPdZblP
         ozwg==
X-Gm-Message-State: AOJu0YywQAmW6sJvewiAmQkjPX3cJ0MVZyerlYEs1NZMKt+4OVEmU/kL
	Svx+HjnicytGrnG5MWiMSY/UY9JlARjemJfm0rIFtvyMIQYnKeMBqWmp
X-Gm-Gg: ASbGnctowBL1XKE4w/SH9XhpEqGaj+CgEeGbTOYNzkAYMxogkiExdS5jEVh3cgyEsd3
	JDyp5dPRL1qjs9TuVnhFFV3XIAdZE5y6O7hyRrdGWFiuBwiUhU9j5DO6Lv39hMXeZcDbF4oG+L0
	kS6aiPCnbMQ4sE24bR+ZxJw07L7MK21nharHhlsGqHRxIc6tXMwxqpn1vQ3H8AchB9JSpaquyTF
	J8o89ql/+NLH5tLxNU5Q9t5XDhHPSMNUuHzmoxcFz8Rl7oSXiOtM0s2ZXJ7kjUzw8jd4b0mirZZ
	dpjQW2kQa0foqJKBqC7HuCA/5kybIZCczn7CtVuQcfHmN0gpit6rdsTl+jDTwln7JE6xtVefiBd
	irssC1KjOm/iJGYREeGOOyKMuSR065fOkQYOOfDD1bV7L/JvVsk/SqrQ5X3duAi+UFL9fRh9gXh
	U=
X-Google-Smtp-Source: AGHT+IGsUHNfKID6TgeghxyRTy1TNoKo1uMHKcdNmaDlhNhx8glXGDIKaIcIYTS2lNZWYl+67UGNiQ==
X-Received: by 2002:a05:6a20:6a04:b0:21f:a6c9:34d with SMTP id adf61e73a8af0-2431b7f0d26mr3689795637.1.1755681464015;
        Wed, 20 Aug 2025 02:17:44 -0700 (PDT)
Received: from localhost.localdomain ([114.242.33.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7ccfa8d1sm4847120b3a.0.2025.08.20.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:17:43 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: pmladek@suse.com,
	akpm@linux-foundation.org,
	Feng Tang <feng.tang@linux.alibaba.com>,
	John Ogness <john.ogness@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Sravan Kumar Gundu <sravankumarlpu@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] panic: use panic_try_start() in nmi_panic()
Date: Wed, 20 Aug 2025 17:14:49 +0800
Message-ID: <20250820091702.512524-5-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820091702.512524-4-wangjinchao600@gmail.com>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nmi_panic() duplicated the logic to claim
panic_cpu with atomic_try_cmpxchg. This is
already wrapped in panic_try_start().

Replace the open-coded logic with
panic_try_start(), and use
panic_on_other_cpu() for the fallback path.

This removes duplication and keeps panic
handling code consistent.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/panic.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index eacb0c972110..cd86d37d124c 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -355,15 +355,9 @@ EXPORT_SYMBOL(panic_on_other_cpu);
  */
 void nmi_panic(struct pt_regs *regs, const char *msg)
 {
-	int old_cpu, this_cpu;
-
-	old_cpu = PANIC_CPU_INVALID;
-	this_cpu = raw_smp_processor_id();
-
-	/* atomic_try_cmpxchg updates old_cpu on failure */
-	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu))
+	if (panic_try_start())
 		panic("%s", msg);
-	else if (old_cpu != this_cpu)
+	else if (panic_on_other_cpu())
 		nmi_panic_self_stop(regs);
 }
 EXPORT_SYMBOL(nmi_panic);
-- 
2.43.0


