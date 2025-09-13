Return-Path: <linux-kernel+bounces-815352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B273B5632A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C259A07C6B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCF32857F9;
	Sat, 13 Sep 2025 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Drz5Xxv/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434B62848B7
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798495; cv=none; b=d6MmxW94Z2JeIPf5cFTMG1g04vQYHcnQUyb67+XhZNtHIS6JXVShG4EfmEfxCGJ8WRyqvNuKo/CoRGFeBbLthzzr/gSa5e87jlIb1UIkggym3+MDbVRHBswWWer1Cd/sNXxidhqh84sWs/IkRSkjaloW6vpJyYYnfpwNhoGJHYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798495; c=relaxed/simple;
	bh=xJIw1bAGNCKENGyl7Smzyc8MsigWND1otejzP0Dgs0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=liFfz9A0c+k/lNP3bABKPtdi861DXHtU/fr5CtTzpS9rfgbZxYYyizr3nZv+PBmd7+ldSH3+SAUQ3i15mfyVyXIMJU7xJU5mk6Xp5FdHb/Oq75qkfSGC6ST5ryIW7x1oeOggIklJZf7PqweBzdUGEUsOsmpJJtA8CGhF0LU0jAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Drz5Xxv/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so356445f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798493; x=1758403293; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3eQWTLa8qf+9saHeA5hbj7RQD5lII0deY9ii6lAlos=;
        b=Drz5Xxv/BnnMv3jLlTbBuSXPKfOokiDmndSmHCSTk8jIFRUD++SuYGrhzB7gwZ0AJ8
         s0g9uY8kHpoM6xTsR6K5etO/bueVFHMExpXkU4fuFCEcKlz9Uqi6aDP7JjotO+oBxn/a
         u/tb+b2a8I+z+COf8iKqlHjpo2vwe2Pt1e45WFtLR2WCpu7elYF+ZXlw+OXL/n30Dzkl
         4rNm1mDx1piXImQpVDqKfsFmoKsgDd1imIYnrdryUAG6+443U/WckibvYwqzCoPL5Wqd
         VM9NdQpGAlbxeyANVCboLvq2y1NPespdttxkJTvvvBygWCWolAROSIcd9L18TCnb/YWV
         aNCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798493; x=1758403293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3eQWTLa8qf+9saHeA5hbj7RQD5lII0deY9ii6lAlos=;
        b=Ko1MCOzObiKgmW3LbcFx/wp6L1amNHxBdkvNbmSGQkP89JouIhK7/8MNGcwNUQinBo
         wpDGcEGw5/VlyfhtmCSoJkdZMFKE1Ti6jkQd7JsPOxrW7WyvlzTLpmYtFTVv1KZX/3xx
         Q+xKZegIYbRJewDLlDuU6nZTQNyvw3PXOYog4+BDTydN0uRPle0rVyhHymfd+TGRqCPx
         IWYBoBuEv+c+y3jyOGRMf3dlbJoJs9cSNkf3xd+xwbZJ7g24ELGmlB80dHlu7SEE4edX
         H7RQN7QHHbhxTuw1ApXn1GTE1Fe+vXIjkRHPJ+0BKrSGc0A3qtBf/fxbW0TAFzgJfmK/
         1cwg==
X-Forwarded-Encrypted: i=1; AJvYcCW/9mWOhINFQOL43kmez+scBfdfISPrfXE3T7AlpaF/blbWnm3LrKNfNLfk1Goos0AOQ4DuypDUrgJuB5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Pi3aZ1ciCZ+DRnnSKJ+TU4AcgvDqxvqj4/iQQcYJwSC1QtZW
	LblU6d0zE8+71TlGdWRk7fpQQnIbxo9ohAzxyucKfwHiWCKryhEkquPA
X-Gm-Gg: ASbGncuru1rSAY0Sl+zoFLr1zVE5V1a+YDH+raoC3Xe5Z+s8rQoUaljpP+qitfgsKjp
	O7NjTxdIKzTy8nPXCQ3ZEyk9Ah9HtaOmUdDL6aPKgba3gDov7mtfHjfN40BYahB08vaseQibNF/
	4pajoiPWUQ4k4944ckw4gknT5M5sAyZE/A/iuWLzvaDV9DTfZ3OhbQeS/HMFm7e1CUUQo080XN0
	8Yde4T5RIAppmpA4dwLNJupEk10vfC/WUoTnqeWEZY821RXAsSw+z1lypH+PWp4M+AVNW8xRnVo
	y+uMsyLNt3BDNmth5tExXn1NAzp/VGMQi2YyfwuQL/fc6tFkXdBayD74ugo/6XTrwvjYp8MGqEK
	UWSWTKmbjRTjUGO4FWuat1F03Xfkp38/nspe6KGZWSa0d6g3XZMkV
X-Google-Smtp-Source: AGHT+IHr8CiMYGUEeTiKYHRRsxQhLO6JbPn2EeOKGS5jqS2eJuGZcBJj8fDG+9B8XtOlMfD63jhKQA==
X-Received: by 2002:a05:6000:250f:b0:3da:936b:95cf with SMTP id ffacd0b85a97d-3e7657a93b4mr7806706f8f.28.1757798492558;
        Sat, 13 Sep 2025 14:21:32 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:31 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:06 +0200
Subject: [PATCH RESEND 4/9] arm64: dts: marvell: pxa1908: Add PWMs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-4-8120cdc969b8@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1513;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=6njTuJu0UcIU1bHrsjDWk5PZ/WvBeIzNhePT57xOd78=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/j/9Wlu0tA/HS04WXhf9ekl35iYE3dVPO9++9LNc
 NlCRpaKjlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjIgxOMDEs7c44qKm/1nBH6
 4K9KyWyzKecW3JK8+My2/cC297a8Z18x/BXezh6Wsd3N7UmozX/JKU4zAhUM+Qoyj+vnp7ZzeUs
 sZAAA
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The SoC has 4 onboard PWMs. Add a node for each of them.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
index cf2b9109688ce560eec8a1397251ead68d78a239..61498fd75d1dcaf0d068943c1ac14d3e5a7ca9ae 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908.dtsi
@@ -195,6 +195,38 @@ gpio@100 {
 				};
 			};
 
+			pwm0: pwm@1a000 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1a000 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM0>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
+			pwm1: pwm@1a400 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1a400 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM1>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
+			pwm2: pwm@1a800 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1a800 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM2>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
+			pwm3: pwm@1ac00 {
+				compatible = "marvell,pxa250-pwm";
+				reg = <0x1ac00 0x10>;
+				clocks = <&apbc PXA1908_CLK_PWM3>;
+				#pwm-cells = <1>;
+				status = "disabled";
+			};
+
 			pmx: pinmux@1e000 {
 				compatible = "marvell,pxa1908-padconf", "pinconf-single";
 				reg = <0x1e000 0x330>;

-- 
2.51.0


