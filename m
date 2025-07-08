Return-Path: <linux-kernel+bounces-722045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B1DAFD3B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4075878E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656AB2E62B3;
	Tue,  8 Jul 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPbqLhaU"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037792E5B37
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993803; cv=none; b=AaxQ1e7E4r/itWoQyEwZJl40zIOZwlCs6d2q7KCJDUh3evCEQChlvcbkY83s4s3UALP9c0p1XVMzbTeNvF6nEOcedrKrpY+pL4bozu+CcnWgAAoBhysIZXw82BjpySTZzukye7EJdtQ42qoSuWq8BSVJN2AIjIXBdHaHqDmg8cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993803; c=relaxed/simple;
	bh=tGQfUzEblmv82RM1x1NgNBUIurEhO/o0ushNrrpnTBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVLHlLRSSH+bpdpA4KYXbkdUS6xd8yMvTPUtoX8MFGpZQRy9IFHAtKNUFR1WGHzomUK/+15d1ren+IWH3TLG9/9UmECuYNrZG/YZWnePQy3pIGwf3mD9L9Iu18w65iaJu5n37RAEsaxx3aCcwWO3oLOHzIFBEA6JlsKsiZzzmWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DPbqLhaU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d3f72391so47552575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751993800; x=1752598600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nv1g3oLhp9LClJpIDjWjq3gCYnWK358SMoHHVdyx1nk=;
        b=DPbqLhaUkTXnGJ4yL4pGHGvFEscRz6pN4P7Q93vuxCiLcxcfB037Jxu38r3q35v/op
         HGj6qnzPYA70o+8cV1i1iOLKMkr8iq5xaBuhlvX2AndyN8OGZ9stePBruhecJdvoQaEe
         QKUp9YWYiZUEVoh7lKNemE3E9DyRr+B81zono9PgLyqNg8WQQHyJ5Ndt7tKt8hEGwW2p
         5AWaaZ4SjpHlTbBNReo36y3xRNo1EB/V+mqvsURXIv26Boh32GpAvuE280XgvySqK9Vg
         NMTCYGtUOLjBDA6YoEHbhKsv1Hdi6sWrCIGA/xOmhtcUMh0IYuONDHW1+1iJz0Ap1ZBK
         JvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993800; x=1752598600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nv1g3oLhp9LClJpIDjWjq3gCYnWK358SMoHHVdyx1nk=;
        b=RMyHMHBQ9+QhBE05vSXKfFgENzxGWCZ6H6RgLxinYKerThbQzPmgFTXs954dbFZcyB
         u2oTMAy7/84SwE0EE6f++yyORk3Pt/Gj7ZiSv48EkaeLsynzN9sVrKVbG0qS+DqZeFqz
         gQiDmebEUHagEdROxiZqiskyHqCsNxH1wterte+D7A0qeDnbPcWjgpzvgVaTKmQPchtD
         dKuCALgH9VnnMIW1x5sQeZ1x9zBQ7YiIEvE9nUom2fQBScV9bLPhW7awJOomGasaTvf7
         Y2O1FxsLmrDJzeh9SltFf6JVGb1Q8yZeILylA/ubkQl/DP5N0geYYssqCFtGnnEC99NM
         +yCg==
X-Forwarded-Encrypted: i=1; AJvYcCWoq4CrJ5CuYmYfgaKfBMZZbzf92LaoF6gbYSaCupjBZu5NhUffhVdPj5M7AZ04WcBB2nzVf6SyTsNAPQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHX37RaGy3+E3qDMkRy1LuzTAep7NAfQsZV3WnGS3/FhUS6St
	+xCA/tTE/7L1U5Sp15DCOZsJ0ZrKSW93T+MnBOuYxAvIiFINsHWCt0ux8FIUbc09EIw=
X-Gm-Gg: ASbGnctOvy+q9TWaDV74hI9Q9bh7WxAeH83s1NOSl8qXgpgyVYTbGeV+WPowW5fvAMY
	Io7W5xBzTKyB4kGsGg/mzu/ic8eMJUJ5XfVbg3giKBYcZNhUA9A819wjNUCrpVhWUzeoMX7VVAX
	gP/3o9xPnjvGRhPWRhHQIrU0JSbNuARmEwTdmbST4tcGJFy83Hsvd3RZ2veqCgC9ZLB9krkGPMt
	9SV/TbYoAOlJ/WYtG32VtfFDgHRy2qNmvn2wP7ws7fnXlpGS16BSQjsXB4oDoO1tUN/Q2L989f9
	dOJrkQPYlXSNylukYCXQX7POK8Iok7RKiDTrlKxyrzs9Lh1PtQSv1TZ2kXMm5Y29M4sWooI=
X-Google-Smtp-Source: AGHT+IHOpyZU8Q+q2tLlijRQ0LZXkdlgUs+EvMoHKUMc8miI9KhZ/rO8YYQF6q9OCmCm3lQ3+BnUbg==
X-Received: by 2002:a05:600c:8416:b0:450:d4a6:799d with SMTP id 5b1f17b1804b1-454b306b0c9mr151534335e9.7.1751993800277;
        Tue, 08 Jul 2025 09:56:40 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:2a4a:c4af:2315:5f08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d51sm27295965e9.29.2025.07.08.09.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:38 -0700 (PDT)
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
Subject: [PATCH v3 4/6] sched/fair: Limit run to parity to the min slice of enqueued entities
Date: Tue,  8 Jul 2025 18:56:28 +0200
Message-ID: <20250708165630.1948751-5-vincent.guittot@linaro.org>
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

Run to parity ensures that current will get a chance to run its full
slice in one go but this can create large latency and/or lag for
entities with shorter slice that have exhausted their previous slice
and wait to run their next slice.

Clamp the run to parity to the shortest slice of all enqueued entities.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7e82b357763a..85238f2e026a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -884,16 +884,20 @@ struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq)
 /*
  * Set the vruntime up to which an entity can run before looking
  * for another entity to pick.
- * In case of run to parity, we protect the entity up to its deadline.
+ * In case of run to parity, we use the shortest slice of the enqueued
+ * entities to set the protected period.
  * When run to parity is disabled, we give a minimum quantum to the running
  * entity to ensure progress.
  */
 static inline void set_protect_slice(struct sched_entity *se)
 {
-	u64 quantum = se->slice;
+	u64 quantum;
 
-	if (!sched_feat(RUN_TO_PARITY))
-		quantum = min(quantum, normalized_sysctl_sched_base_slice);
+	if (sched_feat(RUN_TO_PARITY))
+		quantum = cfs_rq_min_slice(cfs_rq_of(se));
+	else
+		quantum = normalized_sysctl_sched_base_slice;
+	quantum = min(quantum, se->slice);
 
 	if (quantum != se->slice)
 		se->vprot = min_vruntime(se->deadline, se->vruntime + calc_delta_fair(quantum, se));
-- 
2.43.0


