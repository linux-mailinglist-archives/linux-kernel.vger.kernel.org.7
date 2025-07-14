Return-Path: <linux-kernel+bounces-729851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F56B03C75
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387BC17E896
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C19F24501B;
	Mon, 14 Jul 2025 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgqmwbzQ"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A42245031;
	Mon, 14 Jul 2025 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489940; cv=none; b=OtskPGmD6Q3+5Z36/fJm6Kb2z5V3vw0szMSPmETuzPb1yIgAXbj0eGe0OHiQ6mnu0OTBm1bfpugvXYHHKEDJECXW5UYVfa4DQ3W+9Me2JuMMuqyLwBqBQDobATudwXAq04Q4Cr3QPYJRtm1YuTYi/cf0LXr93rUMC1QQn52HLXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489940; c=relaxed/simple;
	bh=A0n1K69FmhDGVMxgGpbk87aEUh5l75kmd7WrE1t4wLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emIoGljAyGMGAaI8hH3CkRDL2SVIECtP5MAqdP5QgKdAYxWVMa8/eLcR2MazzEagqwYUb6qRwFSorVcABZbzMTo5wonn4QoAvKwLtmamSI3w7b54/DPUctq8qfMgRZISN5QXGAhpvxNIjQS+tR3R1ZrmKO51wC0kMnPth+FK7wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgqmwbzQ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso4351679b3a.2;
        Mon, 14 Jul 2025 03:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752489935; x=1753094735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ew3z3tT1Iqc1DaqYrhCVfFfwHfKONsa2dCPq/VLPSGE=;
        b=IgqmwbzQIizqFhv1BvLeAe9RsqRdkP6pnKnhh2JJRTOXUcKxVyenLKMP0oCSnAK425
         FMCYT1gLolEaPeQ6nRvuYUOQYydCU5TUwBSWE7LkZRK79c6C/slr5ZKnGPHim4jDTakn
         OCb4Pbu1sFCwGgixw38YZ3e5mC/NeeiJdo1LKbt6a7MSPvNXcZdkUkessfuVvqvCmC9l
         CM7tB5L98UAMAHulSfW89zKxoWByMAO77eUZFKX5rpTUZhln0OGgtwYZPmz6AQQWgQqy
         YZ2E8GWIxGT9exp1qdD+3DvzBGbWYw0E8rN7RsIulzlgPAvDu1etHRIgZcrbOGTEFe/A
         /v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489935; x=1753094735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ew3z3tT1Iqc1DaqYrhCVfFfwHfKONsa2dCPq/VLPSGE=;
        b=wJrcG2cH0Iek4vJQA/0vjaK/onQ0YQSF0hc7/1j+x5aGF76wqGsZ05b2gCVVTwnw8d
         JjHc4sJ/bo33b6AvfCTHc+rk1ruvGd+LoOfbGloAiseBTbK4Mek/cHL05DjCVda1TIVT
         c4OkHxtJ/r/DVhTSttz9QoSAlwukHdl/wOisI/0Zdpf8FxvLqHO5pEX1CHb4ev5P33k3
         9b6U4GGmiiGIcYmDGuE1ez3FWpyWucdUP3bdqugyHiCW++k3TvCOiLDZft4eF9DTykMz
         078V3ZDQR81e0Wt5l54gt0bCId4K0XiWgn0psSzTN5U4ZX1RzOHpcOgpAsFmsyf57jtA
         AQHw==
X-Forwarded-Encrypted: i=1; AJvYcCUWnldvFstUswmRG0qLw8dDB14J9fPZ8vJZY9het3Avl54BeW9FYpRD+WrBgk1t3KI6BurHxKlqixPZT78=@vger.kernel.org, AJvYcCWG3byUEAVKtrfMkUYVqXu0MEq8SnE22rcCktxUtiR9IZl7wgPPcVEx+IHXY/TPINUIMea3VRTkdqJxRa/da6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRo9V7cMToNHP5TEHp1T4DT8ER659l+a7Yt2KRvpjhMjvqEJD6
	S/E0RdeHVgmnkshR77fOZ4v2VMS2wjGrKO4x0l/ihSfzaoPDKBCUIhBQ
X-Gm-Gg: ASbGncsYMiIWC3MCNORyc0ek+DZsIjz9X3oleY10WQlpbeHs3GeR+4xWyBy0evZ2Rjr
	03VAuUT9u5xdBogS5A2lmBgNZYoA1KaNweCppKS+NG88NI0ziuPDVpGawRt2hvmsjbDu0uEhr7C
	UC77Tp0hvUzkhGAO7ThSPxha42NtK9mdzoqnYeEc7oywch300q0bGTq/7PM40NUc7SzedOj/BcU
	lRr6sYvOBHXhRWJOK3xt/g8nnN7HM1Mk2xohQYxk2m6OBrsx6O/4bU4Ua5hpQH4I4FXuy/uw6Iq
	V4N8eBGJmj2kVeCWyWaaGb6rADHvV6l+ecH7hxI7YOJNZlypQETSY3pc7T90Tl4Jv3eRv7VNc/l
	oCt/qvkda6CMzaQffyJSYrIOY
X-Google-Smtp-Source: AGHT+IHPYYr30tbc+ztqYQvY2Rm0RrK+nh/L+wMF4ZiTUbfKfx+mQjBJD6fZBwNC0fwr8N+K5R84jQ==
X-Received: by 2002:a05:6a20:2d23:b0:215:d611:5d9b with SMTP id adf61e73a8af0-2311d95ce85mr18201600637.12.1752489935443;
        Mon, 14 Jul 2025 03:45:35 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e058fesm10320909b3a.40.2025.07.14.03.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:45:35 -0700 (PDT)
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
Subject: [PATCH] gpu: nova-core: vbios: split out PmuLookupTableHeader from PmuLookupTable
Date: Mon, 14 Jul 2025 03:43:13 -0700
Message-ID: <20250714104322.100511-2-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714104322.100511-1-krakow20@gmail.com>
References: <20250714104322.100511-1-krakow20@gmail.com>
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
index 663fc50e8b66..20011c5c9bbc 100644
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

base-commit: 215a3f91713383a3c0d2da82d223a608a3c17ac1
-- 
2.50.1


