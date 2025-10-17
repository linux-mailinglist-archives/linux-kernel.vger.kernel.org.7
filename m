Return-Path: <linux-kernel+bounces-858115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E67FBE8FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51DA835C349
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101AA34AAEE;
	Fri, 17 Oct 2025 13:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLG6Go9g"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409634AAE7
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708783; cv=none; b=IyqEx4QqI8ITZh/XklUx+VEjiJs+oyo/3q8FwhWZF+0AFsCqalz5a419k9a8RKr7+k94nLVmRGQmZD7xGApw0s00kL+k4hQHXQwGRgTHWKOx/BQnP6I27OtE1S8lHYzkVcwh8qA3dnwhgVK9s8W2YehHu9QV+vIiHZ4ajp2f2ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708783; c=relaxed/simple;
	bh=FrcUFbCjux8hx30xA1Y96H6s9eZe6s3XK6jOYQ+DQ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHzbISIJJCmB1UeCI/pLc/Q5wvYp6xrfyv6cczcSP7g8pb+MCYzh2XVF8DUkSqs14biMq4FXqxg8l69S22SmPORs4eT0ajKv1HUTkgyy24LpobQirVsLPBzH5d0HXGI827EJA5RwmPKgT6BSt1w5MGinwWYZxhWVABtHk3VfWKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLG6Go9g; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1607037a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 06:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760708781; x=1761313581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8wxeZ73zfPxZDqjOffcWW0zKOqaQGOLDGU9q6V4WVw=;
        b=nLG6Go9gJ8qnjiEfvPKJh1m+xs6qjopJWw2lnkUkn8aKTFNnzF+GRNS3kkvY6eCZwd
         46Ph/ejYSNg9gaDqTl5YN8eNOvp3+HzkQ4LVI6X3k3V/p8YWuf0Y9FfiUvvhVInVgsJa
         3cz4HoKCiFESVbbTmXt20Kvv/8KjTH6HzmnReM+oTzZA77FliWdrVWRblEonUfz56ZNQ
         ku0tXcKhGCLTs50diNHB+vQE+FqH+uOsIAKl5T6V+kI18KkT82+HoM5yW0H3EHHtYWK6
         MqoVpUrXGxZRSXJawgxaUkzzv/RbdRsUW2rfa4XRmoNsmyJERV4cZz52vSYTDC4w4CzP
         RPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760708781; x=1761313581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8wxeZ73zfPxZDqjOffcWW0zKOqaQGOLDGU9q6V4WVw=;
        b=jEYqNgNsg5mEOb0T2BBZzUZD8153hxG59VUN84VjvvjIEZL0H0dvcJPFOnBvIZ5Wk3
         mFQxJW7xdPg0qizVg2l1RKPY31d+z/B/pknXnea57n9OoNa8JVXZuVfym1jLDcpKmm/Z
         PLA00zxyCgbIH0HYb58uqagRmYllFnpsYzC2H2n1OBi4OLQraf0lmDB91/x3rMpw84N9
         +HBrKZVQWcDL2vqg3WCa36TrCkLQj24z4HV/Srcyh+zZBsuCTb6E48IqgGM9CzwmM2wC
         +fgMZ7uSvIEdsCpV8lbB8VHXmc0Mh6IoUETVqcOP7amS/xF1rydDxiovkabpF+Xvqlb1
         i+Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWV0yzqx6IBuDC+4J+I8tGdozcm/KTAXSEGd6Cdgdi4N+TK1rrYAvOOrdYwR4FfdbbXKnjku6dYwNu8/Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4skbX3c5ZdbKYRVXDSDJUTsyBv9s35QEuZqHZeOOzMJDLbVm
	yZacMtyG+hnraksTrIyGuN8rZRKRaCaI/AJpWBNOQTLCsbGFDgMwGfem
X-Gm-Gg: ASbGncuOsj8qNz/PoNTG3mlgNlaPBKTPybmawD3+OxVLm0BVNFtHR8vmXm/wlCclcEZ
	p46jNaoqiG01S3e4fo/rmLhii4H4gXnAm1Z6AS9eihfCTOX21q7S31hvzIL7X3bfnAiP1ihTEE/
	mwX4cAf9GQTHjvqZWUnpI/ClQB/aIykQpqIcIwoGcQhYOjmhkkqnShUTdmnvzpmyDY92MVvR3Xa
	Sd98tDCG6MbCE7J4/Sx6we5dvrDBKNUUqteNniYGxGbvAltexXarPgENm50JSTHIgv2EoVewqez
	P12CzNoSqpOGgQNAtSjmZx3sJl3JqAC1g1CD37RZaXxiOVINin3eHJUHZE30sesSLSBp92jAiyy
	poW9mx9YPrpsde7/d9YwQFX1T19CENzYBJTO/bb9Foew1bZUtuVH2gEgAWMfk5vZkFXQf2ZDMAc
	rPiZulX0KOvcbc90l/MOZzbDsN3r/GhCGvBFrU1xHEv8j52c1/wWiKX0SHEY5yGdNbjaJqe0ga0
	TW11qlRkA==
X-Google-Smtp-Source: AGHT+IHEJriQOsCE072JGcgtKsQf1uKRAkkKtWjtVovvtEqRBoI600xoTijqLOXvNy4EBRqUN6GmcQ==
X-Received: by 2002:a17:903:19e5:b0:265:89c:251b with SMTP id d9443c01a7336-290caf8519dmr45137495ad.29.1760708781029;
        Fri, 17 Oct 2025 06:46:21 -0700 (PDT)
Received: from bu9-daniel.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afda1dsm64834695ad.108.2025.10.17.06.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 06:46:20 -0700 (PDT)
From: Daniel Hsu <d486250@gmail.com>
X-Google-Original-From: Daniel Hsu <Daniel-Hsu@quantatw.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Daniel Hsu <Daniel-Hsu@quantatw.com>
Subject: [PATCH] ARM: dts: aspeed: harma: add fanboard presence sgpio
Date: Fri, 17 Oct 2025 21:44:02 +0800
Message-ID: <20251017134402.2073042-1-Daniel-Hsu@quantatw.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SGPIO definition for detecting fanboard presence on the Harma
platform. This allows the BMC to determine whether the fanboard is
attached.

Signed-off-by: Daniel Hsu <Daniel-Hsu@quantatw.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b733efe31e8d..7983ae0bd3f3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -814,9 +814,13 @@ &sgpiom0 {
 	"irq-pvddcore1-ocp-alert","",
 	"","",
 	/*O4-O7 line 232-239*/
-	"","","","","","","","",
+	"","","","",
+	"presence-lower-fanboard1","",
+	"presence-lower-fanboard2","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"presence-upper-fanboard1","",
+	"presence-upper-fanboard2","",
+	"","","","",
 	/*P4-P7 line 248-255*/
 	"","","","","","","","";
 };
-- 
2.43.0


