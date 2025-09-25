Return-Path: <linux-kernel+bounces-832790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A761EBA0586
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E2DA7BCFD9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604632E7F06;
	Thu, 25 Sep 2025 15:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="EZwPqDhk"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C522FB974
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814315; cv=none; b=KZpTSjZrYrL/Dr8LUFZ+2hZ0njziVxJ+kFd/vLv4DUnHD2Zg58+Cm/m+I4FsD3tAMfKE/to0Tm89ku6ok8QioP//7yDHQS091KmH/sV/f85sV+nBkbADekZuMmK+is/rHvflG/wc2Xlcf6ZJgTBgJugYfZ4Cusq7AZExfVHrzm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814315; c=relaxed/simple;
	bh=q5aG2S5mYUlLQBqwqhP3YXxDUhZ1opyJOZ1oXoGgGA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUMFuIry6iaVrGX2Xl3Ffdg8vtPQ6nEih43Dq8gl61LOqu72BHQaKzFVsffG3wI2tWlu/FJu83jC90mhTq7njZv3cEsEX0+QSjfQiMr5zb8jBSf7aBOOmp1jMOEMejbmnCx2+ImTyDEB0tFB5bWBQ1RptydRvk2A3qHGjtBTKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=EZwPqDhk; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3727611c1bso46672466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758814312; x=1759419112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j6NXz/L1rjCXicECUckXAuwnbrEJeLUM7GD37RWm6Y=;
        b=EZwPqDhkxKEgMdXteaQFYfQ39dcFnn9f10C0sbwID+CyI1D1xza5k+ooeaMQ8+aJjd
         f1RXYXD/R61lhHVKErdXdJlBdQZKS0mb6fH/KobxM5nbOYwIz7oDL16bgkXiEs2P//V1
         cZ3HZ17jx6NK9Sm/kDsbIFrbh8g9CbX+v5GAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758814312; x=1759419112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2j6NXz/L1rjCXicECUckXAuwnbrEJeLUM7GD37RWm6Y=;
        b=STTS+AR0fsG7Hgfks86qWxOSEuZ5JSlb9wnlVDkavC7CDNi3mXkwi5Q9dJH22nljI7
         nn9+CnqMt4+e/Mxx0Zv3ZNX197++roO7A+12Mmf8tJ0hq2wP9CNLe93e4BVThtB64lbR
         QbS/rpDxNIZNv/Ihv9iu7lXJKnKtLCGiVQGop75DouSad0IDIntKbjR4EPpVv4dY5/Gb
         i4u/zSUEwchwVdjuvnx5XSfV6/7Vcq+p2Kg991B4hiXdcOMZ0noRwa8Ng1R0jqz/atgT
         ERq9LULxp42dy312k0K9QBPa4UAJmHbm7I1Eblngr2XBvsVpMAt5W+5v7dO/K0P0gIZc
         S6MA==
X-Gm-Message-State: AOJu0Yxi6nmTeEcPK38xrjEQIBDmeMwcWZUr3HIRXSjl23bdQUpnQmfH
	KPNCpFdXeyrCvNaqcdi5hIfJfHXKmJHPyMqL70i0F4+g2UGl7XSMjs2q51wRj5FQ+8gIePqbuCh
	GexMWdHQ=
X-Gm-Gg: ASbGncv5GBdxGQGXuq7W+Y9CSnUMuibaBlQENG+zllDgtC7iYHXyK8414/DOOMIs7Rq
	rC3Bp0VtmgMDB22ts5v/6WS80ZK4MugkaS5PBL22TRSGuxy3EDRWiZgsiRa/ZwFhlZ7V4DGbXDc
	1Zb98bavRv6gKU4Wu4y8brd8tSJXcg6EvIWhSt6p3IJEVg9UWa1wBxcuCMfbG+5J4juDdUpl0Ub
	KqjZwFhu5CVFoBZcqNCm+tfsLsIuW1SEoBA9o27oMNKLWoMDMhFXoWorVCJFlloX96EgynI+F1F
	devDh2v39CIt3zWBCvWQWiNWeTBy55BMWjd5ecfT/TZsDWIeMgg9QsHOL55zk9kKJ5R/EdQm6RG
	Z/gERzvbMLBoNgajXCseZN9y0yGfkbyrufHZWLMj7OnhGiNybsTaEu0TB345bfWhu2XUv1uj+5s
	qgY5FNERzIeL1j9Ngd1Wmc0ebXiChaPHI8PX1iohdWBkyfc43LEIdKk03oitnrNZYb
X-Google-Smtp-Source: AGHT+IE6hFumdlcUjZ/00Iv3aIuLUT9mICMj6k5jLi1LoqQpjx/Mu7By43eLrCshvtCsZpoRqZOBQQ==
X-Received: by 2002:a17:906:6a07:b0:b04:20c0:b1f9 with SMTP id a640c23a62f3a-b34bb50f700mr453534566b.52.1758814312116;
        Thu, 25 Sep 2025 08:31:52 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b36f410e129sm43924766b.89.2025.09.25.08.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 08:31:51 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: sebastian.reichel@collabora.com,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [linux-next PATCH v8 3/3] dt-bindings: touchscreen: remove touchscreen.txt
Date: Thu, 25 Sep 2025 17:31:35 +0200
Message-ID: <20250925153144.4082786-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250925153144.4082786-1-dario.binacchi@amarulasolutions.com>
References: <20250925153144.4082786-1-dario.binacchi@amarulasolutions.com>
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

Changes in v8:
- fix conflicts on eeti,exc3000.yaml after rebasing the first patch of
  the series on linux-next where the patch "dt-bindings: input: exc3000:
  move eeti,egalax_ts from egalax-ts.txt to eeti,exc3000.yaml" has been
  merged.

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

base-commit: b5a4da2c459f79a2c87c867398f1c0c315779781
branch: drop-touchscreen

