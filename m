Return-Path: <linux-kernel+bounces-762782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C333B20AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CC51890DF5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD46213E66;
	Mon, 11 Aug 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma3LZc9v"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238FA217F55;
	Mon, 11 Aug 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920458; cv=none; b=X9HCfrfTj4j5Jh8s9GzORgzFGkGdy5PD/Xin/JQWuYSPq1+bCJHTkJaAR2lcflsBZLQo0xYtwhUWJ7DdZegY1OoHarn1wRshagMpQGBtv//Z76DzC6WXi4aFYdLg4UuP2dMAKTUH9JNr/a812w/P18cL+i1bB9GXtTh3yQm4Ttw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920458; c=relaxed/simple;
	bh=RyAP4l/zPWmcwBSNE2d6uKakntoPAmdHkSji5mOR/zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BkTj6Dlpj4kd7UbwXRttCuDmTuQNva9LK6f88Z3Le9GRDYlnz5B8DgeG2jtRs45Trhs5P7hCPjU1E5RedcnbRc8fKj1jGtdTjD44xa/UYwSYmZzzVnS5Euz7mGThwWZAoEVmUyHiAdDvEYlRvv6MQaGWziTOyfqV1wU5ckv58jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma3LZc9v; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2403ceef461so36738495ad.3;
        Mon, 11 Aug 2025 06:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920456; x=1755525256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=njXuK3euMe/kZMogavF3/6ffW6FWMiYEAwe6fdu8xrI=;
        b=Ma3LZc9vmtJX4tBrt0whmGwo8cdY4AB6nMCnidR4N68NdBcqGSNc9M4OqsSsWlthAw
         6XpjKxlUfvdcLMPQlSo2OOvRIeDCdu6z8yL63Rno9B6X6n3u8UOJqJetY7CuX5sLM5Wq
         fLF8eoQk8UMBSpoG6qknxqdTeGUHiXaIMNHMG7oY1GnoIffdX7jZ4903UxDDzzRwxk5p
         mWQcrq71cgK70X8h4fu0WkdnwlBBzGiQ59Q22LbnG7c/Gda0Cz+x0vDXAAVcDFWPh0tw
         mXZpp/iIJSgpjQPYoWVx8zZhcrxSUeODegeVE+Tdhp096CGKFQeV02D6Cgb7WgQuwJei
         b+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920456; x=1755525256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njXuK3euMe/kZMogavF3/6ffW6FWMiYEAwe6fdu8xrI=;
        b=Zn6xjzk9k+1ySrQ5+/Uh8dnmLh3UtMsPmiL6z8qqN2Q7qqGF51JhlfpyPk8x/VlUca
         drEWgoqHjzQ+cMUQTq3UuKkyo/mysCRlVHMwrkW2/z1H8+k9grHhhiOUHPNr8puuzX8L
         pd4O3LaepD3Mvdr9ktJrPruhPgegvojgH9fh9RWvcFp2CKvs0LTt/DQLbhsijKCZfe5L
         BNmRJS8DpZtuEk9n0J3LumoRpsvHW79tkWlFBWEmZqJ0WUnwcwXZ6HXgGd+T2+pBuRxk
         02kecmqK2szgEFOKNG7i3g3nu5ETkf5h+15+CpS1Yvr03hhjgDEtlz70rHrizdEmibbr
         XajA==
X-Forwarded-Encrypted: i=1; AJvYcCVOUblgp1kOwvJLkDwl6oBLz1g95V+QCMdkhlQJ7UEAxo+dmGEG/aSbTw3Hx8Uc+wz6FpYeXgYgaYFK/d7B@vger.kernel.org, AJvYcCVUTL5FGDGNC4DmH3XlkQDyH3vTKO+u+8b+aZEgz5bgYns/IWh1R2+1LwYHb97vEvUq5dLIij8fzITB@vger.kernel.org
X-Gm-Message-State: AOJu0YxgqQse+i5sqphbRRagpo0Z3wkCTI+3CWGnz/AhF/W2reL33ti6
	qXbA5x9OyNcaoRIqZCaINErogWQP+QAoYY8oL8TqceiJTS9pFzZVtHRI
X-Gm-Gg: ASbGncuf/fYXFtjCZk/C7JNR1wRTrsb4CUR9SrZCoWJOCFdpu2aB087QqPeMz2Jnxri
	gsc2QlTPpjliotQwcrTbfSwwm/Drakjl4XM3KsXoYifTT+yJPpOx1hyGqvqsG8mg4SMjzbXPwJv
	O4McU95ph0zpNi8Ne8SUIUcsj8vTZfc989icT9Yx3F72NwjGY8SIvzHD/FX6Xi9ZkaeXBFums3f
	/HDC9iA3BqRw0JldTzLUDUFqxGXGng+lmoPs/8TURWTvkOYvxOClvcqCkTFxrTyUHipba7l8nh0
	nh7D96cHFcIUTvY9Ik9oPpxGTxP2nKJcwMBUJdxpDm2wgTgSOiYTVkwUsUZ5Vp8b/WieyVjlIgA
	cF5V0IR/ZPSzCkhvdaeMLXr+UcduzL2WVaz1XyNb0HrtLtaIE0wXEUEmFXQ==
X-Google-Smtp-Source: AGHT+IGrScjZxGAQoVeES5vrMAAEiXvuJkpocuymu0hQtDgdymNeonp6DcM+OcVkEjVZPGfSG1hQvQ==
X-Received: by 2002:a17:902:d481:b0:223:619e:71da with SMTP id d9443c01a7336-242c225767emr203264025ad.49.1754920456171;
        Mon, 11 Aug 2025 06:54:16 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e899d272sm272976285ad.135.2025.08.11.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:54:15 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:53:56 +0800
Subject: [PATCH v2 2/3] arm64: dts: apple: t8012: Add SPMI node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-spmi-v2-2-a291acf0d469@gmail.com>
References: <20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com>
In-Reply-To: <20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=RyAP4l/zPWmcwBSNE2d6uKakntoPAmdHkSji5mOR/zw=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfX87iL2CjHFNJCuJQ9I4roFaqK+UKkKCXZJx
 eKPQUxmTHaJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1/AAKCRABygi3psUI
 JP1TD/9HPeYKU524PqwiZmBwkDCq4p3VGO0Y7feNyOfszAdgTCzHKMFxXVxNIbjTE2PyoF5ugYd
 Nss2mwVjRBWFrg98bGdvqfnGKoPzsHoujiO7GqB7kfaXEy5wWrvc5dvZTEnfTWnA4UX3waSf3bG
 JG3+/Pnj86EBtI3d3EVScr00gzR2GfHcnQ+ehDSJGAN/vIitchqqXFA2yzve3RrcVFT8+iGRJNV
 tFSRdwXoTHO/92gWj/aqc1DSRJIh45dp8NG1NgqARmagCTv/L5Jt0d3kuhE9xLRi6bo58k2ovPQ
 iUWCm1ip7nLi1qMIQ3yGbBOeLxowWukg4I0JMf42tft7Ag0mjcDj36eHhCG+RsTVHFoCats4bsA
 eGaVPIugyMROrTHnY+ZIcN/LhEmF6hZabljg/2mbGOaAEnJqadlpfdgcYXWZyf0eTuS8iQo3I8f
 PaYmpt8XhCFtxklZb3Gsv9Pcmu5RxCnuJrVwNGvrmWryUVNoTfciFPPHVXqoxONZR3R9ZPFp2WP
 /sfAOHjRL8atEQLJ3eExfTopY55aU/GKORZqDRSMs5b/eVPw9AEXOUc1M7D+claCAT0XW3Xd2/f
 FaZxUUMiXmaEFe3mqMR1HO4Xuoqwd789Da8hqwgG+d1R5oknCUERY1dQK6WnnqtK1DTSn2fZuWy
 VULoEGS7qpip35g==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add SPMI node for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index a259e5735d938cfa5b29cee6c754c7a3c0aaae08..60e73a0401a80abd03f82d24845dfc12d8770ebf 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/pinctrl/apple.h>
 
 / {
@@ -220,6 +221,13 @@ pinctrl_aop: pinctrl@2100f0000 {
 				     <AIC_IRQ 137 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spmi: spmi@211180700 {
+			compatible = "apple,t8012-spmi", "apple,spmi";
+			reg = <0x2 0x11180700 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@2111f0000 {
 			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x111f0000 0x0 0x1000>;

-- 
2.50.1


