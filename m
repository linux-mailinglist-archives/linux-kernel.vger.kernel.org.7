Return-Path: <linux-kernel+bounces-885681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55021C33AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 02:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3EF246549C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B382323EAAE;
	Wed,  5 Nov 2025 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GV9pbjvF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A81E23D7C3
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 01:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306258; cv=none; b=mzCVtZ6hjbiiNcNd/K0/uWX/r179tFlVLOTyPqXWfDswtmK4ZUe37Pievr3vvdbZTvb1j9bmKw06t+5kaYpLCDfnhQX49IlzQDWx98tkBJKYRi3p/4fNjaTj9l+Q/JPYYuowh/2K5x0pSFCLuziP6nGl7BMLr5l79MD/ItZIG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306258; c=relaxed/simple;
	bh=/52sgte9woUhDAcbwys1yM15CZcVFVv2vlQyUBAgYOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5Q7ZGRQApcUPSFAm4QwRe2V+hbrh0uio4NIkEUFwKNOA2KQNaH6nUQGfBlcigVPgec858GatE+34ijJ8GmSE3jEpqBEfNpTBKktqG6cjJTaBkVghXOfEzlB0tsUwLNDCXHtXrME8y4Igo/TjcRKr8+0lPq6boywMdlVR3musME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GV9pbjvF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-594285c6509so3076370e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 17:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762306255; x=1762911055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TxZAPUKdi9AxX63zPi/NWqNTntX+DYqp6OrCNhCWvus=;
        b=GV9pbjvFt+D4uwTaBIBQ1OcP/dwluq8h84WHEM7rFCbh/kwi+uG31fVQvT1ZhQOAT/
         AtMfOOgl7sa7oI8/s2YfZ1IFOMk4ATQ4/roMQNDWv6qAbwdBTVMpeeiHbt0d+80HdmmR
         pmkxn4eg/vhxs+075X6HEi+LFUzqfqIZ72PLmRYW+KwkSCoM5/BQFowcZ27DNX5Gm9rG
         BkSGvOERr2VzyGdWdQ4G8vUOZNnUzKyLp/Nn5Kq94LEplKFfidcJWZViNOvZG0yihaLa
         FyW4TfYxtQHb27alWGlOZ4i9EgRSAbdxFmZ3Z16CRSX0g1vzno3lQ143mMcdHTeRJMJh
         1uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762306255; x=1762911055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxZAPUKdi9AxX63zPi/NWqNTntX+DYqp6OrCNhCWvus=;
        b=JF27vcZAmevKSi2aW0DOXFHEYCBfoPBZao2SMSDdeg+pKijK4/hxUkVpWeVXkj43i+
         s0awA1aAMTLlW+ieshTSMZ0SVe8NMZQF3H+PNM1VoR9pW26UsPdQrjrA+3ZD7HpDWP6k
         O/95CcahD6XLFWvlNoMm7PEQ9zlwNlewOfOGRfi7+wnpiLgH0DGSJv8JkYGUDf9zs5Ki
         ZaGdan9EWupN9M909NRk20Rh95PtfBBcm8tbsXcaXdHzdkAFS6xlvLgL2TGMUX2m2Xir
         oeU8KDa8POS/Vm2hTyKUOHKD9SR7z9nJljKlJ+TJ6qqxNg7esKQh33G2awROj7e0TWaI
         DPDw==
X-Forwarded-Encrypted: i=1; AJvYcCWy1BgK/zbB9hXFMYwURUJZyQgJRSgkLYRwHQStbVLqbwjwjnm45m15Rp3wgkGrqXkuDVlGCxSW0ZEoYbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIogVacRI7BdmA7X3wlH74sk+6myLxMmfM7hqq6y+qYuFkaYsR
	MJ2m0P0XaQaPvT9NdAp7tPhUUq6ODT3p8TNZajjfuL3jNZbvkgZV1duOR0nHdJ4QMTA=
X-Gm-Gg: ASbGncvrMPXz1ryzI7MLmEy90OzsOT7/s0wmcpNEO3QMei6AeroknGRqac8f34PT1kB
	++z3OtBgAs9aWv2ns20164Z7+8BgdT5OWXcs6tKSFSOyA1QLDZrJ1umVB1XpXc7yWPpCCTPZKCi
	CkLj/gOL/cxYdS+lE1n6WixCoWzxV02czn0IPNMlvcr7GSXXVok6+uiImrJwbNulnlXFchyVEwR
	GmJdnFyzgrocL/ybTXk8RbebWgLqwWix6H9q59KyfXdzXH01ryt8OQNHZteuvY/VLvhiLj+zBTB
	vEGBG/eNHzxXgb40bMEiWEcu5ZGJbhyZWtPa+NSLc3WJn92WQujWLl9qrWnxCMZxsbPMhpeb5Af
	RN2jZIc8syV7tdzUozfeiE0F/BPDuqBrmODfDstlBbGU+cFRjnu6EPVsHDP2u4xFUtc+Rnj45rF
	FdX9iHJLRDZNY3//VVn1OVdrRUyJ7iLKqyy+Oed1HBuSg=
X-Google-Smtp-Source: AGHT+IGYR58g4TD80ka/4TE1av2oXs5XYjdiJSgJzeuI4WSwQMOU+Tz4cXqdNh66K0bcGOxe0TdBBQ==
X-Received: by 2002:a05:6512:3d08:b0:594:27ab:2f7a with SMTP id 2adb3069b0e04-5943d5176bemr317362e87.0.1762306254539;
        Tue, 04 Nov 2025 17:30:54 -0800 (PST)
Received: from Shofiq.home (62-241-229-58.bb.dnainternet.fi. [62.241.229.58])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59435743c50sm1017484e87.32.2025.11.04.17.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 17:30:54 -0800 (PST)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: nm@ti.com
Cc: ssantosh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] soc: ti: knav_qmss_queue: free resources in remove callback
Date: Wed,  5 Nov 2025 03:30:49 +0200
Message-ID: <20251105013049.45646-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the TODO in knav_queue_remove() by stopping PDSPs and
freeing queue regions and queue ranges before disabling runtime PM,
mirroring the allocations performed in the probe path.

This ensures resources are released on driver unbind and avoids
leaking queue/region state.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6e56e7609ccd..1e5f3e9faa99 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1884,9 +1884,14 @@ static int knav_queue_probe(struct platform_device *pdev)
 
 static void knav_queue_remove(struct platform_device *pdev)
 {
-	/* TODO: Free resources */
-	pm_runtime_put_sync(&pdev->dev);
-	pm_runtime_disable(&pdev->dev);
+    struct knav_device *kdev = platform_get_drvdata(pdev);
+
+    knav_queue_stop_pdsps(kdev);
+    knav_queue_free_regions(kdev);
+    knav_free_queue_ranges(kdev);
+
+    pm_runtime_put_sync(&pdev->dev);
+    pm_runtime_disable(&pdev->dev);
 }
 
 static struct platform_driver keystone_qmss_driver = {
-- 
2.51.1


