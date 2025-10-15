Return-Path: <linux-kernel+bounces-854690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654ABDF1E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A70D6356EEB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD32BF000;
	Wed, 15 Oct 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXfcbIxn"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074552D59E8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539180; cv=none; b=RqoGAq77ew0af5k9JGXxK6z6Zt5MELHvQ813RtFZTiUu0ArQJuNYP/ynCkmV0iYZwfGcKzFGzwRnVoXlQ9X6ctSo5BzfZveDQs5pctDcqrXURdPq4opz+vbbmeyJ7vDi/MOYdow4N2o0LpZ1izlRKQ6X32hWtTDQAXi0uLIZqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539180; c=relaxed/simple;
	bh=1Ae7pCJMeSen81U43oVm0cV86n05nI/vbEvamy+QB7A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni+sTlcF3VsB84MTYTbOauQjG4DzFIRDs+Jh7udQBx9gyoP8NT6qiBCdutS6MTTTx6pE/T1wuOIPjUqleUFmJb83grg7AREqvwQ3AT+UrJqAHBKZIOgFBRpKaLq+W17pjh8NhSmBgam+Zncog4Pp7/ERH4JDhMsQo95t8dEVMOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXfcbIxn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-271d1305ad7so104526685ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539178; x=1761143978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThMWJU9Zn2zc8Ri8nC2rLeAQ6V0FQ+wbPN7aWmFwPkY=;
        b=GXfcbIxnBH8x3Ta5T8jsLEFGZt2UfozF7LzeXxnJ/P3brUugPMkcfzBEgDRO9dTyer
         xVN9mQlWlblTUTvS46tOZ2FpVXgd0KQl4dK99PUJlKasZCNTLulmJcsnxUmOvvak+18M
         wiO3vGwvLSV2J7UvXWeoi3JIXVmr8JSITvMA3BM3gEZp8uJywt06qCohxDaiI3RgaPXh
         a7U6dWOyTDS6OaKujJDXzabnAnJ4YjqCH2umw81W6Z4gkZODiAV+hFu/aRD9vWg081/5
         lsFiIft1NKwbuNitcEctOu8UUbQ8tqFvQ7/hDYMVGloaWwUPRLmNht5EThp88gTRy1VH
         AxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539178; x=1761143978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThMWJU9Zn2zc8Ri8nC2rLeAQ6V0FQ+wbPN7aWmFwPkY=;
        b=GN0L/XEbovthFb6icAhytsGVB8EggMspHDtwTD+ZlMzslATM6y5YQf8ytcnzKMGibn
         2rkG5vtE78s2HnuqzP9fdHxll51UQfJWFU6GcuxfQOqlyCufcJh9cZWirhyLINGXTzZk
         jIOmkCrdT8qKgljbNWJL2Bjka7N9mzvI+d0ebGsdpBL8cXdGRzQfZ+XW9uSRc1igUDgn
         kGnVwERAZ45hYrInhAvqs7pFXLhPlP2aChlcgYYhB0izhGYMjTkYQ4CXFOkbLw/XRqsc
         1hUbdQ3RkXaN21LT6J+rotrsOD0gW9om5TCeBmrypCJHZXla0UGI30BPvz3Ir+eJUv/Y
         +MuA==
X-Forwarded-Encrypted: i=1; AJvYcCVpUfOWy2MHn7NvLCUROcbINSN9ZtPax+z14LjfviuVHzBDCIBNUaWKCSQwWjUfnEsCZvpQhGAi4UqxWTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YybSTNepoLqDZ76eK9M8PHj2Qao1A5b/sZdP9xUiCyyhxUPBqeJ
	4txIzFx7x6/ijLj1kZXjJANihbTnzMAoCSb9oBvCkVpfKxIN+VxC+8oJ
X-Gm-Gg: ASbGncun9wJwU93eINJ8UfwJ8Nenp3apTCuEEX5iKpmGKZBkzHSnXLK3E+chyp2gKz/
	IxHtQRVYr9fbXcLz4i2UtkeXQio19Eh0ygG9RiHLg1iRMT3R6qwBUOwzbX78hkhg/ZIrqw6uUtZ
	Ce7YmhOwaF6EStWjItF+tlwsKBW5eMgxGXoRbhh/p+6Mo+0hKy0v9aQRFQxThf8be8/9cQQx6RL
	aTaIPANuNBWP5Gl94uJJ9GyKomp3PAP+28F/1KAMcIBTDGbxsnE9eDWfeeAMKHOEjbuWoR6Z/2v
	yVdY39RHaj1U42PmgaTkgPoRnWy+TuHO7YxNp9zBbESRXGCCBWeAyzWe7ZWnoih+Wq8wxKLwJdw
	V6D1ZmMCg7WLjyq0wJ2lmjBowji6bzhPKk2seF+pDgJJrijtOyrTzWSMT6mPwG+GAsU+VRam3NS
	BOSlfHI3mToPCxd8GoXfG/HxUgDDxN1edDFHLc2qyC
X-Google-Smtp-Source: AGHT+IHXFYBxv1duy+NgjILQXBh6DIAOFdCHnmkFRStqTE9SSRyR15DtFXzEoOln24REjJhH1gcaGg==
X-Received: by 2002:a17:902:ecc9:b0:25b:a5fc:8664 with SMTP id d9443c01a7336-290273fff0dmr361423205ad.51.1760539178118;
        Wed, 15 Oct 2025 07:39:38 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:37 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] ARM: dts: aspeed: santabarbara: Add gpio line name
Date: Wed, 15 Oct 2025 22:39:01 +0800
Message-ID: <20251015143916.1850450-6-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add GPIO line name for userspace control or monitoring
- Add leak-related line names to report chassis leak event
- Add debug-card-mux to control debug card access
- Add FM_MAIN_PWREN_RMC_EN_ISO_R to receive RMC power control signal

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts       | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index c0334abf9cda..3f36c8e03f48 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -208,7 +208,7 @@ &gpio0 {
 			"led-postcode-2","led-postcode-3",
 			"led-postcode-4","led-postcode-5",
 			"led-postcode-6","led-postcode-7",
-	/*O0-O7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","debug-card-mux",
 	/*P0-P7*/	"power-button","","reset-button","",
 			"led-power","","","",
 	/*Q0-Q7*/	"","","","","","","","",
@@ -1744,7 +1744,9 @@ &sgpiom0 {
 	"FM_IOEXP_U541_INT_N","",
 	/*H4-H7 line 120-127*/
 	"FM_IOEXP_PDB2_U1003_INT_N","",
-	"","","","","","",
+	"","",
+	"","",
+	"FM_MAIN_PWREN_RMC_EN_ISO_R","",
 	/*I0-I3 line 128-135*/
 	"","","","",
 	"PDB_IRQ_PMBUS_ALERT_ISO_R_N","",
@@ -1804,11 +1806,17 @@ &sgpiom0 {
 	"PRSNT_LEAK_CABLE_1_R_N","",
 	"PRSNT_LEAK_CABLE_2_R_N","",
 	"PRSNT_HDT_N","",
-	"","",
+	"LEAK_SWB_COLDPLATE","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"LEAK_R3_COLDPLATE","",
+	"LEAK_R2_COLDPLATE","",
+	"LEAK_R1_COLDPLATE","",
+	"LEAK_R0_COLDPLATE","",
 	/*P4-P7 line 248-255*/
-	"","","","","","","","";
+	"LEAK_MB_COLDPLATE","",
+	"LEAK_PDB1_RIGHT_MANIFOLD","",
+	"LEAK_PDB1_LEFT_MANIFOLD","",
+	"LEAK_MB_MANIFOLD","";
 	status = "okay";
 };
 
-- 
2.49.0


