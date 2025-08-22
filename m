Return-Path: <linux-kernel+bounces-781185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0CBB30EA4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 642FDB60FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF83E2E424A;
	Fri, 22 Aug 2025 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR7mDKA2"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1852E2EF5;
	Fri, 22 Aug 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843307; cv=none; b=dHpxkRVpCJyMMSAEzqxPJpZ/K1NE7TWcPmgu6OHqZF9MwkSPj89jiZJsShUwBqM6P6HspMX8Pa7oGy48apyLdvih05D0HxQvpJa51PGV/3I5jUpkR2aeXNO5zQtIYOylYavKtAF4D4rQ3fZvGEEKZ+Fy8hRUt7emwxYgQgA/7Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843307; c=relaxed/simple;
	bh=26zbFI6hb3mIw5E6fR+zJorauuLVdmbMe2rz4rsCbfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmpXOSG1QBRKOZh2ZCht8JpMLGAx0r6TjXMEvJ5dx22KPzGVAqo8uAlwq1UAPLTfjs+p53OMVmlKCvqc7FqIpcObfS+h/nLh07INh+qr2j6lUtZXHnZBDw48DumQ9HA6I6ogeWmJz+QB3+yXzT4UPEAavJ5uYbIYJjgsuHphnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LR7mDKA2; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4717330f9eso1247451a12.1;
        Thu, 21 Aug 2025 23:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755843304; x=1756448104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=LR7mDKA2wavEoiIHgxsk+ERkJPQPyOMizjkSDHHwT3duNrtbXbfTrUmfS4c7el5gES
         C/L4xjjB1o0wQPlQsBkXMi5lz/r2LDAx5bbrzqUg2qdahGQ1Vg6cuUGSV/iOhoYlwE4v
         DrMENF3dqmNI9rwcBKhqmPTTW/j7LazZoyGk57iO7P+mS9eblz9R/+i4ZOjGQaxAuzZI
         Pz0yA/ndpZ0LZxo8k1N24AI52gzLSOnlyVPQFCkmc+QeSX653+sPCGt/bWCoF1NP4QO8
         FSu6Ixl0439OoEz3AGvgHvGm5fQsCNKGj+4aKBq5gYbYD5K4prvdwg597NFfrNh0AkHe
         3kGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843304; x=1756448104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=Nf62G3MwPKA5QdUnS6xRD5GIY1cJYQm65u6HGL6hJLQdhmhMleI7H/hgODEG+re/6J
         sNTlwfrB6ury2lUhG81cFcnA4S+GA8RH96xdM/WyZodhUIGZaaTafJsq8s8uDp9eSnrJ
         ye2DASiEBjObgS919ngz296UkEYAdOIBaLqbr8F+Ut1ZZ+tS8yoT+NQJt17nqkL/Q3dG
         jeFUn5i+C+Yd8C0UfeGNafy1J+43tst1DYQz6evN29RwGoFYFaTZJeMqiEoBELyLtlg5
         uNTQE6QBJD1md8Ahh/EsbzixriCym5gvveVleilCKtctn7yeZ4KjvhT4U7EOZgpXsb9E
         d2xw==
X-Forwarded-Encrypted: i=1; AJvYcCUOiHFaAmuG/lHNAgxsy4G6YL1QfBF4H84rnCcDZ15TtEFHyXCuMJMoWYjfaWsKdNaPTqxc84obhKIpImb3@vger.kernel.org, AJvYcCUP1xL0GiUpU3bfjcrd1rwUMUuN23ge2KOUb08Y2lu8jycevh4g/E+RHRTDCGiJ3VEq3TfgdEXqaX70@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34tlltsX/GuCLZX0AYHbXuLF5UykDd4yPDk26vOwSEi+1FO1Z
	/hkc22pybnWUpQ8D3AcQR1AtbE1lGNfHk5q18MGXxJj5Ug9b+8va5ncc
X-Gm-Gg: ASbGncvZto0ipYttwAQGGaq+utDJoLfZ9ABCR7zppPpdktFgnYuK0n7cogZcmf9HEDU
	94e4zfyD8p1TdlvErjiHRtFhrhg1P8vDwsRdqWqhmg0Zk3RrlLe0rGVatg0A8RofxTpDCGMYsmZ
	bx91bLx76EohZoXrZLb039DTUu66WfnLlKK0fGSHENbqHhujFGTQcGy9Q90wT/NkHNrR0/UJmju
	MkhRnKKYS/LPefJMsAh4q+dtggnpk2SjIw4+FneyS7pVNN4RvFn6Ls69mMcZ4aRiGBFmTWryV6P
	s9v9jLBGPmDAHbKZA2CT9GoJR12yWNEd1o5akpM8jDWAmv7b+Ej80DaLj5ZQYFJuBGnOIydfLhi
	24XhaR90DRh1A2YebaYi4XqITB7SmjoJtvRzNMzFoY1NbyK86oK9HX3o6oIZpdd53BoEeFlFWyV
	GgXH31jgyGr1PilE+D6V8Q+WO223/V
X-Google-Smtp-Source: AGHT+IEX8roGyBHGJ/i9ej1bGUzipkk+L88noriLAZ1+JU3Yv/i6WVdaBF5O/2TerwAvPB7SMxG8mg==
X-Received: by 2002:a17:903:2ac8:b0:234:986c:66bf with SMTP id d9443c01a7336-2462edd7d39mr20587355ad.11.1755843304375;
        Thu, 21 Aug 2025 23:15:04 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35d-8041-a0f2-62d1-f7aa-e5b7.emome-ip6.hinet.net. [2001:b400:e35d:8041:a0f2:62d1:f7aa:e5b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246181c48c1sm28660385ad.116.2025.08.21.23.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:15:04 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: aspeed: harma: revise gpio name
Date: Fri, 22 Aug 2025 14:14:52 +0800
Message-ID: <20250822061454.2610386-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
References: <20250822061454.2610386-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update GPIO label definitions in the device tree to reflect the correct
power and control signal names. This includes:

- Rename "fcb0-activate" to "fcb1-activate" and "fcb2-activate"
- Add labels for:
  - power-p3v3-standby
  - power-p1v8-good
  - power-pvdd33-s5
  - power-pvdd18-s5
  - power-asic-good
  - power-12v-memory-good

- Replace unnamed GPIOs with appropriate labels such as:
  - irq-pvddcore0-ocp-alert
  - irq-pvddcore1-ocp-alert

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 741d2d9b6d03..81278a7702de 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -234,7 +234,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb1-activate",
+		"","fcb2-activate",
 		"","";
 	};
 };
@@ -308,7 +308,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb0-activate",
+		"","fcb1-activate",
 		"","";
 	};
 };
@@ -698,14 +698,14 @@ &sgpiom0 {
 	"","",
 	/*A4-A7 line 8-15*/
 	"","power-config-asic-module-enable",
-	"","power-config-asic-power-good",
-	"","power-config-pdb-power-good",
+	"power-p3v3-standby","power-config-asic-power-good",
+	"power-p1v8-good","power-config-pdb-power-good",
 	"presence-cpu","smi-control-n",
 	/*B0-B3 line 16-23*/
 	"","nmi-control-n",
-	"","nmi-control-sync-flood-n",
-	"","",
+	"power-pvdd33-s5","nmi-control-sync-flood-n",
 	"","",
+	"power-pvdd18-s5","",
 	/*B4-B7 line 24-31*/
 	"","FM_CPU_SP5R1",
 	"reset-cause-rsmrst","FM_CPU_SP5R2",
@@ -749,7 +749,7 @@ &sgpiom0 {
 	/*F4-F7 line 88-95*/
 	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
 	"presence-asic-modules-1","bios-debug-msg-disable",
-	"","uart-control-buffer-select",
+	"power-asic-good","uart-control-buffer-select",
 	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
@@ -801,7 +801,7 @@ &sgpiom0 {
 	"asic0-card-type-detection2-n","",
 	"uart-switch-lsb","",
 	"uart-switch-msb","",
-	"","",
+	"power-12v-memory-good","",
 	/*M4-M7 line 200-207*/
 	"","","","","","","","",
 	/*N0-N3 line 208-215*/
@@ -809,7 +809,10 @@ &sgpiom0 {
 	/*N4-N7 line 216-223*/
 	"","","","","","","","",
 	/*O0-O3 line 224-231*/
-	"","","","","","","","",
+	"","",
+	"irq-pvddcore0-ocp-alert","",
+	"irq-pvddcore1-ocp-alert","",
+	"","",
 	/*O4-O7 line 232-239*/
 	"","","","","","","","",
 	/*P0-P3 line 240-247*/
-- 
2.43.0


