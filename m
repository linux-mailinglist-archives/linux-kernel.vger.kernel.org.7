Return-Path: <linux-kernel+bounces-802476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A17DB452B0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4309A63E60
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC9B30F552;
	Fri,  5 Sep 2025 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Pt9LjeMi"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF997267B90
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063351; cv=none; b=Fe6ax6In8osHFaKDx3Ereq2eYVCzMv1xwksKn3chg0P9QwnJZWEmmS7xlON83ENpntlUAPV5/EWOeEcsnmqft6ecFi7XR/wc1w8fIMyFVJDn5tGk0HMI7m//VWMKbuim7OJyW+9bz/T93EEnE+6RYm3ceWkGU2OfzXgJa8YSeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063351; c=relaxed/simple;
	bh=vk9Cb+Vk9ZtUW2KuwlTe8a3xodP4C8YTSL3zTrsGK3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6py2WIVP8gpOejFB6BYmI9Ww7TWznHrVUkDusAZnBM7PjaYZ8eqQIPRBTP2ius4gsntqMMIlPTvNIm9QBC1O93RWitwKLs8TQxENBt8ji1iZAI+I+pbrWSznFyssaD6E1Titj4JVZIV4AGUOZg93/s88a+rHH7fRA9NzK7oRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Pt9LjeMi; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd513f4ecso8017965e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063347; x=1757668147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK0RwwSJzlC/WRnGVCpPlRTi/ItQrFK4FNQp0Qe8tM8=;
        b=Pt9LjeMirypo3z8h/SKmsc44gkIo6ZN9yDsPxxcUt4OH66zqdkDN23EjoLr/oupeXa
         3HzLtyVQ4vpcYlR584kDR8JQExK4zOYYBQ916/43sX+Ofs+5QFR32cwW6vGP0rzgctUP
         E2bodtFwDOz7ZxcW11ZQMH4zyDnuWgSkoWcpu/RGbS6VgS8ZUKmZlBYVDMAScurDz3Jl
         RqsXHn8+SnrpLAOxCQtKOPJH9nnV+dlO9lH8s/PjSzmQUV9mDTElMHgicu0y2Bbv01kZ
         UCFGefygTAZ2ri9W+998vWTXkOX7047dIK0dF9Q3KIL5C4jvxhsmSaWKT0GIdtBHCEyz
         I+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063347; x=1757668147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK0RwwSJzlC/WRnGVCpPlRTi/ItQrFK4FNQp0Qe8tM8=;
        b=IMZm3Qx+/Q+pHVd4Z29Vl2OH19vvTXsb/s+3htK6NHvy2beINaO8xc378w28j7WqHW
         3I7JBOvYgIr+UOV/tyTKiIreS/volatPDldDRNDoQykdWLKXwfXAD1bwbj9GSMo5DD8V
         g4BLDRjBtAH7/UnkBCwXDfMO0wSpG9ePiCbcX6HXLZQWxQ9pd9giTw2FszffzJR0lip8
         bHx09WRl0DEiyUvgqTVdCm9nnZqsVMAAcQPDFkiPozupJ2y738P88+mP0uJ6BkLaeTZz
         N0C5yeF9lXXXYbBl1ktvbNRPh2awjRZFtN8YLL+MjA6P1x5vrYWZkr+6RMVF2NT0z+p/
         P5dw==
X-Gm-Message-State: AOJu0YxxENqF57wpyGvAK9JWFZDNl1g8OykrgvEHBBfMKj4PBzoxpuOg
	Ky4Hp/lJ+NquKWZIWobL4ChM8yCMf1sE3xzCpl7g04lg7n5oplDq/uqfbOLE/xMHNU20bBnMiSE
	CQbeQ7nI=
X-Gm-Gg: ASbGncvqaacnO8l7pYwMp0alszbStrgt7BnOkVTAcUtzbpRENejdS7NleVHG6BW4EsJ
	Wu4RmtUKM7ASEAFNf3yTVcrg8DDPJ4Gt69Go8cguhqU5J5u/VzEehrM6EWZ7s192aBWZeCi19Wg
	MAs0sbvI4gUd2/8kW5XI2UVz0Ciqg4kHGlL5HInme8Vj2Y9HWch7z9n5oKZWJM64F/xB/pyFgjN
	cQIqnfM2faPxJzNq4BisLEc0dVBArcUxFUciXOLPgTVvNUnHoPeCJ0SKsMWvOCRvygOl7BWOi0d
	9DnK0PFdtGCbfoie3QUpH2zlW+z2pYyyHN5V2YJL99wZtNKWweSq959UBXxyjqP8EgkYTZlJEBu
	EYq5QMJ2yIT4o36LGJHbxogUs3eLoDwiRg1SJ1Pq9EP8UxWY=
X-Google-Smtp-Source: AGHT+IGaFXgKftq7eqLnUWiGjqoNmZIxu9zYqDeeosWGUHYB3ka7ctAPjbsx0oj7KSjVVtsUh1fiJw==
X-Received: by 2002:a05:600c:3145:b0:45b:6b6e:ea37 with SMTP id 5b1f17b1804b1-45b85570c73mr166696325e9.19.1757063346899;
        Fri, 05 Sep 2025 02:09:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm12931995e9.7.2025.09.05.02.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:06 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 1/2] drivers/s390: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:08:56 +0200
Message-ID: <20250905090857.108240-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090857.108240-1-marco.crivellari@suse.com>
References: <20250905090857.108240-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/s390/char/tape_3590.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index 0d484fe43d7e..aee11fece701 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1670,7 +1670,7 @@ tape_3590_init(void)
 
 	DBF_EVENT(3, "3590 init\n");
 
-	tape_3590_wq = alloc_workqueue("tape_3590", 0, 0);
+	tape_3590_wq = alloc_workqueue("tape_3590", WQ_PERCPU, 0);
 	if (!tape_3590_wq)
 		return -ENOMEM;
 
-- 
2.51.0


