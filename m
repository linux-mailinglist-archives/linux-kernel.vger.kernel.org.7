Return-Path: <linux-kernel+bounces-844476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE7BBC2044
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 18:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE3684E3709
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 16:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BC02E6CBE;
	Tue,  7 Oct 2025 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKKOCpsX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1030F2E6CB3
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 16:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759852908; cv=none; b=I6Minub8kikbfZ/dhh+r3LmR6M7yMaFszpym+iDv9gzGOcb373fLhnQm0A4apbYKDokPOGfGtZnDYqbDNGE7Hyc590KiqCE26ne/VXBgjmK+g3ZCavQvCobEQ1CUJ/Wvl9diCLEhICyKme5YrwWWZ56MXEgf8FZreAt0TGazHJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759852908; c=relaxed/simple;
	bh=JESQkAaKU/J+NFwewP61WmovszCLFhCP0rBghjse7Ug=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g0nEks2TT6vuLJMnpBwJTt9mM/hus0leJsoHLbuOsUhByDyryJlDCJVWlQsmr5yQ6QaF4kBKAaOjXVd000ewnzmHat9R4Qx2XRoOQL/XbNuWb5Cgs27GN3tCiL+vA2/koH5sAP4PPppgeH96pWB41XNA3GJOSr4aedJMVQHgtbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKKOCpsX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b48d8deaef9so938033466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 09:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759852905; x=1760457705; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vIKhzvptts89Sbix0kNSsLk9FsLBPvSNCFN51YR9CMM=;
        b=aKKOCpsXYF9MBzm9tofaf8KFNiRxZ++vYVOr1T19IFwHKd91h1BlH3WS6BdMBQp4Zm
         lq+Tmc3L0QK9pBPk7sxmadsUuXEKCHD23LjSNZMMXPxs8Ej/EUnhX49P7l4YmzcLg1U4
         EqDwjM6y4FsIBjL009CGNI344f/jbhscY0IOwdiZn00VlJWoqplQppkNctbsuzcGnUIJ
         OeNbtH3as5/zWChNfSh8YW3N7gJml2tjq54SGCwqzEHouaieupKOfl6eLyygiSeuB0Ph
         opb9pU/YkAMsm76+zuBubJi/KgTynwZ9vYmHGtgvH0ByUSSW6NoVun0E1niZoTZHTGvD
         TPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759852905; x=1760457705;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIKhzvptts89Sbix0kNSsLk9FsLBPvSNCFN51YR9CMM=;
        b=bgzKaTfeoxwAnFGcA+vFncwTQoTlNNITdKWQ/KRaoA+LQ0LNNp/o2VAJOQce++QO5c
         ft66+hIHahla9iD1chkwiaWcG+b8abSaf6noimB+HYnyNMWIHxW123t9ZkYNSejIbaUf
         CvhP+jNtpqVm1gMHIyrPSoU75pQ6JG7lxdzaCYre8lgpO4xiwjLn+5FADEUro4mbXVfF
         88mICy+Z1LURadaNsVNuhOoWxWl/dNlYaXMGimtL7n4t448PakqqJWqMRUMXIJ4Ff4GZ
         Oy0GKhksrYI7DEeshbRLgYvJZDFOzKvS3QWAq9ZMhlog2wSv7fkJe1fQnLBeFIsnvFEu
         l8jg==
X-Forwarded-Encrypted: i=1; AJvYcCV0JLrAN2SJzxI6CCJ0yXgyfJaDDpm0cEy8o6vwQCO4ZRpPR16wkeUM0JEfSzdhvRV2Hj41NxEr/w3oGdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS+bTTGhx6vNQ+WCD2vp8pVFi+eCEzTAzSFBQ1noIuXS0wWxb+
	/jK3vBNfJdf5yUiT5mchF8DExVSABhd6ABNaY2zSQAiLkF3yMVXRKPzJT2y0JukIFJ8=
X-Gm-Gg: ASbGnctETojBpdb5kh9gVO+Jjsk8lbWmezqqERuIJK0LVykjFcCA+Hj78RYIB77iiUI
	XVgYfMi2weiLAvsiXKIh9RuMEibAy5TarDot7ke8NZLpSQDYrXsnUZPJj5hHm0O2AXXfZo1Frpq
	PXU/6zP2k5odOujg9qjFaj5iM4oL1MHvnp7JYdDNBP9b2FtOEYh1e8UqH1HjhUYGNLcO2qIiO8X
	/mWtX0bV9cpp/qwyTx7SUdTafSn26kC9n22mXuC3VtpRz0lL4wIxZGIAqgk1CslYzAi1rMWqQfD
	yiaKYNAd/7CTYePW7TJcoL8DyaB+4HNV7qEROaxhLT31ktmvlupjL0SVF7YMin7t2KL7uflPWg9
	aqzhSTPFXz0XBpJXvtu1EKMS8LsI5vO3ls2P+n9ZbUHYTyYx5njfaK+euuJZuDEYjUaad9d9y45
	bI0RKC/eVaBadoRoT16GE6E6TmaRGL041CZKsdqkdlM2Oej7K6Ln0=
X-Google-Smtp-Source: AGHT+IGf9IQ2wpi7EPhCeaXvA4php2sl46FSyFnA7c6eHrUoUGEvZyyl6soc6Yh6K+i89mmku9HqRQ==
X-Received: by 2002:a17:907:7f0d:b0:b2b:c145:ab9a with SMTP id a640c23a62f3a-b50acd2b3c8mr14811566b.60.1759852905201;
        Tue, 07 Oct 2025 09:01:45 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a60dsm1402129266b.63.2025.10.07.09.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 09:01:44 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 07 Oct 2025 17:01:44 +0100
Subject: [PATCH] dt-bindings: phy: samsung,ufs-phy: add power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-v1-1-d9030d14af59@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGc55WgC/yXNQQ6CMBBA0auQWTtJKSEKVzEuCp2WWTBtOoIaw
 t1tdPk2/x+gVJgUxuaAQjsrJ6loLw3Mi5NIyL4arLF9a8wVc3pRQZ9Wx6LonzixeJaomJcPqlt
 1k4hb+DvMNPRkyVF3g9rMhQK/f7/74zy/0CuPoX8AAAA=
X-Change-ID: 20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-fce95e2eae38
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The UFS phy can be part of a power domain, so we need to allow the
relevant property 'power-domains'.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
index d70ffeb6e824bfc19668e0f678276acd879a6217..2b20c0a5e5094889eb3e80dcc21b505943c68523 100644
--- a/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/samsung,ufs-phy.yaml
@@ -36,6 +36,9 @@ properties:
     minItems: 1
     maxItems: 4
 
+  power-domains:
+    maxItems: 1
+
   samsung,pmu-syscon:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     maxItems: 1

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251007-power-domains-dt-bindings-phy-samsung-ufs-phy-fce95e2eae38

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


