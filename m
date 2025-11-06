Return-Path: <linux-kernel+bounces-888856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822FC3C1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 16:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9EE3A9D84
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3929B20D;
	Thu,  6 Nov 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b="AWRega6l"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B37253359
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 15:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762443089; cv=none; b=YiI2+J0Uq6srGCGzA3MtpuLLlkS7DG6F7A5UFMIJMmlbmodRkG89+aYb8q+VVeIvOyqey3HfoTGWnrnmycYmnUH3QohVMuRxzUsnkbX+rpz3iGrXNsxCq3uL6oPKFYu30pH9WhRLGFyEJ1Ky+oaINz/r6E9qmB1aeeO5Q3k0qVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762443089; c=relaxed/simple;
	bh=wPKoUnMK8vZ+AgOMszH5Qwlbo+GoY0Sp3z672Mc1Pis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XE1iu1DKN+bx8NFWzPfQv3m1+M0O3GJXGpvKy1dq3WtOnONDQq+rRV/MzJf38n6aV4rXaIfnTdX8PBAzmhVIB6QTST1uQ/XXYPEh3SwBkcpqFYrmAJx2RInJIXUH3wu5TyLcZnG/LpXRlNflEZOSh451YNmeQ0IOt187VTs+I2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc; spf=pass smtp.mailfrom=arduino.cc; dkim=pass (1024-bit key) header.d=arduino.cc header.i=@arduino.cc header.b=AWRega6l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arduino.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arduino.cc
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1278809f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arduino.cc; s=google; t=1762443085; x=1763047885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFCi2W3xPGMmw81b14h6jvOzJY80ZgmyWnBp4oBmytw=;
        b=AWRega6lZua7EDE8eQUaM+1KLjNszUt3GTyepfMoEzhKfeeKpe7XYDC5k3hJyrR4cX
         U6g5IAS6Uyb+UKp5R371PQGpknuClKf3Z8PczD+nbdT+XUhjdPmh4wbDGrD5f+9H2Wi8
         1UW1HuNqgVGAvTsu6GW0KIzQ0OTwCycr6sBgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762443085; x=1763047885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zFCi2W3xPGMmw81b14h6jvOzJY80ZgmyWnBp4oBmytw=;
        b=MHOiMolxPiPq9iXT4potWbjHBmSLjnbM41qlJkPkFqH7uFKYO1ljvufOwE3M0KEXUn
         ffV7H4CZpjNqnf8F/Bo1Jp9X3IQ8rbZuMdsUUQCW+dsKFhw4aHGvVqsGOTQ5JNJsOIt4
         vOsaG2fKgKhzB+ZnBHrgUaA/IhfoOnIM6mPxoUtuITjsYfJcBBn9IN/gpfX21hCXLDJJ
         9tNcxwzfbvoowkyrdIG17wzhbXSN7727Nixgjq7gWIr75DHm+TKOeeUAiLlFXIOET+Il
         0pLUQycf4qJENhVg6L8nvQ6IFw1z1NXxhPxpdcNgH2Y+kYjt/+OI4djHbkSL0t0H/3Go
         dcQw==
X-Forwarded-Encrypted: i=1; AJvYcCXkeXCflJI1zK6EuP3Vs7OAWgWJ+d8JjNZR/lPo7i1fKEiK4wzaKiyNkRg0cFznA258yKXBlEh7hyAm3fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSK4KjWOcTvr3QOEhdNIv6lFQedwCOHjk3TBPZHuovRuPuh0yk
	qmPbDeM56poR1zZ4lXUFOgmXKTsyWJW/gPjqWYUlW3ITXAjVqGbIJ8sGKCJ9990W8dM=
X-Gm-Gg: ASbGncvE9z/6lmWHhAgOg7zdOos6qRkIB+LnHNymjfllsSz+MDaAmK9jQMPr5LJEvgr
	miuQRAxiWcXa/z6TIaVqSmE3TE2Mdxv3eJ8y+G/EPJM2JYXCIL+78v1TBnQrn8Mlaac1IxPLyMp
	cfUPQ/S8nG0/B+7D8j4/oILTMrl87BLBjeBuSmeUQVJ7nEGdiSCAHiumyDp9fT9IpxEuF26701U
	WH24OUxOAbnuaWF0/Vk8s3B78H4/iwNIElxX/7BLpuxMluOngANPdYsbJ0DzWPBkfjc41aEFWga
	6ELLNS5cbyUNrYovCWWQlUwD+XAXazUn0gFkJ0naCj+YyXEpAJCWj2gDJWiZiZ83bi2Kpe8hOEh
	E21iaWFXQ8h9QyQ9/sJmd3NBcKUfdUud451fGl6zznvNsKsY9j4M1b/aSp0/uALtPyHBqu5h4Ia
	Jp3UeqV2FdimG4k/du7aD3GuXVwRPTOItjHzg=
X-Google-Smtp-Source: AGHT+IGo0bYCWcjyrO5rRfbbqk+9J1qWefLXEhHHSmFWJVEVTxenM6rlhrrYWhuAbzg+tmOJeinyWg==
X-Received: by 2002:a05:6000:2002:b0:429:bfbb:5dae with SMTP id ffacd0b85a97d-429eb19d9f3mr3818004f8f.17.1762443085192;
        Thu, 06 Nov 2025 07:31:25 -0800 (PST)
Received: from riccardo-work (public.toolboxoffice.it. [213.215.163.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49a079sm5966719f8f.32.2025.11.06.07.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 07:31:24 -0800 (PST)
From: Riccardo Mereu <r.mereu.kernel@arduino.cc>
X-Google-Original-From: Riccardo Mereu <r.mereu@arduino.cc>
To: andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux@roeck-us.net,
	Jonathan.Cameron@huawei.com,
	wenswang@yeah.net,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	nuno.sa@analog.com,
	chou.cosmo@gmail.com,
	grantpeltier93@gmail.com,
	eajames@linux.ibm.com,
	farouk.bouabid@cherry.de,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	mm.facchin@arduino.cc,
	Riccardo Mereu <r.mereu@arduino.cc>
Subject: [PATCH 2/5] drivers: spi: spidev: add compatible for arduino spi mcu interface
Date: Thu,  6 Nov 2025 16:31:16 +0100
Message-ID: <20251106153119.266840-3-r.mereu@arduino.cc>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251106153119.266840-1-r.mereu@arduino.cc>
References: <20251106153119.266840-1-r.mereu@arduino.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible entry in spidev describing in Arduino boards one of the
interfaces between microprocessor and  microcontroller.

Signed-off-by: Riccardo Mereu <r.mereu@arduino.cc>
---
 drivers/spi/spidev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 5300c942a2a4..f0dd516c2083 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -704,6 +704,7 @@ static const struct class spidev_class = {
  */
 static const struct spi_device_id spidev_spi_ids[] = {
 	{ .name = /* abb */ "spi-sensor" },
+	{ .name = /* arduino */ "mcu" },
 	{ .name = /* cisco */ "spi-petra" },
 	{ .name = /* dh */ "dhcom-board" },
 	{ .name = /* elgin */ "jg10309-01" },
@@ -737,6 +738,7 @@ static int spidev_of_check(struct device *dev)
 
 static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "abb,spi-sensor", .data = &spidev_of_check },
+	{ .compatible = "arduino,mcu", .data = &spidev_of_check },
 	{ .compatible = "cisco,spi-petra", .data = &spidev_of_check },
 	{ .compatible = "dh,dhcom-board", .data = &spidev_of_check },
 	{ .compatible = "elgin,jg10309-01", .data = &spidev_of_check },
-- 
2.51.2


