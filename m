Return-Path: <linux-kernel+bounces-747032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214BB12EE3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A483172FA2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8096F202980;
	Sun, 27 Jul 2025 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUyCRF9X"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551A1EA7CB;
	Sun, 27 Jul 2025 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753609887; cv=none; b=ne0/axQ3rjsUKpfdwsQpmh9CzZGNMZ39g3uuwrfpQoTT8AB13apCu2GvAwxMnZeVkZCJSnMXib3LsvU/s08HG7X/V28hp6RL+fmWzSmob0g9Z0UkKlteYTCxIts9b8wdHM14nFAS9iTlVM0VaLUu0VOLuWJeX9vpLa3mP2ZyBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753609887; c=relaxed/simple;
	bh=ljGQTr4PcCQkzJA5DGok3GYjeKIjHU6qHRRA5/+a8lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SwoEiFj7M8hKbki0Peta4WutxJIIo9a2fa+ccINHN4XZM+a4MYbxlhtq3K32a0Pr7u5a/u69ienUCQ7JyJ9BC9wiu0zI8krBpjbeRymZ0fbplUocpd3eaMcIBom8qBNwke9VrgtE/j9nOs/hlExYUDhy0Wbc//fgz4PaRqf3mvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUyCRF9X; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313910f392dso2570838a91.2;
        Sun, 27 Jul 2025 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753609885; x=1754214685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q75mBtp8jcS9+B1UD9cGfUNuIFaVl8oU2VgPg7QjKsg=;
        b=BUyCRF9XDkT9Ga9J88/oZfxbFHpuR6PW4b674LAtpXZBvrRC9Sn8kOzCZe318DhbMf
         CVMy+P6wwo3/NYpQfBvhEjfJEYRM7X6dueIEVaOhu+950zX4t7jRZFMAoyYxE7gplEdn
         gdrgNAliCzMbZ0FvzohcMnX85fxQAAd+tvWEv+tZxP8yCJ7NINCeilD19u63DIvk2oDF
         THzA/N8Pnx1Z4tP6PYBB0YqcjzbIocGE14pJqpVbfCVllaZYQmfcWYdmFl7UUD4SVqHS
         kp9lp6tzTDzJsy6KwhT34dk9JOoSrj+VZdFSKcW06V7wl55NgzGHWmwgah2aFuHXW+gC
         TDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753609885; x=1754214685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q75mBtp8jcS9+B1UD9cGfUNuIFaVl8oU2VgPg7QjKsg=;
        b=pAHrlf8oaiKjyR01fpIznISKxmeBgzZ+RLEwu4vETGzx7ficWsEMKTGm8n7x5zAwzF
         la5DJX/2A53xYYEPPFimnZoYVIoXknYFBd+qSos1OOIExBHWh6cErbYFrB1j5dYUcgwb
         OgzcjsXT/XaWa22bqtHr8Htu03+S9tGlWMtETsNXb8QLbymIl83sTGbWhx6mQA8aMfwH
         rYQk0fIH5SnvUyUpKwEcvcg771M2lQV//Ts0Rtf8G3Q8OcZzzEIhaWr5Ohx6M8X/B6Ot
         ZPthwBWzYPYFdOk3cKQkOasWHvRWUn0kZY2JxcGmJ2yNANbTweVW789zukMXj4E4FVAp
         iGtg==
X-Forwarded-Encrypted: i=1; AJvYcCUfVZsvrVjqb3R58ta7uZrG16tblcUfhEV+9/ToDFvq5O6WZCZOhHE2qUSmX2zXnalsVK9SEONk4iQrvKM2S6c=@vger.kernel.org, AJvYcCWN9jPK1PsqGiJFzlDDyvq3gHPuleqc2faKGnMvX3K58QXRhEglZyx5+6FCYvmjzXbZ3vcFCIybu40RYcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcKs1cFptDJ8ZbTH8ksXTMABjljHQfsEbRDTGSCkF/Ks5a5W/
	KsP2vGO1otLNIhrzem1KRi/KLCHuPheOE6wOjS0erPxakpxqw4EV1s1n
X-Gm-Gg: ASbGncswdXYqsdDajZSMbdx1YhA2aBjZ7GWQeJ7jTWwzT14G1RfGRmaifF0fP5Te2Cf
	BXhbRqaCjCYjNED1OLIWoQ7skkdciOkUbefdpYxSToTDbR7fst7+XeqSb7Y/PTIPE5/CWYAipgz
	+RRKMeIlRZBaVGawsQ7obBvM7J2H/ZklxJlwWu1oxdAQsrZEtxKn4qafZX91x/g6taANId+Y2do
	qh3nCdWk83DNtl7Ww0+LYLrTbEcGDWZ7R9u6sjem8FCXkrR55fBzHXRMwQqxOcZ7FLu2V6hgEI4
	/MpvryWbrb2elFThqHx0EHHsDelMl0/fdssaxpwpRQlDo949ORg3zItieVEZ9PSGV0CufLTKSoV
	W7NZ4Ze0Zzrbppf7egBwBgtQc
X-Google-Smtp-Source: AGHT+IFphsUeaQG/0HS39YHZVYaXChSqW9BbhaZJq4ICXtoyWmtTBglaeojibI0sGzaXO/VryFY/5A==
X-Received: by 2002:a17:90b:58b0:b0:31e:e3e1:3686 with SMTP id 98e67ed59e1d1-31ee3e137eamr293498a91.19.1753609884768;
        Sun, 27 Jul 2025 02:51:24 -0700 (PDT)
Received: from quat-desktop ([2001:569:514a:9100:3f23:7b0f:f6a2:1ebd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31ea8c1770dsm2012652a91.36.2025.07.27.02.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 02:51:24 -0700 (PDT)
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
Subject: [PATCH 2/2] gpu: nova-core: vbios: use offset_of in PmuLookupTableHeader::new
Date: Sun, 27 Jul 2025 02:49:00 -0700
Message-ID: <20250727094903.20483-2-krakow20@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250727094903.20483-1-krakow20@gmail.com>
References: <20250727094903.20483-1-krakow20@gmail.com>
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
-- 
2.50.1


