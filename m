Return-Path: <linux-kernel+bounces-749440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F67B14E71
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 15:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95DE3B88E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 13:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141E5192D83;
	Tue, 29 Jul 2025 13:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtzE+7yL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDB54C79
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 13:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753796052; cv=none; b=aCYPPA+uV1zodmVtcglhlVHaZ1VZsYM+YmadGjtYWe9LsbjNba+K8MRxPGHkJprKr2rGxRgm0qVysJoJGkhc3xcEwZWOYswLUdl6GsiZFAdN+VtH6ss+qO/7eK7kT6y2njVKz3oLByzPHuNvzmnP+3ZdVRBBOLPFJ7zyK2vVIEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753796052; c=relaxed/simple;
	bh=6S8uDIVHHBTWsV5A0VeLl+bEA8MPjEWPgvyLyMsf3RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QoAaA6Pm+oru/mWlOFDak4jYkWHtcZrhnaoEb5UWJdeKIbddnbsufNVNRpzPK4Lg2pc58Qrz/PJ2Yyf8LhX1X07Wn7o/yXTCrq1TrV/BkOi4zGH9ccX8oJfp21C7W2oe9+aGdWd/gP3fa0SY3VeXL2m8lutDuVuwwRsqNKBRkSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtzE+7yL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24031a3e05cso8018995ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753796049; x=1754400849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=znZJfjztwaxHeWgbXPd2N5VplBeaiXDoJkiNiwedcqg=;
        b=PtzE+7yLbAf/Ms4R6u5bWo8AoElh+XB6kkL+QiC7fAr+4HdIcGJ3cTtj+e1qamWSYU
         oPHfFCQGGtyp9kaqOFZWB7STo8F6j+5Z/mt6Bc4H7kl6HJob/lor/C1W2CQ+rEmG91sY
         L3OO7WWhAYObHG/IFhqtXNHJdj4fiwMGrrrFS3qLsK2H6PpoZ/pQ/iSmOhD4KWKjm6YA
         fxg0v9JOjZwXzBEUKATv0g4cwhgK5BQmEzccwJIweR/1uiaHJBBr0yUsmm6+5AO1ad2i
         mUF1y5JtwB4PUZwnNVcfAJFBydREDnOXQr2BG8ZScXHHJ0ZBLUgRZTCj/yoR4GKngONC
         dXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753796049; x=1754400849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znZJfjztwaxHeWgbXPd2N5VplBeaiXDoJkiNiwedcqg=;
        b=QrnNG+T7GvqsfG8ZOQJhZ7IpNyh7Q6oTYIMG+E6qcX6VqH1VVdxzrk+ZZiFdb2Ifxk
         KE3Aicgi5pr/hwBuxHUhPEjSTyoagP+V5qDYMO4nZ3s6ellIIEI5VXAybUomSUmOtf0D
         qk1w3rYOjH6kFZalkDff3rBHIgTThvrfJQPz2XsIGWs0ILr1+Bl3gVLVbzwfrGrDrfOP
         sBboJif0nH9TtMjX0AYZbzf/wxJCsZVK0ao89vbNJAbFDhTj64+5WHjqzTY/nmpKabtj
         W5lm4gG+LvO9hbTDAFna91e+65rFLILBFbWqcFDNIZRgdz21g99s4sO/ZV2irTIwXPc9
         zJcA==
X-Forwarded-Encrypted: i=1; AJvYcCXIXwFWFfTAuIpLlhaed3COGb9x6Yks5ZEhDwOlmuoQ8TZ9/kZEi9Rgl5Z3si+zOEzgNv5FvjFJHluo77I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKSMf7BOUuKf7NovCRWJ01oxnzpb1LOgh8b1ErhyzxzfvtNYT
	fX5suBDrKzp3otV80kMJPVyQ0l93zRaMtfc2C5ohJTMMN2N9Pz03zJuC
X-Gm-Gg: ASbGncvpj6fpDrf746r3clmbVGkC3KgS9c5mJ1nksVPiQBA4/SEH+l9/IOFll2HlU2n
	bdtaLPi8jxaizB8YORsunY2+KjK11+OVf5K1mpmjDJOuOc+hHCL8YIejqy0qLiUk+355WIQi7Yn
	kMG4DOf+FuS+UGeMtSCJ74P7wpMuBllh4Ohb/yMr+Io1HJSPVGRiRxCvdt4hG/6TK+rwfE1u8Bn
	1KQrNycSPpjuEkj+VR9AfpJrKj7Om3jhD1qKQNUgrgJhhyNvJxiSjR8AWKkuw5SVWuMXL3FoxbT
	1LtD6qsOIntSFapco87rXuTz6tJl1DyeqtnrKZ8yhHwQgP4YyCG2m4ZlPqaBeCclGeZRwIS5gbE
	v6MWdbV48daJ4KLPa7efDGUt26y/Ca5KjU5vDtqitqWSP15z6+A==
X-Google-Smtp-Source: AGHT+IF3DY0U7q1CGXUDQyWG2ha72jTh8NKrqkGssvrWl2GQldN2wm2zrrZR8IlQ0G9ZWv0k6NrYbQ==
X-Received: by 2002:a17:903:3d0f:b0:240:1ed3:fc28 with SMTP id d9443c01a7336-24063d326c5mr51966435ad.12.1753796049246;
        Tue, 29 Jul 2025 06:34:09 -0700 (PDT)
Received: from localhost.localdomain ([49.36.70.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24052e03863sm30033865ad.41.2025.07.29.06.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 06:34:08 -0700 (PDT)
From: Dishank Jogi <jogidishank503@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ryo Takakura <takakura@valinux.co.jp>,
	linux-kernel@vger.kernel.org,
	Dishank Jogi <jogidishank503@gmail.com>
Subject: [PATCH] kernel/panic.c: fix checkpatch erros on style and initialization.
Date: Tue, 29 Jul 2025 13:33:40 +0000
Message-ID: <20250729133340.9613-1-jogidishank503@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---------------------------------------------
Fixes:
  - ERROR: do not initialise globals to false.
  - ERROR: space prohibited before open square bracket '['.
---------------------------------------------

Signed-off-by: Dishank Jogi <jogidishank503@gmail.com>
---
 kernel/panic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index b0b9a8bf4560..38b4ad6fcb2b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -61,7 +61,7 @@ static DEFINE_SPINLOCK(pause_on_oops_lock);
 bool crash_kexec_post_notifiers;
 int panic_on_warn __read_mostly;
 unsigned long panic_on_taint;
-bool panic_on_taint_nousertaint = false;
+bool panic_on_taint_nousertaint;
 static unsigned int warn_limit __read_mostly;
 
 bool panic_triggering_all_cpu_backtrace;
@@ -509,7 +509,7 @@ void panic(const char *fmt, ...)
 EXPORT_SYMBOL(panic);
 
 #define TAINT_FLAG(taint, _c_true, _c_false, _module)			\
-	[ TAINT_##taint ] = {						\
+	[TAINT_##taint] = {						\
 		.c_true = _c_true, .c_false = _c_false,			\
 		.module = _module,					\
 		.desc = #taint,						\
-- 
2.43.0


