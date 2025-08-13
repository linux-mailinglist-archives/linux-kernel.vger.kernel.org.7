Return-Path: <linux-kernel+bounces-766261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4713B24467
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A1F1884951
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA42EFD9F;
	Wed, 13 Aug 2025 08:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/78BOgB"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873E2EFD88;
	Wed, 13 Aug 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074032; cv=none; b=WNWO5QITgFc8A4cK2vYnnwqKLnnyRH1yPMRVh1wJbcAwYPnYhw9e2Gsxbar3iVJ6t8MCzjaaColvuPPvN0e1s/YASkeuVswhZB40g4mVqxTO82nvYkRcUG5ek9XVR8p/4I9V+iUJW/kcLtpw0VtmsAX4FbkopTrOGeBUHLbUA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074032; c=relaxed/simple;
	bh=XCcBhLdQCV5TovEOw9nFA0f1JDSfRAWiRcTxRItdr/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4u4ckg7crADhOltdmoPid8CObVhqx4lImzwE9cjWeuGMHyi7YqfNoScGGDaJPC2pAzIFkgiENWAaO/1sYZSt5kLuxNP0aBw875B4YzWde+FHbmTEIbsisb7FYZa/WyBIXcSe36/ItLponc7AjpyFN+srC+eC0b2EghnqXiJSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/78BOgB; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73c17c770a7so7939125b3a.2;
        Wed, 13 Aug 2025 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074030; x=1755678830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wq2k+55Ab73eX2+RWOpVJZjXZGzL72LB3pCtHrAjwhQ=;
        b=l/78BOgBPP+kr/ORI0BZEOFQJ26sxgEWpu6YnssAPdW88PCRIe8pDb0c7Ni3YFp1rK
         fmCPoOrnOW7WPmfsM4NJIReXKdL8+appi9xElQ42EYTINBcj7liVT7RqJjffjNvuVoZk
         pf4sSVMAIkmLmBMBgX+na+0tBbrmW6ReEY6LmpRFcHnHZMI0RHzgYL3R2uFmC2GuPFGr
         Pbvfm3q05k62sgvIN9KoWARAQxeLCFJHffOZV3nWiIXWobiLH/6UTCVbKLxadCOpiy/X
         sC7T+lQx+N33Pski43Q6WbQciao0hDB5LSKgHM80/hGUCX/7WAxfjdf4JSSaeG0cxyGN
         pv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074030; x=1755678830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq2k+55Ab73eX2+RWOpVJZjXZGzL72LB3pCtHrAjwhQ=;
        b=AZeXxK4p6aWUOdV10AvNL4sZ7t8PAw+bUvsOe8W3KOILxvWMkNrotYZOGyKxThjPPz
         Hc4jP5NvZETv97Hff8o+hARvo+WmDQ7ErdQgyWQ3WaLMapv3mSoms2nn1waxDLYw4RwB
         nM9nyEndzXHz+yUbGiIxQKH8cg+hNzYbtPwagrQNEvc7WH7ASd3FfXt6n5ZZSNAxiMsW
         cN26iHJcqvum06EYFSPgIuTMGD8ma9MHK4Y5PGtEZu+W+/WHyPlssc4/Ai98izZCJjyp
         uXIqftvHc4Y3gP21KnVNOuI3w8OAvuNlc4GuHQbRviWja33zjQGr/74ojzPKDjlBL8UU
         r0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0tQ10y9SPGnuRH/6LlZ8iN6F9FrimEcqQY8E00JpE+W0M9BkGO75EeKoXIDtrrZIDpuPB+s/Y0WWO7AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA1j3EuuZXg1eXICVoASSqQ4Evoom2XlbBjcb22WqgMpYXZFIR
	KEmSIZkcg637WIHTE6P1WCCF19GYQMr51cJmR/6/e6PbL9npN3idjCqp
X-Gm-Gg: ASbGncvWL2ulvggIwp7N4wk2ssFqWoIXWDhucYw9gSh570X1hpvMU6Db9Va25CPtQ6v
	N9A1qKG464uf82HTCLwbG88mtzEzu74AOb3NdqqwK4d1zZl9aGPDVm0Ffgi4WTiO2A8bwlweKae
	WY5iwdDz6d2Uyn+p1AMsSKDwrPDJEGb9FjtSJbYmckZhc11hC3QwQH/Yf/2psEh6NX5NNHnvva/
	3OEj1OCcb7hxMYT4hL/JlouO/aHf7H0wtXKzqTPX4YIKk9HNlrykimFeq/yx6QVBPSbeBegmmUc
	CzCsTmD/9fuBB+XwriouVs4SC6iQYQBdCjgZJfHgrreWDUn6GBenPp1nSNDgP9KSwHiaV0svTWP
	xJff3pq3Z2rmBSUsIjojB9oG64nmB73/l
X-Google-Smtp-Source: AGHT+IEfk6doVGoDmRTH1HGierQdyb5DZdCYmbzXWdhql7JiBQuLlcrHvNdWPaOoLf3yIBMJIUCv3A==
X-Received: by 2002:a05:6a00:22d0:b0:748:ed51:1305 with SMTP id d2e1a72fcca58-76e20c9a175mr3054927b3a.5.1755074029634;
        Wed, 13 Aug 2025 01:33:49 -0700 (PDT)
Received: from [127.0.0.1] ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm31307814b3a.120.2025.08.13.01.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:33:49 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Wed, 13 Aug 2025 16:33:18 +0800
Subject: [PATCH 2/4] riscv: dts: sophgo: Enable SPI NOR node for PioneerBox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-sfg-spidts-v1-2-99b7e2be89d9@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755074006; l=1215;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=XCcBhLdQCV5TovEOw9nFA0f1JDSfRAWiRcTxRItdr/c=;
 b=ntXtnj33yA6oSILDv+mHhzb0RrZs+vQ3X8WLAWJ2qXI8BbQZNK0ALxACU+7Yw5qjMlsGU4O9c
 BNYcHJXWHiAC43XNWIS/lhRbb00r/RfpONJEI2RksvXUk2DVRkUahPD
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Enable SPI NOR node for PioneerBox device tree

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ef3a602172b1e5bf3dcf54a8cacdad5172b7f50e..554ec14d58453a44a02a82da40a7aedb80d61dc9 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -138,6 +138,30 @@ &sd {
 	status = "okay";
 };
 
+&spifmc0 {
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


