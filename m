Return-Path: <linux-kernel+bounces-765800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4AB23E6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 04:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC91E174D11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9BD218EA2;
	Wed, 13 Aug 2025 02:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="eVo8v6nD"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4C20B800
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755053127; cv=none; b=LSvUMur/hIGSCdI8GR94IvptT1GzUwdOBn1xTkv0dl2UTZSEjN0jDIZ+0Qr8A0tF+6yWtGjMS5EVh8W2SRo12sxqp0QyI3ERJos8rk93UBarzeWJHanffELxw/c5MF/cO/0tbPLcC/CZg4caj6bB7gP6Bk8c/TsS/bg12bN0rbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755053127; c=relaxed/simple;
	bh=4MkO0yPVEXokF7BKWo63wkxjH8l6ox9Iw2xywkWl/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ib2sTJUBE44PiAI7TcVZGdZ1GTwRo/VLo9dUzTTYKg1OSkaGyUZd72ovDbACPULOTtrUKApQuWRu0TmJ0Stna1r9TwUE66N3zgUYxoApo4oB5KReWhrHxQO3XsktDRlIpO//hps2ViExoed/zGhq/6inprhsciawRgw80kSw2J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=eVo8v6nD; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3e545dc7400so18998865ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755053125; x=1755657925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzbsCOAJDq8e6tJqb71PLkWE7SOSqQYLq4powgsnVhU=;
        b=eVo8v6nDby4egFAHU+YUlBLnPa+BaFhpcuqK3xsAgwfLSVR+Hwel02EG+kdpFl1rk0
         EAck2VpZGxxRuIuqkGX7tectvBr/hHmXffDMgcOAWVmTM4y+X6xfk2FpkWPZ7K28iWWs
         i81ixNz7V5ktLNt9N20C30kj5u6fBy1HFZFXYBrVjKkrRMMGVykCT8ieOWb68PjskLFa
         ijGWUuFAP1mlbwofMrJe4T/upcb9vK9NPQYv8iHU8YGFp1E7WePsAFu8RSOaY3lx7/cn
         lu3Jp4juHVeCw/nYodhIxsfuNnLIEwCmQQnhQ2O8MRI4oK8GPYPRu8st7wTFbdt91fUZ
         zzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755053125; x=1755657925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzbsCOAJDq8e6tJqb71PLkWE7SOSqQYLq4powgsnVhU=;
        b=aezsFtOLnnI2ZsN6LUVAmxZ3vw91v9sU84ZCz6S8qtVTMnHCeaQgYGARwIdlFtShiw
         0hdHmCkuP1tqMbP/E/uUQbEUrled8nUgxiM72Kua0eUuu/lxz0GYbP5k16ShjbPf3Gm7
         kuR3292RjdUHWiAw2PMv4H16dOJcMIYRKW0617kFFf80dZlj4qK8/jz7DSRTedC0G+qu
         Ejh/1tvu3h5HwPUBg7WF/vM+Z7tWHrmaxkweUfQ5eQIJ/MSRlXlIYPyawzBwNVuoCFOf
         +WiVgYmgsra1eh72cpUCUfJRa/i0xkhF7CWY+v8viOI3cLefAWSgDCm3p/XQDMUNkjNh
         oiyg==
X-Forwarded-Encrypted: i=1; AJvYcCWLO+LdA9oR3sTiZw563dr+wn9pwWbpvVUQ0iNEufPq6B8+iqyxKDLMJZmVVaRFN0fr4e8CMW6J7NfGaeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6kvavhhMaOGc5KBH/PBvYjhkm/rXGk3u2QxO1l7QY1hi4Ts8
	vEdPII/Klqt8S7LA39NEUh5bEoDo0frcoZiNbCWGiO3dgZl41hnSx2MJXEAaRROu4rM=
X-Gm-Gg: ASbGncsvAfKl9nv4tl65iBMwIAMFZdvD1Z0SEwXuDTUm5U8xeO/hy88H7wdQUvvW3M/
	1xRwEZPNi65x8hh0SxYy3MNsf15xAlfUutm+tsfDIVnI6UTC1YCdYoSd3tPZTsPDqY+JYU4VK8U
	yMXCRswXvT0sVIoaeQcwQceKeRge4VxZ26tiVm4VxBoEL6vZzUaSnXsoVnnIF+z+Xrt09lrKaPJ
	GnCcSwjNL0QrKLMGO3VxoQDtvLB6dJdK0DjS1yuXit6VK3WtH31tNqNna8kOh0GGIQCGDAuVv+n
	xVTRd3ZtwkRAtGInw9nMXpcQ1mSnmtrMh/CJeoQsTJPgbloK0CFDsJMgXOCU9219LZ9O/qaId4L
	LPnL6MUbRotng3j+zqYLCHNnAybZGofxfsCQ/52BUmCogmEVQmShCOUyAh0G/GEvPWg==
X-Google-Smtp-Source: AGHT+IEsfC/IKzLwt4IZPy6SkPXZpTJu9PySwz9GRZIpUkfEiQ20Q0ptezwTySBlx0jjAkkgtyP2Sg==
X-Received: by 2002:a05:6e02:184b:b0:3e5:4a7d:2ae5 with SMTP id e9e14a558f8ab-3e5674b0c78mr21916045ab.17.1755053124757;
        Tue, 12 Aug 2025 19:45:24 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ae9bcfbf6sm3430829173.54.2025.08.12.19.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 19:45:24 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 6/7] riscv: dts: spacemit: define fixed regulators
Date: Tue, 12 Aug 2025 21:45:07 -0500
Message-ID: <20250813024509.2325988-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250813024509.2325988-1-elder@riscstar.com>
References: <20250813024509.2325988-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the DC power input and the 4v power as fixed supplies in the
Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index ae9409fe398b2..a11a60b9f369b 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -28,6 +28,25 @@ led1 {
 			default-state = "on";
 		};
 	};
+
+	reg_dc_in: dc-in-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_in_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_vcc_4v: vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_4v";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&reg_dc_in>;
+	};
 };
 
 &emmc {
-- 
2.48.1


