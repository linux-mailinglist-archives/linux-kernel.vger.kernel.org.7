Return-Path: <linux-kernel+bounces-815879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2D2B56C3B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 22:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808093BBA89
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2742E8B95;
	Sun, 14 Sep 2025 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="AUEv+5RM"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BA22E8892
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757882316; cv=none; b=PjwcJJJPFXotankYfhuDBt7ZW3RfKxwG9LaMCUIeq+UWyG224m13yOXn94adZo76lII2fW5IhgVS+xIbS5zZuUsEtqAqwtQAUbryY5R1fAGBdITdaPVw7Ebuh9AgryMgfrnaFqKDRvfbaNvReKZN/wnry70zcHrpThMagaIaMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757882316; c=relaxed/simple;
	bh=/oqsdERk1dOnIz7pgCq78P2/eMnzdLETqpsc7c8e0Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbslFGAPiU4BUuhdkJRMu/ue/uCwPcSywaRFmMccQcjdpAQxWRzH6BT0XdIBY06ZarTwVzPhir9egDDhAuXzitO0wVNAUKiOC4FmpVUGVJNafLP3XIBnsZUNfAo0vxHpjzQ7AxyS352Q8lSSgm3TNw7pk+CssCG17mTe3PQTWyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=AUEv+5RM; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f277546abso1542361a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757882313; x=1758487113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRNP/ea+IMU+WtlCpH1FQlK5+aG3ehZbfYI0GGMGE9E=;
        b=AUEv+5RMQRhL0H3Xl4vvaCxpsYA97T0AUZxLK2E3rtq/Vmz+qWJ5G3w6mBAalpePcx
         3mOozxtcmp71efraIK1sebaI1Xb6GeMQV8Ra6b0h+ZYJycIE+bNGiHyCNMtf1wWCek5c
         utnz3Znd8hOSnx8/jnmC1g04rC/ow/YgPKHHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757882313; x=1758487113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRNP/ea+IMU+WtlCpH1FQlK5+aG3ehZbfYI0GGMGE9E=;
        b=uT7nInc5sckHIZ7RDnbzAlEwk0ofXzqZ5oRosY6KqpVd2Ky6HQ1tgN51YAiLYeEy25
         0wEwR55gz0gLMtXvMKCQZbSRBNhX1Ejb4SIbDMKhFn58RYG3Dn2XVh+mwet02wQ+yFon
         j5fV/UXnCU19mO2A2aBNoIYDulsvSYb/uAllQ47AoVx2JDfhhzV7j4ja36ZC1D03t1Lu
         A5a5te7DNewHTrAwQw7hZ1v2VMTNwNH/dHuvY6IpYnPRBBTlTyIMnmRzfFTv5NTZ6ZO1
         7Tyg+SnX60Oza33ffrq1wwLeCk8+HKI+H8vwjRXBYrdv/4dTbUFcx5RyClkVzCOAEU2D
         EWhQ==
X-Gm-Message-State: AOJu0Ywa2sVB6ILjqvQ3MEchR0E+gXSzcyLxnKn+vmqmbnmvshLW5C8c
	adjphizI9k0D7VLvI9hVEFrEhILHG7Vre4pZP15qSVRHNLq9lVHO8hYyOxwKkmeP2k26TarHCw4
	yw6Vb
X-Gm-Gg: ASbGncuRXVDTI7XuEfvEb+AfHaxEhnLhhzmURAyf2ustlNJhp4GN1ylh7O9LLhqCoi4
	PH1GFEv5bGPRwQWHEFT/eNAlPORwx9rRaX0KCogsyhCYw7cOj5+TlvbcqNaPsa7G7lfMYHFXyQp
	T2lpiKvJWnLtE1c+PZoM3wWsX5klPDZ7dJc1Ea8kh6Sx0Du9BQFBPup4YJ1m7dDDmE4XofmyIwg
	qt872KHvJ6XdcIvUm6zN7IAlU78mxzikbV7zN7qTGXKCYT0huxqQwIFvFnVn7OBri2m0+8bfGBE
	J0sip1gXuIbFc7GtVgbMBeiMyNWfYYLauo8p8DRdnH/J5LGvLAMiibMOZn7rnTWHnuVM4jn5s40
	wplNVmWW/s8Bf0ryl/4gO7WQsKE+IGBcNOG+zDexI6aw2KbZrprlfqc/nxSGy7AeJJh9XqLG2h1
	zvheb1konXRnBYPeHR28rKDbzpKRyPFReyzXVJxMXxmjfV9HR2nBlNURvFulQw+kzOSot7kcHHO
	jw=
X-Google-Smtp-Source: AGHT+IFmx1iKDCMnVdGgKnBLwcjUK2UHcFgx/Uomcucd/BtDSvIuEp4t1zmwRoy2VyM0EaarmQA9Uw==
X-Received: by 2002:a05:6402:2348:b0:620:d826:b4c9 with SMTP id 4fb4d7f45d1cf-62ed69ab473mr9494870a12.0.1757882312803;
        Sun, 14 Sep 2025 13:38:32 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec33ad242sm7803739a12.17.2025.09.14.13.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 13:38:31 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v3 5/5] dt-bindings: touchscreen: remove touchscreen.txt
Date: Sun, 14 Sep 2025 22:37:56 +0200
Message-ID: <20250914203812.1055696-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914203812.1055696-1-dario.binacchi@amarulasolutions.com>
References: <20250914203812.1055696-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v2)

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

base-commit: df86f912b45c20e236060321c85fe35437e9325d
branch: drop-touchscreen.txt

