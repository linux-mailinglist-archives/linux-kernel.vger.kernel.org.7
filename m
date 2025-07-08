Return-Path: <linux-kernel+bounces-722041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F1AFD3B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F7A73A2558
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D552E49A8;
	Tue,  8 Jul 2025 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nnn+D2C/"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31501DB127
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 16:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751993796; cv=none; b=d6N3RgpHHAnsuTQyeWhGx/R9ZOjiI6kwBbzfDsgfcRiIY2ojiZv5ea20/sV8Wfg7/e/efKsvcVb5yXfSmnEvl6PpcUaLsdIqc8CR6rOAcf+PXPIJ9E4w0hLO2xSZDdUeqIkd1v0S5VC5UwK02ibheJGnZJ0XHIeiz61f+f2I8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751993796; c=relaxed/simple;
	bh=H3PQHkdFUiYbWlK5GnVK1oSOr/cGPYlPZBP4Dd2AAHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZozWbcnu6sXCTMwPyY2pEcUjVq1LlQx1FywKmjKhdedfLqInss8fP6LoDJnYcLVBJOxKP5HWLkmafyAY/GJasFkbNs+jTWmMuTO+xMPG3nm9sfgP/P2DPUZbI3P2JBfNM5wkxIifYKonjQ8GyZZQlu2R+tw+HISmL8aNOej58Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nnn+D2C/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45348bff79fso49896965e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751993793; x=1752598593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nPHs9GtHQqKtCZ7NIydrH5t7EwZDokg7M2MzazpwsNI=;
        b=nnn+D2C/LOqBdDbGzjd7oR+87Es2oK35hUkxK0/LwkmWNj0VEZCviI8daBCG5echgZ
         h4b8hsEM81s0IfRTXIV0hzMBvT15fXWXdjRCyCDqxNNqR6Nd7hLv+pNp2rqUSVdOS/XQ
         VSZ9BxXFWQ1XMuaCfM64k/vz7ISjNIKE883tLU1/GTzaqOG+d4VFqVrAJJtU6zUd0vNO
         C1vq/3bSCV/EhBUf9HxG/5sl8WYc+jtHH6vEfg6ioxvbx3CpiyibJdalHMlPhjgen2OS
         AEU24Wtzd7ceHf4BXuBnupOpeksD6nOBmYecdecKeJ+FBmxRGMvSGIrq4in460Uoipru
         1dUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751993793; x=1752598593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPHs9GtHQqKtCZ7NIydrH5t7EwZDokg7M2MzazpwsNI=;
        b=ROnf8gW+hKOi31lJ9xtwiOKia13xzwOcUxU3/8Uf6u9pQnbdHjs84GT1MmkfeR9EYJ
         ToD0ShZs0uNmAyMGfvMMPSaUhETK90EpbvwloB/HWQCWP6kItis03M74MklN5fEY3K4n
         oKvYWq4E1u+uAXW3Kp+RGe8QarmItoNpwxdlTWCJ4XAwQbjCBSYb7wlVoQzpza/GReHa
         Hwjp2lt+g3IbhHN+pOPogCGIj5eHDx75Gk90v8ecnxmi6BWh5xsKxK6LNUtc0Ytdr0Ct
         cex1V0jS8FVX2VT4zqLbdG2eraITBPsIEt4ZJ/bepJ9IJJDetJwpLmVTdSc0zTq9jKHQ
         8+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCX7n9FKtLMZoJw9sXyl+YJbEIhzroceyrJZJIsyiHb9H+6W1RrrF8rDIzkAXWcmoYaGgXROCFVwYye6GWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ab65BbYfYlrHXKA6fxqReAKUg6Dovm6/dBFvE8CbjnmpwWTS
	kLks3CI/DyELkMO1UmYGKTPuRxG/osGE4BmJKSSAfwgBwK1pN060m0fLxzcyPOEJ2aA=
X-Gm-Gg: ASbGncvH/Fozs5kr5lx4AmADFDgNi5VH0omTSHKEP7NptNKZknBDQwLAkDg3MXBZCES
	UDy137jzAJWNXw58SyHl7dlF1au5reAT39j6M9gDSW4AOHE5abhkxjiTt13ekf6StqQO79thfBW
	Ck4mYmUXUoEPlGU+fp2xoyAIlC+fVQGsCnISiKI0i2WC+GEhAuNh+8hUz2LdwX34JcnjxnhB5eZ
	lFjO1KLXtAKXfuE8baJuLGjqKvUXuKQGiGeg9ZRTWN7HpFxS+8QvoPIWlFAPMHIxiu6wDSp3Nic
	g6iXIcpDMtOT35sSbNWMxLQItJzR9uOJ+1+AMIEitUh2qqGM3vYWsUcwFzvQRmU5HC0VhDQ=
X-Google-Smtp-Source: AGHT+IF3QjsJmNeFQUlv71ScCM/JHUwBhA9e0EreL8D1YMbyrznxmVTHPXCBPb3xsqalvG6Lu+AMqg==
X-Received: by 2002:a05:600c:444a:b0:443:48:66d2 with SMTP id 5b1f17b1804b1-454bc56e39emr152992645e9.16.1751993793091;
        Tue, 08 Jul 2025 09:56:33 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:2a4a:c4af:2315:5f08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd3d7d51sm27295965e9.29.2025.07.08.09.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 09:56:32 -0700 (PDT)
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
Subject: [PATCH v3 0/6] sched/fair: Manage lag and run to parity with different slices
Date: Tue,  8 Jul 2025 18:56:24 +0200
Message-ID: <20250708165630.1948751-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This follows the attempt to better track maximum lag of tasks in presence
of different slices duration:
[1]  https://lore.kernel.org/all/20250418151225.3006867-1-vincent.guittot@linaro.org/

Since v2:
- Fixed some typos.
- Created a union of vlag and vprot to help understanding the usage
  of the field as suggested by Peter
- Use min_vruntime instead of min
- Removed resched_next_quantum() which is equals to !protect_slice()

Since v1, tracking of the max slice has been removed from the patchset
because we now ensure that the lag of an entity remains in the range of:
   
  [-(slice + tick) : (slice + tick)] with run_to_parity
and
  [max(-slice, -(0.7+tick) : max(slice , (0.7+tick)] without run to parity
  
As a result, there is no need the max slice of enqueued entities anymore.

Patch 1 is a simple cleanup to ease following changes.

Patch 2 fixes the lag for NO_RUN_TO_PARITY. It has been put 1st because of
its simplicity. The running task has a minimum protection of 0.7ms before
eevdf looks for another task.

Patch 3 ensures that the protection is canceled only if the waking task
will be selected by pick_task_fair. This case has been mentionned by Peter
will reviewing v1.

Patch 4 modifes the duration of the protection to take into account the
shortest slice of enqueued tasks instead of the slice of the running task.

Patch 5 fixes the case of tasks not being eligible at wakeup or after
migrating  but with a shorter slice. We need to update the duration of the
protection to not exceed the lag.

Patch 6 fixes the case of tasks still being eligible after the protected
period but others must run to no exceed lag limit. This has been
highlighted in a test with delayed entities being dequeued with a positive
lag larger than their slice but it can happen for delayed dequeue entity
too.

The patchset has been tested with rt-app on 37 different use cases, some a
simple and should never trigger any problem but have been kept to increase
the test coverage. The tests have been run on dragon rb5 with affinity on
biggest cores. The lag has been checked when we update the entity's lag at
dequeue and every time we check if an entity is eligible.

             RUN_TO_PARITY    NO_RUN_TO_PARITY
	     lag error        lag_error 
mainline       14/37            14/37
+ patch 1-2    14/37             0/37
+ patch 3-5     1/37             0/37
+ patch 6       0/37             0/37

Vincent Guittot (6):
  sched/fair: Use protect_slice() instead of direct comparison
  sched/fair: Fix NO_RUN_TO_PARITY case
  sched/fair: Remove spurious shorter slice preemption
  sched/fair: Limit run to parity to the min slice of enqueued entities
  sched/fair: Fix entity's lag with run to parity
  sched/fair: Always trigger resched at the end of a protected period

 include/linux/sched.h | 10 ++++-
 kernel/sched/fair.c   | 96 +++++++++++++++++++++----------------------
 2 files changed, 56 insertions(+), 50 deletions(-)

-- 
2.43.0


