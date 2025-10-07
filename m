Return-Path: <linux-kernel+bounces-844479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 76185BC2074
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 367CB4F714F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899A52E7186;
	Tue,  7 Oct 2025 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFCCekN9"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAF52E1C7A
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852995; cv=none; b=FpOc3X8HgdZOaGcLFGlzNSQyWBgQkoYp+lhX9ttPjjCotNkk/QFmQYhEdd2kZm2FZoPFzPrefg6wS7gqw4v0NzGh5uVd4jkXeQaQ9b6j57ctM+b7e80ECP2YZ48oC4FYmL+J5sRHLzEnyMfZ8oxcqbJgCsi5nZCJqvvc+P66CVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852995; c=relaxed/simple;
	bh=fJ72ZMhavTt/zW71hZxTnZ2SN+OoyfXQg3BT41sI8Lw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jqJ4hE629O4lJAF+ccA4bSGCmgOSUPEpiVvGnM85jOLkW/XoGigIxvKQaHX4AqwDg1ZFMTviDfAqhez0fYZksuhJHcW4rrrwDkOOD9nxwSnmjmOqOeuk/1OL8m7Dz8Wp0MccP1rThJXbcQ3FcWemfj5MDH9DKAfxXHaxLVSbzAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jFCCekN9; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e44f22f15so960246066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759852992; x=1760457792; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cm5Dko9olaR4ZjBSYSeJvT1TaV6qKnd54YvU1t3L9I=;
        b=jFCCekN9RwyDqx0qwWloiB2wwjxnod2enfPpmNxf62IebJoXUXrWni7d1z3/EnGHfy
         aNjUnnfzdXYBXMN24SVO9QzcPUDwdeih3LIjXUTaLo5rLJQyZ9VQml+fPbGzSgoT5Ybd
         loMdf0h4Qra0w/hNiQD++yk8JcJ7wz5QLH7DqqYa9/F+5XzltCrB49IxTZpEzjz9pyDG
         BIoqsvlqBbcvI/GJM/sLpM8IMlgP1FTh7bH075VpkQ2xYaw60YQMBJ2X2YJ7JBqSl/6u
         CUNvszkf+5wJEVfvKbnhLSm202BycDdQPadAoVY4BUgX+4BMlnGVCjNbKk6CqM3paVHe
         Zj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852992; x=1760457792;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Cm5Dko9olaR4ZjBSYSeJvT1TaV6qKnd54YvU1t3L9I=;
        b=Zh29yFR1BZXcUfrQ0jYpj7McY+878n9jb8GOjOB76+Fa00zPiQZLULDBepdvI7H20r
         HQZZWoHOwAqZJ3NJ8jh9gRW+ftioRJFyOQqqYZ7ZQ3DS7Yg0uQ/kQ8a0qFSMxvB1okc1
         fyzw4a7nxXtqTGp+1qCyyGkPPG5blCa4SuoWFGezgjLJgoHsqoeI9b5DfqaPtn8UttcA
         mkLFU5XalNTpxNoEG05+6QvdczbRM6yMop7GlFIhnrw1usrdL+20hw3YWERahxZWJFZL
         QVJdW6PZ180nYAlYoRHWTKkBQ+yN6Dwd9+iiJZU5SbCOl4ynkzCoEjcn1ghO//oerDg2
         ZIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD1TZEUsqGsPOHl/+X4TkuAKLPVSL8oYR8Babr09TvgQuCCG3Gn/p/KGFPv8rEE+FBnYrEXqdo3kqjBCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfdDEIZu2TT6iB+e7+0aOPHRtd+qIgMU0fwJjlDsaPjmEIxqZt
	nDRrc9ni5ig0znngqENHyk97Gf+sVbWTfovSbg6IDY2SHFyn2leLxV/4n8E0ovByuxg=
X-Gm-Gg: ASbGncuQobqrbMhKVbhQEy2WfqCHgO69ht9lDnMQe5VO72E5dAWc86coddheHOS6dQP
	Q0I6NyXmBOmhGqGY3vItc8GNukoy/hVr9FWFiXpXg7u//9QdSE0COsSy9jjeeOZZ4KVxig8t+e/
	OWFES9Xb2s804+a7++vJQiW16PjTHgvaMzx+ygu78gn0t0UnthM1QwpEGDpOv7Vy005W3Qcho1N
	/0/PNZzhhFHIOJt+fVyCPXHIw0cdE0+XPBUgdHa2t/dJ+DtTuoxFh+OISNsfWqdXe5A/4E5ns1S
	5ZfMGTWRtMlSgdsEBABT8oWYrkDmvqO6zDW5/6k5o/MTb/15v/WkHi83L0GwR1xmCuYXrnYNVyA
	mc6ZDAF5qkayethdX7PPmBdjogZOW77zS/NVNygPUwBjNpXRnYP6nyajPmTyj0jhQBbSdYRIu7j
	Rb5Br/Uk8xJ4eTX5Av1Au/nFgsNsTUZmAeaPNVOmci
X-Google-Smtp-Source: AGHT+IGcHy/Jl0g2LAmEkVEntCtICg9hZqb+cVzIJexCEPogdkyReymHfPrFtWwic4ednSokiuHGag==
X-Received: by 2002:a17:907:807:b0:b41:f729:77b0 with SMTP id a640c23a62f3a-b50aa1869bfmr22271266b.21.1759852991654;
        Tue, 07 Oct 2025 09:03:11 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652aa637sm1399772566b.12.2025.10.07.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:03:11 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 Oct 2025 17:03:10 +0100
Subject: [PATCH] dt-bindings: clock: google,gs101-clock: add power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-power-domains-clock-google-gs101-clock-v1-1-1ee73c453ba8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL055WgC/y2NQQrCQAwAv1JyNpCsqK1fkR7qblyDdVM2oELp3
 13E48xhZgWXquJw7lao8lJXKw1410G8TyULamoMgcKBiU642FsqJntOWhzjbPGB2SzPgtmZ+K/
 2gforD0dKQw8ttlS56ec3uozb9gU0JNMieAAAAA==
X-Change-ID: 20251007-power-domains-clock-google-gs101-clock-3208b1960d98
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The CMU can be part of a power domain, so we need to allow the relevant
property 'power-domains'.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/clock/google,gs101-clock.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
index caf442ead24bda57e531420d8a7d8de8713032ae..31e106ef913dead9a038b3b6d8b43b950587f6aa 100644
--- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
@@ -46,6 +46,9 @@ properties:
   "#clock-cells":
     const: 1
 
+  power-domains:
+    maxItems: 1
+
   reg:
     maxItems: 1
 

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251007-power-domains-clock-google-gs101-clock-3208b1960d98

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


