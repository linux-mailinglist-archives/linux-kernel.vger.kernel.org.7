Return-Path: <linux-kernel+bounces-783548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BEFB32EDF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 11:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D4A1B26AEF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 09:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0723826B2D2;
	Sun, 24 Aug 2025 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9oGXbKk"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5A264614
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756029522; cv=none; b=EOglExehMQq4GykJJbOmxWXb9yDDXGOg8AD26hYt3wOJOBmcbN86Z+lG1SUPYvSCwRPREogrDHmiDE0G+LGg3eY9fT8H44T3JWEmHdnFYoPvPo5xJ0I9FYsQVRvRcfp52Bk/UcX7gg9btjY0ppErpbw4vqzun0+I3tWrk3AByy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756029522; c=relaxed/simple;
	bh=CXpEwzcOgts0UYKdQU3OZhreVhHUKwGYoANggirmlPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh3vkRsM92xS8pt6Hu5faLIDceGKgMp7jdDXZKAJ2VqpVjdXRfVLghEhi0WgEZTve7WNszFYvTWRbzT603nKyeqHEVbh/n2dj+wNIoGDlse0ipB+F0wqRxOnFnzuzWpnEtKsDppo32T4319fUGvJ+WpuZp++DXfknWJtnA2BCHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9oGXbKk; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78f5df4so586927366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756029519; x=1756634319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB3jyeOTf+YX3hjwKO9p+5RPKcTVpxOior2qXXRyptY=;
        b=k9oGXbKkDjUCeUzLvIhhTKMzerehq4X0Wzxj4npP81NaL3NVznUvnuY5Pz3GHL5CIB
         pIciww46TaPGFFUCJY12HzBSa4FvUVUJMzcY6ZTiBwsczdNMNu5B16XD+1+sIAuApvi5
         nkQU1Ej/0CvBJnQT29S5wA5RV+o5ODkJnwhOFKOOTBL/+TTtau7srYcPPCzMInY7dxO5
         EVEEoa0cahvla4Owry7b99j1ASZYL/rfEQ9+6cfb+UhbxhR14jIggY1YpzjtTzfCPUg1
         XQwr/4UyX4DhmaU0awHOoftGDdKLlZSDEVBDZsAYikSayEoD2u0cnm0bUg9Enc5DDnP4
         DluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756029519; x=1756634319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CB3jyeOTf+YX3hjwKO9p+5RPKcTVpxOior2qXXRyptY=;
        b=xLIVjGkdOUer1Dik1yjHj5fzMWiuiYLMZQpzZOPD6hMYjtqbl6lxckBFXBZZzqlT2i
         TWfCr5p+QWQxLqUmBDqdPZG2qnpZendY3GG+SYH0ddBzDlr+0KjtwdZLtQTWXFXb4+V0
         R+d7i0iy3xJ/P8coAMXQZ+2g/n7QRCGI3AsL+y7sSqj9pbqbezPnL30OaHCZnPQ6IMz/
         w1J9yrFAXh9/VulKI68RB2YhgKVj4g4SbDVukiEE9h3bFtWyDKSg11q9p/344W8Mi7/7
         81vnE192JLmZXwQ9FtAnBbb9GnRd/c0haa9tOk0EIsBfobN2FtGRFcfk8tH/bbaGx7a0
         i6tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRzQ6NG9oN7/d0vSNsMKq6VIyMS/XyCgjK7MK170u8xWyqg2pJOoEZJVXhsRX8/8BXEArzIJVQrSKyj/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWcyWDb1Zedh6GSa5fOoBFsEa739DTMeaM3zVzi/bUN12f6TX3
	8so3W4cQyiTvCMjG99cJ0QJ9ofMSZGNNY4BRZYzKpWjXqoBTcFS8hZDJ
X-Gm-Gg: ASbGnctNWLNaomF+NJublQzfJ8wBPL8YM1bouKMdpa3/f/tptknJ7aWyGejrtWlR8v9
	Ipv0NVDWCxcxDJy6MDa8sQ+LRSy9Eu2kS629QZd8fYfwRcYYMqukOVFkMFAP2sFiXMwqad9c41B
	v51vlVtpMgNtTmDau7sNbwGbPxNBZPFfsZj6vJV9VL3V3Km0VwygWHImn/0JGXOenUYG2F23e2H
	rfAiBb1nJ23KOHEAXLCIK4ep9TSyCUXwGQVPH+p4mipGXNypbxhW+/lKxLrvBL4bOWRLKC8qpP8
	Zo8FcK+sK1XV7ahpgIxCM8L/1zagjj+yI3HvQgffrY2plUm/a0mDDjXxq+3+kbG09SmHqd9M9+B
	vI0rro8vddsG85fTE2ud/KzgRJg==
X-Google-Smtp-Source: AGHT+IGQeXBOoeK68ALXLYtOAYAecYc2sLvZHTeB0Ue7szRlW3hJU4FCo/iL21WNNcmTopTbWW8RtA==
X-Received: by 2002:a17:906:6a1f:b0:ae6:f087:953 with SMTP id a640c23a62f3a-afe28f8581cmr819070766b.12.1756029518977;
        Sun, 24 Aug 2025 02:58:38 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe79fba62dsm41314766b.100.2025.08.24.02.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 02:58:38 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: rtl8723bs: remove REG_EFUSE_ACCESS_8723 and EFUSE_ACCESS_ON_8723
Date: Sun, 24 Aug 2025 11:58:29 +0200
Message-ID: <20250824095830.79233-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250824095830.79233-1-straube.linux@gmail.com>
References: <20250824095830.79233-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macros REG_EFUSE_ACCESS_8723 and EFUSE_ACCESS_ON_8723 are redundant,
both are already defined in header files without the _8723 suffix. Remove
them and use the marcos from the header files.

rtl8723b_hal.h:138:
 #define EFUSE_ACCESS_ON  0x69 /* For RTL8723 only. */

hal_com_reg.h:35:
 #define REG_EFUSE_ACCESS 0x00CF /*  Efuse access protection for RTL8723 */

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 36680ecb5897..45cd2291f83d 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -568,13 +568,6 @@ void Hal_GetEfuseDefinition(
 	}
 }
 
-/*  */
-/* 	The following is for compile ok */
-/* 	That should be merged with the original in the future */
-/*  */
-#define EFUSE_ACCESS_ON_8723			0x69	/*  For RTL8723 only. */
-#define REG_EFUSE_ACCESS_8723			0x00CF	/*  Efuse access protection for RTL8723 */
-
 void Hal_EfusePowerSwitch(
 	struct adapter *padapter, u8 PwrState
 )
@@ -609,7 +602,7 @@ void Hal_EfusePowerSwitch(
 			} while (1);
 		}
 
-		rtw_write8(padapter, REG_EFUSE_ACCESS_8723, EFUSE_ACCESS_ON_8723);
+		rtw_write8(padapter, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
 
 		/*  Reset: 0x0000h[28], default valid */
 		tmpV16 =  rtw_read16(padapter, REG_SYS_FUNC_EN);
-- 
2.51.0


