Return-Path: <linux-kernel+bounces-805866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066FB48E95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EFA3420E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DC830AD12;
	Mon,  8 Sep 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="BKy9EOhD"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD713054ED
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336669; cv=none; b=D4FWeqdNXoc6B71qGUeRyNDGYxjwt2NQ1aMvBSDhU+HQI+Vcuoa25XzJ/2bPN1XjAmQ5QI6gILMPlJlP7DIkelHOBd37iAn6ZLkjHyoCK6h7sTXhcCVyBWLKLU50sUMLc8/wOe1R7LY0ikJMi7A2rWDtKbcaMalrG/nz+E09V7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336669; c=relaxed/simple;
	bh=boqo4D0Ut6Z85GE1PumcJoIJQxrDEFv9/JnfEr7I//0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UnjhD6R5uXbuc260njH/ReAdcdann2ScXQLu5bdit0JDz9K9ZKQVq3u1rtqEX2QT/BQwjZF1eFzPf+urXa335AI+eQ0sGj3fg6bvJQNuxiu86BSDLZ/P/xdqkxfsmYlE66V75j/cfcvF2UpSyPgn9TLH4kso0dtMYnqpR9sO+BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=BKy9EOhD; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1757336664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=byn18G7s2VhbZik+AaE4LMlS4ilFfprAqRoubR2e5f8=;
	b=BKy9EOhDW4zdny/HfyWlxbl6Bv5Hj39ETBoXd0o6Q8coGVMrquxQ5EFqntAgkwGFoRvwnR
	YVYvm00zqf9+4soKIaWcbbiq4d+YcTVCuV/9WtbvQUbr8HLajJKqlPxFzykzzFYp6t17io
	/408aUYt4WFS4T7XjA/PeoIOkkWEj1M1BS3et6hLKd4f2ExirsAHBilPfL6rM7AASA/3yY
	XME5FiSntkJ2QvmwSXlAa6OeL6wgjkbPZ/SLcK7fEzPw0R55G6miieOIwK/Yd92v7zh9xJ
	rb+VLOGtOVuS39cog5YQ9ieaOD4dAWfXZNnlvY4UsV2n0sHpc7Zwws8sXHVphg==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Mon, 08 Sep 2025 09:04:19 -0400
Subject: [PATCH v2] MAINTAINERS: remove Alyssa Rosenzweig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-kernel-retirement-v2-1-85c9d4d49f26@rosenzweig.io>
X-B4-Tracking: v=1; b=H4sIAFLUvmgC/32NSw6CQBAFr0J67Rh6BARX3sOwAH1AR50xPQQ/h
 Ls7cgCXVcmrN1OACgIdkpkUkwTxLoLdJHQeGtfDyCUy2dTmaZXuzRXqcDOKURR3uNF0zG1VccH
 ZLqe4eyg6ea3NUx15kDB6fa8XE//sv9rEhg2KLmstmktblkf1Ae7zhPRb8VQvy/IFIEt0wLYAA
 AA=
X-Change-ID: 20250907-kernel-retirement-f11b99161435
To: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, sven@kernel.org, 
 j@jannau.net, maz@kernel.org
Cc: Neal Gompa <neal@gompa.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Migadu-Flow: FLOW_OUT

I'm moving on to other projects [1] and no longer wish to be copied on
kernel patches. Remove my MAINTAINERS entries: both related to Apple
driver support. So long and thanks for all the fish.

[1] https://rosenzweig.io/blog/asahi-gpu-part-n.html

Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
Changes in v2:
- Also add to .get_maintainer.ignore (suggested to me off-list).
- Link to v1: https://lore.kernel.org/r/20250907-kernel-retirement-v1-1-e6f4b2eadb88@rosenzweig.io
---
 .get_maintainer.ignore | 1 +
 MAINTAINERS            | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/.get_maintainer.ignore b/.get_maintainer.ignore
index b458815f1d1bf4d03cbe81a80f8b478cea53ebed..e8d2269bad9d000194c203df1a5b36a18e2f1953 100644
--- a/.get_maintainer.ignore
+++ b/.get_maintainer.ignore
@@ -1,5 +1,6 @@
 Alan Cox <alan@lxorguk.ukuu.org.uk>
 Alan Cox <root@hraefn.swansea.linux.org.uk>
+Alyssa Rosenzweig <alyssa@rosenzweig.io>
 Christoph Hellwig <hch@lst.de>
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>
 Marc Gonzalez <marc.w.gonzalez@free.fr>
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..3c10a189421c9d20247ad1546ba4af31556c87cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1845,7 +1845,6 @@ S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
 
 APPLE PCIE CONTROLLER DRIVER
-M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 M:	Marc Zyngier <maz@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
@@ -2364,7 +2363,6 @@ F:	sound/soc/codecs/ssm3515.c
 ARM/APPLE MACHINE SUPPORT
 M:	Sven Peter <sven@kernel.org>
 M:	Janne Grunau <j@jannau.net>
-R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 R:	Neal Gompa <neal@gompa.dev>
 L:	asahi@lists.linux.dev
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250907-kernel-retirement-f11b99161435

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


