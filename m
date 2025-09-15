Return-Path: <linux-kernel+bounces-816879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D6AB579E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283A7188F0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF15302758;
	Mon, 15 Sep 2025 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S5d/zfjj"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55972EA482
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938003; cv=none; b=KcmWvEG3qukGBKHB2usDFdYfHIHourrteJnQxmFoB8NFJLVUA/iiuXiA/lYT+6p/NtkN7mBKKoiqQdcLUIEqcxnXAlsicsW2wPwMu6SwQK9oUA1epru8LWSkzKEK1b0+rSR2Uhm9HEqt6jEWm4tm32UnErsRFvhOFsdhpEeVqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938003; c=relaxed/simple;
	bh=pqoax34Ax9usK+3e9jmP0XDFWfB9JzxMKUmMmacFw8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auK68h7V90SWUcZSjFManQjJVnGrVhCBnC534MQaCrtrycg7poGFRqp6D2Fr2u7Rr7YmacxW09P/TbA5wprr+UeW7gxVrX9Ff4Ok1mWam7L3LBSSRXl3syTFzuG+6BrENCDNiDLGGLr/n7l5+vrhHTvBgR8/rGmsZLqVb5uOQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S5d/zfjj; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757937998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7tVqiznUpoaNUx9SMKLXa0FJsHlIFlRDldLiHbrCkRM=;
	b=S5d/zfjjaWP0z2wVzeS5ooK5KOC5/Sc/gXGWyJq7+GltpjmguadafJtTRZvLF+bcLYVWbX
	qXjbOwmGyC/HFuQyVDkbN1432yGILjzaJQQcRO1tGak2Cc4iFZahS6mqZLe9xtmZoC/KBN
	VrpsQgMEzfZhAzunBz8r+ec/4XUpej0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] xtensa: use HZ_PER_MHZ in platform_calibrate_ccount
Date: Mon, 15 Sep 2025 14:05:39 +0200
Message-ID: <20250915120540.2150841-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the hardcoded 1000000UL with the HZ_PER_MHZ unit macro, and add
a space in "10 MHz" to improve the readability of the error message.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/xtensa/kernel/platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/xtensa/kernel/platform.c b/arch/xtensa/kernel/platform.c
index 926b8bf0f14c..f14713060fd4 100644
--- a/arch/xtensa/kernel/platform.c
+++ b/arch/xtensa/kernel/platform.c
@@ -14,6 +14,7 @@
 
 #include <linux/printk.h>
 #include <linux/types.h>
+#include <linux/units.h>
 #include <asm/platform.h>
 #include <asm/timex.h>
 
@@ -38,7 +39,7 @@ void __weak platform_idle(void)
 #ifdef CONFIG_XTENSA_CALIBRATE_CCOUNT
 void __weak platform_calibrate_ccount(void)
 {
-	pr_err("ERROR: Cannot calibrate cpu frequency! Assuming 10MHz.\n");
-	ccount_freq = 10 * 1000000UL;
+	pr_err("ERROR: Cannot calibrate cpu frequency! Assuming 10 MHz.\n");
+	ccount_freq = 10 * HZ_PER_MHZ;
 }
 #endif
-- 
2.51.0


