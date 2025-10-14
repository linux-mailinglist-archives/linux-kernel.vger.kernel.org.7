Return-Path: <linux-kernel+bounces-852319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE46BD8AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB733A684C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F722EBDD0;
	Tue, 14 Oct 2025 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7UV4+nR"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9048F2E2F13
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436467; cv=none; b=JRHkZkOnw4ycI4BpjqQa/XBDH9hVXIC7/v55w2SYU3Trg2Tcv8Jlh9fsJX+WiTVi55tglXA6YMlRzdvvWD4yZ0VtMod+F8Z16teIo/Z9to+Aw6kXjTg3TpcrrVC9EhCl8oDfmLiAJfvreaXGno7rs2Hnjw112eKplQuvGj5Uc7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436467; c=relaxed/simple;
	bh=52B6KKCTmHzTmQ3h+uIgnxRU4z72GzjP6jDC3Lo/rJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nGdR7ek+g6N1HFETRpb84z++CkRzzQCTvTSaBmfL4Z4Tv9pLosodWQ6bWYwjQLw1EQGVwswgRzX1LtxQR8lWDy97BX1sbVstDq2+SOYA0A7lwueweRYUnRBJ5av9DxaTvOmZ1AoPpY+tKupL7gdLLwF52e13YocCz5mJMjeGOos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7UV4+nR; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-556f7e21432so4653052137.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760436464; x=1761041264; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ny2xuE6ziFtYutlPkIB8e4ze32Zq/HpfNT+lnoibpAQ=;
        b=C7UV4+nRbbrfBBLFuu5GimvgPr6FdPVCGf/fSsUY/6FgNFRRyq9OItHPBNFgsuuRHV
         yFCKuNvEVSnnewDLiDqtvPJsdSnTDLOOV+g+XYMieeG+UCUEvOuwUoZDLrbgoVafm6mz
         P/0QJ7Kvh8Fn4JsldoxNBzyw+zcJx6nr33Tf7kAfVxLprmH+eJNY9jT1fKC+6LVUIMfI
         RvsJX1aTTq4dTgs5e43eomlZfSE0WLVMOXQkRpy7wdAJqZRAAiOVEyxndyuw/4zXT4lA
         uNhkey5gcnjGggwoj37MIGas1QCH/aO7bP2v0401nqnbhffdQKj2R1CUHvMcPClulQNd
         aX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436464; x=1761041264;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ny2xuE6ziFtYutlPkIB8e4ze32Zq/HpfNT+lnoibpAQ=;
        b=UcaHd69JgAFjGQM/xH2PC0N1pAAdRjM4NxSrynDg4e3Zk/5qB4pqQl8Upvw/fNzLXK
         FMsKkE/MT/Y9FPmxt15UxnoOaFeObkzykvdQp6kAoTWSKgaPcE0Wsxi3j096+YuOq7BR
         T3+n1Y0ZZdSoudBlhU+EcGehddoPO/jv9uXZF2GNvcEntQjOQDprmHj0mGxDV69Pvyym
         DrfkA5hktB25Rvc6CqVDp+Ys0PIFHw9uHQn3wx3Lmlrmh02PPGRHg/MWnTNdMxoTJLx1
         lK+b99I3rRBbtRhzGcoQ430NKbropv2kgMIe3YO3rkkGpdGC5umz3wGX4wMa0DmnqIQJ
         4F2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTJulD0FliAtRBt3hvCf5w0PoysEl5LxNnoREJpsxoukd6i9vP5B0Gwii2La/ROi9DuApB6UT6OGn8GF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1oL9digIiuHWUF8nM7Fyb29rMv856edpi+IMLFwn4Yov/nIqT
	qmpfSgZ6bhD61uY3jTr21uLQTTavSCLF6YQZ/1ZhWT2nTHjuy8tUSmh7
X-Gm-Gg: ASbGncttvPCaypkzKzxjevgkwSIKHv/zYDCPlTawyyHayBwx2W7OApkn6pqbkJbh/+G
	SCPfK8vYVU3p/piezAdTs9fvtYFPB5XTOaRQpy7rnetWeLoR/HLcxL1VKmUyXXSRXz3xzahVzMH
	LrWz12jDDhYS1KByQnUAlsyWfvSsp1EbCMuh0klaC2wmTeW2yKSIGt3t4CVlLxTFkiWndxtVHks
	MjuJcgbEdukhNV0Lza17EG4uaJg/8zC4AP58FH3NXv1KVWSbg2WDcb5tHaihAMXKgZrsL/T+2MW
	YceaOvxvmXZFQXyggLfoQsjYTjtr2ougqedxLIOxvkDdfuXYDaSH3AhfdldeyQtj+jyZSZvgYxn
	1iK9P9e2ktbDzlgk+/7So4ph7rpc+0whGOl+qNwsgZkGktQLimIhsdg==
X-Google-Smtp-Source: AGHT+IFHmk9H+o0M18+P+FqU0IZbfnWXxDvDwxciPXKm/+nrLvsqNqmJl7xfYRQe2zBSrY8m/1+RsA==
X-Received: by 2002:a05:6102:1622:b0:529:fc9e:84ae with SMTP id ada2fe7eead31-5d5e2357b3bmr9241852137.24.1760436464398;
        Tue, 14 Oct 2025 03:07:44 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc8b5e06sm4223171137.11.2025.10.14.03.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:07:44 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Tue, 14 Oct 2025 05:07:27 -0500
Subject: [PATCH v3] platform/x86: alienware-wmi-wmax: Fix null pointer
 dereference in sleep handlers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-sleep-fix-v3-1-b5cb58da4638@gmail.com>
X-B4-Tracking: v=1; b=H4sIAN4g7mgC/3WMywrCMBBFf6XM2kgnJbVx5X+IizzGdqAvEglK6
 b+bFoRuXJ7LPWeBSIEpwrVYIFDiyNOYoToV4DoztiTYZwZZSoUlShF7olk8+S2UL5WuvdfSVJD
 /c6A87637I3PH8TWFz55OuK2/SnWoJBQotLQO0dbkDN3awXB/dtMAWyXJv6bMJhrfWG8vWjXqa
 K7r+gUUpzkC3AAAAA==
X-Change-ID: 20251012-sleep-fix-5d0596dd92a3
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gal Hammer <galhammer@gmail.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=52B6KKCTmHzTmQ3h+uIgnxRU4z72GzjP6jDC3Lo/rJ0=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBnvFJ5WCu949E1z0caTm/kcs7jvFdzYol4XeuPI13ijE
 /Xe7/hSOkpZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiR20ZGT7IimiGRjVPvHb7
 Rtml/v9rtB467lAX2J718b16/reHE3MZ/idmFNj3Vbiwf3tlsWG94cGcf0WHHQT2WN/m3/alWM9
 cjhkA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Devices without the AWCC interface don't initialize `awcc`. Add a check
before dereferencing it in sleep handlers.

Cc: stable@vger.kernel.org
Reported-by: Gal Hammer <galhammer@gmail.com>
Tested-by: Gal Hammer <galhammer@gmail.com>
Fixes: 07ac275981b1 ("platform/x86: alienware-wmi-wmax: Add support for manual fan control")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v3:
- Fix typo in title
- Go for a simpler approach because the last one prevented the old
  driver interface from loading
- Link to v2: https://lore.kernel.org/r/20251013-sleep-fix-v2-1-1ad8bdb79585@gmail.com

Changes in v2:
- Little logic mistake in the `force_gmode` path... (oops)
- Link to v1: https://lore.kernel.org/r/20251013-sleep-fix-v1-1-92bc11b6ecae@gmail.com
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 31f9643a6a3b..b106e8e407b3 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -1639,7 +1639,7 @@ static int wmax_wmi_probe(struct wmi_device *wdev, const void *context)
 
 static int wmax_wmi_suspend(struct device *dev)
 {
-	if (awcc->hwmon)
+	if (awcc && awcc->hwmon)
 		awcc_hwmon_suspend(dev);
 
 	return 0;
@@ -1647,7 +1647,7 @@ static int wmax_wmi_suspend(struct device *dev)
 
 static int wmax_wmi_resume(struct device *dev)
 {
-	if (awcc->hwmon)
+	if (awcc && awcc->hwmon)
 		awcc_hwmon_resume(dev);
 
 	return 0;

---
base-commit: 3ed17349f18774c24505b0c21dfbd3cc4f126518
change-id: 20251012-sleep-fix-5d0596dd92a3

-- 
 ~ Kurt


