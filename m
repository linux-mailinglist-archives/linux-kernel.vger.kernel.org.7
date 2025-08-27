Return-Path: <linux-kernel+bounces-788519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF15EB385B0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B27C27A45AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3C2271468;
	Wed, 27 Aug 2025 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="PXaEdc8k"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE43270551
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307056; cv=none; b=J/aOIc9zKc0s6gspQ9Ym+1LJKh2byjx3A7bRJPf2RLMU608dfUnbb4fGLJ5m/xDF7TqXf9U9p+bjxMHA93B6jZvvLvg4XQaAVei8OONS0wkU4KaN8IqUn0tt3wlHfX5YhdgIP1w0SBbMDE6HUve3L/gatT21KeY2lWTFqKZx7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307056; c=relaxed/simple;
	bh=zX7jaG1JgqtVvc9IAMJuVT3Unjf69P6+q88NH4C9Mn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUwCNZfp0rwUUNIAvDNQuHDCNPwumf7FE83TxjSMtQsNGNuv5CCs8iOIqMi1qzkEgTc7d73hXW1RUpJ6pP4x8HwqUl9CCgQvXdpQBNbtKB4ZLCVdKMvSHEVjVpfBP4Zv3IRTaazkrj1zfUwwY5Hg4reH72NZLCchaqaBiWJWQ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=PXaEdc8k; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso3843499f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756307053; x=1756911853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FN3etd68yjlykSE7mt0F2RHD6jpI0nU5EsyPecY0KV8=;
        b=PXaEdc8k6U9ngBq1Oizzx6beedimVYfyKkS0UmTOVJvOzHSyRLkyC2m5d9Pkgz1UQ4
         zEqKuVVGqBiV9V4MEDrJRPrqvyqkNj3p6yxKywnags6xqES3LeBKsI0CSblPcLPaH32b
         APfMuah1yp46NHuBF+0mWtemRZenQDC/oa8ZeGY/68G52p2IyAv9aNH4LRs8N2weSgUb
         OgPEVz2QdcP82TsYRKYSjirk+3RH5j9WGAA43YbScd+z/+57KIA1d0yXucQsZFzzRcBF
         nvRop9HaKhuRTGp6m23O9y+t05QXfxE+uJQRCNAp70ck2fCmv736gda80T09juFtqF5t
         hwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307053; x=1756911853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FN3etd68yjlykSE7mt0F2RHD6jpI0nU5EsyPecY0KV8=;
        b=KVkIR4Xf89ITepMB5TS2qMPZVZRezEhOy7hLSQLcvr1uYcVopjI9SJJkGgE+aDH9yA
         n75lDTozU0TR11QDausCD0c3sNLtONCs/KNV0wiBOCp1B19SbGQAY61kyinOk4OzLnxY
         5EOvC+4K2GLQsge8ZOrgoErSmSfFMOI6owwYiju6SoWFfv2ntN4fW50LZQTM73qP9k+P
         YNf7E6svEb9IGYFo4/8PDaDPxE2rqLxWpRIFwLZ9AI7/C/m7IzFGuq7PrXzjXV3MItkL
         0ULCLjGYZnf3U1W185gRoDnD+tyHvFONOXxQWs3WQ32A+/yPHnbfSrrJ9O6QdjvdUDOu
         j5GQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTCgHUMmhtzCu4sePQTVmLbm7CXmuZ5MaxD8wG5crcs8sN5hWfoLa27hoQ+kj36VunZJa+tIEnmS5VCm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5rRTEmHWf7mdAcFJt8OigC9uqY7kiDbrJO8LSpnq1x4SNjEn
	mA3IFMlA5i3LNwQas36XMnSQuwXruUL93DvBfNwD1mMgmSYz21BOyIivJHTshopRI50=
X-Gm-Gg: ASbGncsd92geF0ZacDXYkSKlv3xvWSxke7sonfCEGJiqXRVOrh5ST153RpdbUeJNW4i
	JHx3HKkhiQRVxk1qZjhGpTTY0MgiCWRKuwpSjTWSJqQYYEFlAkSiWt2PT4p2VVO9Tx4H2yGTdBx
	1t9ZOCeU5xwb1sZzWkgCeapAAbxQmoLsKKNwk154rve5t1KroNjxm5F6RRW38juobhzDw9sZPfo
	GajGtLzkhtE1xqCdFRXplUU1BhI7Dj4Os8TANjrGpV1XVSN9UoUOT8okXJsPxAbw5OSwtYd6MCh
	w+F2S+CEcHcp0Hx7PfC8z1Xqngu5cs6YXCjuhRBj5t4kjxfr72tQ6S0b+39JWEyc/f3Ki3XcL/R
	Klag5Yqnlig4MiMOy/CpGF3wsiujedM5wvoGQfPGtov+kimBf6xwRW112AwW8X6SQ+uCWCRALQJ
	s5IPBgny+foKw+hvSOohuZ3A==
X-Google-Smtp-Source: AGHT+IGrW72g0ILq4UifqCK6TBTWBT1mHH+uWmSaygxM231xFkoJ/nzT7KcZcVt1YLhfij5DkpLHmw==
X-Received: by 2002:a05:6000:26cc:b0:3c9:9ec0:2055 with SMTP id ffacd0b85a97d-3c99ec02f3amr8669458f8f.39.1756307053288;
        Wed, 27 Aug 2025 08:04:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc98998781sm3421790f8f.49.2025.08.27.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:04:12 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2] huge_mm.h: disallow is_huge_zero_folio(NULL)
Date: Wed, 27 Aug 2025 17:03:30 +0200
Message-ID: <20250827150330.280399-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
References: <2aa3f478-9c87-4102-b83e-bf235372d834@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling is_huge_zero_folio(NULL) should not be legal - it makes no
sense, and a different (theoretical) implementation may dereference
the pointer.  But currently, lacking any explicit documentation, this
call is possible.

But if somebody really passes NULL, the function should not return
true - this isn't the huge zero folio after all!  However, if the
`huge_zero_folio` hasn't been allocated yet, it's NULL, and
is_huge_zero_folio(NULL) just happens to return true, which is a lie.

This weird side effect prevented me from reproducing a kernel crash
that occurred when the elements of a folio_batch were NULL - since
folios_put_refs() skips huge zero folios, this sometimes causes a
crash, but sometimes does not.  For debugging, it is better to reveal
such bugs reliably and not hide them behind random preconditions like
"has the huge zero folio already been created?"

To improve detection of such bugs, David Hildenbrand suggested adding
a VM_WARN_ON_ONCE().

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/huge_mm.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..bc9ca7798f2e 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_HUGE_MM_H
 #define _LINUX_HUGE_MM_H
 
+#include <linux/mmdebug.h> // for VM_WARN_ON_ONCE()
 #include <linux/mm_types.h>
 
 #include <linux/fs.h> /* only for vma_is_dax() */
@@ -479,6 +480,8 @@ extern unsigned long huge_zero_pfn;
 
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
+	VM_WARN_ON_ONCE(folio == NULL);
+
 	return READ_ONCE(huge_zero_folio) == folio;
 }
 
-- 
2.47.2


