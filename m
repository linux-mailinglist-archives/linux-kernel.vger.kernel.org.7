Return-Path: <linux-kernel+bounces-728886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86702B02E7B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 04:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C628D4A1CB9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E244215442A;
	Sun, 13 Jul 2025 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kalLnR45"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFEE4D599;
	Sun, 13 Jul 2025 02:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752375228; cv=none; b=ZcTW4lQrsunvDpDne3F+vUB3hQ5lV/JBID/FkgNSmQl7xi2Z3DKX/PdUJL2pMCHTb+DFDTD6GFlAdv/qA9o8wqcn8dSoJknG4mGrY3+lvtND8ZUthUQPAT/PvkdTZVMUTr+iGlzh5lfU3VkywWvjNlUY2nqU5YcizXQNVj+OhSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752375228; c=relaxed/simple;
	bh=00ZyH3aMujfB1olxVlERxejkAi5mSITlmaj3KArXwhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8qDuiW5mOWKS2wcyQ6pkXp/0LDO5yicfg+N5OFQi89+4Msr1ElKDRFWFMx5IYz5aT3/Xp2uBxzhqKD5gV9DblZ2mK8LS8hbr43phzEqriF0kx98ymvb04cLovBoFJ8+z2N5U48z4UsN0lq7cXmZun7YZbqzydKjGahz7eofVos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kalLnR45; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313910f392dso2807568a91.2;
        Sat, 12 Jul 2025 19:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752375226; x=1752980026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BjtA+38PaXu4R7KEWbDJSP4mSWUP1v/3PF8r8C6k8w=;
        b=kalLnR453FEmCcJMy1q0AIFREWSQDN9YXL7caAFVi/cK1bdcW89a2BGEg2mJRVXjhU
         vhjXMhDcVDsGN8waPlbo8yVlOkslYfIyXkHZaozvDv3QiFueNud/XGdRqsWcPRxyrVfR
         P5/FQXZfuDfXZrivsDYqm6AJGkVa0jXpC8+ty2FlKqUk1uXO8p01U0n5SrVc5WnXCGS8
         2fLj6aTbUwq0jBl/VCPu03UbuVuW6px2U3myiNz5pRU4HzwJEnaw+9Qp/iElxszqfFJr
         3U3f8MNu8Mvnf1Z2NSBq/8YY21rmZNpN3SPrYMtT/GOgzViMvyW3d4lKswu+g/oH793i
         P54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752375226; x=1752980026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BjtA+38PaXu4R7KEWbDJSP4mSWUP1v/3PF8r8C6k8w=;
        b=rBGmumj3vNT6W2791r4rjGprUwSGS6FblWhXkmlO0/JdWWbbFpajxsybceZIH7Cv5U
         lFtCXXwK6YXg8lEvl3vgP8NB2FF5f2+tQkb7To4rDSHTSw/IpWmJAms7afXVMiTCvruz
         RaSPke6OfFvmt/my2YRB0qqhggzvy6FCLm5dVCYqiHknyNNMf68nBQ3eFcciGPqcDTW8
         f/2SqUh9hiZ7niy1PzVH/S9qhqki8bo61FyxucQUhebcGeauig3cZ37bVvzFKit3wqf2
         up2K0qj8uk0YyN+zdHli/1fmdWuj5O3i5pSWn4Dq/L7DJ98Tx8unZeyi9GN8qpVuwW8f
         uuXw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rfurDo45P7kkRiy+szUGg2Li8ou/PDpvfbSpYX4eDM/0zF1+NSqfMvhWMKnTLQbaWFYme82h6wliHeo=@vger.kernel.org, AJvYcCXwyY/YPjhrpzEs+8Pxj8YUohp3UR7RCA7ovnBZFwo2A/9tSmnsLGlJ89R2qkc8GC1QO5nTJQKCTwZmjT2OVko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVYFTX/5tJnlCxbl8TenFpgAE16iylCr5FKGMnTUJX24uHadvd
	1+FwqC7qDQuzhjk5O0Zsa/sge+1owqv22LNdtp49DVhv8Z7K3v6aLyqMH8xVks+Nz/A=
X-Gm-Gg: ASbGncvQlfaaJ4HpSAAYmEQVfC7MpHbrknScxl9Dbbmxregzf9z6pwtaeccOR6Ivwm/
	/AqEJEWlzx/Yo536ZNizPQkW5tX/4gQhSP2snyI1AOUq30xtTECVGOkGzpYxOT5rIVowLXuxYNW
	3UjOLqlZGgN56aBT87qAb8ghTBtjLczxmSw6fGpiQJYQxF+Ze7rqKwq84V64b3QzPdNNpI0pScW
	O2qCR2i0jKudROI0TTw1KU6St1ef0jkJa/3+Uwb+WkJcj2/VUyAb7c6mEHlD2hl+/KSE+rqjNsC
	eoH08n+fZlvyzoY7qXyn/1e+3mweHBfTndVe0jwIyZO1hrlAPIVDdZq7NwvHEyxGOnbTQiVqQJN
	I9fplVe/6rJbcNDFMG2Jxt/Lz
X-Google-Smtp-Source: AGHT+IEho1Foj4fnk6PgnQ8W8nqUpc5SNVdnaWd11d+U1bW/ogI/EC1H+8IGCCJPQ3wJ6U4piH66Dg==
X-Received: by 2002:a17:90a:c88c:b0:31c:23f2:d2ac with SMTP id 98e67ed59e1d1-31c4f53f737mr10947368a91.19.1752375225640;
        Sat, 12 Jul 2025 19:53:45 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286da3sm76345145ad.34.2025.07.12.19.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 19:53:45 -0700 (PDT)
From: Rhys Lloyd <krakow20@gmail.com>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Rhys Lloyd <krakow20@gmail.com>
Subject: [PATCH] gpu: nova-core: define named constants for magic numbers
Date: Sat, 12 Jul 2025 19:51:10 -0700
Message-ID: <20250713025108.9364-4-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250713025108.9364-2-krakow20@gmail.com>
References: <20250713025108.9364-2-krakow20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an associated constant `MIN_LEN` for each struct that checks
the length of the input data in its constructor against a magic number.

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
Changes in v2:
- Add commit description
- Fix author to match SoB
- Add base commit

---
 drivers/gpu/nova-core/vbios.rs | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5b5d9f38cbb3..d456c494374d 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -364,8 +364,9 @@ struct BitHeader {
 }
 
 impl BitHeader {
+    const MIN_LEN: usize = 12;
     fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < 12 {
+        if data.len() < Self::MIN_LEN {
             return Err(EINVAL);
         }
 
@@ -467,8 +468,9 @@ struct PciRomHeader {
 }
 
 impl PciRomHeader {
+    const MIN_LEN: usize = 26;
     fn new(pdev: &pci::Device, data: &[u8]) -> Result<Self> {
-        if data.len() < 26 {
+        if data.len() < Self::MIN_LEN {
             // Need at least 26 bytes to read pciDataStrucPtr and sizeOfBlock.
             return Err(EINVAL);
         }
@@ -772,10 +774,11 @@ fn into_image(self) -> Result<BiosImage> {
         BiosImage::try_from(self)
     }
 
+    const MIN_LEN: usize = 26;
     /// Creates a new BiosImageBase from raw byte data.
     fn new(pdev: &pci::Device, data: &[u8]) -> Result<Self> {
         // Ensure we have enough data for the ROM header.
-        if data.len() < 26 {
+        if data.len() < Self::MIN_LEN {
             dev_err!(pdev.as_ref(), "Not enough data for ROM header\n");
             return Err(EINVAL);
         }
@@ -900,8 +903,9 @@ struct PmuLookupTableEntry {
 }
 
 impl PmuLookupTableEntry {
+    const MIN_LEN: usize = 6;
     fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < 6 {
+        if data.len() < Self::MIN_LEN {
             return Err(EINVAL);
         }
 
@@ -928,8 +932,9 @@ struct PmuLookupTable {
 }
 
 impl PmuLookupTable {
+    const MIN_LEN: usize = 4;
     fn new(pdev: &pci::Device, data: &[u8]) -> Result<Self> {
-        if data.len() < 4 {
+        if data.len() < Self::MIN_LEN {
             return Err(EINVAL);
         }
 

base-commit: 215a3f91713383a3c0d2da82d223a608a3c17ac1
prerequisite-patch-id: d80f92d314a0693d4c89ffb7810d9ab6990336fa
-- 
2.50.1


