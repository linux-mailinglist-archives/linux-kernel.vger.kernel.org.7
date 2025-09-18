Return-Path: <linux-kernel+bounces-822238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE453B835E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99704A52F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EFD2F28F0;
	Thu, 18 Sep 2025 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRu/CjVI"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E522F0C4F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181171; cv=none; b=H91+OuEVhljeBBhKMqDf+mSMmYFKjjr0bEkirDDm/0uI2zAJ0m0uE8OepWV58TYFiCtjEMrwnUw27bNp4Qwos1z8SHdY/sO38o/KIkdVPF+EGHIlTW+RwoI4KTcvbVjvaeGkGQyY1Zrk+QXbhFsROS/Z52qMKaflSfPKO7VZXQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181171; c=relaxed/simple;
	bh=YUEZeH1TUt8vhd5nOMxaCkzJVaWiSM7ZZlNxkfxZqDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOGzm3Jn+DRMit2Tu3VPLtEbvzKOEHsPMS4Gb4V4xHOYsCe20tn+9JAgSO6qJglnQV1gKdJxckhAEUsFMetLQih53AAGFg1wrQwoaw0WGPge/v11j21/bYtvoor3h8bMbSawPMkmRT0frTPEDFnXOZ19bZhTPoMHkiis38xynyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRu/CjVI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2445824dc27so6457505ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181168; x=1758785968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=IRu/CjVIJ3IG83jyLuk+P5pcgkUgkM0sCqFpjsizHB3GeqfxrcQ0Wz5VF5VEkcaY1N
         0dg9pgOUzhtYw1lKBKJ3U9ZgeiByTXZgbLwhObiFlO48Yi1PmcCxJeWdxwOXQVl+IeB8
         7vmoFdAGt9BJruHLi9OusOhGt9cLM+o8tUer3+pZ40iD5hdKOQ2PBKEr/oR+f30rkmTi
         /FzbwWf+IpSqM1/sJ4VBX9kZt9259JiK9UA+fdc8lXLeC4QwtE0lnWu+QitFJ1wtKqup
         WbCXunH5hKKb1i4rz817o/zAqixiR278EmgfQlBNGxhyUvJMRUzbLI+orB/yW5hmUqCf
         ZPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181168; x=1758785968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=Ag9iIX2PBz9dmt+qZ9mozy0tc9PjmsCKf0VMB95Z9THLrCtBRGNzoLYaB6vd5LLISA
         TuZEM+Ojcb12GzXiBSlRiYEkRCzm5gz91gKmFcefXYiMEpxe7i8KH4OT/ZTQZb/iBNr6
         ugD069tTnc/UTGJauABt5/vQVVFODh36QUpIQsSdb3UMiU2e/4klkVfToMMAxvhmRvUw
         WaWgJOke2Mv0B8lKHh52+vi3+ImVctl9nea3Gx+AgPzgFUtFKSX8mWtsI0ysDIFJ3hzv
         vQMFl6hcTIyWmchM0kXkoOp0H3h8YsuI2ZrIdnvCDPRdk1Ag+U90hPcaY/fmPtA9kRDg
         4Adw==
X-Forwarded-Encrypted: i=1; AJvYcCV8LQryu/5Yoat6ME4l1SZMEZxn2VUmDaxIiPLbPgCJ9er3EuI4pl91VZFgJoT7p/lDlExvjppVeSEWT20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrte0Yd7cGqNXTpCn6cCuGJHQ03aDhAs8zFSWPCPAYE17q153h
	qNdAq51UVptGROMNm9jh6ZDdPQrAp+h8+EeDHOQ8pT+1yAAw8bMXqqrfOUMx9w==
X-Gm-Gg: ASbGnct9R3OxZVSNg+oCU5PkGWMsrKNJxFhVJNYC1jc8nbyA1FzN/36JFEYZxSa5hQ3
	25vMaCAP1NhoV99t7pwnkNty7p6PPpzTOTsVgAqQ6DI1RWSjckNEGAMkr7Ih6Dej1ozlUxXM7yP
	fM21IhA8JjMaQGVBeQsubNS9aL82q8A5Qc6SWttivgNXGvzjfwmA/S85USWiBxOWhiZHePz/JFz
	2b+cShAEETe/UAj+WMaKD1ztPljHIbL9hsdo+AKNy5imjueHTG1SAJ8MvIAspIGYTUIfL0rgk33
	M0QOwN6CXwuztRMBa6xCsTSqiBSyqWOFNT+Nl160qAiYPAM2tBb9G1xltRYwLpK+o+KpPn/eUCA
	U/0Ucip2Clam9x91Iqz6jIblLx3K6rgSI2GQ02klGdQ57nFMg4ecnAa6dpXCOQ6o2p+SD662JrN
	t8nnHyxA1ylUkuf8CIdWMeIw==
X-Google-Smtp-Source: AGHT+IHNzuZzI3jPq8s+w/v0EJThDoVKmlAiVRMnAVUhLpF0S4fB/x53BdW1cn1NajqHcqRK1lVQ1g==
X-Received: by 2002:a17:902:e807:b0:248:811e:f86c with SMTP id d9443c01a7336-268138fdf0bmr60148035ad.34.1758181167976;
        Thu, 18 Sep 2025 00:39:27 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802dfcfasm16349805ad.73.2025.09.18.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:26 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 78363106210A; Thu, 18 Sep 2025 16:39:25 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 08/13] x86/um/vdso: nommu: vdso memory update
Date: Thu, 18 Sep 2025 16:39:03 +0900
Message-ID: <0f3c31aab253b7a76f96ba758150442d72b52ee4.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
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
index dc8dfb2abd80..1c8c39f87681 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -21,14 +22,24 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		goto oom;
 
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
 
 oom:
@@ -39,6 +50,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -63,3 +75,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


