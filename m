Return-Path: <linux-kernel+bounces-789464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9C5B395ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D5594E388B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E452D7D35;
	Thu, 28 Aug 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9FmFzi0"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4C22D781E;
	Thu, 28 Aug 2025 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367409; cv=none; b=k7PqoRq1F8XmWikjBhs3WolCzlp4+n8Qs+UYJA5HwEeyyw4gEHjlOD5In1O1HdklYDV1mva1X8NMaCbtz3aH1l7hCU+7MKG+MCl2QVzojsNTRdTa4ePOmKVJ6t5Wdgubu9TKcvHsYTst018YFEJKLwrYKH1CT9xfJAUk3oriJvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367409; c=relaxed/simple;
	bh=26zbFI6hb3mIw5E6fR+zJorauuLVdmbMe2rz4rsCbfc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HASHHjCmPqR2d0CIMFRoSh5S2d39QF2LvCBk2zABcdXA8Cpp3Sk7eESZuQFoLlZ/xBAzjrQLktmzddsRqfb4BLDtlxeRWoQ4DLPREm3s9ldtOaOCL3VbKkeiC4L/nCZkqU8cEIITBwcBF+pUjKRbipXJ4YzYDBq33RbvGXguknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9FmFzi0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3278efed3b0so507603a91.2;
        Thu, 28 Aug 2025 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367407; x=1756972207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=D9FmFzi0QawNnbPOHUXiaqzzHr4d9vEmLDGGSGY5ppSkySRYNDlPIsNyhowPM1cl7P
         QeN0O1kCTvdsJ65m0nBm9dc9S5i3CeTpqe6B8lqKnnywpucSHbDPFZP+NCB1pO4fNrZx
         OgzqWaT+i3isIPkahydVHcEQyKmcNLaGYfPykxbaSYXiz/L/WEFTg3KwYkXkxRAvFkQw
         s41W4unDPgzTwKF5+zBsk/KsSyeplWXkLiO5gl3Zow9BKhuBhxq4PrKEVn7wkM9CcCFp
         z7ZFHexiV3Qtm+iuN+2HvdNAR9Ytno+9JVs0r1h4kIRTHkYn18LBQtpab7Pkk2vUVTNL
         QZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367407; x=1756972207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=c9UORc/mIz0hZknnRQDQjY4JVLacghaugqfRdaz2y2t5fSnCyczuXINYr6nf8lE7k2
         1vcYxKxB3tvOug0mH9VLA8VEzPhXGwJtXUBUnQ9IBpyDKoTYKUj7TbfQQ5PUIIve6N5L
         MjWqO4C3ZIZGJs+UfLVIu2lQ/hJg3NBJMWYrWczvoKFYI5oYUGyH4KC3nO32NRQ3zvVL
         O6qnYsuxIQvE5ItqIZMHj65zdlATM7Way3ejuWsI0vJqqJsIL6Ku+HvnIC6EEQJPc2R1
         xuA7GnaHdpOyqoPWXBKzYq/9A5tWG6g9Dcun11XGOHmJrtoFCWXIi3CDrcH2HI5xrb60
         kU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXC0jWZvQ3WTfpQLZ2F6WhMtpP5ZMgO4xSiNPbOxv0bcLUJ0Vtb+qWmQYfe2IKkZzDw6STtVrZpR872@vger.kernel.org, AJvYcCXtGtHOTA6q3q3n5dTq6dxDZuB7yub7czzcIqJ6O+qgZQKdFhiFjWpWL4ypIh3s04v6uYkLRGDlw/CXj3qs@vger.kernel.org
X-Gm-Message-State: AOJu0YyhtCz6rs3v4OaEmvPMAURhSR+X/03rTGkv2eS+WaDpuHaPDD1t
	nTBVmftr5XnWYhD1frJcp6PywjmJcfwWFNuLitsCUEpcPH8R2s0Z+zki
X-Gm-Gg: ASbGncsm/04S+EoaqyfCMnfK+LTX9LRE8ZnTtNiyPk9X72k16ktkfYBfpiY1KEQJYoq
	UYyQ7Mw1KBfqLcepUBSh0R4XiTnCxQ82qPD72PYUogL+ToAKtKKF2fLCVDexDLyBWu2aIdv28Ez
	6A1WC7bHkKLOasSdjdzXq/bpiaDtuSlg8QxW9sS8TkEFEoAGlPDRNeX9w+rolhw3mqvsCCfvRDT
	kSV3MioEos41/RVdLBDOlzTV76JPvpKDOaOIY9jQYSiZfDuwQqH/7ncLiXRH95NqbRxSt6PglSw
	puNhSQe5zsfkfMmJ4eCl8MaL9Qrfr8O0tlAnW1dCRYWdQyKYAQ82TlnccWkIWRDpVSeZTR6JdiY
	hUZd352I8SLcLQvDHrtdtERonoHVqRbVLzoqUO6E1iJYbQMXVwjMFqz6QIa7AUExprTgXxGpLOe
	5b6MrTKbUOr2wMYxT/mrRVNkyvF5ELEN8iTBKbz9k=
X-Google-Smtp-Source: AGHT+IFoFeIhs1JjbGLogAOPAL7+VePjRCrOyPg7wVzL3i/MGX6/KrwNh57ZD1SdoMCZnSYAqEG18w==
X-Received: by 2002:a17:90b:1d92:b0:31f:a4:8bfe with SMTP id 98e67ed59e1d1-32515e2b3d9mr28696892a91.7.1756367406727;
        Thu, 28 Aug 2025 00:50:06 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:06 -0700 (PDT)
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
Subject: [PATCH v3 2/3] ARM: dts: aspeed: harma: revise gpio name
Date: Thu, 28 Aug 2025 15:49:52 +0800
Message-ID: <20250828074955.542711-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
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


