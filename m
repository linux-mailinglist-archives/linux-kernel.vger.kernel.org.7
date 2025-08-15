Return-Path: <linux-kernel+bounces-770972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1F4B28122
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585D160314A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902453009F6;
	Fri, 15 Aug 2025 13:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="FHaDPKJ6"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0827929D05
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266323; cv=none; b=ZYoYKbAL0gG0TTawGF1tqeeNsUjmnf7ey5PfZhXw8NYyaQyB3M3/AZRNw4ZFXod0H21kPWJC9OYHtzhiugyCQD0iM5liSxGJMjRLGLyKw8g08/tWKXWFj/B5yP1Vw6s4RXfXZYAlwZfO5MnayF61ft5YkDysmtee9v7DHQpI7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266323; c=relaxed/simple;
	bh=EKAkIF2g3jZRCCcRl0kzUAgwxMMswi+UHKiZD8FG8Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=G3e1vtpfrt2ZdBju+8ylctOGsb4EXPdxAp/YQzLfH8dELKUSrRpMbIM7rwUSESwIDRVhUHjbYBXl982A2JtDujV27T67O3/THQfo+xGjuFtRcI+BK3RMqutUcAlzykGj5e05HPOaHqyVQxCY3Y/M1nQlRutAZUQd1TN67JyYwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=FHaDPKJ6; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7B09FA1132;
	Fri, 15 Aug 2025 15:58:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=ZPSJcLnKcVpWD3NTF2ZlZ0UCAXjT3T7xjOMbng/3RBU=; b=
	FHaDPKJ6cE/pYH4ewjL0SSgOcM3dqNRZxJLazVyf4EHewe0uTDgnYM6FuX7MKze/
	hlT2WbfP1n7XsuhRTPRD3y0n1zZQqAsC5WQ49x97LScoIetLpP3rYLQ8V8cR6EeE
	XEcGbAuvPMCnX2eQM2hvWhHyb6hXjWytHXagCDiawvAAq2X0yoU6mH1Ph7A1Nf1C
	w7hsV9N9UxM60DuRPHsQKevdLxHzsoXm3+FropK1/fSuoFrWnDd5yHmzhoDuB/sR
	i28ZjGWGcqPNPW4XFuwEYD77qsr76s1o7VJu2sgYblZB8jOLyom2avj8W1rXGv28
	exerNx+smoSuxIwwLFpCTI058vnrSuaMbyzKVFfmpalaAdE/yp2DpmSEKxR3sHfp
	VZvAYJY5P3+wSH2PPMaYWoxGmADp+ppjKZuGGjFMgTeabY99spcwMtWR9GI6ep9K
	gDR+nlBRcMBZwW3bm4lYx4U6oB7Y6moBgtmp4RrbJAOfa/aHAcdB7IwvPwJ+njRp
	0ym+h8AbJ8Xc0Dk4Z1gQe47jBDQxSmexkoo3e/84fNiqBKkIptR8ELbWxQGWW5nJ
	Gs8ghUT+tgxJC+TWd07HYk8fEnZ6GNM2tEyeey+Ue8VocQLdqMHc6BEJLbVAQ+4e
	baTmDKyWLgyvloE9bSC96u8pHhpznxCtc2QEqjIGTSQ=
From: =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
Date: Fri, 15 Aug 2025 15:58:29 +0200
Subject: [PATCH] Documentation: sysfs-pps: Fix `Description:`s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250815-b4-sysfs-pps-doc-v1-1-61d315eafbca@prolan.hu>
X-B4-Tracking: v=1; b=H4sIAAQ9n2gC/x3MTQqDMBBA4avIrB1IQkLFq5Qu8jPW2YwhI2IR7
 960y2/x3gVKjUlhHi5odLDyJh12HCCvUd6EXLrBGRfMZAMmj/rRRbFWxbJldA9DwZcYbPLQs9p
 o4fO/fL66U1TC1KLk9TcS2lHo3OG+v/DT/yl9AAAA
X-Change-ID: 20250815-b4-sysfs-pps-doc-270e54da51b4
To: Rodolfo Giometti <giometti@enneenne.com>
CC: <linux-kernel@vger.kernel.org>, =?utf-8?q?Bence_Cs=C3=B3k=C3=A1s?=
	<csokas.bence@prolan.hu>, Rodolfo Giometti <giometti@linux.it>
X-Mailer: b4 0.14.2
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1755266310;VERSION=7996;MC=924765609;ID=1129803;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155E617063

It is unnecessary to duplicate `What:` content in the description. It
makes it harder to both read and maintain.

Also, the uapi header no longer lives at `linux/include/linux/pps.h`.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 Documentation/ABI/testing/sysfs-pps     | 29 ++++++++++++-----------------
 Documentation/ABI/testing/sysfs-pps-gen |  2 +-
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
index 25028c7bc37d8e50a2d4b53d954a2a0628c4a582..b8034ead5ae530c99fcfd280f295057823a3d613 100644
--- a/Documentation/ABI/testing/sysfs-pps
+++ b/Documentation/ABI/testing/sysfs-pps
@@ -10,16 +10,16 @@ What:		/sys/class/pps/ppsX/
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
 Description:
-		The /sys/class/pps/ppsX/ directory is related to X-th
-		PPS source into the system. Each directory will
-		contain files to manage and control its PPS source.
+		This directory represents the X-th PPS source in the system.
+		Each directory will contain files to manage and control its
+		PPS source.
 
 What:		/sys/class/pps/ppsX/assert
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
 Description:
-		The /sys/class/pps/ppsX/assert file reports the assert events
-		and the assert sequence number of the X-th source in the form:
+		This file reports the assert events and the assert sequence
+		number in the form:
 
 			<secs>.<nsec>#<sequence>
 
@@ -30,8 +30,8 @@ What:		/sys/class/pps/ppsX/clear
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
 Description:
-		The /sys/class/pps/ppsX/clear file reports the clear events
-		and the clear sequence number of the X-th source in the form:
+		This file reports the clear events and the clear sequence
+		number in the form:
 
 			<secs>.<nsec>#<sequence>
 
@@ -42,32 +42,27 @@ What:		/sys/class/pps/ppsX/mode
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
 Description:
-		The /sys/class/pps/ppsX/mode file reports the functioning
-		mode of the X-th source in hexadecimal encoding.
+		This file reports the mode bits in hexadecimal encoding.
 
-		Please, refer to linux/include/linux/pps.h for further
-		info.
+		Please refer to <linux/pps.h> for further info.
 
 What:		/sys/class/pps/ppsX/echo
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
 Description:
-		The /sys/class/pps/ppsX/echo file reports if the X-th does
-		or does not support an "echo" function.
+		Whether this source supports an "echo" function.
 
 What:		/sys/class/pps/ppsX/name
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
 Description:
-		The /sys/class/pps/ppsX/name file reports the name of the
-		X-th source.
+		The name of the PPS source.
 
 What:		/sys/class/pps/ppsX/path
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
 Description:
-		The /sys/class/pps/ppsX/path file reports the path name of
-		the device connected with the X-th source.
+		The path name of the device connected to this source.
 
 		If the source is not connected with any device the content
 		of this file is empty.
diff --git a/Documentation/ABI/testing/sysfs-pps-gen b/Documentation/ABI/testing/sysfs-pps-gen
index 2519207b88fdffdc404238409cb03d0112ce1958..c36bac37a883f1d702ff97e63603d4df7e24de83 100644
--- a/Documentation/ABI/testing/sysfs-pps-gen
+++ b/Documentation/ABI/testing/sysfs-pps-gen
@@ -12,7 +12,7 @@ Date:		February 2025
 KernelVersion:  6.13
 Contact:	Rodolfo Giometti <giometti@enneenne.com>
 Description:
-		The /sys/class/pps-gen/pps-genX/ directory is related to X-th
+		This directory represents the X-th
 		PPS generator in the system. Each directory contain files to
 		manage and control its PPS generator.
 

---
base-commit: 88250d40ed59d2b3c2dff788e9065caa7eb4dba0
change-id: 20250815-b4-sysfs-pps-doc-270e54da51b4

Best regards,
-- 
Bence Csókás <csokas.bence@prolan.hu>



