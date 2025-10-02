Return-Path: <linux-kernel+bounces-840066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB6BB3731
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 11:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C033188C356
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 09:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA1D301015;
	Thu,  2 Oct 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YG180d8e"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37082F3614
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 09:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397102; cv=none; b=WopfkIzg/J6M0sI6owZHVew0d/GFbiR4aq/8BKgRqLZo1DddjlUgQpKcbT82+stEl6if9YISLM38AvjKg8l0vFqgkMpd2tNduqcB57ebvfMaSUMluoHLZFBEVafgaUnsU7wkHQv8ZXGcBpZqUKH/pZ3cxwCqw/5lZXJah3E8CD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397102; c=relaxed/simple;
	bh=wyk+LiOY+/2xhWdko/Utglt2dKK24fcOQB0e8E/SMOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lr2+PDGwNbLF376E/zNNA3kc7HPFqaS+6tmU1uYS+H1S19DV9ibQ/wKukNk8Fn197J5ckQ6ufChAL9wrn9Pj2O2AR3O30HOqeQr0BPFNObG89aJHcAxW8oweQ6G5jAMPU+JQhOauph9Oyqop46MfFSvicY32lDtmYLvzHxApiKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YG180d8e; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-579d7104c37so1073084e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759397099; x=1760001899; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnd1oe+gCOsUbP0Y8B7hIjrdA1ewGBuYtns+fASNVw4=;
        b=YG180d8ehU31W6azkkDPH5yYiB0ZZEXFH5Juq9/HKcxD2oT9WWG7D4KW3v3pzgTonZ
         SJjQ+ZrHyTlCTJHH+10nfa8WVGnBvymYuy7S45mosOrnyQXuvWRsvIw3gcRK5Q5wue1q
         FdPoxP/scviegUFWPCln8dgvbmj4wYtvxlXu85iE9QEF22ADI+vgENis8gx0ZkG6c0N6
         NTks407YwrhdU/d0GciMJABzi+vWKTXI3a555958jJdh1XLZXHukyxZUaXPZrs0kEMc/
         iaO9jzUGc10CUG4P5mN7yvKyWfF3qLcyVMY156/FLS7Hz/aGTFihccOGqPeIvUeuOvqP
         zaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759397099; x=1760001899;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cnd1oe+gCOsUbP0Y8B7hIjrdA1ewGBuYtns+fASNVw4=;
        b=VUtsT02bfBTpr7fOIRoq+aU0LhxXZ2i8DGtchmPJJmSX3Z0yihecvDnJh6Gk6jqUeK
         JE2EuLpAMvM4dQATDO1gHRhy6HXIMeR4Gk7JaiccLNtRE9gZ5LNbGvmjkW8q1wFji88i
         1NanQIxkMK0Ksc7nBJzqwVbB3q4KU195saUIwxXg1siLtATRlzpktZMM5u1oH5WT4dko
         eekqdLzaOR3RLVREw88TfUeOUlL7BFy/IwARuwy4R3/ulZF7qWiskJaZ4VQ6NPLgYNCu
         RTxrgM6StWAsWuQOTmHpYThxMNNYkXESnma8+NtG4TdHyEfhJHbqqk/1nJqmESLjvf4K
         R7TA==
X-Forwarded-Encrypted: i=1; AJvYcCUTU3P03P+X86zob8McttPvJtirBs+YuUHH/mGYehhLXscRHyrtFe2BZjJjy+fYQFjVRxbZaGAbs6Uze88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhd4wgqU6i+z5QxZcKQmHDCxJpusjqFS0pwjisrkUj0pYWi3aL
	qzbmVOPJelQwyvPmPZG8AnapadUPcVxjgHZrFQEotEc8LL6Lhn5I4V9M
X-Gm-Gg: ASbGncsTrd2DT4X2qvy77ctBXQCgJsTKp4ZIE/QkBj//sj6KWk3d/MVBQLydebVU9Mz
	smCjr7yvc2fu7+m2rOchcBRrD0LOjg07HVHFtcFaQzq7tOCwZBbJ6GWS8N4HTt51JvsvaEq9MLx
	yjVuU7/IZSwvFuMdaFUTZBzm5pX3w4y4uwcH+XX0KhpOhqYo7qu/6eRYeQSNC7A/FHyeiUSm3q2
	FyzEypdcumH+r+gXhkBSUK5nANUj1NrBYMb4lefz/tHW2hZC9PnBpzYo0eJnLqYZR4kRgT9yqdr
	1KSBT75xGmvhuU4ZtW9Miz4J7oyMJjNW48k490RiSBTmkSSn+lQtN1owim4+TBkYDAkcPdpLWl7
	9MLlLATI/s+SwBpMQKNMDOp3Uou/Sx9mJeQoOjtJrVaHm/ZFGj2HjktU1IuqviC7Y0ADz61POJS
	VB0g3bUTkiLqKdPhk07iEoNjVWOHCgJSh1qBjUmxWa
X-Google-Smtp-Source: AGHT+IESR5YgtJIt0LMDa26rTnIZwd70OvmJPXrkYGT8voRp7WuzaTPAueJHEK1uF9O71i7anaaZGg==
X-Received: by 2002:a2e:bea4:0:b0:36b:9ecc:cb36 with SMTP id 38308e7fff4ca-373a74829bdmr19011161fa.23.1759397098830;
        Thu, 02 Oct 2025 02:24:58 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba2e1f37sm5575651fa.19.2025.10.02.02.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 02:24:58 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] rtc: fix error checking in wdt_disable()
Date: Thu,  2 Oct 2025 12:24:52 +0300
Message-ID: <20251002092456.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

The i2c_transfer() function may return an error.
Ignoring errors returned by functions is bad practice.
Especially when these functions perform core functionality.
What's the point of continuing to call the same function 
after an error is returned?
If the second function call succeeds, data corruption will occur.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/rtc/rtc-m41t80.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index 0013bff0447d..b24d09c57816 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -677,11 +677,11 @@ static void wdt_disable(void)
 	};
 
 	i2c_data[0] = 0x09;
-	i2c_transfer(save_client->adapter, msgs0, 2);
-
-	i2c_data[0] = 0x09;
-	i2c_data[1] = 0x00;
-	i2c_transfer(save_client->adapter, msgs1, 1);
+	if (!i2c_transfer(save_client->adapter, msgs0, 2)) {
+		i2c_data[0] = 0x09;
+		i2c_data[1] = 0x00;
+		i2c_transfer(save_client->adapter, msgs1, 1);
+	}
 }
 
 /**
-- 
2.43.0


