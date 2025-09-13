Return-Path: <linux-kernel+bounces-815349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC854B56323
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0076B1B20631
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF0628314E;
	Sat, 13 Sep 2025 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7mZP4sR"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F929280312
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798488; cv=none; b=CoXk+Vt0FtJl3609ZR3pk+GHTYSE97mzBjM4RIADvJfSGX22objSadWGtadcUte30TJCZYdZfTJRYCSh3Z+t0Dk7PGESeSnYu1G7t3v9adsHmuNyf/1ykVJ+ucyhEGaCUNrBCOxs4SaTURmVlTUuIPKdt2qXoztM0C/WnYmMwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798488; c=relaxed/simple;
	bh=oaJUaCOYqaH1L8LbASqlVhMT0XivPLTV80hCIDJAMDY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3/hcXC38DEpAfBZhCVKpIwh0gGnEyMgCq93fbKB5kdg4GuJsGLFoOviTzSpUsnXCxo7RPI3uoRzDYZhXP5XzalQuO2drCGZpNZui9dp9Ke/2IXj2t8WO4WaOe/5c9EgJ/AGt5dhK2560xmDEZx2AR0i8SKI4nB5MpVgjOTreV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7mZP4sR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e8123c07d7so447340f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798485; x=1758403285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWd2b4T+HmUToKXe+DhMe4fckX1fCVdutnchyiOuReA=;
        b=N7mZP4sRjyoAI4dZJI5PYtRdnvW2yj4yqf+bR3/sglvKusKfggZdoA6If1kNCi1JOd
         dLfu3BR+v9xfoRYy3QDM1ivm1Yr3Ci6CxjnC/SD3RDaopXjg+7/16I1rYDw2/+25lLUm
         anmffZXMBuiHf17B551yB6j+8XXVAd9sKeZi6nFApGNOKGyRkJY8d9Z1tANTKwbESSXt
         jG7EP/1QWiUwOvSq/vU4KJyrhdArJ7R1dX8sBPmPddgY9qrFKIOWEVnljmemLGxeF0WD
         puF7TNgAwSZV/DMSJQK1T40BD/NEmQNrALODOOHEVR2yqKkGO33+R4bv1I2HHV5qFdDy
         vU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798485; x=1758403285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWd2b4T+HmUToKXe+DhMe4fckX1fCVdutnchyiOuReA=;
        b=hxZKJ+2mLoy+0v3+XsnJ5hdrvZO0YuRocair5JqTu7Ft3iyL+TVaJ4uyQ3ORn4qeSb
         9Q6wt3XXwNDKWmPJyhJCA3FzJDmbC8As72RGiXv2V3sN5EH7Q3EyeQw57T3giRb0oFRQ
         z4x2/bKvbjKFz+zQksw6zvJmr2qkpmYQoPJj9c/aMS/eCL2YfJ9VQM2memMnlKcoJ8OZ
         PX53PxWr7TbXonnVvEmaCKvR4G2RH3l6Sa4a5xckLuyfmbtm9iUKJ9wOGr5aQqjoY9Ps
         NFHfJwIs7n4D43BY/e3vShthYYEpWbRIgRnsdblqLlMuFcNWAiTOtqB8bTG5QeQ4wsRb
         M10g==
X-Forwarded-Encrypted: i=1; AJvYcCUohJSh5ONEbWHZuWcZxB2I3CH5+i/i3vxd+ITdiFbEgT1bO37i3NhOIgWYYtI8Rqp7G3FZr1nmyn13z7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5g9ZXQOLQnadTYeRRhaK/9mCZF31D80iyivnCkcZ0ikHgXanA
	77+mBHZ4gBnp5OWdMDE8oXYP94YgQX5SFj3bwpo8oADeS1fqYVsSLLUk
X-Gm-Gg: ASbGncs2AgOrJ3GDtsowQ2Pai9Shb2tvRTagJSx3mOR+UNcgKQrIKiePeD8P1IjGrN9
	IJqlYCvb60fSODNwOtOj+W6RiuPEGqqSfiwZiN4nSmpAEiD3Mu0MU0ml1vq8l7w6R3qtbnQIhke
	Jx0VAOET83hnA+ZJzKb6fKkNHz5YoKS9X0DZuvxGXF4wdDt9GxHmEfhc0uJ6KG2XuE6dnA2pAVL
	PGaQOI3Tlow89DOX+zJ7UjLVBSEasHd9JvP3Qu7R2qAotIDNX0xaUvuAptak+jQTFxyWvbhTVOa
	dqWcrcxOPZwfo/VicBnVFmT6uQt4xRymtOiJ98W6ETPNpwQ/oB51kqRPq/9ktHKsc7ioe6nivGC
	TT5taik5awIFzUbEioPBYl6J4TRbbs86fTGRg7UrfEA==
X-Google-Smtp-Source: AGHT+IEGJzSKpd6zREOPWaWs/h+7A671p7jcXu2As5oGpHICFBcGGlWQqYtS0ly1bNsIo7cSV/bMuA==
X-Received: by 2002:a5d:5f42:0:b0:3e8:6b2b:25e0 with SMTP id ffacd0b85a97d-3e86b2b278bmr2411238f8f.25.1757798485438;
        Sat, 13 Sep 2025 14:21:25 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:24 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:03 +0200
Subject: [PATCH RESEND 1/9] arm64: dts: marvell: samsung,coreprimevelte:
 Add backlight
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-1-8120cdc969b8@dujemihanovic.xyz>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=duje@dujemihanovic.xyz;
 s=20240706; h=from:subject:message-id;
 bh=3n1cVAjfm4iMd5ytnRCe0bLiwYBnKiHaKl8qPthmrxY=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/hXRhoe8Uv9obNo0ed8oRy98/4WF0LNYuP3zt/In
 WfmFnK1o5SFQYyLQVZMkSX3v+M13s8iW7dnLzOAmcPKBDKEgYtTACayai3DX7ni9SVTgjLbf5mH
 etXa+kVFmPX1CnXJdps82B1ZJK7izvA/2tDK/nTfb2vDI2slt2+/LPXgmW4+rxfXapNP3yXbUjV
 5AQ==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

Add a node for the KTD2801 backlight chip found on the board.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 47a4f01a7077bfafe2cc50d0e59c37685ec9c2e9..b9628b1f59f2f749804799e3d9faa48e3036e81a 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -115,6 +115,12 @@ key-voldown {
 			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	backlight {
+		compatible = "kinetic,ktd2801";
+		ctrl-gpios = <&gpio 97 GPIO_ACTIVE_HIGH>;
+		max-brightness = <210>;
+	};
 };
 
 &smmu {

-- 
2.51.0


