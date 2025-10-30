Return-Path: <linux-kernel+bounces-878161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A48AFC1FEA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AB104EADED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 12:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C18031A7F3;
	Thu, 30 Oct 2025 12:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnQ4fvuh"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A0C301716
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825767; cv=none; b=fy3gB/6zPmK2ALKNJf0YnbiS5ugXqVBeP5bz60We52OunBOtKN7XHG98qYywm1Kr5KAiGBQPgVTdLfW7/aMiYDKxtKipq4G+cNrpjk0qpmXFhv75Whx0N92mbZGNjVMuM4zjZ5DF0A8SjPpQpLFITA/9VA2N7TvwC8oY5VuiURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825767; c=relaxed/simple;
	bh=2wqxvv1LyQFzj8yk+I9X6hMiGmB+zBuKRmM0nZOP2cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZjgmQuVxMqx7CcvDZTDJBwmTDUDvlPpDphZNmxe+Yc1sLUG7aCH+lRWuBzk7jFuDZJar9HIkJwBa8ob5j+4p7oICZB7FR36SoqS8LRwxvD/b+Um6P3Yho7MvOZ0TLyY+hT6/6etuj4lksVlokSK52D4VXa4vrpzBT8/nos0BqvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnQ4fvuh; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429b85c3880so694937f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825764; x=1762430564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKKJA6fRomltCp481BiLWPXK7LT4XBfRN+VIaJM7fMU=;
        b=OnQ4fvuhKziE670U8YC2oRVlWhEV1LFYD8HFX7Z1NL4Ta/ap9trl+pENyDsvmbr6SY
         vcrB5CBfIPOiv8FjuddrpjTyKTaI9d/pBVRhy55HZbjOoWNIK7EwfTy/7Ri0b+vIv3HQ
         T3pv2rEKPHtCzouA6J/VGBd0dvC0GRb5xwkbJwVwmp3qiw+qZTzrD9yjRxG4S/HeleSM
         BqVJ490RQ0WOwF0Sp3jmUFDCIerbvVa6zuhHSgR1jV9N4MJvoTctSyD7BS+KuJWGwlpq
         76aI6Hr6eGu9ZB2JYrVcqQt33h3kbFKa+WnzlQ8e3K01k/jiFMSxEfZ/uXaGD/mVjr8E
         JI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825764; x=1762430564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKKJA6fRomltCp481BiLWPXK7LT4XBfRN+VIaJM7fMU=;
        b=b1wEkJUnGSIZTDHNX++9KXW7tTkRR8aLnmR0QiAPX3RcHoZKqtNeCqq6im40oq2e6l
         QW80zKU6G5AidLyU517JK/XWu76+6fvy93Io17wscqdQL4fbCHv54p3jPSsI6Obd0/wH
         0An1OgdiwtTb7iulpBl0U0QdD3hd4IRsZyaA9/yc+68WB5xtzmKUOqR5sC2F8BK+181P
         PXj2c/m9RLeWFd59D1bBi1gsjaPVeh/dMut/8I/wgjsjbp5HPwUBu4CkCYSP9dwalqL6
         rOBf4IXcwr+UtxCFt4OcBxr9Pgixogwqrz2Zupv1YS5xw/jRQ75tpu+1sufPQjqLD37+
         Sb+w==
X-Forwarded-Encrypted: i=1; AJvYcCUqcvwdHXPizsFr73wFCuhlXc1siBWYptZ4dZ3RmUqDc6n4SDWYOjYFiYAGnTHfwH13a8nB9njKxKB6tj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5kGrjj0ryIM8VUko1rZ6M1GwbUW1Lyk2UmOrCZ/TOO97wUHL1
	uyEFMyeN/qHaX8yf+JziT4A6QDDu1NL367awpiwfVBQ/DBvgZ5luGpok
X-Gm-Gg: ASbGnctbyKEc7bTKTm9hYnaVH+75w4C+VwlhFr97zPTwa+BBMz4Hz6h3b2V75SLlcYn
	75WZ/yYwyxgltQh3chMc9JIWaHYO8k2w6RgQNLal1bplVWBYVIfCk0MCr4OXFQtyL+k6h11hjV7
	SHAt//i/hRavv+c/A+eYUH4J2Y5I/iT35kAkLFbhTH/kVI7yY1vbipUL23I01pCSJX6ugUAotcf
	MDK5tSL4800/ThSsxzFYhmh8Kxv9+Oq1RhDSS1nJ1ftv2Nkd3GuFPPcE+GmtHJjSk4zMUrG65k6
	y9sJ9jLso4qbFjlUtgPQqtciPUUIZut40up7aU2eA3HsTAT0e1riOl51R7BjrTN3JPZh9sI6zJb
	d1aI0x8tfzD1oGLqPuEyujod9zYOZlhpVOViWXj1zDnNOd5Ztofr7BDR7mUN8B1UFeEHXBDlDcK
	4vLGb4ahedochgKXyIYCbLC0LhoCVhaQ1d3kZaQ+ZgcLOKa1agFJO2xiFpsL/xb8+uvszolMsZ
X-Google-Smtp-Source: AGHT+IGkEzWaIhOle1zjpMnONwufJ9WytmJCNBOpcHQt6RREK2pdj8LZw4LmLrh8QmCmDfNohShFNg==
X-Received: by 2002:a05:6000:26ce:b0:3e1:2d70:673e with SMTP id ffacd0b85a97d-429aefb2a1fmr5378560f8f.37.1761825763215;
        Thu, 30 Oct 2025 05:02:43 -0700 (PDT)
Received: from Lord-Beerus.station (net-93-146-98-100.cust.vodafonedsl.it. [93.146.98.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429b9b436efsm2399848f8f.23.2025.10.30.05.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:02:42 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] arm64: dts: freescale: imx93-var-som: Align DTS with hardware revision
Date: Thu, 30 Oct 2025 13:01:20 +0100
Message-ID: <20251030120127.509933-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates the device tree for the VAR-SOM-MX93 to align it
with the latest hardware revision of the module.

The updates include the addition of missing peripherals and devices present
on the current SOM version, namely:
 - WiFi and Bluetooth module (NXP IW611/IW612)
 - PMIC (Dual NXP PCA9541)
 - Audio codec (NXP WM8904)
 - Resistive touch controller (TI ADS7846)

These changes ensure the DTS reflects the real hardware configuration and
enable full support for the mentioned peripherals.

Stefano Radaelli (4):
  arm64: dts: freescale: imx93-var-som: Add WiFi and Bluetooth support
  arm64: dts: freescale: imx93-var-som: Add PMIC support
  arm64: dts: freescale: imx93-var-som: Add support for WM8904 audio
    codec
  arm64: dts: freescale: imx93-var-som: Add support for ADS7846
    touchscreen

 .../boot/dts/freescale/imx93-var-som.dtsi     | 332 +++++++++++++++++-
 1 file changed, 331 insertions(+), 1 deletion(-)


base-commit: e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6
prerequisite-patch-id: bfa4df6e3787b415218cd441317fb838824e06c3
-- 
2.43.0


