Return-Path: <linux-kernel+bounces-826301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B0B8E23C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 19:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0C3440350
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 17:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C168D273D75;
	Sun, 21 Sep 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EAj+dlII"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8727C27057B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758476044; cv=none; b=dgS9JOEp/rogHqPrepenZeslIiFUM1A3goi/LPoszDC8gb20SS5L/OkADLsxZpzIpiaxnaIcXRXaLxsNjjisRTjZOvU1FX+1JZTPCWgSioUXBVN/qiLnn2hrXI8+X7H8H4Q/kh5lNu6eMo6YkVOARRGpM9g5rjrBHAepX3ba4Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758476044; c=relaxed/simple;
	bh=U5rpBoUei7B3mGSsrABizF4eMV2IFAukcd+gEXdncFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GY4XGU3OgVafS6VUmsHqxfR7PBE5dD1vu3qL2trDl5Im4KE7NKGaZS4rv4Plhj3lUjbVau+YUtCbpXs8AZTH3E9+5PziG9j3cEZuYNCbwqEdAMHWARvniM2Nv9LEVHHopsvBsx9+Ev3Y59Le6BEL8Nko4zmrQTONm+rcv3BE9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=EAj+dlII; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b0418f6fc27so629543266b.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758476040; x=1759080840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzJWTSZGsWBx3i24RVD3dVzdxwVQmNlRx6nunjK1UCs=;
        b=EAj+dlIIBTB9kaQOcBw7UV47CTJ83QUI5B/zZ0Ah2mer3qenpabJ2+YN2SA4xOASag
         QJxL4ycyRwpCjP3UVrmy3983wE6erOMJNponKLEaXL+2yF8jo+WqWYcVTKi/q8GpyNcn
         SmQ/OMw1E6bLCQitVI+B7YIaCYv4YfXYzPdzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758476040; x=1759080840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzJWTSZGsWBx3i24RVD3dVzdxwVQmNlRx6nunjK1UCs=;
        b=X7NzuxyOpwvdzkeVyjq5/Fv9XC5TQ+nkRXn6i/rjAJJjh3RzCDziaSQhFgJDgLv9nz
         0xKrS8bPXQWFbWSwfCJkifhoBMUi5i9c4bwMN/0+tgeoU1hVRq11K/pquSooKi8lMsy9
         av838vBoNqAA1G0GdPGRaTPnAml1cM8zapAGy99dk5MeWJdCmmzfap1aoZYQE52z7Twt
         mKpHpewgCiKuR9+PmLbHEPFx+/b5lAz5rvJVgvNx/EgCYTfNmcLdB71SefFArRSSIbBt
         8PtAyGlCj3bnhCADymetyRSJrleKjNVjKK8KcsGK5wqBt9X7NzLtyyilv2HEQ/H5pMXN
         xhmg==
X-Gm-Message-State: AOJu0Yw2FbvUTtSlMt4vpP1ND+GiseSHujluWD47Sb/oCU8O2k6u9OzJ
	iJ/E7jFZPf7TLpY8ni623F/PrjZ1P2sxHHFVPNdPUHI5aqEu8kH+tHfEC3/6raj3/dyHXgQwZ9H
	h4ing
X-Gm-Gg: ASbGncu4mfkiHgeIgBzLM29aIs9DMemuB0ENxqV+U+LMW82gPMH9XbY7RO79ij3bs4n
	ZyhKaXkbH3xQvMmUdudjKghTyWH/6aHyWxYxf6wX430ar+aOP6XZ7z17tc00YnXqyS1CkNDStkM
	yE87iMukE51IDfhCHLF/KLeUOcR9/8eZM8OMl7k7NkNv57ncNvM2GnUZ4XggZXBK2yg/8lK9KCG
	7dCRPqF1d92mHp6HeBF9cy4cr7eetJxxBDaJ9U+Q7lkRti4ZH+uo6pc7a+ACLYI3vZFFgcVBjEB
	KY0OD2HfT18WBXLWfECz2w/fhfejgwvxE8MXEMaTWK29z9DgtTQwj2KcccBUoDx+hMgfbGYcAbv
	Ewui7y+s4nK/7LNb5v1W6Z+ST70cgER0PS4TCCBi8q2Qd6R3P569ZehqEc1FVM3mdPEWE7TNFA5
	JXzpFhmzqVky8o6JOmSoWcDzx58sl7I5ciqjZmjjCb8WscVZ2ty/1rZBpGTUl8j4Lj
X-Google-Smtp-Source: AGHT+IGz0pd6yisb8PdKwdoXAN1/izzqJHKajxmZxcXhsHPhM86fjHeHGd4HkEVtbFTY3+U0FGA7cw==
X-Received: by 2002:a17:907:3d94:b0:b2c:fa32:51d4 with SMTP id a640c23a62f3a-b2cfa41a17fmr31404666b.3.1758476039775;
        Sun, 21 Sep 2025 10:33:59 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2928cd31a6sm324347266b.102.2025.09.21.10.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 10:33:59 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	sebastian.reichel@collabora.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v6 3/3] dt-bindings: touchscreen: remove touchscreen.txt
Date: Sun, 21 Sep 2025 19:33:44 +0200
Message-ID: <20250921173353.2641438-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>
References: <20250921173353.2641438-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 1d6204e2f51f ("dt-bindings: touchscreen: Add touchscreen
schema") touchscreen.txt is no longer needed, and since no other file
refers to it, it can be safely removed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>

---

Changes in v6:
- Put deprecated the properties added for the eeti,exc3000-i2c.
- Drop the example for the eeti,exc3000-i2c.

Changes in v5:
- Drop patches:
  - v4 1/5 dt-bindings: touchscreen: convert bu21013 bindings to json schema
  - v4 4/5 dt-bindings: touchscreen: convert zet6223 bindings to json schema
  because accepted

Changes in v4:
- For rohm,bu21013 bindings:
  - Drop description from reset-gpios
  - Simplify description of avdd-supply
  - Rename bu21013.yaml to rohm,bu21013.yaml
  - Add Reviewed-by tag of Krzysztof Kozlowski
- For zeitec,zet6223
  - Drop "Phandle to the" from vio-supply and vcc-supply dscription
  - Rename zet6223.yaml to zeitec,zet6223.yaml

Changes in v2:
- Update the commit message
- Add Acked-by tag of Rob Herring
- Add patches:
  - 1/5 dt-bindings: touchscreen: convert bu21013 bindings to json schema
  - 2/5 dt-bindings: touchscreen: convert eeti bindings to json schema
  - 3/5 dt-bindings: touchscreen: convert raspberrypi,firmware-ts bindings
    to json schema
  - 4/5 dt-bindings: touchscreen: convert zet6223 bindings to json schema

 .../devicetree/bindings/input/touchscreen/touchscreen.txt        | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt b/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
deleted file mode 100644
index e1adb902d503..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
+++ /dev/null
@@ -1 +0,0 @@
-See touchscreen.yaml
-- 
2.43.0

base-commit: f975f08c2e899ae2484407d7bba6bb7f8b6d9d40
branch: drop-touchscreen.txt

