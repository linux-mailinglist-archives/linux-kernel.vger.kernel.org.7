Return-Path: <linux-kernel+bounces-826983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA99B8FCE4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0863B6E80
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745CA2F618F;
	Mon, 22 Sep 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a6MuXr9y"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D02F5A08
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534123; cv=none; b=X/yWd+J6aAaguAjzMYGuYCEWcxUs9Q2JMAyzpl2qQB/c4P7nAsbcvl0oqC55nBkCqBRY1vWXU/8WcYFYGPf7nrtXirvBjCsYWIlvWgURnYpoVqMU8tRHXbBHICoHrwU6JBJvZIgo++6pmQFMzCmNoGXsO69VKVBJCxAY/HD6lEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534123; c=relaxed/simple;
	bh=w2CQvHkt4M2gPEgsJ1Jr/TEVOrRgfKToXeIBZjuqn4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQqq98RqMroyLK2ARXXA9i9XcaPmBVfa+QpCyrMRTGhgzLfJow7vNGmOvdQXppY4G9xmGxLa2oknrvreywZA0EfBhS+E07cNa93LLx4P4pXywRCPRx8ut8E+Bx1/VPs+KZiiDydZdPePoyWQoUH8UgxJo84/20mn4x4oka6e5dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a6MuXr9y; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso3771305b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758534122; x=1759138922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOurKnsAQJhq1MI/K3lsAX/7s+mLOF8dCVHDunK7rpk=;
        b=a6MuXr9ymnM1X9xenimqx6UCDnN7iJ0GDjJJaHa/S1t3Qde5Ch8jGLWhUjlqyUhOhQ
         eerJxUMerpruFgqB1JI7B2pGqCPOnlPMd77gsMe9jKEx154XpiVr7z6u73rrlHdAShbP
         aCHMPyTFHyYiqR2Wm8SyIAlLMw8oo3wLfTYmBdCKnJ6xzaNxXJq0cTgshrJI01+/46CY
         8Od4hfqX3j9FwTLVccGQt/6Wm34dGasjENc0P8yc11C8lX0v/VqYSRg7IOY9dC4lQodg
         iXYPFjHz5ub+2ZblMo9J8W9wQSZFYKtrVjRvRqNWMigcwAxpMh5r56N1V5d2h0PLTP0d
         KhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758534122; x=1759138922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WOurKnsAQJhq1MI/K3lsAX/7s+mLOF8dCVHDunK7rpk=;
        b=PDfj1rJVc1FBsJeYt7AnTbTvfIox8WYWVHIxtCKPnP2PRwLixYF39zLMFua2i+zjrP
         R4iqo0WbOHegEuEBWxdIgomptq+LjP04zFv77ZdkjpZCMjA/p2Csli1NiVTA10MmhIX+
         DToOrS7R/OsTO44rqKvZmTuS9RZCvnXnthoxBXMj0VSFy1pnQr2CzUFj2vLkoMXDbhBB
         1VITqR4uNNLSKTf4HNTx2vrDrHecMahAumP78vB6C2dJL4EqmubvgZ+iEoVEd1vy9e1Z
         YunE4L0lEofcuBDRfSAf4tKjc4TCFBchBpOmq8u6sVV+UV1Nag93CsF6TPyP+sMXNJZk
         AFNA==
X-Forwarded-Encrypted: i=1; AJvYcCVL5aSF9GI/lXZBPiPVNI2C4gfEOZWcbrSe8QrzIIuzB79R7Ax4CDiTOkokwZLYiCtuZV/H27mKBhzex8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBGeHODx+GB/jgjdE7qyVjI7LnwaNxhywfjDVlzdNVr7prPVy
	jZuRzy0GRjDey/Rxf+qAkK24/I8NpeI+4qtLb4WNZU/jgvDJqIAmBU/8UEjwOkCNGzs=
X-Gm-Gg: ASbGncuKL4oL15LbfQmL4HM5f/L3tRU/Py1Z8g3X+34PbQJFUSfFa98Yw1Uy1GH0y1p
	G6KosfNM3NnHnlQsvkGOJjJ/JsEj9D/rwRtUglPXkmy8RwiPwlWDTYgAR2YUCLANy7KWPA0u+Pe
	qWT74EqoSwUdb7SizAVtk0d270jTbI6fOHk5wyIsbSiaFXoYKFzlK0aX+/BSkGqURGtrP29/5U9
	4FXtbva1xFqjcnEsNrCWTeRNpdkvv4HiKP58dh2hC+QA7oVYkh3jOA9wwfZSXPEuoKKjvCtYmdj
	dL0ffRIQld6tQWFDfUw8jOnj/MFdr54SBICC5+0ZE4G1F2XTNQGTnvCNUN26PKXF0v26JOpjtI9
	MKKMhE7IEPABcvxAB3zuhxBz8N+9Lf6KTPYirHg==
X-Google-Smtp-Source: AGHT+IEYZ/C3dL0qp2wE+58Yl2Bn+i2OwzxTRskr6Hw/lJro+/C/gVzHqm7+saAW2gcX3d53cPh8Dg==
X-Received: by 2002:a17:903:1b68:b0:266:88ae:be6d with SMTP id d9443c01a7336-269ba3c255emr167678175ad.6.1758534121484;
        Mon, 22 Sep 2025 02:42:01 -0700 (PDT)
Received: from localhost ([106.38.226.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c098sm123997705ad.33.2025.09.22.02.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:42:01 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: cgroups@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	lance.yang@linux.dev,
	mhiramat@kernel.org,
	agruenba@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev
Subject: [PATCH 2/3] writeback: Introduce wb_wait_for_completion_no_hung().
Date: Mon, 22 Sep 2025 17:41:45 +0800
Message-Id: <20250922094146.708272-3-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250922094146.708272-1-sunjunchao@bytedance.com>
References: <20250922094146.708272-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces wait_event_no_hung() and
wb_wait_for_completion_no_hung() to make hung task detector
ignore the current task if it waits for a long time.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/fs-writeback.c           | 15 +++++++++++++++
 include/linux/backing-dev.h |  1 +
 include/linux/wait.h        | 15 +++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a07b8cf73ae2..eebb7f145734 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -216,6 +216,21 @@ void wb_wait_for_completion(struct wb_completion *done)
 	wait_event(*done->waitq, !atomic_read(&done->cnt));
 }
 
+/*
+ * Same as wb_wait_for_completion() but hung task warning will not be
+ * triggered if it wait for a long time. Use this function with caution
+ * unless you are sure that the hung task is undesirable.
+ * When is this undesirable? From the kernel code perspective, there is
+ * no misbehavior and it has no impact on user behavior. For example, a
+ * *background* kthread/kworker used to clean resources while waiting a
+ * long time for writeback to finish.
+ */
+ void wb_wait_for_completion_no_hung(struct wb_completion *done)
+ {
+	atomic_dec(&done->cnt);		/* put down the initial count */
+	wait_event_no_hung(*done->waitq, !atomic_read(&done->cnt));
+ }
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 
 /*
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index e721148c95d0..9d3335866f6f 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -40,6 +40,7 @@ void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
 
 void wb_wait_for_completion(struct wb_completion *done);
+void wb_wait_for_completion_no_hung(struct wb_completion *done);
 
 extern spinlock_t bdi_lock;
 extern struct list_head bdi_list;
diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..8f05d0bb8db7 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -330,6 +330,21 @@ __out:	__ret;									\
 	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			    schedule())
 
+#define __wait_event_no_hung(wq_head, condition)					\
+	(void)___wait_event(wq_head, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			    current_set_flags(PF_DONT_HUNG);	\
+			    schedule();						\
+			    current_clear_flags(PF_DONT_HUNG))
+
+#define wait_event_no_hung(wq_head, condition)						\
+do {										\
+	might_sleep();								\
+	if (condition)								\
+		break;								\
+	__wait_event_no_hung(wq_head, condition);					\
+} while (0)
+
+
 /**
  * wait_event - sleep until a condition gets true
  * @wq_head: the waitqueue to wait on
-- 
2.39.5


