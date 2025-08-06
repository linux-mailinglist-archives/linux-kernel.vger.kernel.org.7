Return-Path: <linux-kernel+bounces-757294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2A4B1C069
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BFD180661
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F76D2066F7;
	Wed,  6 Aug 2025 06:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH3jlUME"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4EE20110B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461657; cv=none; b=Akpr47utzSKm0sXwyuKlmzYD5e49iTkYmuTew8o0KVczW9WteyJ5VpZtHkC7aWQ1GqGDuo/p1v9YBNGGC+vYfw7/27F0kdNh1lTUMuhEhF3a2+O4xEHoQqkHYus/aZDHwp/x4vDHMPu1Fj7KmN9fTpBLFuhgb2EYRVZu5zRzFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461657; c=relaxed/simple;
	bh=ArxsUmBRLlbSgLLVtSCRW2TXy+NtPKUl63JAPtSukp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BbbVJUQgepmLRXKuVT/S9fQmuFnoiIDlagWgkPPf0L5jt24/qlTmO67kPwD2+Vi5PMfRszMOIUWvVaVdFAbdm3raE0SYoMyVhZDeIKyeDSVxsoVcFbgX8yg5VG5t8B+8CZVNTcdQ59LohKXJzdEytv4ZgcM19wYgtJcCrcoJtU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH3jlUME; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3226307787so3984225a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 23:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754461655; x=1755066455; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v3VgAx1fS6I2c71PvMh+h8E4HzTPn+s88CNs629QlCA=;
        b=DH3jlUMEwtzW3BVhI5F35HDQnK3+qhPZeMs6IjK1TG8xSXvQs3Ikhog/XbHxir2oKc
         QuDcIIOfO9V9xKgQgsCVyDsL+44xV0Eq9ZrOjVtCGXChTB+/AiZnbGUHeR7s3bsgKk3Z
         jCMssPBmY4fLwKhLmHjXih+1L4MuJlmLui0pKUjfoHNoLfacbsFEux5wgqVWT8Kj3fvT
         LeK+fY4KRwBEBhpEe0vvte0utf8Vn0l4sp4zWYbB1lUcQ7R1xs6fjdsrEoROgB+dm45Y
         v/PgRRwK3gRzTEWZKSM8a1+AprjEMVXKdAUgMrlG8NqN7M7skMOm/YAkznWbSxC6kw/I
         UTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754461655; x=1755066455;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3VgAx1fS6I2c71PvMh+h8E4HzTPn+s88CNs629QlCA=;
        b=nrVdayaV1cXy5J5mEpuf7iMV/peytTjwAqbON5g/4bhR3r/1LynjJ6ESOn/1DOzQ4u
         vV3EqM7dsT1rqxPM8gsApemZDiwhKzSi3IJOXXWNYwfHOQ0/hjxp0cysOgxb+TU5MEIE
         61vP2zlqzcXnXnVKNBLbIkTBYSztOMsUYFyRsWOp65TEhq9hcDOGzfJDeXOJuhzSUk9Q
         EHIyhGQ7Cg2vFW2J1ouqiGB8/AQn9yDLFevVTfNNqkmJYmWP/3MiClL6Zzuj9716aJ78
         cYUAwMfzh32oe+YDvhjW0suXXOP+qHCxkT6ZmohGY95305Neo3XlwoGM43uatvrjiK0W
         gBDA==
X-Forwarded-Encrypted: i=1; AJvYcCWGnvpqdQ2ByXu+6Q5BuCOByFJF869wLTidklKPKIi4468b6EkFxqZqL5usS733JTHMrzEcQ+yQC7MbIlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy4sZ3+fMqbeiva0nQm4re8UvVm7uH4EQbPPQuBM1j6/A6IfCZ
	Iz2zh9v0/wMO5S2AhohPxDFJuFcYdBN2o8sMBRf9hPg0YOVEItAgxvHA
X-Gm-Gg: ASbGnct8jp5Fp0A23C8cuzsdMP5A5t3HqpHMQnZcF6sLFRkAV2vuKJ1S8t9xxU814aC
	tYY7O0Wg/5kySmyfTyW987CMmkdR9wOe6Jjrn7iXY+JLA8M4o1XiQkNdLixQfxOe/hRanb4ejea
	9c8qyGnA+oe0O+X8yq9E7bK826BYkAeVRPkiklF70CpCopcuNHhPW42yy101D80fH52723BguDH
	Di6lToTrxzKMSbWEVFv09MNMIBfb5LSoDRk0K/oow/16SuwrRjmCukAPTO48Ai3RQ+r0nDzmrg7
	clVHMY0mRtIDrqHzeLSo4qTXRiBZ6AA6vq6jamv2mH1cBuDjDKXTSm3cxqu8jXowrkbdlHkc6P6
	9bsgU94PEiNnkxBupDnLl1w==
X-Google-Smtp-Source: AGHT+IEpNrcd5b5s+6Lh0/TxzBSctjDMFTnSnsB9TlfDEOgYkwSscobfkMZxY34y1QWt3oSEck/+zw==
X-Received: by 2002:a17:903:b86:b0:242:9bbc:3645 with SMTP id d9443c01a7336-242a0bfe727mr15011065ad.55.1754461655477;
        Tue, 05 Aug 2025 23:27:35 -0700 (PDT)
Received: from localhost ([106.105.221.248])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32102acbc56sm8223370a91.2.2025.08.05.23.27.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 23:27:35 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Wed, 06 Aug 2025 14:27:11 +0800
Subject: [PATCH] greybus: svc: use string choice helpers instead of ternary
 operator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-greybus-string-choices-v1-1-3e1c91048b62@gmail.com>
X-B4-Tracking: v=1; b=H4sIAL71kmgC/x3MQQ5AMBBA0avIrE1SFY24iljQjppNyQxCxN01l
 m/x/wNKwqTQFQ8Inay8poyqLMAvY4qEHLLBGtuY1jiMQvd0KOounCL6ZWVPiuRCUwdbt3Z0kON
 NaObrH/fD+34t4QiOaAAAAA==
To: Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 linux-kernel-mentees@lists.linux.dev, Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754461650; l=1226;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=ArxsUmBRLlbSgLLVtSCRW2TXy+NtPKUl63JAPtSukp4=;
 b=P45rsFVpVU9VMZHYEQEdptLJC7YPc2z7ZQPoW7edIi9BkJs4M4LOUBYu43c+mYI0vGXbDVG4z
 b0R0MX8eaniBGUB7JAcRFB+nCLiXQC6Wsaaw72giYI/Agx0YVHkLkxx
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

Replace ternary operator with str_enabled_disabled() helper to improve
code readability and consistency.

Generated using Coccinelle semantic patch.

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 drivers/greybus/svc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/greybus/svc.c b/drivers/greybus/svc.c
index 4256467fcd35..35ea7147dca6 100644
--- a/drivers/greybus/svc.c
+++ b/drivers/greybus/svc.c
@@ -10,6 +10,7 @@
 #include <linux/kstrtox.h>
 #include <linux/workqueue.h>
 #include <linux/greybus.h>
+#include <linux/string_choices.h>
 
 #define SVC_INTF_EJECT_TIMEOUT		9000
 #define SVC_INTF_ACTIVATE_TIMEOUT	6000
@@ -73,7 +74,7 @@ static ssize_t watchdog_show(struct device *dev, struct device_attribute *attr,
 	struct gb_svc *svc = to_gb_svc(dev);
 
 	return sprintf(buf, "%s\n",
-		       gb_svc_watchdog_enabled(svc) ? "enabled" : "disabled");
+		       str_enabled_disabled(gb_svc_watchdog_enabled(svc)));
 }
 
 static ssize_t watchdog_store(struct device *dev,

---
base-commit: 7881cd6886a89eda848192d3f5759ce08672e084
change-id: 20250806-greybus-string-choices-e6d53d2382a6

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>


