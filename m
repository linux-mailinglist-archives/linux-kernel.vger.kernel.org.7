Return-Path: <linux-kernel+bounces-751967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39253B16FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E414170664
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE502BF015;
	Thu, 31 Jul 2025 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9pOa4qd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B212BEC20
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959354; cv=none; b=kt856km/iLmjrhgY45BvyuROyKXEfC340oGFklWKXBtxbiG/of3vrg1NBE0oWj3QjZ9ANSmB2MnaiLy+0qXTKWx60cFVxqDnJsVJ+TDM6O3Y5YolvHmq/7LoNJWsttjNc+ExrMpjyUSt5wKZitHZKc5kxib4ZAYjZ3r2t+IEl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959354; c=relaxed/simple;
	bh=22/BBPVYAgcEcnh9sb9JTkNEXXz/AMYJeDNiGyEFh6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyUgj6FUrdKC1XUmttlD8e+y2eBSpmtO6QTNvIVSKWI80qSgMqAb2G8+oUMUVS4SoH+McAy4x4z/Ub70VRIVvtgIa+PnXLpeei5hl2ajpY4IPpVVC5npCB3QHgy8OCZgRNmx+xRp+MD+0rpEQyq3tWuyynj9JMF9j9/6woXbBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9pOa4qd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b780bdda21so609802f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959351; x=1754564151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwcLfkk7r5x07qaUEcnr0bt4ogsKgYoe5GuJmqfu0Uo=;
        b=G9pOa4qdNhJ93Mkp3by0M1narOK8zw1X49G8quHE9CZplzOr/pTKUc1AeuUXD8s56u
         k8w/bUEu9F+5MiAKqwGnHMIIBj7nRAbabo8voP4nCZ98HnSTGCXidRWyqjJ9c/p6yRmN
         wJwGnT5EdpH7xST9wvNTNJpGd3pERXdmq4828IaRR0IzEYr2/wEFbCexHbLeiYAZUwdS
         Ky7k5y8LUfA9/bhXyJDcfJ20gzAfc84YrJgmQTr7FhUq40eHgQN6kh2cCuj0j+8+owGW
         Msxf+toL78bYVlfvFdZdNNkTDYSX6wQgKOikbTJz+Yor/o9uizoxfWSbOehwNnuhHyCk
         9t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959351; x=1754564151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UwcLfkk7r5x07qaUEcnr0bt4ogsKgYoe5GuJmqfu0Uo=;
        b=URcJULOaXQDa7OMeoqYBTwAcE4pYAMVAEs1i5+hbYWU4V0z7+ugNIMgdBsYrcIBqSa
         c+V/ISB2RoXJiu2kwwESF8e29Rrh531Z36JeOpDOogVYmmnG1JcDwgauOeUeePENVtuq
         PIPfVIlluy8vu0baRKPtm167ca1GU8eX5D9Gou2HWdAUMA6viwQvCVAveY1yQg5FDQFi
         TudJzFIen1XdL9/onZBJOu88Z66hg8ND7bP1prdQ9ZlNrh1u1KbaudVQ2yuFpAfSalJD
         Eiyt7+hzGIuGgZ7K1CM5vdOpPZ6DYPqU26BT78QsGMbu8Y2Tz5VhHWHB8Hz9o1lh6iXO
         RcEQ==
X-Gm-Message-State: AOJu0Yy58uMqMVQ8akLBNLKgZ6+jEZJJVMtUrvtFL5zSNfqu7jSBzGM4
	8RKND/HK5FwHYBcbTxpGmglgFwuAckM4oURNiiJWcC3OJBdztT5CHbF7
X-Gm-Gg: ASbGncsbgcOXJ2xzH+IhNYSld83FAuTk3BPV573rd12tqMX6GdA9jC7mCeQMXtXBmfg
	DwcSwvR7X7VCL0/SPOMSrOJsvCGtzqsnoDKFhe7Nnr0IowB8RbDKCtNEddIMsdyK7krj8Htla0L
	sNvbYEi3DVUhTcZgBtWUqtfWxD9OKYajYQ66pG+kuC4sOjIGx+1yf3qtDjgs5CAFxj2sNCTRnBK
	Z+2D7/UpV75XwJQnZz62wCuV3TUkE7emLlr04Z0yzpKlu28hUlWt0VrAjZE8U1llHZ2NB4uYf0K
	8ll4tWMPn/EMb5b236Ot3FOuMMtwgE2s9JJHZIfc3uSSxZcK0Ehpqi5a9Q2rphfNXcLf9pdBMcH
	bBr1OgTHL6qLGDlfYKK4=
X-Google-Smtp-Source: AGHT+IHIAMJQh9vdqcyDc46LIAaCbP2BCTOf9gMJ11VQgISefC0bY7ZfqeQx9HUNhCSGmDhUHbFiKA==
X-Received: by 2002:a05:6000:144b:b0:3b5:f8b3:d4fc with SMTP id ffacd0b85a97d-3b7950190e7mr6416634f8f.53.1753959350947;
        Thu, 31 Jul 2025 03:55:50 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:55:50 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/25] sched/deadline: Account rt-cgroups bandwidth in deadline tasks schedulability tests.
Date: Thu, 31 Jul 2025 12:55:26 +0200
Message-ID: <20250731105543.40832-9-yurand2000@gmail.com>
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

Account the rt-cgroups hierarchy's reserved bandwidth in the schedulability
test of deadline entities. This mechanism allows to completely reserve portion
of the rt-bandwidth to rt-cgroups even if they do not use all of it.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/deadline.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0640d0ca45b..43af48038b9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -231,8 +231,15 @@ void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
 static inline bool
 __dl_overflow(struct dl_bw *dl_b, unsigned long cap, u64 old_bw, u64 new_bw)
 {
+	u64 dl_groups_root = 0;
+
+#ifdef CONFIG_RT_GROUP_SCHED
+	dl_groups_root = to_ratio(root_task_group.dl_bandwidth.dl_period,
+				  root_task_group.dl_bandwidth.dl_runtime);
+#endif
 	return dl_b->bw != -1 &&
-	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw;
+	       cap_scale(dl_b->bw, cap) < dl_b->total_bw - old_bw + new_bw
+					+ cap_scale(dl_groups_root, cap);
 }
 
 static inline
-- 
2.50.1


