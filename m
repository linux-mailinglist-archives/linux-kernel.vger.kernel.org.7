Return-Path: <linux-kernel+bounces-772587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B989B2948B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BDAB4E812D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF94D24503F;
	Sun, 17 Aug 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZyiChyiG"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAC1B0F23
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755451218; cv=none; b=KvE0Ntz6kIVpAneElmHDHy5WlLsLRwg15PsK3TypLZSC/LllPunl5WyOxsyVxb3z0tjGoxvoPMdYw4goD3s42guIn0ggOUa1yTOKfk+RUErSBmw9TQvI+FV7JdP8di6OHa03uptQZziQFqB3R9vSdSAuXrW1bq61EKCyegN0Uco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755451218; c=relaxed/simple;
	bh=QywHrMCGHrpw1N/WF8P8OPYDpdoKfATYmwOmZsutAD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N6AlZitWJSnMCtHA6eREuR17qXdi8dkk5RATm5AUkl7oJPc+XqwwU5Sv7xgyazRnRY0fuxizOIZ8v/DIyz5XQafQDvY/s6+Dz/Qm+5CtZYZw+Pk6HREM8jbfXTt+4UJ+4FlSFHKe1Gs1qB1e4Xu0+zQ8hvKsyVk/kcn+kvDLiD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZyiChyiG; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b134f1c451so7334131cf.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 10:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1755451215; x=1756056015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mSnL06ycRqaedii29t6GSI9Lkyw4QrGbTSVi1KTNBmM=;
        b=ZyiChyiGBkmghbYceYdmQsAdDOKK0WHt+Tt2kRvC0w0s+gAQ8HNGmXieB9LldrVWXB
         oxSX5D0PuNOU1lm+l6o1tNsaf0xBqOQxo/NtDuNFcLeLS93oVakRN7afJC3AGHvoJY74
         aGKHWcSay/XaertrpKw8EQPrSpIS/jzs9QUS7SG7XgKZ0Rz8QQCxKO4KA7AeKfaaPCcu
         jrf5oqrZ0/c8oJ6UyEhlQB5JqCvF3lH6e3muQE6KcgNMxkiNODKxX+bIGMYpJzQImBbP
         W1P7Q2YH12mt6byQ1F/aGA4qrRPKhuO9tbGEkwuCRipzvFx91mvl/9lTDvVNDck+AHEw
         NZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755451215; x=1756056015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSnL06ycRqaedii29t6GSI9Lkyw4QrGbTSVi1KTNBmM=;
        b=O48LulBKyJ8MlWE1Fl/xdfmm1SZRtAzrq+LY6IhAr/ufFHesC/JPgNfK90PUmKM0MS
         iM8rlS0wVjCjOHt0gIiyQJUYjr27gC4z6Rfb37k0rWZi6rqnULYvN5K1CHs8K4Xui2cp
         A6AqBrR3WcujHHmTcBTBbNkhGN/+4DmwpY7IFyxgzO3FpTrAhSwjrPgOk3ThtwaxmocT
         +4oUBWbFThpb+7n1vZi7xRM8w/7CzIgt2rWNjYXq7Etsmu089nnT5i5RAYODzO+1NMQO
         QC8yCJcvGXgdI9qnPHMIJ6KWYmOK/tGroDgy+sYon1PWCJ4saFoTlK71451O+lxzy8G3
         780g==
X-Forwarded-Encrypted: i=1; AJvYcCX/lH48ocJDAWXdSP64P5SGzH+T6WUHCHUiC3cxumkr4I7kq2DBgQ6Mez1Rlg8QWqlMQ4kt48m7WcsbXVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLh404B8BE5IHndAvuITJRe6UWYBJ6mJTJl6ckDTe3P+fU/Ml/
	hWfpGAqIxuEn8O1aCby1CDimXR2Z5verAqa9asS4RA+16Y9UWN+XP7jM9Ie6ZwpvQss=
X-Gm-Gg: ASbGncs/e17jBnt9t7ci/FNwefbW0HbciV1PaYSJN9Mf2eK5+52NXZ4KiOSCaUgzUPi
	yuM8BUNJeyh1y3lYiqYWwBuIY/aD50fQMnyVmZwOEb3M4uVhMNtNp1HthJqsQIgdcxdNk9cnjzK
	YdiJqIstsmWyTca0Tri4cmecv6OqfDILSINYvY2kp8javk2+BwRWnswYZY3vKuSv3+O6E/lQ2wI
	DmdhAkCAB+I+57sKQ48BvYMNj208JphtNo0m/iVFgGn+u1ZP/5ue2IUJJELm6BWkqYheMKfudwb
	q+9EwsBuaE7lbqNEcwBJrahuGFYqIgNaN2wwByDs53lQ6jI4VyH46ozp8S/5mNG5/Lpb5bXzncz
	h9c1x7egGCKaLwAtTLFwepvzuDeK/y/m5R1S9y7TvdffWdCDWNqnVCzno
X-Google-Smtp-Source: AGHT+IGwz143a26VUvXza9j4UAUrHILartEYg3sAkeI33tXkk2gT37GFXk9hZ2LW7zx6MH72H+UDag==
X-Received: by 2002:a05:622a:5515:b0:4b0:7a69:7280 with SMTP id d75a77b69052e-4b12a78434dmr91489461cf.45.1755451214902;
        Sun, 17 Aug 2025 10:20:14 -0700 (PDT)
Received: from fedora (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b11dc18a0esm39529561cf.9.2025.08.17.10.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 10:20:14 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	Gregory Price <gourry@gourry.net>
Subject: [PATCH] cxl,documentation: remove page-allocator quirk section
Date: Sun, 17 Aug 2025 13:20:02 -0400
Message-ID: <20250817172002.43488-1-gourry@gourry.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node/zone quirk section of the cxl documentation is incorrect.
The actual reason for fallback allocation misbehavior in the
described configuration is due to how reclaim is engaged when
the local nodes capacity is exhausted when nodes have no overlapping
zones.  No fix is available for this issue yet, but the documentation
here is incorrect, so simply remove it.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../cxl/allocation/page-allocator.rst         | 31 -------------------
 1 file changed, 31 deletions(-)

diff --git a/Documentation/driver-api/cxl/allocation/page-allocator.rst b/Documentation/driver-api/cxl/allocation/page-allocator.rst
index 7b8fe1b8d5bb..3fa584a248bd 100644
--- a/Documentation/driver-api/cxl/allocation/page-allocator.rst
+++ b/Documentation/driver-api/cxl/allocation/page-allocator.rst
@@ -41,37 +41,6 @@ To simplify this, the page allocator will prefer :code:`ZONE_MOVABLE` over
 will fallback to allocate from :code:`ZONE_NORMAL`.
 
 
-Zone and Node Quirks
-====================
-Let's consider a configuration where the local DRAM capacity is largely onlined
-into :code:`ZONE_NORMAL`, with no :code:`ZONE_MOVABLE` capacity present. The
-CXL capacity has the opposite configuration - all onlined in
-:code:`ZONE_MOVABLE`.
-
-Under the default allocation policy, the page allocator will completely skip
-:code:`ZONE_MOVABLE` as a valid allocation target.  This is because, as of
-Linux v6.15, the page allocator does (approximately) the following: ::
-
-  for (each zone in local_node):
-
-    for (each node in fallback_order):
-
-      attempt_allocation(gfp_flags);
-
-Because the local node does not have :code:`ZONE_MOVABLE`, the CXL node is
-functionally unreachable for direct allocation.  As a result, the only way
-for CXL capacity to be used is via `demotion` in the reclaim path.
-
-This configuration also means that if the DRAM ndoe has :code:`ZONE_MOVABLE`
-capacity - when that capacity is depleted, the page allocator will actually
-prefer CXL :code:`ZONE_MOVABLE` pages over DRAM :code:`ZONE_NORMAL` pages.
-
-We may wish to invert this priority in future Linux versions.
-
-If `demotion` and `swap` are disabled, Linux will begin to cause OOM crashes
-when the DRAM nodes are depleted. See the reclaim section for more details.
-
-
 CGroups and CPUSets
 ===================
 Finally, assuming CXL memory is reachable via the page allocation (i.e. onlined
-- 
2.50.1


