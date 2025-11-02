Return-Path: <linux-kernel+bounces-881715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9A3C28CCA
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C07B14E5FBF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F8F25C80E;
	Sun,  2 Nov 2025 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R34IH01p"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6A26F47D
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077003; cv=none; b=hZojA08f+G40S9FA2u2UcaICN2dYdA2OxUeinw3NbP7vEkqG4bzGkw7ds3wn1MhXQ9D2g/fcT5uLJctDmNr1A10HziIkV7mA80FaqkkCt7a9W6N/Ad8WOtiVo+l4HopyTEXiYBO01GoXU5HAoiI3jzADz6Kj6v8zgrbHtZGgCO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077003; c=relaxed/simple;
	bh=xTw1fZj9TABghspblzMyZh7aJYlpz7LOhXxI2BNDWxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gd/r+hA/vKqQNE7Jqcs2mV5N863StxKDFObOKY/ojxZKjRzp6W+ByUEhjigbpJvEhV386a73+FGfomPUiG0zCpsFnxfQ9VpOrMg4fE+VS7QkBu67Hi0KqmCxTXa2mzQYmX6BqLKr8ywwRrvgYHeLs1Wv61UI9K1Y2WWjKqWZ/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R34IH01p; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so3807586a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077001; x=1762681801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=R34IH01pQ2mVcxKuC0WakEvhR1IP+HeIaVoSnrkZfebuZV1NkPBKc2ntL5u4dPmSzw
         un9DmkQVXSQJXuYNey3vQd3AI1cnDw2bm5nWiXcwSUv+YGLNTq8gUJSC3RAOjmhDgsIB
         NSf8bak/vKjx9mU3CIn3es4DJpp+zDYOtPG2DyFC4Bwy+Eh2D5TFcIHorAU4CEh3FD+l
         yOPmDoBrVolRsY4tpmFrrSyUjOjS301gxmIS8JtompwKp4DjyfofuR9rl674DlEGYYJs
         Jzj8oB/td02JORJFeAk5hF1ABQ1Lu344Wr6IfpS6SgBQthRoVkrEIvafpHf3NxeFndhB
         dabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077001; x=1762681801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=mQaYRvW3aVpvZdsogtqfqhhSwdmWwvtbkXdOzLf3pAA7z23AWMbAses5QZ1gkvGaqL
         8Q0qFp6ydgdwdQL8YlMF/SjoqaviKqPL5oyZ+vBwpkyVb+ugo11l7K73oR9PYMXhk4zY
         FumTO3nAnoNoBbhzzbj2xLszaAFdjtM6nKYb+oq4tuJU/Qlg7tePcZa/3qoKkE12a9We
         PDm7CjREdD+Nykv8HLKbYk4zQbVs4PpdUGXvtCRlTylwPv+CK5BJ037ZooZaJ1k0g5N+
         oCoR+e+gB28Q5nOzDKc6/Xp63HlLJrfHkNb1nzZH/uZCm//G6siqsieKZY30bKGYOfuw
         gbXw==
X-Forwarded-Encrypted: i=1; AJvYcCUCjtTY2NZQhlrOD90Anz0xMZ5Czc3PPDIVs0ucVp6o8SXoBZVOn1Us3d8U1+IXDziA37r0kjqg+llpWro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNygxf4dlPPFISup+9gvSWchT2/+LKbKaberDkxA9RpmO2WoKd
	o+6FyiJc1+XzTnOy7FeuYfq+xI6rRz7hFDa0nxDSYjCrsGFTgSzi4kMV
X-Gm-Gg: ASbGncsbhQXh/4t2eHZl5Xgf/zASDanNZD7aCifYzURVv5SJ06z0D7bd+LH42dtykWS
	HahzGOvL2+oe5q9leJAyzVus0wmeAheeG9XzP3Im8vatGUWCmo/cTgWef8hyyndOwM/kB7UP5su
	pGvdCTtd/sce4/oc2M0Z0j3RgAr+ftntA4tex7hkn420dolTfMaDyPt3gA6kQaoxarWMjr0U1Io
	YzHssqVycbsOkHeltXgIqHwsRl3fDpOHbI8yvJP+jTA0jkzZxENPPJ6gM57AA0T+JN/3iGI0BxI
	8HNpmNsVXAOIVPcZQvIpQET2O+OR21Pss25P4qIbhPKeV0qmBt/ZoptuXpiHd7s0YVHY7t7EdEg
	IPwv1ljxZpuk1F8hGskcIXpaaohtyR4ds6c0fiewhaNLULxn4ATJDGAEuIIOQAQZlYa+K8+a6ks
	qo+BaLKi5LbnTpY5pxIx1oivUjnBk1751y9FW7SmlBHSOLhQ==
X-Google-Smtp-Source: AGHT+IF6VpzjPS9k/xuod2eADBDKoo5bQTtUF+qS4DJNZKzsKjProRzGMXg47Us7ItLnPnxUlti0ag==
X-Received: by 2002:a17:902:d505:b0:290:b10f:9aec with SMTP id d9443c01a7336-294ed2c61c2mr141344925ad.26.1762077000826;
        Sun, 02 Nov 2025 01:50:00 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd6f4sm79732315ad.101.2025.11.02.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B530F112380D; Sun,  2 Nov 2025 18:49:53 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 08/13] x86/um/vdso: nommu: vdso memory update
Date: Sun,  2 Nov 2025 18:49:33 +0900
Message-ID: <8036933c8c46dbf1ec32b8b57ecebc94c2cdb2ca.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
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


