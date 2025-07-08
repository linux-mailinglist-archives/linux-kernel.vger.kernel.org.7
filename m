Return-Path: <linux-kernel+bounces-722047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE584AFD3C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F147C3B649D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6AA2E6D26;
	Tue,  8 Jul 2025 16:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ezyrr3EB"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50C2E62B8
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993806; cv=none; b=s4Jp+9HE5+29UGnK39+62esmlh/j/bk19UX7hq2W8kABCRrr93iZt8hpgxfq2spdTO4ksIZu92k8Fjv57roO1norqTwKjDmx3dd3V8l5f9Sdk3ujG88rYw4AbQ7M30YNoTRMa1OxMRenbHUeM8YAyXxSQ5BvxQXKlbbBZn3FzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993806; c=relaxed/simple;
	bh=YDHzCZD1O4x6a9V2ciIeVZsYJg4YFiL4AoSP+V1JNEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0qxtsZrBaSPyKyCldLJ6ZyWFDwDlpGKzOXmU83eiOqW3RD34ETL87eZrD6QSQjjWu1ub7/Zx2b045pFIKeeRxeNEnoJxAYkLhc3XtwwYzKE6eh4jOUN6XXqFnNbjwv1yLzQDoQXgBYw9O9QxVSvcTjPiZHEZwXzAYdcRQBMoIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ezyrr3EB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a6d1369d4eso2755299f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751993803; x=1752598603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZl7Fer6pxxctYiak9nxWwOWdwOt4/BaPnKvvUOawZk=;
        b=Ezyrr3EBFE1UlkT2/wnYG9tpsOAJg+2eO5g4x49D7l60H5KSniHrkXsfPVdwwivVRY
         F2qSCTvSqkj52but6QYw+373lthDF0h6MQV+CZM0GIaP8V5TxLl9zS1aX65t8IN60SFA
         /ClQEi31VgKPlNutyBreUu2CyY6qBUHsTI3Uc+ewvqvWbEO2aBzc2g2Sil2NPzdtmTAF
         cI2V/SyJM6foFvVJUI6yKydMLYrVM2q1wFRmG9AqPH8wVzYJ2PfdxqYJTxnK2g34v+D5
         obmKudHTUHgqZViW+11Rz+bRgSbKdZYDlTMJRmo18tkOKD7YxEFfAZFyLOun51dwERI7
         pGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993803; x=1752598603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZl7Fer6pxxctYiak9nxWwOWdwOt4/BaPnKvvUOawZk=;
        b=QY222J5XZ7zcqljXzryrBJY/prKzoQVPZ4osMJ5csRZIPBI9yawBoaKooL2YcfMIg+
         pwfTzI2oeDqB/Hqz70q/8cAZU/4YCQu8qts/dqGXJbiYsIiqbOzYqRS3dzcHB9E+CuwM
         d631FEhjf2/StwHBcRtA1F3hcM5OXqRDTd8aYF1K116Ug/g0wj6qN+CO+cqXecfVTh09
         13Llyc/i/Hj4RkLwQOf8U1DRoOhJImMFjONQAXOvOZCPYT4PMjiSyDyOX/wpnC2SI7Zm
         zOVtOMEJF1bMiyyEhVe0H35YC1PV51bBYb5rEKkW5JP7O8s7tvSrSAuxDUU6NoqruRGS
         mdLA==
X-Forwarded-Encrypted: i=1; AJvYcCXH56Qaf+1khGTmsQeVnBNvTmmyi6aMBay4/aUyAPkfub3IPOHDmOHJxoDSI/yC3EQS0dFf5oNqph08BUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCoQIw2yx4Hrl5PCksLvGQm+FlrBguMVPGLcMfa6rT/cHz51Qr
	qSUAWsLoHw7Cg7GMWHkooGfWIpUhMogQ5SFCAF6FsiV/Gfy+/wDbcERfUsdHExI60gc=
X-Gm-Gg: ASbGncsH75+rHr3UA6HdIq/+yMyp1SymHtoEYtdusyj5leqF0/tA0QsKZYGgCgUKh9a
	JXGjq7qRZU4jLdjrU1rFzf6JLsIdvSr4lYXgB8KCUNvCOedcrl41kS3dDU+ZEfPe8pCX8VMUUez
	fBrBDdMhQsgQlUn84hQx7/ynKm4LEnUll3vGl5rSOliftVHuaHEKbQpiUG4e1KuUDi//fl3Zi06
	F34cC/NvpDr2kvVT6wc6/zNRQyrOwR79adWu3EAPw52P+0ZvazxKe1agIQ3sOtuhemDyt/6c3DP
	+h5YtkSM7Ft8Y9bNDxMGU39Canc1SOgE+neRuAu+8Dq4IiuUme8+MGh6xgNj1nRpYPZ7GDUNnvd
	gY9yKag==
X-Google-Smtp-Source: AGHT+IG/A6kRJu2SjEN1uKoSXT92i0pOXWJrm/dgz/mCuQn8JiG5arI1A7md/gXc7lQ/lI1lm2ZAJg==
X-Received: by 2002:a5d:5e88:0:b0:3a6:f2da:7fe5 with SMTP id ffacd0b85a97d-3b5ddea60d5mr3525069f8f.55.1751993803000;
        Tue, 08 Jul 2025 09:56:43 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:2a4a:c4af:2315:5f08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d51sm27295965e9.29.2025.07.08.09.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:42 -0700 (PDT)
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
Subject: [PATCH v3 6/6] sched/fair: Always trigger resched at the end of a protected period
Date: Tue,  8 Jul 2025 18:56:30 +0200
Message-ID: <20250708165630.1948751-7-vincent.guittot@linaro.org>
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

Always trigger a resched after a protected period even if the entity is
still eligible. It can happen that an entity remains eligible at the end
of the protected period but must let an entity with a shorter slice to run
in order to keep its lag shorter than slice. This is particulalry true
with run to parity which tries to maximize the lag.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d815609526d5..fbe969adf287 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1183,14 +1183,6 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 	cgroup_account_cputime(p, delta_exec);
 }
 
-static inline bool resched_next_quantum(struct cfs_rq *cfs_rq, struct sched_entity *curr)
-{
-	if (protect_slice(curr))
-		return false;
-
-	return !entity_eligible(cfs_rq, curr);
-}
-
 /*
  * Used by other classes to account runtime.
  */
@@ -1251,7 +1243,7 @@ static void update_curr(struct cfs_rq *cfs_rq)
 	if (cfs_rq->nr_queued == 1)
 		return;
 
-	if (resched || resched_next_quantum(cfs_rq, curr)) {
+	if (resched || !protect_slice(curr)) {
 		resched_curr_lazy(rq);
 		clear_buddies(cfs_rq, curr);
 	}
-- 
2.43.0


