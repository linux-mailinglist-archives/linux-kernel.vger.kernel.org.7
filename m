Return-Path: <linux-kernel+bounces-835855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED81BA8341
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36033BDF0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4882BF00B;
	Mon, 29 Sep 2025 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk9InYnE"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836752C026D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 06:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129062; cv=none; b=Q6COF8uPZg3T2xZ5KT6Ip0x38lAmwf6Uv+rDbLMSzVWKNULzbyGGLF3wA05xLp9N5wQB5jT/6PZPVhV2WeZWcMM5ihqbJRjvIZmpZ78HHbtxvTK6ZVros9O+UvvbMCxYxjltcxj6QhpYSSgGGMvjI2r4qWRbRN/oW1ryXokD6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129062; c=relaxed/simple;
	bh=OxgF0sgU8kJelkuDjh/RK/kYTlp1sBcDIk4CfwqFFXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GCKHP5BkATd1uJtm4QICDpUSZhJ+pPsSfGXZOtpwxubmmEmKn4I9vOfxX2pZ/GLvoGAjukRwMwUMRlOKRplAQpDzXXhQhX0cmtVggyRQGbMZCKMf2HqkvQoJiirwPaF23TF/TQSw3E6sYuHpSVkNiK0/gpjL1ppGG5rWhBU1vGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk9InYnE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26e68904f0eso42143955ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 23:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759129061; x=1759733861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/i3lJ5UnNUwnZHcBsmIKwojuviTql3djQ9HFxU9mOWY=;
        b=Qk9InYnEs2RiP5gBVWTjrkHfvx6iD1ivIJ2c2KsIIsZqn+ABLLgP1sHQcONXMke/+L
         SUsJbhab1K5duPct5LBS8BUZbuEXWGjSDAI5Nn/I0M6jHj+H9zBtpV1nSTC7SLmQFOiN
         4b1zsKwp5S/lRdwHFO1ixYVsVVzYOqkwbohaBMp3EQQzB4eFtf/ddT5iR1rlO14V4nbv
         8KsAxv7TRab7aUVO+3+E9fH2HWPtiw68U6aS8y8zlqOtXDEtBdY9GasJHvSTSwJi2wqT
         6iE6rEx/6S9MbdgRDNbC4uI83Rl/iGKkfjEqJ+VWy7IyvySZJQHcgNxyCCCLDfE/UFDO
         Kmtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759129061; x=1759733861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/i3lJ5UnNUwnZHcBsmIKwojuviTql3djQ9HFxU9mOWY=;
        b=kCMX3cEawjpYx8Dm1eYxPKhOyQ7kAk9XTmBkpoPJ3vt0stiy5WfB5iazSlMA+UkVut
         pU08vknJfwf0k64i0poJqLEPhXhjXeZK4N4Em6VFOG2aiabmMsvy7S3cYn0uIn2Vo4nB
         DD+AcVqGERjfS5lciFtfr4B5WgcLWbn/oBnUgn+u+ka+X8b6UF0CKLoOvaDMhelw9HrG
         YygH2kwySWKXN0O02+2RLUgv49cKveLlViTXmQF5Rr37ftOBSXD3nbIhYAiAuCnm6WOA
         6fLChD53EqDjIdadVDFy3YGsDbj6X/lPd/LIwOypjcCPgq+dzXvaaTzsgoRPSnwoHdUv
         SitQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfQZE29Akyajl7xcwvLGPYbltHMgVxayi/ohtbRrnjoQgL4cRq8bQiTWLHo0XK7xO4RKbKgjd9BcNK4+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNHLbQnpCe2EfW5brArMEO0O8AMt5MfO/wL3ZYPIMtHlq61JSd
	22X9IZDwHsatZYfqINqcuIS8P9GWyuXPqOCyI5ZkJzCPgJr/BB4IhgGV
X-Gm-Gg: ASbGncvVwmmcFcx3prJGbAimnLDwm58xzqpILUtUtw1Z8My0eUPYj/Q5Su0M0EUNuyW
	/X8Hyz2fJJhYXWsppXkA1QMId8osj79snXdYm/b1gaTbp/AGEp4L4GH9RzJNynsrwhZmfMj/hVg
	UWoHN3yTPm9FbNUg3lnV9xnrfhi/nHejtQEWy4IWUf898e+MJ9SDvuEx/6FASBRToplHBPn7c/f
	BS6hAIEdiRX1suCUuTjqwDStLa120i1pmYcJCmsgnsxnJhgFpI181sxw66VCxD49oikOvHKu0eG
	RQaWVw9xecYxbKPUAw0fkcvvTjO+8LZXu/8DTCCTI8EI1Uy0OaDQCd4zmhZp1YBq/NqHgNs0epy
	bANMbCffD64tRZRXK/hKJ/oZlcM/bhG+bQab/7BiN6zI=
X-Google-Smtp-Source: AGHT+IGXx48956iAsgN2mLQXj+DWiZQ/oeB2pwDmDud/7PQv/mcuFlsHf1iG+3XAh+OJgY293RcZBw==
X-Received: by 2002:a17:903:3bce:b0:25f:fe5f:c927 with SMTP id d9443c01a7336-27ed4a7f364mr157596135ad.31.1759129060832;
        Sun, 28 Sep 2025 23:57:40 -0700 (PDT)
Received: from localhost.localdomain ([120.229.16.251])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53cac77sm10549595a12.17.2025.09.28.23.57.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 23:57:40 -0700 (PDT)
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
Subject: [PATCH v3 2/3] dt-bindings: arm: rockchip: Add LinkEase EasePi R1
Date: Mon, 29 Sep 2025 14:57:13 +0800
Message-ID: <20250929065714.27741-3-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929065714.27741-1-jjm2473@gmail.com>
References: <20250929065714.27741-1-jjm2473@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 is a high-performance mini router based on RK3568.

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6aa5b..ec2271cfb7e1 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -726,6 +726,11 @@ properties:
           - const: lckfb,tspi-rk3566
           - const: rockchip,rk3566
 
+      - description: LinkEase EasePi R1
+        items:
+          - const: linkease,easepi-r1
+          - const: rockchip,rk3568
+
       - description: Luckfox Core3576 Module based boards
         items:
           - enum:
-- 
2.51.0


