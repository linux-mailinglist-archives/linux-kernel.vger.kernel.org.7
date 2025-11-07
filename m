Return-Path: <linux-kernel+bounces-890548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D9923C404D6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83C4134E161
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3543A329C4B;
	Fri,  7 Nov 2025 14:23:26 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D700A328B48;
	Fri,  7 Nov 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525405; cv=none; b=nCPIFvJkL5ch7P/3F2Ssz7alQrpzpvi0U9c6pTxqDY3g8PhGzp3RMI3rspeusRBeZtYP1V8qD07iIXt5Ac2GsT+FLg5s9Qxw039aa3/FfzIw7Ms/sXGhJlFNKnkSvgtN7mDoI2N/j4SKtyCK10V/Sp8Gr/PZZAKVV3J1+QcKzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525405; c=relaxed/simple;
	bh=9SlaqGcPSvj6PVufICMnZvQnvPxy0cvIV9NGMVLQwxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Igt6KYAowo2f98C6QwThYO0gCpid+AeZQhw+CAyQWdJ51SpKU/7G4X95fojaVRj58UEJNnBLR1J8Tl7A0cmbD29sJgnYlISNfpEZ/9hJeoWl759/Z+0T8CB05e5LQGigjirxeIgziVx7oNGMO3RapJDFpVA30U0byomkV/ixQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from localhost (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id F3EA079FE5;
	Fri, 07 Nov 2025 15:17:05 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH 3/3] Documentation: admin-guide: media: mgb4: Add GMSL1 & GMSL3-coax modules info
Date: Fri,  7 Nov 2025 15:16:48 +0100
Message-ID: <20251107141648.1889-4-tumic@gpxsee.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107141648.1889-1-tumic@gpxsee.org>
References: <20251107141648.1889-1-tumic@gpxsee.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Martin Tůma <martin.tuma@digiteqautomotive.com>

Add the mgb4 GMSL1 and GMSL3-coax modules info.

Signed-off-by: Martin Tůma <martin.tuma@digiteqautomotive.com>
---
 Documentation/admin-guide/media/mgb4.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/media/mgb4.rst b/Documentation/admin-guide/media/mgb4.rst
index 5ac69b833a7a..0a8a56e837f7 100644
--- a/Documentation/admin-guide/media/mgb4.rst
+++ b/Documentation/admin-guide/media/mgb4.rst
@@ -31,9 +31,11 @@ Global (PCI card) parameters
 
     | 0 - No module present
     | 1 - FPDL3
-    | 2 - GMSL (one serializer, two daisy chained deserializers)
-    | 3 - GMSL (one serializer, two deserializers)
-    | 4 - GMSL (two deserializers with two daisy chain outputs)
+    | 2 - GMSL3 (one serializer, two daisy chained deserializers)
+    | 3 - GMSL3 (one serializer, two deserializers)
+    | 4 - GMSL3 (two deserializers with two daisy chain outputs)
+    | 6 - GMSL1
+    | 8 - GMSL3 coax
 
 **module_version** (R):
     Module version number. Zero in case of a missing module.
@@ -42,7 +44,8 @@ Global (PCI card) parameters
     Firmware type.
 
     | 1 - FPDL3
-    | 2 - GMSL
+    | 2 - GMSL3
+    | 3 - GMSL1
 
 **fw_version** (R):
     Firmware version number.
-- 
2.51.0


