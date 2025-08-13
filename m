Return-Path: <linux-kernel+bounces-766263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E730DB2446D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6E456034E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CF82F066B;
	Wed, 13 Aug 2025 08:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwpGmFVT"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8912EF64A;
	Wed, 13 Aug 2025 08:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074048; cv=none; b=CR3csBML1nZJAm5U5/ZUgfqVMsY+om+fJ+uZfQ7KlbbB0TG9KzdaCmzIEhxsVDpUlH0jKHj0ybmiRjdbhT/bbDT9ZsvQzyEcBHkOdyUQZY9w44TYZdnc7yzNlCj0REosljr44cucHzwclvuq5CC79/dsG1uWp01EudDoFtpr2Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074048; c=relaxed/simple;
	bh=QR9rt1dx8wRY8ZK0TwZiHfOAeokIcX0oUcFGhOLvmKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMgeODANe7XO7gNseuBboEs4lMAxAHgcCFfteRN+kw3JUb7bGc4Hy+/uqJEYsEvwDe8itrvlGl00LQoeNtkGO5RdXWjA8RlhiiBDK4EAdSijOdZn74rN6qMgY/PfyoyOOyDqrWfedj3W+8G7GKxTzkDoNVf8eN0nWgTRTFIU/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwpGmFVT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2430439c05aso13437035ad.2;
        Wed, 13 Aug 2025 01:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074046; x=1755678846; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLh7Kk4OYjALVNhIIaD4wUDlSppRWWz8p4xTrDTK0VU=;
        b=PwpGmFVTzsLG+bq1teYaDCk5JKu+l3zhEyIo7bIWJrKYAfr4+4N+1DJyHp74gpK0e2
         /uRIM4RIrn0J8G0vCkz8yc+pDgTpLknUc1p/W7teo/7wzD4LLhVo+C9E0qy76aKKIvR8
         k3Qm4lObaGyBtJevPAMWhEvCnOv0h86xUKqJP67rXHp9LBPfwM8/ZNnJkVohu8uHb5e/
         gaVGikg8P4DqC4y+OqyY3EeDCX2GrSMDmn3vhKWx5uaPc+B+lkvNOrgqKcnUC9sodd6x
         8uaqSn9S3/lcM0eXSINVUD8PYgTrH5+/x0fL+WTsv7neLVwcKt90OIZ0AxEmG8SxlZec
         9h2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074046; x=1755678846;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fLh7Kk4OYjALVNhIIaD4wUDlSppRWWz8p4xTrDTK0VU=;
        b=XkzHJ98bFC5lNMvFbT0AwiXq+LGoK6TQZEO86IjoWMPgAAxaPRH23D/PVcFVjynL2R
         WYv/uJLBKJ393TQ4o42L+qUFDj0W1JchXkAquzRgMg7F22oEK0UOg4E2ZsOrWFZMV5B2
         UUKrZ0+l/tovD1LXhuzeGxHPgHRxX0aT8lUizMeW+GBV9xZ/MGkGxsUuBxCrDsErJm9P
         Hr2TJjSDvf9wOpJwgyfoYsSFpyv5CJvPIQ1wbmefjlvrNjGda/w24l0y7XbHoktlZTGc
         +AT7NIq5OycGIFRWA/ecSX93uodClLUTmJvbwsX8rY8JfPmIE+OTAu6Njn76Tn8JF8QW
         eegA==
X-Forwarded-Encrypted: i=1; AJvYcCXMT0UXQw7u/IOq/yUCP4+4bakgmSabiyFPeuapXtCpJwoiwOjsPQTuoztZfZ3MyUDsAp24z84T6Ptp8Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGRCEJV0tdDUdW4CoGNv4qDPQ68Tz8Pnl3+rLGDq3wdbUiAule
	6y2hal7upGG7nprWlpFneFU6yzj+MLa4mHNQz8ygHEbScvlYsTK//dRQ
X-Gm-Gg: ASbGnctS4UAMJtJy/dWcvdXPviK+qcmYvJOm7pmgv4Qfvrcvri/zO3+mmNV4TUlcd0O
	7/mli1SosGwaa2WKSMaucQ3418m+sVnXb7/ZwkOscKuk8amtTKFM4aoCMUu8Ee+kog939F2wvgi
	UEZuU2p10bVwtvBHFqgWDEm9+9Cx03y4TIUgvdX36W/vG5StmLYYldcWSZ72sIaEWVZvlPx/5xo
	Eu/uFpKjhFiuraLJxiuyDvNmIPdDTn2oy/l3yzZJ3WhiiD7tWi2vkjblkAcJvihQYvwbj/ZCy3U
	Fn11M/JuKhbFhvnM9GYqgAGpv4DWHarypOhc9qoCflGpu9Ba1R/kXIFt5W+LsniQ+LoieMpZPDo
	ar4qeDF8gFBeet+PRxvVvwtYN04e4j3wA
X-Google-Smtp-Source: AGHT+IEEUcjPWyW3+EqWvnD5E8+0bREKP1ea0Z5KKh4lSYDKYOfsw0ft79JZxtY8fSAzLb94o+PTcg==
X-Received: by 2002:a17:902:ce8e:b0:23d:dd04:28e2 with SMTP id d9443c01a7336-2430d1ab47dmr33684355ad.35.1755074046271;
        Wed, 13 Aug 2025 01:34:06 -0700 (PDT)
Received: from [127.0.0.1] ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm31307814b3a.120.2025.08.13.01.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:34:05 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Wed, 13 Aug 2025 16:33:20 +0800
Subject: [PATCH 4/4] riscv: dts: sophgo: Enable SPI NOR node for
 SG2042_EVB_V2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-sfg-spidts-v1-4-99b7e2be89d9@gmail.com>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
In-Reply-To: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755074006; l=916;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=QR9rt1dx8wRY8ZK0TwZiHfOAeokIcX0oUcFGhOLvmKU=;
 b=Uus7GJwPp8hyacJ983Bo8pDUNcIFyjii86Yas9FPuyQSkIFFV67tvExpI9nc3thUzuBPLdj6T
 1EGrsJin13jDKhinFEmR0uA+IEAu/ygtsCjvUbhfQ/hJiUnN+AuWnom
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Enable SPI NOR node for SG2042_EVB_V2 device tree

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
index 46980e41b886ce17dacce791fa5f2cef14cfa214..7001d8ffdc3e04c5a5cd5da85a4fb1c0351eb9a5 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
@@ -226,6 +226,18 @@ &sd {
 	status = "okay";
 };
 
+&spifmc1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <100000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_cfg>;
 	pinctrl-names = "default";

-- 
2.50.1


