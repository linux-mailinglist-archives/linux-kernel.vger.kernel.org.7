Return-Path: <linux-kernel+bounces-736427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF13B09CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662777B363E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B662690ED;
	Fri, 18 Jul 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zs3eotS0"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3992153D8;
	Fri, 18 Jul 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824241; cv=none; b=iCwxFvB9WIfKHSXOgd8sjZdDgq1AsqKyDP/fm6lWM/efVmDcth4gjsp9LyynSO8InXUrdW64jU1EngCAhpUI9SNb3NrkuWARh/A7yavGbQBjcW2bbxnaNS3MASeO7GbyFWTorCvsAz1ABOlZq/04VeBKXlkPcPyXK9uB4RDQhY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824241; c=relaxed/simple;
	bh=WUszYK4D8HHPE32atsbZ76wDuahsOAiTrpFMUh75OBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WgoDa2DFJVlbXzwYMmvL8K4IAKQPOsqrXjhlUDtOXsF0fCAVek5yUzwP7wjt6Kujo34+ThjQdahBagn+aYHsH4xWpokxg38//iqDBhJkuu3nCwFnMDUnDVYys6lhY8bPccbM5cJ/f+xP6nQLapJx/H6ltw/QnHAceXdWB4dFzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zs3eotS0; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23c703c471dso31227125ad.0;
        Fri, 18 Jul 2025 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752824239; x=1753429039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai6AIsNYmiqglCkswHUmAaEoqz48shBaAddMej2UzY8=;
        b=Zs3eotS0W7C8ngfCkWoGCPZqPM2qbuMbLgfq0si8k5EIT9+horXSKpT5XXDjLszMIa
         P9zj42/1rutKiP4mcSWiLYPG5IGFxaw/zu2UBrTnLxJ5C+Yn6V1jn9oCS//wlxLt6KOF
         Zwzg6fz8DCWfskHrFDYbM7J2be4KDm86YQZgua253kgYae3kEVXTQWDqgl7TV2x04qHm
         hoaf+u+WkbeEdaIY6NoWDexXlpoEIC2qGHCqZtVv5qqwNRw5w/36QpiJZ+oirK8umkld
         jIVHAyWtftDzeRaA9Nx1anaLLKwa+x1JlVT5NeAlVhZ2xPSTyY3O9tvmCB0+hp8uXcwi
         ZT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752824239; x=1753429039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ai6AIsNYmiqglCkswHUmAaEoqz48shBaAddMej2UzY8=;
        b=bIQ82y8UKI5v3P6TOPQfhSczyHVvDRy0XAIm+qwTDQP0Dd0hcj/Ff5NCeIysnpYLR7
         GskTekbOOyWh/xw5/HCGLybA6T2S/4oBZVglgKgbkMvXkiVw17rDvNPAi5X/mceQnRJ2
         pOhM87Ge+hryvfgQXL9ka9yjIITsMNojqDCiEjLfM0ElvkCsrZtxtn4pvpkd86+QQoTr
         xoag669ajxr0a2l2yPU/ArqI23w3x3okMb3bIxs4Z8RIeAJbQdYu/S8dLJ3c3WPxf07F
         VJ9emlcLUshwzAKZ+pSJMzFNK42xl72bXpnXLXTxHGEF26bbSDyXPT38H58gCaMvv8V4
         uYGA==
X-Forwarded-Encrypted: i=1; AJvYcCWrsJaz1IcSEp/6TPtlkBZII6a2TCCFT2x/g5xLaUuvJu92cOn92oHvYAzpJYOhVwRabdMJBvGYp/EaHZY=@vger.kernel.org, AJvYcCXPGdTBamFoFYAaX+NjJJXjuTlS8IMs8xM3QWjoY0ZxeltAclU9/2CZr81Egg5DHzCDLw6SbCE+yiKEqcJljzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCczx7XAD3aFBtT8a1WFjtOdogdTFqjNRrZkh43ix1Q5igAP94
	wUh45fhMF4/BmN4gZRQ/KVq3ct53KZShMIs7shSE/s4+7MFLEArTxsNX
X-Gm-Gg: ASbGncs6lr+4yz9GRk6lF8QnNy8MUh/1QRd72FQBQYjIXQnOMSaxV1Y1ucYQHOXFbBm
	IpE5hJJ0YoewOR6HAGSN2Tn70SUw4RTe+DC0h5c4xx0l0R66C3c5WZXpQWAT+FcFFqspMSYvkYE
	/uMeI/bXeCtLCqV2t4soUWNhx0XB7UF1BtQOkmLFtyvyB6mjp5TIJCXq8rQFa6uM3V6/yx+pdSX
	a982mai8gWMFpKypDZxvLC67Gy/KG9s5SPsdTX0hjBZvFOlMEUzu3vCZfXyDDxDdKuQT/0qgOz/
	6CR7qnSTYCllceDiodn3rovIP2rK288b9g70BUGTPol8IGgFgd0ILkwXjpMFHoOSGq8A69uiYzz
	/TteJk+G//XkTRIRRT58TH5AU
X-Google-Smtp-Source: AGHT+IGhzhjEyANqqp1/SDgKHIG6htiJ1z7iWroAuAfjCn4qbOsU8XvNCKF51G1XeSxmyeC5vQFokA==
X-Received: by 2002:a17:903:19eb:b0:221:751f:cfbe with SMTP id d9443c01a7336-23e2f73fea7mr100230355ad.19.1752824239054;
        Fri, 18 Jul 2025 00:37:19 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4e84sm7671725ad.104.2025.07.18.00.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:37:18 -0700 (PDT)
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
Subject: [PATCH] gpu: nova-core: vbios: use offset_of in PmuLookupTableHeader::new
Date: Fri, 18 Jul 2025 00:36:23 -0700
Message-ID: <20250718073633.194032-1-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the offset_of macro for each struct field, annotate the
`PmuLookupTableHeader` struct with `#[repr(C)]` attribute,
and add a TODO message to use FromBytes when available.

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
 drivers/gpu/nova-core/vbios.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index a77d7a4c8595..cedfcf3476bb 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -893,6 +893,7 @@ fn try_from(base: BiosImageBase) -> Result<Self> {
 ///
 /// See the [`PmuLookupTable`] description for more information.
 #[expect(dead_code)]
+#[repr(C)]
 struct PmuLookupTableHeader {
     version: u8,
     header_len: u8,
@@ -901,16 +902,17 @@ struct PmuLookupTableHeader {
 }
 
 impl PmuLookupTableHeader {
+    // TODO[TRSM]: use FromBytes::from_bytes when it becomes available.
     fn new(data: &[u8]) -> Result<Self> {
         if data.len() < core::mem::size_of::<Self>() {
             return Err(EINVAL);
         }
 
         Ok(PmuLookupTableHeader {
-            version: data[0],
-            header_len: data[1],
-            entry_len: data[2],
-            entry_count: data[3],
+            version: data[const { core::mem::offset_of!(PmuLookupTableHeader, version) }],
+            header_len: data[const { core::mem::offset_of!(PmuLookupTableHeader, header_len) }],
+            entry_len: data[const { core::mem::offset_of!(PmuLookupTableHeader, entry_len) }],
+            entry_count: data[const { core::mem::offset_of!(PmuLookupTableHeader, entry_count) }],
         })
     }
 }

base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
prerequisite-patch-id: 6f9311de987d56f4313d5fbdd85ed8c48a44e78c
-- 
2.50.1


