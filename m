Return-Path: <linux-kernel+bounces-891386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0D4C42927
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8C73A997F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A93D2E8B9F;
	Sat,  8 Nov 2025 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbT7lvjz"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07362E7F03
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589177; cv=none; b=kJOAQLz+xlW2xNqvtldsK/n7b5rRGft590aD2B+cmB83pppNAh/iLtpCYjbjPKqo/TtJLUgCP+hSj0AghXubJPNuJyWxmYe+VhABqJSKjiO1hxX6SjfR/Srq/2wt2SLDjwSQEVqdYUKvhaI+FkJl7Z7O0y4F5mNbWfK3G/fo3w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589177; c=relaxed/simple;
	bh=xTw1fZj9TABghspblzMyZh7aJYlpz7LOhXxI2BNDWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TP8rmFwl3ad/BPORs7okKip3UU0Mt1RgG0bPDyQQSYU1StN/S/xa66XdRXMP5JgOoafr4JXCMvt9aRvz8zqjjdnmeqmcJwup8Jcnj3GM2UDQVCWxG0AQe1ub046+hg2VZNkC2jPWeeDJsbXSZSG3Wt6Ci5C6Wci6WbVW15F0j68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbT7lvjz; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7af6a6f20easo1249143b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589175; x=1763193975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=EbT7lvjzKGBHqo1JeOk9kDmxmgdHxlF0uNv3qjutwAXpW1lf/yEZpISX1uYKUfvsim
         aX9J0OsVtFzzgnA9YtNb9r493TBeUtLMIBUwVZKmBRXjEITSbB06Bu9uoVQGs7ThOMNZ
         akoMTe0/CitClDLTPhkv/qDq2olDFNXUq7JQzR1pH8zT+8kyNpbol1raJNNG0FboztBp
         2fDDPlXlorf5uwaAsueYahrxp+Abc84fEzawvzSP4JR9S1rcShGl4+aOeDbxvnHZjB8R
         GZfo/zX5Vq7xDXOOurEbWwtOuK4nbTHXdsFGbBpHatee4szE/EvQB/IzHAUuY8thKD/g
         Iyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589175; x=1763193975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=VZwfgaDEWglhmKh4nxf5lyPPXJ35P3VzaKDhQnHleelm+D5103PAB3llGFrYotlbWs
         vya9yooXDKx3fF7xAsICmfE1XLRq3ASjvtSfxXcMM2Vsg91S90GPm8iRYGt8ShDYx5sN
         7/3LwacmlFsEb4tx9ieIb8V1/NKstMiOOAge744+K+ptLDiGuRYNHZZcUu6xXeKOFH/6
         okp7Jt9Ed8IDGMKMii6IwUFp4HTWZKJz6xg6nBbxvnr0yQfk5mtukYPjwhA1TrxXqJXS
         5sz2cObU/o1NIYD0wqlQlWomDrjC0tnd2wY+AYZ3rHWp2jjl0qrS4zzQQQQs3tF24Y85
         1Vpg==
X-Forwarded-Encrypted: i=1; AJvYcCWXcQpBEwoEzj/tRmIz2YQl5ty11t2pxu3aUVar+8FQtv9X9SDwQNQcCAsntvlRojm965naNJ/U5XZjk+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXH5pa9F2vSD7RFR64K9AzayWXvSPJAGtOIPc2VNJ39A11mePr
	yKeww36Q1k34UmpkrTlQVJM81UE+pwjWRFvLT965CGxbVBQRn/XovO58
X-Gm-Gg: ASbGncviiEqgf7FujkUti3R6PsyDijgupVFa1nkvPiegKrJVk86qMCY0do9/D2Gj7UX
	14cc57YaDeOanU/QWIQkHVR7xh5cwcv6PBgj8MO9nW0yA+sTl5DxqmoYsGA2NFqX/3q3YHI7wD3
	2sFK2jK5Swuv7fKoD+huCuMgS5UAISgkRsp2wK6O5frePfLhx1C0a9Qo4TpCD/UE0AprHV7SBId
	XernF5GgnqecmDHDgdYYUYnBgoydMKTWydUYdoMYuC8rUtGBA8c6C5ecOG248xOJDUDV5FA0q6W
	N/V0pUy82uxGuqMusfxHLaoIq1e8nU06vh2VzbdBlUX6I62B9hsew2i8GhFsBqJTF1OYk3sczWC
	xtbAA3xFfMU5+J+dDHBx991GDqq/MyRTyW4T0TZmVla4WZXAtLHy43nWjGHrgXS99WZM1iUkFkO
	kk/RBQoXOkDBk7w8pHjANySNqGv7cFfeeq/+5GdheJezb+Lw==
X-Google-Smtp-Source: AGHT+IGD48yU+7r6eJf4t73UQMq9PCzXek9Pp9f1XAQMtlPt+4CKZ0imYX/Cbn2ZTgd9N+RvP0eTWA==
X-Received: by 2002:a05:6a00:4605:b0:7aa:81fc:a83a with SMTP id d2e1a72fcca58-7b225acd5b0mr2845940b3a.6.1762589175204;
        Sat, 08 Nov 2025 00:06:15 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9632e22sm5333782b3a.8.2025.11.08.00.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:14 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BE10811388D5; Sat,  8 Nov 2025 17:06:12 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 08/13] x86/um/vdso: nommu: vdso memory update
Date: Sat,  8 Nov 2025 17:05:43 +0900
Message-ID: <a689fc371d0207ba83c9e0d2e9335be7095b73be.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On !MMU mode, the address of vdso is accessible from userspace.  This
commit implements the entry point by pointing a block of page address.

This commit also add memory permission configuration of vdso page to be
executable.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/um/vdso/vma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index 51a2b9f2eca9..0799b3fe7521 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 unsigned long um_vdso_addr;
 static struct page *um_vdso;
@@ -20,18 +21,29 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		panic("Cannot allocate vdso\n");
 
 	copy_page(page_address(um_vdso), vdso_start);
 
+#ifdef CONFIG_MMU
+	um_vdso_addr = task_size - PAGE_SIZE;
+#else
+	/* this is fine with NOMMU as everything is accessible */
+	um_vdso_addr = (unsigned long)page_address(um_vdso);
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+#endif
+
+	pr_info("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
+	       (unsigned long)vdso_start, um_vdso_addr,
+	       (unsigned long)page_address(um_vdso));
+
 	return 0;
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -53,3 +65,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


