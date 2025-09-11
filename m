Return-Path: <linux-kernel+bounces-812890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609CFB53DEC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB16AAC23B3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363C632A83F;
	Thu, 11 Sep 2025 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/czUfLM"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F14311974
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626754; cv=none; b=XxLHegRp8KQwI6xQH4R4MJ8YrtEfSCSQxYHfWQAXh1I5YdfgiEHHJTxy7WcjrpL/0jg596hvfHJxmAyGpg74lMjtGObn5lgwxDNLpVBzB4f+cR8UzpSaSZX6iFhbjJA/w3B4v4VpR7zSKXmbPGT2liInX0KfF8mxqIz8luD6GTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626754; c=relaxed/simple;
	bh=jYTp9B54aHLVfgeXIg3NyIskdozVnt9ZijXB+1faPyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z20zCp5/acE6ozalytRhUqJAzpUspILAZLoU0CwNym4TLLktge0RU7ayHP2LC/QglQjDbfIGqm4zmNVdfUcvMQMfZUxQoQvqhzFkYiYuJWXlBP0fpcWKGFVySzTWxtm3TeejIb+ilm6w+NqlpkuYd2GFA+b+S2RSsaWxGQEnLgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/czUfLM; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8877677dbaeso29821539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757626750; x=1758231550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWtqPHzvZoScVts3x626CqF+Swe2KDKHU2aMYO19y8E=;
        b=U/czUfLMyJNA96dbl7MtsEqMij1Uhc2dAEremF2fAv3/hm9+L9khEFpJ/II381rfs5
         fC7Z8Vng0vChcPFPSJVNC8NPZbYK1bey455pQsPsCVxojsNu0/lgAuO8AYHHICJZNCUV
         Nz2Kf5IptgdKLUADIL8mLvJSC7rWrelXv9YCTh1AmYRMjNSHsYDYl/2NmsiKs5QsT/Fb
         5y8j4BqzlLbUrfujrUDK4ky80GU4ERsTkzwVgln7Kir3PHjeZnF97Se8NQnqSEgu5JAb
         zIs6DaJv8p+E4O4OTZlYNX8qF1CUUamBJWFGa+C5AHrsbQjWFotyQmcxNv3IT7puEy1p
         61kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626750; x=1758231550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWtqPHzvZoScVts3x626CqF+Swe2KDKHU2aMYO19y8E=;
        b=LB+W4+uCsqBQrkOscnDFQUxYCpIGvsf5uvmbB1c695A9WwftIhUJk3Vcm39Nz7Y34X
         u7Y7YVg39a9IXZvsUFp1H+smoaS3cO0B5nJORrQda2hfElE/FWUQG8wfTnDNjraS1Sli
         R4YM4HWzcPd/EDh9PiYdoCz14NMTKltUU8pLfO09dkDeYQ44knpIqXFE0s+uS0HLDJyr
         vc0pngVmFEAqgsMXkJNy73ubD2Z6YvHJUYjoZ6i17sVG71FLDzAwLIgcQOTAi7NHsVWu
         4MKNZs9Bewoi9SbtZCDcoikJDwQqOsKgR0dTQWTyhGi7e5I0wV4uoNGW6vaXQBqIj8n+
         uGUw==
X-Forwarded-Encrypted: i=1; AJvYcCWLnPntxDGy2upTG4tKBbdGZHdsXEHWCLHmx9h+PnmcGlITrzaP0A3AOtPwVYdfpj14wTDdC8Cs5eBUNBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyByV+xnyiLpwWe3IBeXVt+Y3LjdUw2ENWIqDfKiEBfKr1GS0KL
	DKug2jJll92iavnOYPMLL1Q4j6muZJ1BtMPLbLegLyfIHmfaoJxXisnq
X-Gm-Gg: ASbGncsE8Gn4yvVreVLTg/eeJcWL6laBQpn8+5Mtc4p5vMXj1vHyRKEyPs3ialH1kKF
	j/hY2cJuhxP90X0bSFDcQy6foS2VadPAw+V6/8pLz/QzvM1uUaHpt6xzlpwZZuYE3fOm/RXdodP
	7Fuclphxt3xWRBKiVC555odDOEuWlYXgQMTtC4VYIZtl5q80J4EY0TimF0knyeSJpX/YtnEgqn/
	0d8aiWrQxy9qUkhiIjik27MJjfAxhz00dhp2gnNWg9uT73buAqBsH9MOEdmg2//Y3an886FSvzr
	rpXr6iLCmQHiqySdVIKl29CP2PyrFfF2PID1BUwvXs0muLNZcg9mhxuayxwTVi5ASutDEZvft/a
	KK0LTvm9Ise9ciHZ9bzFLGiRxkXnOJXG5jg3BpoyvSNnwN/2lvJutFU76PYvdHJpc7P9I7qxiG5
	4trVnHwJLXhIXncA==
X-Google-Smtp-Source: AGHT+IE5LddwjuBNCTtYiX9X9AVovxOJ//0BaqdW3KbJpOPnh+BMlS5K5COQlhpLlD6jCU5d7XYB5A==
X-Received: by 2002:a05:6602:1591:b0:887:574d:dfbb with SMTP id ca18e2360f4ac-8903451f4cfmr111537339f.11.1757626750604;
        Thu, 11 Sep 2025 14:39:10 -0700 (PDT)
Received: from godzilla.raven-morpho.ts.net (c-73-14-87-86.hsd1.co.comcast.net. [73.14.87.86])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-88f2d0bfdcfsm104024139f.3.2025.09.11.14.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:39:10 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com
Cc: gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 23/30] dyndbg-test: change do_prints testpoint to accept a loopct
Date: Thu, 11 Sep 2025 15:38:16 -0600
Message-ID: <20250911213823.374806-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911213823.374806-1-jim.cromie@gmail.com>
References: <20250911213823.374806-1-jim.cromie@gmail.com>
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


