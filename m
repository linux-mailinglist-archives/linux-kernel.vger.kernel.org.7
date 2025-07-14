Return-Path: <linux-kernel+bounces-729850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D620B03C76
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8239E4A3394
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3054246769;
	Mon, 14 Jul 2025 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSUQZv+q"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1325CC62;
	Mon, 14 Jul 2025 10:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489922; cv=none; b=o3LRN4Cwlk79+62YPJEw5hLIlYukwP4GMvNoMqIj1EHUpDp7K5mRMfIxReU0OueQe2/DbPUXrVMu6sGYBGrkVe6JLL5GBjEnui3hfRM0aKsO7H+JHZinli4RMsFzKzvxYzlz8Lks4XPz7znSnS+FbvCuBRb478/YK8P/z5NmGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489922; c=relaxed/simple;
	bh=IxA+Ret/XRU0Qh90r7/z00q3BJc4ZjLR64P69wpNHbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkZPo4tzhIxxytuP80RKsgTUQK77+h2TfXvlcR/9GBcAUql+BnN5rBK9tVziGZuPbs2vP4sc0XRWlv7Bf++9uMjxY6YfkFIapNLzhJl4QQiHJlIRPz0UMTMsCgXt4QBFRD0H9xrDmNWB9aYLJzwrqJiFBr4c2+LKHhxrfkBmPj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSUQZv+q; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b390d09e957so4355981a12.1;
        Mon, 14 Jul 2025 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752489920; x=1753094720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DThnUhw5TFFjYMJ6Q+QpynsJ5dmeEt17gTWIuYiMaTo=;
        b=jSUQZv+qIw2MJXe8d/V6MWJwWM5z2PYtukH315mHND/BwHj1CY3NVGe6lWlMWuaMvB
         yZr0UCiWyy0FUn1DY5Af4crYXE/IWjq6wztAwbH7OfwlpiaEnDNk42ap6uNBNpHHBeNd
         DIBXtB2A1mUHNeYF4YkbGAww5YjtlOandrjYjjgoZTvwIUrLgHsVXRz5zGm6ofHdUhD6
         34QkmDYPkmWc0a7FeY09hk8GL34sfMFleCsLghVanfKinaB26gOOylIYygZ8Ol+BXmLk
         0ETkgbGAxFKDfYJpc+xwoTfhwixAVVmexteui1qEY8mMK93LkzYTbCdbD1axEDuETneL
         cXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489920; x=1753094720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DThnUhw5TFFjYMJ6Q+QpynsJ5dmeEt17gTWIuYiMaTo=;
        b=tbecFfITU5Pdw3vL7xkS9FppRLZ/0tJhcgdlnyiTGBpOcQ+9KeDgakrfU4T4ghojhM
         IfsKbodXagAdYXyVELSW6LZWC7h3DaQ3dECSnkSeCfEQCrBK6J43qcam/J5wUXfgGyF/
         XXoJmBCDteU4M69WkkBMjaabVuTcc7LRTHKwRDxQG8u8a31fWcoGtT4xdf5vHpYAUCcc
         y5FlPbcjzAFzstNpP3b8xrPURqQlQbdeaIBysDkgAaLPcmb3WRBQTRbReIgdb9Bc7P78
         pq6k0RtZS2z6HrOFw8rooWsoO+tRFRrFx6iCS2OQGK2m4n/XCHesYJtF9GrCfkeA69vr
         lgzw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Ekm6SUNGS4m0eSR5jBY+cwoBTdkBP9QRFj1+dQzyQD1TTFUC9iPkKUMyLbnG+ZYsonJIn2g3aSfGbiq/Ow8=@vger.kernel.org, AJvYcCX63xgVEv88q1SBIb/G6tp9mVkTtzgS7xOQdm4wmranhF6unRLHdEKGkwfoLQbnC4fNlWMvjx3ojBoLtkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOHo2+M1pGEcvwLDAGzb+APvJl6eELvB/pzwH77kQPfetoKRVP
	eqIRxuTrsSTv3TJC/tokLyFDiYkqNucWxJ0WJfkmxvrteO/Q+YjqA8hG
X-Gm-Gg: ASbGncvvwuQy3ffSu+leyX6kMMKTFU3ua5StMJ+sCo9nDPfEbXthxWljP4hRfupOV3P
	wyog+KK8P54u7EpI0Tvebva1cEKtJaRlSVLP+L+C+vZftyC3Anmfh09TdMfu5Tteks3XR7Tst8S
	vf7kfgSRgYmsHZ/I9bDjD+NdO8iFwFbeYu68gvViwjdc21/g/oz8TWxsoYS3wojPLUlqSJbD+r0
	wqwTu07MV2fcebiAkoKMMto8bZo9XSk7lXqQlUdz2he7IltjM0tpqye1lfucA6aqBZmnFrGyBes
	9A4M3CNb9ORMqSLCcyjngytmf0Tqgh3GFj1DZ7w/+LXRLLexhsVMG5AzLKHMjCxtrZ1BvDJ/ha8
	S6eYNFzGxdpkym5aFKF8ET2Q4
X-Google-Smtp-Source: AGHT+IHh8nvQAWLf0IaWZQL6rQlZ7/oYqf00LH67GRlU2rIWMZm1c6jUnva8RdcSbzLdp26M/41yaA==
X-Received: by 2002:a05:6a21:3318:b0:1fa:9819:c0a5 with SMTP id adf61e73a8af0-231363657d3mr19458861637.11.1752489919804;
        Mon, 14 Jul 2025 03:45:19 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e058fesm10320909b3a.40.2025.07.14.03.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 03:45:19 -0700 (PDT)
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
Subject: [PATCH] gpu: nova-core: vbios: change PmuLookupTableEntry to relax alignment
Date: Mon, 14 Jul 2025 03:43:12 -0700
Message-ID: <20250714104322.100511-1-krakow20@gmail.com>
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
 drivers/gpu/nova-core/vbios.rs | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5b5d9f38cbb3..40244485283c 100644
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
+    fn get_data(&self) -> u32 {
+        u32::from_le_bytes(self.data)
+    }
 }
 
 /// The [`PmuLookupTableEntry`] structure is used to find the [`PmuLookupTableEntry`] for a given
@@ -1037,7 +1042,7 @@ fn setup_falcon_data(
             .find_entry_by_type(FALCON_UCODE_ENTRY_APPID_FWSEC_PROD)
         {
             Ok(entry) => {
-                let mut ucode_offset = entry.data as usize;
+                let mut ucode_offset = entry.get_data() as usize;
                 ucode_offset -= pci_at_image.base.data.len();
                 if ucode_offset < first_fwsec.base.data.len() {
                     dev_err!(pdev.as_ref(), "Falcon Ucode offset not in second Fwsec.\n");

base-commit: 215a3f91713383a3c0d2da82d223a608a3c17ac1
prerequisite-patch-id: d80f92d314a0693d4c89ffb7810d9ab6990336fa
-- 
2.50.1


