Return-Path: <linux-kernel+bounces-818872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4226BB59779
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743722A2F06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAF031B124;
	Tue, 16 Sep 2025 13:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKSM/yYk"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD831A54D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028992; cv=none; b=FfDC5VjmafquUOFzWTYuhIBapCh7qwrm3dkHZ2CokjujSsmCbNkM4OYSOO0Mpc0NxVolWVU3MXjfsHDUcN3/GN3/Ss8S3ATpyy01Uym6HrldYzTvULAAlYGCDJgwmQ/xZzKl9UIQU8ZHzqDJHZjyxBAp/0fvQNg3SsG/dJJwMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028992; c=relaxed/simple;
	bh=3DhmzJSYRDsFCvFry1NGwCNmIuQHA8Daa9KPGiMP4XY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Za1QlwxJ3lFakGW73ZbN2xz6d/JSJdU5Z40+fAXzv1O7FTtWyJK+/zI1by/MGiRXw731+2Vnyz7ksSRqt8ju0rXW66PfnM8El//CJDwRCdflIInIBlW6vkH3eRaLkeoCBc+NF6M9va9UhqqVrprQE+0cZa/nno9fEr5Vui+55d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKSM/yYk; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7761b83fd01so3706961b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758028990; x=1758633790; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWMqq9LO02bLf8s/U6m0bmjKdBTSQTZetwyPUYJWXY4=;
        b=UKSM/yYkR9MroMmuSkZh2/sYM/3XkNYDIvF4mbhvvTJ0LD2hOUy51fth9emt5UW1EB
         vq1QSDJAiHq6PwsLGAM8AhflLMhuOZp9vgFwpe9nC0BTU9Y0N3xYU7CPYLOSYyOIAoYu
         4EMpXuvxwgrM1HUIhsamyYVeID43sEFJ1jiwfduvnqQLq1UnH8G27yB3xtsIaumX17wr
         bb/BMFd74dVwZaVoyAYa2AB/p+Hduzkd+0wMnaF5pfSxjVKUF8C1WytiqL5lwPJsiw/E
         PVsnEirSxMtPRR4LvqXa0e1nZEqVRlm93YmUd1EBWnRZhv1T8My+g4imSbo9TInZrZ0/
         ctww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028990; x=1758633790;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWMqq9LO02bLf8s/U6m0bmjKdBTSQTZetwyPUYJWXY4=;
        b=BQNYgG93/gx669Z+bvMskuXDXF+3LVT4VOFJPfc00c7rQG55B8qmjyk2F5dHG/92Y5
         lchEoBH1P3wACnXn/9xXTp0pX0jQXDygrj/n7SsjtJERUIS8sB5vUPBYb90ckVDhUgcG
         dNo3BopUWIdMR08C+jmfK4zCrlO4UnNtx5jc4rzPkHPaMHA8MGfJLucJsXi5bEFN+9Km
         p9JVBxyhuuo7q6y7pDCeY4fNN2Z6XLgBOX0GgN4AozDTNFX+6JPS+DzXph+59OSZXksh
         r9Zl5cKG2AYxD2ahrLJ1KxG1cWmEe/aVKRaKu28t0X9wDFuhypmclww5aZRQeS7Emv4C
         HISA==
X-Forwarded-Encrypted: i=1; AJvYcCWLCCY2cHlJ/6fHYJp/ftpDOT4Nc21I+TZz5bDB5FPFj95duIOpMOfienOKDpCf1p1SNiP2GYNF6L1lLno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjefgNk1jTS+a9oj5b6MDAA2gLtxtfQQQPn6gjGovytSFfnd+i
	GbwnlBfdiZPqk16wMEUCt3XBKGMRYg0eaCGXb7viRZaxLorTz6QHdpEQ
X-Gm-Gg: ASbGncutnkKVgE180KbkaeBp9sqDfaHMnUU5QU/yeLaoH5zOUNVOIuOfrDB3is6dhH/
	+LldAMBg8Gp0bpTMvDonxz5E9RNchNt/xTnuLvZaz23TvyuPiLZ8eEKMxCV5rNuzKMQQqKK4oQ9
	RQOPXdb5Lzkmx4EQKdoJW0cZYgAmBbplFb/19+M/0oZin8AE+hcPvGqpY6AT7XjlWI6EVG4l/Zz
	ejxwJ1H0ylyazMc1AmB1VHJUhoL1UxG2pGRN9VtuKrdf2xVsUBrTmQT/tTbLxowEje+2xn7cRmB
	kBIKHGNcNjDFtpFs15LtiWEI7uh98UzV7nc9Pr74ltUnNer81pgrW2uwrP22OIZKQejgBgrkpFQ
	YtBCVhn48B1tm8KpvKQNWWF02QqHmww==
X-Google-Smtp-Source: AGHT+IFXpFj62OZ32vgpqEl0jm4rS+hTk4dVTJ7qY1Ii9cd3iLkjwoIHMHjRDgvG6v07+neosQb++A==
X-Received: by 2002:a05:6a00:a8a:b0:771:ec42:1c1e with SMTP id d2e1a72fcca58-77612168e3emr16052303b3a.16.1758028989635;
        Tue, 16 Sep 2025 06:23:09 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761562f25dsm13277310b3a.74.2025.09.16.06.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:23:09 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 16 Sep 2025 21:22:52 +0800
Subject: [PATCH v2 3/4] riscv: dts: sophgo: Enable SPI NOR node for
 SG2042_EVB_V1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-sfg-spidts-v2-3-b5d9024fe1c8@gmail.com>
References: <20250916-sfg-spidts-v2-0-b5d9024fe1c8@gmail.com>
In-Reply-To: <20250916-sfg-spidts-v2-0-b5d9024fe1c8@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Longbin Li <looong.bin@gmail.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758028972; l=1276;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=3DhmzJSYRDsFCvFry1NGwCNmIuQHA8Daa9KPGiMP4XY=;
 b=OLm66401v2Yc411lYVRBOoQ+/JCntUIWLk1Znyf/hX9gSFKbuT59M3tCILRkKSEjEaaHjGW2C
 dJTZ/jmXKq1Dwveckan4KcjmhHWTbAuLhHVnTO5XbTGuox/oBOZGp0P
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Enable SPI NOR node for SG2042_EVB_V1 device tree

According to SG2042_EVB_V1 schematic, SPI-NOR Flash cannot support QSPI
due to hardware design. Thus spi-(tx|rx)-bus-width must be set to 1.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
index 3320bc1dd2c66ab1a77fce719f145070ad51f297..517943696eb464d54d42018825f02a48c6ca00b8 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
@@ -238,6 +238,30 @@ &sd {
 	status = "okay";
 };
 
+&spifmc0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
+
+&spifmc1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0


