Return-Path: <linux-kernel+bounces-782596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082EDB3228A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D63B19B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F32C21DD;
	Fri, 22 Aug 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SF0kEHzP"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C94D8F7D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889312; cv=none; b=rGCUhKkMzCo+qtaHklkEbTrR1QPEtVu/Mv6Ssx8nVxNqT4Q3lwpr2WHihYK77Pw7RUkUvXL5wH6wUQe6xmk8cU4KAEWJvw11zXoMPQ5CECTqCEWG+9Ue5b0a4EEOed4k93kkXhGdj5rRU48lqg1MqbPQkqix8o+0kyf4OfD5l6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889312; c=relaxed/simple;
	bh=mlcQtSh0hqaRcHWIznFySlhxi/4/Wh0665fCG2bxdAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieIBusDjhi8o/kjcjxmwLO/MeeqMwQLb/35IV/aA7MEQhspJJoCr0re/eXXyKQO+lOhyB3EFQppXmRlIMTeMWBTdrAuP3iHcRfworXiaSkX1ZCRd89HMaQxwG3BrJ4CSRokX4Njr41m3BRaFqjVeIZS+7a9MlGRo4iNrHDuljO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SF0kEHzP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7702fc617e9so1080247b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889310; x=1756494110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLGTqHSiHacelS/0B9Hd+pXTKy+T7n8diYWFTswYvyc=;
        b=SF0kEHzPnOCeYmGlIxZwQLR6dsHE1tlahNfcY3JEuIsHke5gpzkyAmjLjYYHn46kD3
         iYISTwLlxKy4RmJs1EpUkbtwVUwyS7k8tJ+M5gvBHOvD8ihy8XsEZbzRYrPwE/W+fXr5
         WXG2lbflK3ARx2JrwghrqVAU90hy7n4uD10Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889310; x=1756494110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLGTqHSiHacelS/0B9Hd+pXTKy+T7n8diYWFTswYvyc=;
        b=e3uWoLCQa2FrhXa4FM4sxozYfnFGrOnXzrtouK4ZXbzzUFV0eBjnOTvDel0mCc9+4/
         FL0AU4llbavOOu/tSh7CL7ucjcUbmwVnf2E7IIiAH4mr0nfZ0rurlqd7XWNb1gg1MFGv
         +J3ehyAX6J4otAsyQ2XSMMuAN7eTDAE/LIabxu2nG8i3kdsGnVQBjsiiTWK4eHcuq6c1
         yDkPQc7tYO8YeLRAwgqsTdBgJfhnjTrvifJikGxLjrqGWEZoXribqyVdNGRD9t9ZGFuc
         5mFQ2jf2lvJfBIZvYRTjnsSzVNwYzr7J6bDArHEWxCy2g782kOKpgR7GtrXKxYroUflV
         Plog==
X-Forwarded-Encrypted: i=1; AJvYcCVNEOXFHgXHvY5bdk6EZ7ChQSZABE1B02VR4enCQphs8k668+3aeqaR8P4NitZBbQIviWbQVrD3ikE7ZW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBCleXBXJ3BKrMaPY/AWn5MNIQIskXdYoxNdjAnPcmubtk58UX
	aX8tKxiMkS/cANgGJU2YyfM3BkoucFaWpAii6iUcRvVI5QdRZYyXMthZS+G67grEL7AwBh6YNn5
	3/hw=
X-Gm-Gg: ASbGncspGQZNnK2Fdv40sWqnvwGr3kEg4KE+EBZv8v5G4mrmYdL72sWm31XNLlYxbF4
	IWtY7CAggrp6zN1Pr1Epr04+CR+joyG/bJZ7ER51dXFxOR2WR7E2J/Paydzv1WTZbhIqTK4gJIz
	6WZBxkdcaYylPK+MC/nFg1Wx3KPM5SEUSxTE2plGf3BRz2GJILeBddXYqRDpcL0W7wej6mRei/Z
	smuA1bESfr1arq13LADSoFfDcqYUJtW6xKQ7ZP1oS8SqZ3mR4Hoah3b/zGFSWf1d9e6Nm09lP63
	CfqrjUB2bwoSjz5wg+VOlhKZNGjtEc6PQh9/M3xtTGTWc5VzFu/hNs7b3ORnwRDR2fTlvA/7Tl4
	bkZPnpl49qUB4L7g2S6+CrwGbBRTnQbVRvjFlprKUkAqyMyL9FT8zB9TTVJLGDcix+sSn/g==
X-Google-Smtp-Source: AGHT+IEJpVJX7aV2ACIw6Rj4vHW2PTWmPuZyvJSxgQtwFFTZFJR0kuL4UoyLgKSxesSQJr+uWR1Ysw==
X-Received: by 2002:a05:6a21:33a2:b0:240:1dca:d13d with SMTP id adf61e73a8af0-24340d4407dmr6792727637.43.1755889310348;
        Fri, 22 Aug 2025 12:01:50 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3254a4d9159sm559489a91.13.2025.08.22.12.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:49 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 1/6] genirq/test: Select IRQ_DOMAIN
Date: Fri, 22 Aug 2025 11:59:02 -0700
Message-ID: <20250822190140.2154646-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
In-Reply-To: <20250822190140.2154646-1-briannorris@chromium.org>
References: <20250822190140.2154646-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests use irq_domain_alloc_descs() and so require
CONFIG_IRQ_DOMAIN.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net/
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---

(no changes since v1)

 kernel/irq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1da5e9d9da71..08088b8e95ae 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -148,6 +148,7 @@ config IRQ_KUNIT_TEST
 	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
 	default KUNIT_ALL_TESTS
+	select IRQ_DOMAIN
 	imply SMP
 	help
 	  This option enables KUnit tests for the IRQ subsystem API. These are
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


