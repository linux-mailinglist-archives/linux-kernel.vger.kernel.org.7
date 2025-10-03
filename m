Return-Path: <linux-kernel+bounces-841394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F0CBB730E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 16:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6F44A0912
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D0621ABB9;
	Fri,  3 Oct 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QsglpAhS"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73521F8724
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759502016; cv=none; b=E3py4nzZcaWQU83RttSDYVWrYULOVlp86TKewlkBz3qKBCZHLZRMMqqqKftBDV9u6+1utATsgkOv6Y54YWZoapdu8C8w5HsA81RmOwMjFXlLT8mjTGYynuRi6NodJRSNCVgP5TkjNHk06/TkBO98Ia09dZlrqbONaViKT0Mfz7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759502016; c=relaxed/simple;
	bh=f0k+kW0Uq5dGtEoUx3uqrv98HH4BGEJvGHNwLn4gP3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XUtrzNhJ1Cn/XlWUHm2vRsflpt4M07B63esWGMb3naWAafs89wwkonnQzxIPDwq4ov7wNFn5pBu9fKCb7pky3hvlY/1s3S2lS9BuAZl4P+8uKVwq/tzYeeOstWqZtdCS0lGtDMdD/aVnDr0vLRKxM/0yAybI1H3CsiIV1spE4Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QsglpAhS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-858183680b4so294111285a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 07:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1759502014; x=1760106814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6dPEYp0SmulQxrX2drwOWKtF0shLYyrmazi9ATO4Jg=;
        b=QsglpAhSjdCPMD01m1v8tsdOknWuAsW8vg8xN7+mTQEVycJvAek1gwAhzmB6aarrDH
         FBhAvdPj6eP6NasL84Bng4bknZIKqmjMnHiIzbjbU3HxxPAqbmxFh1LExyUQ0ENA+1O1
         gZ1ushPCLGeUCleWgKU3nH7lipNeg0hPb7ZUwCMk9i5PTg6IsXJjIH0NmgMWnDRWrSoM
         MUZ8EqMUMpxKw6JnnyxqGts8sOA1yvvr1bXcYOqDGhLH3tPRnImz3FRFYxYXgy+6Rd91
         yq1NqdLyk3rs3qD65F9OUNwACcdSdjEIwddk/jcCgqm76rZ+pr51dKaxeZbWvn3sY1mf
         ykgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759502014; x=1760106814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6dPEYp0SmulQxrX2drwOWKtF0shLYyrmazi9ATO4Jg=;
        b=Ft7nm1evY3x8eHJaC2OZmig2m6lH6nvzQ7lJ9iIma0/vw6Yie1KCgWM5qg/nR3aOd5
         MbwtqOuYiPuvvOSTuMMLzNbll8oBB3Qho9CACzqsvribnPEyDoJk4wQ9Z9LMOC4a5Z2u
         ChusEtk/lzTrskq5qyCm9pV4xEHJvSmuEaD9njKf/5xwd59wsjnRfWNsqCARcbsWqbfB
         RAmArh023RjTGVPgGsWmSEg4j84Vp3n2GbecXnCRDOX4qA9NSpfPULHrh6mdApYgveMs
         DqyXHOX6cwklkba6/y453iLr3OshJwc3MTsVyKQGB4d4jjeJIwHloDVYDxe6KB7mO5fq
         TyyA==
X-Forwarded-Encrypted: i=1; AJvYcCUANq34NohQbeaWJ4lgr650HYYPQVGim1G5d0SMHXEUQZl+hGHxxadjuerwoeoRg3O7OZEt/blmQC1D55Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8mEkJhBRNFuH+aXbUnqSh3F1wa9tgjEAwSNkDxO+3KzsXqYmE
	NLugx1lW9vQedpAWbgxmTeJ3lYH/PQptLgsaURi+Myv+DcbTi/4kfdIcq5uctxmkujk=
X-Gm-Gg: ASbGnctdn4hzHg3NaWLG0wAsCn6F08VKj6aJfBWZSFV6TwqyLZas3hTU5D9/P1JwxJ6
	F9F8rTrKcohsJvZSBEmIEBRLsCvX1graMAJ1L9uOZsCl2fGfq7NV9ATB+hhKpf0/cS3yA/0fnhG
	Ud/8chezzETSjOK1zyVUNjk5Gb2KOHPJnL+w8PAGCpRTVfDMuaKbzqdoFEn0QY8RajysSoBrb88
	qFnmJIbmByxcWRBGQN8Cg1dBMByDZPk9JPFB+k31TK3qL2T1Wa1U80YQ+WtKIV5lby2fMfySiuI
	IoZ6R4JnjFcIc0W2I3hiUIufjYRmIEWG0GJp21qysw6OtHRCsmWhHxQM4Bt0MdDKuTh6saEtfa6
	RJj0Pyxi3dXN1zGMHYDge+eyIPmozQdfJzEwmeeGv6dx7NQXhFrYMazSCNQK8mP2FKDnKxW5Sqo
	iaOSu2/j1WsfRxjA64QFXvyIJ2/CDIGC6mxEM=
X-Google-Smtp-Source: AGHT+IEaQ0B2XmFj8U/GUa+p19UedSknVSwCkjKUNut/FbZ2W4QxK/tAJmdZIZwBzFFIVtotQb9hmA==
X-Received: by 2002:a05:620a:28cd:b0:858:ee50:25da with SMTP id af79cd13be357-87a38b336a1mr458817485a.63.1759501956557;
        Fri, 03 Oct 2025 07:32:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877797993e1sm426958685a.58.2025.10.03.07.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 07:32:36 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	corbet@lwn.net,
	gourry@gourry.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/driver-api/cxl: remove page-allocator quirk section
Date: Fri,  3 Oct 2025 10:32:32 -0400
Message-ID: <20251003143233.1985150-1-gourry@gourry.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The node/zone quirk section of the cxl documentation is incorrect.
The actual reason for fallback allocation misbehavior in the
described configuration is due to a kswapd/reclaim thrashing scenario
fixed by the linked patch.  Remove this section.

Link: https://lore.kernel.org/linux-mm/20250919162134.1098208-1-hannes@cmpxchg.org/
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
2.51.0


