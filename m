Return-Path: <linux-kernel+bounces-790573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A9B3AA6B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F041C27B41
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD82F0C4D;
	Thu, 28 Aug 2025 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFcpQ/Ul"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACB023F405
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407289; cv=none; b=sMmdK8Qdc4fPRBxwwthsl+SXpxVYFBUkdEHc6Y7rGxKRAne93f17ZwMpr4VPZob357KaxJf3g0QXWbwuCKwJsDA+UcjBmg5KS0nBnYPvvWc7lzZJCatmYCbD7zwDaUUqMtfAzdLpQyAth9zLN/xxolqOhiX/1A9bCJRSh2JLrB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407289; c=relaxed/simple;
	bh=UB32cd4v5nOi4SKgbHLmKFdETxJPIf3iE4l6iXI7l/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOqCY6ZbXpoZJaLO0W19SnpzEOl3f9awubfAlNyZthvwo49y3AOkuDUUQOsYDDPmSPXT0eKcSgjzWxUXEWdR3a3ZgYynLR0egzwVhWz9l5hJNIuJGOLRR6tOeUsFOGVg3m7Bm4oh1cNfV2wo/b9JzlROkGN2Z1w3NWKGT0Lz/cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFcpQ/Ul; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso11220465e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407286; x=1757012086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WN5onauXHoolTP647TVCWaTXWh5ZZ45V4uGhZZF0eeI=;
        b=VFcpQ/Ul9t9kQ334OaqaOGIgMkOz2qH4lgivwyxehqSS9Z4gs2oSgKY0fBsFxksNho
         illdvmhoiHuiHsXAWb+mX1E9Tzd6ehsZH+ML34JYapeYbx4R4CmXhcjwfn1/9CLntAvT
         pEbAS6x5K9urCImCgHif1ypWYgUi6mMvCygW0uew/A7ihQwym1hWKLlyTpYXogHh8rMS
         QARmUOCI3xXTquS2DOi0+En7f9UcaVYWgsoapdXwABaF+w2D5+i2VXxSE1a8hLvUy8WP
         6NAk4Y7ydW2SsqOt7ZNv68dLsFEAik5oSF2jg5MaRvAboIbdVqItFqQRKuQtQwQ7jIeQ
         zXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407286; x=1757012086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN5onauXHoolTP647TVCWaTXWh5ZZ45V4uGhZZF0eeI=;
        b=HIppzJv1jqNNgPEfdzWFP+3cjlXTMLc4ugIPcxVeiezbUg6zbnnPf98OCXXGxExTQ6
         AQQn3C4YcXb5OLvCXif1JwuWbzLfX1VtfZhvCa+z/Jm2+Wl9/SrAXa8jW+TZmry0mV9S
         +6GPDhT7bCq9gM67Qi9yDzO7PYSG2TR4yo/O9luhBvRek99Lx+wkT2z7bZnaidBwRX9n
         J2HADKVUM6P+QJezEw52ZU8laPMcI2G9iLVhigkdqYUxM13FFy6Vfu6ptFAe+NfulGLK
         UREQ2fih9aijHoAM3vuAvU+++OCXv5r5uHdR5E3Z8025l/hqiLAYTCFp92w31ZeKnubP
         TFEA==
X-Gm-Message-State: AOJu0Yx4Vp5F3/tlGZZaFS7XN+JSdFZmAcfE2h1BzrArljl4ne7xWGgP
	VfBZw+0cCrGj9VTw3jrK9d8lQ4iL7Ry3vxXIP6rIhJyw/TroLy8LR4qUHrrAg9wK
X-Gm-Gg: ASbGnctrmGZhNsTcJ9JGzbfxVs5lMMc3w9FIf79u5dRftRpewzpnWOkvbGqlspu102a
	0D4yHwVCuMor9I3xzpGqTESu01AIS4A+5xobXAF1E88G39LBoXV8IiwSj0zpJ0t+zArD/fI6VFy
	fBNvJymH13ufDVCXE3Ax95OFKKwmuIdiBQ4iV9PATWHM6Xm2tlxwuJpwp+3lbRAMNlaN/vt0l0h
	EVGgjhUHVdSCmBtlLTJA6YXGTW+hp6y0urwxJE20Th1VpUSQUkSFyX67REX4nG9IlFjkTL4xPjD
	kOwGAITWTh5+QhMbtTtYuWjC3PZbXhM5uGugsTcTnjhDHQcU+o3NO+HH2ezJ2n7JfT1NsSsRsVF
	KADkqti/qNPWSuzUW+Wn8ChOL1oUYU7rJixidajk+DKbfc8sZqvZqXOf0UZD7fKZNlo5m0BsJ76
	X+PuyKTCOm4IAsX+RkGmILtq8MhL9WBmv5
X-Google-Smtp-Source: AGHT+IF0Rh6n7fC7olPEtXHMwYpXxl8PUWr3IiTKB4dklAaWD1cR3Ik55m8boq/MJ+gbUEZndOnQNg==
X-Received: by 2002:a05:600c:4f4f:b0:45b:7f04:6cbd with SMTP id 5b1f17b1804b1-45b7f046e06mr769575e9.15.1756407285495;
        Thu, 28 Aug 2025 11:54:45 -0700 (PDT)
Received: from fedora (2a02-8389-2240-6380-b418-985e-6bb5-99d0.cable.dynamic.v6.surfer.at. [2a02:8389:2240:6380:b418:985e:6bb5:99d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e74b72esm6348495e9.0.2025.08.28.11.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 11:54:45 -0700 (PDT)
From: Dennis Beier <nanovim@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Dennis Beier <nanovim@gmail.com>
Subject: [PATCH] cpufreq/longhaul: handle NULL policy in longhaul_exit
Date: Thu, 28 Aug 2025 20:54:35 +0200
Message-ID: <20250828185440.9654-1-nanovim@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

longhaul_exit() was calling cpufreq_cpu_get(0) without checking
for a NULL policy pointer. On some systems, this could lead to a
NULL dereference and a kernel warning or panic.

This patch adds a check using unlikely() and prints a warning
if the policy is NULL, then returns early. Also, the loop variable
is now declared inside the for-loop to match modern kernel style.

Bugzilla: #219962

Signed-off-by: Dennis Beier <nanovim@gmail.com>
---
 drivers/cpufreq/longhaul.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
index ba0e08c8486a..9698d56bfe6c 100644
--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -951,9 +951,14 @@ static int __init longhaul_init(void)
 static void __exit longhaul_exit(void)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(0);
-	int i;
+	if (unlikely(!policy)) {
+		pr_warn_once("longhaul_exit: policy is NULL\n");
+
+		return;
+	}
+
 
-	for (i = 0; i < numscales; i++) {
+	for (int i = 0; i < numscales; i++) {
 		if (mults[i] == maxmult) {
 			struct cpufreq_freqs freqs;
 
-- 
2.50.1


