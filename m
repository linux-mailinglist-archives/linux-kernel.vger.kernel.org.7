Return-Path: <linux-kernel+bounces-851796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C97BD749C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C6C3E82BA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D492B30BBB5;
	Tue, 14 Oct 2025 04:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8zd6X4w"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A2930BF65
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760416955; cv=none; b=GTwXWiM3PPGWNgZNTBScyxG3UiuJo67UCYH2AdZNQ7KBezCJtyTCH4cssKCI4MP0rnQQmXPaMExWoyw1k9id/X8ifZzqAG6egFjC2shhc9OQv/oxBRqsDD5OECK+qU2jmX0yGosUOEn2tm8GQrxBWbNoNh7l/Ke6Y98BBns5B4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760416955; c=relaxed/simple;
	bh=ZOeZWKOOWKCm2A4DyWN9TLg3TCjbyuF4ehcHyG+iQKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QbLFLzg4zjEy4eWt6gg19jJMm8nifnMwiPd/SES3j3rUn860tvmAnAtsSBxD74yHKw1O7fcXamoq5Jp0ACoP9G8w8+izSG+wIlPmdPV7iD4V72hBBYvI4et4w5oTDMjd4ZGgdnI+qWgUkIjTRm4yryWI4fe7AceZHf5/1UzhBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8zd6X4w; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78f3bfe3f69so4378759b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 21:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760416952; x=1761021752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qr0OOb/YSzzcrccKjN+O1ce21xTtHsXacPPXsNxVeZg=;
        b=C8zd6X4wfAgULf28ZjaEStgY0ocgWj8EIzAfV+AoGsguCrrRxdVGItVUqJJp9gR6Q8
         b2uqsAmhhTScsKdoBX11fQVjV0y+wPHG0aT2xgArT5Pcn5ShtG6pGz3bOS2rkIYb//eg
         9ltIwGsd715rqIGtNPDZVmBqVovn23Xdu5NBMVkkcUKnTL4HC6HR97Yz+f4xEsdTqzrT
         6xHanuNuqAPpbIYezIPEPq1k+mhs+rwBdb2Hpv7UWxE4g5nnPYPzWhS5iPcOhyXnAbz+
         CTVvIjztTy8bRom+9xvaDfUhDStR6EyXyJwQALhvdKhRKtq/lFNCcLK28xQAblV72d3P
         I17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760416952; x=1761021752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qr0OOb/YSzzcrccKjN+O1ce21xTtHsXacPPXsNxVeZg=;
        b=QkrmlBRBudA9E2pfDKIlxcbE7fODEAMUP1UnbwLoaGQenoktmymKK3JMn5bjZeTKRq
         +7ZzFXuAznaXVKvR6A7+Ns1n1TL2p2nxOEjUhOJH5g2aMxxtPSlAnTdc3lfJ+0p6RNZQ
         1NRPpbA4ohGx1sA3YXFP6GGlFdhHQ2T2hkdCTdQzyxFDhYTqo02QHj7IIM6Ad6Jrj/vI
         VDkOFwn/knsRJ66WNxdmIz9uX/D+hhA4ujLlTLL+QJ55bctv1SRguuCtbVrbPVScBZ1R
         T72+pqOFDRjd2QpFc9GJXjmsOmZHQOsaN6Bq5LqKmJHbO6VSYP+5I/D3F4TS6XANynTq
         oD7w==
X-Forwarded-Encrypted: i=1; AJvYcCV3EI8Z2BHYBskdaMQGO62CAhJxn7BNiIFIwQ0029Bb5W4j4Ahvb+805CQ95jEHm2nx5xgnYHXFBj91Euo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuhcmQu3FUgWUJiPv2uOsrZIthqYDIn5Be6T+123vKHLMThlEE
	rEAo2f+FEeRQGfWKiqCXzXhbj4hePz7B/lVNwCI7Nm2O2jCNAuOTYMpC
X-Gm-Gg: ASbGncuFivZVSuqkeGNj16Lw5hTm57ozEPQiek170IH36/wKNmpvLTSZk9sxBm43qXe
	eIh2kZsk/djCKaDCuxZ356wj3mNEUUkS0qjDo5qpxbPzRx5JtVQ633k1OBiRjg+UIsr1PjgCKhH
	dQZKT4G8zhWqhJBzHY8NQNpdvXnud2pMTxVOSJ4S2QbMs1y1Zef6XzPhCzTugOLRD904Gs7AZW9
	hd3pPcoqCIruMFXM1dNaAvTkhtnlArDGhSTS3dSglXkPVpasmFzV8P6ldLkTeBfm6FLX4Qr2QwP
	bTAc2FafGYggl3oQfxKvNs3gh1b8tn4PQC9co2j0VeK43L2yxB8PTw3SfjV7rzUYVyTwrCWyQ//
	Genosd6QfpWIOnBVEWWV68Zi573Xvd/GBeiG3
X-Google-Smtp-Source: AGHT+IEiczPDzcVKQsKr3sSM/MLNqusV/eS1JcWGMdi/R/+jLgzmhexRA+IU3VJwnNlXXtdTmYg0Mg==
X-Received: by 2002:a05:6a00:3cc5:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-793881ed81bmr30446227b3a.32.1760416952199;
        Mon, 13 Oct 2025 21:42:32 -0700 (PDT)
Received: from archlinux ([177.9.216.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-79b65528a51sm8440684b3a.85.2025.10.13.21.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 21:42:31 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: dts: qcom: r0q: add gpio keys
Date: Tue, 14 Oct 2025 00:41:31 -0400
Message-ID: <20251014044135.177210-3-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014044135.177210-1-ghatto404@gmail.com>
References: <20251014044135.177210-1-ghatto404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add GPIO keys support to Samsung Galaxy S22 (r0q).

Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
 .../boot/dts/qcom/sm8450-samsung-r0q.dts      | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
index a17dcb848fc1..5ca45b040a99 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-samsung-r0q.dts
@@ -2,11 +2,13 @@
 
 /dts-v1/;
 
+#include <dt-bindings/input/linux-event-codes.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 
 #include "sm8450.dtsi"
 #include "pm8350.dtsi"
 #include "pm8350c.dtsi"
+#include "pmk8350.dtsi"
 
 / {
 	model = "Samsung Galaxy S22 5G";
@@ -28,6 +30,21 @@ framebuffer: framebuffer@b8000000 {
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		pinctrl-0 = <&vol_up_n>;
+		pinctrl-names = "default";
+
+		key-vol-up {
+			label = "Volume Up";
+			linux,code = <KEY_VOLUMEUP>;
+			gpios = <&pm8350_gpios 6 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+		};
+	};
+
 	reserved-memory {
 		/*
 		 * The bootloader will only keep display hardware enabled
@@ -124,6 +141,25 @@ vreg_l1c_1p8: ldo1 {
 	};
 };
 
+&pm8350_gpios {
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		power-source = <1>;
+		input-enable;
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+
+	status = "okay";
+};
+
 &tlmm {
 	gpio-reserved-ranges = <36 4>; /* SPI (Unused) */
 };
-- 
2.51.0


