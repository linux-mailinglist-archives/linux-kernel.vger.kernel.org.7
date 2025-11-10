Return-Path: <linux-kernel+bounces-892901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4255BC4611B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 32DE24E9813
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095223081A4;
	Mon, 10 Nov 2025 10:54:19 +0000 (UTC)
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A5268C40;
	Mon, 10 Nov 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.14.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772058; cv=none; b=pb7x+lMUpCYsEfsn06APuU8H9PALdx+Le0LT/dr/hX1q0YjDfAc1TSA9g1Jp0QlH9yV3+pKTCeIRlAV1BEkEwfWael0gpopE5hmOCaG1sH2k9SfSkPSf8iR7Iu2xFff3sgPUms4TScen/Q8IZ/G6IKDAM89Dm61kfGm4y2eREJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772058; c=relaxed/simple;
	bh=9SlaqGcPSvj6PVufICMnZvQnvPxy0cvIV9NGMVLQwxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZwDbjfY6J8UN+L6kH7NtF8TSRFMUdcM3+JmlDNpQBKLS745nVkFU33U9UCV5EQwOrcVewptafDDp1OH5u+mZ0ZZ1iXdCcW7d4uaLM0LXFhGXYfRMLAZy7nCbWh3cyF2V7A7rR7KT+5+zWO3/OQEX+JAcJ06IuVD5CnD7ERLtsvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org; spf=pass smtp.mailfrom=gpxsee.org; arc=none smtp.client-ip=37.205.14.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gpxsee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gpxsee.org
Received: from mgb4.digiteq.red (unknown [62.77.71.229])
	by mx.gpxsee.org (Postfix) with ESMTPSA id E437530D8B;
	Mon, 10 Nov 2025 11:54:06 +0100 (CET)
From: tumic@gpxsee.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20T=C5=AFma?= <martin.tuma@digiteqautomotive.com>
Subject: [PATCH v2 3/3] Documentation: admin-guide: media: mgb4: Add GMSL1 & GMSL3-coax modules info
Date: Mon, 10 Nov 2025 11:53:57 +0100
Message-ID: <20251110105357.1813-4-tumic@gpxsee.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110105357.1813-1-tumic@gpxsee.org>
References: <20251110105357.1813-1-tumic@gpxsee.org>
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


