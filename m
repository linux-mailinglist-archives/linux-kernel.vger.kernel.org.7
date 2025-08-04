Return-Path: <linux-kernel+bounces-755411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3568BB1A5EF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BE7E18021C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C323F25F99B;
	Mon,  4 Aug 2025 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGkAiLMQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D31E267AF6;
	Mon,  4 Aug 2025 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321142; cv=none; b=o0tA+czKA5LK/usZcKK2odTFvBnVwoLJR+oTr7iu5OE6OqCm8UMhVvdMTEdOgxp+qxKvhdro6DZ/Qoe56xFxRgg+N9Krz8stgeZWbtLAJC9yYBf0ZKYZiL9GceOubXsMLZNdCjfwpKjU0t9jAD9qGIg+nH4gCKNsphp0TtHlQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321142; c=relaxed/simple;
	bh=Ww8XtzWWmd9NEN1mYrRs/EouHRfHz6SnzYUwUTEJH1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFosv1FK+J2QQToF9MjCHw0ADOr1b/XmqIr64FUIk+8fmZfo6PxkeK401EL2f0cUNq88RjUxj8w23z0lUpfJpbpcCqYQZmJO9KonEwo3nXURJj3ZhFt2bvTWTJcmuf3FEaJZS/WNmzUeXH8J0vqZes1H3jXzCNV0n2H5YQ98aP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGkAiLMQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458a84e2917so38416185e9.1;
        Mon, 04 Aug 2025 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754321139; x=1754925939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Agid0tpjdSujjAhdXbPA2x3WyjxVEkJpaF+LwGDnBDk=;
        b=nGkAiLMQ/9ohIhlQZwyMYU/mEn27RUcH6JLTsoYEAHJg35OQtSL3IMIKFrKAqn2uvA
         q4I8AFED1n3lr5s4qzdXmiXUlIoOuMSf1mDMCdCNqBF/CF8ZcIfqwlUXwiSj4p7qhj01
         P5Ab7hLec5ho8gqa7Y6J6YvaQLUnWu7GdiM7ogMHzTn5op/hWRXzkaCJ1TBV5yv68k9r
         wnn0k3UoYsGp8yNVs9ZjpNauEMEXKI8nh/Vg6OM7q7Bjuh3mbHbjQZIDQSowT3s+bbnH
         Ja0STOjEPryqvwTLwIjSYYnQvmhcjVUcTP33GAx172BnZmGutb7wmilraGoW4O/9/oCt
         UpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321139; x=1754925939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Agid0tpjdSujjAhdXbPA2x3WyjxVEkJpaF+LwGDnBDk=;
        b=NbnNbNcBaMwqomEfVetg9Dt4xL54qBCxll64riJBIc3jI5smpDm/kmsk91Epi0S9Iz
         QGBe/mpYycTPyn7MpwmGdEfRHibpqmLv/tVxl2WzsbDSo6gWXxzNVFN17qIYCSqWSj7p
         J11lTnBkppev+gH7DF5MW1e0ixjKg00AEVXLVXDsxAJzzv/cpQDHJjY4n8zNVTHDQ9NL
         xC7BdTFvuQuZdO171lRseXBrA0PcXyz5GJnvgrnFHc4KOgjrjNS3uXUUeQ0wWnZ5xgC8
         iyEO+Fbwe0ZEHsnp5vQP267RSp6axUXfLnzutrHJtdBiTthFDEYFaIoqkMgD1wADDFnL
         iePg==
X-Forwarded-Encrypted: i=1; AJvYcCW/w70BZyqJBEufAEaZ0Z9XotUFnyhZBoqAkwu50S/phOn3HQ1oEVqH/HMsyg7BIERxs6g2WRs5iPwrtlD8@vger.kernel.org, AJvYcCWdSK5gC7IlP34pwDaN/Vlk1hkxAUW6YjNm+88+Wu08p5nWRonRbaltlAc/CuSAhLg5KjtU7neyYpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRWaXZqt+eAopkp5oeYga2D6n1ujsuUWq8f6dkfJrSuPYkLkPR
	F8ifUnVax/DkGepPqpQeLEfQPUJy1YeUaApVFRJWmAZtRtn6SUh3Yb5x
X-Gm-Gg: ASbGncvi9Ue9pnUi6cr86nFC2gFDI4h29DyqqZ6qn0BCBHCOuLQjpe9AJH+a30ur13E
	aNgSjgN+Mg/rt3trqHitFnfoHRl++KcO5+EvCbMgdG2VX/I5zpVzWAJhkiy2LadIx1Ia6IgZTFQ
	oXCvXCZcQFA8fKjv43pvjoMycMlbYKQifueH3g3PFJwHmbgHpGvKBtIIiIj4e4Td2Ybubl1a1U3
	qPNqZxy5dnnMCrCXm7njcbNRwnw426qJJ35zEGMdNY5PAyu7mQgUAQ66p6b46F2hUzwAoncpw63
	4Cy5iYcTkXy59x3EZI9kWRanNidm0cfBoIMWhkjOeCZuc5Kk0xtR8CehLczbpzMtzOtI09j9EZ0
	Nwexa2nCNMcOa6WiKO9eed02C
X-Google-Smtp-Source: AGHT+IEwVz6tKP7xYCRGxAy+Gr6ILrfFw+f0M33n7qvsp6KtNbFsQ2e/9w9NH4WtddpaydCsNgzP4A==
X-Received: by 2002:a05:600c:35cc:b0:459:dfde:3324 with SMTP id 5b1f17b1804b1-459dfde3545mr10599275e9.29.1754321138486;
        Mon, 04 Aug 2025 08:25:38 -0700 (PDT)
Received: from fedora ([2001:16a2:6713:7d00:e3c:d6fc:37a:c91f])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458ba0a133bsm95763655e9.0.2025.08.04.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:25:38 -0700 (PDT)
From: Osama Albahrani <osalbahr@gmail.com>
To: Justin Sanders <justin@coraid.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Osama Albahrani <osalbahr@gmail.com>
Subject: [PATCH] docs: aoe: Remove trailing whitespace
Date: Mon,  4 Aug 2025 18:25:14 +0300
Message-ID: <20250804152516.16493-1-osalbahr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix `ERROR: trailing whitespace` errors from scripts/checkpatch.pl

Signed-off-by: Osama Albahrani <osalbahr@gmail.com>
---
 Documentation/admin-guide/aoe/udev.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/aoe/udev.txt b/Documentation/admin-guide/aoe/udev.txt
index 5fb756466bc7..d55ecb411c21 100644
--- a/Documentation/admin-guide/aoe/udev.txt
+++ b/Documentation/admin-guide/aoe/udev.txt
@@ -2,7 +2,7 @@
 # They may be installed along the following lines.  Check the section
 # 8 udev manpage to see whether your udev supports SUBSYSTEM, and
 # whether it uses one or two equal signs for SUBSYSTEM and KERNEL.
-# 
+#
 #   ecashin@makki ~$ su
 #   Password:
 #   bash# find /etc -type f -name udev.conf
@@ -13,7 +13,7 @@
 #   10-wacom.rules  50-udev.rules
 #   bash# cp /path/to/linux/Documentation/admin-guide/aoe/udev.txt \
 #           /etc/udev/rules.d/60-aoe.rules
-#  
+#
 
 # aoe char devices
 SUBSYSTEM=="aoe", KERNEL=="discover",	NAME="etherd/%k", GROUP="disk", MODE="0220"
@@ -22,5 +22,5 @@ SUBSYSTEM=="aoe", KERNEL=="interfaces",	NAME="etherd/%k", GROUP="disk", MODE="02
 SUBSYSTEM=="aoe", KERNEL=="revalidate",	NAME="etherd/%k", GROUP="disk", MODE="0220"
 SUBSYSTEM=="aoe", KERNEL=="flush",	NAME="etherd/%k", GROUP="disk", MODE="0220"
 
-# aoe block devices     
+# aoe block devices
 KERNEL=="etherd*",       GROUP="disk"
-- 
2.50.1


