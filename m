Return-Path: <linux-kernel+bounces-820463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A1EB7E6CE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D82326598
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0C7285077;
	Wed, 17 Sep 2025 10:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyTnb1nV"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B578362998
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104317; cv=none; b=MWhXUr85zVK22c41+vHXFckFmbKLPk+TgNx8BgaUY77GnmQhQXyMFipDyErn4O28mKLPsRgb+pzEE5osMNuZClZf5yPEWYY3ivCfKa8k0+qO+2TuxZPfM5p53JS4tVQMedVJ9mzTGvrUF7GPBcL5NAqiYYBPoaPGYpsJNORAjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104317; c=relaxed/simple;
	bh=uvIYlGmQH1mEHmxGr3VC58oWOwuLYDjJrOFwBGwq8QY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGNGcYMu11Kfkf34/hf2CQn9WTNwtmzaVd+JdBdesPmayiRdBY/S7D8J3umyE9v1MK9QtzLZGWjY+pK10E4vp5cR0Lko85wqmwFt2kaD++jOnn5uZ9fMbqHGRhF/dAPOtsq4ASrNXrxfGUiwk87d2lgSr3dU7EWOzJsaiATneC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyTnb1nV; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-25d44908648so65183665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104315; x=1758709115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kmbJPIKT2sQhA/vxVf0N7X2Z80CDuvnn3C+ZX1OUAE=;
        b=JyTnb1nVKnHO+Mycv2SgI9lub2hub3BYwGJTEEzh5bifqGDAmkdAxtk2ieEIXjqf6y
         qVJKAqjFdN7pnBSygbBe3gfVHptgy9PAzQrB3lgTHvOD/XzmgsClFY2zsDrJ1tjsCzjz
         nFUoCVXBiyvnb4W7xTmKXx098bcVy4r1PAWG8I9dIncmEGpck+Sg7gXo/FS0QSmnks5E
         hLDONum30SebSCRCdHV556q9XfJHOIyFQv9l4Bjoi1X0FBgA1OVVlVrpbY+41bOjrdqG
         yf5Htbv5IeW+OFgLT6E8x5XY9IX60bUFAhSO09lrAEEn7pwlwUb996svgWGE5pTLI6IV
         e2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104315; x=1758709115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kmbJPIKT2sQhA/vxVf0N7X2Z80CDuvnn3C+ZX1OUAE=;
        b=LtZpXC6LFHD8LBDUmXtr969x8cVXO6X5rmDt9KOyCy9vEfKVTFbI5vck2Z0idmXdld
         ddztEV2gnV2hSRgSlJladyBZukMPHYZtTPxFwYQd9RUGxJ6IHfsHWUvtHrefegK34rgS
         cbJ7nSHh+gyfK8+HlEbZgFs3GdDGZLuuqE8A+Vk1MukZJAKCkeUQp10RtYuJbhX/NoSn
         uMeF8/dVYBdxXdUOkg9c3mV5u6+BQ9UEfZ1jwCOe1jWrNYKvf9lN0v92HtJ27ht7iWOT
         yOWcNEzPdW9CTq3GUZPECeSeep0V79HhLphfpgchAPIvxLb0QQ513Oc7OaGmYYlWIjA+
         jsPw==
X-Forwarded-Encrypted: i=1; AJvYcCVMPYENMJF2geVwaoC7ttaOpkevszC0W6jh+gPNAsifNYH3zJrSWTvXkCBeIOexHCW+xbFYYFHOSCiA9ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6/CSVypvO4i96Fkf6A5Iqj/SyplysN3zWAY7TvoaAevLy2wS
	0Ov2VECgLuVxvvKfz20yc2CTIRe1+t0ZoGvsulAvaFZhbuIFNLlQELea
X-Gm-Gg: ASbGncs1P1d7+0QGhh4O778ez5PxTaUon5gLe8lvQqfq1BDopCYHk1dxlQE2ZqZBgOW
	9cTnTOIwplHAFL7gqBpfbFRx3j0KTfXCnBspoiIRLLmqf8q5GDjTrzZ3+tf+kKyNZc93AYgHbQY
	xtsr8hEn1g5FMg4m68uj/DBUqH72e9FXbrVLp9HXLi/ebGX74BZ5wJVbEP5nR3EbBZwYq7IsTwt
	Qgt7BngxN1ZhhB+4KJArEzVkpDF4G/OTfucetZAzWRWUNDyoJFSXUr358MtqCUN8JJDMbxmrTFk
	ElsXzYR0D40XpqL4u7ossQs80DR8GNs9y/UJ0ta6D1JhgjgOYLMZAeqnpvKpP/SRnn/Kqmc1DaW
	/BoI07vMmSWuzC3f/X6bzjfZGmQ0IlV5c6b//ySGcFSaGmeNfjpGAgzy9hzSI0LXYdCHPpy/7aV
	QHI4luAhHbgQmVJx1xfZ7KDsUxBQ==
X-Google-Smtp-Source: AGHT+IFiUe1D2qnklzbedzK9Brp0DgIaGignG75uAoJrTAq+Wmo3K/I8sMVvXmtJYvF52h0HPiTMlw==
X-Received: by 2002:a17:902:fc86:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-2681390307emr21798845ad.42.1758104314805;
        Wed, 17 Sep 2025 03:18:34 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:34 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 1/4] ARM: dts: aspeed: harma: add new line between the child nodes
Date: Wed, 17 Sep 2025 18:18:22 +0800
Message-ID: <20250917101828.2589069-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new line between the child nodes of imux28 to match DTS
style.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 23eaf47a38e8..41ae86180534 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -524,26 +524,32 @@ power-sensor@20 {
 				compatible = "mps,mp5990";
 				reg = <0x20>;
 			};
+
 			power-monitor@61 {
 				compatible = "isil,isl69260";
 				reg = <0x61>;
 			};
+
 			power-monitor@62 {
 				compatible = "isil,isl69260";
 				reg = <0x62>;
 			};
+
 			power-monitor@63 {
 				compatible = "isil,isl69260";
 				reg = <0x63>;
 			};
+
 			power-monitor@64 {
 				compatible = "infineon,xdpe152c4";
 				reg = <0x64>;
 			};
+
 			power-monitor@66 {
 				compatible = "infineon,xdpe152c4";
 				reg = <0x66>;
 			};
+
 			power-monitor@68 {
 				compatible = "infineon,xdpe152c4";
 				reg = <0x68>;
-- 
2.43.0


