Return-Path: <linux-kernel+bounces-722046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77272AFD3C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68C911C27568
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CA82E540D;
	Tue,  8 Jul 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZA035RHZ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AC22E612C
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993805; cv=none; b=FN2VKGMimuWn2wM4/+vnQDMV//DWhXamCmJxSp+ANFzs6iD1eyZmpie90aOmHm7JWrNkdNDpQUYuQo+PfmJO2xNeV4Y61Rjj+Wx3LaHMSss1t7jGI7tuE3/zOxTOe2mtSP+M9THzLNDPED9/aIztSEYW5fB4lLOzmBJqevszcv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993805; c=relaxed/simple;
	bh=ZXF3oCG7ibV36hVD1H+76FIfM4kzG+s2hW4qeQQEF+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMhdXIaiXYlX8kKAPYXnyDRDGYd0HcExGUqjQy8TNxjOIVlTKLvJB95C+O6cGIi5tIiFQnt1nn7LRlr7lYjMvr7g+vULQw1zCD9UGzyAtCiAo/Kfgakgps2vMwAuBSd72d0ttuhMpkORb+L+Dgbtc48IZk3MzEjlZ2WBKUnJGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZA035RHZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so823985e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751993802; x=1752598602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgrc0RZh3NEys+vWGop1P04H8K+3Thfdpsx94SuLWJg=;
        b=ZA035RHZ/oet0m6V/gjiKODZq9I7p1jHJk3Pzdw/iSci+zSXgj7pNYyRSJ6y5YSnnI
         +5f0tOxn1Go/S0dE/l0ApLJBUmwAAz436AyOwMOFBKthehNz1ZVoMbvrsx1KOK3nGsZ6
         yYewfpNLxtbs+uMZ09JRtIqemlVSzwqdYhAeJwAMlKpTJ0fW6VrOqVYG793jmiXj0Xyw
         NE8x4nz3rmwDtTr9cH03CoE7CjeAHHH/Dvol7gS+cz7tY3pfbpCqSBq0iYv24zsNDoKm
         0PzYZ6nc1BqMaE4CpG834Otr2MT1lDX8e37wJylVh7/jrCJe0OqdjdV29+vmvExJ18R2
         bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993802; x=1752598602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgrc0RZh3NEys+vWGop1P04H8K+3Thfdpsx94SuLWJg=;
        b=i9N8CyuaJw4mI+f1SqWxCfAT4StdQyK8tNTVRr2TKVyYGF3Al7JcFXEhWa4/KFimA6
         TE66N2TkFwPM4FxNKbmrgg9vlRkD+VIhnzClfU1HSGJdyoeGxnm3nRN1mtrd8Q770LEJ
         l19h3TE1zUc1fWhCej3KBVo9GOaluMEviV3HeOlYcC9yRCQCE96FrJ7X2qpFdXUNqBEu
         wQWw2DOwgegHX/7R9OB226+6Dq0c965RPZDU+ZkB1h9k3vyUOteJx507YZPsHXCO/Jz9
         4B0M+t20akA8oiVs4WOMgHUemQbV2ebJBWx01yBWQwpNXkwQX9YkEb0qihleKC5PunQU
         6GIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQtWMBpQyRo3Vze+BUTw6jtqM4O+AXuK+nd3XOOCgAk52D+L8TkPfq8huuFfpKgE3A+SSQxHbCJTDPo8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSK9B3SeT6Z7nzyWVwIBZC0QibkgMXI/c7wVrshn9f1IKpMBGz
	JomFbS1Qtq281/G7mOfXK0HUEOKiiOSgYezUOTdByGSIhG3U5DmnS6YkY2QJe+4QXNs=
X-Gm-Gg: ASbGncueRgyZeIfQeZb8AGiCIehWtWxoeUHLAqcF9d0gDNLA8lJmG0Coj6T9ibfOyhd
	Uel3STttk7R8XBrKd9DctjnOwkOE7hnwbvre7meJltl6ePX1gkzIKUiNUsI55VC3hBRa8FZhB08
	v8ztMyxV6FP1lcf0rYoEskS0wamdPaZ/9Bn/5j7RYBFae5WvItPVUiwsxF8zuTWyeuSQCZCBwQW
	DWMyJsMMDVQBzajH7QElf5GUZMmZDAEwBNtnCvB7oYxFF0jXRLyx8FuqhcGRo4Yis/qTKBt6wYm
	op30PM5X4ouNjIR1YLXf6zlClSaRakvCOoZ/RYO6Ot/InQm51sJgLe8neNGVOKJnV+lbGyE=
X-Google-Smtp-Source: AGHT+IFevQFiPprYHsFZNqRJ6pLWR8/V8YHEPiMUzoDJWyI/jJwOp4nt8xCWiTzyX31ZVIoI2QyGAQ==
X-Received: by 2002:a05:600c:548d:b0:453:ec2:c7b2 with SMTP id 5b1f17b1804b1-454cd85dd18mr33162365e9.7.1751993802014;
        Tue, 08 Jul 2025 09:56:42 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:2a4a:c4af:2315:5f08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d51sm27295965e9.29.2025.07.08.09.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:40 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	dhaval@gianis.ca,
	linux-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 5/6] sched/fair: Fix entity's lag with run to parity
Date: Tue,  8 Jul 2025 18:56:29 +0200
Message-ID: <20250708165630.1948751-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250708165630.1948751-1-vincent.guittot@linaro.org>
References: <20250708165630.1948751-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an entity is enqueued without preempting current, we must ensure
that the slice protection is updated to take into account the slice
duration of the newly enqueued task so that its lag will not exceed
its slice (+ tick).

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 85238f2e026a..d815609526d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -889,12 +889,12 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
  * When run to parity is disabled, we give a minimum quantum to the running
  * entity to ensure progress.
  */
-static inline void set_protect_slice(struct sched_entity *se)
+static inline void set_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u64 quantum;
 
 	if (sched_feat(RUN_TO_PARITY))
-		quantum = cfs_rq_min_slice(cfs_rq_of(se));
+		quantum = cfs_rq_min_slice(cfs_rq);
 	else
 		quantum = normalized_sysctl_sched_base_slice;
 	quantum = min(quantum, se->slice);
@@ -905,6 +905,13 @@ static inline void set_protect_slice(struct sched_entity *se)
 		se->vprot = se->deadline;
 }
 
+static inline void update_protect_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	u64 quantum = cfs_rq_min_slice(cfs_rq);
+
+	se->vprot = min_vruntime(se->vprot, se->vruntime + calc_delta_fair(quantum, se));
+}
+
 static inline bool protect_slice(struct sched_entity *se)
 {
 	return ((s64)(se->vprot - se->vruntime) > 0);
@@ -5468,7 +5475,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		set_protect_slice(se);
+		set_protect_slice(cfs_rq, se);
 	}
 
 	update_stats_curr_start(cfs_rq, se);
@@ -8730,6 +8737,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	if (__pick_eevdf(cfs_rq, !do_preempt_short) == pse)
 		goto preempt;
 
+	if (sched_feat(RUN_TO_PARITY) && do_preempt_short)
+		update_protect_slice(cfs_rq, se);
+
 	return;
 
 preempt:
-- 
2.43.0


