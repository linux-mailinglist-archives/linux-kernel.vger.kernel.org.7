Return-Path: <linux-kernel+bounces-732387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F4033B06600
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A681C20408
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994E2C324A;
	Tue, 15 Jul 2025 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZktlEWJ1"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F042BE62B
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752604119; cv=none; b=qXXeGX8vXurwDcpIQCsV+u2DLbXc+4Tb8IgIGoLIaEqMus6V7kpSFvXKTiHGtqN+LrXIwlbcdw5yU9kMGAR0oa8MwUS8TK5/zPIX2mEYnhHlB4aOKAaLBqjXDC5JWhHbepOHgSJZdWfXrtrHsMllp5+qc+d79ifodDDxmRBdKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752604119; c=relaxed/simple;
	bh=GolBMq6OFv1MR1lCKXX4qDABROYUnoVtl1R+maoxlSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mRSSi/ALo6YiP6J9CRJOozSxo0zHZuspbBmwi9mRhiQnkyiIbqHKEeieYfdQmfi5yLIb22jKHAU1ogdswK6jKOWZo6HfCiJM4bqrIZS7bP9uvwD0gXMdFlVWpb047FFtc71ULqfzYs2skI5jEYTHTHVeHYKOaQ0xXtCJU78wGhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZktlEWJ1; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60dffae17f3so8922424a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752604116; x=1753208916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNCDjASoME1LD5pZ8epvPobCM+XQAYfk2wfTrb5cxoU=;
        b=ZktlEWJ11/whkD6nzxebOMcs3Q/rARsNiAYaQllliV4u8pyfIRpMqIG7B8p0497XrU
         tT/3Sc0qFS1UpNSWvedX8+aNi+pwoUD0ZL87caiFlPO2aIvba0Tq0PLy3nZHx/+uOSBD
         inVsEY29joNuqhwh/y3qD3UKfEGTJa8APn0UpImBPTFL5M3ihoWt2EW84R1LOkVnJfRT
         GDLe3q7dK8wxEXslEWEJPX6izVLbyO9IAOuSGMzR703Ed/B1emyTD5USeuJxpDIlqnFG
         Xw8Th1g5ohLm6WSVFoXiO95MVJ5x7u2sAQyUCBxXTk41fTgg7vz5KxV9eYbzbplb2ZMn
         sYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752604116; x=1753208916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNCDjASoME1LD5pZ8epvPobCM+XQAYfk2wfTrb5cxoU=;
        b=BHfNgpMPAsYT/U+veFhpdC9AlWnv8hrxfATo5XzJhCaiPiwlDTSrh7jOBsaUPGNUpY
         vk0AVkc7O3qC6+pwjyR5dS0tW5CyndT485pPrdJqV68SEtexDGhDIHTWC2p0l6l2Jmts
         BvWHV0CEB3nu0PgFoheB0Ibc3a0O6qyD/ILfve3w/EmkZbg+Q70qiztmH9YejXn6FhBS
         7dfJCt8pCg48NV48duXBv+lKIKtwhxY68KreSp6XGCoHRYGtk/v61WmSk1wINfP4ZVle
         sbiXXMjs1z9Ee9yuzI4N0dA8D09EfMmfXq5tfVwqKi5V6aDtP+lPOAeW3pzVVwzf06bk
         7qSA==
X-Forwarded-Encrypted: i=1; AJvYcCUlD/ZjiQEWoJ+Od2HiHz2i+I+yAnH+mfOutu5+crUo7KMjzV5OvaCf44SkW7thM9rmE3/xLl08u/3XYLw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XNK/nk3/k69481zv0uJ1iaeCMVQlmnJfQZZiDTKpVPN1V1J8
	GgHQuNoSR6PNlqwgghG0AsVBbGmxgOWTQRKlMc2TPztdWyamoYJIPEyq
X-Gm-Gg: ASbGncs6CPrl7MxQaev/SEs35ify5bc3QfW26awJxV5ziUr/SoXdFIXxlKU8+JPuQjR
	9fJTkfeDU3NJS0MaDg2F/6IOrIUKLfwMfE82anAXqGW3bu6lLNwcYUAzHiKVqG3AsHgfa/WyiUQ
	aHS2p+M3Qcaa32bXLckEeGRR1URXkThyOPnKJVE5XrR/UknJfj0mxMfiD5rNXGp+cSqawzXa+Fy
	YkQdIZP1NsWnVzJE7D/1LJz8Mb/ca9+IKzkIhrM6+Gw37pvS4y3XClHdN5NdZB9ANQRVcOKcCQI
	u40Z+Q4zWu33xSkFbeXw/CgLbOnC8JAwjEzWowFfE8x6geRJKe0+OCHpqn94lNQzvaGs1q2AOGV
	nNRUlHFrFDxkfGXhPpqn3Seo=
X-Google-Smtp-Source: AGHT+IEG8G/3KDBgU7yI+WXfl1prf0M2J5Fz5nCF/bbi6kChEkhalhvHnS1TeS+8UZ/Gt7M4eiJMNA==
X-Received: by 2002:a17:906:d7d4:b0:ae0:c7b4:b797 with SMTP id a640c23a62f3a-ae9c9b598b3mr44074166b.45.1752604115776;
        Tue, 15 Jul 2025 11:28:35 -0700 (PDT)
Received: from tumbleweed ([95.90.185.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82df2fbsm1039562766b.158.2025.07.15.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:28:35 -0700 (PDT)
From: Michael Straube <straube.linux@gmail.com>
To: gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com,
	Larry.Finger@lwfinger.net,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/11] staging: rtl8723bs: remove function pointer c2h_id_filter
Date: Tue, 15 Jul 2025 20:28:13 +0200
Message-ID: <20250715182814.212708-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715182814.212708-1-straube.linux@gmail.com>
References: <20250715182814.212708-1-straube.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove function pointer c2h_id_filter from struct hal_ops and use
c2h_id_filter_ccx_8723b directly to reduce code complexity.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c          | 2 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 1 -
 drivers/staging/rtl8723bs/include/hal_intf.h      | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index dea38bb8424d..961b0563951d 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -303,7 +303,7 @@ s32 rtw_hal_c2h_handler(struct adapter *adapter, u8 *c2h_evt)
 
 c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
 {
-	return adapter->HalFunc.c2h_id_filter_ccx;
+	return c2h_id_filter_ccx_8723b;
 }
 
 s32 rtw_hal_macid_sleep(struct adapter *padapter, u32 macid)
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index c35b0235d3c1..1e9447633465 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -1315,7 +1315,6 @@ void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_level)
 
 void rtl8723b_set_hal_ops(struct hal_ops *pHalFunc)
 {
-	pHalFunc->c2h_id_filter_ccx = c2h_id_filter_ccx_8723b;
 }
 
 void rtl8723b_InitAntenna_Selection(struct adapter *padapter)
diff --git a/drivers/staging/rtl8723bs/include/hal_intf.h b/drivers/staging/rtl8723bs/include/hal_intf.h
index d6fd692aedc8..248f54f04c5e 100644
--- a/drivers/staging/rtl8723bs/include/hal_intf.h
+++ b/drivers/staging/rtl8723bs/include/hal_intf.h
@@ -161,7 +161,6 @@ enum hal_intf_ps_func {
 typedef s32 (*c2h_id_filter)(u8 *c2h_evt);
 
 struct hal_ops {
-	c2h_id_filter c2h_id_filter_ccx;
 };
 
 #define RF_CHANGE_BY_INIT	0
-- 
2.50.1


