Return-Path: <linux-kernel+bounces-736537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D65B09E40
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A0516F0DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B07295502;
	Fri, 18 Jul 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="UFf9n5XH"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9882951BD
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752828271; cv=none; b=PrcxJgS8+aclAfmAbsdy+TkkCDfuLTkfxIVrMKxHWxHwPmruhQuIF4oL0c2yGrPVlL+UTYyjsp0Zn/GZrKJG8lGBDmwmgzjf6ZLCfHvZIZZ6vT3FEW38RoUnLjJhzKpfoNXWnh+0DCiP45hzPDRWCuwX1jN0Jj3E3ng/d3jYtew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752828271; c=relaxed/simple;
	bh=Uoj/2NsPxaTTI2japwMQ43nh93mfeyzRyN0+brvXZjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpLp/KntKjFhFpjY4+i+a6kX9CHJjewxOXUTvATkDH83T8LGaPsOcBRlurJs+L8MJvEEUfNN33wWC0si+QLnBuKwAZEFWhO31XzBdPZfzQ1wuDlg+yGuPL4b7mIGCEbABiwwVYckdRW1BdoC08OIhz5juJEyifovITYHMSXCYh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=UFf9n5XH; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so1297899f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1752828267; x=1753433067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIjJ267yEtDnmiN+Y1fTBADY4HhOVJqHNJYRhatCK9Q=;
        b=UFf9n5XH8neSI0tY48Ff6SvIsl76S1yy9e1XB26c8f4cL+pGv80VKgWqjq1kMTGU2i
         J53XnZN5+rXGnyg0qNHtoe/aVDHdiv5BeWhkfS8cPLfm0BAVrvGKMfs/ppNXLP26ucBp
         w/gdJNSIrQXD0bEZtDWymDATPjmJ0a/GPtXCIkzBGq1nfk+SqU9gnEwjEPZoyacpfMCK
         rA+jSETsU2aN2wWL/UT0QeMx1we/lIarqk7fd9QeirHyAG3W2GueZOJaD+L/H2bLQOej
         3pwamZt9g97j8xBTj5WOPM9iXVv4EY4UtrYhdzBCR6WTTE7HyatpmzJd+XkOUVx30Te8
         8ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752828267; x=1753433067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jIjJ267yEtDnmiN+Y1fTBADY4HhOVJqHNJYRhatCK9Q=;
        b=A8tGlDWRBq9wKwQ9QWqEnEg9KySYY5Ycn1S9sdxLK2iKKE1gHhr1pJolpoqkSFvt8V
         TiU9GRpzsOhZxgE5W1+TG4olG526hfZV6xSMqLUXtT83sVKhK72rkqskyAP9rCDPd8pA
         7nDlOQku5POwMTJgSG6c3+wZ91XY2iPmgAfjk6xTn8IP+ewIuVml1LltZGDDqmyG+ACS
         XfLvev3J/aWaQsH7z48bmzX0ub88poqev8+OkJxoXzMa+CUDAakvT20DUKnedNAkBbPn
         7KdV0hUDGv3pmdGQrOprk4ZTwJkbC856FoGofkwd91czxLZ4HmroAlw+DxRxuid+A2F0
         4EsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrI9eVorMJ5b+cae914VmKxaK4R26q/yE7ZmVFGkSATIPd/nTqEm04cUG2wsRyz9h3VVNTGL0nO8I3xDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlBeBQ6rMU8PSyAKQfyE3WRItyzXYneXjiBa4LjiQgAuIw2uqu
	3ozp50C5qPf9S+OZoLGjNuIUUxucm75Rn980mbjb7ubDHkeBpvFllILU9bCwkgAEH84=
X-Gm-Gg: ASbGncv42YV+4s/M0vAVYQjqw/iytc2CjTU4vQ0o9cGoJVqtfi1gEowgFkZDmI8Nlae
	g2pBj/coZWlwTS7SYJjoFnGY/3BAKvsU3giR/Y2JzAlCB7b2OAZ6aCUC0l0D2GJjV2pH70P0RaC
	m7bBBN4PS3CsJs/uIrgxB9yfz85MtOc/d65B7jtnyvhJ/De4hqfcfa5vYFl2Z4x7rBBummhzM42
	kBrNpN2sRTE2WOFRvyin2MNx/jOerTqosPir9RrkZO4/ANCXT+kzcabSa1n4OZO3vDsxQOObGxM
	4VqhBKVucqUsQz2p/rDRuqVuUug7Meks3qOGfLkasU4XGBuTwLKe+BBOb/R3awMM7nFB1c/mYoy
	WEyln5dLToH3u7yhqIGpFv7LLyTbKwWcG6pzidq6ovmDJmrSa
X-Google-Smtp-Source: AGHT+IHMJeUs8RlmFkrQ9WTk0wqJZT629erQHVUIzMmI6akez7WS0GHbIEYfQ+fiZr6Q6Fy6PniGIg==
X-Received: by 2002:a05:6000:2385:b0:3a4:dd8e:e16d with SMTP id ffacd0b85a97d-3b60e4c2194mr8115453f8f.15.1752828267262;
        Fri, 18 Jul 2025 01:44:27 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:9aa9:dd5c:bad6:e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627962384sm58208115e9.2.2025.07.18.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 01:44:26 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	palmer@dabbelt.com
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v2 1/2] dt-bindings: riscv: spacemit: Add OrangePi RV2 board
Date: Fri, 18 Jul 2025 10:43:38 +0200
Message-ID: <20250718084339.471449-2-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
References: <20250718084339.471449-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the compatible string for the OrangePi RV2 board [1], which
is marketed as using the Ky X1 SoC but is in fact identical to
the SpacemiT K1 SoC [2].

Link: http://www.orangepi.org/html/hardWare/computerAndMicrocontrollers/details/Orange-Pi-RV2.html [1]
Link: https://www.spacemit.com/en/key-stone-k1 [2]
Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
v2: No changes.
---
 Documentation/devicetree/bindings/riscv/spacemit.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/spacemit.yaml b/Documentation/devicetree/bindings/riscv/spacemit.yaml
index 077b94f10dca..c56b62a6299a 100644
--- a/Documentation/devicetree/bindings/riscv/spacemit.yaml
+++ b/Documentation/devicetree/bindings/riscv/spacemit.yaml
@@ -22,6 +22,7 @@ properties:
           - enum:
               - bananapi,bpi-f3
               - milkv,jupiter
+              - xunlong,orangepi-rv2
           - const: spacemit,k1
 
 additionalProperties: true
-- 
2.43.0


