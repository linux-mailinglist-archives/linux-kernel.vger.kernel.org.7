Return-Path: <linux-kernel+bounces-862122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C9BF478F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B864664AD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D4D211499;
	Tue, 21 Oct 2025 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9FmyixS"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6A3B186
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016553; cv=none; b=rX8IcTuWYuTSY8PY4HheZGE/QmkIRa/yWV0d8+IKEHMoeh2HfxQ1QA3Bx4It6hwaWfV+/OcQeqN1ZzAqNA41fSxi8i0VQJQppuaw19Mk2Rv8P96GMKMqMPV6bbYb6MTG/uADMwL/GtX6Alb9gGb2ImCgZldfGSRLLHcbRO+3aOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016553; c=relaxed/simple;
	bh=FozCj5Qtilnm6MTFQqUJJBi0+f5aDzs/7epoDnQr8Rw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eZw877HkXajrrEq9UsGQVUrN+pvWqpHd0jVTVKi+Hu7AYDDQvHCaBbG9csKSrUc3QB7QOBjUewL9EmQrTDMYg7CeLXJOoujVL/v9TFkChZPko9Qfl3jvWxJAuSnJWJAhZHSOZtf8kVdw6Up4Ys64jh/G6rtLigLujrv2PvB9tk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9FmyixS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27ee41e0798so80769295ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761016551; x=1761621351; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIc5Jk6uXrpT5vKhUN3R3BidtAKxdUPzX/dU/naleU8=;
        b=P9FmyixSb94cxMLRqyW/OTZj/wzKWawTCu1NAN3EYTDUgInaRAy3rt3KyCj/JDnuew
         kprRO9iS03CtTySFOlfSiDFCUvvLpB+9sdvN7tF2noUBA3Ewj2dIG6oMbjpuDA5B+EWJ
         FsW0kxOMOqeRWVHpD/t3rYq7T4+VIFeIvBPJGaIdj+ZeKxRbB4RhDdwjEAJ6adWPPPga
         +wnHKPBf/erEGhEUs+eIaYkdTJjk9rx9tU+w6jQTAyxRk6bXdZQqP9Y3joaB/HjFAFsn
         TiHyyaXugJxC8QvqjVNptYZ0hru0NcnD94dnL2xF5w1IB1bqgdclItju4l9qZaj3cdxC
         4eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761016551; x=1761621351;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIc5Jk6uXrpT5vKhUN3R3BidtAKxdUPzX/dU/naleU8=;
        b=a442sftI/te3mjLnWxSxR6MEJXQJXYv+GcaNPhJbqKw5RVcrVczn7NEey2tlD9fR+8
         SR/ZLlmCpnaXuYYFZcYrgZqoXqcnoIJHN3zhzvXxB1JKarZPyvuuQmpayK49Z+JfvqLd
         4/YcGaL7WAZBN9iDQZuY7kFLAlFbfD+ahdiVOaCPqG1dMoPaGnT/aznIhelNA3DYEsDo
         qAWHaq8KT9AOzN1WATAzb+5o1yEMgg1tsyc0Pf7Q6rQBitDt2GJqufPIsuy3C5LHmTr+
         Be2tpKzz+eTPJLPpWn6KeOOZhxVAHnz8bMtQQF56tsDyVBigWFXEnd5pkmUKZCNCaekL
         T6ug==
X-Forwarded-Encrypted: i=1; AJvYcCUaKJyE6lz2LY4sYxh8Et8btmChl41ehfhuwAT5pQd7GVv+4Oe99nBxZ/g0myGrGUWYMVrIN1N0oUdQVu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3mX0Ay/Lvw/9dt8itY9Lzc/XBhMs7uJjiR1z7R5pV5uIriDW
	2HFBUI2JxvtJIs5WJUxsTpx/Rc+HtPLP1FyN2/d1Mo3a0jOVSrYuxRqE
X-Gm-Gg: ASbGncu5IiS90nPiy5uk8uxzE+jPzETVqOstKAo6b5k8jrSy/WbcAUfpB0ahKiNxovF
	yxnmzn7m0RT4wxHi0/CrdAZPbSMGyJiKrI0OPRvOQpVfSGzgNfg4WkjM2GoTwcDOPohDAp/J1Od
	AQn14VHxWvNSEaGScBmEIHxZFS57ZTBLM36kKOsvYalkTseKS8EN9jRoInSr9Y0QZ4HycUVnVqo
	V4RWepRksofGhs6gCKFfeFKCmZ7jh9m1xQR4Akqu5Nkft/bSqkNKGne8HZHpUfE/mszT+SJByw4
	JLMpJF3VMDTalk1/yuHPjh5uPTsG0O6wccHOLIMABPKh96wFG0ZOVK9hqrluNvIyFJeJ5+oLuyw
	0LukF2p3pq6ft8aXnEglfV/c1XSdqADtvnXq16f6G7OHA0sxSQqX4TrzQIqEx5TBLYL+L0jHc/+
	RBAahsoFc0PAzsLSpRI5qvlF78J396O4ydkFtE
X-Google-Smtp-Source: AGHT+IHvc2OdIns7Dhqd5TV4LyvC/HJfGjCUatzoXh06HQxZAcairq7EJA2klU28lcwGsK1CQQDx2g==
X-Received: by 2002:a17:903:2b0d:b0:272:f9c3:31f7 with SMTP id d9443c01a7336-290cbe2ae84mr56298125ad.50.1761016551034;
        Mon, 20 Oct 2025 20:15:51 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246fcc2b1sm94889765ad.27.2025.10.20.20.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 20:15:50 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Tue, 21 Oct 2025 11:15:39 +0800
Subject: [PATCH] ARM: dts: aspeed: clemente: Add EEPROMs for boot and data
 drive FRUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-leo-dts-add-nvme-eeprom-v1-1-33166b3665b4@gmail.com>
X-B4-Tracking: v=1; b=H4sIANr69mgC/x3MQQqEMBAF0atIr21IZ3REryIuxHy1YUwkERkQ7
 25w+RZVFyVERaKuuCji1KTBZ0hZ0LSOfgGryyZrbC3GCv8Q2B2JR+fYnxsY2GPY+CPfqpG2bid
 rKNd7xKz/99wP9/0A40cKRWkAAAA=
X-Change-ID: 20251021-leo-dts-add-nvme-eeprom-316471959c20
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761016548; l=2272;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=FozCj5Qtilnm6MTFQqUJJBi0+f5aDzs/7epoDnQr8Rw=;
 b=8BInr5iA6wBDcAL4sY8DnyKW4muBdm9myjKyhrNgz4zvC7PgZByz+aciemOqaw2l3lP+Dk17F
 WiRuYEfnT9MAdWDDJm8CfcmcWioWtAmA94gNx57lZN4uJoHCmtiSswe
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Add EEPROM devices on the I2C buses used for the boot and data NVMe
drives. These EEPROMs store FRU information for each drive, allowing
the BMC to identify.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index 450446913e36b1418fab901cde44280468990c7a..885c50a7d66593dfa8493d2d031700174b452382 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -311,6 +311,12 @@ i2c0mux0ch1mux0ch0: i2c@0 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0>;
+
+					// HDD NVMe SSD FRU 0
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux0ch1mux0ch1: i2c@1 {
@@ -323,6 +329,12 @@ i2c0mux0ch1mux0ch2: i2c@2 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <2>;
+
+					// HDD NVMe SSD FRU 1
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux0ch1mux0ch3: i2c@3 {
@@ -493,6 +505,12 @@ i2c0mux3ch1mux0ch0: i2c@0 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <0>;
+
+					// HDD NVMe SSD FRU 2
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux3ch1mux0ch1: i2c@1 {
@@ -505,6 +523,12 @@ i2c0mux3ch1mux0ch2: i2c@2 {
 					#address-cells = <1>;
 					#size-cells = <0>;
 					reg = <2>;
+
+					// HDD NVMe SSD FRU 3
+					eeprom@53 {
+						compatible = "atmel,24c02";
+						reg = <0x53>;
+					};
 				};
 
 				i2c0mux3ch1mux0ch3: i2c@3 {
@@ -619,6 +643,12 @@ i2c0mux5ch1: i2c@1 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <1>;
+
+			// BOOT DRIVE FRU
+			eeprom@53 {
+				compatible = "atmel,24c02";
+				reg = <0x53>;
+			};
 		};
 
 		i2c0mux5ch2: i2c@2 {

---
base-commit: 6953afcd81a2cc73784e3dd23faa0a1aaf97441a
change-id: 20251021-leo-dts-add-nvme-eeprom-316471959c20

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


