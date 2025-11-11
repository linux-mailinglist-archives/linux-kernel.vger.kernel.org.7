Return-Path: <linux-kernel+bounces-895714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE062C4EC22
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD0564F1283
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD43363C54;
	Tue, 11 Nov 2025 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="il4tFN4K"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161E363C4C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874042; cv=none; b=TCEvsxHPOEIgb2cP7BNCK3lcZOEsc4JxVryn768c1CGzg4Q6B4ItUM9Ow6FYX+cZZmQUyxxORi/HWnBVA9tJg9aD6Lj/jCm0rIeywS5HlFpJlrZfqby+2c5IDzduxY8Ov7bS6MCwWZQnfkQ5trltp6+eylecemG/Hv/jpQDujqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874042; c=relaxed/simple;
	bh=exXPbv8F9cIfrhHTxhSis/wzZIan0gY30z+dZ74lt1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5tDAjKuXwqtqqct5L8Yoqq+AR2EVUKbpHTOZGL0QlcH2pXi6bKDycxVV5xCBQqeTmdyH5iVMQPWRYl9vdzgoD1pu0tgzUyHeIQILvw9N+bVfKHWZ0QzC2GqGjEWvZVi37aZ1cCj6nGD8RVx2+nLMHAhKm61WCNGbSTfhiqZkqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=il4tFN4K; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b55517e74e3so3747113a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762874040; x=1763478840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXmtHotN5KZffmUTu9Owly8mSzQe53/VPy+vlDSmfcM=;
        b=il4tFN4KzuNBhi/uEfuWbsLo6h8y/1l6B93u5BnM/jFv0Gx8hPMH086rPCSRNsCynx
         0RwkkFaksYt9/jXbbOLv/8mgOmt/IQz2eEVHcIUbRZGkYgfT+TVJ0rMR1luXgs8pVo11
         Fh/gXDEQLbK7jYj/zcO1Ro8Ee9fBsx2MTBL4LCgaPlfaM8a7pTYYDmTRF1gmHhytuULg
         OhQHsvlOND8yL2cmgppU2xmVD7j/Q+U2ut9kD49MlEYgaChPykS5cIemw0c68o1kCcLW
         oIXlG2WpzIEAuccc/sgQVPOFwl7v2cEFG1M9LeocrCr4+IwpO6nd97zMXAWZ4I9YQCZN
         gMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762874040; x=1763478840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OXmtHotN5KZffmUTu9Owly8mSzQe53/VPy+vlDSmfcM=;
        b=YlsDHTBX6ba/94Sd3pKbKliOXuMpu+WZSd9/Y4KEFtdQDrN+ywwVuExgkjqaKxn09v
         sQd/WqCYzJDZva+f0UkiF9lJovmLllzVQ5D3eMu+VFSmYkl65VZBvFNJ9P6tezd2fYlI
         hdzyFdNyBRnk3dHgFvH42dOSCwU9lLf73q88jasvJuHhn/kODL0fgF6YWt+98fh1EQvH
         XAiel/wryC7s1TWJ1uXFasnwTGW8XSgd5Waglakp2aM1rl8rTlwmOQqtmZyT9YlvpiJu
         lzoJiZh8+Z/ORE4ZV/cu5tt1P9xd6JfRZSeGzic/+kk86WNmI+ph2I9ggf6ilp/MOs5l
         xTKg==
X-Forwarded-Encrypted: i=1; AJvYcCUcWrApCiKV8g5AcDjJfssyOqJ8cAH+2IeOIWh9qdNKTkNGPfjrFCofI6U0mxCkYS3B3Z8zTbsapzQwwYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZA05UJa7FhXCOCS0Y3hM+n17LcvCWYPfhZJloLzp+z8Q5N0ks
	mS7qd4cTEcmJyciEYzAWPZPXIpzO7GqHnKJvGj/CCsT82JwDkXaFKyNw
X-Gm-Gg: ASbGncsq+FfFABAfvZOizh4nuYxvS33yOcJiDIYeIMSdlZL+SpOVNONTTWAC7ysNxY5
	SnIeKjSP3azK/3fOkupYLthTG0nfIhHjFq84jYyHgTcims0xF16bsUk4/MlCosHy+gp4w1vs4bc
	ZqkMLGtphCENCRKRQqMTVrSNrQGeZ4iG5EQhCFPDell/p644zjEQV2iK3OlrIO4xvOGVl36r/RX
	ydCPdWgq/8suczZDC9/59SACUDFYqIguFYpAN5nm6wM+BZRQ0ePoWo6HMgKD1GL0nCS2NWzhggn
	en9/fnezibDAdFLejDoRjraKv4BcFyG/z4Ep0QGZPOVg+gLpteQo/hh5uBf0986GGLyhtuAJVdF
	QohCTZz9oki4F99yq70GNtR6EjiR25+0Ijh8t4ylTxTTU8kA7ZZnfGVkggOS1AmIlbt22IHjbus
	z/km/Hil3W3c/1gqNgj5+n7Ipn
X-Google-Smtp-Source: AGHT+IFpHTaG+Oj/fmYZy53il1DO9yHF95r12sk7azQnEZNF97P/gwxxwk/B9EkN5N0uOgZ8NoF85g==
X-Received: by 2002:a17:903:1103:b0:298:43f4:cc49 with SMTP id d9443c01a7336-29843f4d12emr34013475ad.24.1762874039940;
        Tue, 11 Nov 2025 07:13:59 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.177.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dcd050asm43325ad.81.2025.11.11.07.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:13:59 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de,
	clintbgeorge@gmail.com,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH v2 3/3] hangcheck-timer: fix coding style spacing
Date: Tue, 11 Nov 2025 20:43:40 +0530
Message-ID: <20251111151340.9162-4-clintbgeorge@gmail.com>
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

Fix minor styling issues for proper compliance to the kernel coding
style.

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---
 drivers/char/hangcheck-timer.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hangcheck-timer.c b/drivers/char/hangcheck-timer.c
index ff141fdb4..231cbf7b3 100644
--- a/drivers/char/hangcheck-timer.c
+++ b/drivers/char/hangcheck-timer.c
@@ -69,7 +69,8 @@ MODULE_VERSION(VERSION_STR);
 static int __init hangcheck_parse_tick(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_tick = par;
 	return 1;
 }
@@ -77,7 +78,8 @@ static int __init hangcheck_parse_tick(char *str)
 static int __init hangcheck_parse_margin(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_margin = par;
 	return 1;
 }
@@ -85,7 +87,8 @@ static int __init hangcheck_parse_margin(char *str)
 static int __init hangcheck_parse_reboot(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_reboot = par;
 	return 1;
 }
@@ -93,7 +96,8 @@ static int __init hangcheck_parse_reboot(char *str)
 static int __init hangcheck_parse_dump_tasks(char *str)
 {
 	int par;
-	if (get_option(&str,&par))
+
+	if (get_option(&str, &par))
 		hangcheck_dump_tasks = par;
 	return 1;
 }
@@ -168,7 +172,7 @@ static int __init hangcheck_init(void)
 static void __exit hangcheck_exit(void)
 {
 	timer_delete_sync(&hangcheck_ticktock);
-        pr_debug("Hangcheck: Stopped hangcheck timer.\n");
+	pr_debug("Hangcheck: Stopped hangcheck timer.\n");
 }
 
 module_init(hangcheck_init);
-- 
2.43.0


