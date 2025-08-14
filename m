Return-Path: <linux-kernel+bounces-768878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCFDB266D8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F9B9E773F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA23318152;
	Thu, 14 Aug 2025 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fhe5lxW3"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEDC30100E;
	Thu, 14 Aug 2025 13:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177445; cv=none; b=BoDedtW8J7uBSqWjYDS5JxEsbnVMtXtSKpEPyFfnXCNj9KDx0arWYSKaq0oGjXWQn6rz7oyU5vU8iDcFFWJYxra8r3Cu9NG2DRihOIlZaHc00yvScP7MmycGB5DCqsX7K5G/MTD1UWOiweEAiBrXYt/CjM0cfvaOcalZbTkDGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177445; c=relaxed/simple;
	bh=QKx+F/HxQZ5yhXn89TjtWTbvMv1eNZ0DhMYal2o/FpA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0Ttw2s7FrtzxJEVCnoGNPLxiSfe2pUi0sfcvpr+f+Y9u4Ya9Ie1gN5FNkTQlw63aP1Xb261exR3dOfxLEi2iIbtn17eWooEmah0B4uZ2+8Z5iNezYaA8SqfeHl80M4OGmVVjhH1piQZ4MNRJ2nnYYb65cb4IpJOYxeEbRbD4Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fhe5lxW3; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so1552825a91.1;
        Thu, 14 Aug 2025 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177444; x=1755782244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lsr8NoDBS2RQArrp1EpyLZ8skAK+yEiuZh8RDSmxYGs=;
        b=Fhe5lxW3dL+/AAGVMUyatMTYBIGULdkOYrUZr2CTFbZGsR2K35CCXnVSFPaMOI7wUI
         iRpV8Ush5wkmATP8C7i7MRN+CCpnGngbQbEoSLMg44PlpzzUklF3dZUFpHUZhNIB1/b9
         1LUtLcJr0/sh2ru/8nvbrFEIrYGY7rN5aD4r5PSzG23Un2cv9SgE2OyrPwuPGxGwUsWm
         AMpxQORul16VcVpKoefE86PVxAXbI7VKS7Is04Kng5ceESP2etgz9xJWXhzAF3ek50+b
         hnsmD8Ua00eHze3UalFS8A3UKy591xfb61AMfzaKEo+PijU7WSyON3x7rodVPChYbcyt
         d4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177444; x=1755782244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lsr8NoDBS2RQArrp1EpyLZ8skAK+yEiuZh8RDSmxYGs=;
        b=Cj5Q5+eFOY5FzLRFLWsQ4Ss4amF0SfH81gyX99lqmXe7xur/iARUUZ6r/fFlfVj6i8
         3gvWUY4QF2SQk+3TsFL8Z2MzSFgHBjyr3hRBX9wdF6PaoIRmRmhK8QDEyAnzXYyldC2U
         oK+RpCJMZ4V3Qltu5IfQZ46A05QczmXulFJ4LNVTcUK6jcSRv9ZajpS8QdD+SFOiSVTk
         hJ09dkXMOVL6f3KHHCS9onMnUZqktPE9TxN+Ahy2gpjNxOBcuR7jg0ufxwiRpJ5B4ZY9
         DPyO7lquneJMEDdg5/GaBaMa8wTM6g1AuQVAckZhi8i6EUY+jmiYigP5qMZTEJ7XUqPT
         6TaA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+M6RBKdeHtt1hKwnUmIT78JToyAexem84WNjXxezbIVvfzI7xECnOlrJ+aafs7WdrQaSiFeZry1slDuN@vger.kernel.org, AJvYcCXhMzHKzHXdkbQ4EeVOHfePy99BmOQkLOT+Zyi2q11D4u/0HCreTkYtA880ReNozN6iYVRi0XX8DzTP@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGtzEnyOyKlkEWlUYN3ug3fjXZ5wpJFxv7Z+XFxtLgdoLetlY
	8xdCEZrILxKZF+Mp2st9c8FI58oYTVKoPZR/Mfhj9hajXz/wcYAlBVho
X-Gm-Gg: ASbGncuRBHHikudvpS3kNZTc4PGGvPcfwhf7ZQ7QcIoyVLdN8s3Y3h+Fm+2QvvMDgQX
	M9C3r/utWAm1mnw1IEE5ZnkwZlLhrOApA1LkfgfByAT2wh3AJP6sBWdLsT4369We5VnVqp9fZxh
	UU675FhtY6BrAZBuYtRrcWLKCuUvUhGbXn34MA3nH/o1w6HSsRMgMrSuu+7avUBoqOvIKlXpJCf
	zWxWs5S35CKnAyIz3p+RKPFcaWHiW32TKSacfWlEoR6VaQ+fPFlH5Zy1bWEaudzjz5SRpamI80S
	g/W5IGKAKuXiQJ3ziwKkBGJ7dHp1s9qY3sfRd9TFbGVQHNoAqmMlgb6SGH58e4w6yKykKfFDwOq
	3CVCCLlSmvhZpQuPfQL/Zad9gu25IskcCOeuYIjVz+RYwINnJKS+/mxhGJQO6XVBdqRT8n/bgbQ
	ryHtfrfkh8ruY=
X-Google-Smtp-Source: AGHT+IE2z0Mn4IzOfVrP5fVEkPK/wTu7L7FYQyC/LTk08Q1390PeBweG1bRkM0f2xG6YdF4ltPjpOA==
X-Received: by 2002:a17:903:1b50:b0:240:14f9:cf13 with SMTP id d9443c01a7336-244586f6e7amr44650985ad.51.1755177443544;
        Thu, 14 Aug 2025 06:17:23 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:23 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection
Date: Thu, 14 Aug 2025 21:17:00 +0800
Message-ID: <20250814131706.1567067-5-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add leak-related line names for the SGPIO inputs that report chassis
leaks, so userspace can detect and handle leak events

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index ed2432f37609..6af8b22f72e1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1767,11 +1767,17 @@ &sgpiom0 {
 	"PRSNT_LEAK_CABLE_1_R_N","",
 	"PRSNT_LEAK_CABLE_2_R_N","",
 	"PRSNT_HDT_N","",
-	"","",
+	"LEAK_SWB_COLDPLATE","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"LEAK_R3_COLDPLATE","",
+	"LEAK_R2_COLDPLATE","",
+	"LEAK_R1_COLDPLATE","",
+	"LEAK_R0_COLDPLATE","",
 	/*P4-P7 line 248-255*/
-	"","","","","","","","";
+	"LEAK_MB_COLDPLATE","",
+	"LEAK_PDB1_RIGHT_MANIFOLD","",
+	"LEAK_PDB1_LEFT_MANIFOLD","",
+	"LEAK_MB_MANIFOLD","";
 	status = "okay";
 };
 
-- 
2.49.0


