Return-Path: <linux-kernel+bounces-870079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A0FC09DD7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 19:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7AF74E73B5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 17:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB238286891;
	Sat, 25 Oct 2025 17:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIn9t9GL"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CF427F00A
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 17:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412605; cv=none; b=H+bjXkWaIh9c9sHWNO7TMPXcof/VwGXkusVxCfkquONuST+uumPHixWK7fubBlNgGhLbyHdCBCa4L+gp2Zxj21RaheBRFg6eONAzBgBpyh399nujBmj6Mbv0RZOZ6mqCRZvOcJwvjpHCDMD/IA8tHbmPltEDjV4j83lcSfLiWzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412605; c=relaxed/simple;
	bh=r2Om375Gpz/OuMljTFd7kK48QcMYVt8EzT4iLKOqUk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liXBlFgmsqUavsNjH8vW6KBqVjoVU4bV+U5WJUKaXRvgNx4tV9JDoWcxfMVT1k1gDcB/cp7NMGNVBNnSpjKLxO5pgPLohs9TfHG9+X7W/KDFffshMDC5oqC7AOFvUJUtIpgADwJSiCMSx0e92FOJce652Fa3UCNCENIXdH0tsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIn9t9GL; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so16994825e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761412602; x=1762017402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEm6jQjbUP/ZLb0mwjDF1ek1ZnHXSkpVbfXo/n55Y+U=;
        b=FIn9t9GLSwbWRAgo3G6aW7dwAGUIxar+bq+bKEWx9HgCZLw5/gcbJQI0YNhRrOB83V
         FU9gTOuopp3b9y/HMrxacMEGc/+SKszw+D6Nz67haFCUrBNqhMXCeO9ZjitQnky8+fJ9
         lp0ND74MHC1u5VGimGRzjpt84uwaE+IFN9466Wh4ph9u5rkGz4nnZYlVHrWu5AJtutNh
         yxt+GZntWGsJ4PWLPfyGJ6CXXq1tsRgP3Cz7YyOaZtkd0TtAhaY70TSO9xtDVZ2c4AY8
         h5Jz6B6b6oRHp3E/VbC8k3dDCafvIk0kpdAWObjpP9vccPcbASFGSbG0J2FIUv4vWgg1
         Qlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761412602; x=1762017402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEm6jQjbUP/ZLb0mwjDF1ek1ZnHXSkpVbfXo/n55Y+U=;
        b=DJhcw2ChpnCXde/NxJ1M20UeYyQrjoE83MTb6Zs9iJ6CJNerd2FcA6ywOQhCovquIE
         5rYD2iLojFKWSmyqCD6YvTvzvHvYzQrXyFXxByX1Z3u8A4zV8PLZpMvrHULAXXBSOcv5
         P7o8L0sQagwlfqbYEcOhYFbmq4A0kWdW5xqp/9E6FL7JMvnedh1l1v1ci54piSnyBI2X
         Yw7lTY/jaKQ3niznFZnImLgctDX0psb2xLdfmbxWem2h8AdkFyBrsjDuhjmlfPPnIMA+
         ymahVjQW0tKjhZU8PmRSra0xElHhvUaaBqjc7Wl96BuZ4dD4NugjQp7wapPWQJildnhM
         oOdg==
X-Forwarded-Encrypted: i=1; AJvYcCUvqX8CMwrBDa7d5konXI3HwDL4Jz6hWGvsnvPWviZNXFUUhwEdIsKxNOGVSRF23MIIlCZyb/lsRot+9qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzoo2c7iJkkC+4SmYiaApeJvCyxOaIvt2GEmoCakGlqb1K2BN7
	lGgs6nmKJeAgr80p+cEYXPsVHu1T5k26QxQFMPBgg1ClDR1Te2iz19UU
X-Gm-Gg: ASbGncuepY/P+6DjmA1QMLTvzoumE+qMJMomW0a6hrwRepMQ8DO+XOmYN2tf8aj5T7S
	nZmGOA4BIhwhhNczmQ66p/TB6Iw+rmgZ4HtSB8P/JDHOeGexwA9JIuL8n2Sq/wIjjkW5Xxs/Zs9
	ZrbfAtamDssrAYr+JpdWIEwKU4dTMY11Jge0daCWLxfThclZny1zlGUnJHs/TR5PV/woUQLz3KV
	Jq+iOfla5gtOi7XDLAcOdf9xa1HzzhjqHIgVKJhmkvDgnU0dA05TMNy+nPqA9N8tFVOLZk4HQgP
	jwYBOVdCdC9Rzr9mgc6kFZlK/TkZl2E/IYneBm2igxT/9TYSqhFn59VJaClTdxnxn9tiHjzQzF8
	Vps06xr+waTLdiKRqjBXohTkC0Yq3V5IOH9MeonpdNVJyP0obCYfENyIIKceuW5xGNWclT03pe+
	8amc/awOanRx+iLg4W2f4XOIWwJsx7BHEFE/AM4n1/Ou87liDqChYRQ8qWgO3peagmoJdFzgGiz
	7NKxA==
X-Google-Smtp-Source: AGHT+IETiH6reF9yPWlfM21dO17Uv5A8dtC1Are9hXbWiATaPdqLT8Ej4bIbVxMZ/9xCDbB1zZYEcQ==
X-Received: by 2002:a05:600c:3e16:b0:45b:9afe:ad48 with SMTP id 5b1f17b1804b1-475d2e8c68fmr45738125e9.16.1761412601518;
        Sat, 25 Oct 2025 10:16:41 -0700 (PDT)
Received: from nadav-lenovo.tail4fd44.ts.net (85.64.200.239.dynamic.barak-online.net. [85.64.200.239])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd477c92sm42510045e9.2.2025.10.25.10.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:16:41 -0700 (PDT)
From: Nadav Tasher <tashernadav@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: corbet@lwn.net,
	Nadav Tasher <tashernadav@gmail.com>
Subject: [PATCH] docs: replace broken links in ramfs-rootfs-initramfs docs
Date: Sat, 25 Oct 2025 20:16:25 +0300
Message-ID: <20251025171625.33197-1-tashernadav@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

http://www.uwsg.iu.edu/ doesn't seem to exist anymore.
I managed to find backups on archive.org, which helped me find
the right links on https://lore.kernel.org/.

http://freecode.com/projects/afio was also down, so I figured
it could be replaced with https://linux.die.net/man/1/afio.

Replace broken links to mailing list and aifo tool.

Signed-off-by: Nadav Tasher <tashernadav@gmail.com>
---
 Documentation/filesystems/ramfs-rootfs-initramfs.rst | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index fa4f81099cb4..a9d271e171c3 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -290,11 +290,11 @@ Why cpio rather than tar?
 
 This decision was made back in December, 2001.  The discussion started here:
 
-  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1538.html
+- https://lore.kernel.org/lkml/a03cke$640$1@cesium.transmeta.com/
 
 And spawned a second thread (specifically on tar vs cpio), starting here:
 
-  http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1587.html
+- https://lore.kernel.org/lkml/3C25A06D.7030408@zytor.com/
 
 The quick and dirty summary version (which is no substitute for reading
 the above threads) is:
@@ -310,7 +310,7 @@ the above threads) is:
    either way about the archive format, and there are alternative tools,
    such as:
 
-     http://freecode.com/projects/afio
+      https://linux.die.net/man/1/afio
 
 2) The cpio archive format chosen by the kernel is simpler and cleaner (and
    thus easier to create and parse) than any of the (literally dozens of)
@@ -331,12 +331,12 @@ the above threads) is:
 5) Al Viro made the decision (quote: "tar is ugly as hell and not going to be
    supported on the kernel side"):
 
-      http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1540.html
+    - https://lore.kernel.org/lkml/Pine.GSO.4.21.0112222109050.21702-100000@weyl.math.psu.edu/
 
    explained his reasoning:
 
-     - http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1550.html
-     - http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1638.html
+    - https://lore.kernel.org/lkml/Pine.GSO.4.21.0112222240530.21702-100000@weyl.math.psu.edu/
+    - https://lore.kernel.org/lkml/Pine.GSO.4.21.0112230849550.23300-100000@weyl.math.psu.edu/
 
    and, most importantly, designed and implemented the initramfs code.
 
-- 
2.43.0


