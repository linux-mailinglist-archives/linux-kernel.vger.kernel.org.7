Return-Path: <linux-kernel+bounces-751984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B97AB16FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 13:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E4D3AC728
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE482D3ECD;
	Thu, 31 Jul 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCu68OE6"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D712C3244
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753959368; cv=none; b=KDW+a/VCXRnWhmvdm74gtKEVwdA0mIyUf97J4S3xUacssUQWaLs1ZLDmlxkDiAVTCzcm/RaxHICnbyNeAiG32oDQLTiIrF8Oh75V564JInQncWIaVAQ58Kxdbig01SxzBWtxRl6gZ6Z4k/roo/+7Fvdfs0hws7myPjACq7gx+5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753959368; c=relaxed/simple;
	bh=4n9dDvibvFF2K8duQIxb/c28VkIW1FuNIozyqhLdMH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GGdXHFO/sOZfyF+HNmN4hxYn6HVDjHgsDKj5ICgC5QcLyGDDKY4WJf6dVi3LfCyjGQCpMJs3mjpY2DvHpo7HTicXz210dwODDKSIds3Cu326ZSIH7F+AAqv0DIYyyM4zeUC0m+eoYAlzp2TtFTSlluvAWCKV2VlrAcI/LmPnOyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCu68OE6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso7808415e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753959364; x=1754564164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIWR8F3615anV5iq4cLOiQAGxUyyEmR9Z0MfkybRjAQ=;
        b=UCu68OE6O1dtk/EcpkCLNBVwhVzGy3WYrXDQfEho/Bk/uZkrPqo5ndbtETyOvPt7Sp
         dcUqI0cvh6+7epZghgNti1XS0XYgCMbHQl09QRO8TlAG4bdSO0r30sIXrUxwNEp82fVh
         qpH1iboObM65Tm+rrAXEYBUk3CW3H+Zsb8SKbkeswZRPVPOvAtAC/si3MOokd4XFu68T
         2/hjcngzVRCpwpmDzu4UKLyDEvMBVuRqX2obBF7ZS06L0CQ3H6YDSw4B+pKCoEF74tAw
         y/whcjjGQiqR8uqtqBNR+RfYYTJz070zgbwoLbp9eVSMrI5srMFCe1KcM3IwMxq2rm8R
         MXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753959364; x=1754564164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIWR8F3615anV5iq4cLOiQAGxUyyEmR9Z0MfkybRjAQ=;
        b=p/CyyucwBC22J7uQ6Iz3P04gHkKsyNh3BYqGcN1VdzH4OBxc3vM2CuAfRwk9Dco6Go
         jNxmfKR7FSTgB0OXFzY4OiDX+Jhn9ru7OEf0fkIEifqQ6WFfdyF7VfgXhOTTFyoiMhOX
         zd7IYoF7Yq59RC+07gDg6HcmMr/fZ7wk1hvW0gCDtUCghkvNCpM8VXFG0wR/Tf6rx4Bd
         b37RFqhTCkt8jeDDFSLXGQqex6hLxYpxAe6MRjO6V0XXqoSdkhslXJdogFs3ZV17EeL9
         hB7Vc8LIwrNNyOtudnBvLRfsXnoHOg+NjhhieBcM3krTYbhUbxabko7rE6zi9+OE6PqX
         kfSA==
X-Gm-Message-State: AOJu0YwKRJG+1vr1zQayR7A7KuYRap488jgMqdwZLna0bDtR4b9qpiqD
	XjiTj7ZyJ1wxOGan/J+LYgEudg+97BGff3+QjvLo8qXwmjsIrzV20PlQ
X-Gm-Gg: ASbGncv76nzJAASj49qnWe3GG+QRPdqnuHExryygfEzFb/4fQjbMCIiGXj2y79laksV
	2HPPqITIYnB75LCvysAKFxhbXJuRiLJrhT7UHEIgWP/tpI3c3iVwNGjvH8k1isBx6B14+mxqZbC
	AVcqLTjwFL7WJKEP8m2YlmZo2BnUGfm5GfV2WvqtKY5t8+gDposXU64cHeQfJntxda+Oo6UbsNE
	SoAsB1jQTRpJQIFZeea+LJndNxmWnxByw5V57GkRiNyfW09o25emWjiaYwePaFKUmx7e6v6fxIp
	vlbs4WJCOK3u5F7sePTi6SxtJrc9CEm3OOCMoxR7UWxdStRXO8/WbJRg+KJL/lI+ftjxKZy2PEo
	YI0Yo4VhDQZBoN+0m8zA=
X-Google-Smtp-Source: AGHT+IGe9POE29jIFgrNmwcAbP7onYa5j4KecD1gmJUY2Z0ojhLUraXguYOR0AQ7z1kOaJ7MTk17Qw==
X-Received: by 2002:a05:600c:1da2:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45892b9e27emr79953285e9.12.1753959364156;
        Thu, 31 Jul 2025 03:56:04 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm1946025f8f.55.2025.07.31.03.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:56:03 -0700 (PDT)
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
Subject: [RFC PATCH v2 25/25] sched/core: Execute enqueued balance callbacks when migrating task betweeen cgroups
Date: Thu, 31 Jul 2025 12:55:43 +0200
Message-ID: <20250731105543.40832-26-yurand2000@gmail.com>
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

Execute balancing callbacks when migrating task between cgroups, since the HCBS
scheduler, similarly to the previous patch, may request balancing of throttled
dl_servers to fully utilize the server's bandwidth.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c8763c46030..65896f46e50 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9247,10 +9247,11 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	struct balance_callback *head;
 	struct rq *rq;
+	struct rq_flags rf;
 
-	CLASS(task_rq_lock, rq_guard)(tsk);
-	rq = rq_guard.rq;
+	rq = task_rq_lock(tsk, &rf);
 
 	update_rq_clock(rq);
 
@@ -9277,6 +9278,12 @@ void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 		 */
 		resched_curr(rq);
 	}
+
+	preempt_disable();
+	head = splice_balance_callbacks(rq);
+	task_rq_unlock(rq, tsk, &rf);
+	balance_callbacks(rq, head);
+	preempt_enable();
 }
 
 static struct cgroup_subsys_state *
-- 
2.50.1


