Return-Path: <linux-kernel+bounces-810070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF87B5156D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 13:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38E41B2871A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9F931D36E;
	Wed, 10 Sep 2025 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ij7Da+Tp"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE1527F73A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757503456; cv=none; b=ouW2IqGNRqP2Wrk6O0RwpHlZ5gQe9ONf1yw7nKtvxbodC/mtX5ajLMuIlK0nD9WAuU7cb+LIVdJDe1REnVfjW4ORc5BMgiUGA7vm2CxMMyh2iIK91fHbwV+ENqqR+RwWXwAiqvu1a/LI90jpuDVLjxfNoKs19BaKokPrGoSU9/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757503456; c=relaxed/simple;
	bh=sztzkIrLu7FSExGL9BMcu/D/DVjlKOO7T8geLTSmEr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f16c8HDUAXkSq4WFToBI03DfryawMeI4bp2ueWEbYQv/FYPh1tNdhmx90p0A76MJLLfthfvqVWxv+Wil7LVwWk8tPAsU242JFNrEZJ5oE+KHycdVZOYnheTFLbYA6dkbmfhRctAPZXfPpfl7e23oqFQgZXJngpJjPEH2uL//hz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ij7Da+Tp; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-772481b2329so6941091b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 04:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757503454; x=1758108254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/TTXO4gixGHLhOwbcVZRnmBexzuJ8V+thRGTmK2A/8=;
        b=ij7Da+TpX17evMwcbDwAo8OqtUMj3kvwBV0LUTI0JphKtpONkgA5EFToGNV37xpoYq
         yrGe8td+fPbfRGUCOI+/Z9eSkbc/MEflG85DZIWV8G9HG3rtKIOWDl0AVXJfsoFgXGOR
         54KCkb81Ps6wAzUbGqwSgAnlvjTKp7v+tRojUvKcLA3uZbkl1JYhjo3umONDT1qHVI0o
         hTnpxv+SaRLDMhjvWb1c/qzb0owN4T0MpUZen48IGP6iE+vGPYWv5lULD02rEnhW9dMl
         bTs4dMbntTqekPhbIf+l2SiJOZ1BF10njIAvdI+AIa/DsccYpvPfp+6i+P8qMVN8sHrz
         WF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757503454; x=1758108254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/TTXO4gixGHLhOwbcVZRnmBexzuJ8V+thRGTmK2A/8=;
        b=EZpVPGHvZ5kPeyoyII4g2njCZaUOuk2u8wEHyJFa2pM3b4JL/ld1qdcaxAswoop4b2
         37k3GhwpgS28AeVZp9REBtt+wBMYK6CEyAG22uo6sjp5K69zbAUCIXD5BJZTHIIEL4HI
         V8Y1dvJXbdMVNJPIwljhe06zqTC9UbuTcJgpghGChtFfDOlPmhzZOgYheGoRdvCi/92O
         QXMeCKv+Kgx0UV55N7TBoUIyczrtLyt3XpkxCUN3qqjSb2hlQy6JEQBwmgCoeKcaZXFa
         lmZMdVONzyyLEX/HKtkGWxz1jAkX4THeKPybnCgUKareqgne9A8YK5OEdcRQXNeyGnKO
         KEhQ==
X-Gm-Message-State: AOJu0YyYNfxVWPqm8oAJwtzwZX1KHW+juZfhnCcPe24I1AUGsKh3hC1W
	P4TtQkTrZePqXSf6SusU9zb9sUXwKtauonL6yNzeJ1o0J2ie1xKNfmRw
X-Gm-Gg: ASbGncuHWaMp5URYJo5M0zkAAMIgFskVyP2th1g9u+iuCd2exX/pfT0Jfm3esvsgshv
	FvzigiQSgKXkjjJYeme2ExAULMXFv9yFID3vYLMJRH0P/jrqnSnMGYKA9sC+bd1uf3U4t51vpJ+
	9QSDoO1D0CUEnN0jDPAyakpBhEh540FL/2RR6sFoH+ZLBG0vfJQ7rgFSp/wOWhoz0u8lxDjOzKH
	pMqLQkMbxnjlEgD+Wlx8WPSoVe4y8eEGHEnz2aMlxB2vGQ0pLDrexMHtKE7/MFTaqmg+kgoYaIm
	KT/ah/82Y8aNZD9bAyMQpwtjtIDA6zLMUm5oB5ZLUNgt5e2eE0johcKmGevD4uD6pjzVJvaLHze
	EGDHTQhYpCA6bw6xg1dVq69OKaEXCYUmy
X-Google-Smtp-Source: AGHT+IHf9ljGSSI5D0eYX/jCF1ENGjCsNs2GTVoKAKOhVS8gT9oVVkaoH1FVSM6lQLvvSyF+uVbghg==
X-Received: by 2002:a05:6a20:4b27:b0:24e:2cee:9585 with SMTP id adf61e73a8af0-253466f5f47mr17083813637.54.1757503454024;
        Wed, 10 Sep 2025 04:24:14 -0700 (PDT)
Received: from localhost.localdomain ([119.8.44.69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548a6a9bd0sm2312530a12.27.2025.09.10.04.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 04:24:13 -0700 (PDT)
From: Han Gao <rabenda.cn@gmail.com>
To: linux-riscv@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Zixian Zeng <sycamoremoon376@gmail.com>,
	Usama Arif <usamaarif642@gmail.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: acpi: chose to boot from acpi then disable FDT
Date: Wed, 10 Sep 2025 19:24:01 +0800
Message-ID: <20250910112401.552987-1-rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

avoid errors caused by repeated driver initialization.

commit 3505f30fb6a9 ("ARM64 / ACPI: If we chose to boot from acpi then disable FDT")

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
---
 arch/riscv/kernel/setup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f90cce7a3ace..d7ee62837aa4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -330,11 +330,14 @@ void __init setup_arch(char **cmdline_p)
 	/* Parse the ACPI tables for possible boot-time configuration */
 	acpi_boot_table_init();
 
+	if (acpi_disabled) {
 #if IS_ENABLED(CONFIG_BUILTIN_DTB)
-	unflatten_and_copy_device_tree();
+		unflatten_and_copy_device_tree();
 #else
-	unflatten_device_tree();
+		unflatten_device_tree();
 #endif
+	}
+
 	misc_mem_init();
 
 	init_resources();
-- 
2.47.3


