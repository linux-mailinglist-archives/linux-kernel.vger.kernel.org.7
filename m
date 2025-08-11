Return-Path: <linux-kernel+bounces-762473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF33B20714
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA9F52A2E1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E1E2BF3D7;
	Mon, 11 Aug 2025 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="pAwN7B9x"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042C2BE7D6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754910825; cv=none; b=LjpXwvXKcloHe7KC1vsqGxe2zZAxOQcCtKLWajB4p+4HhnwAxa5J0JF0O6mce6cAN/FaeBdnKe52q10Uo/6P6vXo+rKln6hpY29RuAju/97oR9o77hj2VPvlTQmpw5tOa7KzO5yPti2HJBsVmpEscTN3cdrGvrn9ruOMGk+E6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754910825; c=relaxed/simple;
	bh=UX0N+djpdMFrLMwSfXGN6kbOHJTu81y3bcRb/z2XUPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j2DbVyD2Lbj2MKWt5c24TASCSwcWfaZ50Oyza4VqBF7hPTsYIoRN6qst4br/iQOaJ3BIADnmeWf5l2vGvrdS5x1Odafx6NINUI1NAOrieIPVcVeHdg9xQMbOKezhYMvQcfjdJp4KPP+DWWvdpSFNseBZ5TSXZsVBVeMvVed1vKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=pAwN7B9x; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-615c29fc31eso8022996a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1754910820; x=1755515620; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE2K+2ZuImK+3i5KhTzlvfFepruAjEsa4XS1kJeheQE=;
        b=pAwN7B9xe+VX+QD2Vtz0A8GkgVTcqV4hLM148cDvn/j/lRA4TXGV6bmsa4Rzx4MG8K
         QukK11djwopDMoCqHNvYWZikvWBltmPV6KHj3+f3qZcBmw+P0v/y6y/6qU4NhW7z+EBM
         xqRlqb6jh6mvjIzFHLwX1lfX9MvaW8t6HL6V9K8kFML7hA5Ue5LVzk6RD4XVN3euCWfn
         p5CQPrZLpvpEw35wno1Bz7tBkv2kV0dmapzFz80QaEcewfihtu2AM9Cq+lq+MpEXXXo/
         YGmyYdKepR+dhzltBOoETgJIuIi99fVZ9xbQkAZfp8MiNkeQwPxyNzexhf/drn9Z97ON
         GYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754910820; x=1755515620;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE2K+2ZuImK+3i5KhTzlvfFepruAjEsa4XS1kJeheQE=;
        b=NpFFGFh3OWrpu2F1dhUieLOZRpD9unuSfnZmR2DAydJOgA8fNh/i9U3xPBAFd3Sdir
         H2fjKu2AWGM3dPmBLN9O7CEs34T1gfyO3zKwIDHH9Xe+1qsPooZWjrVWWNqitlSUcrew
         QDrEVkTMIcuXQvfKM0lUk1U0g9GomK+EHKYF56e5t4qpUkMUXO4mWGs7MM9lR2EWmzbJ
         AC9OKnzT+9Ct+JHdInreNnGfHWkKXMI1hCVReQd+H4UW1oHMTmkdEOFGyPCVSMQql3rN
         6lIKrr3T0ccq2A7jIqv2tHmaxglJMrmyNHP3si+OJaSupTex111I/C3EpuSfnT6HO3JX
         tncw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Yr8kVPkpHPBG5dKZT5g9+femJjJQag/Abb51caH0cj/8bkxoXbgnWAg7Pijx39psplNEf5qRmTjm+Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWcSQf/Ftz5NRkqwmK5zKTHEz2qAQjLrYyzNzBSmf4qw0g9517
	sbiJYRLovTJpc0j0js81oJYtlub/WE93IGJy36uV3JbsWvkniiy885rwxe8DCUyn7Rc=
X-Gm-Gg: ASbGnctXmDhi3J2utUVo/iqByFagF1KoP3l+2wbCsyx55Zf/ixYMLB4HIFfBUtGxaHB
	0azRfp13G5M0XKiFxDh6g5GBkQIXBnxp+EUGKjQywfLZBHGvYUjB6c0kvHrVfGItUyQ54gNnjEQ
	6kSmfLqLN2kxJACEN953jdLHSjEdKTDex/rJ5pTuWx7vxR9CE/TpdCJW/ts5Rb7Y93hOyaHsItX
	0MvW9wwRBe4InTa/cpcfhXVz0/YNIgb82rIU5v93Nqe8tnPcLPSS//fGZplPxweCvxiCf1Ay1EX
	8X8leNoww1sh2hAnXir/duXN+ssjbQC0uPX2zhpRyfY3dCtlkCRRbY08vIBaDbA+uZqNG72LPLT
	WkojMZmxe7PgN7SeBGBtw5sKtx58IEDD5z0jaH7Ql2YLg6ETUov1NfkkoPpYZkUTaUQWhv15x3D
	/AbA0=
X-Google-Smtp-Source: AGHT+IHUNrs5ICyRttLZ4MBvQlWqGANX+fEiGFeSfSnY70D0xRdH+Hf+x8fR/7sL6Y2nP86DQTcQsw==
X-Received: by 2002:a05:6402:50c6:b0:617:b2aa:576a with SMTP id 4fb4d7f45d1cf-617e2b70dd6mr10647062a12.3.1754910819461;
        Mon, 11 Aug 2025 04:13:39 -0700 (PDT)
Received: from [172.16.220.71] (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61821e562c0sm2467278a12.30.2025.08.11.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 04:13:39 -0700 (PDT)
From: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Date: Mon, 11 Aug 2025 13:12:01 +0200
Subject: [PATCH v2 1/3] dt-bindings: input: Add bindings for Awinic AW86927
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-aw86927-v2-1-64be8f3da560@fairphone.com>
References: <20250811-aw86927-v2-0-64be8f3da560@fairphone.com>
In-Reply-To: <20250811-aw86927-v2-0-64be8f3da560@fairphone.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754910818; l=1623;
 i=griffin.kroah@fairphone.com; s=20250804; h=from:subject:message-id;
 bh=UX0N+djpdMFrLMwSfXGN6kbOHJTu81y3bcRb/z2XUPw=;
 b=G/haZsxAW3Uta/ivP+qf4w96lRdnPqBSEuvBIEv5bSUBM+FgC8/2/wi6zdwUPHNG542bTSlH8
 V4sH+Gtjwc4AWJeTwfiTqevrXKnhnpW6DQxLkXVhGeJ59bz3lyLvcWe
X-Developer-Key: i=griffin.kroah@fairphone.com; a=ed25519;
 pk=drSBvqKFiR+xucmLWONHSq/wGrW+YvcVtBXFYnYzn8U=

Add bindings for the Awinic AW86927 haptic chip which can be found in
smartphones.

Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
---
 .../devicetree/bindings/input/awinic,aw86927.yaml  | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/awinic,aw86927.yaml b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
new file mode 100644
index 000000000000..b7252916bd72
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/awinic,aw86927.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/awinic,aw86927.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW86927 LRA Haptic IC
+
+maintainers:
+  - Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
+
+properties:
+  compatible:
+    const: awinic,aw86927
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        vibrator@5a {
+            compatible = "awinic,aw86927";
+            reg = <0x5a>;
+            interrupts-extended = <&tlmm 101 IRQ_TYPE_EDGE_FALLING>;
+            reset-gpios = <&tlmm 100 GPIO_ACTIVE_LOW>;
+        };
+    };

-- 
2.43.0


