Return-Path: <linux-kernel+bounces-758602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80617B1D140
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 05:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40B753A3A8E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106DA1DE4CA;
	Thu,  7 Aug 2025 03:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="V0U7W+hu"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49650524F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 03:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537658; cv=none; b=S+mWj/c1WhlJoLG/0BHuPOv7b4n5US/WVsyaDoIF+rRCzleIC6jrDz2spr4mOyDpDoKsOCITB/rvssQ6EXRgGmPSqVFk4XC2zDzhcWXccKio5B+Ac6WdTPdKkjiBdLxQMPMXCvwftsX2LqZCLYfWR0oJQtS/+BVj7E3TOgH4h0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537658; c=relaxed/simple;
	bh=Ibx9Bltnvn86+Mffl7e+s176pcBn4D82Z7YerShOWBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bv/h0kr9+8ySBSax2IzrwwO4iQQJ0hq9tyhj43jEh/FCrgzos1b3CJmLDkPUHL00c4lkDrjlNOfmEmPoQ72FKwe1e/8095TOoJ4CJY5ztlPA9HmVcG3Qf1olf9nVRjV1QIt96TwNy4fLThVAat9ic6+VZIjDzW9OFUgpzgrArPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=V0U7W+hu; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4K
	oFYVJlbu0CVVqOvGvUZRGS5uUL7FqL1hRsqc0+7RU=; b=V0U7W+huX5yHgJxrmA
	0Bn9rwbaKgrIUvseg8hv7b8DmjInSuN6+Cn2UrNJF8e0b+2010NeTbHK7rw4QlYB
	ZvhZiY+ipW1CMXEaXhj1nAmHykk5tnNMaC6PDCzvbgpjWm7YYTXXh1mVGpZWYJN5
	J6gyzS8Ho/+4V6LcmTjkv2554=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wAHjXGxHpRoTj0UAQ--.10072S2;
	Thu, 07 Aug 2025 11:34:10 +0800 (CST)
From: "longguang.yue" <bigclouds@163.com>
To: linux-kernel@vger.kernel.org
Cc: "longguang.yue" <bigclouds@163.com>
Subject: [PATCH] Makefile: mrproper deletes signing_key.x509
Date: Thu,  7 Aug 2025 11:33:46 +0800
Message-Id: <20250807033346.12642-1-bigclouds@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHjXGxHpRoTj0UAQ--.10072S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjfU5PETUUUUU
X-CM-SenderInfo: peljuzprxg2qqrwthudrp/1tbioAiiQ2iUHOctzAAAsv

deletes temporary signing_key.x509 and reserves user-defined x509.genkey

Signed-off-by: longguang.yue <bigclouds@163.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 37e37565515e..7ad2679fa1ab 100644
--- a/Makefile
+++ b/Makefile
@@ -1589,7 +1589,7 @@ MRPROPER_FILES += include/config include/generated          \
 		  .config .config.old .version \
 		  Module.symvers \
 		  certs/signing_key.pem \
-		  certs/x509.genkey \
+		  certs/signing_key.x509 \
 		  vmlinux-gdb.py \
 		  rpmbuild \
 		  rust/libmacros.so rust/libmacros.dylib
-- 
2.34.1


