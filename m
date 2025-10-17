Return-Path: <linux-kernel+bounces-858679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E61ABEB67A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE90F4F297C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957B22A7E2;
	Fri, 17 Oct 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZUGZXyDf"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3392FABE8
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730410; cv=none; b=akQFwX53SPBMv3c3zHPqGQwydUgk3POEeQt/COEkikkYs/k7gg4/dJIQucSaflM0JdmJuxKqGlJ5exmXeiuRG4KP1KD4bpOp4i9YQ0F11oG9kFrM/dN2MfZtm8VL+rawqd3g7+eDvysbvEbIZVcY/ruG00hJ6TSqvPUwRMZi+f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730410; c=relaxed/simple;
	bh=N2xCTkyeUBvL1UCxXbUEbTbI7HxLvTjzO83pqQw4Ffo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ArLr3BNXQyXEZdnwRWiK5nFi1VtgwDvOFWeaswv9FaR7qtGz1CBBr+XGXpTONUaNZOOz8H1XIGE1Js5iD6dSH3ACX1CNKTGa17aNAz0A0VKzthZAcLoNhyzKy8asqRhGx4h1vyTUIRmDgTma1ErTgD8OqL8ZRUS00QfKDwzWXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ryanneph.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZUGZXyDf; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ryanneph.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b55283ff3fcso1576551a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760730408; x=1761335208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xS2W6P9O/5R7omuKwloPAtjlYNdoghzDYUggMIQ8atg=;
        b=ZUGZXyDfZKdf1YSJ8WJzLrBhHVbvSqgZ7d4XxrDxND0DOrGCxFq2I+O2CgrnzryMJs
         eJ9trq6TsIHi9qHVuNGyy+XxnaPN0JZHDp43PGcO6nV41SbXg5Qwm9+v5BJSIteCkj2F
         OSraeJlAGQ3K6yGdrf39QaNfk6QZ+05eCsgsEv1kO7Nvp6XcTj1UbsDdj/7r7T5b3q77
         guVxopMMxePoAxye/UlW+8ScLdavLgPzFPhy6VVHyJHZGdAuMR9cABXq7FnjmdE6Epp4
         WFlRg4DNEB2pfCl9/KXn06NQQpdADMnI0z9g5czXuQdwioCrFN/Q0KDeeHGcvB/Kk5jc
         4WMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760730408; x=1761335208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xS2W6P9O/5R7omuKwloPAtjlYNdoghzDYUggMIQ8atg=;
        b=dpBMxibQz9LAa1kpEDT19csWUa9rQZQATOtfFtuCU8KSHk3lf2gvs2jIcC0XYS6Tgf
         95YC3Jig2q4MiwHFXId8Vl5f8PIYLdDAK247TrGj+IhAEyseHIO/JHTDC1mueCPDEHyN
         RCOR8gIBNHJdx7Y8JNnAUoAdI4xDJLRNhSCQwpcjkjzHGcMovVNmxi3Ccrsfdg4Bn3aN
         zgzSZDKSAq4ydBhUAIe4H7szHtsvKltcnF1eb5Yej2ZL5J9qjoUT6RYi7HDhXuoJp6YW
         cFpmOe2TLoZ08VHpWCpwd0DFE5f4R6te6WhYvM/CNdwFKOsRvsyVsziHLjCgvlGdRVPo
         6FdA==
X-Forwarded-Encrypted: i=1; AJvYcCV8UeIXTk07rM2QESsbXGzhqW+2fLYUlMTOh/p1PAPhIVU+VfzckE23PxkWOyLS5WMi1zgw4AIqLQhNSTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLUwpbdpN/RWG9YbCFqt8VHdJ6f01VHNeHe0VZEAtbmX89UUh
	0Wj/pSozolVv4sSn99g9053fjH6hFlMAX6OIfxQ40X+GQN1/GoaRJztXrPJMLsTVzpolnrJUXqw
	dYGm7G4sfOhpMfA==
X-Google-Smtp-Source: AGHT+IG197iQnjLRwxm4Jsr79MNCmECX5CThjh1rAaLaU6FbEdeCp16Ft8ibFhXM75nEK5W0bGciB8r1G/DnEA==
X-Received: from pjbqd7.prod.google.com ([2002:a17:90b:3cc7:b0:32d:69b3:b7b0])
 (user=ryanneph job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2d8f:b0:339:d1f0:c751 with SMTP id 98e67ed59e1d1-33bcf8fa5b4mr5593940a91.27.1760730408212;
 Fri, 17 Oct 2025 12:46:48 -0700 (PDT)
Date: Fri, 17 Oct 2025 12:46:26 -0700
In-Reply-To: <20251017-rn-cfi-v1-0-bf66e6ad4fcd@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017-rn-cfi-v1-0-bf66e6ad4fcd@google.com>
X-Developer-Key: i=ryanneph@google.com; a=openpgp; fpr=10046FDF459A0F9DD68C9C04313B8636EEDD116A
X-Developer-Signature: v=1; a=openpgp-sha256; l=2508; i=ryanneph@google.com;
 h=from:subject:message-id; bh=N2xCTkyeUBvL1UCxXbUEbTbI7HxLvTjzO83pqQw4Ffo=;
 b=owEBbQKS/ZANAwAKATE7hjbu3RFqAcsmYgBo8p0gYtAv+VXf0NjAMtfz+GBELlf52U7mq1Lal
 cyMybzMyaeJAjMEAAEKAB0WIQQQBG/fRZoPndaMnAQxO4Y27t0RagUCaPKdIAAKCRAxO4Y27t0R
 algQEACVzGzvQW0Y+/Tn76eydGWkFLIWx7CLY8LPicenn3OBnTMHbIJ+EkrButmJDC+dQrZ3p6T
 EwneLQwW3cpJNbD6NewOWPKf6sww9snnB7CGzWs4kzDgiExl3FL8qsGqNZLUYxjvoP86QoZTtd3
 zjGLmLOKcsGl0APYHQC27Fs1qJ38KiPJZ9Wp4pmcTy6BoCt7RfgYxTTlBt66T43cYWFVpwUk4ct
 csijQX9LfnLchMYLg1GZy1LskiXp93QOihNL61MOo5d2zWUGzd7yZl/BU6AwrsAuF8Am0vtW+Lq
 g17aZy74mynAvNlMJI8HLyEW2KYLR/2q9n278tGuq3hXJBMKOzKMlKv0/oaF5PnJzsq1Au3Cy1W
 KWqOEm0UzR6D37kGpxVuO0T4qKC6kPoEKC66mK6RNvC/l1yJz1WTAxCGsZdy/ScZ/MExnAMFRbE
 S+HqQ4Wwk5X9sXFtkcodxR0iPOk9derf048wY4UfL0GME0nNvSkv+GOxFFtDHoujZR7H2eCilmK
 wbX12StzHyMbtvNRY8c+SuONOHJx3Ga333k2a9xjbnlslIwnp4xzuHrg5Da8kJCrs9xsHUrOtph
 ERma71qJICY9Dvjwc3QKjLuSJXO7nBOezN536Ha2e8NZ/nHgcJOnM9f7hnQY6HuFzQehpopUh6q sx2oMk6mZMsRvpw==
X-Mailer: b4 0.14.2
Message-ID: <20251017-rn-cfi-v1-2-bf66e6ad4fcd@google.com>
Subject: [PATCH 2/2] drm/xe/configfs: fix clang warnings for missing parameter name
From: Ryan Neph <ryanneph@google.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
	"=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Ryan Neph <ryanneph@google.com>
Content-Type: text/plain; charset="utf-8"

Fixes warning from clang-17 that look like:

drivers/gpu/drm/xe/xe_configfs.h:35:97: error: omitting the parameter name in a function definition is a C2x extension [-Werror,-Wc2x-extensions]
   35 | static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,

Signed-off-by: Ryan Neph <ryanneph@google.com>
---
 drivers/gpu/drm/xe/xe_configfs.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
index fed57be0b90e146d57d966bab0e55e1723513997..a0d614b37efd54b89390f04a238aef1a8d4df4e2 100644
--- a/drivers/gpu/drm/xe/xe_configfs.h
+++ b/drivers/gpu/drm/xe/xe_configfs.h
@@ -21,9 +21,9 @@ bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev);
 bool xe_configfs_media_gt_allowed(struct pci_dev *pdev);
 u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev);
 bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev);
-u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
+u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class class,
 				       const u32 **cs);
-u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
+u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class class,
 					const u32 **cs);
 #ifdef CONFIG_PCI_IOV
 unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
@@ -37,9 +37,11 @@ static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return
 static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
 static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
 static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
-static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev, enum xe_engine_class,
+static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
+						     enum xe_engine_class class,
 						     const u32 **cs) { return 0; }
-static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev, enum xe_engine_class,
+static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
+						      enum xe_engine_class class,
 						      const u32 **cs) { return 0; }
 static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev) { return UINT_MAX; }
 #endif

-- 
2.51.0.858.gf9c4a03a3a-goog


