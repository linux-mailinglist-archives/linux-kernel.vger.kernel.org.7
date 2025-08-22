Return-Path: <linux-kernel+bounces-782601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD2B32293
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDF05862EE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA322D3228;
	Fri, 22 Aug 2025 19:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LRLBgq0g"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904072D1F72
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 19:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889320; cv=none; b=GYAxpHImNTFw+IOx76/XujqAaU5Sdwcapqed5t26VRZXKOQwJ3nPQ+n/CVU6tza7tYqtvafyRp6Eku9GLPgJ08G5fXSOnivY8zis6rKCpwDU96ZbZjSi1yWmeqlUjuC/LDsyIZ17+l5f6TUusD6cW2vWJ7qbKalPFkpc3dZ/e0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889320; c=relaxed/simple;
	bh=T9Xl7UOSJb9bzLmKUWoy6oZTyLj8Bqzr11x7wqMwQ3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5TQYpqQRQALkAv2UQ8Tqu/YbxcyCSfFZuDve3JtHF9AgSGmxeq87MYy1A2GB8CjGgvVbmB6xEVloHl0vg0U4NMGTLduSG++8irccKvmMZe+/vxeS3JCFzmGt7u1ezFDPa7VGOILP+nemt6OpOl0WaXSi8VpYWOrEgUCvdZJ+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LRLBgq0g; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso1748975a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755889318; x=1756494118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQFaJ4AT7s0VyfipZWYXejbB1s7k8OeAeFLkpqOojDk=;
        b=LRLBgq0gWoq4oe33JtYY5EyN+MKqY2+G1BIP2Y0jY3XF4acKP0+xq8B8lYsSb9aSh9
         XLgEPGqykvnnX09T6PsRK7Lb1KEKRcEUalp2bBGDqmnFZWw3VHoVG/QFGQZzwiU7AWKs
         9WWno3bxXjeetiKUVz1m+j8PtrBE3A3CsOYek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755889318; x=1756494118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQFaJ4AT7s0VyfipZWYXejbB1s7k8OeAeFLkpqOojDk=;
        b=EckCeZDKdmpMuo3xw0FtscdU61HPe1CZbUhIflh2Lt14UFvfs649kjhhXUfECTasiV
         5knGn7OfVxIrf6TziXq/m0TfNGUWNSj6x8IRkgOx8VDD5sALBEocJTHhIuvDk5Gf4AmL
         1fpvQBg2iGgsBo5jFyCsyVDmXylAQwIzHA+KBWzsfNlxg/udQelVCXGTsCWP/++7TRY5
         x/XeTWC5ORPMLTeS/shwb59geEP2IsGyslv3mOtkPveIkEzkaOgDEQoliE3UOJeFkMZ4
         4F65oklNN7O5yipPAug7p/0+GooOUZEOjUeTReQ4Dg+dyHvKklNnILCbxY9QDMn6y5Qg
         BWaw==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ubz9D7Juit2jZUMO/KT3dT89nljiwfVMVft1c2jEajXf22U9YqRCIZgo3bwUvqgcemC29VlxpGuf7do=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvF54LiSeaL8UQwMI7BnPt+/pLk19LDsqyrwRiQ9F5yVvBZ6v3
	IOs0JgYuhxZeebIRu7Ld/cmFtaQ/4ID5tl6pG7X8/SDMXCDUG6tpt8Io8UCdlIr8Mw==
X-Gm-Gg: ASbGncukTzOtKcPMKT6+8qgGhkTiShW+CjiZqn7YAx02NkrdnMVlr7c+yNP6IqmE0Mo
	rHMoYK4EvHOl03XUYsnR35l3nQBo4AKRXu9RxXFl85dHbGYjPBdUhpFW3xOebbeDtF35zoZfJzN
	WymwF0ckX6LIvCi/S9uvYhpxMFHYNc+8h6euoftJIA3r/CHpx1afOcEtNTLpk6bpxEA6sUbnAcV
	tCU71xoleZ33jE3k5Bi50i8mD5XDpay5RsUw+95lTDvSuwSs83bOsdV6p9Ym/4R5Jod16g81pTM
	SbdDw+Fs3BXyzy3IiNo2pe2Cuagv0DQPmxfoAfpfEn9tHJ32K0Mw4VcuwEAH3Gqm0021AkMqy5j
	fJAxx8WAESu/ozWQg/E4FFkJ6zqA7Jx60zyY/QBZFhN2mlb/PHe3C3G84EHw=
X-Google-Smtp-Source: AGHT+IE7/lr1yAQ07k6SksI7di9GFkZg/VTeRFaVY3AiRILkRCeCyUcKXcDhSV/7rbuWZWKVSC5mEA==
X-Received: by 2002:a17:902:d592:b0:240:3f3d:fd37 with SMTP id d9443c01a7336-2462ee80b64mr49717985ad.27.1755889317735;
        Fri, 22 Aug 2025 12:01:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:154c:8cf:f7d0:c083])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-246687af23fsm3346895ad.51.2025.08.22.12.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 12:01:56 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 5/6] genirq/test: Drop CONFIG_GENERIC_IRQ_MIGRATION assumptions
Date: Fri, 22 Aug 2025 11:59:06 -0700
Message-ID: <20250822190140.2154646-6-briannorris@chromium.org>
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

Not all platforms use the generic IRQ migration code, even if they
select GENERIC_IRQ_MIGRATION. (See, for example, powerpc /
pseries_cpu_disable().)

If such platforms don't perform managed shutdown the same way, the IRQ
may not actually shut down, and we'll fail these tests:

[    4.357022][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:211
[    4.357022][  T101]     Expected irqd_is_activated(data) to be false, but is true
[    4.358128][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:212
[    4.358128][  T101]     Expected irqd_is_started(data) to be false, but is true
[    4.375558][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:216
[    4.375558][  T101]     Expected irqd_is_activated(data) to be false, but is true
[    4.376088][  T101]     # irq_cpuhotplug_test: EXPECTATION FAILED at kernel/irq/irq_test.c:217
[    4.376088][  T101]     Expected irqd_is_started(data) to be false, but is true
[    4.377851][    T1]     # irq_cpuhotplug_test: pass:0 fail:1 skip:0 total:1
[    4.377901][    T1]     not ok 4 irq_cpuhotplug_test
[    4.378073][    T1] # irq_test_cases: pass:3 fail:1 skip:0 total:4

Rather than test that PowerPC performs migration the same way as the IRQ
core, let's just drop the state checks. The point of the test was to
ensure we kept |depth| balanced, and we can still test for that.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Brian Norris <briannorris@chromium.org>
Reviewed-by: David Gow <davidgow@google.com>
---

(no changes since v1)

 kernel/irq/irq_test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/irq/irq_test.c b/kernel/irq/irq_test.c
index 56baeb5041d6..bbb89a3e1153 100644
--- a/kernel/irq/irq_test.c
+++ b/kernel/irq/irq_test.c
@@ -203,13 +203,9 @@ static void irq_cpuhotplug_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
 
 	KUNIT_EXPECT_EQ(test, remove_cpu(1), 0);
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_GE(test, desc->depth, 1);
 	KUNIT_EXPECT_EQ(test, add_cpu(1), 0);
 
-	KUNIT_EXPECT_FALSE(test, irqd_is_activated(data));
-	KUNIT_EXPECT_FALSE(test, irqd_is_started(data));
 	KUNIT_EXPECT_EQ(test, desc->depth, 1);
 
 	enable_irq(virq);
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


