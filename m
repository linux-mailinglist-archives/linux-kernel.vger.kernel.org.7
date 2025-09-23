Return-Path: <linux-kernel+bounces-829001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346ADB9604F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56913BBCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF3C327A00;
	Tue, 23 Sep 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8U8uuKg"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB710F1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758634371; cv=none; b=VlaOqecAwEjeVRIQWxFw6bOesDCL9MqgtbZF3t2C0tHoaMpDdb9KdGXVNNqTAgLEfM4vS//kZyDA328P77LIcsb0E0bw6vZYtYxrboJa59KhmChitKrMFsIJPQEpgtogxph3D3wMdwp8beaCidJngurcARYNLJESbaEYN3B0nW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758634371; c=relaxed/simple;
	bh=wBKw9LwQW+XEjdEFwXUsCZBkjOUUTDtWyA5fwq82xbk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eXbxAG+OPqLdtluaLja5EkvitX2c1XtxoELcqJH0WST5/fRK2mmKzweTAxcn4Jv6oz6NorIulvXDQKpy2+Vg9nHAwN8Pn0jI0TDz/roGQpBg0yAhRo7jWu9jP6RfV5ww5USdthRXBIN7glLmF765WD+3bSM02m4FkZemW+MjcDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8U8uuKg; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f32d99a97so2062102b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758634369; x=1759239169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YdNQB1ZGXvQWh3XKMx+CaBgdTFkZKFEai7KtP6jM1KU=;
        b=f8U8uuKgzwGUIKrTqyKHHXKSlpiLPb0YwmZHKIAGA6i7sA+xtzIp49p/wYiIsFgccJ
         I+YQ89rcWxNhFSZLVxS++mosw36gkXWHaLV0nuFyl5LEAVRDjwxLEZMlpGTz/T34C3ZS
         gpGA4gjMIlx6PbTk60WLuK+UMrzkLatzt+Wwc0oyAC7Yn/8+Nok5Z3YlcDs+uxsWpB2v
         QIHBBOYQVVKEKxn/nCRO18wZqs7EEcDOYoD0Q2hizcYK6JJPqu1iK2KUt/oTjKY6W++Z
         fEPfjbTKYmEUAU7OuEQr7nO6BAFWiRXPGwCktOq7O1jCi8ElBCaOOg8kX58K2zkD4OVa
         /8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758634369; x=1759239169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YdNQB1ZGXvQWh3XKMx+CaBgdTFkZKFEai7KtP6jM1KU=;
        b=XVJebiFPXcI7DPkuwCx5aehp/GqLWPvfyj2Ypu62oOdwKNQ0pXdcvYclejFBMtVGYR
         Fk1/DWGckN3jNIH8Zu2jk9pjmjbmXFt1/qlagusEwDFLyurEQZCeSYeIXbEdjXBIoz9Q
         aMXRC/Pa5GbmPz7xiH051wgq3o3xzTmX/yfokQvXT/PMDhmsYlT9mQVxVNlDVpYY9rva
         0Dm2E4efyWzvshBAatKSHwqHoIbQGnsZepuUI6Cd7TvucWXa/j/9+GG8ba0qpD6Yi8U0
         DJ5Sa3BOoHpSU7mQ0bFX9qWKxL1VR/BYonY6j44344GpqRZX/b1TKocu1oIFB1Q/Ild/
         Daeg==
X-Forwarded-Encrypted: i=1; AJvYcCVPYIhHpa6eTGy59BkItNXerkNwGVDogFf+jcXaLP4MqWMoKoq0C15c9cuu+qmSIe2I9KPrRwF6wHo8IIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVjN0okjL1HuMQZ5kuFVg5QxsXx7s1Y3Aag4cZA6AOG0k2VWgM
	2cOgiZe064Ka7t6/xJrrUy//e8jHjBHq+sQVfkjYDCgIR6QgxzhV5sF9
X-Gm-Gg: ASbGncvZzkUCJAzZIaigdHHM6anrU0M+lXUCwp0sgYn3eMPfzooGMgqPdN3ckomweIG
	NBlM6vZYYhV0JFa89H3uT95PAsF9X7ZXzzEw+cp+qofKzfkrnemsb6GPQBH5ZiChoDsUI+1M2iE
	evYcezcTsDUePXI4dTjP3A/nfBha8O6Hs8e0+E2fJiBUnWmIltdLawKiXkhV+SlD/bFbPvYd7rj
	2werxonPof7ZSTA2CJ1OQtAE0wC5KFl6VK8+TuwbXvHtqI1OtMT13IUHrFd+gxDyITZmBNY/oB+
	yVPBagy4dG5vm9pBlyGAfEPvb0vACv+8KrukZcm7znCdnrDp0bfzsTqnJCbxnlTDlK5LyA/6Edm
	93ZzFGpbKayM4lg==
X-Google-Smtp-Source: AGHT+IE6W4t4zmOFnWhJK8hWF/RIwTsnYRvhbOlZb0wiZzpWRN5aDrdCT9aya8IOqH6p/Q/J1JKHJA==
X-Received: by 2002:a05:6a00:2da8:b0:77f:2f8b:7667 with SMTP id d2e1a72fcca58-77f5362ea1fmr3223982b3a.0.1758634369100;
        Tue, 23 Sep 2025 06:32:49 -0700 (PDT)
Received: from lgs.. ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2d435616sm7364041b3a.5.2025.09.23.06.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 06:32:48 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	"Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()
Date: Tue, 23 Sep 2025 21:32:35 +0800
Message-ID: <20250923133235.1862108-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
changelog:
v3:
- Move Signed-off-by above the '---' separator.
- No code changes.
changelog:
v2:
- Return -ENOMEM directly on allocation failure.
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..cfccb9389760 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.43.0


