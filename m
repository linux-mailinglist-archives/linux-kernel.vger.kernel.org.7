Return-Path: <linux-kernel+bounces-729882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40689B03CCF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B19716400B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 11:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C89246772;
	Mon, 14 Jul 2025 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOGz4nWl"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045081FDA94;
	Mon, 14 Jul 2025 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490971; cv=none; b=vElm8g/2IGEsSG0SLKBjccrV/9ZA/uD7/vggKGDvMmfQLnQtmfER6zI9g5a9nxq8L0hbipD8N7DeUNNx97+pOZyoJTZXi/c/kseQzzghCtuYo4uwzxrKWqHSbF/i7o1H4GPvGfqTHaIqMHdpJS42cRDgBw154HdPDPBnyNXt16s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490971; c=relaxed/simple;
	bh=CT2d4fMV9MPKMzd1upFK9VFQswonWTdXm3cXWGJ2s/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OSZzR/VGFwZfhjlMnZe6dNT6eqqOIIu5Xfj7rQNCChcyS3n7mplB6xXQBLa5V+m9rvlkbn/VggOmBr7na2OYapDnc5tclLZkqHoCP8e9WSKeLKOOR1DJhlurPlCRhxvUp+kVdjAg/kRrTTAksYjd1QJkpsnBlTrpq4/rWjNTlNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HOGz4nWl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c8a5053c2so39259725ad.1;
        Mon, 14 Jul 2025 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752490969; x=1753095769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zY2RufSpt2fWThIm+JO9PtJKALSoq3fBtnelRxK+RwU=;
        b=HOGz4nWl5GAwqmRyzovMHGqpJNc6fDntGadzsuytEmXV/YQmuugqIv13H0vBpMUwIL
         Bpd7GeOCJ8PQaBYcELERm/JxFGvj8ggUHsMxopFmKQ6FtiNsMU1hU/Lqsw1puiH5qdGB
         pNYB1hYp++GH5Fbv2BVd4JUD+uiczZWZJwGx3XSth+75lANjJ2tnvAf/2ngB/slk/OXU
         elUxGU3BUnTk7Cm3IrHnTiBM0v5S0O3oExQt09sruqrMvPVMIYvAD6F10xHOjqC49O7T
         dWLF0Jk6JQbRpM8S8BBIs5mXcgnaC3jz+WCBZSS2HIuqx7P7CRVmg6OtkHGOJI8xdK32
         YUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752490969; x=1753095769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zY2RufSpt2fWThIm+JO9PtJKALSoq3fBtnelRxK+RwU=;
        b=QbbEJqohoVPGJ8hn4PeN575I6SCpR5uwbnoMcDrTn+tCBmBQOSb4yRCyDsto8gB35g
         cqIrJD2QvfsR30HcKJA0chudeMKhmO53c2UstJ1Naerjvdz34RAOpt0KorIoESavkdzv
         RgUPAyxpBjxN1RvgLhLbaSrpdVhydSI0rnNR1JI6M1+VMyHuhKxmGIPqBo9OF0ZC1FZE
         oNQvMQChs4eRqeGM+s+NDiFiBIwzeOtsUXA3Gqj8cO4fRbKDF98rKjY5Xgf2YkKwWhaf
         TMMGPFqzTKFLHKijWtrOi6ZxD4W8B8VU+51/L1y+ly9SNPq3SPvv/WILkNt66PLZIG63
         I9dw==
X-Forwarded-Encrypted: i=1; AJvYcCV22GmD/xUDTEf7mfTEqbm+YNpzgGmI3r0eruNLRlIA7CO3zIO9ve8XUbnEh66TueNW6Ks3agrbEjIjzr4=@vger.kernel.org, AJvYcCXDrymWyjbXJtX9N1ZS2u56kvKgb7B9FL5dw7SpYpKbSdBP1XuhlQqF0o3Bn4Z9NNm4eVLth9srXEI0O7xaRFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GIPrd82qjbSyYV+ejKAMoYaY8jqGEovm2EfMrirRSGFBd+6k
	GrfZYsOagGr8J+2AGL7+veT4f3PNk6v+Kdw1Bi4wS129MSh3JPmuhAk8
X-Gm-Gg: ASbGncuxrXNZElAjOYzHnBDiAxfcIhxeF73aVdD0l5gHBD3uvwYpi+0RHTpxvm6GQmC
	Mt4EjfHaa9GqTVBMRGGz+mSKxF5Borq9+mWzRWa3Qc4INvmOOeDUSSOvPRKmKQPpqDW+rS0G/SU
	GqT3G5epbEM3AAULhPYxu82zsntaXTgTw5ghb9UnUK9h/9IdQC+NMPIlKrPvkyqJ/WoRxZ6m3I+
	QW9oN0gKP3PpnMPAgr9MUyTFbN6m8OCslsSfjhMwkVtBrbZlTFdWKfjLpTo1FY8Lyu5k5O8RRH2
	FnJcP9WDl+a73AcXYVWo+rbTQeUgpnLTSJaA6HgBVhqDVEplJ8CQyFsymho+fk6HTO2QbZZDTia
	s+Vo3H5bDw0tXjRL5n2Ps7dZ7
X-Google-Smtp-Source: AGHT+IG6MvbACALZhHxOleL2gcaqp+TEs087W9l8VZmEIwt1vhqvLmUpApCU4JU0NP+hWfxq2ez7lw==
X-Received: by 2002:a17:902:e88c:b0:238:d19:864b with SMTP id d9443c01a7336-23df093eba5mr200332105ad.41.1752490968886;
        Mon, 14 Jul 2025 04:02:48 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad2fesm95136035ad.70.2025.07.14.04.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 04:02:48 -0700 (PDT)
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
Subject: [PATCH v2] gpu: nova-core: vbios: change PmuLookupTableEntry to relax alignment
Date: Mon, 14 Jul 2025 04:02:23 -0700
Message-ID: <20250714110229.141221-1-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of the data field containing a u32 and changing the alignment,
change data to [u8; 4] and convert to u32 with a helper function.
Removes another magic number by making the struct the same size as
the data it needs to read, allowing the use of
`size_of::<PmuLookupTableEntry>()`

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
Changes in v2:
- get_data helper function renamed to data

---
 drivers/gpu/nova-core/vbios.rs | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5b5d9f38cbb3..339c66e63c7e 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -896,21 +896,26 @@ fn try_from(base: BiosImageBase) -> Result<Self> {
 struct PmuLookupTableEntry {
     application_id: u8,
     target_id: u8,
-    data: u32,
+    data: [u8; 4],
 }
 
 impl PmuLookupTableEntry {
     fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < 6 {
+        if data.len() < core::mem::size_of::<Self>() {
             return Err(EINVAL);
         }
 
         Ok(PmuLookupTableEntry {
             application_id: data[0],
             target_id: data[1],
-            data: u32::from_le_bytes(data[2..6].try_into().map_err(|_| EINVAL)?),
+            data: [data[2], data[3], data[4], data[5]],
         })
     }
+
+    /// Construct a u32 from `self.data`.
+    fn data(&self) -> u32 {
+        u32::from_le_bytes(self.data)
+    }
 }
 
 /// The [`PmuLookupTableEntry`] structure is used to find the [`PmuLookupTableEntry`] for a given
@@ -1037,7 +1042,7 @@ fn setup_falcon_data(
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
         {
             Ok(entry) => {
-                let mut ucode_offset = entry.data as usize;
+                let mut ucode_offset = entry.data() as usize;
                 ucode_offset -= pci_at_image.base.data.len();
                 if ucode_offset < first_fwsec.base.data.len() {
                     dev_err!(pdev.as_ref(), "Falcon Ucode offset not in second Fwsec.\n");

base-commit: 215a3f91713383a3c0d2da82d223a608a3c17ac1
prerequisite-patch-id: d80f92d314a0693d4c89ffb7810d9ab6990336fa
-- 
2.50.1


