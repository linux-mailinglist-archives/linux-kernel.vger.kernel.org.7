Return-Path: <linux-kernel+bounces-783035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB5BB3289E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 14:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 877661BC4D6B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABAA272E43;
	Sat, 23 Aug 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/6hYafg"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6026B771
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755953029; cv=none; b=D8wELKxk9jNNyAQGgwUTYgN2tldsFayGR5SISbaFHD5Qo5HOOxCYBADRGENbeS2yE6smFD7zDi8n359MFknR6va24JK29lv8/RALR4gyfSJ4y6IcLPm3TT0CTH0FE62o4+BVGiQh1lBo2mv2T4e+AuYOqgAxfATVMp5FTz9ifuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755953029; c=relaxed/simple;
	bh=IanlrOwnnjBBrz4JaH6rwyvteh8W9IK5cImbmNuzYw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cghtzKwTiK+aEsVh+uxmTr4cUXlSpISwhlsYrQ3MCum84F3PXjT8hK49+yq+ERtBJtY1+Ef+f0oCmR1/gZQ5AN5R154UC3/7NYLfE/SjAzSEvfPtPkzKXTH25YFFX02ymme0nTCjjcxbp+1koWNyWXavruHX4MNtco2KmwuCFL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/6hYafg; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78da8a7so448943566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755953024; x=1756557824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlpWMFNb27oGthpW/T6mneIPKbt2sHdUQYK8r4ZWK0g=;
        b=U/6hYafgdZ+wGYW29H6LmIK/GraWugBuW/hdBcJydLAuwC4Nrm7wSnB1v4bIh+oX3t
         AokQngqKUl8EluhoJcEfEY048QlaneD3PuQhXvtJowr7FTCBa3dP9SHQth0VIu4JAAdo
         Omc4qnNX/4WVFexrZROxGNvrs72TcYi6Anjmq35PgsIIYpWPrCdcWkZIKT/gpcySdxOS
         YuT5T5ySM1yw2GjrKU1FMPhovam2UC/YTYQ8/kkekibJiSiXq6pHAaH6k/xwLRk3A/vX
         B6ZmjS3eXuTS2tgpLSDCanNkNhawO61HyA4pXPbn/sOQkK0zYMQy2Bxa9/OT1HGXyeg8
         JHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755953024; x=1756557824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlpWMFNb27oGthpW/T6mneIPKbt2sHdUQYK8r4ZWK0g=;
        b=Sr7iknPbYUusVFp4yThIhE0l6Ueg6sqqtWuAErpwu6vDxAcfqG2zidhIoyDdcekaX7
         K4n6l1vuyBxFvfScOx+FKYsmgbkGRQy2jurY4hivGQaOGFCMqhZFVFGfuFqU7edFssDB
         3OcFZZATOqfnvwgDwHOtVGq3LXOe5rNgF6sp6lmyNSq9S4tlz7dt7274fADHbRLHkCMF
         3h5sEKwXDHb8JqTGawPbxAtQU2kfZK65t/fU4cc/6bm0cC4Cc04UQtP/kO6xRtEoBX23
         cYqNrch2SB1L87eNasyfRsrwYQCFCG9CZKYwQq4SY1vNKxaOKDgNXFHJTury1LEir0zL
         i38Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLVwZCHqtr29z/yJCNRAiE7m0dZieTGgCYmr6kluh/sOfWBq0IB4Upr4cFiti67ywyqo+MOknO74P7eUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzascGNHhFZD695eaXPtD5n4govdo+IRRZpdhMHsWaCDDtSmeOG
	ugWNgREuIarDU+l7gnH6gQqlTPMNay2EuxaZ9Mdrtmadq6Z6mJ+WEZ3C
X-Gm-Gg: ASbGncvFasa25LByXd9BbopAdM4VMlb4DrpXVDdGe/JcJ8RcbvFN9+PtRK9GMUeWI7a
	UN8Z3X3mUzyYU2DBfmMPZr2+p/dlZjzsMyk0JSqR8v1hbCTOmXy8ZNArK+OB2koOEP1jHaATOzY
	KxCVF4qre4EpRnzINp4OO4JNKi2geq8hyj5BZesm6g6MywKrbyABSmtnmxZxEd84Q0BWpJXlHSx
	yWnJTVznXS8J+dZY+aFUDzsZCZy9V5X8AK0rGnUYmd2dk9R6l5IgJu59e5ozMshcc+/XQUh7HqU
	4K4z7yEUOS9T0YLXi0ZO0lIdv1ZUA3O1Z2y3S4ISU0ZN/SUELK9KQrOaf0L1mWDjqY8qMwMJFJb
	GCmKv/1G9FUghdUBH4ye1RZ6VGA==
X-Google-Smtp-Source: AGHT+IHaVisegjQ9un4mzCp0ZhRFxVs2znau0+RrxU5O9zNvz+u1VqtORNXI6y8NK2V/NUg74HclLQ==
X-Received: by 2002:a17:907:96a9:b0:ad8:9e80:6bc3 with SMTP id a640c23a62f3a-afe28ffcdf4mr585948666b.1.1755953024284;
        Sat, 23 Aug 2025 05:43:44 -0700 (PDT)
Received: from tumbleweed ([95.90.184.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe49a1f5a6sm165076466b.111.2025.08.23.05.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 05:43:43 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/14] staging: rtl8723bs: clean up variable initializations
Date: Sat, 23 Aug 2025 14:43:19 +0200
Message-ID: <20250823124321.485910-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250823124321.485910-1-straube.linux@gmail.com>
References: <20250823124321.485910-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After previous cleanup patches the variable initializations in
hal_EfuseSwitchToBank are messed up a little, but were left as-is to make
reviewing easier. For example bRet is initialized to false and immediately
set to true. This patch cleans up the variable initializations.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 014d94894de9..ab30d2598825 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -448,11 +448,9 @@ static u8 hal_EfuseSwitchToBank(
 	struct adapter *padapter, u8 bank
 )
 {
-	u8 bRet = false;
-	u32 value32 = 0;
+	u8 bRet = true;
+	u32 value32 = rtw_read32(padapter, EFUSE_TEST);
 
-	value32 = rtw_read32(padapter, EFUSE_TEST);
-	bRet = true;
 	switch (bank) {
 	case 0:
 		value32 = (value32 & ~EFUSE_SEL_MASK) | EFUSE_SEL(EFUSE_WIFI_SEL_0);
-- 
2.51.0


