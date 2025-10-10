Return-Path: <linux-kernel+bounces-848126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0284ABCC96C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9D2C3C4EAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917EA28506D;
	Fri, 10 Oct 2025 10:44:16 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD2285040
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760093056; cv=none; b=B75Npe2IjaUCjndQx1uyfqZ/rno3K9SE4zvrXLl+75j2gDyEq9Yfz3NOd9PLpWkpnJ7ZvIhRqX58UPmoAXUAxGPSgvHfIUxq4LCHPxqmyEoQmSHBl46WfevIHX0h4/TE2bUo+4PRnz5bZtYIk6nmRV1L2GqEmGx8AXYOpRxvcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760093056; c=relaxed/simple;
	bh=Xv8vfELqxCi0M3JUv12/9oo5sF3vO6GI19h00ESuh1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jBQOUxDjTOuMW7tJs9AkPLMCe8ado8ANycsSqiBS9pBNbpDyTzZpYEZy9iMjOOeDb46SwI9GGNmb7di16Fq9pz360XUXS3B7oOR29n4ZwWDSEoSmv92SK+mzdHfD4AUtZ5gosoNv235NuMSfjzYlj8BUrzvk2/tJiJaH/hcHXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78ead12so324875466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 03:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760093052; x=1760697852;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hjZQiho0iGA/YlIfjvASm46/AFyTuFHZ48K45pFHug=;
        b=YT4Wta+BI3S/SVrrb4obcfIO/2bRsjdD3ALohq1wXPsqjHAvkH0zsytU9gMtIANyKQ
         jYZmOyKxTwjmox7tVejjFMZ5OAWMXxS3JCTzHpc9RKeEaox1b5XWfKAmTTbkW9NkhcVD
         w+5WkVqOBekA1ARUv6wPP4b1rH2LkmWVJA7HNFbux4QILimvfQK766ZDjEJoANDrNrta
         BNcwSaHqM/NY1tnAADXWKV0jmeHb6nACboczoZfg9BtsoxktgZnRnQKmSEDqv9+3EKGS
         GtE3NSmh39O3M4SEmhStomS4JA1nlLJRoAPmppuykahFh9xpSbr6j4ysfAU5jJchJlZ/
         VlHg==
X-Forwarded-Encrypted: i=1; AJvYcCWMxQckz6zTrpUEIElt3y8oM1grMWHT34dlMntOIKDw7YmG0e3oaLBotUFlVkJKlAjWsI83Pj8WrOSd5Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PcJ27994bSsCzCCVXDpQfBu1HxQy3CN/IPnBaBs83cyQq+nT
	CSjjs0UueYhXh3l9DV5TvW7zXZ9kTzzfE8ccXuaxVaN4CGVWbNsedU63tlJPSg==
X-Gm-Gg: ASbGnctBCbbYRu42iPvyAaTGKPSGOIaKrjSOwrP10H/e5T/HB+RmyQFUFhMORhoII7n
	eU7pQUvLufCql1uLqZLpuJueglg54V4h+lBSmr6V1CBlf7nNnsWLcyNciE6KghA0JeQA3d/OhIh
	Ri/NQIlWmYJnKTaGjXGCLd1GdWlFRr/2BQWvdN3RnL9itwK/GamI5JGWcdrITqwa6AzFjyLHe+6
	5UoJpSgKLAJKmEy6MQUNUg2RS5VV9bmY8+yZDoUDmY8i2FrgoS7xC/A3bztFrAOrs4FPj4FrGn8
	BO9JN4VQ596YCTey2RSc5NYv0RDa4A8TcBfB5qE89QCyzqcxoDDxnFovWCA1xpuN4fA4JWjD+UF
	roTurp30LbURgXClHv2vVBhCNEd/bt4wLuWuC
X-Google-Smtp-Source: AGHT+IHEr3FgoOnkzJSJ3QXTjdVVTT0W9OMbIhq6GsugiZh5aafP9iMGPMQXEE4tmD+zXgXWqXCs1Q==
X-Received: by 2002:a17:907:3f14:b0:b41:3c27:e3ca with SMTP id a640c23a62f3a-b50aa4909admr1122902966b.7.1760093051867;
        Fri, 10 Oct 2025 03:44:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d9525bdesm201931466b.78.2025.10.10.03.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:44:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 10 Oct 2025 03:44:04 -0700
Subject: [PATCH v3] efi/memattr: Convert efi_memattr_init() return type to
 void
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-efi_fw_bug-v3-1-78259db0f39a@debian.org>
X-B4-Tracking: v=1; b=H4sIAHTj6GgC/23MQQ6CMBBA0as0s6ZmpkK1rLyHMaSFKXQDptWqI
 dzdwMKExO1P/pshcQycoBYzRM4hhWmEWhwLAe1gx55l6KAWoFBVSKgl+9D4V+OevVROKza2pLM
 xUAi4R/bhvWHXWyFgCOkxxc9mZ1rrXyaTRIlkz+xKdJ7dpWMX7HiYYg+rk9XvJSTcvUqS1OSUo
 apr+aR377IsXynJKK/hAAAA
X-Change-ID: 20250106-efi_fw_bug-2b62e9a41899
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=leitao@debian.org;
 h=from:subject:message-id; bh=Xv8vfELqxCi0M3JUv12/9oo5sF3vO6GI19h00ESuh1U=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBo6ON6W6e3C/Qe3WoG1ip9wiq+lAK/++yi87Kr+
 y9kz1yoRvaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaOjjegAKCRA1o5Of/Hh3
 bQtSEACdpPEJKfBod/cJDK5qm/LcmMRN9hfEyG2qJHSEvRQ/tsM2RGAdgf74izCo3sPyNcne3zK
 IvzZ6GTwDOuQgHLKA5J9oQc8KBh+gSB3AVNP8mnNekhytbpzfEh62Yfx3gLBpDVUVGQz8WZyRg+
 e9LY32dEjrY/AmoBd9LtgFz04IPwF2Kjs/FbPta1KrEEsRa4HmrXRTMaGQ8n1hlOTbd7FwA3VQf
 p/ap0mpfWXvYKxwZVWnJsV2JdQDsnntebB/mHFuuDvU2jeC0ooG1YGlLgCwim+btY1k2L6nwYJj
 qupDG15x+TbW+e42cnJtvewYpJp4WE6uKBuTn42aWfXlUVLCdFjQEGU4vjm8oVvX9/XcwysePfd
 bWQl0L6guEhVaEq2WNu0++kfjw4v/krQj0RFrJ9ez2VMhMQLF8bzgqyP1vck/fk1GTJVXcSH7XI
 74E7r2Vqabp28EQEl4OkThZQuAjUcFqyhR4s2otISjIlcqrwD+hZitx9v0WMYISRsSCOY5nvJNA
 ivSbRUe3xW3UHrW9u2U23lU21E9LFpkwDwgGbxnEwpYUVAZMvg67unYmcWjIYJ05Wloy0shtKcy
 VrAV3TfUNMNqaXy7dtzBuur59i4tjszJ5NvC43Kn9JD1R4pHaVLNn2OG/HWKtKFTtMIWukGKgha
 qspb2Hn1QkxEfBw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

The efi_memattr_init() function's return values (0 and -ENOMEM) are never
checked by callers. Convert the function to return void since the return
status is unused.

Signed-off-by: Breno Leitao <leitao@debian.org>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
Changes in v3:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v2: https://lore.kernel.org/r/20251010-efi_fw_bug-v2-1-61b2915dce76@debian.org

Changes in v2:
- drop the other patches from the previous patchset
- Link to v1: https://lore.kernel.org/r/20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org
---
 drivers/firmware/efi/memattr.c | 7 +++----
 include/linux/efi.h            | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index c38b1a335590d..e727cc5909cb6 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -19,19 +19,19 @@ unsigned long __ro_after_init efi_mem_attr_table = EFI_INVALID_TABLE_ADDR;
  * Reserve the memory associated with the Memory Attributes configuration
  * table, if it exists.
  */
-int __init efi_memattr_init(void)
+void __init efi_memattr_init(void)
 {
 	efi_memory_attributes_table_t *tbl;
 	unsigned long size;
 
 	if (efi_mem_attr_table == EFI_INVALID_TABLE_ADDR)
-		return 0;
+		return;
 
 	tbl = early_memremap(efi_mem_attr_table, sizeof(*tbl));
 	if (!tbl) {
 		pr_err("Failed to map EFI Memory Attributes table @ 0x%lx\n",
 		       efi_mem_attr_table);
-		return -ENOMEM;
+		return;
 	}
 
 	if (tbl->version > 2) {
@@ -61,7 +61,6 @@ int __init efi_memattr_init(void)
 
 unmap:
 	early_memunmap(tbl, sizeof(*tbl));
-	return 0;
 }
 
 /*
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a98cc39e7aaa8..0b9eb3d2ff977 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -772,7 +772,7 @@ extern unsigned long efi_mem_attr_table;
  */
 typedef int (*efi_memattr_perm_setter)(struct mm_struct *, efi_memory_desc_t *, bool);
 
-extern int efi_memattr_init(void);
+extern void efi_memattr_init(void);
 extern int efi_memattr_apply_permissions(struct mm_struct *mm,
 					 efi_memattr_perm_setter fn);
 

---
base-commit: 18a7e218cfcdca6666e1f7356533e4c988780b57
change-id: 20250106-efi_fw_bug-2b62e9a41899

Best regards,
--  
Breno Leitao <leitao@debian.org>


