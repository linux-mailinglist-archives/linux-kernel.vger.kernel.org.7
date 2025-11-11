Return-Path: <linux-kernel+bounces-895712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FC9C4EC19
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B86A54F6481
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB235F8DA;
	Tue, 11 Nov 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xk1EG8Eh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FC1361DB3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874035; cv=none; b=oWT/E/dVVa9fn3XhCJ6Fpw4+rZ+NUIHfcSi11rWzdUZskyguCl+JlgS38PBhy2P3Czl4M/gAhyXdjPl2jm+cU7zwn+BlHRmexOuR2Ypf+NAM86PAFBSNDcEulmGjUqLB/xpBmuwwCK1Q493pO94i9C1Iol/VBDMUDXUkkuJnyno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874035; c=relaxed/simple;
	bh=dtUjLOdH30HZ7lq2Yut9cRbOFxg6eVSJ7fh2zMthlpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7lEoG/WcpdluwyyI0n9BXZG1ESJRyjV2YTBRt6GdAqwUac9U/kTzfCmFs/8MG5VLsJ4G6YOP7rYID6TPun4fSsIKEXing9Mw4ErLPJIqEFaX6DuyxbuxRATszVhtEjTShdH/kNhHH/oWXF9I0WFoqTkZ7gz7FSe0oxhOYw2cMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xk1EG8Eh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-297e982506fso36093935ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874033; x=1763478833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUyh9ZW3/kLx88s0Qv7t672gbmKqLdg3BEyz6Kj12UI=;
        b=Xk1EG8Eh01GOshDWCr2jRVSvhtwDU53rTdHATRd5uByQkXAJWHPBiB3Nps5xktCNWl
         kqO6RNHEHDI/kiLZaYSEqWdztNl0+4rkScn10E+1iEMDC5oX5K5ry2h8qRJADCcF+48F
         MutKvx+TZhowR0rdEJDgNcZk+3VTfxcsTEtfbA8Xqiq9JGxCxzWVKNibqXqpgWQ6FkfD
         SDN/xHivpt0HT5RG8zYo0J0u3Errt3T2b+SmlCOMRATHyDiBx8WmzoYP/T+/gvL38RmM
         lgav/YuasQGgxfdV2WLBHKqTGKfBCVo65Tv5P5Vss8cinEJYHR1eJ64ubOpzsoadSfXk
         29xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874033; x=1763478833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUyh9ZW3/kLx88s0Qv7t672gbmKqLdg3BEyz6Kj12UI=;
        b=cDpPGek5EfxX6Hp97hl1m6IU2WbKCFixU19OuMWg+7pkZtQy0loQm96PG7wziVLE2d
         V7hGnG6EHRlt3F0x4upEnzjF5O7mvC13IqdVGaJBes/dTP2eOLx8MPl6rDhfQW/i3TxS
         KGF1BDBZh0vjqKvTEGts+wCbcFurhOTJbzPOttMWxw0rd+dy4l2ikF9ihVNR4kmvfTfo
         AOqKBpurBrgTjOi1Rt4wKr2l0GT7rZvFxtOCFR1UJoEZZG5CUW0V9GjFrhLvZ8ApAzwn
         EC1vTssdrx7zL1yLXq+0BX//aEieFieuCpUY+MBM0qCUgGxH6/5xtBtOE7zxnqUfwoSO
         OIqw==
X-Forwarded-Encrypted: i=1; AJvYcCWdLkX4T1p07IzFS97kHQzIHLW+QIA2SR7+XZj28Qu7rYm/arYDHSASk0p+lG9H2WNAHFV9vCAvMg4xLcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUM/kUnivS313aIKu7O2GPRFGl8Lia5PkEjHhiN7FKNvli9gA
	xozIXGyJBV6Jm2auQM8WmSTvXjImodZAR0Fk/2zoNZqIDRAx9GfK9F2n
X-Gm-Gg: ASbGncs9tvn9Me0Wi5C+JAFeshLez5aY7muMvjXG0b46peJpFSI3lLXlu9eXRp/Orjg
	HrF26UsVtAUOa6dZ/YTsVmngzww1NqK9cbPGGXlhnNuFgrar/uHvQy4Rhbze5unQt7im39IcGq2
	6FzTEwD/iisHCEawbtIX6SHAqYkFgqFEwuF6Kq4EXyjtO8E64Rx5miza+zJMYLCKOLdtCrVoSY+
	8vUqeeTZmMl3zGsopJoHUN6Weps8tYQ2lJz9Sb697eUD5qYMOp5YpWKXNAvVZjFmxbK15a82w1P
	GxdjLDhsvZKAW7AXcE1ZPPXWQIPX4KiaRYqW3LqGxcKKmyxgGl6kHzhiMU1C2TwclYERjPbgaMc
	yEvqlXBhy1U2xscQuVX+cnmIddzcgWAIiNkbGdHhMJA9CK4ln/2/sbSv9yurtBtbl8MaQIodZNC
	v4DT5qCZ+Cy+IPdHfjtHJn8TfB
X-Google-Smtp-Source: AGHT+IFZEnI8fZnhodv8vqzdFTSs7qYOInfMTTdTV9hrb6S4aEfRvMyAWau29LKKOvYeIyEUaRpJdA==
X-Received: by 2002:a17:903:32c7:b0:295:8c51:6505 with SMTP id d9443c01a7336-297e56aea5dmr158213485ad.33.1762874032711;
        Tue, 11 Nov 2025 07:13:52 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.177.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd050asm43325ad.81.2025.11.11.07.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:13:52 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	clintbgeorge@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 1/3] hangcheck-timer: replace printk(KERN_CRIT) with pr_crit
Date: Tue, 11 Nov 2025 20:43:38 +0530
Message-ID: <20251111151340.9162-2-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111151340.9162-1-clintbgeorge@gmail.com>
References: <2025110649-elves-steadying-a4d0@gregkh>
 <20251111151340.9162-1-clintbgeorge@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace printk(KERN_CRIT ...) with pr_crit(...) and printk() with
pr_debug(). The change aims to make logging more consistent and
readable.

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---
 drivers/char/hangcheck-timer.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
index 497fc167c..21ef8a6a0 100644
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -126,23 +126,23 @@ static void hangcheck_fire(struct timer_list *unused)
 
 	if (tsc_diff > hangcheck_tsc_margin) {
 		if (hangcheck_dump_tasks) {
-			printk(KERN_CRIT "Hangcheck: Task state:\n");
+			pr_crit("Hangcheck: Task state:\n");
 #ifdef CONFIG_MAGIC_SYSRQ
 			handle_sysrq('t');
 #endif  /* CONFIG_MAGIC_SYSRQ */
 		}
 		if (hangcheck_reboot) {
-			printk(KERN_CRIT "Hangcheck: hangcheck is restarting the machine.\n");
+			pr_crit("Hangcheck: hangcheck is restarting the machine.\n");
 			emergency_restart();
 		} else {
-			printk(KERN_CRIT "Hangcheck: hangcheck value past margin!\n");
+			pr_crit("Hangcheck: hangcheck value past margin!\n");
 		}
 	}
 #if 0
 	/*
 	 * Enable to investigate delays in detail
 	 */
-	printk("Hangcheck: called %Ld ns since last time (%Ld ns overshoot)\n",
+	pr_debug("Hangcheck: called %Ld ns since last time (%Ld ns overshoot)\n",
 			tsc_diff, tsc_diff - hangcheck_tick*TIMER_FREQ);
 #endif
 	mod_timer(&hangcheck_ticktock, jiffies + (hangcheck_tick*HZ));
@@ -152,7 +152,7 @@ static void hangcheck_fire(struct timer_list *unused)
 
 static int __init hangcheck_init(void)
 {
-	printk("Hangcheck: starting hangcheck timer %s (tick is %d seconds, margin is %d seconds).\n",
+	pr_debug("Hangcheck: starting hangcheck timer %s (tick is %d seconds, margin is %d seconds).\n",
 	       VERSION_STR, hangcheck_tick, hangcheck_margin);
 	hangcheck_tsc_margin =
 		(unsigned long long)hangcheck_margin + hangcheck_tick;
@@ -168,7 +168,7 @@ static int __init hangcheck_init(void)
 static void __exit hangcheck_exit(void)
 {
 	timer_delete_sync(&hangcheck_ticktock);
-        printk("Hangcheck: Stopped hangcheck timer.\n");
+        pr_debug("Hangcheck: Stopped hangcheck timer.\n");
 }
 
 module_init(hangcheck_init);
-- 
2.43.0


