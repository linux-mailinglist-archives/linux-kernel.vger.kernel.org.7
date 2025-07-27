Return-Path: <linux-kernel+bounces-747030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6CBB12EE0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA7518981E8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2FA201266;
	Sun, 27 Jul 2025 09:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7mqAuv/"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E63171C9;
	Sun, 27 Jul 2025 09:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753609876; cv=none; b=Pog4ZgKOf/bLSvFUlZ/CYhFTHqPxO66nzl/C+vu0ZKa+loHjSqpJhhKM+9xxlZNinIjuZBkaq8f0JnU00FA0V2tIt8sr6LQF29DjjU9ty8JuSynXTTBzPm+DWnKCbVLsU2StmtsiQ0l/AAr4G1RKp3iFSyzSEFzyf9jMiTp6H6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753609876; c=relaxed/simple;
	bh=xKwJvXxWrDpppiWK/6VTWyH419R6C+6Ux5gNQMAFS8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UhHl7Ymhbgsi0EuE4qU2t2JbPY4zY13NRoEpdiVW6/8W+IT1RIshJFsF2jb9L4+LpOY3mv8Xh9YMfVuWdygQ9n3MoN2qEGtcsUSZ0NaByXmM5PuLvxzGnnirMYokNG5pQNLelAwglgD9ajbl2bEQmR17fCfg8wZrhxV491GCXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7mqAuv/; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so4378650a12.3;
        Sun, 27 Jul 2025 02:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753609874; x=1754214674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t1kXiH/iOIPgD/M4/LDkpVx0cWkoY7aI0S+hOevU85Y=;
        b=b7mqAuv/Ry15MhAgUCU29NACg6GfuIgh9Jz7gFBzKOT7l8d4CSmqSaL0wreS3jgFBP
         p8OVTHqvsmMbyZjVwlP/A4b0QTu3y5zZb0IghLuG8HPLWk4GYLx8WFEtpT/cRigk35Xo
         cxY+ndM7NwNHdEz0YqjT9tUnP6LYz/MO0Gs32PRyxBs2Ey8PNlpPdiCfOetbcx728J4e
         533su3jjpk+2cDpekmvfgeHsVVn5msqVwva4A2fukeDf5Z68TI6nQ9zygnBg1f098MCt
         DINt3263HHUkfUZeuINZZRTLVGc4mtXrarWJ6F29aok62N059jQ8kNdSaoYYL0QpGe3/
         tOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753609874; x=1754214674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t1kXiH/iOIPgD/M4/LDkpVx0cWkoY7aI0S+hOevU85Y=;
        b=NDBdNLUezDGYzUmAcwY4mLZytoKi+CAvCF8gr1vLQKIIG2zDr0VfpOMydHl8PemZLo
         HQjnyzelzFur39IBKPpmySkRNn9bQD4+jqHSadbo+C6RxtEuvptBs+5GEF1Lw0jpiCYW
         j5nXdWcYj6Yq20O//y+MJhE7osUz9NtN9jX8HGpDeE8Kk5HcGO7i+kALAiOgNn1Rk/fo
         M94/3DTgaG/dtnlZFl03hneBMekK6/XtJy/24cfSPfOUOW7xfcDDzdqcy7IeKlYVR/Px
         XqgvExTEhoXcxXQk2Zwdbc7o9gqQujNiwiqQIeoGXmavuGSgmvGfR23Tn8bfnB6bRlmh
         kq0w==
X-Forwarded-Encrypted: i=1; AJvYcCWaleWS236hXg1L6VlFY3By2vV0HgOwZYjC2ew/Tcr+6vt11pM52D2hWzeudB+yGDwWCwHm0XvvEWax0QOQkIk=@vger.kernel.org, AJvYcCXBEVQIgs8wftMIa7eK6ziU+AzE6LmnXA6uxlYgOoF6LDqEI6rZRuCXBUh2gMc+iKdj6sCHvlkmHgOuphk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUvZ/xz7o0H6/Cubdoa/4c8v1a2A5Ao+ZgxGyE0k90KQYWKO/m
	62Pi2tLVOj/x/6tZ99ze2HVHGXG3v1SsM4uKHf0/TyhIKEIDDEpCXkHq
X-Gm-Gg: ASbGncs24eZgNFq8AbWqitn93GriN6KeqUiZCgc0BJ+dOqrULuOznaoPc3K1FYCsYAp
	glge8a9x6ZB98D+T8bkYR0DAMISgrS5jfTloI2/YDrGkFW/fRjOa856NsngMx7tSufwkgYwcYt0
	SxYAMHfUq3uqlBHRXTYQ/jX/5yzzFZPNZCtI9quMtOEdpyP4D4kNh/YE8HgBh/7+2Dm1r8l3FcK
	dbWMVjcPD4ekg56uo6Ed86uRCyCKzrcTOyWDbse9c892C0Igumhi+zmwljaz7RM3O4xu1gxFc1E
	kvaAMf+BE+jOrrl/U8/PjJY2+nKNR/RLcBV3HYI7vGzp3x1Yq/J4DbQqDAIjMnTxJdpb6EEQsTl
	HxOy3HMBCsvd82XXV7qXqT4wi
X-Google-Smtp-Source: AGHT+IHAGa1LiA4U0ZjULerVSzNUQ9qnTdRAU1E1dly2dZnZK61QY6vXTJDFJnRt1D8ULLgYMQEINA==
X-Received: by 2002:a17:90b:224d:b0:31c:c085:fde6 with SMTP id 98e67ed59e1d1-31e77636196mr14021956a91.0.1753609873917;
        Sun, 27 Jul 2025 02:51:13 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ea8c1770dsm2012652a91.36.2025.07.27.02.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 02:51:13 -0700 (PDT)
From: Rhys Lloyd <krakow20@gmail.com>
To: acourbot@nvidia.com,
	dakr@kernel.org
Cc: Rhys Lloyd <krakow20@gmail.com>,
	rust-for-linux@vger.kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] gpu: nova-core: vbios: split out PmuLookupTableHeader from PmuLookupTable
Date: Sun, 27 Jul 2025 02:48:59 -0700
Message-ID: <20250727094903.20483-1-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separating the header allows the use of `size_of::<PmuLookupTableHeader>()`
instead of the magic number 4.

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
 drivers/gpu/nova-core/vbios.rs | 56 +++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5b5d9f38cbb3..a77d7a4c8595 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -889,6 +889,32 @@ fn try_from(base: BiosImageBase) -> Result<Self> {
     }
 }
 
+/// The [`PmuLookupTableHeader`] structure is header information for [`PmuLookupTable`].
+///
+/// See the [`PmuLookupTable`] description for more information.
+#[expect(dead_code)]
+struct PmuLookupTableHeader {
+    version: u8,
+    header_len: u8,
+    entry_len: u8,
+    entry_count: u8,
+}
+
+impl PmuLookupTableHeader {
+    fn new(data: &[u8]) -> Result<Self> {
+        if data.len() < core::mem::size_of::<Self>() {
+            return Err(EINVAL);
+        }
+
+        Ok(PmuLookupTableHeader {
+            version: data[0],
+            header_len: data[1],
+            entry_len: data[2],
+            entry_count: data[3],
+        })
+    }
+}
+
 /// The [`PmuLookupTableEntry`] structure is a single entry in the [`PmuLookupTable`].
 ///
 /// See the [`PmuLookupTable`] description for more information.
@@ -918,24 +944,18 @@ fn new(data: &[u8]) -> Result<Self> {
 ///
 /// The table of entries is pointed to by the falcon data pointer in the BIT table, and is used to
 /// locate the Falcon Ucode.
-#[expect(dead_code)]
 struct PmuLookupTable {
-    version: u8,
-    header_len: u8,
-    entry_len: u8,
-    entry_count: u8,
+    header: PmuLookupTableHeader,
     table_data: KVec<u8>,
 }
 
 impl PmuLookupTable {
     fn new(pdev: &pci::Device, data: &[u8]) -> Result<Self> {
-        if data.len() < 4 {
-            return Err(EINVAL);
-        }
+        let header = PmuLookupTableHeader::new(data)?;
 
-        let header_len = data[1] as usize;
-        let entry_len = data[2] as usize;
-        let entry_count = data[3] as usize;
+        let header_len = header.header_len as usize;
+        let entry_len = header.entry_len as usize;
+        let entry_count = header.entry_count as usize;
 
         let required_bytes = header_len + (entry_count * entry_len);
 
@@ -963,27 +983,21 @@ fn new(pdev: &pci::Device, data: &[u8]) -> Result<Self> {
             );
         }
 
-        Ok(PmuLookupTable {
-            version: data[0],
-            header_len: header_len as u8,
-            entry_len: entry_len as u8,
-            entry_count: entry_count as u8,
-            table_data,
-        })
+        Ok(PmuLookupTable { header, table_data })
     }
 
     fn lookup_index(&self, idx: u8) -> Result<PmuLookupTableEntry> {
-        if idx >= self.entry_count {
+        if idx >= self.header.entry_count {
             return Err(EINVAL);
         }
 
-        let index = (idx as usize) * self.entry_len as usize;
+        let index = (idx as usize) * self.header.entry_len as usize;
         PmuLookupTableEntry::new(&self.table_data[index..])
     }
 
     // find entry by type value
     fn find_entry_by_type(&self, entry_type: u8) -> Result<PmuLookupTableEntry> {
-        for i in 0..self.entry_count {
+        for i in 0..self.header.entry_count {
             let entry = self.lookup_index(i)?;
             if entry.application_id == entry_type {
                 return Ok(entry);

base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
-- 
2.50.1


