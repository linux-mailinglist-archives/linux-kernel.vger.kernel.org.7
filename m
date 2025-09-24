Return-Path: <linux-kernel+bounces-830330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15D9B9969B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611BF4A3840
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2B2DE701;
	Wed, 24 Sep 2025 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvdHD7ii"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22A2DE1FE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709382; cv=none; b=SiH/MskqDrpbC0fgEIuYBPYLDOzjwh1ko2k2oXlYlGPUcX6t6qFZ/+TyHs4a9IZ08jWmfw+xOt30AaMkHzHHpybzwX2IlGoPRKKGfW/lHjVtryHBmhXJ7rlCNB+h4Ma+7LRHN3aGokGUAn9+z+U+u3IKzsmhOm3aApb3VTin5+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709382; c=relaxed/simple;
	bh=70m8hIHxbgOeHMiX7Op2kXSoJJya+09jCQ+CrFquVZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlC+cbJJQ4+wwfZ2kj8eyBaYHCrkeu18MQdWnl8ylQLwj0U1j1Xj1ykfT40Rh1e/Uplzw5IfQnryKyhlS4UOjtuxUcgK4uVT3oxUrt6iMhn8+BFqhoemyuDau6JvmRT1jN5DnR4Ov/WcgPjkaaLcwXmfVlSlhcF7idR+K6fbWAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvdHD7ii; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e1bc8ffa1so21380015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758709379; x=1759314179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2SZhlVPPd52n7ONt3JZoUJyYMwjtJvsP+AyT6HZcYJQ=;
        b=PvdHD7iiom+tbN5R71tFRPm6867+xfycSFIQvMU+rQJDnpGwKk/qIaGTEEBTFmDrnP
         NRz0t1IGZRMcVkteykENOWj3u2GCNFnzscORO8lCbJYn0MvdGR23OhmddtyJ/yAqqerX
         D8K0GAowA9q3MfwiZX4BzhHT6qFJM/weg9jpAKXzd2cDEaChyutJ6VlJo+uzEHXnT792
         7UtWLXk+FbmGdFpATlAQyI53a3GGxPyFQ+Rz13ZvGYxjbxlK41ScNadHxabKB5jigzPA
         Zy5slThkOoFxaeo2UXVut+I/hUiE47XiAkHuc7eBTbJzuwioVvQIlRIJA5lyrsv1bHFT
         1QXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758709379; x=1759314179;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SZhlVPPd52n7ONt3JZoUJyYMwjtJvsP+AyT6HZcYJQ=;
        b=iqT6reMSNHQNhi8XQaHPYy4yYRYsd+rB+BlJHPhSZ5LTIUbO0CehDD1LUQzd2GXGdy
         QgkHnd7l3Jq3JADKN3m4xzL4bseMYlcTWkTSB9Jjan2Y5uFADEc7cE6zpvtzrCuduLrD
         2oJL8BrYqH+c6Zwr5M/egmgCMeHC1iWJmFRP5Jf4+k++Y+6K/4WziTkdtsBN3vQ7pUBr
         uTa3456qsQlEHo4WMiHjVYJF3LH/jNiEAkQdtJmAVBtyuoCOuzJxsg6VhALJLtldc5gV
         GYnYO981wRov07gyX37+4P50CRPSvyeIUNgbjC0pB5gZyDWm6/HDBMauygLhHHS2Kuy6
         Lh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdqfKvR5FK32oJSlM8JOY4ts7mhgFEliOzpOT6py/M2KTJIZ99HE5wmdmtp+NZraefz8udlk+ZoxzFqi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykHiLkOFTDcdrYxiRT+XvZZYYCMXX+QMRgaWGFqKrGXLsvorRK
	0S4WDHZuKGq5aniojEdXeVKxyMteuIN7JdydX6IEj5Ou6xYSavlUBYoqVVZWJbr1bcA=
X-Gm-Gg: ASbGncu+stRbDaEXxTXK87iD9BvCrThUNr1ndVr6HqvGAadc1ARTmhtE9XWoufIMwM6
	e6q9b1ah4XQWICOq5gveD587kCSD/WPoC2pixQJIwfOBjnR8cW3Gpn2FrAwQ1veXYxArHqV4A84
	F0BcCyuX8rcYYQ8N0LPctuu/s5TlHB5W0K3q5clpjPz+UWxjUicwG4j7qbloEFd3K1n3YuWQw2q
	JDAk5oyE5RyoVN3b0kSnp1jD61gtaZPsIvkiRq/2KtMOVtJOa3efab5YuK+m7hR+7TmIZ3dSct2
	WhQeW1bRgl+zCPoPZHq+HlBCpBEHxmcNuIRcWV7bOrxjTtPSnCciMlUEfL2xR9TK1JOhmLFITS5
	HZZqb/B3OcQ6UF3fUdWrNmCV2BKU0a76M
X-Google-Smtp-Source: AGHT+IEaxHf/2iRwwqfoIfQ+Znhm/drcILF6bGn2vT3pOma/+G7W3dJJfRF76aIPViePMXlaIdlZhw==
X-Received: by 2002:a05:600c:1d0d:b0:46d:fd71:f69 with SMTP id 5b1f17b1804b1-46e1d988de8mr46724395e9.14.1758709378513;
        Wed, 24 Sep 2025 03:22:58 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2a9b6e1bsm29341975e9.10.2025.09.24.03.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:22:56 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] drm/xe/xe_late_bind_fw: Fix missing initialization of variable offset
Date: Wed, 24 Sep 2025 11:22:08 +0100
Message-ID: <20250924102208.9216-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable offset is not being initialized, and it is only set inside
a for-loop if entry->name is the same as manifest_entry. In the case
where it is not initialized a non-zero check on offset is potentialy checking
a bogus uninitalized value. Fix this by initializing offset to zero.

Fixes: efa29317a553 ("drm/xe/xe_late_bind_fw: Extract and print version info")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Fix identical issue in parse_lb_layout that I ommitted in the first
patch

---
 drivers/gpu/drm/xe/xe_late_bind_fw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index 38f3feb2aecd..8f5082e689dc 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -60,7 +60,7 @@ static int parse_cpd_header(struct xe_late_bind_fw *lb_fw,
 	const struct gsc_manifest_header *manifest;
 	const struct gsc_cpd_entry *entry;
 	size_t min_size = sizeof(*header);
-	u32 offset;
+	u32 offset = 0;
 	int i;
 
 	/* manifest_entry is mandatory */
@@ -116,7 +116,7 @@ static int parse_lb_layout(struct xe_late_bind_fw *lb_fw,
 	const struct csc_fpt_header *header = data;
 	const struct csc_fpt_entry *entry;
 	size_t min_size = sizeof(*header);
-	u32 offset;
+	u32 offset = 0;
 	int i;
 
 	/* fpt_entry is mandatory */
-- 
2.51.0


