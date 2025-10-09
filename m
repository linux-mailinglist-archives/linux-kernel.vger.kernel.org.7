Return-Path: <linux-kernel+bounces-847310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F3EBCA826
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739B91A660A4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD5E2F3C35;
	Thu,  9 Oct 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYVxrxmt"
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4F42F3638
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760032756; cv=none; b=E5CVlnMvZRY/MyvuDNv5jjY19rjja/z2ATbkoL7oN3x1hnMn6Ah7T4KfNQtrFLAjKMrG7yZ/2ewdjqZtsMMJbnGfQ284ExO5kCHmVCm13cpDbAliLkq96/zk57x4q5nBzCyTECF5HSSTrZvL0OLRVHM8fr/0KcKTs8n3wyDoFLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760032756; c=relaxed/simple;
	bh=jYTp9B54aHLVfgeXIg3NyIskdozVnt9ZijXB+1faPyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nb44aIuVSXCVz8R1tgbBNmosasa+oE7H8AiS7dXanJwiNZXtsdSPHcykvzWQ/3FE/3rV+5ctbnOA4PrzqeMedLJ+x8qgDxo7hwmuDRGQ1e4QqOqQxp1ZdqH+O3hnm7LVuxZgfojHYHL3A6/ADyYILruEo3DFw5dIjzLJals1OJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYVxrxmt; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42f5f2d238fso5468485ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760032752; x=1760637552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWtqPHzvZoScVts3x626CqF+Swe2KDKHU2aMYO19y8E=;
        b=GYVxrxmtfP9Oer68iYLGxPFxC7DN7Bwk+XK0nWdKqO/Uk8l3niU465PGLWtj0cgNQK
         V/c4EI8qlcrpiVjJOicW5YeySKeoqRXWf5/Nq/Cy2mnwNj0+0gVLbXKPWxcq67OvyqPn
         +2s7WudNyjl16EN+rcoOJo8YvFQ4cCkoUA2ljGjxCrSzxqwLaJS2B3bZdau9OXfc7LjF
         FphaAUHP+OkmMEN6nxBN6NKljd9SRZVtiJ3EtAuv9dvEZHEX3DJfUXOoNdLg3Gimr7X5
         rmp8fQ2nkhjbjimk7xTZyvot5OJ0NikG++atjMfspD67k/IVbqOTfrW5HDqyriLqLBp7
         I8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760032752; x=1760637552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWtqPHzvZoScVts3x626CqF+Swe2KDKHU2aMYO19y8E=;
        b=WuYKfqaw5z/w1DmCC1RSfJcECJ4Bnb+l/EkHczFwPczNt++J72oMLvjzZlV5OmO6XP
         wdPpol3beZF5zvattSMA4SD/a7eVx7YU8I5SSFbHv3mgfP6MwI+jsg4Vwa4/Uh78C7u+
         Krp6XGS7FyfQbqgY/6Gusx5y5D2fRDS7gEDI3kR/TC6RMqR92wMCBT4uc+pIz2XZuXOM
         +Cf8T4cRt5jvhrztakaKe3/M0uHV90k0WmdD23dirDCbsMSZaM/jaMpLRbAZSzVig9zG
         JYVy82IImqk/6rSWdBk/vtD0NA3p4+0QAmTokFSK59zKfMjdKH08/a4zRc39I01qeQGO
         MPGA==
X-Forwarded-Encrypted: i=1; AJvYcCXeyYqGCe8hk5FwKVqVIweU3NpzWWuJ40YMp1EYsTAVBK7GUvnEihTbZ6iHrUaGopmjWDSe3aJgJ1ymwWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+jUCmFsxLZzxxI8PSpViWAFrE76OyDeUPm8NjpizafK5dJV26
	N5vgoeUO+/y1ggGNHfexQY/fIOuHPD9i3DMXvFHHIFIJqpAg0gtlzD9l
X-Gm-Gg: ASbGncvsYfDxtDqz7ATDSWlIm2ZaPM9sNgSufhr+ptNd23W4I2tkfPnE5BWVMiMaebT
	GoljOqKzTAFNc0d78CVgoPEt/Ck2Zsnv2MdpZx4+rdN8eRjk8zrV3TX1IhtBAOzYcbcDUGglblO
	NzjrAP83D1ATL9eGmDV1c41U0vYlTaxHIttXNYLo7Yu2X915RLQvdL3u7sQYMFXh6uulwmZEKZf
	GCWabKyqPR+Pi91kxuQx45dVLEJxxvW2y8844lII42czHZMWFhb2VjsHiC2lLgD+taxN/JHV1Op
	qsCf5kj5qAXbVH74QksvAuPEmtgVugCO2RvQLmPtFFjTYXfs+9LmLQZGlPtWYyv8dWy8INMY0iV
	3xKQCZK5TNLygbS7jMmOVT0Wmm14otQyB3AU4Kf62lMJpZUn0kQGCy0CGjBa96tXjt2hysKLElr
	rqtkiExZbgfFWaYJioBBKc7XSU8ZW+Gmwg08dHUg==
X-Google-Smtp-Source: AGHT+IHFaHIr6hhGjGpGvstoe1cPL73AxoLQd3mHJOdW06DK9B2zxkHb4Qpq4bia8u2yk9gHtlYTWg==
X-Received: by 2002:a05:6e02:160d:b0:42f:991f:60a9 with SMTP id e9e14a558f8ab-42f991f6190mr5265655ab.7.1760032752391;
        Thu, 09 Oct 2025 10:59:12 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-58f7200c4afsm30256173.35.2025.10.09.10.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 10:59:12 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 23/30] dyndbg-test: change do_prints testpoint to accept a loopct
Date: Thu,  9 Oct 2025 11:58:27 -0600
Message-ID: <20251009175834.1024308-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009175834.1024308-1-jim.cromie@gmail.com>
References: <20251009175834.1024308-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

echo 1000 > /sys/module/test_dynamic_debug/parameters/do_prints

This allows its use as a scriptable load generator, to generate
dynamic-prefix-emits for flag combinations vs undecorated messages.
This will make it easy to assess the cost of the prefixing.

Reading the ./do_prints node also prints messages (once) to the-log.

NB: the count is clamped to 10000, chosen to be notice able, but not
annoying, and not enough to accidentally flood the logs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index b2bdfdfb6ba1..fa81177e8089 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -29,18 +29,25 @@
 
 #include <linux/module.h>
 
-/* re-gen output by reading or writing sysfs node: do_prints */
-
-static void do_prints(void); /* device under test */
+/* re-trigger debug output by reading or writing sysfs node: do_prints */
+static void do_prints(unsigned int); /* device under test */
 static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
 {
-	do_prints();
+	int rc;
+	unsigned int ct;
+
+	rc = kstrtouint(instr, 0, &ct);
+	if (rc) {
+		pr_err("expecting numeric input, using 1 instead\n");
+		ct = 1;
+	}
+	do_prints(ct);
 	return 0;
 }
 static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
 {
-	do_prints();
-	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+	do_prints(1);
+	return scnprintf(buffer, PAGE_SIZE, "did 1 do_prints\n");
 }
 static const struct kernel_param_ops param_ops_do_prints = {
 	.set = param_set_do_prints,
@@ -191,17 +198,20 @@ static void do_levels(void)
 	prdbg(V7);
 }
 
-static void do_prints(void)
+static void do_prints(unsigned int ct)
 {
-	pr_debug("do_prints:\n");
-	do_cats();
-	do_levels();
+	/* maybe clamp this */
+	pr_debug("do-prints %d times:\n", ct);
+	for (; ct; ct--) {
+		do_cats();
+		do_levels();
+	}
 }
 
 static int __init test_dynamic_debug_init(void)
 {
 	pr_debug("init start\n");
-	do_prints();
+	do_prints(1);
 	pr_debug("init done\n");
 	return 0;
 }
-- 
2.51.0


