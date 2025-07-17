Return-Path: <linux-kernel+bounces-734451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DD7B08200
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 03:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B0FA7A2126
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5A14A62B;
	Thu, 17 Jul 2025 01:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlAflna8"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4019928E7;
	Thu, 17 Jul 2025 01:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752714231; cv=none; b=gZ8eeY+TvHGJoJr69fwijbhjktjdMdcolNclD5b73DgbZ9cxLIY7H8IPaBV5JLLRuL2LMm7JNzOr4b1bUum59C6fHNyEJVcCBtYAaCu6REl2xVDAYvxygcXlDNMrNLi/h40DEQy6HGvH6QKG0jDNE7TmqjESYhydaZzJ5fWZqFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752714231; c=relaxed/simple;
	bh=r7KBEe/U1rHOla01d//g2fAxzBm5HnT8XVj9/Cuyqu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITU0RmXZ4E8FDj8xoDKm+US4SHf+aI8bXPyBnVSlyaDNHLdZgFJYJgg9iOYMtBdBEw0McCwi6xvYCRiOGl+NjwRmwBJ621uOKbqxbF0u7pG4eSGieRMABy55orLP50ad0jlyQJw4a/gdIFMvMbh7CM9GUxCf92areWPaZP4YW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlAflna8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-455ecacfc32so1493875e9.3;
        Wed, 16 Jul 2025 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752714227; x=1753319027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sscvi53gVDM4UOp6lMcVQ4uaKrceVNglNU+jEsJsRcY=;
        b=AlAflna8anXBKT8lyhW8NZvStjTKwNNM+O0ZoRqufOk3VKIXScYI0o5agB+PQ17Vpl
         kdQlzI8HLdm3qztpBuGAcObf2dtOiiPlB2D5OpSrCFT3426Y6Q3p8kCLzvKKxsUuj4xa
         A/aaa9moKFS2aYW+yvg4K1aozD6Pc9nZfxLFQ4xm+AuE772e2STfScCKwBfvWAa8gxcj
         otaBoASL36GsFpuYNw9Cf8W6jvLGq4gj8qRvLEXTlbgvgJddRy94zJCwgAoD5N7J4A//
         K5WXGFRP2+M01vZ56cWyYWa1B6UcvrgMu3eOIX+6O5QTgQlRxQDp3uTn+MLa9BkymjTX
         82JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752714227; x=1753319027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sscvi53gVDM4UOp6lMcVQ4uaKrceVNglNU+jEsJsRcY=;
        b=RKHUy0xstSsTzYdeU3hvHCnw/K6PiBv/r6pWr7jDUvYopntnJhbk91fdmC3Co4d5dD
         b22UdrFQORFarpsS8GTLv09kaqW+K9VdI7qxviB+3v7wirf4IFvmHJKRpiPkQdmbYNs5
         uQmmEqmssHaFiJu2WfqFfNaR8WX6RpQp7Q1KUFDX/jhNnBwe9pYWXa6735Ib+Xe96rDL
         NmebwRb2SF9OIs74fGaLo9DvLHqiGi43Xl+TOsnaDaAP17ciH0GtNpw84dC4w4ZNBcHy
         Xk0fGmmB7OyXorlgyJOA4YXkoopzI7JupsSR/GALDk4KKJqAffnfsJmrBBySEuqcHLnV
         TXpA==
X-Forwarded-Encrypted: i=1; AJvYcCXFydB4JideFUpb4iYu1Ivlnpnih3eb8ixj8fugDqM1eQXOXktrGuDAIht9v+xcI8ufifQ6hQLTZos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP1ctIaseRITBuHfNH1mOdfxrhD17UDlp+KKAiB3v+WSctbENQ
	x5nnmI3xXQHzjhJGhB0ultAMPtctxxMg2Jkb9HC9zNg6/rjZiSSAJThv
X-Gm-Gg: ASbGncvgGWXTDEXtmBPGS340RSuMzahNBm/UL7of2hcefckD2yu7350u+E2GmUFd+Iq
	48WGw/4Ex4l9qtyfW/R7jUwkt/FoPQ3CKtQ8sDCUVogxP5aHhz+lLs347OFDGRq5oKuO9qeNRY1
	VSt596LzHrbTYGoirCA20LxQdua4hVX2kQWQfJ/jg8iGBlsERpgXt7JdS6Hq5yitU767XsiC3X7
	/CTC720tAdaoF88Ya+96Zsb5sys/pUU+HHElbh0WsMOIrINOy3qfgZRMm1mK3Pcsqpd15jUj6DK
	gB/MiiOAIrSkenVJDq900jMDha8RayNlCq+LoHu68GM+A02xUUs3JlpbGY2Qr8UCaQtqTCTPn68
	lWapXwOwlu7IeYiRpFHTEWw==
X-Google-Smtp-Source: AGHT+IFOgLZETh8Ec/9h9BgSa32GB4DdT5xGpUYmcL3HY81MNy2vA3E521MJaU8PzthhUPDX8qDx+A==
X-Received: by 2002:a05:6000:400e:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3b60dd6a91cmr4297940f8f.15.1752714227303;
        Wed, 16 Jul 2025 18:03:47 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e269a0sm19070592f8f.86.2025.07.16.18.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 18:03:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 85079420A818; Thu, 17 Jul 2025 08:03:41 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IOMMU <iommu@lists.linux.dev>
Cc: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Will Deacon <will@kernel.org>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Ashish Kalra <Ashish.Kalra@amd.com>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] iommu/amd: Wrap debugfs ABI testing symbols snippets in literal code blocks
Date: Thu, 17 Jul 2025 08:03:31 +0700
Message-ID: <20250717010331.8941-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6987; i=bagasdotme@gmail.com; h=from:subject; bh=r7KBEe/U1rHOla01d//g2fAxzBm5HnT8XVj9/Cuyqu8=; b=kA0DAAoW9rmJSVVRTqMByyZiAGh4SciiGSIRre2rNT1nmAv1l5NSQWz9aASgtyY9q/mCAYTqt 4h1BAAWCgAdFiEEkmEOgsu6MhTQh61B9rmJSVVRTqMFAmh4ScgACgkQ9rmJSVVRTqMe+wD/c3ep 8NeeT5p0fbdqd1ZGfdaNFgpyFwSvxjGWhSwueuwA/iinJIJLLzIwBLecFt/9F+PdVvVNsjn+7Vm BUFMVxCgL
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Commit 39215bb3b0d929 ("iommu/amd: Add documentation for AMD IOMMU
debugfs support") documents debugfs ABI symbols for AMD IOMMU, but
forgets to wrap examples snippets and their output in literal code
blocks, hence Sphinx reports indentation warnings:

Documentation/ABI/testing/debugfs-amd-iommu:31: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]
Documentation/ABI/testing/debugfs-amd-iommu:31: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

Wrap them to fix the warnings.

Fixes: 39215bb3b0d9 ("iommu/amd: Add documentation for AMD IOMMU debugfs support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250716204207.73869849@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/ABI/testing/debugfs-amd-iommu | 125 +++++++++++---------
 1 file changed, 71 insertions(+), 54 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-amd-iommu b/Documentation/ABI/testing/debugfs-amd-iommu
index c14b1620aec171..5621a66aa6936a 100644
--- a/Documentation/ABI/testing/debugfs-amd-iommu
+++ b/Documentation/ABI/testing/debugfs-amd-iommu
@@ -6,12 +6,14 @@ Description:
 		MMIO register offset for iommu<x>, and the file outputs the corresponding
 		MMIO register value of iommu<x>
 
-		Example:
-		$ echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
-		$ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
+		Example::
 
-		Output:
-		Offset:0x18 Value:0x000c22000003f48d
+		  $ echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
+		  $ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
+
+		Output::
+
+		  Offset:0x18 Value:0x000c22000003f48d
 
 What:		/sys/kernel/debug/iommu/amd/iommu<x>/capability
 Date:		January 2025
@@ -21,12 +23,14 @@ Description:
 		capability register offset for iommu<x>, and the file outputs the
 		corresponding capability register value of iommu<x>.
 
-		Example:
-		$ echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
-		$ cat /sys/kernel/debug/iommu/amd/iommu00/capability
+		Example::
 
-		Output:
-		Offset:0x10 Value:0x00203040
+		  $ echo "0x10" > /sys/kernel/debug/iommu/amd/iommu00/capability
+		  $ cat /sys/kernel/debug/iommu/amd/iommu00/capability
+
+		Output::
+
+		  Offset:0x10 Value:0x00203040
 
 What:		/sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
 Date:		January 2025
@@ -35,24 +39,26 @@ Description:
 		This file is a read-only output file containing iommu<x> command
 		buffer entries.
 
-		Examples:
-		$ cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
+		Examples::
 
-		Output:
-		CMD Buffer Head Offset:339 Tail Offset:339
-		  0: 00835001 10000001 00003c00 00000000
-		  1: 00000000 30000005 fffff003 7fffffff
-		  2: 00835001 10000001 00003c01 00000000
-		  3: 00000000 30000005 fffff003 7fffffff
-		  4: 00835001 10000001 00003c02 00000000
-		  5: 00000000 30000005 fffff003 7fffffff
-		  6: 00835001 10000001 00003c03 00000000
-		  7: 00000000 30000005 fffff003 7fffffff
-		  8: 00835001 10000001 00003c04 00000000
-		  9: 00000000 30000005 fffff003 7fffffff
-		 10: 00835001 10000001 00003c05 00000000
-		 11: 00000000 30000005 fffff003 7fffffff
-		[...]
+		  $ cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
+
+		Output::
+
+		  CMD Buffer Head Offset:339 Tail Offset:339
+		    0: 00835001 10000001 00003c00 00000000
+		    1: 00000000 30000005 fffff003 7fffffff
+		    2: 00835001 10000001 00003c01 00000000
+		    3: 00000000 30000005 fffff003 7fffffff
+		    4: 00835001 10000001 00003c02 00000000
+		    5: 00000000 30000005 fffff003 7fffffff
+		    6: 00835001 10000001 00003c03 00000000
+		    7: 00000000 30000005 fffff003 7fffffff
+		    8: 00835001 10000001 00003c04 00000000
+		    9: 00000000 30000005 fffff003 7fffffff
+		   10: 00835001 10000001 00003c05 00000000
+		   11: 00000000 30000005 fffff003 7fffffff
+		  [...]
 
 What:		/sys/kernel/debug/iommu/amd/devid
 Date:		January 2025
@@ -63,19 +69,26 @@ Description:
 		interrupt remapping table and device table.
 
 		Example:
-		1.
-		$ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
-		$ cat /sys/kernel/debug/iommu/amd/devid
 
-		Output:
-		0000:01:00.0
+		1.
+		  ::
+
+		    $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
+		    $ cat /sys/kernel/debug/iommu/amd/devid
+
+		  Output::
+
+		    0000:01:00.0
 
 		2.
-		$ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
-		$ cat /sys/kernel/debug/iommu/amd/devid
+		  ::
 
-		Output:
-		0000:01:00.0
+		    $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
+		    $ cat /sys/kernel/debug/iommu/amd/devid
+
+		  Output::
+
+		    0000:01:00.0
 
 What:		/sys/kernel/debug/iommu/amd/devtbl
 Date:		January 2025
@@ -84,12 +97,14 @@ Description:
 		This file is a read-only output file containing the device table entry
 		for the device ID provided in /sys/kernel/debug/iommu/amd/devid.
 
-		Example:
-		$ cat /sys/kernel/debug/iommu/amd/devtbl
+		Example::
 
-		Output:
-		DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
-		0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
+		  $ cat /sys/kernel/debug/iommu/amd/devtbl
+
+		Output::
+
+		  DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
+		  0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
 
 What:		/sys/kernel/debug/iommu/amd/irqtbl
 Date:		January 2025
@@ -98,17 +113,19 @@ Description:
 		This file is a read-only output file containing valid IRT table entries
 		for the device ID provided in /sys/kernel/debug/iommu/amd/devid.
 
-		Example:
-		$ cat /sys/kernel/debug/iommu/amd/irqtbl
+		Example::
 
-		Output:
-		DeviceId 0000:01:00.0
-		IRT[0000] 0000000000000020 0000000000000241
-		IRT[0001] 0000000000000020 0000000000000841
-		IRT[0002] 0000000000000020 0000000000002041
-		IRT[0003] 0000000000000020 0000000000008041
-		IRT[0004] 0000000000000020 0000000000020041
-		IRT[0005] 0000000000000020 0000000000080041
-		IRT[0006] 0000000000000020 0000000000200041
-		IRT[0007] 0000000000000020 0000000000800041
-		[...]
+		  $ cat /sys/kernel/debug/iommu/amd/irqtbl
+
+		Output::
+
+		  DeviceId 0000:01:00.0
+		  IRT[0000] 0000000000000020 0000000000000241
+		  IRT[0001] 0000000000000020 0000000000000841
+		  IRT[0002] 0000000000000020 0000000000002041
+		  IRT[0003] 0000000000000020 0000000000008041
+		  IRT[0004] 0000000000000020 0000000000020041
+		  IRT[0005] 0000000000000020 0000000000080041
+		  IRT[0006] 0000000000000020 0000000000200041
+		  IRT[0007] 0000000000000020 0000000000800041
+		  [...]

base-commit: 4ba382d42e2dd8294311fd4ee1ad446c8e5585aa
-- 
An old man doll... just what I always wanted! - Clara


