Return-Path: <linux-kernel+bounces-779089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E79CB2EEF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2ED93A8A04
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACCA258ED1;
	Thu, 21 Aug 2025 07:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hcOblnxD"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296F347D0
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759698; cv=none; b=pA88tiDfH8izhw1T2Czkd1gBYcNPJ1Czg5mn6w/1QoTD0e3Y2iABRvirVh+BTchTArnpkR8teYkOnWlAuj9GG+ZQ1+ILZ/UhwuuSugsUKzX+D2NcVIy+enZ/oFltOpnGWSbAR73RCuWkH3cFV/VSYFSJPKirdcotExWwKl+4EIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759698; c=relaxed/simple;
	bh=xAbwWeBBjg9N+cdieYDjYzALaVmrwO5vpPTMIUPytzk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nNN2u8ZGbqq1QWL5nC/Y5GjHleeRxJcIGO4Cd3bsl6P3I871RooxzI8ksP1WFRc4hppeJ3eQKQpNlsaavJp8Q1c1UnxnEPd53SwsvMWrBXPTcrWm/qhU0lUlnUgXhPCV9FzsfcKkdM8EpkjKcTtlooexpdCnH+2uUPAZ+GNYWUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hcOblnxD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45a15fd6b45so7328025e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755759694; x=1756364494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GIUE2PmBqOrrYO7GAV3V+fHhCJGdLaC9xCv0zLUGcNE=;
        b=hcOblnxDNap8aX9N5LLgAqTZZ/cNLjESpPbIG4uCd+JkcOHVsKsvPAs/C6Hj/rhxCr
         UWN6ibRxIhMkVLyz5ewTVRa6PRM5xy7esS0qeaEspX6jII+Yq7QQLAlBhVm4rwIgLUBN
         A2VkYa4mTt79NKa8/fx8G1NPSUMiCTvl8M6BWNLm/ZAwRvQu3D1yQBsxvFCKnYiiWVKF
         PBTNjPxX/edQt26xGii0csEdCL9JlggABmWJdcwA8zUhDcKPZnYZMdRlBvBKVWMcpsjl
         mZTjD9nu1nC5Z8bFE4P3v+Bn5PVAUA27MvaN7CDTvQBjVebJZFgFS+odiTaJxVaFMafX
         UmTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755759694; x=1756364494;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIUE2PmBqOrrYO7GAV3V+fHhCJGdLaC9xCv0zLUGcNE=;
        b=JCVg7vUopg2ZhZXSOmnTYaQ9Lw9cu0gtutgjQIojC5bEiQQVx9r7FfJWd0hds7nBB8
         ZcyGlm9x6uafJOL2j7yBxsC5v1pxnM4Lo+0Zc6n7dXWfFZ9+0WllBNYZLuqTzhc2oO59
         0J4oqXkSErm5cjiwTLUBpPdgbd1BfpZqX0UzjZgJPxi+hXFUPCU5MDsTQLSrOMBnIikb
         elGeqDeviCZMUtlVxAvB1COMXJc8yMCuSUbak7Bv66VVNxzpLgJI23hSfE2s+KDWDEcQ
         5aejf1MdLkhS8DAEmZ+9/UXQwF3l+zqxa65Er11Wh3WdlBoiYwxD1zrLRyB4KN4K/U6D
         991w==
X-Forwarded-Encrypted: i=1; AJvYcCU75PrM8a/GvADJC0NjMCEhIrbpRNkml0jeDOZZ9tWLmhYHv44RtROQJQ4eL961/WDrzGCBs4KYCMs0vjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3r6s6WowiU0vAlLg85+SCbiQ+in7QXpKhXYo78+zYUyTCkvyV
	efkYwJF01spq4sgcuVHxURmi0V6qsq6Xo9uFOzyqiVuFWTvVHOg/7EWAQNENaBIPT1NYW5fCTOD
	Jf51ILDZnMg==
X-Google-Smtp-Source: AGHT+IGlH2xw1DoBwNhaE0zN8l2SvWcW/Lug5/2eb+mUXE7rWPWReBJndxbSGekbGMY8ZvWt/3V02e08ioCL
X-Received: from wmbee17.prod.google.com ([2002:a05:600c:6411:b0:459:6a64:4582])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:c0d2:20b0:459:dd1d:2ee0
 with SMTP id 5b1f17b1804b1-45b4d70e0f1mr6209805e9.0.1755759694320; Thu, 21
 Aug 2025 00:01:34 -0700 (PDT)
Date: Thu, 21 Aug 2025 07:01:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821070130.2581766-1-abarnas@google.com>
Subject: [PATCH v2 1/3] staging: media: atomisp: Remove unnecessary inline
 declaration in gdc.c
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Get rid of gdc_reg_store() forward declaration because it brings no value

Signed-off-by: Adrian Barna=C5=9B <abarnas@google.com>
---
 .../pci/hive_isp_css_common/host/gdc.c        | 24 ++++---------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc=
.c b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
index 8bb78b4d7c677..bfda3cd13306e 100644
--- a/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
+++ b/drivers/staging/media/atomisp/pci/hive_isp_css_common/host/gdc.c
@@ -11,13 +11,11 @@
=20
 #include "assert_support.h"
=20
-/*
- * Local function declarations
- */
-static inline void gdc_reg_store(
-    const gdc_ID_t		ID,
-    const unsigned int	reg,
-    const hrt_data		value);
+static inline void gdc_reg_store(const gdc_ID_t ID, const unsigned int reg=
,
+				 const hrt_data value)
+{
+	ia_css_device_store_uint32(GDC_BASE[ID] + reg * sizeof(hrt_data), value);
+}
=20
 #ifndef __INLINE_GDC__
 #include "gdc_private.h"
@@ -92,15 +90,3 @@ int gdc_get_unity(
 	(void)ID;
 	return (int)(1UL << HRT_GDC_FRAC_BITS);
 }
-
-/*
- * Local function implementations
- */
-static inline void gdc_reg_store(
-    const gdc_ID_t		ID,
-    const unsigned int	reg,
-    const hrt_data		value)
-{
-	ia_css_device_store_uint32(GDC_BASE[ID] + reg * sizeof(hrt_data), value);
-	return;
-}
--=20
2.51.0.rc2.233.g662b1ed5c5-goog


