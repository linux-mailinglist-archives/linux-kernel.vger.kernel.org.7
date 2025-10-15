Return-Path: <linux-kernel+bounces-855201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC7DBE0810
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FE01A234C4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30730C63B;
	Wed, 15 Oct 2025 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmQATqIh"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA55230276F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557471; cv=none; b=eveT+yXpLi8Mo5yccw7dhOlcSjI7/+a6PF9asGrlgYdD55JSoQLT4ds+hZfaTaPUjY0/CeZlKpqBqsmkhTscM/NvQNu7l/Uer546NsZJdTHwjrIe2jHBl4X/TTesr0qX4DqSFIgWizW6wZxG5bsYevZiE4O+Tw7yNK1xO2Vfmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557471; c=relaxed/simple;
	bh=Zm/F6uFyMc4nnEbtPWODklxGuzdzraA3ZsA0+iIdu1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQ2eOxyZqIIX7XddXepPq0EBMu/PXk+hVXIsdj8QGFRU+zIJqLHV7xI+nqDQwp9MieeOSv9iYapgtL6tWq79RxA79Z/5/YHOklOGLb0iUauwzAewMlcFOWoL1MQvkIfEnapRjgLyjB+Wa7xs21EllRL96AoXAufHQQf07ve7ysw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RmQATqIh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47103531eeeso1312525e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557468; x=1761162268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mFohtVVslXrTyo8hMYkLuQEeqxiLiM0O92p+2v9UC8=;
        b=RmQATqIhQnJlpMMpZy6+za6mpegcAdg2uxkvxUUsWDzQizv9ZOlu/+EJOUWsZn3Vuf
         pyRjjT5wiH1cIi8r4eXwaSa81XAtthXC3+7t4KTR31+zVcs3JuW9X+bdnI9zaAtIKi5K
         Q+eOVvsDq/q+wY57q1+RBHFj4QKKcg++3bwDq8PvB+cDU88iv0TJqybQvJB1fhYoToMz
         YaaQBTVsjFNzzQjUWN0RDFQUvc98+yea9vCpo3r0SE3A/2n8E8f+4FzFjxc5gfcJhSYr
         +3drp4+x7IXV6pcIHt/aGa4MzLJRpt4x9IsFzom92SJYBr2VZdh+DQRq3HtiQGBnEfKb
         XOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557468; x=1761162268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mFohtVVslXrTyo8hMYkLuQEeqxiLiM0O92p+2v9UC8=;
        b=cZ9eQVOUrcDH2Pq7VIYp3lHVv77Tyb4a+aUis1vDgvHhgDMUcRzxP5l0z8l3P/utx4
         n9JswWldJnBOfCbwWNv9t+GqeWGnu5HNd8lkUOi5HAswC0+hi1ZPVceDbTDQJNBCT2kH
         BM1/iF/W65tnVkNxveLnjxSWzv+ry4KY4Zspp5EHZkwuUFzx1sAvj++RVpb6zHs+t+2v
         vO9o24oDMJTncK7oFG1dYBDZI7fMv3HQM6khFRaC7E4pJPPszMQdIySuWMPWOwV9qhUE
         1TlH6SgFKxxKH5yO550HzDamVetV5jzbG0cXC8Q17RJE9QUBi+8XAMKkn8WCMArEx/Y8
         cSLw==
X-Forwarded-Encrypted: i=1; AJvYcCU7Tbu5UOqAV6ITriyl3GaXDEnEvRXcBFHJgBWHgwnppPtwSMRHhkajnVBoph1gGdWrnEd3+27NQcWAsRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe4I3lQaxZqG9+iTSznmXlRJtHZUke8HLuUlh4FoPi2yi3vSbA
	KsqbubZcpMnOgrvV9RPrV34l7+STqt/0kPkyZ3krtTH1QLtdv3PqXaSZ
X-Gm-Gg: ASbGncvqaCFItC8xeQe3daPSoibX1e/c0b5RrvwtHvSUmbnqMzuFStDOsvzKYNcCeHt
	Xk14mAeYaHCfVb4dj/EzmSUYSKrMu06X3E3NsFWuMV/GOnDOBbKt3z9WdYhT2JkScKU6lUl4H1W
	T8xfAw5yhBBWytEWrr3fQmmwDOP5ZbvANzD6mb7XwMt+MF1/ZAVVGhmpD1Bf1dGrxxG5Vqy6GHi
	7DW9rcaPVXyEgMG1kny2c/iY/lPgaa7RqH8uL/7vG3LylNa3aUOvTRxunLvJXU9ilFswpDdiurN
	LShU9OADMnPqaAn16MJkgF/zmt2sRmjS1KGwHAJHmXMPXdljw8xtNZvNRvVY0ZMjxGkXDsVhTJi
	9iyvcyQ7kqMYPf94fjCJ5VQ3JWfTeLBc5ALS4VmjonERb60+xgagiKxIRgYvdVjSO454YjqhE5k
	XnBNVmq8Dtpqnoks5mPsEam/0N7vjkdSl6Ackdj6lw2OZT5DVU
X-Google-Smtp-Source: AGHT+IFu9by7ZXfU1sgF4e/dNByhsbrzXetpPXsPwzZE529Y3Mf5qtbWILesQssXcoywCNc8g0IyDA==
X-Received: by 2002:a05:600c:4589:b0:45f:2d70:2af6 with SMTP id 5b1f17b1804b1-46fa9a8b2damr119306735e9.1.1760557468065;
        Wed, 15 Oct 2025 12:44:28 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:27 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 01/11] ARM: dts: socfpga: add Enclustra boot-mode dtsi
Date: Wed, 15 Oct 2025 19:44:06 +0000
Message-Id: <20251015194416.33502-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015194416.33502-1-l.rubusch@gmail.com>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
Some Enclustra carrier boards need hardware adjustments specific to the
selected boot-mode.

Enclustra's Arria10 SoMs allow for booting from different media. By
muxing certain IO pins, the media can be selected. This muxing can be
done by gpios at runtime e.g. when flashing QSPI from off the
bootloader. But also to have statically certain boot media available,
certain adjustments to the DT are needed:
- SD: QSPI must be disabled
- eMMC: QSPI must be disabled, bus width can be doubled to 8 byte
- QSPI: any mmc is disabled, QSPI then defaults to be enabled

The boot media must be accessible to the bootloader, e.g. to load a
bitstream file, but also to the system to mount the rootfs and to use
the specific performance.

Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 .../socfpga_enclustra_mercury_bootmode_emmc.dtsi     | 12 ++++++++++++
 .../socfpga_enclustra_mercury_bootmode_qspi.dtsi     |  8 ++++++++
 .../socfpga_enclustra_mercury_bootmode_sdmmc.dtsi    |  8 ++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
 create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi

diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
new file mode 100644
index 000000000000..d79cb64da0de
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
+
+&mmc {
+	bus-width = <8>;
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
new file mode 100644
index 000000000000..5ba21dd8f5ba
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&mmc {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
new file mode 100644
index 000000000000..2b102e0b6217
--- /dev/null
+++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
@@ -0,0 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+ OR MIT
+/*
+ * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
+ */
+
+&qspi {
+	status = "disabled";
+};
-- 
2.39.5


