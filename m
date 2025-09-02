Return-Path: <linux-kernel+bounces-797379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6A4B40F9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 23:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BC8162EE1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6284335AAC9;
	Tue,  2 Sep 2025 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="W8xA81rq"
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F132B1E51D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756849873; cv=none; b=VbYZ2zQkDYr8YsxtAl5KBPBYlmMOPuodD01Mx/GjgxBNEum9Qy2mLUBOzMOndIvG9eRqN/3K2shrQOfMTpWqi6iPaft96QY9fYBwf1GLURs8g8wp4domG6wxH4Gza6dvFsfMAqF5DXaLpXi7Vh3PRElbCweuLBdTZATn/XLwNLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756849873; c=relaxed/simple;
	bh=PhgyBskIEFQnUD0P3UgbIXJw3q35eVbCgAjfy2fV/MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOmCfgz0pMnoWqeuz4M2cL/0G0CvFszkl+2uGjdKNoWeEXIKsh82/zwu0JWOfioqSSxIcj71yTW9lsA6AFrVCLzTAQY+EG28y+odnkMy5apB9TNetFJ6l+/WFepNns8d+Dq7xcKNYP2EIQWiKd7a5DXXVhAeZBB/bwt6hE03awY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=W8xA81rq; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3f65df713fbso656085ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1756849870; x=1757454670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BwJP/IZ7edcBdODnSS+hYoNQBKWq1HVWg/WApUUDlnU=;
        b=W8xA81rqhHuqcdr82ohvZKkoxv5DpLIUyrIEu7XE17G5CcZMrO7m/dN0+zDR9XPeCS
         l0vOGQkD6bn8GD8hGIs2VrvCj8iM67zvCpsZ4a9WJBH2CKjHhBjxPghPsgIxt/fH3387
         RlJJ171iRGzJJL+NWMXCWGsG1IjkjCDaLzuVM+xiGJC1hMLmRLLPQZOZGr2axv4X7EPQ
         her/lUa8QWxxj6NrrvOveyU5GXdStfJbQQM6AUwHZj3SMp5sUnSvLmeOq0n8In/nkk3s
         j/ovH1dgJP3FzbL18mqq5HxSLulrF6ut4gvwHtOfv8eFw2IbagfJrz0+aDvz3dv4einX
         U7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756849870; x=1757454670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BwJP/IZ7edcBdODnSS+hYoNQBKWq1HVWg/WApUUDlnU=;
        b=nOq3E2FR4A5zjn7uVDzCmfv0cNBQB/jZU3vdVE+u7cCWzn/6QzLckO8d6TWyMfIOHI
         3tKCs8I2bXWINjQhVwXHt7njtdq49QAfA25N58oYs91+W/0H6mFwQ0fuaibhwV7seOkD
         /z8iudhiUh4uU8Y98Jxp0A81EUD+Pv27tSLpmQDzqgojXwsqWJtEIT1VL6yPECwUU9D1
         Y/mfNVWXSwZ+xGn+NXvd/41V1atJ2G7BdaaSz1Qc50cHsl9r64bhzHvV7IuCODn62er3
         POQWoU4IvRLP9UBbWjOV1Ia1h7J5KUtElGuLIS2KcRwV4L092p/hzAZHLUpyWeGHxa+4
         1O+w==
X-Forwarded-Encrypted: i=1; AJvYcCUcsrJCh8hzXW3XyRyf+hZEbkTcHtE3NMkMWxQBrGxIp3fk3D8CNWQg/xyuqlk197grosPV0PFzX3eIOaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4obmPKonO7xfKVaaDVbtQds5/sBONjMcwZw7N6r1gYCxsoIUC
	WYwlTKctycb4SKYDGuPzELBcHnYoQXSxGK2UoLrVy5t+X9sGO6nj/a/KhjbH102rsWdeMbKMYSo
	7/HyYQuqZd5AUUak64sxIB7S8P2UHEI3LriZ4BWr26RvIoQl7Bmvw
X-Gm-Gg: ASbGncsdal/A9hc86L/QQgRL/mW8xmQht9ntQXOhIDsVJSYgmOV6mQSf+DPIqFdHcPx
	R6sLApLKOluH9pqiU9HvcNyZw1mr4Fhn/nroAXziAHtzvD5Tp2WGiy4WUTIcwZhQnXVHrAtk6iL
	1QMZZT7H2yAaRYGt/yltcU8Qz2pJw7bJpZJ3ssdGijRIRkzfDp28VXYplSiIzIYKHVbT+LkPTof
	qt96VDWRIwjPy6GRTtCu02RZ1HEOCQtW2wdoWfSrTC7nBohAbyJ4lZV8EWp8Md9yUHRX6AtUV8J
	uDVqxS1CI7Veb+nc0IXLV3KLEzCaXqjD/2aXmgSkGAWIyHDIl/u40OnfLg==
X-Google-Smtp-Source: AGHT+IGXGrDVgLYEPY3DWvVTQ6mI3JQb1xGTMbKSTJm7SLS6h82Apglk08N9OZ2x3i9SZUj1csjceovMtfQz
X-Received: by 2002:a05:6e02:1d8c:b0:3f1:a5b9:4a3a with SMTP id e9e14a558f8ab-3f3221b05c1mr95335085ab.1.1756849869879;
        Tue, 02 Sep 2025 14:51:09 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f3deddbabdsm8385005ab.23.2025.09.02.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:51:09 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5802D340328;
	Tue,  2 Sep 2025 15:51:09 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4FBB1E4159F; Tue,  2 Sep 2025 15:51:09 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/register: drop redundant submitter_task check
Date: Tue,  2 Sep 2025 15:51:07 -0600
Message-ID: <20250902215108.1925105-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For IORING_SETUP_SINGLE_ISSUER io_ring_ctx's, io_register_resize_rings()
checks that the current task is the ctx's submitter_task. However, its
caller __io_uring_register() already checks this. Drop the redundant
check in io_register_resize_rings().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/register.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/io_uring/register.c b/io_uring/register.c
index a1a9b2884eae..aa5f56ad8358 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -406,14 +406,10 @@ static int io_register_resize_rings(struct io_ring_ctx *ctx, void __user *arg)
 	size_t size, sq_array_offset;
 	unsigned i, tail, old_head;
 	struct io_uring_params p;
 	int ret;
 
-	/* for single issuer, must be owner resizing */
-	if (ctx->flags & IORING_SETUP_SINGLE_ISSUER &&
-	    current != ctx->submitter_task)
-		return -EEXIST;
 	/* limited to DEFER_TASKRUN for now */
 	if (!(ctx->flags & IORING_SETUP_DEFER_TASKRUN))
 		return -EINVAL;
 	if (copy_from_user(&p, arg, sizeof(p)))
 		return -EFAULT;
-- 
2.45.2


