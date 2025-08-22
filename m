Return-Path: <linux-kernel+bounces-781832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB58B3175B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2EE176B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2172FD7D3;
	Fri, 22 Aug 2025 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rpZvoWKc"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60AF2FC037
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864878; cv=none; b=ELz6sScLP0bwj+DEPTJPQymMJIp7Qhnogk24a6sc54HMSCy8bPYqbpHl5oRUj42zRZUGseTo9cRRVMegSzbh13yj+KUYZIA1iwowcAFy/PzQmJjrpKNi3Ku7nUfdKp1y3HvD4UHk/YaLTEKZu7OtkYJYGI4/ZkzlBHFDiOTWL4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864878; c=relaxed/simple;
	bh=u4Q49fzz16cztRN4bhMz4zWhFIJDuK0fi+nL3nK66Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pSQ6B9I1+q2dtSdI4d/mjubI9o7GjB/75AUIgI+HiiiUn6fVnXXLNKbjT2yoDJy0bXC1qeBb5NYLkSSCc7dsnrMjre3WzCR3DXnzi27axVSo5PRPhy0LSAZeC3grJd0jWS3DWok+9wbjmeNIIlGXHUp3S99xAE6dqgVZaKkEPyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rpZvoWKc; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78d5e13so26333866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864874; x=1756469674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpQFNfP1MuP2zGJDIekphY6+xfLWcndjUj7V6Qo/mqs=;
        b=rpZvoWKcDUDn+mcxEVjkRANTTjUgcU021D0xmTfskRKVhiKz5ZPzbHQ4gv4kG7baa1
         l6yr1H2NysZ6Kg7PlrZJ1tZbSdgLHm8ZDaRFOIgWKspwNrqmrjlgoXaNBkRSwuwci0og
         QCUgB4BO2tSa9ViQ6/DatO0kLc97sLWabkyN91qKgfXimASIlND4no2wP+Qc2fVfku4z
         s2iRor+GpaaQKFYL2lLY9YHHdnIgH4QWIdFpiVF8xc6wTN7zSea1XZTyDHqIab/7ESxY
         QRiVgr2aWLCy6+czwpOdID6CXJkDXH3L5xrojgTjYvqWbvM0lauy+61xhjpr0RbJNWo/
         CxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864874; x=1756469674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpQFNfP1MuP2zGJDIekphY6+xfLWcndjUj7V6Qo/mqs=;
        b=IdUjkkKd1QEjc/ECOZjKOBJ5TV5VUz5he1BLgXcCpWIE+EWp4OI8VRY3zNwY4R1mdi
         sAMZRJ4X8gwWHgsOydeJdLCHtLg3E6gSS9zW+2vkWhn4BgHDwmy0cO4eaDb6aud6s6x0
         SIOhUt9GWoWBUsyKyx9S5EIgc2Ym4ArxlVltxZxiUJwTXAZQHwLd64iTYVC8yP9ebJ8N
         0SYxZ4dh9Dv+NMywzDcb7jctJlJy3TFMfNa9NtpOyhI8daauMAboA96mDWSuw3tAIi44
         Oib86RQgu0fGwP6FHT12kxbrGZAcMgejViacZ0o9G8mjK/Y3Jewg2qcHoy2I8kEWpdn5
         e08Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1Gnbc7wUy9Ort5kILnUst17mX6iSdUZqeFDE/osTvo3r/aykY6JEVpNxKJ0Nffg74qphk+xUWspveaEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1pC5kUpMEvifHB0y5qzYfgjI92XQWWGv4TkJ38dlB+USN1KDE
	tfpofEPH9qsnVScD1V2bhIFFL9WJZRtWWm1iXbh4FqXtutFkSfazByarzt9Y8OnjlSg=
X-Gm-Gg: ASbGncsk88xuE600xOIF3W/lwOLITZ6Co5j0MLqNRz/+/tBu39RQULpQViBPL0jDV+n
	G8Q7bOs5tlvOizY7xy8v+8e6SF7lj1m4f9z31JdRa9zTkk6br4B6pBjhzqfjKHLlw49UGMtZ54M
	0R2uCcgJabYmDtBLQEYLh50esw5sl44G7RLJFUXrl9q+nDyCIDGmiCkgywNv0UllLwNVojtURWD
	NG1w95wjMZDCmiuF7r5s8xHDZ9SE7n3FQHkVh4kqwP5bVKB2H2veZTz6O0i63wYIFY/EyGHZ+HZ
	6zbajaCN3tl/5QRId5ISrWvxoJqv//+UpsNFXYXUvgI5pdsYQEeAOybNj+KCS5VygdVDf6/Y4E9
	LD/fhkbIWlxf8R1QZRO+nDnmeLAjK1eXeELL0OLvs6D3d
X-Google-Smtp-Source: AGHT+IFvZy/hVC+pkJt13msp2gYUwDT8avyVy0YPiKQmu27rm2o1448VI3vZXw0It6rSB4Aa5n3zgA==
X-Received: by 2002:a17:907:94c9:b0:ad8:8c0c:bb3d with SMTP id a640c23a62f3a-afe28f08b6cmr124114866b.3.1755864874131;
        Fri, 22 Aug 2025 05:14:34 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75778c5dsm6842065a12.31.2025.08.22.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:14:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-fsd@tesla.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] arm64: dts: fsd: Add default GIC address cells
Date: Fri, 22 Aug 2025 14:14:26 +0200
Message-ID: <20250822121423.228500-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822121423.228500-5-krzysztof.kozlowski@linaro.org>
References: <20250822121423.228500-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=755; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=u4Q49fzz16cztRN4bhMz4zWhFIJDuK0fi+nL3nK66Ik=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqF8hYv6B+iYK7dUhyfFddjuhtdNLQmUTGiyKM
 PUtycqDXfiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhfIQAKCRDBN2bmhouD
 1xdjEACKbhNaHa/2goI1CLeFIEuXCJeefaB9pYRprjRWzmncfcymr67jhqPtF5Sr6L2FhZxr86P
 zpPOaAVvF9wd0O2Z7Jjn0I9DUcv2+YQghQyyO6RitaMZQdJaRRcyRDEOhOT7gHcvxhEAR8lludm
 H4pZ8B1BA9VJCUH2Prh9rjCHI0TzaSIgPX2q9bXH8vnMNoC3MmaWRhBD7ANy9/Sf7Wi3wUMULdt
 O5I7auGPCSmnJEv2b6bWeuu36vMv7mH58aLOvUqMNtNnNJKOlRxXoQKcuVTATreoNDNe4BDEz9X
 XVsimYLxCTqdcD1+G+tX1f1fbY/fWWzhGDmKmjFqrWFCGPyUk9UvNJKwVOTJiDqZelt7YjBvJY0
 Ck4Gm2931W75VpSR0MrUjpTWGgJo/BQLnlU3Dj9vR/FilsmKfCiHup/Uz4s4jJRr5nQYpslNvHz
 NTZYXFILqvvwvBx+n8P/7oVlfzLA4SFF1OC0rlc9K9uHqgECCU33jO+G8lWJ4tI48yjA/x3dmsZ
 gLfiT44win6D5tvDyoGompMy/Iix0Ug5YbAsbM/2QOH2g7zQBbDWRQ5wm7CUCcBVxSw8jVGUuSZ
 Ey36mb/ppTOJ71RoKC7o2icrUIYH4qSEhJaczgLn0de/ncDXJhLUfjmupYuEXkNN2aleq8Sbq50 OPSDtptU+XCRleA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node.  Value '0' is correct
because GIC interrupt controller does not have children.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/tesla/fsd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index a5ebb3f9b18f..5b06e2667b89 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -363,6 +363,7 @@ soc: soc@0 {
 
 		gic: interrupt-controller@10400000 {
 			compatible = "arm,gic-v3";
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x0 0x10400000 0x0 0x10000>, /* GICD */
-- 
2.48.1


