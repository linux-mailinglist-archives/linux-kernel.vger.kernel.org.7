Return-Path: <linux-kernel+bounces-822285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25517B8374E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4911C82C2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A132F90C9;
	Thu, 18 Sep 2025 08:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="XiEiyhxX"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D4C2F7AA0;
	Thu, 18 Sep 2025 08:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182827; cv=none; b=HoZtZCWLJTQIjqLWPv4PoMqxPKht7wnbh3oJFDl/NcNoLXMFhaKaQwYhJMWJFDVnojMTeFP8U/LQ4twbYmxpDqdKfC8wUObpYZyjX1VNrWDshRf+/yVz2BDQ7UHB34LBsBWYSbcjyg1/VDhimdZ0U3scUChYs72sztnqzIUqpss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182827; c=relaxed/simple;
	bh=ClFvh0a6XVFxTs3aTf7ZnAV6BT767LS9PZiwjdEuS+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exDrqaXOpJVYN3axERSVwSj7XSSEcjLJF5mUNix1phkZdtd7ca0syZzio60Tc19aiHBhMF7N2SsdSBOpGsP0QlaH6v9Byqrf0koqdyk758+jXOEU2aN7aWuAtfMC5QcBve7ALsvsnpxtupECqsRahmRA1bF9c3LAfuu1eBDZtC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=XiEiyhxX; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=8d
	AwrvZ0ngReEO9LbXxo4sA0RRfzQcPeOQ4JXyrALtQ=; b=XiEiyhxX+xfG9vyXT6
	FpTlDsaGsEqUv7WVZ9OTb16dsE479QaJkEAYy1RVVvsBxZzrokISSPtAD4qm24tW
	ArQhoXdYo07nP4Te7YFJ2XwWbowXaDwEK8++DB3oajKFNUqbV7WEOtoYFn+fH4i/
	361sg5afr2XlNxRvfJLGFjMR4=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCHJdpuvcton1nLBA--.29488S2;
	Thu, 18 Sep 2025 16:06:07 +0800 (CST)
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
	Wensheng Wang <wenswang@yeah.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add MPS mp2925 and mp2929
Date: Thu, 18 Sep 2025 16:06:02 +0800
Message-Id: <20250918080603.1154497-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918080349.1154140-1-wenswang@yeah.net>
References: <20250918080349.1154140-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgCHJdpuvcton1nLBA--.29488S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryrXrW7CFWUZF1UGr4UJwb_yoWkWwc_uw
	4xZ3WDCr4kAFySkan5AF48Jry5Gw17KrWUu34xtF4kXFnIgrWrCF9aq34a9ryxGay5ur15
	urnaqrZ3ZrnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbeMKJUUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiCQPMpGjLoSZNMwAAs4

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS mp2925 and mp2929 controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
V1 -> V2:
    add Krzysztof's Acked-by

 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index f3dd18681aa6..eb617a6c50e5 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -297,6 +297,10 @@ properties:
           - mps,mp2888
             # Monolithic Power Systems Inc. multi-phase controller mp2891
           - mps,mp2891
+            # Monolithic Power Systems Inc. multi-phase controller mp2925
+          - mps,mp2925
+            # Monolithic Power Systems Inc. multi-phase controller mp2929
+          - mps,mp2929
             # Monolithic Power Systems Inc. multi-phase controller mp2993
           - mps,mp2993
             # Monolithic Power Systems Inc. hot-swap protection device
-- 
2.25.1


