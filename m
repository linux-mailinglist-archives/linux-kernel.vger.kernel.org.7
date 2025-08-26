Return-Path: <linux-kernel+bounces-786801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B177EB36AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27E95869F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 14:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA7352074;
	Tue, 26 Aug 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XCIoqawS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dq63S6NK"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2672A35207F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756218337; cv=none; b=KVB5EVn9cGARmk0vtDCuPBJ3kgb2bR0FLmS7OdQ2b1LxRmM/t6bKPReZk5rK8OwUlvc4qTbWsXOmm/TU1ksSbyf7eXwV5cHYDrg1z4IvNJNu/FFoxjHoaqGjzHV24Owea4qUzSdXjzuPmhydyAmmjZivb/4CzDQuXNQEhfnHF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756218337; c=relaxed/simple;
	bh=l09/IEebklIK/Eqx1Fth6P//mXx/yr1jpJLS1onaQVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mLN0iO9Bx6ZzvyBSYt7LjhSAnOijADE3rciSD3DDFw5xXLcrZEND+nTG9Zc6zdB6rHv2xoibXu9BvOe7DWrH1C7ARFTyTNFVwubGUCyrVNecXd3sWAYDj7DGCY5MLt0HFGeeF32KgZvBTSx/B40YS0Y8e+drh0EakK1bu8H6UCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XCIoqawS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dq63S6NK reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756218334; x=1787754334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4Xc/PHP79K7OcUXYd9xwXOEeSBAN7ZoHnn2wNUgop5w=;
  b=XCIoqawSGLnWv7KsaZfPosDlx/pd6v+Xkn5A4XrfjPJxd+pxTM9xYFno
   RVlVlA74U1iK6WF6ITCHpCCxPLFdokZerVsGC2fT1/bP9phDwdbrjdyU0
   +GIjyES8QSj/MItpml/5fz5Kcp9RN5yYOkxNWJ30ok7dB6je7nzG/oOP1
   gcNL5Z2/q5M85rPekF9spCXFy2Iu1whhUoh+wzHJEZyatfyQYIl/AUqPg
   8ccZt0Vg+tgubbJPZ0CPnEdaAz6gsKDa4C2PnHyQXz/a2SuYeCVPGgkz8
   wJ47lk1dZpLB6oQhn+ZWtPWp43e0Vp/YA0CcYHlj/95XOZrS1gLGgdKAS
   Q==;
X-CSE-ConnectionGUID: QgH0+YLUT2S0IoPcBAzjFw==
X-CSE-MsgGUID: LUGeoco1TlihimYj8UbQUg==
X-IronPort-AV: E=Sophos;i="6.18,214,1751234400"; 
   d="scan'208";a="45917613"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Aug 2025 16:25:31 +0200
X-CheckPoint: {68ADC3DB-6-20CAA7DA-EC9DC758}
X-MAIL-CPID: 7FF6881006BC76F6B23B54406A99D6C2_0
X-Control-Analysis: str=0001.0A002101.68ADC3DB.0098,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 48B63160070;
	Tue, 26 Aug 2025 16:25:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756218326; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=4Xc/PHP79K7OcUXYd9xwXOEeSBAN7ZoHnn2wNUgop5w=;
	b=dq63S6NKhMPNFSXnqmQZ4o97qDL0Ib06Qn0S06kKyxLpKxHKl+wOYHN0mTUK2ZDmCzLcLN
	FDPelSed8/4wuItVd2807hfNjC4cDUL0gNYJjddxgMJ/axEvrq81lKvNofDNHUi0F0htv0
	KnevjU6vVABvRenctfStGpIHE1YreXeAflbFC34prp9FEq+yOgaqIxU9g0nF75+CtWzOjR
	2qil9Hy1oAWjcix2b3FCJbO4iBmfey4USIrzS26yReWa6zD7BfuUKVAcyscn2KL2UecSrB
	/TE2OduvoX2bXxtEP7jmD9jSmsN6+7R5VmAtR/rSabH1Y2knE6m9r9b4necuVA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] tools: use basename to identify file in gen-mach-types
Date: Tue, 26 Aug 2025 16:25:17 +0200
Message-ID: <20250826142518.2583999-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Bruce Ashfield <bruce.ashfield@gmail.com>

FILENAME is replaced by the full path to the executing script. If
the script is executed via a fully specified path, that is captured
in the output. Although it doesn't impact the output, it does trigger
reproducibility warnings/errors.

So we introduce a basename() function in the script and use it to
make sure the output file contains only the name of the awk script.
The motivation for this change is Yocto emitting a build warning
  WARNING: linux-tq-6.12.41+git-r0 do_package_qa: QA Issue: File /usr/src/debug/linux-tq/6.12.41+git/arch/arm/include/generated/asm/mach-types.h in package linux-tq-src contains reference to TMPDIR [buildpaths]

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/tools/gen-mach-types | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/tools/gen-mach-types b/arch/arm/tools/gen-mach-types
index cbe1c33bb8710..ab69d408f9e12 100644
--- a/arch/arm/tools/gen-mach-types
+++ b/arch/arm/tools/gen-mach-types
@@ -21,10 +21,14 @@ NF == 3 {
 	  num[nr] = ""; nr++
 	}
 
+	function basename(file) {
+	   sub(".*/", "", file)
+	   return file
+	}
 
 END	{
 	  printf("/*\n");
-	  printf(" * This was automagically generated from %s!\n", FILENAME);
+	  printf(" * This was automagically generated from %s!\n", basename(FILENAME));
 	  printf(" * Do NOT edit\n");
 	  printf(" */\n\n");
 	  printf("#ifndef __ASM_ARM_MACH_TYPE_H\n");
-- 
2.43.0


