Return-Path: <linux-kernel+bounces-815353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3E8B56330
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94319178DED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB4428689C;
	Sat, 13 Sep 2025 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfHZ3JTT"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2272853F8
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798499; cv=none; b=i8ynn36rixCF7b7Oe7Of4wcFzbJIb0ibOZ3yVZnIm86lkTbLaMNh3y6Ry3rfqgMNvE6q3CIyQL5Xy71+NJoOODTokTBTLmPah28FSVPUpOx2lhAO95R8rIb3q8zwRnxJQwhJebjx/1s4w1Y+FZ9XqEC7DWTsTJha4ejZj0lSGoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798499; c=relaxed/simple;
	bh=uNF4o+FlWLCTLVTWRxLW7Lyuky8hKhwVnIT0SNYmZcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dj08sp37dpgcbr+Q6OL4q+xIVw4DjGjYlzsA5nBcsGjRml/AkaR/aXPhobDzrXxd3+Hy+es4N1eJ6oQIvWWk/UMyLTM1jtCTT3jRB38fn/gsstbAPVwU0xU0oKWHf10NOqreWNZ1b3XgturNVa/xg3utLnkchrxvlT02Hikijpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfHZ3JTT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so26697385e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798494; x=1758403294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1pL+OZ1Boa6u+YXgScmmKOffrAx3fdC1TFoaMx+6KU=;
        b=cfHZ3JTTFt01f4ehfJRbcSS4SDj1x/bUXwbUzCW+fMrBqtUToYvizBJWw7U4lqd8J6
         4OEsYX2ApZKt0xVuRFeapCieL/IKUscpTuoiKKuN02QadLCMKE0wevSYEXfsv9iG1CxB
         reL1NjeAsijaadDF3/gK7InqIsuovf8zJsvg9aiIDUTUKhxexDgpE7B/VSKk+PCdVyi6
         MmyEPm/vMUzmQ7C2c8V+T8GJQBQRhL9quEy60I3vQx5l/QS0vxoD0WUzeC+1QM+pROr+
         vfpTlRZj1sUS/mOIirua43XUxVgD8Kjpz2VPuWkvraDBb3gNcZJYOmtUd55tvGmvj2X8
         m7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798494; x=1758403294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1pL+OZ1Boa6u+YXgScmmKOffrAx3fdC1TFoaMx+6KU=;
        b=mGDLgIR7jR76RVVU+k4Adt44KTmIQfSrLv3hafkvRt85CjPvj7v+qgiESDj9tHGrQn
         1VK2hXhjTBTSRQeBApHJouTgymHfieeVF+pqEA+6302cCGB2QAStC9HYUtaws/GNxY1V
         G+ZMVWZX6V5/BnIgINm1hEV3xI84PTpwwNHFD35rl+03fxucUlwEW8TOJc3iJTSSx+8U
         zZyqyBx6Deut/wp0uuGODlX2qS2G7WZnCkzehdX99LF0ddR/Q3B2lBfle8XeAcPt5hyU
         I4FiomLqmQXYUckt0DcRmVwx9LaMxGdgCTZymKTPyxMcn7VOun+PJtTmOOoaalAiKdBZ
         tAJw==
X-Forwarded-Encrypted: i=1; AJvYcCWFaZfpIzqWsvijGegWtcIku6Gm7dF+RY6BaTgsRet7AkyXjIUDqV9Gy3oKayLNYlGFfyNTdagai7nRndM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyibrvkAfoL/ObyBALFEM9nzrl83e8zLlD0FxoaGc0oceL0H3Fk
	JUL3XXvlgYMb/cteFwxJmiD4OXP2bKcDBdsLl1dJmjTQQOM/mnGziRGf
X-Gm-Gg: ASbGnctqQVZVEnPJ8Ci024M8UPOiS7dtaCeC2OU8j8NXbaPEY9I2D/Xqzd60tLbncTs
	8a/U367sY3cxU0eyGl6dcrRSZP7yzPVTuRCi1nmPXDBElsEQvnGDKv9Vw3TVYwTUARPBmBTwREM
	hbbIFku+/uCYzGUu5qdUlx+KLuzwX2SijgJ055IoSdfn/THUiLpcxxIT4VagsCCLL6feYWCM9eA
	uH2DUCyxOTCm477NcUCYohU/HSovKH/pDU0dnu/RFpKY27Imw4oby79HDEBPtUHTTS9f9UR2Qa2
	DY1zhPbnx1PX699a+ta9E28KXigxQXgkiOgRC9Smb84dh56LP8jSjlrFIl8eDKr52X6G0xBfMGg
	sIpaOF5Ira8etL7dQO/qRuGX8ECzxP/9lajmBj93Sf5hHiQJ/9fg1
X-Google-Smtp-Source: AGHT+IEUygTfQFxD0Xjd1YPk8jG2g29zmtJi+7jJLe6De4WxzayNW1WWv1CJtbsKPSYW8CMC/jCaBg==
X-Received: by 2002:a05:600d:f:b0:45d:e531:99df with SMTP id 5b1f17b1804b1-45dfd5ab3bamr97128825e9.3.1757798494216;
        Sat, 13 Sep 2025 14:21:34 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:33 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:07 +0200
Subject: [PATCH RESEND 5/9] arm64: dts: marvell: samsung,coreprimevelte:
 Add vibrator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-5-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=jyb7dMVKfzm+pC9ukuRfnyNGN4DBhDuznQcq0ZsICNA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/j37juY9Cokv79Ivex67/u52+yiz786v2NtQu+Kn
 W9sVvlId5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBE+lMZ/se8UnkwxUnpNgP7
 C83rcy38H4a8W2+xQN79ernL5Qu6boqMDKt1+L48Ov2+rGaZ52PZPb8kBU7dail6FLLr4sG8yZz
 LLzMCAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The board has a vibrator hooked up to PWM3. Add a node for it and its
associated pinctrl configuration.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 78b7bccfc5f299889d1b9a8fd2c08554f17eb147..c28c2eadc42cc538fc5491ecdfcfbe0191004794 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -121,6 +121,15 @@ backlight {
 		ctrl-gpios = <&gpio 97 GPIO_ACTIVE_HIGH>;
 		max-brightness = <210>;
 	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+		pwm-names = "enable";
+		pwms = <&pwm3 100000>;
+		enable-gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_pin>;
+	};
 };
 
 &smmu {
@@ -365,6 +374,16 @@ sdh2_fast_pins_2: sdh2-fast-pins-2 {
 		pinctrl-single,bias-pulldown = <0x8000 0xa000 0x8000 0xa000>;
 		pinctrl-single,low-power-mode = <0x288 0x388>;
 	};
+
+	vibrator_pin: vibrator-pin {
+		pinctrl-single,pins = <0x12c 0>;
+		pinctrl-single,drive-strength = <0x1000 0x1800>;
+		pinctrl-single,bias-pullup = <0x8000 0xc000 0x8000 0xc000>;
+		pinctrl-single,bias-pulldown = <0xa000 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0 0x388>;
+	};
 };
 
 &uart0 {
@@ -409,3 +428,7 @@ &sdh0 {
 	bus-width = <4>;
 	wp-inverted;
 };
+
+&pwm3 {
+	status = "okay";
+};

-- 
2.51.0


