Return-Path: <linux-kernel+bounces-768290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4EB25F66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF255C483D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFC2E975E;
	Thu, 14 Aug 2025 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFtQ3479"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEB2E610C;
	Thu, 14 Aug 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160949; cv=none; b=a8K/EMdVBrek5FymBjuFn+e7UkIcRv+bLNQvMpNC+r1guGeNVgmebv8FrA69SXESmVeWpZHhwBt6EIFME/ROo+Y4cwnSO+7rqrwlpqk5ZfG2gSPbaP2g96DNDy/CPPydlVLZQPtPVM9cLSsH1r1B4w1Y8x3Rn20aBbvQEM2vfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160949; c=relaxed/simple;
	bh=JBcFfTnuAxsZxmRhQrEZTdzQ+D7RTRUHtornFcNtc8M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPC+znpBfQOnBBQcjdCUM145Z08J3KGv2Td+C+oaTANC0R5XWYhU2iDmymaUCA8hL5s6GZG95yejt1+JVgI1QqSinWCEBpBGriFa9VMfYbZxom+e2drM7fQ9+KTCJNYwEE/ZOY6i3rVHsy21SezaSzd+ziFhvnADkGi4v5tVi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFtQ3479; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b9e4106460so526514f8f.2;
        Thu, 14 Aug 2025 01:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160946; x=1755765746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qcztVxGVnrCnJstyxMe9QKMd8mGJlLFli+mnzkxgSgo=;
        b=BFtQ3479whM23VoTuKrK4RJ1cnEtfODF3FbzOvi7xq/zTsN0782FY+urc4i/Oy2GXq
         HkAt/Q+QFrECHz59XGBASx+bV63MqHIzcC+i7F0Fz6C7OACE9CU2BJKJC+xtj0mkFe1e
         36J61mdtQ+dK4WH1RYti7IUiGAEfWZ8rQeR0vAu2flgSvRQaAIGPMvD+9S8erqy61/51
         wB6RjP1SKWzD4ZtLhF3jQzk1yyFVYdrsm2vtzAWJMB1SaagK4ClrXj/870UZwxCBQNUh
         VpRhH0KPy7DJU0mZG82YSaFXApnE+/DFT2GBvGfoT5jgfj4rWYoggAZKfjmXOz3ZbAmc
         UWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160946; x=1755765746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qcztVxGVnrCnJstyxMe9QKMd8mGJlLFli+mnzkxgSgo=;
        b=r0aVXaS1Zzu1obEYAW/FA3mclGTAEw4lWEq3wak6ms29Bxm5DmOlDL6QDrfpLdayKs
         +SnMM6DiDUu4eOaOtgZ+8THQNWO7UD9FzBYZMDfoXYYS2//mc495NSeVHktCn5PTL8fo
         HAfqDrwzY+5e5AkbXsy3/04HX+2eEdsab04r21FAJoOKPkl+HQFvrOtyKqGYeMqJ4sKL
         dJQL0fD9ovkjE/eWid+X8z+ci1WG+af34zxstHv/yFsJTn3/wxRE4viPtkwvQwAqvsm/
         Dt5WQvlqMk0w5Jeg4bBE4aWxsYWam7gkiQ1Q9ol7EU8mqdNyaenxS2BtKATz8O45ep3W
         TjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU10RYvHljPmDB3pGO1o71Lvenm33UBFxJx72l+N/r+fw7kBYZhq5Ic1KBVqbQ5IyqrmTEwPzNL+yiW@vger.kernel.org, AJvYcCUIhPTzrb6HXbp4FQRJMhyRlLcRz9td3FYm9em7+PMSdzfV5JNHDhastZuZ5rqnWDCyoyaNv8xrLMgXrVlE@vger.kernel.org
X-Gm-Message-State: AOJu0YxEf3487BLhH2FFLaOTNntjYApIZ6ub9m+lwORLsjnUlDHOvyb+
	QKTnllrDRlxGsO6n5WW2V2XlY84HDBc48NmENuNdubav2IcLSwgXzLxk
X-Gm-Gg: ASbGncvJ1/LKEB4fW6hK/6YF4QJ0+pLWxl7KLCavPUs32Wilp5EXK122rN9phEgFuGp
	VVpDtUysfdwQQd6iZNr1jOIJH1ajK4ClUlUs+jlYep/VSLNtD7y+Gph/t1+lVyUkKV22EoKXGn8
	JG3/QaCv+/J72S4qVixTYSC69AN4aUbvPKWyDe2ljNzChBS2dDR02Fxd5KFw5xhM9ixQSXFnk6h
	Q/An8oAiwYB3BYCKR2JDwm1kKlZAY0LHTuEmukw5Bwtw5BQSk/zNi8LIJBpkjRZ11wWx86AKPRE
	VPuIHCWtwmFsa03gWpqnIMMo7JiUIMtic/P2rnnU04IBk5TCTfG/PwTMU/KXSQBCVVXntvIW2PT
	0istKXriTpgQNrwKttEfXJwBTq3Kqqdca0A==
X-Google-Smtp-Source: AGHT+IGNGAaqjdrkR5ie7BopjeIbjP2Ysg5xIk245PoOvFZ/Zh/gK1jESvIEVcJ1jKZ9Cs2PCEoSNg==
X-Received: by 2002:a05:6000:2381:b0:3b7:9546:a0e8 with SMTP id ffacd0b85a97d-3b9edf648eemr1801871f8f.41.1755160945741;
        Thu, 14 Aug 2025 01:42:25 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6e336csm13114565e9.16.2025.08.14.01.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:42:25 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 1/2] arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
Date: Thu, 14 Aug 2025 11:42:17 +0300
Message-Id: <20250814084218.1171386-2-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250814084218.1171386-1-tmaimon77@gmail.com>
References: <20250814084218.1171386-1-tmaimon77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine the NPCM845 reset and clock controller nodes into a single node
with compatible "nuvoton,npcm845-reset" in nuvoton-common-npcm8xx.dtsi,
using the auxiliary device framework to provide clock functionality.

Update the register range to 0xC4 to cover the shared reset and clock
registers at 0xf0801000.

Remove the separate nuvoton,npcm845-clk node, as the reset driver now
handles clocks via an auxiliary device.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 .../boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi      | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
index acd3137d2464..e4053ffefe90 100644
--- a/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
+++ b/arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi
@@ -42,17 +42,12 @@ ahb {
 		interrupt-parent = <&gic>;
 		ranges;
 
-		rstc: reset-controller@f0801000 {
+		clk: rstc: reset-controller@f0801000 {
 			compatible = "nuvoton,npcm845-reset";
-			reg = <0x0 0xf0801000 0x0 0x78>;
-			#reset-cells = <2>;
+			reg = <0x0 0xf0801000 0x0 0xC4>;
 			nuvoton,sysgcr = <&gcr>;
-		};
-
-		clk: clock-controller@f0801000 {
-			compatible = "nuvoton,npcm845-clk";
+			#reset-cells = <2>;
 			#clock-cells = <1>;
-			reg = <0x0 0xf0801000 0x0 0x1000>;
 		};
 
 		apb {
-- 
2.34.1


