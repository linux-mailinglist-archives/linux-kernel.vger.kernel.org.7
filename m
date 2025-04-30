Return-Path: <linux-kernel+bounces-627641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC38AAA5357
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 20:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD357B5E49
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D90265627;
	Wed, 30 Apr 2025 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aqsIxHzr"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DD25B1C2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036664; cv=none; b=qyjAXmuCaMQs/oMANcA4+JHAgpry14xPxX8FmTj5Ry2XQNQ7ZNmcmIjkOaZ8tNPWfD3vOfXQArjYdjCe3gykeJFj0YQsvdRcmif+5TsV3dkopumhOwimpPjDfLE94r7G0cN+HbhsopGCYY69pURtj7Uw7TCYrdAqTWFz4mvNu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036664; c=relaxed/simple;
	bh=bc+l52lzMgg34Vw41X2Wy/FxQj+yccNEeALSbRGK27Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tPFNaYi8pCZf09DZ8G3r4iAPUd3FC0Sl/V7HMpEWZcWmY+yR0DXDiuj+ro4LSOGxia/0YlAAJ4FzW8sFuZDY//kAtNggvl4N8bXhnoj0BBAdptSLnOABf73vICXioH6yIrtzgqm1uxkSgacEbngBV/biM7NMigY9eO9Zl03jbwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aqsIxHzr; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476977848c4so2562121cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746036662; x=1746641462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3rVHINvuxD50BlXL+fWePXRUBl5vPBCCVNAK+caSv0=;
        b=aqsIxHzrJDIZL/iYJd6VsqJJjdiFAzqfLxhI4c46o8J6KLCx/Y3bPNgzOBp2E+01Pr
         OXf43OGl9NJZz4y9nguXpWSkt1s5CD5lV9m3Dm5VxODJDQmXuDJgMd4Wr4VAsu2k+i4b
         539NJAljiflbVOnndzTRP6wK3IG6IZ9hZUuHWBdFz/6o61bNb3GwWaymj6UVJ/hOPSh8
         PEg9kHMtIRg70gxZ+0VZ4F1nd+6zfNDXGEuGSuMZwQxg+gFaND4xa/FMOVrpiHdiXAAu
         /G8pMCsxJOeo76u0sC9OdJtBFHpSYzwUxqIaA2/2sqw+LHEE5DORUh41lJn8z+ShKsxn
         w20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036662; x=1746641462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3rVHINvuxD50BlXL+fWePXRUBl5vPBCCVNAK+caSv0=;
        b=ocHdv0KvdK+kSK1IwXgL0DWLBXKK8sxUsFsTayToADE2HSfQFHuz2nE0DlO4ESJiDD
         FLJF3Z67EYyw7w5k1RW2eH0MgN3SzE5r8frdtPZa2Fb/al+4vUek3CPBUdQKsLvdSqbT
         2RfPx/o2R1xKZCFkPSmq3qHdixND9IT8N8Whoas0MM7iCcc4QikPWivGV9aBWUOANiqm
         44DH+NVaf5zb2gQupgYjh7mRNwsRMZiBZrzWD8wjrXkmNfB3y6s+QVRQXrThaYu7bPjK
         rPKCfnQIMVzyih9d2Owo7ODWUx/VgNTXgPwo2WPh8cVQPlDX1S3NHXd8VlSIx+eyaFR6
         B12g==
X-Forwarded-Encrypted: i=1; AJvYcCUhdohp8KljdnqkQjNAj8r6BPt6HPOD4Iyd3sOq0ypS9JdvQNhvoHVs6blSo42WylzDs8LR9ZRW5aCf/xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2EMuUCY4f0qcqQ43uRBek6JJGNAhc1oPpl/p3HEoNOS+nbBO
	q5CMmgoQ8pR6Kqs5E5hcoJNMMV0nl7lQ95Bp/2zsi6YT2NJH07IsM3Tj41RDUXc=
X-Gm-Gg: ASbGncvEaxF251VaBrQ2ZlmDZ5/BEfB12+3h7Meb4StV8LQsgzOFlC85QKegEFbxqax
	+NsrOufmal3lVvpqe0nnI4cEOLH3bLUD6MDMFPYpc/DUwkgyJa6VtFpmuURLxvJ0Y/x7/h6rcKD
	wdHXcGd8WyQ1fgRNwqrSacZLEUgQaqiwubvlB7qwipo/HX0+7jn6SAORgkCqvO20C4HYaa9w6lL
	hBHH/vJ5IlD6uonbHLiv353LMTBF/eJeTzaMeXZbxyXPawTrZINEcue/tRq9Vms08XtEzq7CIKL
	C5MITlBMUyDVD20Z3cGGXPV4uz1KLhJzBwsOAhX000iICS2cWslzEL0W+H6FRrg/ZZAzhKdd8tT
	7B7bu6B18ZAVQPOY1WQnJgDbLSlyI
X-Google-Smtp-Source: AGHT+IFEFexCZkfsgjT0Bdcj5OkkLcxTMyz8IGrh8K077WV+JwvSahKI4mujBFQCFuESr0+In0WTAQ==
X-Received: by 2002:a05:622a:5815:b0:477:e7c:a4c with SMTP id d75a77b69052e-489c5212aebmr68148911cf.39.1746036661817;
        Wed, 30 Apr 2025 11:11:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48a64fe04efsm5897421cf.19.2025.04.30.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:01 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net
Subject: [RFC PATCH v2 01/18] cxl: update documentation structure in prep for new docs
Date: Wed, 30 Apr 2025 14:10:31 -0400
Message-ID: <20250430181048.1197475-2-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430181048.1197475-1-gourry@gourry.net>
References: <20250430181048.1197475-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restructure the cxl folder to make adding docs per-page cleaner.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 Documentation/driver-api/cxl/index.rst           | 16 +++++++++++++---
 .../cxl/{ => linux}/access-coordinates.rst       |  0
 ...emory-devices.rst => theory-of-operation.rst} | 10 +++++-----
 3 files changed, 18 insertions(+), 8 deletions(-)
 rename Documentation/driver-api/cxl/{ => linux}/access-coordinates.rst (100%)
 rename Documentation/driver-api/cxl/{memory-devices.rst => theory-of-operation.rst} (98%)

diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
index 965ba90e8fb7..fe1594dc6778 100644
--- a/Documentation/driver-api/cxl/index.rst
+++ b/Documentation/driver-api/cxl/index.rst
@@ -4,12 +4,22 @@
 Compute Express Link
 ====================
 
+CXL device configuration has a complex handoff between platform (Hardware,
+BIOS, EFI), OS (early boot, core kernel, driver), and user policy decisions
+that have impacts on each other.  The docs here break up configurations steps.
+
+.. toctree::
+   :maxdepth: 2
+   :caption: Overview
+
+   theory-of-operation
+   maturity-map
+
 .. toctree::
    :maxdepth: 1
+   :caption: Linux Kernel Configuration
 
-   memory-devices
-   access-coordinates
+   linux/access-coordinates
 
-   maturity-map
 
 .. only::  subproject and html
diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/linux/access-coordinates.rst
similarity index 100%
rename from Documentation/driver-api/cxl/access-coordinates.rst
rename to Documentation/driver-api/cxl/linux/access-coordinates.rst
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/theory-of-operation.rst
similarity index 98%
rename from Documentation/driver-api/cxl/memory-devices.rst
rename to Documentation/driver-api/cxl/theory-of-operation.rst
index d732c42526df..32739e253453 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/theory-of-operation.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. include:: <isonum.txt>
 
-===================================
-Compute Express Link Memory Devices
-===================================
+===============================================
+Compute Express Link Driver Theory of Operation
+===============================================
 
 A Compute Express Link Memory Device is a CXL component that implements the
 CXL.mem protocol. It contains some amount of volatile memory, persistent memory,
@@ -14,8 +14,8 @@ that optionally define a device's contribution to an interleaved address
 range across multiple devices underneath a host-bridge or interleaved
 across host-bridges.
 
-CXL Bus: Theory of Operation
-============================
+The CXL Bus
+===========
 Similar to how a RAID driver takes disk objects and assembles them into a new
 logical device, the CXL subsystem is tasked to take PCIe and ACPI objects and
 assemble them into a CXL.mem decode topology. The need for runtime configuration
-- 
2.49.0


