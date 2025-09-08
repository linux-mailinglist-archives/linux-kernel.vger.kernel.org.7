Return-Path: <linux-kernel+bounces-805311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90702B486E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB351B22F36
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A542EB5A6;
	Mon,  8 Sep 2025 08:26:25 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7521ABBB;
	Mon,  8 Sep 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319985; cv=none; b=d4JPsQmrSqK/EeFJ29BSFPRkiishLpX55e86/687Q8KKfmk3w8mUpreOsTYMjbVnuU+1ujGp8CWvKE46jJ1fCa8Nw8uIE6vQ+UYYVgeBTByzJ6dTr6t51x9w4GdAkZeWRaWBsVYDRgblGemq1kXWQW8yEsTQj1hDO1oalUit4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319985; c=relaxed/simple;
	bh=b6mwVhROf6BA2J4DuaSl5UNlXikeqbGdkbqQCs+11sU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VxXWGq8PrRVJ04xigh4klfglHiJq42fA324/ulnnTpWenW09Fc1u1sIHTvM0fgd/OfDtHH4mhczi1EHDxtCFR7ofZJ2DTZhAaqZylNqrh1wfeoCdkzvEQO6gd6ImZl7t7tGDo6N9Zhcz2+wvndDyAv7fECnJawHWxMDDL/bsXDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cL0Mv6fgtz6M5D4;
	Mon,  8 Sep 2025 16:23:39 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 12E7014010C;
	Mon,  8 Sep 2025 16:26:15 +0800 (CST)
Received: from smtpsde.huawei.com (10.221.117.194) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Sep 2025 10:26:14 +0200
From: "Dominik M. Weber" <dominik.marcel.weber@huawei.com>
To: <corbet@lwn.ne>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Dominik M.
 Weber" <dominik.marcel.weber@huawei.com>
Subject: [RFC PATCH] drm/xe/doc: Mention Buffer Objects in doc without abbreviation
Date: Mon, 8 Sep 2025 08:26:09 +0000
Message-ID: <20250908082609.1683192-1-dominik.marcel.weber@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: frapema500002.china.huawei.com (7.182.19.148) To
 frapeml500007.china.huawei.com (7.182.85.172)

Add a new heading "Buffer Objects" in xe_mm documentation, grouping both
the related BO sections and explicitly stating what BO stands for.
This abbreviation is used all over the document, but is never written out.

Section markers are adapted to remain consistent relative to
included doc from drivers/gpu/drm/xe/xe_bo_doc.h.

Signed-off-by: Dominik M. Weber <dominik.marcel.weber@huawei.com>
---

I am aware of the guideline recommending sticking to the usual
heading adornments, though doing so is not possible here without
either necessitating larger changes in the kernel-doc comments
or breaking the current hierarchical formatting. Introducing +
hence seemed the cleaner solution.

Since this is not about the content change yet, this RFC is
sent only to documentation specific mailing lists.

---
 Documentation/gpu/xe/xe_mm.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/gpu/xe/xe_mm.rst b/Documentation/gpu/xe/xe_mm.rst
index 95864a4502dd..24a532979f1a 100644
--- a/Documentation/gpu/xe/xe_mm.rst
+++ b/Documentation/gpu/xe/xe_mm.rst
@@ -4,17 +4,20 @@
 Memory Management
 =================
 
+Buffer Objects
+++++++++++++++
+
 .. kernel-doc:: drivers/gpu/drm/xe/xe_bo_doc.h
    :doc: Buffer Objects (BO)
 
 GGTT
-====
+++++
 
 .. kernel-doc:: drivers/gpu/drm/xe/xe_ggtt.c
    :doc: Global Graphics Translation Table (GGTT)
 
 GGTT Internal API
------------------
+=================
 
 .. kernel-doc:: drivers/gpu/drm/xe/xe_ggtt_types.h
    :internal:
@@ -23,7 +26,7 @@ GGTT Internal API
    :internal:
 
 Pagetable building
-==================
+++++++++++++++++++
 
 .. kernel-doc:: drivers/gpu/drm/xe/xe_pt.c
    :doc: Pagetable building
-- 
2.43.0


