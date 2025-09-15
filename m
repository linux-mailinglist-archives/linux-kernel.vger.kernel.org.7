Return-Path: <linux-kernel+bounces-817192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB8B57F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A62327AE831
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C8631D74B;
	Mon, 15 Sep 2025 14:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTlHJVkv"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99D3081C7
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946806; cv=none; b=Tmge6ukPy5WYjw1g2HMzXzJAi+oqBBIlT02hRk5dK144ruOND4NMY+YXrQA1KNr85mT2jU3OLH4X0PgeuEkVeGlRqqeZDVLiY5b+wo5RyX13+bTfO4bUTrwAVN9S/C6S9MA65o1NzJrybCk8/Ihi/wR7CVu9PVkuUXIRvO4lFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946806; c=relaxed/simple;
	bh=2M8bte29liykG6nBai0n+gQbjbDqAsnpaZ6Ut1ajsDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QHz/XMgIdxOQYtuBy6GeiYJPEBR0owVfW4eHtFYihmY04Lri5Yjz3KA2B3Sc4aLilShIuDTFQ/AvZSEdcSYeMTtFk0lFqGgFeAZkeuar3+put+gNStm65LuAnT6XaONH3MEFBs00LqF3HGI5bNMqmp0IQhbcCTCJmsxkKnzsowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTlHJVkv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45ed646b656so34893265e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757946803; x=1758551603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qHPRcShdCxFpSO6mT7vMAVpPVug6VS2Oq2S7HGINRxQ=;
        b=GTlHJVkvzWm8BjSk0SkXcVgwKubIRszAvLc8T5kGkd85/urhbcZAlP8EYc46Q69Fhy
         xFmC6Igq9iNguz/U03y8Fsw5sPutfuWqO/BkVc1yHMQVM7p61zKcml8c4ralVqADEKcQ
         Wc6rqEiHb4YBaoZ59+HGWyFyySw0ZCyqkBcu2FVQDj8BqnaqWmHofRXn3gfLogEqDP14
         KVGppZ3cD7fnxZwnxfJcp5UbYiiivsFtz3RW4RxFA/EqSZ3fdVhsjSDJDjlS4OZ+VnkC
         0MnaACeP36Xa81nSA9HKygix0fOwunJxm8eK0nZQDPEa9xUEJwUI3UQbu8VB9LVsVI8y
         +SLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757946803; x=1758551603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qHPRcShdCxFpSO6mT7vMAVpPVug6VS2Oq2S7HGINRxQ=;
        b=gzFLxZadEr+/DRTDyy2hRFeQyCXy+jV+CSeYZj26gyQE73RQc54s7sLKuBf+cJTJ/o
         mn/+FPmMe/UjMt1y+u9jAdghVjG+7tWDADZT7bAd/nyaRqTTDuaQQTGwPQ9+6bKGSB0R
         cE9Kbos3jI1usC7+mnZA3uiQnYc+23U5P1Nzd4UqgqH84/R2xlZPsJyZO2/rXECFcoPa
         1r5VM4lMJzB/3wulPapWZwLjph9ckr6Y3S3T7yimcOMRSHNF840BUj4C91P5jH8kNrZw
         m+xbOHG0NBpJ5BzNL+7Wmk8uLYIpdmFcffJNYHceFNkNsqsQBAviMx5bLwhv8CJNxo5y
         NR7w==
X-Gm-Message-State: AOJu0Yz4j7u2kVUolaJLQsdHSZh1SAkoITlV3hgv33TxjW9RD2qRTHuQ
	vI1iMFznfrd1NGe05oik+9GnLMTLvpyYKc8y7RmYPnKdZXFaofq/OW9o
X-Gm-Gg: ASbGncswcyXKmvdv1oMKuPxydnZTjUkinK0eOsSwpIsB86bDyeNWeIidEuyrBe5yhQN
	W21xu3WkBZeYKuWW2pvRgJ/uULCcCOhN+paPZU0PY8KTKnFAglDdfMk5OQC6jHPO/cUw5XcflUM
	aQtRrQAoyzd3EJ+GlNzcWWNJuwioF0DmrwXSo7X7MhGloVprJi8ZianBsZO1KH1HG4wep8ENbIj
	Tzm2PP9rG/EiV+0zs7xUv1mjpwA0HEW+cRNQcwHLtKmh/wl06pM88EcyiKU54NyujCdEHhqcD/U
	a9AFEjGxrAtxu+xRBhCRPMbdKXd3p9taCYDXasS0kA3FOB4XP+DC6BVj7Ccn4D+MPMhE1bUQ+aI
	Nfb8tSWweyiMtFqYht4hfxCunC0K3WVnXR7coJ53B6IU=
X-Google-Smtp-Source: AGHT+IEn5Sa4Xov8t4lAKQk2pYBCXtbAYBUAtDz70s4kq9Ua1d/xAlyfDPwz+0nOS9FKdWS0cCrzdg==
X-Received: by 2002:a05:600c:8b4b:b0:45f:27fb:8017 with SMTP id 5b1f17b1804b1-45f284e67cdmr74363105e9.5.1757946802462;
        Mon, 15 Sep 2025 07:33:22 -0700 (PDT)
Received: from localhost.localdomain ([37.72.3.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3cbdsm195493545e9.17.2025.09.15.07.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 07:33:22 -0700 (PDT)
From: =?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	alex@ghiti.fr,
	wangyuli@uniontech.com,
	=?UTF-8?q?Miquel=20Sabat=C3=A9=20Sol=C3=A0?= <mikisabate@gmail.com>
Subject: [PATCH] riscv: kgdb: Ensure that BUFMAX > NUMREGBYTES
Date: Mon, 15 Sep 2025 16:32:52 +0200
Message-ID: <20250915143252.154955-1-mikisabate@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current value of BUFMAX is similar as in other architectures, but as
per documentation on KGDB (see
'Documentation/process/debugging/kgdb.rst'), BUFMAX has to be larger
than NUMREGBYTES.

Some NUMREGBYTES architectures (e.g. powerpc or hexagon) actually define
BUFMAX in relation to NUMREGBYTES, and thus this condition is always
guaranteed. Since 2048 is a value that is generally accepted on all
architectures, and that is larger than the current value of NUMREGBYTES,
we can keep this value in arch/riscv, but we can at least add an
'static_assert' as an extra measure just in case NUMREGBYTES changes in
the future for some unforseen reason.

Signed-off-by: Miquel Sabaté Solà <mikisabate@gmail.com>
---
 arch/riscv/include/asm/kgdb.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/kgdb.h b/arch/riscv/include/asm/kgdb.h
index cc11c4544cff..66ff46e434fa 100644
--- a/arch/riscv/include/asm/kgdb.h
+++ b/arch/riscv/include/asm/kgdb.h
@@ -3,14 +3,18 @@
 #ifndef __ASM_KGDB_H_
 #define __ASM_KGDB_H_
 
+#include <linux/build_bug.h>
+
 #ifdef __KERNEL__
 
 #define GDB_SIZEOF_REG sizeof(unsigned long)
 
-#define DBG_MAX_REG_NUM (36)
-#define NUMREGBYTES ((DBG_MAX_REG_NUM) * GDB_SIZEOF_REG)
+#define DBG_MAX_REG_NUM 36
+#define NUMREGBYTES (DBG_MAX_REG_NUM * GDB_SIZEOF_REG)
 #define CACHE_FLUSH_IS_SAFE     1
 #define BUFMAX                  2048
+static_assert(BUFMAX > NUMREGBYTES,
+	      "As per KGDB documentation, BUFMAX must be larger than NUMREGBYTES");
 #ifdef CONFIG_RISCV_ISA_C
 #define BREAK_INSTR_SIZE	2
 #else
@@ -97,6 +101,7 @@ extern unsigned long kgdb_compiled_break;
 #define DBG_REG_STATUS_OFF 33
 #define DBG_REG_BADADDR_OFF 34
 #define DBG_REG_CAUSE_OFF 35
+/* NOTE: increase DBG_MAX_REG_NUM if you add more values here. */
 
 extern const char riscv_gdb_stub_feature[64];
 
-- 
2.51.0


