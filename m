Return-Path: <linux-kernel+bounces-846506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 641A6BC831F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 11:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 542394F7730
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA82DF153;
	Thu,  9 Oct 2025 09:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="cAie7e4U"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C532D94A6
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000814; cv=none; b=NWaf+aH6VfwoVWUKP9VbkKWLrynnjOJ84efxd3lzfMYUTyijqyjbi0kJsWHDHMYqix1Cai6yIR0Qvtg463iTpFYOObDg6qGBLnuv0wvlw05+0jw2Bwp+89eYd2+AbYsqXNAlr0A1vKZR1WdSH88a99/mS5WQupj8zPSKjVirYIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000814; c=relaxed/simple;
	bh=6c+LDrNFsl3Mf/zVKIj375u+Xy0wPf0+vzPBVIwWGeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y7dK++K+o+Ub3qXx1WXvew9JkR2hvZpmB4FMtYe7Bn94v9ysECLUXyCCUBcdAhL3tOzzXVK/E7iJRBFpi2zzD0sgSdkyrkYsY53ETcSaQEggIfzUhMKKOcnd69zGoU1mkP52b8jXSjsTa44bcZQdngORjC6EQpzIJ584oeF9ykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=cAie7e4U; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62f24b7be4fso1227494a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1760000810; x=1760605610; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ekJw9Dpe4LT8cbettXRBucWkmba5D2JfYHQVJm3ydg=;
        b=cAie7e4UuiAbHPLhkLohgg6i1tOMLJIjPqHSrp1ROKvr8ADW+Ylpr8kiaIzuGnpk5/
         0uTuGEbCpelqA6/Kh+lELV6Mg4VRfHp31sIHYLtKyBbaXjvMQq8kQw/tdCwRkn+C0dTx
         ntSVi9kImsQLMv1nzup2xWIVQ9o99XI1HU6nW3hjnocLkl2uHK8ZiHuLjjGgry3YWxhb
         y8MKP7VIblGwTPx99Vt2MIV3ug8sVbax9vMfzLrpFnGqNue/DoCS/y2uCFzj42C+/fHD
         X0/DqSbK4svp8l3gCIvxu3knmQ8l36NSol2NhHp218o2kT7594mCo+GJPhuqC1VEYQaG
         0diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760000810; x=1760605610;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ekJw9Dpe4LT8cbettXRBucWkmba5D2JfYHQVJm3ydg=;
        b=J1rXWI/nKn5UMQD1BAvd1vjDHlOmiMzEj4naZ72YuhQ4JNQhBFZ+m1u37oVTsfBZ9E
         Eb1KLzaIQg5l8PxHiQZWj5OgwgRyEvS8PT2fposSh6f2um2NVbQ0bB3KBFUorNw5efYR
         sOTzAVL+0o62sRRsCakza+nnK5BfsOWoUtSz8axrdF5fIuLBAoK0KpJLjrVAvhv2/rTU
         NuM3DqsaHZFqL6MDwSzARqDphhi5ZSFGqek9PYzAuJ375qv8QPLwiXMYMNZ4v2sKorT7
         S78wPfDx4jxnqfZoMpjraX5Q1Brn9N4mnz2qoHrVGjSsZnpRez7+s1flTwegd5+DwpCg
         xw6A==
X-Forwarded-Encrypted: i=1; AJvYcCUbWIMAHiwLg848Ac1Qi7UwZGnAVvX+EPbilKj1fr53iCmawF7s883Kf8q302P82BoNnSZoHzujuNyqu5U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww1n0l6bvYuJB7AEoqnMTehzGu+KuKuBel17RgLgt0rikud2ZB
	SqDLlv7OlyI/62a88jrFieM1KIMsGfLT5g6YD1qYBAoAuHyIjx3mUQmdzn61yMCnFRY=
X-Gm-Gg: ASbGncuJVwN8CvwXtILBlk+iePHp0Gztr/tBo645fmXpeungSi0l88z5JVv8TbN9ZRj
	tW5CWWEO7ZACFknuinbv8YNKwmR+vngSYRV4BvHPUnt/WX63fszrvrR2MKMxOToA2BcGQu0FbZJ
	oheBSRSMgah+bKzgzSjcoUgMMCPv9cJV79jK/cdA2jbk66b6J/PxBcCLGs5r+/4j+FdfAFtDdXL
	i3qk8j+EbvQrk+gZHUxBkFEFx7a8cdaMhghc2c3MeJtOtAzyrQhQdso5YCKOzqil/So6zfmJafh
	vUyyv/RJ4G5dDmkncyyIN8O69spq/tIyWyEiaN/YmhdLWVmpdVIhwYhj1f6Ks3c1nc6OfjohD+j
	zAV8gdDkm3Zt/eifU0FbviBr2dQ/cPHVsw6hndr3C8a+TX3h2vpLsp5zmYKDuH5vRttQRik7WL8
	9j1WFmf9a5pWfJst97Mfp3Abebr8S7
X-Google-Smtp-Source: AGHT+IGVnju8p0EtiVRVfPYKo2DKq9aqai7ZQykeesawT2arQe+oRNmMFYDi5jeeocRAxFAQMHEcgg==
X-Received: by 2002:a05:6402:210d:b0:639:e712:cd69 with SMTP id 4fb4d7f45d1cf-639e712dbf2mr4128487a12.18.1760000809554;
        Thu, 09 Oct 2025 02:06:49 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f4109046sm1905755a12.44.2025.10.09.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 02:06:49 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 09 Oct 2025 11:06:35 +0200
Subject: [PATCH v2 5/6] arm64: dts: qcom: qcm6490-shift-otter: Enable RGB
 LED
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-otter-further-bringup-v2-5-5bb2f4a02cea@fairphone.com>
References: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
In-Reply-To: <20251009-otter-further-bringup-v2-0-5bb2f4a02cea@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Alexander Martinz <amartinz@shiftphones.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Luca Weiss <luca@lucaweiss.eu>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760000803; l=1117;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=yyPwwquHQ/hor9rKpE+9NwLbamAj8RJZBJZ1Khr3/vc=;
 b=z6PdzX5mDNnT5WJj/LvOPGdVhBBtxqgjFNbSFc4dXE8k8eCqz/pKrxJLlPzBNCJXkFHDd4cxx
 tepyVBNdHN+BrD03oBFeKB3I2JWXKuv5ol87WIOaChcKJkalYXqz06O
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

From: Luca Weiss <luca@lucaweiss.eu>

Enable the RGB LED connected to the PM7350C (PM8350C).

Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts | 27 ++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
index ac6ed79e57b1..af6f7b41201d 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts
@@ -618,6 +618,33 @@ led-0 {
 	};
 };
 
+&pm8350c_pwm {
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
 &pmk8350_adc_tm {
 	status = "okay";
 

-- 
2.51.0


