Return-Path: <linux-kernel+bounces-751982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA216B16FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C276D3AD942
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F742D374C;
	Thu, 31 Jul 2025 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxYxu848"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE32D238D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959366; cv=none; b=aWrPphHs+oxjWLf5NrHsFOfTdsNeC6uOanmgehYlo4tIHmov0+7nBaCc60d7Iu6ixkMUM1ZfIJz7LTmeewwhuzrhC+KQKImU4oP4l7aMCBcDQER/cCbr7v/8HToYA39zMUl8+TiUNUQwbdbIkboDoGTpwQgIiavLlJKG/lS5zKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959366; c=relaxed/simple;
	bh=OpUMuETLodfrnIf+F1HVlkdpkuJLOZnropoVxSeakd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GXlzW/ahXtZ9V3s8i9+3zZBu+TzRGaUYGSNNHDCWkbxuG6WYszSHf+rQ3NW355lQI0bBXcYVYXh4EzdSpJJ4lA7lljfImFNcEaZ0NmCwVAbIxmUPYKvnpSp7HRJ6FzRltk9WYEIcaH+CaSFS3dYdueEJNjTB7L3wXSIu/E4aat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxYxu848; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45634205adaso3468135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959363; x=1754564163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIm3rlyPz0rfM/eD/RBrN306alHhzSHRloZOtfBSX6s=;
        b=cxYxu848Tb5n1L/RNiiCH4btunaC5NV272alBxmqbFj47fVh9xeTKoE1N4zWYhXMqc
         xpKNH6B+PBIZxSdR0/zeGLzgWMFS3t26il9ByHh/z8OYsM3Wae1+C+uzaptgteroH+hY
         mMsrPjuEsZTUeYz5mxgDT+Wjw9Wu209wjV/QU4bJtgD06mWdqMO9N8tQ8CdzE0jjOXYV
         UNv79ROUssgGaji1tpDQTiKG46zzLR1dcD9Nmo+DcVYFhfdLMqHLPGfIGJIbcN0EdjGr
         swBJ+RgSt7psQVqicX0T6GHYFtRSUAL2cxwi3h+cyDTnOk6XFAOb4P2O1nPCJiXQzeBE
         byDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959363; x=1754564163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIm3rlyPz0rfM/eD/RBrN306alHhzSHRloZOtfBSX6s=;
        b=N4wP8kQ2m1/7xPuKqZ+VPWHdH9tNfF96a6PMVsQGU9qYqFAfcvzq3qHXCuIldn4oN+
         Kwm5XWWQOJJ3xohAz9U8MxmyN4YNGOnMdrK0n1pchY1QdiJ/tqxMzvgIBl2HkuzBh3Lu
         znCkmPQCLw/G8uRZKrwstEk1v8st3l5Wth+sg2ptOh4ApRTHcv/zAWLDC5xEcohIy2/X
         HdMki7bMZX+CdKuuyfDrGyPxtBaMP3hFt2LrbtBxo9ByjPIQAW4hG3//3kQlS3PwJUCQ
         TmcZR+BoCDOT8re3XGkmyWYKt8fxtXQ+xLwVoBP7fkduj1USLmxy+T0xB2Cix5zG+QK+
         86lA==
X-Gm-Message-State: AOJu0YyB6Clp3PFXYthnmNBx6D2PUqDwWDdkRmaGlxCpAGW0FI7sSxQG
	ZT1NxRopjEjYkpyw5IHSyNisMFvrcD6CFyWEXYBhvJekCX8tRC3WELi5
X-Gm-Gg: ASbGncsbPvS+vezb2ga+ZTWY5lVSOBdzlbDWz+h7hGBitymMwVto5A6+6utmYFeSZ99
	m+LvAPn6XoY3Iq5re1PQRRQPStXyuUEFGTXvdrVLaTTNza+MWSkzCbiSI2Uhh4pvWOaRIPA4Urw
	IdBm/Gh2/Ty2W34TK5OSga/xBMBAD8aPdh9OsfLJEdrzyky5A+0f5mfqwXx821mPs1QRZSOZby9
	ewhYXZdcSTZ4240ySXDoRdFgbyXRAN/OkAUcsGsO3iwhtodVzfqTxxdzhPMBk8N2Fj7sMsFJZn/
	+YjVCygeIZiK/ZD/gGYir1PHRodzunvY9zlXlR5zGHnSmjM9I2Q18HV8Mcp6mWQRQMk6fZpCPYG
	lUTbuHu3ah4uXcxsVqUo=
X-Google-Smtp-Source: AGHT+IHRBj19Y/8c4RtBt8R1QreJkcQ2oxrrOP8mZ0lIqy+GRRcjW42OC0INVfegbbJW2IPN3jmfLw==
X-Received: by 2002:a05:600c:3ba6:b0:450:cf42:7565 with SMTP id 5b1f17b1804b1-45892bce8c7mr50859405e9.23.1753959362600;
        Thu, 31 Jul 2025 03:56:02 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:56:02 -0700 (PDT)
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
Subject: [RFC PATCH v2 23/25] sched/deadline: Fix HCBS migrations on server stop
Date: Thu, 31 Jul 2025 12:55:41 +0200
Message-ID: <20250731105543.40832-24-yurand2000@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731105543.40832-1-yurand2000@gmail.com>
References: <20250731105543.40832-1-yurand2000@gmail.com>
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
index 021d7349897..d9ab209a492 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1723,9 +1723,11 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
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
2.50.1


