Return-Path: <linux-kernel+bounces-829273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BB6B96AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E37E119C5070
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDBB264A92;
	Tue, 23 Sep 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QhCEAk9A"
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BD02641D8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642779; cv=none; b=FybF6mgA1l3HDGKAOKmPQtR3Sl/t0/AnGFu0qjhuPQRsKl/nORuTD/th+izNqkRohv7fMVWGVYr3RTomZvlcxuBCAV6diKYQ6PqGl/Uch+02aHe4LmpQ3iWaoozH8npZfq2AFivmdbwyY4UcW4unIKTI9TG2eTJUP54se3n96Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642779; c=relaxed/simple;
	bh=uAKJ5YIXpok4J2HO9I+jHEc/uFeWy79q0BkxKhz4i14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nsObY0/efFa0m/ej0qAAmKHtt6m1IVkc84Lm87i+jdntnOovEUuqeonclni1u0pMQH77gY1wI1/RLYrn64Md6t2joYVWpSAzD9DpKgp0lDqEvR2HHlqhqdHml3MP8tjfO72JGD7WZXn1US+EZnIp8r2AIr2wkURmmPh5u3ehJYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QhCEAk9A; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-425775d02f4so1905915ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758642775; x=1759247575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hr2andr6If2MhR9CesjDbJLb+O0VNW92c+JnTqVvT0g=;
        b=QhCEAk9Agc5GwnTTK1rpkLqjWDIke11C7rceIsE6V+n1ef2yO1zXPU/zmGa8bddV/t
         gK/N7JI8GFR0YMLGPmfg/HKv3wpkmMe7SviOBXYtK0YN7tkrGor04UNFtEXEEvDXRP0e
         2VP5CXfVaLayK19pJ2fhqEm/MyuESRMaqLsZfXSIj/AgykSq3pNjVUmIokJB1BeucJ3w
         vvLEsJYXWHOgnDT2kNMAmoNOjOby+86RCPOBSfxhVNAgjS6KO/2f33DXPnP+5VjAhiSJ
         lmFWEg8XIk6nwRGuE4lUpGTeMfYtV4/sXkAm92S2glGVzojoXWmPmfaqgTI2g9ngvrhZ
         Ez+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642775; x=1759247575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hr2andr6If2MhR9CesjDbJLb+O0VNW92c+JnTqVvT0g=;
        b=mcxPSw/Z0V3Ktg3jS0TmtyZVNUwKofdF8yoyLpPDFz7KG/ECk53p5k5ZWAHzonAC4h
         scyvT0pxa42aapYGKpkotRPKfm7oMRlAFCVvaDLhrceTg6m2Li0BUwrXLh2Ad2FAr6ex
         KFF/hqrDieADtkhKlbADjQZ9IVAK/a7kwN0E5ZNIuBXmXjjVaHvQCWIKZRjcgBjOL4dg
         C2jggHSxswVErTm/keLZawCcwIALiQjWH235w6TSPb2BF3bROvrvLLDAFCjDG0VaZzxj
         mQDkdpSWaP01yUrDvNKdkxGcOAx90RgwwRUp+z5Tx4CJV/6futRoo16DaypYZex0yEF7
         /qTA==
X-Forwarded-Encrypted: i=1; AJvYcCUbxeHdMiTmnOMCpZj3evVHSIRMUsNHAIHZ7uRmaawXT2x3c3O0NVyZnWDyr4WlmH+jL6uqgQi4E3T1RH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLfR+woXA/SkcrlhW1wpNnQzMKLkc0xCWUYKIY1TOwameEbA2
	l8LFq1Sv/oQRFk/frt9VBAP8eqqOIDYEewYAkU1ZgE4Nwz8QpsHKHunqd6KOr0TF6Rv72szl1Nk
	eSDAuSgmchuffC3p5ERgxl9knHY2DX/wZDRD2
X-Gm-Gg: ASbGncsQup31p5Ozk2JvM9z42dIYdEsygDFyYgdE8y1w/K2n5MUwFuG5qFJvXqGOaQI
	B6bB3fto/Ie53xVymXImQiKJS2GBFB8rpgOs71Yg+yObu4iniPXB6l6J2LaNWtKb9rWdXBjGmym
	m7Wmt7ciXBfPJgRh22MEpOSaeGcsnJ72twQ3VvSx0QKUI5hKP1ym2FZlQVKcCgHO12JF2CGvW0F
	MTQUQ+xyTDU5MLbRXV7QbI1bivIy1FifRUR5DqRuW2dOSaDv3lw0fEhs6Xvzzr7Yd/dwAMKm/TY
	OAp2V/BwOvD3vebQbJ2JtpPrcGd4qZEAjiEG9azAFRnu1p7NjbE5xUHaOM9XwGMRdA7rmJLp
X-Google-Smtp-Source: AGHT+IEWTzAV4+l++tX2sIXCcXNEeWjLQ9JCB3xpPjwbjd5Z+dIR2mwEOpQQxTO5cYBdtzV5UuM+Ty87VSEF
X-Received: by 2002:a05:6e02:12ef:b0:405:face:641b with SMTP id e9e14a558f8ab-42581eb0769mr19692455ab.6.1758642774589;
        Tue, 23 Sep 2025 08:52:54 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4244a369a9dsm10025335ab.8.2025.09.23.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:52:54 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3B9A53401CC;
	Tue, 23 Sep 2025 09:52:54 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 36094E41BAF; Tue, 23 Sep 2025 09:52:54 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove redundant zone op check in ublk_setup_iod()
Date: Tue, 23 Sep 2025 09:52:48 -0600
Message-ID: <20250923155249.2891305-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk_setup_iod() checks first whether the request is a zoned operation
issued to a device without zoned support and returns BLK_STS_IOERR if
so. However, such a request would already hit the default case in the
subsequent switch statement and fail the ublk_queue_is_zoned() check,
which also results in a return of BLK_STS_IOERR. So remove the redundant
early check for unsupported zone ops.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5ab7ff5f03f4..fcc8b3868137 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1103,17 +1103,12 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
 
 static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
 {
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_io *io = &ubq->ios[req->tag];
-	enum req_op op = req_op(req);
 	u32 ublk_op;
 
-	if (!ublk_queue_is_zoned(ubq) &&
-	    (op_is_zone_mgmt(op) || op == REQ_OP_ZONE_APPEND))
-		return BLK_STS_IOERR;
-
 	switch (req_op(req)) {
 	case REQ_OP_READ:
 		ublk_op = UBLK_IO_OP_READ;
 		break;
 	case REQ_OP_WRITE:
-- 
2.45.2


