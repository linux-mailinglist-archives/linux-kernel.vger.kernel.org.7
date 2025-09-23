Return-Path: <linux-kernel+bounces-828944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404FB95E89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F31E18A4365
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26F0324B32;
	Tue, 23 Sep 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="js1XnGgq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A563233E3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632272; cv=none; b=CVDtvip7kRaiV1ld+pRQjR6Eymdt3IovYdKBXt+BjvFO7jdj/Dx2O8/fzj4NcxWgZ0/PMHl11Wqzm3evapJBRjcxw6/VD8dwmChyMZdgneXcb4QsIZ8IDoGujY9Ft7AWOk6cPgdqBgOpORlZxLO1m4vOM1ZdaDxRyGIaQkLnI14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632272; c=relaxed/simple;
	bh=2OimLc4Q0N4DdlXJSrIcFQzy1fFQeu0NoYdwgFDUiXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUIP+vB1kJSFWSBafW/FaimVPRedie7eKPKIa1Rdq3roLiiW93/2r598sxjDMSyLyD3P/vxXkD19NoqUIiAhrkLKT92QqUp7Vd2Bw7rIOZQK4ESb8ydyBhtDAdBZlXxLvyqf+5ggnD7L4yJW4iY9hG3civQyDy+onTUTi1x1R20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=js1XnGgq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso5506722a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758632268; x=1759237068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBAyBOapRa+Zm3M5mNo1qzi+GFdGcs+c3cJBwbllCjo=;
        b=js1XnGgqPKYj3Gpp1/XPAMXcZ2L3pjn8vQ2NCGcY3M+j8oyx0dcbKdWCDMELoyn2JR
         jAXfYdjEMEHkIc5Fk78I7TuRoZ5vxVcZTShSjKCFMR71TbE1VDXWOtkDtTUkTMEEo0bH
         yZNlFQjpz/PRLXaZo8Uo/cMHJOpygXX8eO5Qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758632268; x=1759237068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBAyBOapRa+Zm3M5mNo1qzi+GFdGcs+c3cJBwbllCjo=;
        b=tKGu8mpw7hPk3LLoIgXK8RQnepLh3fJmvsSykRy2fcl5ayAguy3GQ3gEvGDImsJYAn
         C0bRqPJftTqdaLl6wOz00WabjhPwRGtfaJbD9dRH6ql01GzSRLaXai4uVEH0hfwDvnmI
         e9Y2xQpONTdrIMfhqTwbD8sjmUZvQXnpnywbdY3zG7hFQlAhBeSqSOF1i6dB3jujaf6Q
         QEBGzcJKK1swRpzRXjEJ5P/wJt78FyMqZhEvHuK7Ac5Biw4CBpjqYv1V3mrasjYaiuP1
         L2mMmkis0zR9ONG7oDIvu6m8c8vFVwcOCyTRjGzAAACz9AzgjLBBJQ/sioyTKQxlMs6A
         TZbQ==
X-Gm-Message-State: AOJu0YzExpMPie2CftlnURorVzD/ZAnILvzymhLbQkS/qQcppX8B9L2d
	d1KavQmQLG/f6xmIeho8QIQds+z6O2+biMDkXXr3dUGtGTRjs23jzYESFmQbzHRwFtzjeBZn/zO
	JdYl2
X-Gm-Gg: ASbGncvT02vAAjSRWiFrmd10uyEDlmgNQhYXa/dpll93ZBO+uPK6vvhB+Dxb3Bjvajd
	Uxmmn0KyE+Xw7rKe3070EMBdPuIav7uOvBKMWs7k3lwGQIXoEdJMEvGKVHQboyUlNODxf6eWhAZ
	J6kStBXK2Ujh3kFUlJiL3V3jVnbudll272zWVWcFQcmrVtVqGBlqTdRNRFgM7AW7UyEdLzq0pK8
	8Wus87afVYnNH14TMM6i6WKckue11fMd2Z4ZzXn+BNf6z0RR4xOPu6wHszAle5RiuHfeeveBl2B
	W1dDmUG0kVAiMm2Lg9niJanIKRcvxOkqCWWF6St8DEJTpLYDrlN/eC3tR6oNLC8YAFBzKCCJpWM
	FXAGRv0WR8pc+cVsCJUub5fdU+BOMFfHYyxOxjFAqIs+6BDE3dhaspehTv5vhJUijwWukjJKH6f
	fctq/DRugkKHzxBR0bupGpUah0wDpq4CUB18pRNVP+FmXKdcwvuur1pxZxrH4ZZjm7
X-Google-Smtp-Source: AGHT+IGkBo7ePlcrBjyjhfPlFj8UyoEuC0eBBzad91WGQ9VxfKcKUAhYdekOMr1X/VM1lHEw1ZgcJw==
X-Received: by 2002:a17:907:7f1a:b0:b04:9acf:46cd with SMTP id a640c23a62f3a-b302b50c259mr217771366b.42.1758632268538;
        Tue, 23 Sep 2025 05:57:48 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2761cb532esm872331166b.67.2025.09.23.05.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 05:57:48 -0700 (PDT)
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
Subject: [PATCH v7 3/3] dt-bindings: touchscreen: remove touchscreen.txt
Date: Tue, 23 Sep 2025 14:57:12 +0200
Message-ID: <20250923125741.2705551-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923125741.2705551-1-dario.binacchi@amarulasolutions.com>
References: <20250923125741.2705551-1-dario.binacchi@amarulasolutions.com>
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

Changes in v7:
- Add Reviewed-by tag of Rob Herring for eeti,exc3000.yaml
- Add $ref: /schemas/input/touchscreen/touchscreen.yaml# to
  raspberrypi,bcm2835-firmware.yaml.

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

base-commit: cec1e6e5d1ab33403b809f79cd20d6aff124ccfe
branch: drop-touchscreen.txt

