Return-Path: <linux-kernel+bounces-736429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAD8B09CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6873B9DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74A6268C42;
	Fri, 18 Jul 2025 07:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Z6z4+Q"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124D230D35;
	Fri, 18 Jul 2025 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824270; cv=none; b=PdKKAPUUd0KHWkujaNl3t/FXL4v55VwtHahP8/+l8qnQ8nJyhD+k76pP1OVZcVnCeNe1fA0je80GSZWIUDwt45jn+T3w4COwO3zyd6lFqq253LSCx5DycVP6JU6tnXMr5+6yFGgahOLh+gFCozz7Z8nPKcK6Zc7POAROivvfycU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824270; c=relaxed/simple;
	bh=YZRGev10V8RfTvcCjxGtvvy8xVSxVTnbrl2LPe85t1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttHLlJercamVyynPveioub/FptJXDwaGjZvZkxGo1oxK/pjjVINhSRWvNkPfXXSTMLqFbNXaxjavmrFKifyxajBqlo5id2kotS/oIYLmk/LCo0/DntebuqYH7TPZHIvRhTm073FCsqDDcOEoUibsDS4Qvm/Xle0p7UPojV1PoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Z6z4+Q; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234c5b57557so16593945ad.3;
        Fri, 18 Jul 2025 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752824268; x=1753429068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F331rKpZ7Oe6FYaTJXdFG2PxN8OlPB5pXAO1vVr7BtA=;
        b=B7Z6z4+Qy4z/Pac3UxO5rvF14t8i0OsuyMQgzEzNRwgTvF/5rhp5iD6NNUbi35s9DO
         ty9MAT3JutoieGf7YmDMTNshpVjyZtGE/vGGdgYWiCmbLX5rIPqxxd37eNg0mfSpVEOF
         okavW2Rp74t2MhQyFEKxZ0OYGrj9OsHGCs1g4RZ7oPDLlMnxGekdbcWVTQnnpOGuq8qg
         s5fsQNxRUKWldnqhMtOVavmbjvV4aNd2Qo0xRKDa2+H83wUfAHHnxDwnFKllC8mG9v7N
         VYmjyMVjBfFfbkIXiR1YrBXA9Ps3qUTcanR/pIFkeEy5wX2soa/QDMq8dxswx2fD+04I
         XjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752824268; x=1753429068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F331rKpZ7Oe6FYaTJXdFG2PxN8OlPB5pXAO1vVr7BtA=;
        b=SzLbbaiaxdsUopZ46NI1YgXIoZ8OeCA0tEb3xV1XvFXDypnL0vQRUn2dSGjF2ESZcv
         NafnNkfSlxa8u+SlzBEOaoizWzslZ1m3svkquomgRF/WrabIAZ7eadLlrSJklsP8mi36
         LapxogRjqK8fTl7/99R9gXFm4TLrN/hmetJwk2cj2MFSjFcwTR7n9nHAqOLyy/fDe8bp
         NKUl2jXRs8aDRN8/O822ZhBZEfvYWXyMLrqU2eAM+1f9aiJhtpsrraumvuIaINyA8urF
         z0LrZogugE8hot4g52hIVdHUePWSZkwUHo8LxyWM/H3+KMG36jrD7X0w6COETq3wG5CD
         OezA==
X-Forwarded-Encrypted: i=1; AJvYcCVbzwATVaySkQqKGSsX9xuJEqY1dS1WQ1rPvhhNhTtxflQoAoLYIhPsVdz4bzAVgqfmd6q4eMXQEPW0Ncs=@vger.kernel.org, AJvYcCXCLdjwwvW6aLyapaHylQ7GsrKQe9jjhhobqHssyK+bTFM7VD+4AuxKbpkNvaARqUPFsDTRkeFoBho+3Q8K9gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwkQ/YJpnWMda0qCrxqmklwqLocLeREdui8CYB5es0LYlmLS45
	N0f6yDvdP1K67PepMZ2ZstGkPo0dFGAmhWap1GgBaQbmO7N82fueKTEX
X-Gm-Gg: ASbGncsi3zyZAvv+Qy8SMnvuWT0N1H4jawDgJSJnAnlvBUOdvqOZkSLTBnlDJOb05ym
	3uZQVxg8uuvKJciROyNKrkVmQpLGs7XvEVes1tEI8wdsglQx/DpDmRiMPXb3Lrfevv81DQO8Ygq
	BQRNHRya7FYxWzZkSZFNuh1tBGpGkduyGO6jrDGlEhLS8MNcLutsAVDwokh4FuLbsIIaLaNZouU
	XYLc9YBWik72nXZoPbJlbN6XR/CFFqe/NCV48eVTl2ELzH5jqsQ6RFqO+/gCAWJgFI1zHMEm6KZ
	XKph+exSTALDmaStOabSg07VJOZ0Wd5FanxMhviSFOiICY/rp8nVJgpHaUm0Hj4iR5Bc+qiMvCH
	1gjRyyVlPPmkvzimlzOKz5J9RAaec7lTQ8Bk=
X-Google-Smtp-Source: AGHT+IETRPva4ck7C9Si6yZrkvK+/vXb7rDOjcKQ4Tbk1nNlqyAeaw2WVm2q8RtQKEDPzQzyQtR9Rg==
X-Received: by 2002:a17:902:c941:b0:234:c2e7:a103 with SMTP id d9443c01a7336-23e2572ffe3mr115592075ad.33.1752824267824;
        Fri, 18 Jul 2025 00:37:47 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4e84sm7671725ad.104.2025.07.18.00.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:37:47 -0700 (PDT)
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
Subject: [PATCH v3] gpu: nova-core: vbios: change PmuLookupTableEntry to use size_of
Date: Fri, 18 Jul 2025 00:36:25 -0700
Message-ID: <20250718073633.194032-3-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250718073633.194032-1-krakow20@gmail.com>
References: <20250718073633.194032-1-krakow20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate the PmuLookupTableEntry with an `#[repr(C, packed)]` attribute.
Removes another magic number by making the struct the same size as
the data it needs to read, allowing the use of
`size_of::<PmuLookupTableEntry>()`

Signed-off-by: Rhys Lloyd <krakow20@gmail.com>
---
Changes in v2:
- get_data helper function renamed to data
Changes in v3:
- Change PmuLookupTableEntry.data back to u32
- Remove helper function
- Annotate `PmuLookupTableEntry` with `#[repr(C, packed)]`

---
 drivers/gpu/nova-core/vbios.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index 5b5d9f38cbb3..4c8368946bd6 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -893,6 +893,7 @@ fn try_from(base: BiosImageBase) -> Result<Self> {
 ///
 /// See the [`PmuLookupTable`] description for more information.
 #[expect(dead_code)]
+#[repr(C, packed)]
 struct PmuLookupTableEntry {
     application_id: u8,
     target_id: u8,
@@ -901,7 +902,7 @@ struct PmuLookupTableEntry {

 impl PmuLookupTableEntry {
     fn new(data: &[u8]) -> Result<Self> {
-        if data.len() < 6 {
+        if data.len() < core::mem::size_of::<Self>() {
             return Err(EINVAL);
         }


base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
--
2.50.1

