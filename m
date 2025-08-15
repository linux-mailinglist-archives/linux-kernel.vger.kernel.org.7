Return-Path: <linux-kernel+bounces-771298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F754B28549
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684D8AE3C35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CA5225A35;
	Fri, 15 Aug 2025 17:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iODxFgqv"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B158B317704
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755279630; cv=none; b=AQdTtuEA11WXQV2Cw+OxnorF2zd35wR3l160xpM2Mfv8fMYYGfRmtUAgsq5urCl63TLuGN+Dihp8a+SuKrKiCmQGI32s8cMtkK+sTJUYsxkGvnpWKIR1xvKu8DqQ28MRlIJMjyLvIaK0qNj8hPZsbYL1SMc4u1esZnZoHv33AWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755279630; c=relaxed/simple;
	bh=SHbmrBeiEzcXIkiJQkm4OhQPCKuRqHNu+xmZ7q3ePUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oM3OBnWZUJLmE5jCcF1tApSo9GLxycKWVS548aJFATeL+iHkMsF4kVPhRxdt8b+EICX/4oL/xGDyvhwMxPF8CjkZLwK5k6yGmFADatb98Bihmq9PoIEGIFRyjs4T6uEGpSsRN+ZJlkEak7m7SLKiWDQ4wJ66oMuj4KtPL6r7R8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iODxFgqv; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-30cce8ec298so1849185fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 10:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755279627; x=1755884427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MutsBknavwaBSjOVJH5CuUP4FGqu7aUWlJI/6004eYY=;
        b=iODxFgqvRBFRm6HAm5bQb9pMv1t3CFegkeQzrp663cDciJDM+hgY0hmWAzFzdImsW+
         VCk8ThGpEyDaUVHpFJEN8973LODDle/oewO+n4S4tHVYtjF39vtbJs2bbIFksoGM+aFi
         ahXfqRemkMMYuaCwEaegT8C64QnUreyjpOrR5nSqqZ+JyIhUJZpb4wvEgNn8xoUqOLvW
         Dh6fc5Lcm1DrWI/yQ6hc7WSL4N0Txy7wS7LUt4bX7tlN/sbf6KKqxsWPbpdg3ejxAJZS
         97CWJm6ocH+caL7MLIVsWRhzG4WzojseZQcdH6MFah9zTDK+gg7SzQFQ0vzleB196nCJ
         9iuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755279627; x=1755884427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MutsBknavwaBSjOVJH5CuUP4FGqu7aUWlJI/6004eYY=;
        b=BjgKaTFNvh++wBro7INGIAm4YSiGLLn/mMC5glHjody4Rrh6lfT8yx30CF07PJRcdW
         Qht4ioZVNSSYSxBBy9T4f/FmjzStaaMC2KokM9+lK1th7w9fss/t45lvPDT2zZIKUdIL
         xiuBKTjNucLQX1IERlTjZgP7++NSJo7OQfG7fSNoY19Fa6CjIVkvBRxk2XHfbnvrZAk8
         IwpU6zA4BpzDrUsnZ0r8oORzkq0kdtmI790ASKlu1URfscrTOPcJOwC7oIb2YnQA0KPu
         bHRnN4xTrPSQnD5jTT8vac8l4NaOjj+hmCfTeMrw5sLCS8pZGh3tE06ZVfbMyaKd9nEm
         B5Jw==
X-Gm-Message-State: AOJu0YzwbCKUV7rtNA5Y+QFigo4bEeRgd8WSR6YbNo/qkH5l8uIbN8Bt
	3HblR99UwHZHNP80ezBFWhg5+Owt2vLXUsw7QXqnsxXybORjOQWDxPUpD3KYrRvmfX0=
X-Gm-Gg: ASbGnctw93OfCnfgVOnuzLHlq76MTAZbD4AhHqNVRB1ieqo/+IGWghNFKsioGJlR1dW
	h4haRPsxfebL2Rot0XHWjC8d85CeUjuVrUBJxQWi1XbYhn/P6j23qmoRxm5cMvXHEGzyAWxck2a
	DCXiS3unR4hxPh3SAG/mYiEeWeA1VdFDd5fMe0ipVXFKGbqW4/GXLBqCYEIkU1/bKRG+o89I8zE
	AGApm6b/FFyNFUBE37w6u9NmwNPdB77XwAdZckvwLY9uax3ByKb9I4tupJl99jgwzamnE0FIVal
	xHraf2hPwoETyb2d7n6Ok/3rGaq1dwUCxDQSG5sodXaypUxw8LYUvV4XD/sotmcpY0b2tleGX15
	VZmKGsfk2fg5b3osVEj3jP8P/fGA=
X-Google-Smtp-Source: AGHT+IFO6pw3mLcsyDeECYXWw+Kf1yGV1GR894dLssF9aILYPu8AbW3AbPN/mNR9j0I77KgRs9gRhQ==
X-Received: by 2002:a05:6870:678b:b0:30c:9b7e:16e9 with SMTP id 586e51a60fabf-310aaf9dde1mr1807649fac.30.1755279626801;
        Fri, 15 Aug 2025 10:40:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-74392073439sm405826a34.48.2025.08.15.10.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 10:40:25 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Aug 2025 12:40:02 -0500
Subject: [PATCH 1/2] include: adi-axi-common: add version check function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-1-13bde357d5b6@baylibre.com>
References: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
In-Reply-To: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SHbmrBeiEzcXIkiJQkm4OhQPCKuRqHNu+xmZ7q3ePUA=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBon3D6KxD1WS6f7kDjivNC+94VxAWN86PxlgMkA
 eiFQEtHXCaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJ9w+gAKCRDCzCAB/wGP
 wBl/B/0S7svMzAaljP1A/xmdgIikO9GnayO4X95dXLDbPPmwdFZwtbufrbW/AxOrlPuZB6hJZfK
 Brsms0S46ye53Xt67Tmk993HPQ7rG/XEXg70t0NTVDsB3jpOuFOA7Jh0SEj/C1oPVGRQVgdG0zG
 fvOQaFrTmjRj1MBMXF7K0VW4/7SMhCF5EevwmFuCxQtmicI6sKpPzFgzqAkzCsatg8tp1+Y8GOq
 C2R3bRZjAlfNblsnxFszfBacd0Wc7IMZKFdQwN5mXoU+SlWIHkVgmIMAYLMcvvvTRm4ARDwA4lo
 36RizqVPhY9959dVTc/2Ggv47+1nfQddBxydkH94YBuNv83A
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a version check function for checking ADI AXI IP core versions.

These cores use a semantic versioning scheme, so it is useful to have
a version check function that can check the minor version to enable
features in driver while maintaining backward compatibility.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/adi-axi-common.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/include/linux/adi-axi-common.h b/include/linux/adi-axi-common.h
index f64f4ad4bedae312ec450bd5fed09ceaedd5397e..37962ba530dfc1275c17771cade2e75fd7e81cd3 100644
--- a/include/linux/adi-axi-common.h
+++ b/include/linux/adi-axi-common.h
@@ -8,6 +8,8 @@
  * https://wiki.analog.com/resources/fpga/docs/hdl/regmap
  */
 
+#include <linux/types.h>
+
 #ifndef ADI_AXI_COMMON_H_
 #define ADI_AXI_COMMON_H_
 
@@ -21,6 +23,25 @@
 #define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff)
 #define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
 
+/**
+ * adi_axi_pcore_ver_gteq() - check if a version is satisfied
+ * @version: the full version read from the hardware
+ * @major: the major version to compare against
+ * @minor: the minor version to compare against
+ *
+ * ADI AXI IP Cores use semantic versioning, so this can be used to check for
+ * feature availability.
+ *
+ * Return: true if the version is greater than or equal to the specified
+ *         major and minor version, false otherwise.
+ */
+static inline bool adi_axi_pcore_ver_gteq(u32 version, u32 major, u32 minor)
+{
+	return ADI_AXI_PCORE_VER_MAJOR(version) > (major) ||
+	       (ADI_AXI_PCORE_VER_MAJOR(version) == (major) &&
+		ADI_AXI_PCORE_VER_MINOR(version) >= (minor));
+}
+
 #define ADI_AXI_INFO_FPGA_TECH(info)            (((info) >> 24) & 0xff)
 #define ADI_AXI_INFO_FPGA_FAMILY(info)          (((info) >> 16) & 0xff)
 #define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)     (((info) >> 8) & 0xff)

-- 
2.43.0


