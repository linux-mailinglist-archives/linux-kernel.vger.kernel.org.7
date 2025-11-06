Return-Path: <linux-kernel+bounces-889038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73ADEC3C82D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D3CCB352297
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21E034D4D8;
	Thu,  6 Nov 2025 16:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M7tFu/oH"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD302284665
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447089; cv=none; b=KcVWCldilu9KYcVKnE9a+xYlt1vjk6/DmrSnT5cP9zaz+t66AAVNbKlhM6QFFungi982nA2VHehithKtlb5pYLfWkbltVq7nirNhKKSwbLon9HPQLE7PPYcubd59u5ZuTAYmAHywUx8S7MUXSufvBptcMeOWYB1vK5ddMYcl0X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447089; c=relaxed/simple;
	bh=uHCaSN1HJj7TSyL9maP/C6AySyYk+ApX2MMQbZ4ZLlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mzEzH++ArJ2h2l0QRfjb9I9/ZlU5yixPgqMw57PV+ozyxddVz3Ty/7znWbU4iKITeglnK8CsYlQlqbXpemI1/bc0tzqkYGQXIk783rrkAzpqGRNmrhyXBZzU/KWi30VyRY6as3O+B6dhoDOmmxwgmllkbjFeWODDyWJUCBWFUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M7tFu/oH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775ae77516so14083245e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762447085; x=1763051885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BIW3cS3n8yzrCh58jhXvAPIZMTRPbdX12tJ5K0TKoIs=;
        b=M7tFu/oHqJFxzsnQB1EhtPdFbC5mxz7T/M1vlTmt4nJXIAyiafQmrrosOuXJZruzzA
         p4YVwZQTPuWq5N+M9pU2soWvV9p5nmdbWVq2Eix8WT7r8jKHmaXgOeM4uxZ4ZBcib15r
         +a+2EintvnpNwtezciOhUVo2WKyGAMNYFaE6R50v89iO+aHihjcZiKIoGEdcixYnkwj8
         rc78FbPScwlbxJcC2VrIi7u5Tmc+vSDzlklTZH32xOQ9rkjgauE5d+CqvYmu4aSHY38G
         DaXzW22xiymbGLf1/0nZlQ0T1nHRSW8SkG8vOWNnpmnmjgPFAgzjFkbfOp+KpBC2Pjql
         y5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447085; x=1763051885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BIW3cS3n8yzrCh58jhXvAPIZMTRPbdX12tJ5K0TKoIs=;
        b=SqlZ7i8MGINfwnD2ht8iDfEBbBdA02WOE4sHNVh9CiW1xHa+AZ5BDO3BCL65l8xyiC
         vvxhAoAuVorRu9oPXp8GUfJH9X0wngzGxvJQvtMBSV0jkCRDxhslr8Tiv1Igs5U9GnoM
         dDEjeeAOnmNB83LeJ/8K6HfH/nvFaHDxBukG7Wuj4+nnqbGeDKhGQgPBidRpjtdRR+2l
         9iPo1dgmc1PqqEfW8adWIxnXsnWE6vEofbgx3fUVh3YE8JXIXqWy3KEf75HCCcDz6oAr
         BROuqNscF3DawVcQcq1lTMIaNFoDA0zM+4/nx0stYLRTsvUElIamwNIEGMd6rG7ZOITw
         2E6Q==
X-Gm-Message-State: AOJu0YxxmdSKeGNI7DQK00+NmMQAvJDhGpk9ubjXnnIOFHXETp1PQXzy
	I+ICYeYFQg1k2+epjZ1if5KulDI9db2C7Ini5lGTMAwWdS1c4P2c56tR9BL2aE1gqin7r4eHctq
	ivC4j
X-Gm-Gg: ASbGncs33FNaBKY/QvQwulBIEkTYynoPyqmplbrGrpQjEQEWP8idN/y7nL0v2lrOtHx
	IdH5h9l72n7ktA2UvZXJvYml4+NAQMsS664/EMZDXPI3FgRZe3MihTx60I6PryB20nsgd1m5Dwv
	j4XgokNkRYOi/GzYY0P6EGF2w7dTfNvvFjwlwIXhdcj7X7saak9n7gzSfv6CJgcM8YsRCWajqWb
	KR63ccFbAas6qiyLfs3XoDSaOu4FDp1wPTDXXQJSZXO1BcFEKjmc4LyRs+6wi62W7YXMlXqiY5n
	aUd3MxLEzvVjITWzS5+rmtrf19lcw/nMaVwu5KnntoStCVp/0TkkSAhATzBh7l1ZUsLA8KdpvNI
	v1e5F6ykCqFpdUgfW9LaiQGH2D3a1W51e2mmyLAddAsSL3u66bgNWH8jSD7yEm22LP/R7ExIjw+
	0BXEAq3a85yjowEcu48KpnHu0=
X-Google-Smtp-Source: AGHT+IEjgkNrSWOVJ0pFSgXHlp3nXPxcUMJ0BCl/+QeBwIyxvF9R3B+0c4btthob/ZR/dpqpdOq8fw==
X-Received: by 2002:a05:600c:310c:b0:45d:f83b:96aa with SMTP id 5b1f17b1804b1-4775cdac841mr68114705e9.7.1762447084572;
        Thu, 06 Nov 2025 08:38:04 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477625e88fasm72581015e9.15.2025.11.06.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:38:04 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] crypto: atmel-i2c - add WQ_PERCPU to alloc_workqueue users
Date: Thu,  6 Nov 2025 17:37:58 +0100
Message-ID: <20251106163758.340886-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/crypto/atmel-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-i2c.c b/drivers/crypto/atmel-i2c.c
index a895e4289efa..9688d116d07e 100644
--- a/drivers/crypto/atmel-i2c.c
+++ b/drivers/crypto/atmel-i2c.c
@@ -402,7 +402,7 @@ EXPORT_SYMBOL(atmel_i2c_probe);
 
 static int __init atmel_i2c_init(void)
 {
-	atmel_wq = alloc_workqueue("atmel_wq", 0, 0);
+	atmel_wq = alloc_workqueue("atmel_wq", WQ_PERCPU, 0);
 	return atmel_wq ? 0 : -ENOMEM;
 }
 
-- 
2.51.1


