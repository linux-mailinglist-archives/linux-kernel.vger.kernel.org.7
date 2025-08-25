Return-Path: <linux-kernel+bounces-785285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B99B3488F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32235E1A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA0F302772;
	Mon, 25 Aug 2025 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="x5ecd3CB"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE9306D54
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142476; cv=none; b=mng59xfpA6XtDThTZUAjy5Slz7oHvC9K5427NXS7jUbUZwLvRbjB2Gcm1loaKbkRQi6qy9nB7FgI2UeDhzhR8JlxAn8aPXYU+dXob3k8/ysEIz/ghixEfKNOJy7AHng7j3N8BfQ2H4AUCeg0EYRuGFZ0+l03Sh2HjtnChboeGwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142476; c=relaxed/simple;
	bh=4MkO0yPVEXokF7BKWo63wkxjH8l6ox9Iw2xywkWl/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSsTBVr3+ivM1l2Sebd0brg+bYHfPpomKFe6CJjlk8QxMzdigYIKvHsISj30auAAJEe7dykdqb3MXecgfwAMindY2b+8z6rFET+0qgi/YHP+UxDWwDIc/fo+oUs3l7VUkC6SHiKsRGejeoD7z72Wwv1FztKyn1OaTbjQ3xCAxvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=x5ecd3CB; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-886ec1ac877so4525039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1756142473; x=1756747273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzbsCOAJDq8e6tJqb71PLkWE7SOSqQYLq4powgsnVhU=;
        b=x5ecd3CBy9UbS4pAArGHDTqx+Uo0gGM+clY6B8B9JfAsiL9mruc03nOayaiO6AswiQ
         SpgBdzoCcrSOnfELmpl5hlT8uJpI6WxDtZOjtyngHphjmy9NFQEET0b0YNRlAYE4WKLx
         mZk0EetDeXcUIB7PRa61zN8ox1r8IGhUE16BRalaP6ElLKo5JEs54GOlNPRvhAezEIg/
         de8iIsLwP+71A6vQHTEtZLMf00I1zEs/I7NKH0E8t/6B5eBSTH0Gi8gLXZ6WLrSxUqHj
         mPIWGD3PNG0U+cma/J7iV0JS8mROLJchMqJa/MfLCNz0DxCKxKZBtwxfOpTiBOsoZ3ph
         BhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142473; x=1756747273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzbsCOAJDq8e6tJqb71PLkWE7SOSqQYLq4powgsnVhU=;
        b=wjncdNpW7M0RrlLNOZhm6DW4NODlN8vAD52ezrWS9oRPEd4bOLakUpJc1yhMxdqTsT
         /xy+3stdQJtVRLcXboNcHAQehJbX3NrPpGR7jze1HjFdGYJ+FF15oirMvBtNILTX6XdI
         NVzrHBx1iW8k/MtFap76xZhs7esqau76ITHpXFMb/USYRY1G93axVrlxXPqXkvOYqysw
         F2Ap+JlUp67II2OBm++xBjhqKeL+7sGqdEFiZLz5Iy8NDIvTjVz45xmKawfjKJ0IutBO
         lX5DfYufiNeeNW5/7r85R9Tnk+qWRUDjojxnqypp+Qkg/1WUmQy+GyLhjONYDPPc7Ruh
         0LQA==
X-Forwarded-Encrypted: i=1; AJvYcCXmcpYuQhjvNv5cMNeFFW7rJSRykt3E9ZeTfmZy86RTg7k2fJbB+4QEPWwfR7Xp6Qp+I4rhC1ZRBQE3zqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YymZGSLFFdLBJkOBU+52DauyQSIhOADdR6/NHx2FWQJKe9gwTA0
	RSmROaHstSGvDcf17Subr9wjG4rkAwV7q/H1Tbyn8vrvdmxC3xjotJ1nd52ygV47ycY=
X-Gm-Gg: ASbGncvfrlsoFX/8KdAn9p8gD5xfteSazY000mF++8IzhP3inAWGQlAdsE/eIKPtDhk
	CVQJ0NKwTGwaa/VhvSOUAqQ5aG5CFGtFEMmSB41rWDS6ZvMpRVFMa7zrvOSxUkVKaeNlRQ3i5LZ
	w6Vg3gD7a6yq1B/g1Scyx4ZF9MXB7TnlBaYrzL7JdWgjr9bci0fwXokbYTC+uA2OSCWtd2CPv2Q
	YfTbT0jAKV3mpEGvcdVxkl7uwKS8otiE5wGr+nYD8i7WxnUrouYfEDUvjeOzd8o1HgM4ijaaIot
	0yBxxP+zFS6DG1k10AW+10s2vjDCHZpVVCXkDCZyNSRQVHyB8LqgO6H/goEel7eNrXPQ2ow2qjV
	nvZcZQvsUc6K9Hv60LfyTgc1my2w4WAMlQSvsSSLOcQ78wA+HBntwQsLUV69PK+ea5zwrnJQR4c
	kk
X-Google-Smtp-Source: AGHT+IHaZdCnT4aGtFFcRgzebFZsbTIztmo+Z151ok+iHPQRKBlJjXS71cSRNdn35Lml0SBstQEFDg==
X-Received: by 2002:a05:6602:4c10:b0:876:19b9:1aaa with SMTP id ca18e2360f4ac-886bd1cf44emr1652168639f.9.1756142473552;
        Mon, 25 Aug 2025 10:21:13 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886e60c4737sm76275439f.26.2025.08.25.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:21:13 -0700 (PDT)
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
Subject: [PATCH v13 6/7] riscv: dts: spacemit: define fixed regulators
Date: Mon, 25 Aug 2025 12:20:55 -0500
Message-ID: <20250825172057.163883-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825172057.163883-1-elder@riscstar.com>
References: <20250825172057.163883-1-elder@riscstar.com>
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


