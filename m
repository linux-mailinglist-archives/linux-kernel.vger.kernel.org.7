Return-Path: <linux-kernel+bounces-821890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C138B828F1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047964649AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C918242D93;
	Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Y8Y6VxCr"
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF9E23A562
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 01:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160239; cv=none; b=SQrSL8LqNQcveGwmUFkun++N5oCDhyHJB/BXYCaTFOnlnSakyJs89dKpkdXrWQqZ7TZK6JGVNkU5PHvubCODnfPGV8wlHYkxpcqhR/xRISS1croWYdNBnKdq9svMw/s29DY4XTn0PB2v2k178VR31W1LXLONp92CwMXjSrPjlzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160239; c=relaxed/simple;
	bh=YgaAljjCEjYu2z1bmyuyvJK4rSyuSbdErm8XvDe+Qck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMHMKFslrjXKKUaRIwbnHkL/3SPBPGXxKm9kxZI4eDQedol8cRFWNOA7x2IWJL1Gngj+C1ZHGSTNw3sXy6e/WmKeTnB2O73qMQO0qU0HC5ZdlfQi/qlQGU0yQ47LWkApyhi6O4lvY/lWqSafB/rDYEYx/CbUVFcheshDWWKenWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Y8Y6VxCr; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-78def53f3abso139296d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 18:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160236; x=1758765036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=484GJ0fhKoa3hEGK1iZwSCdH9LWZt7uifdWOXLD/L/4=;
        b=Y8Y6VxCr8mvbcLcbsAoRPh7vncBZZS2sH842XJIAYqkf6pvt4O4U5dap0S46rKy9Bz
         HtKne1/WsxPx685UkqRfl5Cz+GZP9HoxuT5xXwJ/RidIicrLrlOgefnjlMyf6pGsJPAN
         x3IJJWxAitBCwv+Jie5s/04cMM/8jqpn8j5fz9zRKn8GTJFRvI7+dvDAnXDuZmdBQAwk
         s51wuIcwBdfviI7gW6DT6EAXo3QLy8RlqopxvIVJdZToCtQyskkp87v9/y6+oic6F9Sa
         pHDbNjhyzvrQS6XYL5d7/fY1mvjEdOTBc+5EriU5TIMREyrtB0fFojQyabYbhorle2Ib
         mDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160236; x=1758765036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=484GJ0fhKoa3hEGK1iZwSCdH9LWZt7uifdWOXLD/L/4=;
        b=G+Nay0Um1j4U82bk8sY0Cs2Uu2u12B21Xi0EFh1IHckPJ92VCsZj2TVu13sirNiZUe
         rdJouVjk29iwNTLfkOpIjM9fNWHAEJNA4jItLSqUxW16Rwpn1Y04LKt88zjHCoKqAXY1
         t8ef+vaJSemuC96Kn2dgPLX+bZL/oDomwB0wxVGCjI3zkjijSgwAc2R2a3Z/1U3Qy/5+
         9tvRfcImpeZcRe6LBgg2LXYiq5qWwHx6Lvw8hpmqBVaV1lggoC20CiC0FK/hj47s10+D
         QuIfM3vA38hdl1wwkfpZ5CvZSjS1G11g5EMFLb+mvvO5UOrtGZZHTUuFaCU9oaXNFRCg
         aD8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVopTV71fXuTc5/Lh1Nl3t1gfkF8mO7KbWnnZamvbFRl57uavpyNqTRN++EgxYBihskkUAT0Il4yFyOw+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ZqQy5XjjPaZTSJuvlX3jhcXhJpwMX/UcIqvWcD9PuXqWymHw
	SjWX8GsSAgYNayQLyy203pcMmJi9ieMy4uwbBAqhSuQfI1OQHibI3MpVfuL9QPEB4RXRrHu+JwG
	r2PtyihSdyNTDMAScEMwav5W8eXYUyATOdwgz
X-Gm-Gg: ASbGnctHwJQcGBBc+h2mbUrVWt3z/09PR509RaIf2FxSaKtjf2RAwcCRrbtGNOiARcs
	td3OBLH/WxO6qeUAzo9Htxgm3GKINHm2pP0vUkE8XOExk1g5mU5u0qYDnj+QRKlnQPtK3xSLcv0
	J1F+NpufR+mXL6lT8H0vBQKdHVRUdfcigP1PVhrmwknHqtNOvibwhYYZS2jqHDwS4pDLJayFDTg
	BW0AiwKMDVCd3q8MY3eXy0Pgux4XIBEIt94+VweHJfBgYUSDx9k67gc1ITwh4Yysa3V0uBFGChN
	lGjCEv7xJIQVMxSUKyBffX3v3pWdKHu+wyvqM6KplVWEqCqnh+nLHbcunX6Z0NVB5vUgaFdD
X-Google-Smtp-Source: AGHT+IErBYL3/Nsn80r0sQPK5XbZBh4OUvJ12WMsWq2TG6b3AgM8Dh0ua+qlHiSFawMaO170kBRkcOes47tI
X-Received: by 2002:a05:6214:529e:b0:78f:e44f:bb6f with SMTP id 6a1803df08f44-78fe44fbf21mr22825096d6.0.1758160236216;
        Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-7935206af0esm697716d6.42.2025.09.17.18.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 93B47340325;
	Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 8E5E7E41B42; Wed, 17 Sep 2025 19:50:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 04/17] ublk: add helpers to check ublk_device flags
Date: Wed, 17 Sep 2025 19:49:40 -0600
Message-ID: <20250918014953.297897-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce ublk_device analogues of the ublk_queue flag helpers:
- ublk_support_zero_copy() -> ublk_dev_support_user_copy()
- ublk_support_auto_buf_reg() -> ublk_dev_support_auto_buf_reg()
- ublk_support_user_copy() -> ublk_dev_support_user_copy()
- ublk_need_map_io() -> ublk_dev_need_map_io()
- ublk_need_req_ref() -> ublk_dev_need_req_ref()
- ublk_need_get_data() -> ublk_dev_need_get_data()

These will be used in subsequent changes to avoid accessing the
ublk_queue just for the flags, and instead use the ublk_device.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4cb023d26593..04b8613ce623 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -660,26 +660,48 @@ static void ublk_apply_params(struct ublk_device *ub)
 static inline bool ublk_support_zero_copy(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_SUPPORT_ZERO_COPY;
 }
 
+static inline bool ublk_dev_support_zero_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_SUPPORT_ZERO_COPY;
+}
+
 static inline bool ublk_support_auto_buf_reg(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_AUTO_BUF_REG;
 }
 
+static inline bool ublk_dev_support_auto_buf_reg(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_AUTO_BUF_REG;
+}
+
 static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_USER_COPY;
+}
+
 static inline bool ublk_need_map_io(const struct ublk_queue *ubq)
 {
 	return !ublk_support_user_copy(ubq) && !ublk_support_zero_copy(ubq) &&
 		!ublk_support_auto_buf_reg(ubq);
 }
 
+static inline bool ublk_dev_need_map_io(const struct ublk_device *ub)
+{
+	return !ublk_dev_support_user_copy(ub) &&
+	       !ublk_dev_support_zero_copy(ub) &&
+	       !ublk_dev_support_auto_buf_reg(ub);
+}
+
 static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 {
 	/*
 	 * read()/write() is involved in user copy, so request reference
 	 * has to be grabbed
@@ -693,10 +715,17 @@ static inline bool ublk_need_req_ref(const struct ublk_queue *ubq)
 	 */
 	return ublk_support_user_copy(ubq) || ublk_support_zero_copy(ubq) ||
 		ublk_support_auto_buf_reg(ubq);
 }
 
+static inline bool ublk_dev_need_req_ref(const struct ublk_device *ub)
+{
+	return ublk_dev_support_user_copy(ub) ||
+	       ublk_dev_support_zero_copy(ub) ||
+	       ublk_dev_support_auto_buf_reg(ub);
+}
+
 static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 		struct ublk_io *io)
 {
 	if (ublk_need_req_ref(ubq))
 		refcount_set(&io->ref, UBLK_REFCOUNT_INIT);
@@ -724,10 +753,15 @@ static inline bool ublk_sub_req_ref(struct ublk_io *io)
 static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
 {
 	return ubq->flags & UBLK_F_NEED_GET_DATA;
 }
 
+static inline bool ublk_dev_need_get_data(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_NEED_GET_DATA;
+}
+
 /* Called in slow path only, keep it noinline for trace purpose */
 static noinline struct ublk_device *ublk_get_device(struct ublk_device *ub)
 {
 	if (kobject_get_unless_zero(&ub->cdev_dev.kobj))
 		return ub;
-- 
2.45.2


