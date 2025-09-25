Return-Path: <linux-kernel+bounces-831760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC5CB9D814
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68D9C7A3C33
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D12A2E8B85;
	Thu, 25 Sep 2025 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sila9Mru"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359B757EA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758779958; cv=none; b=iArd6MBPsqOkuvk//WA9OLCnTDoiNoV0hgtNcTt9ZLgh7/IDU2fphzmpOFatVPUvGc3jsrvLdHA+T2L63xJQ8ajuXQqJ/sU175WVjNe2ZrcJQqoDGZAKB9y0FbC45SkfufIyUqICmhg4rMhDCQb9DZrwnMHvtbLOc5y6En+JDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758779958; c=relaxed/simple;
	bh=MkXy8B0HvDpu3XB7QRokGYJw4lWQNt80EBtTGcgIso0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fN5yNidKov8oT4LL2CaQ9ZmY3q0aD/st1d1WEjvUxLj/MbgD0gsG2NAKkaGCNec6bRgAZ+j2q9SRsE63zRJvroRUkT2MgGFdSHcnrKKszt0Kjt3rEbO2ZcaEqyGNRq9+n2X+HKQVr9EGYjaaZgkFauUDofqNSygZgc5VLa0kXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sila9Mru; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso581112b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758779956; x=1759384756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzgyK9PV21LUzCc3kELjlfdCuadwZ4YNSm8kpUWXn6s=;
        b=Sila9Mruq+QQ2auSU+TuETeX5EefYN79AJC1YqOUpE8FDzuVbiQFvCaJtJUjcPXJbL
         iZA+ffwH7b2R0CJEiYSklVQAJxHs7lNFYy3LYL/VMhEUxc1b0zdqkiwfHd6s3Gem4nT8
         IqdAMbfavfzrePL6UWNhi+2S8FIvtlRjyIwGOtlcL2sGCQiuBIR4CoyL0fhqfWDT73Z7
         CzoQ7qA9OIy8314EUeEsddoruO8tRsNGmvrbo82IiRodHi905utmxPxLMt8UMF6RKUOG
         eXabe87oVQ5JFz648h2Aw1Ga4QYK1xrYSntpf+QaGTprGmlgkMwqIrENemSNzvhrUxIY
         B/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758779956; x=1759384756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hzgyK9PV21LUzCc3kELjlfdCuadwZ4YNSm8kpUWXn6s=;
        b=kv7xiYGF7b1p4vde+5/NaU5vQbZuYbuKe4Iuye0TbFUvjjGhhfoQQWFhNzR2aEr/j1
         DSiQ0fgeq+cIXwDb9Gp23FehGfDmFB0BcQXngOBlmGuNHlk/YQtgCdYS4UFV9ViogsR/
         A7lMD2TQhPsUzP+jVXz0rBdOMeZhwBulIuXTqGCVy8He6CcDbSeF1TonskyqwSDl3FTw
         Lt4YYdpTnBrmpVz/xJEluua+BjWG662IMM0OQGt+iTD1tcutXJsH977n7pt8NPuHtKPe
         2JJVwPETVar14bCcmkslC3TCAFvVEYMPHz6eLFxjaXHvgNEXX4KkXKRgUm2bzyQw96t5
         Kzwg==
X-Forwarded-Encrypted: i=1; AJvYcCVUxQQH3myVRFLuTpxQn9J/ShrVLTwmMR/IOOcHhvlRYuzHqkMqFGghPUyeETkgrbHpA5GWb9N6n7BuWW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKFToRG1pdev6C690rXVvObQDZt2ZBSp2OcXku+ESRG4VoNSGo
	fXg1TEp6lGF2vFr/zIVCMtrq2tnWt43iUw9Occ81UFGIQu8AiI/jV0qE
X-Gm-Gg: ASbGncuw5d78EAg4l/PrOg0vjzycyn1kVaM5JrNevxU86bxPRtkl+HwiE2eHrs3q7GZ
	ipeGlXgeksY/0S5kNL6XCYrqhd1icc8L6hM3dqKS40L1QIejpWBfCItHYv8SCQE0REs53+5FfG8
	wgML+04jnfrx6Z+kqpgxrtEjhPH2zPX4TnXNW7bUVUdXpkcvoU7P+KiXmltc2BmFzo4cB1U4wUR
	NeAdlzcQVTya3Y4o99d8EDBYisbG5wJuVbUxHFFL7TM0DlZcPAv6Se6NITV3VyHWYQKFIi9g3wT
	rqtDG9reh1jAB1ASQIlvXV19Nml1DLiaJfR9CDdoYRnrqQGdeN75xzahiV/xaZqFy8TCTvioM3q
	TtP/WYy5ufGdgWJrBGZQe40x1l7NgGBE=
X-Google-Smtp-Source: AGHT+IG9xIcUHZTl7U2e2Kcvms7TIgsGltU12ow8osqzjYtqIjX+3YzN6wVfCYN2K3OEd05eSOjGkg==
X-Received: by 2002:a05:6a00:1408:b0:77f:6971:c590 with SMTP id d2e1a72fcca58-780fceb49eemr2573091b3a.22.1758779956482;
        Wed, 24 Sep 2025 22:59:16 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:3981:16dc::247:77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b231ebsm866478b3a.52.2025.09.24.22.59.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Sep 2025 22:59:16 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Date: Thu, 25 Sep 2025 13:59:04 +0800
Message-ID: <20250925055906.83375-1-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase is a company focusing on the research and development of
network equipment and related software and hardware from Shenzhen.

Add vendor prefix for it.

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9ec8947dfcad..db496416b250 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -873,6 +873,8 @@ patternProperties:
     description: Lincoln Technology Solutions
   "^lineartechnology,.*":
     description: Linear Technology
+  "^linkease,.*":
+    description: Shenzhen LinkEase Network Technology Co., Ltd.
   "^linksprite,.*":
     description: LinkSprite Technologies, Inc.
   "^linksys,.*":
-- 
2.51.0


