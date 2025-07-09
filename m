Return-Path: <linux-kernel+bounces-723187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E44FAFE42B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF3E4852DF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC51286436;
	Wed,  9 Jul 2025 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Bv8r3BBT"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B174285CA7;
	Wed,  9 Jul 2025 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053724; cv=none; b=CVsPKpX18/CNQItTOp+s9SBKbleu9XXlfNXSMN0/UfNlgCh7gSXm7rGSVcGbhKjehujdv4gdFC7s2fH2l5QQgecH/ikqwpITN2OZ7ov1kJF4roJAVNpP27RnErD1K1f1U/fyxx9N6wDVkEExcSTYAruFdjOUpb4v1sZIYFxVgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053724; c=relaxed/simple;
	bh=eA81CVyN75G3sso4OnIQ9XaM6hUcquy0KVuHAuIXBJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ouOhERQqxVQvuoPuJ0VVkzV4xrpHYf104kLB4A9KOxICMqoIpytrf9+N7UECDYHn7lB04sEV+sDVgnp+byDIMNTMg9MFHFMq8lFoktsClcqAkjPwQrPKz/DJibUXX/CML8vH3m3hQ0wt/oUersQtAfWQy1gvucc1Fui+TzdTjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Bv8r3BBT; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=fR
	rPR+uh57B3uZhUrObQwXZZ48AfmPSckjLH4dcOMkc=; b=Bv8r3BBTu+mJyOyuq/
	wToxX9VCEoJHFRtYNa+g5r0gU60CWpBz/iYsGDhz2h7v1ckky1fKIR7JmNfyuXQv
	hwBjco8oT4X9kcI5vHAUGzlWyyK3D68WVUk7v+C7eVbhVwvDYxCKuoJwHKKRhNEe
	a9w5cZSkgZ1KbfM0W385Yuu8w=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXTwakN25osQEcAA--.49192S2;
	Wed, 09 Jul 2025 17:34:29 +0800 (CST)
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
Subject: [PATCH v3 1/2] dt-bindings: hwmon: Add MPS mp2869 series and mp29502
Date: Wed,  9 Jul 2025 17:34:19 +0800
Message-Id: <20250709093420.456304-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709092734.455976-1-wenswang@yeah.net>
References: <20250709092734.455976-1-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgDXTwakN25osQEcAA--.49192S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF17CF1kuF1DWFyDGw4fGrg_yoW8Wr4DpF
	WkCF4IyF4FqF47Ca129F18GF45WrZrA3ykJ3yqyr17Krya9rZ7ur4a93s5Xa98Crs5WF4U
	JrnFy34F9Fyjv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j8jjkUUUUU=
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiBBeFpGht6-rnVwAAsW

From: Wensheng Wang <wenswang@yeah.net>

Add support for MPS mp2869 series and mp29502 controller

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Wensheng Wang <wenswang@yeah.net>
---
V2 -> V3:
    merge patches for MP29502 and MP2869

V1 -> V2:
    add Rob's Acked-by

 Documentation/devicetree/bindings/trivial-devices.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 27930708ccd5..2066696ecff4 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -285,10 +285,20 @@ properties:
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
             # Monolithic Power Systems Inc. multi-phase hot-swap controller mp5920
-- 
2.25.1


