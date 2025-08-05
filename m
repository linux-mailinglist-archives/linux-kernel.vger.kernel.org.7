Return-Path: <linux-kernel+bounces-756265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 690A5B1B20E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9780D16536C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914B422333D;
	Tue,  5 Aug 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="RV9IzhG+"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3CD2566;
	Tue,  5 Aug 2025 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389898; cv=none; b=Mhe6ikR2wDW0/vjCQj2UFjGJffBuk+mdE0D67C6sTKjChsjUbShwGUTo2/EVcKYZYl79b5tN4Z4b/U+MMbRCTEmhriSV4ZOqxjsFkc9B2LYAsVXmXhtTFPVB24jbmeIYIe74zUW33uWdEpdk/qYOITqfmSDUTQJiXmh6A3N1fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389898; c=relaxed/simple;
	bh=SZXiJmkDMpnyHVml/lE/tZpUhzlTWvl2AufRZ01q3hY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAYuQIHd+e2Ih4aTGaUAyYV5uYdiccbJoHnaDjCIkdcKSOBQ4HNGfPloYcMJzEAOpsMareFiRCSY3XWasH7F1pP1xCztHnDWLywAMhKtSsbM3Pa0U/79zUg+sX4PFaP9Aq6l5Pa1yYkv/Rh6kF4T/KnTI9RarE1h964Zz6xl8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=RV9IzhG+; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ew
	X3zpeQCbPJL6bn0vT+8Zrn3/M7RCsOru7l1g5Iunc=; b=RV9IzhG+mR371FwMsI
	+HWIQzYo1MRRhcNDUF0AqYM/0LXOs+/1WDXHzPLsy1sVxYPu9H/xqM4+OzFDy5ro
	+G37kwhFkrf8MG1i9YxTxI5O2ydrrtTb5AQ0tEt5GQiRyw6Q9I8NlXjJq1oXTTjA
	U3U2uyAwRhTDInc3Rdl51O9Q0=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCnDwTm2pFoQFEdAg--.18285S2;
	Tue, 05 Aug 2025 18:20:23 +0800 (CST)
From: wenswang@yeah.net
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wensheng Wang <wenswang@yeah.net>
Subject: [PATCH v5 1/3] dt-bindings: hwmon: Add MPS mp2869,mp29608,mp29612,mp29816 and mp29502
Date: Tue,  5 Aug 2025 18:20:18 +0800
Message-Id: <20250805102020.749850-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250805101754.749492-1-wenswang@yeah.net>
References: <20250805101754.749492-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgCnDwTm2pFoQFEdAg--.18285S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1rKF4DCw4xury8CFy3urg_yoW8CrWUpF
	Wkur1IyF4rtr47Ca1I93WkGF45XFsrG3ykJa90yw17Gr1a9rZ29rWa93sYq398CrnayF4U
	JrsFka409a4jvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqiifUUUUU=
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiIAduE2iR2udMfQAA3v

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS mp2869/mp2869a,mp29608/mp29608a,mp29612/mp29612a,
mp29816/mp29816a/mp29816b/mp29816c and mp29502 controller.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
V4 -> V5:
    1. merge dt-bindings

V3 -> V4:
    1. split patches for MP2869,mp29608,mp29612,mp29816,mp29502
    2. add description for vender specific registers

V2 -> V3:
    merge patches for MP2869,mp29608,mp29612,mp29816,mp29502

V1 -> V2:
    add Rob's Acked-by

 Documentation/devicetree/bindings/trivial-devices.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..0e6ba6e12a63 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -293,10 +293,20 @@ properties:
           - mps,mp2856
             # Monolithic Power Systems Inc. multi-phase controller mp2857
           - mps,mp2857
+            # Monolithic Power Systems Inc. multi-phase controller mp2869
+          - mps,mp2869
             # Monolithic Power Systems Inc. multi-phase controller mp2888
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2891
           - mps,mp2891
+            # Monolithic Power Systems Inc. multi-phase controller mp29502
+          - mps,mp29502
+            # Monolithic Power Systems Inc. multi-phase controller mp29608
+          - mps,mp29608
+            # Monolithic Power Systems Inc. multi-phase controller mp29612
+          - mps,mp29612
+            # Monolithic Power Systems Inc. multi-phase controller mp29816
+          - mps,mp29816
             # Monolithic Power Systems Inc. multi-phase controller mp2993
           - mps,mp2993
             # Monolithic Power Systems Inc. hot-swap protection device
-- 
2.25.1


