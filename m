Return-Path: <linux-kernel+bounces-774393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B13B2B1A1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2805204D3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAEF276038;
	Mon, 18 Aug 2025 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L0lZYV9z"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2912750E6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545298; cv=none; b=dkG+lIuduOYCrVysxi5TNe5uVQPEemPa8AtB1UFhcb0cDFiDwqzGl0IOHUi2s5qClm8SRpPiOgoFDJQqVkmzx3dIn1Lu63Iqxv1Nm7RZ1YBGGUsHavf/WYeqfvlIBufA6RWsh8rkyS+GGlbsgZst/1O7R70SUxSu0Utk+jiIxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545298; c=relaxed/simple;
	bh=eWMIZgp5iHXfiCRbCgK+sZ3dVZXFE8CcfbA+F5NJMds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfz+TzG0UC1sjzqDmB+Gb7+8MyAgxiMpbQPAAVhY38W+b/LgcG1b9OyAY99lroekuligA7YSzELA2vE0F50rag4dYn0Ag3p4b9lzlVaQBeVecNlEdKVc/Q8IdFWapnXmwK8rnWX0UG/gfQsajeVJn4MBi5eOhTIQZ7GOiewxkJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L0lZYV9z; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e7af160f1so415113b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755545296; x=1756150096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqyW9AMQrLhoPKJmxnqNq0eziaV39pB/4sS3+0Stwwk=;
        b=L0lZYV9z35MaxUC/L65RtgjOuVXOvLTNF8kUtI2guiMwqugvreTsJRKN4EkQXc3m03
         y/9y3lvye2R01wxJS/WWkbFrYlsoEoWvlGRUlCEKEEKrzt61j4T3nPIMtEgjBvrNyG8b
         xNte1dajFtQa/SXAn9uZ1sBZ1F6T26E1S+9W0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545296; x=1756150096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aqyW9AMQrLhoPKJmxnqNq0eziaV39pB/4sS3+0Stwwk=;
        b=PNaQFerkq9fnI04g9h3yLlejO2yb4W79Jt49sTrVupGNOk3qA+uJsP2GtMjUQ4ZK6e
         VADfScXzs1VzkoCE82jS1hk6iDozaNg5MZpg6PgAeoW1PrvyuJyqLDoxPj4Xfw+AZyBO
         0YL7H7Eeq0RvLlk1xHd+R9+obcNjgX9lFO9caMujTY8eTnlBv57opO5H91/a05MU9l78
         iMrDlCDsTmRkj8kI6m+QLOS9ENzncFfNZJsZFFXxH0tDLbeHVdXcK4ebDhRX7IZylC5d
         nq/Y4xolaWZr0SAk9S2XsNcuU5kr/K7wCFlyttxPWC/dnJ/xUdlP4uboCYyfAO178Czq
         MSEg==
X-Forwarded-Encrypted: i=1; AJvYcCXvSutHzk8BieJfWJFMc37DVwK79sYEvVniAXpRPvt0QtSJDQkbbsUUrGcpoquVMcWXiGSAP+OcyKkviik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm6Vm3P3sYefgiKgTwdA1bihlya1h8EgDE3u/GEoEf1h/p62By
	sM7aCWmR4Bf4ZveApx3Oi9DOan5zRUO0Aji6nUMTTt89kN4AHLRSQlIzY/qxezHBtQ==
X-Gm-Gg: ASbGnctCOGgWrqtqA4pJnEFgYZAhEn6dA87tatlw6MQuUQ3YWs58HW1dBSlFt33XJpX
	ytHOubbMJIPhjgbrCvs/MgaOMCoMVUbY5vDU4Lp7QkRR8rXQGW2XGobcHL5dqQodaV4/jqZWB0J
	KvnTIKqq6DBE4wQNu7MTF1jm0Y/fIKfvB+QQolMWUEpgW+ERK4PPEiKJ0+9NgvPaI4uKWV8djSo
	UW03Ij4+vdjRSqQ96ltIkYKMo0QgaQL/sp95WzKCOdN24ElWXB75+OWQ233i8V38B3vOFfPLCFz
	DsfRc+60fLTIoFfUsd8Y/Gbww+XX+uf8wBEGtdzx4v6Y3VPvquv3ctdF/WsI+MIK2oYZyJCVgKU
	eTwm73OEQh6g+ewubV9xmOCE1hbugnaKjl2bRK+XYec6PcDvE/SLSf3NJ+yFrHL+dLcHGzHI=
X-Google-Smtp-Source: AGHT+IGUiDIahxTrO0TYLvTSrJjpE4pGbPAwnmno/R5lKQScD3kDdYlgMAqEtTktqb0OtuaWUfumMw==
X-Received: by 2002:a05:6a00:80f:b0:76b:e109:a1f4 with SMTP id d2e1a72fcca58-76e7ed284acmr471305b3a.12.1755545296604;
        Mon, 18 Aug 2025 12:28:16 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:87a3:e3ff:ace1:d763])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e7d524c88sm354460b3a.76.2025.08.18.12.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:28:15 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 4/6] genirq/test: Skip managed-affinity tests with !SPARSE_IRQ
Date: Mon, 18 Aug 2025 12:27:41 -0700
Message-ID: <20250818192800.621408-5-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250818192800.621408-1-briannorris@chromium.org>
References: <20250818192800.621408-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Managed-affinity is only supported with CONFIG_SPARSE_IRQ=y, so
irq_shutdown_depth_test() would fail with !irqd_affinity_is_managed().
Skip such tests if they're run without support.

Many architectures 'select SPARSE_IRQ', so this is easy to miss.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/irq/irq_test.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index 56baeb5041d6..ba85e4eb5211 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -46,6 +46,9 @@ static int irq_test_setup_fake_irq(struct kunit *test, struct irq_affinity_desc
 	struct irq_desc *desc;
 	int virq;
 
+	if (affd && !IS_ENABLED(CONFIG_SPARSE_IRQ))
+		kunit_skip(test, "requires CONFIG_SPARSE_IRQ for managed affinity");
+
 	virq = irq_domain_alloc_descs(-1, 1, 0, NUMA_NO_NODE, affd);
 	KUNIT_ASSERT_GE(test, virq, 0);
 
-- 
2.51.0.rc1.167.g924127e9c0-goog


