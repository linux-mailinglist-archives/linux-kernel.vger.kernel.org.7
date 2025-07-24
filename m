Return-Path: <linux-kernel+bounces-744122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCEEB1083B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:55:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DEA21CE76F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272B26A1D0;
	Thu, 24 Jul 2025 10:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgE+izbS"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D426A0B3;
	Thu, 24 Jul 2025 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354497; cv=none; b=emYa16BTPZhZNB/SB8GB1SERwaaT6QloEBMBpBv7Pgh1CaVElinkbO/fdR/W1L6TB3+99BURXL6IUN6a3bWY3+IX90eGCk00mQD7mNLnKxHkrPjAK+9GsgEgHdixgmX1PBUgP5ir6Lc+sqSl4tZRWgPxN9XcVu+RH6BxgkKzHv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354497; c=relaxed/simple;
	bh=LgtVXJub3oQj1/eh39mXtQfGOk25rts9oyrtHoKK6Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SKD8LfaOvGYX5pt5EGMwymXt7DzwjkJvllXDyttosE1b863fzLdJRH4kKiqp/LnY96GA9A7WVylD0cf64XmsA2jC8AuWUGi7RSS7l7FPBCWFWxGftSgw1pM33HK3DT+6sfljZ4a0T4ZP04BxzfXNUK/3+ouc3BHyRHJmleq1mn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgE+izbS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a582e09144so392372f8f.1;
        Thu, 24 Jul 2025 03:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753354494; x=1753959294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsAhWIT62m4Gie5SVDdvUs0LMiYJ2YavCXOK78Oo8mI=;
        b=FgE+izbSJP0q0Qke+3/fw2kTG47AXRNMyYudc+licfWYUGApEzqmF03gCiSpqnWFOe
         fd9oVfbhoWeqFvo5ZIc+zqx57bv/VT838dG+DBOglnDi1CfLFDGQYMmkoawvQMGBr8QM
         uDlI61rrqKwRxHlTpsZt3S+pHKfr0Is53OFGN1P42/mk9n95DjbxGvveS5s7pwe9Se8Q
         WtycA4jKnuFxI7uLiYJ7WZeNB5qNhsxZGYMpUEAuZsmXuHGRmsehn/nOZE/7Cxik3DtG
         2fJBxByy3+EKWWkAXs+MtM3EGukdXilF3BEf6LSy/jGwBeaZWlUyvUeFpkvyVTUOSJhR
         m4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753354494; x=1753959294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BsAhWIT62m4Gie5SVDdvUs0LMiYJ2YavCXOK78Oo8mI=;
        b=S59YB4IOzcJpqHxzQrTBO9est8UTIuftrISMcLbcx99EV95VkG9lPAISKnFAi4Pb+c
         bifoaXu/qQOnpA95At4BjuJ8AhmoKWnqRtLlI2HpqzHrs5zvLsuEyulc3hRrPiiM6+Ue
         EcbSbuUB59+deRy8KHKsMhD8fzzHDCZJfrDR9LtgwmI6zFN5IYBOrI/J6oaAYEowtrlu
         Qoj3W+RMOcmTo8Gk0VpAvCvQRyMkZABn+WW9HeyLKtWr1L8ge/71xh3VN6+3j8SFGVx5
         0o5Ec1XRPSCl0Pfg8nyAT81hUgY1YnI4m5nPDmF0lkAIEThpYGeHUPR1t88H2J+aZT6o
         2r7A==
X-Forwarded-Encrypted: i=1; AJvYcCXbixUzWzq/FAFS3tJsofIkxxEWXcchjdOlxfs0pSQ2m0RPOhNvfJGLebgc+hmluiyFZi0K6PPrYCVzcNk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrpk+GlHRfDjAC6kU3H3PlUagt9agM3Rri2q7nEqe1iQ2RGdD4
	qlzvM4/ts3/F0ziuiIxHxFAM/0rtHe22KnS5eBN6ug1ad/RdUu/voFqglDcgh7JFhRc=
X-Gm-Gg: ASbGnctEOkBfpShL46fkVdepz9bPJjAiPikq3D7Z05ksTQDYwR11BAhzykHDkvjeC/1
	e7xvzxFL/u6GcJp1B4ja4X9Ql78k0vDb5gHRKpyEurcB4Z/NLFGwYMhhdIvBPiCAxVHp3uHfqxm
	tfnzCe/LNRAr6+fCNgi0zUuCGFaj+Oa9YGp2dgYh4Xiuw0HVnyv/QwlBktkC5GCQO+MCuG3toDU
	hdlGZmVjETB5My9Cz3IuXGbnaxrRVFXwSfheVPtylwdiLg5yzklibvNSI2+Zka4xr4mA5m1JHVC
	B9QsAYJ4YsuH/gdiBAHuPMzIHWJJRDlw17LJZLk9066a9BCdoe78fQYlu+FM7GoJ63lCeYn6dR1
	EYKBkNRvYgKHos3KZe8Si
X-Google-Smtp-Source: AGHT+IHSDxo61nyTvpjRTf6DS/I59nhZt2pmYCjOhFrbri/7mfYeSTABKdk5sQANAcITrGTQ3hLuXA==
X-Received: by 2002:a05:6000:26c6:b0:3b5:e714:9c1e with SMTP id ffacd0b85a97d-3b768caa1d6mr5469579f8f.12.1753354494472;
        Thu, 24 Jul 2025 03:54:54 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fc79f06sm1823832f8f.37.2025.07.24.03.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 03:54:54 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Eric Piel <eric.piel@tremplin-utc.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] misc: Fix spelling mistake "STMicroeletronics" -> "STMicroelectronics"
Date: Thu, 24 Jul 2025 11:54:22 +0100
Message-ID: <20250724105422.140186-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is are spelling mistakes in the SENSORS_LIS3_SPI and SENSORS_LIS3_I2C
Kconfig. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/misc/lis3lv02d/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lis3lv02d/Kconfig b/drivers/misc/lis3lv02d/Kconfig
index 56005243a230..9d546a42a563 100644
--- a/drivers/misc/lis3lv02d/Kconfig
+++ b/drivers/misc/lis3lv02d/Kconfig
@@ -4,7 +4,7 @@
 #
 
 config SENSORS_LIS3_SPI
-	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
+	tristate "STMicroelectronics LIS3LV02Dx three-axis digital accelerometer (SPI)"
 	depends on !ACPI && SPI_MASTER && INPUT
 	select SENSORS_LIS3LV02D
 	help
@@ -20,7 +20,7 @@ config SENSORS_LIS3_SPI
 	  is called lis3lv02d_spi.
 
 config SENSORS_LIS3_I2C
-	tristate "STMicroeletronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
+	tristate "STMicroelectronics LIS3LV02Dx three-axis digital accelerometer (I2C)"
 	depends on I2C && INPUT
 	select SENSORS_LIS3LV02D
 	help
-- 
2.50.0


