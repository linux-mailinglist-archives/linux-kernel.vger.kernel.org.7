Return-Path: <linux-kernel+bounces-732777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C6B06C04
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9930850015C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8857276050;
	Wed, 16 Jul 2025 03:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLeXEjLv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFBF211A35
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635337; cv=none; b=n9HqNLfMjUoMyrQmFM96/TOxDiH9jjRN7o5oMDpnLds8G0EYpRll080AVooOmBwhvV3WCWCM+YHsgqkyO12jQWnYxy5awimKy+Xaxt/uRu9BlaaYPFR1n5vhk306arSfUsaKodmc0/QRv91VwWttGPB/bnnB9jN60R+c3yIdmbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635337; c=relaxed/simple;
	bh=I9Nl4TGiDRruYlDY3yO9m94E5FnhJMFMO2CZe/mEayw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fsaVrLrIQ12/7U3KcBx2a1aj2P/fdtUld0qL/mCGb8HAP2ODi/zvaFVF6ujoO3zJb4iaZ+cGZHepbG/ymlsvS7K7A2yWjEuh+PFBxmJxxVbYsSsMtvMefxwSo/4Ep5h8TdYU1furh/SDPDX+/zA4HZpF6Dvcwr4SRxfuWOOz2mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLeXEjLv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso6531226b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752635335; x=1753240135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=txbGeWqBLXyD77pW1MQHtscxDxV1S4JfxJTpEzhLnts=;
        b=MLeXEjLvyDEi+Z/frlJNrEPUXbNSFqfqLQ+ynbBe1+YruMHLa/OOq6ZTb28g0wP8KP
         e43EYxL7cxyilB63gTlb3CnpR+casVUpjEjDrgEw7ODcDFzUWKUI1njQy+zSXx5SoNql
         M/GNmJ+vDDCN1bMTxIQzXZqT+MvVSc53ET2XYciIre11CIpbnYiOgwMxcKYEbtW2n0zr
         SNco/wek6aF2M24gWuPCHZirNQlVWG4bQFmzmQ7sLWvSVwueBidUzMjjtJmafl+ruH0f
         gHT4J8b/ghIjyrlzqHQDVIh/7Yqpr20O+2451TaYCEMR80TrVtS7VPuQnnYTQhYfej98
         AtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635335; x=1753240135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=txbGeWqBLXyD77pW1MQHtscxDxV1S4JfxJTpEzhLnts=;
        b=EQThZkCEyU6xdFUvEnu64az9IlWH9uDadELCltiRP7TbN6CCPDf4M04Z3tx7JOPnhf
         dj/XOMNnYPTKisdQV6Jmpw+kEWW+yEaRjL4LP1h5bPjEn4pTjoR7hUUcI2i+zbl227vi
         fOWu0q41lT968y/Ekdq+xr7to1rCOx6lwQfCbheGYn7OOvIhhY+AhTWAgjnmbTfaZz7O
         bNpetB0eN1jz0T6qf+xrvjXHe62JAGw1ERfmVEjWmZ6a5aSt2tiQrRWAN62f03MvBTuj
         lN3fNv2SEQDzzqG2zDHAPqILE66jrHhDjnJAZ7t9jZni6muDgtUE5yD0uSuk6yHggBIY
         h/nA==
X-Gm-Message-State: AOJu0Yyscjxyho8b0Dti8/87qOODyKL3W1pgkIkHY8t4Vt4e+1AbJzkJ
	PvsTZDzOw4+5pJ0KwuKrOEE4Wxnw/V9ZBMfWnv3YxYKsWY6kUvmsf6Q=
X-Gm-Gg: ASbGncsmu13u0PybZ/4u66zZuLP7imICDsKOaBZ0PXDEs1qMg5RslRRl3LPAc6waRN3
	WJ+THfQBantFlrYseRsQkeEgNRnjRt+2Jw4m2T4BpJ7YKJZ5mhiqm9Dme3jsJDCk6X+KQtOZCa2
	A5sC5HMuokStILLNc1nIQGLGXJh5YwT73KlDhAQzyXOou6F97w4GNMdbGDA8WO2tmX7+xLV1lDE
	Hu6FFAFSx65JcX110gJlp85jQG/Cinvfn4PN6YBltsAQj3DTpqMrIYX6lCmJj03EeJKHWCtt1qv
	LqHndEnQRpQ26/EX61QND2t7+IMzd+n8yL+HZ76j2GlWBaX30cYdP/JCct7UTioaakI2Na6m0Fg
	WN1CaTiJZLj+9aEPdHladJUCakmLtP/Aq8bp7P6GxQZnzPWhAV04c8Q2OoFDSIQ==
X-Google-Smtp-Source: AGHT+IGDwZEiL3QNCCKygKRifffCcxgAnWkx9Gk+aCmxab/qH1Z/dgzSrl2Gl3/I+wu8kFxwy0LopQ==
X-Received: by 2002:a05:6a21:328d:b0:237:ddb9:286e with SMTP id adf61e73a8af0-23812e4d362mr1404171637.28.1752635335091;
        Tue, 15 Jul 2025 20:08:55 -0700 (PDT)
Received: from max-MacBookPro.. (36-237-135-199.dynamic-ip.hinet.net. [36.237.135.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd603asm13549549b3a.12.2025.07.15.20.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:08:54 -0700 (PDT)
From: Meng Shao Liu <sau525@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	Meng Shao Liu <sau525@gmail.com>
Subject: [PATCH 1/2] samples/kobject: fix path comment
Date: Wed, 16 Jul 2025 11:07:33 +0800
Message-ID: <5be61d284a1850f573658f1c105f0b6062e41332.1752634732.git.sau525@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The introductory comment still says the example creates
/sys/kernel/kobject-example, but the code actually creates
/sys/kernel/kobject_example.

Update both comments to reflect the actual sysfs paths. Also,
fix "tree"->"three" typo in kset-example.c.

Signed-off-by: Meng Shao Liu <sau525@gmail.com>
---
 samples/kobject/kobject-example.c | 2 +-
 samples/kobject/kset-example.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index c9c3db197..e6d7fc18e 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -13,7 +13,7 @@
 
 /*
  * This module shows how to create a simple subdirectory in sysfs called
- * /sys/kernel/kobject-example  In that directory, 3 files are created:
+ * /sys/kernel/kobject_example  In that directory, 3 files are created:
  * "foo", "baz", and "bar".  If an integer is written to these files, it can be
  * later read out of it.
  */
diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 552d7e363..579ce1502 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -14,8 +14,8 @@
 
 /*
  * This module shows how to create a kset in sysfs called
- * /sys/kernel/kset-example
- * Then tree kobjects are created and assigned to this kset, "foo", "baz",
+ * /sys/kernel/kset_example
+ * Then three kobjects are created and assigned to this kset, "foo", "baz",
  * and "bar".  In those kobjects, attributes of the same name are also
  * created and if an integer is written to these files, it can be later
  * read out of it.
-- 
2.43.0


