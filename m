Return-Path: <linux-kernel+bounces-734035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4220AB07C34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1864A79A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404842F6F89;
	Wed, 16 Jul 2025 17:39:06 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062732F7D1E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687545; cv=none; b=mEefazEbm7B7rKEigrzsgDplCgyxOgajZjUih5Sez8idQ279tU88/JV3lhRQsWD7LW9zv/FWhQWJEakvwodBb3S8x14gMmFeCwlwIpJOxcZ+HAxZpX63eg5ZyZJyoaGFqd4EQcRls8wklxO6PgzH1Ld8bAtbq0jN12QvVcWvUmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687545; c=relaxed/simple;
	bh=PmUnS3XfIuti54yGZQp7QyQC26QQ4YmoruNcqJ0/SnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T72YD0ED9VUCmvHMegEXv5+xybHhH2AQsRALGZB8MqLHcMVTxX0j415Z+uj0HUl3DM260pWpNj7PxyATf4b1OcPEnfQ4XKRZwxC3EHAAZahIcstUg86/2oHn28a0zhKwvn7Mc8NkC35L05KGQxvEvD99OgTaKQbl7gOUAI/4xGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ae3be3eabd8so35829166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687542; x=1753292342;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeHIIJrtHTOzikZj7FWfivha83sARqGu4O+rj9BWfBY=;
        b=OX68eQVAvwiCoIBm6jkTIBUNt+IXoAnXFxZRB/qvfObr7Ynslj/2Ym14UXIn5rlrXS
         y2hw4LRTxSU+g/IusD8YGWDyIwd9fqVBkWr5y5QTt3OrS0nycXnmuqqw3L4ceaBBzqzg
         zrA4FTnxpXnFvwe0K66N5OXI0fqb73K1VYd7NIZFUtFOZCqMb0F6QVfnvEGxuaV3Ezao
         QK2ZkteKEKnkP04yn686wOQuttTbyL4XHK79vKgiQ5Z6Uf4HaQDiypfeIlrP97SvSsqh
         S+SIJRdKudEtUJoRMxcusr0lmg5NhSkT8QEbYZnM5AXqFep+9tvYL4D3BezsABbIV9X0
         2y9g==
X-Forwarded-Encrypted: i=1; AJvYcCWuMR98IuY/sQV+9q0NbbnO8mngsv1L7vqLLvSGdo7o4f5sNkNtSh0fekV1LKcIQtkTuqzt5uhRMHEdE2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz64DbEbxDhvkbdZfvOAgTcF+VwaZ3dNcHWVf8gZq0rEqUnNYTN
	1iqe6Qpo/eEo+ieCAo+j5tU8DaKQ7xqEEn7TebQJzbX6sb5r6XZZCSyh
X-Gm-Gg: ASbGncvgPitl8EY6WzRDaYIrpr+ya678XHHWgNQrHCG3DasDiJQ2+0pDcH5IvNoK3YF
	5ifJ/P0PTNtHvFLS4LhSsKRvAP7peQBsO+lGcWYEoxCy0GxaH4oUgWqxit8xIJZO+UACW8QNRX7
	dLLoplcZCZrY2PccuDMHiFuoNO6jXDdLGMELXsdckNhn82ruRWnYE6+XFCZ2D+CGE9AP31I4JNO
	rce2C8YE2ynFNxO7cwgUXJC+fqRi1QdmzQnUZPOgKT+40Uv2dFy4/kKiPE5kDL4GMpTQrUQ9zSJ
	PfXSpn5a0ZJNvLlbrzIaCjKrL0cbukrC/VQrgRIVlUr2476M1aTCnzi0UWwDRhEuUGnrtXikXAu
	s9EU8TjIX2+Dg
X-Google-Smtp-Source: AGHT+IGyws8+mUlkwyFvTNNqyC0X7TNkDmKU9AK0NrdsL0VxWveK1EnbpQKQXuYUz2ogpL2MZV9KLw==
X-Received: by 2002:a17:907:da4:b0:ae3:a71b:1543 with SMTP id a640c23a62f3a-aec4ddb755emr24490266b.2.1752687542186;
        Wed, 16 Jul 2025 10:39:02 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82921bdsm1220626466b.110.2025.07.16.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:39:01 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 16 Jul 2025 10:38:48 -0700
Subject: [PATCH v2] sched/ext: Prevent update_locked_rq() calls with NULL
 rq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-scx_warning-v2-1-1d015b2d8efa@debian.org>
X-B4-Tracking: v=1; b=H4sIAKfjd2gC/23MsQ6DIBAA0F8hN0PDWRXC1P9oTKN46C3QQGNtD
 P/e1LnrG94BhTJTAScOyLRx4RTBiUYK8OsYF1I8gxPQ6KbTBntV/P54jzlyXFSH7dUHNMHqHqS
 AZ6bA+7ndBylg5fJK+XPmG/70/7OhQqXJYhuMpcn620wTj/GS8gJDrfULXt+aDKcAAAA=
X-Change-ID: 20250716-scx_warning-5143cf17f806
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
 jake@hillion.co.uk, kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=leitao@debian.org;
 h=from:subject:message-id; bh=PmUnS3XfIuti54yGZQp7QyQC26QQ4YmoruNcqJ0/SnI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBod+O0HfxjgDEv8Z2p8cMZ+hVsbGfA87i8d3pza
 J3mDtr0sgeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHfjtAAKCRA1o5Of/Hh3
 bfIZD/9YIeDKetG5dqg1+gPnk5tN4b473yxLd69N5UTIH5f1meoDAOIx/mRlLpnWtcBf8SAAwpX
 rRAK1FhF1bnYcRGS0+pVCR+NDNVObgdwrj5u7aUzcFKLsymnwho+udvRnFhKh8VinQE9aOryW9V
 FsEvrtcUkFbLzQGSebXmkaFHmoO2aJ8Ara6yFoZv0iklLaoh1gmoOEn2wIYmD58saT7VS4wFlSK
 sAAQjyaribNMsPbguI/ZlZwUW9GoFlDQ1BU82WOBWCYRN76zFx3B4/qIl7s3PnJ0ZSn1lhplfYB
 tCYN2d8xgp13y/32hf3q5DmGCO0cxyy6clI3/y+CETzOtD5BjgVoRmkfxYNcgn35pAVXw1lisnt
 eQLPtynmu/eYQLLPfZyZw+2csOsBi1+cvcXl7yAa52DkZ7VLsVtAdvabQOMH+tqaCVmWWkVvyac
 TnW7y17uONHHby0zXWdYvKnIm5qrfdEm/KrKwfULSgIs9X5/nb7GAqWEgwSQj9oaNT2HmdlvBU6
 SxcKVemYhfqE2yhOuuFOZf1NLYlQGL5goHkZUV6aOSg97CVSx4QHUdkCzIR50vt9VCCpz7fkOeT
 +xPCi7KSwhf9q9BWgKPd7JcEy7ecUlz19DlJWOHFvzdp6/u0KA2oDMa1ujpMKQyyMpFSuLaYTdX
 uI5C13wS1Wbdvtg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Avoid invoking update_locked_rq() when the runqueue (rq) pointer is NULL
in the SCX_CALL_OP and SCX_CALL_OP_RET macros.

Previously, calling update_locked_rq(NULL) with preemption enabled could
trigger the following warning:

    BUG: using __this_cpu_write() in preemptible [00000000]

This happens because __this_cpu_write() is unsafe to use in preemptible
context.

Ensure that update_locked_rq() is only called when rq is non-NULL,
preventing calling __this_cpu_write() on preemptible context.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 18853ba782bef ("sched_ext: Track currently locked rq")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Avoid calling update_locked_rq() completely on preemptible mode (Peter Zijlstra)
- Link to v1: https://lore.kernel.org/r/20250716-scx_warning-v1-1-0e814f78eb8c@debian.org
---
 kernel/sched/ext.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b498d867ba210..7dd5cbcb7a069 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1272,7 +1272,8 @@ static inline struct rq *scx_locked_rq(void)
 
 #define SCX_CALL_OP(sch, mask, op, rq, args...)					\
 do {										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		(sch)->ops.op(args);						\
@@ -1280,14 +1281,16 @@ do {										\
 	} else {								\
 		(sch)->ops.op(args);						\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 } while (0)
 
 #define SCX_CALL_OP_RET(sch, mask, op, rq, args...)				\
 ({										\
 	__typeof__((sch)->ops.op(args)) __ret;					\
 										\
-	update_locked_rq(rq);							\
+	if (rq)									\
+		update_locked_rq(rq);						\
 	if (mask) {								\
 		scx_kf_allow(mask);						\
 		__ret = (sch)->ops.op(args);					\
@@ -1295,7 +1298,8 @@ do {										\
 	} else {								\
 		__ret = (sch)->ops.op(args);					\
 	}									\
-	update_locked_rq(NULL);							\
+	if (rq)									\
+		update_locked_rq(NULL);						\
 	__ret;									\
 })
 

---
base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
change-id: 20250716-scx_warning-5143cf17f806

Best regards,
--  
Breno Leitao <leitao@debian.org>


