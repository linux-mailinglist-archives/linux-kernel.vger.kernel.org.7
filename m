Return-Path: <linux-kernel+bounces-893417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C7CC47549
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E16B74EBFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D61731355A;
	Mon, 10 Nov 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj8t2lOB"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9948A30FC19
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762786137; cv=none; b=fufgTbba/ldzcd1oEXBO7Po31kT+Zs5oP1izp3dyZdRogOQXx4daTikmlQnmxTnAUClP/EfW3Zix2VY1AaK/QCdIoy+A6vt8c/j8aYTqZngsI+V7UJ8TyEn8zK41Sl/z7VDAYfR1ns+lVUvC/WuPoPtGB/c1SINGIy0CiB5bpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762786137; c=relaxed/simple;
	bh=QvLvyRTtOe3YpANvSN2TJE7jXUgDr0aVixqk0y131fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PA0I0tWWKgC7ScWaoUenLfNIgq8JHALFGBtbeCa4VLiYeMxOwEZwQlJPjB2GFiCBXayYKCYSfRpQ9WJOCbctIk/ifwQbWGiDrycPn6cf15u51j2NJqPZ3ziVYnyNjHuEQxNcae4PhYjYZwmdmVrst+PP16cUGrzT2Qjnl7PUbD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qj8t2lOB; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3437af8444cso1364736a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762786135; x=1763390935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FrgskyzgQxtRPQXe+YA6yojSKzP/1EuspyiSaUY67z8=;
        b=Qj8t2lOBhL3+SKQ9YLEjjqg5q8RodXiItrSBwp09JDbTitHiWc2eoS7DzbDn1La+GK
         WhEXzdnwaazwFa8OyTC1iC7dgvuWT7O6DBmsg4dLTImcsEk/nzAnjriVzhrMqePcbYx5
         L8VQj99YvR2/DiN7pEvhfMcgrCFCpG47JVVH7NURT5avljVkiR8D6Eiw4SWOFaysekxY
         mEdBNu4LTXcMr0optpyMYvI+6Mx1IqSXVLQkfR21De+RxOn8a6g1BCWt533EaRATrZ5x
         szULOegP/aUbF7mG/Q1AyOuP/9fygMG5RD8+WT7Blj4xJ7F5v/tA1cp7B5HmCOF2KgWm
         uNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762786135; x=1763390935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrgskyzgQxtRPQXe+YA6yojSKzP/1EuspyiSaUY67z8=;
        b=DjMR64VwRp2SWr167y0Oe4NoDYL93OllfVO/LtsEnnyNhVGe2aXdKloK2xyV8a5vpf
         CINxzx0fg7B89MLM75dp2AJvk4ZEMlSomlix2PBDdoJEM6Pkan1WmECMAA9yKLMlJxRi
         Bv8Tosw4wM9/1kfLIVyz1TJa/NKaCeveFYj/q0Ey7pjyvOdGQMSbpB/UTiTR8zfGbiJ2
         FRk3JDJBJ5UFB9FDxG7H8eSYpOSUjg96nHMdvDrePEPP1KtZ+jhsjG95IgXBQWEKsPkg
         3opBIlINc7XsAvbtoJB4uIXxBEkQlzeEDQQP6lE6Gc5+qqX4xSf1RBoNzZJsPaUyjFw6
         qJHQ==
X-Gm-Message-State: AOJu0Yy1aHDzBAvR0/3ZKBbvq9/8g2HWMhLhxx08Sc1uUzyst/yLKNQx
	+OAqoU1kwmQK8oL7nURSbAELeXIxczRkh+ijaoo/ImmuXDK84VNNI2M1
X-Gm-Gg: ASbGnctqQKVTkxGN7p0OSbnoxqhzR5xj35QwXmKy6jzfQJJeT1SPauUg5fzYWRzFVCP
	3LfkUjogJ03CmEUAE+uaQM9NbJAu/9GfkBDdw5tNL4i5nEcwovlX6ZjVejgdWZxYqAwXRU/rp9v
	YyC3cxL9+p7DmLDbegI9NuZDh1F5NWXIZrYK2yNu2FVJyM4n0zZFK6tvIgPK0oKq+/XFxfecwQT
	prdpDq4/hruzqZbo18AFsUXxJxdUi1dSjbwCnzJzbGHNUI54VGl+o9uPeHC345++XuzxtPuvv+u
	/W7HIIPVJug9/y73zqiFrdVC1Crp2w9fiz15JfQTBnQH7LZhV+ktw/u9r3KYZlsjH6eDJbRnV3n
	T/aVGf4SyNpMP0Gw6E4eePRJwVluAR7p+h2KRROJvw+GtuOS+9+pvaUvO9JczUzQMe5gzFTD9xP
	ajXfxZiNlTUog3s4L0FRh/aafN
X-Google-Smtp-Source: AGHT+IFO7qcki/gcHxPVszkVoI6yIC1USYq4fWfL3CjPS2tpRrsdQwNQQWhcDI05RjMTZ5o9QWvvag==
X-Received: by 2002:a17:90b:3bc6:b0:336:b563:993a with SMTP id 98e67ed59e1d1-3436cbf7f73mr10435722a91.23.1762786134867;
        Mon, 10 Nov 2025 06:48:54 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3437221b329sm7579364a91.16.2025.11.10.06.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:48:54 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	masahiroy@kernel.org,
	jack@suse.cz,
	akpm@linux-foundation.org,
	maninder1.s@samsung.com
Cc: linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: [PATCH v2] Fix redundant judgment in WARN_ONCE with clang
Date: Mon, 10 Nov 2025 22:48:44 +0800
Message-ID: <20251110144844.1376-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For c code:
```c
extern int xx;
void test(void)
{
	if (WARN_ONCE(xx, "x"))
		__asm__ volatile ("nop":::);
}
```

Clang will generate the following assembly code:
```assemble
test:
	movl	xx(%rip), %eax // Assume xx == 0 (likely case)
	testl	%eax, %eax // judge once
	je	.LBB0_3    // jump to .LBB0_3
	testb	$1, test.__already_done(%rip)
	je	.LBB0_2
.LBB0_3:
	testl	%eax, %eax // judge again
	je	.LBB0_5    // jump to .LBB0_5
.LBB0_4:
	nop
.LBB0_5:
	retq
	// omit
```

In the above code, `xx == 0` should be a likely case, but in this case,
xx has been judged twice.

Test info:
1. kernel source:
linux-next
commit 9c0826a5d9aa4d52206d ("Add linux-next specific files for 20251107")
2. compiler:
clang: Debian clang version 21.1.4 (8) with
Debian LLD 21.1.4 (compatible with GNU linkers)
3. config:
base on default x86_64_defconfig, and setting:
CONFIG_MITIGATION_RETHUNK=n
CONFIG_STACKPROTECTOR=n

v1->v2: https://lore.kernel.org/20251109083715.24495-1-qq570070308@gmail.com
  - Code format adjustment

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/once_lite.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/once_lite.h b/include/linux/once_lite.h
index 27de7bc32a06..236592c4eeb1 100644
--- a/include/linux/once_lite.h
+++ b/include/linux/once_lite.h
@@ -16,7 +16,7 @@
 		bool __ret_cond = !!(condition);			\
 		bool __ret_once = false;				\
 									\
-		if (unlikely(__ret_cond && !__already_done)) {		\
+		if (unlikely(__ret_cond) && unlikely(!__already_done)) {\
 			__already_done = true;				\
 			__ret_once = true;				\
 		}							\
-- 
2.51.0


