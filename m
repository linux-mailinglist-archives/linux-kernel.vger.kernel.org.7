Return-Path: <linux-kernel+bounces-834888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE41BA5C44
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF33D4C5CF7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56FD2D24B6;
	Sat, 27 Sep 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcOazuQw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6344A21
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758965007; cv=none; b=YxBmCo4j6/gcJEtM2Ar8lkEh9zgfQd3eNZgXrjWD7qMVs5tlRvCSGnNYN3TlAVB5mPk85xtSjilRGIn/lJLWgwiIirE5KgIJxK9qnltxxACC43RxS8Xlz+mCO0EuhS0mrRx14Swkfeh+VZXIFS/L0qS590bmc3BAM1G9i62avbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758965007; c=relaxed/simple;
	bh=qfPC36RWeFkTRxSHCfQbvdtHmIQoElMVTPi7vaMRZH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XO5OPik0exrAcGn7WIFWsgad6kT056PfsYXQ+SiPYUTfNaxuOueFFUKdqt5WB9O3f00G1bkehbKfrN4hzrLaJCMx4+JkOq55/xoG/oJn47I/iS2B5t1Oy1lIhrLhYW0SZvs/vt4Q2JjUtObFm5TuUMt341h+1KN/lAtps8R4puY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcOazuQw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b556284db11so2932128a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 02:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758965005; x=1759569805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+B9+WNcUf/SiLJEas3IyGzNh/XuKBSyoIl4DxHdrSg=;
        b=QcOazuQw+CI07sTxIvdy0ZegH+VWwwzFpWg+i0ii6goCmt9PsG1iUcd2WkMM9r9q2L
         9rQg93B3CBsfEE9JPmWQ2epK2GDhvPyr1v6xY5yQrdWoyuORK7G2cb48fVkVnsQcJ9WI
         c4ZIXGM36wYeWvxe9Pb/69d+cEWEJA1FsDsyzcxkglUqr9xSLSJ++hNM8PPxXHMO0qGv
         /JjgV+CJ9clgovRx/yqUFQyrnCeWzBEQXv+f6hh68jaCLt6H37QCWobXliOF98V4gXmm
         xuCsEbJCrHDzfq8ats6rUA9Dt2UupO/uU2j3gGjXQ+NWmTjbP3tWtwfK6X0mHpPuntvf
         0glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758965005; x=1759569805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+B9+WNcUf/SiLJEas3IyGzNh/XuKBSyoIl4DxHdrSg=;
        b=v/CZyOATwrMxvnOAh8ipCc4Ryd/8pFFopm1WxN95JL57cMPURXfAZwhfw9ZFF6Us3y
         cImy5bq+IR51o/79Se0o6Wsk86bpG1oxjU5UnbPFvIHaIU/mvsd81vxdB3lgiMx0yIwY
         6pyl1BykHt/uAynkgv0SOcbLVyGopSkL7nYlYTPWrrwQilOe9OxlAgeP9W1HfpeIi/8/
         AMYwaD7MyzsjhBsf+yV00fiKAqQbV2dqFOc5fXf3iPM7VmNRYL53OkAGQ8JThzCNb1j1
         woL+BKlL+91VNC1TO6cuC8ZfUL0Dohc2aRo8qe6Gr6AcYzNb97OdfS0kjqHBmNIzY6is
         0n8g==
X-Forwarded-Encrypted: i=1; AJvYcCUOI6cm57QyY1IOMQ0LciBgtUmMiY66FGIvP1+oRFBb7jhyWibljZx1pklna0itC7AqoEFQZSxdA7u1k0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg/KKejcUydhZtscWud64ix6gGdI9kZil7AgcGwnKbINMoGQKU
	TUeu5aIoKPmX3Y8E9lOt45jQd4Oa+ogYluNKvgR1WRCSybYzRYKi2fHq
X-Gm-Gg: ASbGncuaQij4RwsCivp00TAOLLpNGJB4ZLA5lzbvph6HFYBRNtJ/lSoZFjwX7au6IYp
	1gM8e1FJ0geWB3ao2MVCNjHBiI6d/pq/tI8z4NOHBw9X7j1v8H1EFPtYLU8K2x0iJdn26FTn5uK
	AULmLfTa6fU52bdcmRiEw/OQtdnCc3JkUzcmd40EuzOpU2dVHm+ECvaX4ZKu0B3/cwnwqnH9JKh
	hkeS6kPxRulC/KXbXUpNnLOX57I70tZJ05ZUfbt0kFwXJSpqhitL/RA9IeVQmO1bI4z7fzHxjyk
	m5qIIXDuqIr8l1rcpLbYXYjOypC7+M/Me5g4fva/lSB2olBmGmgxcwzhgaleWq/r+xbw3Vkw6VB
	7/mwkThhpFg==
X-Google-Smtp-Source: AGHT+IHMb2zeZCzMkFx8yBXTWRgBTgF1yuwQDLgQlJbi5YnTqM1OZiKrbYwL/jrRqQ9LuO5X6Hd0pQ==
X-Received: by 2002:a17:902:d60f:b0:267:cdc8:b30b with SMTP id d9443c01a7336-27ed4a873c8mr101655395ad.53.1758965004608;
        Sat, 27 Sep 2025 02:23:24 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2401:b60:5:2::a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882277sm74215125ad.78.2025.09.27.02.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 02:23:24 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Tianling Shen <cnsztl@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Jonas Karlman <jonas@kwiboo.se>,
	Diederik de Haas <didi.debian@cknow.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add FriendlyElec NanoPi R76S
Date: Sat, 27 Sep 2025 17:23:09 +0800
Message-ID: <20250927092311.789946-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NanoPi R76S (as "R76S") is an open-sourced mini IoT gateway
device with two 2.5G, designed and developed by FriendlyElec.

Add devicetree binding documentation for the FriendlyElec NanoPi R76S
board.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---

Changes in v2:
- Collected Acked-by tag.

---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 6aceaa8acbb2..e8185344c6f0 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -330,6 +330,11 @@ properties:
               - friendlyarm,nanopi-r6s
           - const: rockchip,rk3588s
 
+      - description: FriendlyElec NanoPi R76S
+        items:
+          - const: friendlyarm,nanopi-r76s
+          - const: rockchip,rk3576
+
       - description: FriendlyElec NanoPi Zero2
         items:
           - const: friendlyarm,nanopi-zero2
-- 
2.51.0


