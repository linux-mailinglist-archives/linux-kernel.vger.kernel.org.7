Return-Path: <linux-kernel+bounces-827023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A08B8FE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13ADF16A126
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938BB2FFFAF;
	Mon, 22 Sep 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvcc2yuA"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A02FF175
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535589; cv=none; b=pt+Ih2nidFDa89yw/QnOsaQNtOeJCZWKY2CzC3c1cpcnbcTPfx1ufj+EwilYalngH90ZZ3LxWYjDYvq+vhonZNyxXrPvKAKGnmsReuPlqbgcSK8JcCaXWA3t5EZAoRBG+Cig7PlRzN2UzhCAw5BDjWL7j7PHjQ8S3anKkuqVPJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535589; c=relaxed/simple;
	bh=p6iwdyUUP5W8+77ExyG+J/4KTfuGbStSzXc5YQJ6uQg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rj0GrusL3GXG/xXoUxJTC1nICVCBuBmzD/VWIcNGWauhgPJkLsWl4FMHcIhA8jQaPI9xKPplkLSifryDyKf/lpAxBL2vWQz1A1yKtqAV86R8mwX2bCdZHwVty7PuRLsQDpKsGAtIja7IB8XOyuYnKfnBgm4nww5p455Y6x4mBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvcc2yuA; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so3941980f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535587; x=1759140387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz313f5+9XsH5+Eb3Bh9XStxpTdiNn9ua8EWNmWWJg0=;
        b=Kvcc2yuA+C9pliVMnH3NcM/cuTNcTpP9BD6ZmTmpTEc5z38PrdB1ou07Sg9OCDWKRa
         nqe0mO1/uIPlwuNWzpwJ92f7hEm4ykkI+ltu+RtW4pfofjkyF3whnv+F2vejAeQYIwsQ
         VI5YAgoI3R2qM/L3Pz+/HtCaD7NezfDT3OHjEdEjdxXd/eAA1pKDGjxbKB+acITyz7V7
         9wamCwvNKUttbTCblF02F1xJIjXjmcZrIswdrQhoXIW5a+OUGlnkC1AEMWmDN1ALcs+/
         FWaWBZWj+ZFri2yvJCv++6/vSPV/GoiQ1jh2775JOWnmGuztExWD2WtkMNXQ2GQ7mr1X
         zKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535587; x=1759140387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz313f5+9XsH5+Eb3Bh9XStxpTdiNn9ua8EWNmWWJg0=;
        b=pBXefn1Yr8Y+j3S10Y2blOeEqO2i3XA1gMtoYtZbcd4h3fnSVYoQzDxB2t6/FNqI1T
         pnpUGQCTUUhpucCGzs4cjVhLE6sKJ7Pk0XrIDvOo+Qr9wkuS7oVogW/SI2hOtg4739bJ
         qAE/pqzJJzegE30FvYfK53l4mFpINfks+v8RiYkCD8SvFVKpAbkHbt+3ByMFalnAbOkT
         2QRA6rk2nL1TUE9gVJYJ2FNo/z9SgqGinKvyYWtDUPHdU+9g96vAx4Q1PcPvlIkuW1P4
         i2lH5y9RUu5T7KLBJLv913g87t/tBzgsDXV4TF5z1gF0RRCzIvTLHrUk42l9AQQdN/TU
         xVpA==
X-Gm-Message-State: AOJu0Yw2lROhi6i6zKLXyBB+U3QSDTjC10K4oNlXN8LxSaNlneCPYham
	akC084k8sF8biKSfA44lQjR+tgUtUQs6dgk/g+V5QuRl0sGEF2WDe4vXqzYtYg==
X-Gm-Gg: ASbGncvHpx2ts8CIkmgAh0waehSElckng1vGZPJNCppz7vaA6gdQecUAS8G8EdEicgT
	EWqDpQFaDUIUajOUR3VxzooYM6jsDyxdzLB6uj5KnmXeqtXl+lbBecucg/hCK9zfBTPv77GA1pa
	QT7Q1saVN2Dv8QpJNEMprVU7P218lwR/0Y2Tnt4HDVO5C5S8WmGJaGluers/FICgJLoAmaTZOVd
	tqoyLHWhfC6bUQSyNRY+maAu5vdsr1Agt+VOynP75FxK5s0uRpm719Ke9W+NLqxzPbPhJDrX/3f
	WiW6tS3eP9YxOmPobVOnO2eYo44IQBfOu51mIxgxTcWcvohteQrBXC7cQweJid5WtuP4VzTq1oV
	DV0UAsMhfqB9Xc6uqGYgMYuw3PDh/M6EpRk6KBmJa1FkHMnphu8dYm+ZI5q0pnuqaPrbi+9/R/a
	qTNYxI5GzVIRcXMrMUM4vKFURh/ec=
X-Google-Smtp-Source: AGHT+IG5CaKIu1s56p3TpWS5l1RWL/b3CenMfj9WhML69rXhvqLaZjx6Zs78DXIYN5FpHbWguxd0TA==
X-Received: by 2002:a05:6000:2902:b0:402:71e6:5e12 with SMTP id ffacd0b85a97d-40271e6616emr918355f8f.46.1758535586492;
        Mon, 22 Sep 2025 03:06:26 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46d1f3e1b03sm40913405e9.23.2025.09.22.03.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:06:26 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Mon, 22 Sep 2025 12:06:18 +0200
Subject: [PATCH v7 5/7] dt-bindings: memory: SDRAM channel: standardise
 node name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-b4-ddr-bindings-v7-5-b3dd20e54db6@gmail.com>
References: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
In-Reply-To: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Add a pattern for sdram channel node name.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../bindings/memory-controllers/ddr/jedec,sdram-channel.yaml       | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
index 866af40b654d..5cdd8ef45100 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,sdram-channel.yaml
@@ -17,6 +17,9 @@ maintainers:
   - Julius Werner <jwerner@chromium.org>
 
 properties:
+  $nodename:
+    pattern: "sdram-channel-[0-9]+$"
+
   compatible:
     enum:
       - jedec,ddr4-channel
@@ -118,7 +121,7 @@ additionalProperties: false
 
 examples:
   - |
-    lpddr-channel0 {
+    sdram-channel-0 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr3-channel";
@@ -133,7 +136,7 @@ examples:
       };
     };
 
-    lpddr-channel1 {
+    sdram-channel-1 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "jedec,lpddr4-channel";

-- 
2.43.0


