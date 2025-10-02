Return-Path: <linux-kernel+bounces-840052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFF3BB36CE
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580201921650
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837E2FFF97;
	Thu,  2 Oct 2025 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2xFFwXK"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288122765E1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759396701; cv=none; b=k7IzE4Y3XP0pEnDkvNZYRPtvEKbK0wB3pTh9Mc2cRBhTL6tz0FPUKUd4W3VO0hgnIdbUkib7x8ox5CztvMzl7eRZe57g4RkGviX6hwUqfVcHZxljOgmYG3sXT/IMkyji5oE7wabMitAb0Oxsu1E0DbvjfCXW+O7J2y/P2mrL31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759396701; c=relaxed/simple;
	bh=fwR4gcFZHEySQdpc2QlbEaLFRlsqeReMKUqp/CWmTrI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpNwFpB00qMqTkftAioXPRyCSZKvnPwoqOCtih0c59+nvkzs4JN/K6qKszOyyAIYS6FtzbaGOIMs/o4ipItn9VqsRTRvdXZK33znsS2GkNWsYo4y5014DRX3fDn5eypuf/hlCnZwzLolhMG+u4+ym8gEnhYKHy1i6OflJG9lku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2xFFwXK; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso961708e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759396698; x=1760001498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q9NSRzfL4JdrQq47LWXvgJfS/TUzqrHF9LSvRcz8FpI=;
        b=b2xFFwXKsTZfuInKIT/QqU+bydAeafjsc+em8vT2KTxB2nDx0Nit8KKvHi8rrucK+r
         +Bc7hxNabgYF1qZ2Vp8AB+wTreEu+/tVFoDMYqy4uQIRkFiUeZJm/DTub2gqUoOmOWkq
         aspXRMoaXoM1csi86PtrzTCyqB1Gh8mx6OXU24NsgOF2nSWoDbYuSOTqvsVH4QO6MA7v
         rxfBUdveBWBjdPwmc1qpPnVFKHr/VAqEw9SkFYpJBPU+Tyrog8jJb5vAq17IwYLwonvQ
         S9hUGkZaBPsw2QydaFpPxrfkKvTP1WNn5E99/onJqkBR9XKnQldw1fj8kqpCyg82RzXJ
         rq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759396698; x=1760001498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9NSRzfL4JdrQq47LWXvgJfS/TUzqrHF9LSvRcz8FpI=;
        b=HN30nhhVoEYYNs3Qe0YfTXuwLbRiteufHoXBOuOZ3ySJNQ/neFOYoOCBa3tpLP38cg
         sUJrxFNcGEeECDRBAazbGgr9lMiOLsnH39n6LU1Hi9EkRQnMkDUHG+LtDEO5rLtmQp8p
         nVPwv4e1UaGVjrwyraDSwhi9ac6/eAoWTztfMKlCIyxBVV0TW7h8UyxLSpFEWVIiwBEW
         WbolO/rHGQhvxkw+WoK2+qAgzdEN4pvwr1ZqXPlDpaSKxi8tphXAo/WvCyYH3gWOgvlG
         75UpDRes/hCxLkYR38BaoGvvh4BBBuNXDvWPstqwzhWXernijcmDxTelhM8iC5XOfEN9
         7PUg==
X-Forwarded-Encrypted: i=1; AJvYcCWzVlvdSHjSzU5zJso/qP/jD1+9JjtfFp/9RLh6t60DIS5EJM1XGIlbUfnzHeqaf0meg9BNivuoyEA0S/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0RfvuZWZfKLPK5NlWR5V7MBp6LJMKNGh3zq8LK+lIwBR9Ozp
	IQ81g3aiFMWiejj/ABjfw/zArIFXEUR65r1gGv87RsOEc70eSSCv3k4A
X-Gm-Gg: ASbGncupxEjPz/yw7Avi0oJGqqFrS0+BtPACBz7UOQfCWnVGzxRQdzyNTElyEpAT6j6
	5vRtrfHLcKg+rIr6ZkXLfxrvRNhm6uzGL9k434Bs0ZkUqYykpZRx3SkU/lNrgpr+4L4WAriqPnE
	dFlQB0YzOWW1oghs68X9c58eg4G/V8szOWBlI6sGDaOMeEel7lAkaBroly7r09aNLEoMoEpmkOo
	+nRVdFr22wruwnTtF3sJ5SBx2V0Wxi6415+mXvInQLiXqYGFLPP4p1WTqzOc0FlISYjPGF5B0I5
	58DpxgEe+bYklKc8SiSqKXfDGUiWrw6yjTw3yqaykS1VHUTVQKiPRBdm5dhfRbju69xtr67rWrF
	BuZ04s6be19SP2cwuc9DfkwmzHG67nijPxqg+Vg/oDbJPsSnZmXyND4WywGUwgU8nej9zuei3X/
	SRd1BYAhGUiDdptWZCDrKizgWneF2x2o6Qb9QlYUpN
X-Google-Smtp-Source: AGHT+IEdX+6suUdGlkRNJI4CNMgiicWrGVGzkTvMWFFHsr6NunDdGKG/io4TUM6huaaCOQXxmkCBkw==
X-Received: by 2002:a05:6512:138d:b0:579:f4b3:bc3c with SMTP id 2adb3069b0e04-58af9f8608amr1960758e87.55.1759396698025;
        Thu, 02 Oct 2025 02:18:18 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b011af75dsm657471e87.126.2025.10.02.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:18:17 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] rtc: fix error return in pm80x_rtc_read_alarm()
Date: Thu,  2 Oct 2025 12:18:13 +0300
Message-ID: <20251002091815.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The regmap_raw_read() function may return an error.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/rtc/rtc-88pm80x.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index f40cc06b0979..44d324c3101c 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -148,7 +148,9 @@ static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	unsigned long ticks, base, data;
 	int ret;
 
-	regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
+	ret = regmap_raw_read(info->map, PM800_RTC_EXPIRE2_1, buf, 4);
+	if (ret)
+		return ret;
 	base = ((unsigned long)buf[3] << 24) | (buf[2] << 16) |
 		(buf[1] << 8) | buf[0];
 	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
-- 
2.43.0


