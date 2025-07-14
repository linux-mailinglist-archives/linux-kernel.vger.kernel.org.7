Return-Path: <linux-kernel+bounces-730827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1BBB04A71
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24B47B2B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589FC27F16C;
	Mon, 14 Jul 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b="b0VnS6a+"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427F27C154
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531497; cv=none; b=lkYu3rlOxQp1J6/ddpkslANb+ctOFxpGZ0M9QugHiiGaHNcsOsVo2MD0mg3JJ+s+neJZ2l8RA2XjgOuQwNgKuwzD6VSIEJptKeYNgc6SbPvYXZU6h6sYQow0YweUjxV+xFMxismCSKBa3CaqeSDYnzc75ajx/3dqriVm7v3xfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531497; c=relaxed/simple;
	bh=NfEbJQ9APBMNxBx8/hFWpXBgQCXsN9BhVcLRIR0cydM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3WVGHkFm27DuTP2MCKU8ixcoKWmYwMlIXdqGa/NwsCs/qYOLtshoaSaPB+V7311jB5x8V9UyFCP+U9j+E0qP5jWP0vkwah9mxJ7D76IELm6LZXdfuS0RN2WH8NPjy5s7g7WhNZpL2UtnVY09qpBmuDr9RPtM4xjNz2R+x90LMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com; spf=pass smtp.mailfrom=scandent.com; dkim=pass (2048-bit key) header.d=scandent.com header.i=@scandent.com header.b=b0VnS6a+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=scandent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scandent.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ab5e2ae630so22421731cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 15:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scandent.com; s=google; t=1752531494; x=1753136294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIaH38Gh5kKcHJRj8XVnX3nblAGXvNpyNwpxmX14OvU=;
        b=b0VnS6a+rCpnmDrq0kKRMhImO9537Yw1x1jvH8isXr/G/m6ld0JiJNP87Pit/w3Ctr
         3Xk6CF2hC5bo9/h5Ri2f4vzQpngKm5+Yh4y7Tr1Ndbr7wOGV3bdUo2XUGCdV+S7x9ge7
         6AJ2xwYcvFtEhgAjnhI6GzqxXMCzMTsvfWUXyz3SVwvJdwXRx8NSUaKt4KSaPEnvYIuF
         i0EA2WgDOLsVdsytCXFMebZu5hoNpYgsGv2eIUUFKbc5xfC0ZOvYqau8LFPE/6XGuCEI
         jMBdyxFJpSI9T8DLfIW3BgtdZDb8mdSZdosDx/u6SaoJz1lbv4ZuK2dw2gyaofTl9rY/
         UoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531494; x=1753136294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIaH38Gh5kKcHJRj8XVnX3nblAGXvNpyNwpxmX14OvU=;
        b=Go15huTWXM8KIHIi5wqBeCxPsLbB910zGKRzgoUIcW070QofCkIuZgCTOvW8roFHiO
         2YRgrPspo7SNYUIRvd3/jKzLSoZXBoDb5yLff54CUgy5a9d8AHHvrD5olBtMRdpntqW1
         lhdIVVnZwk1Ad2QE0BhJkf/M5NHx6cy9BdHoTaF1TnCxoz01wEFU9zIsP7/zbcBJbf+d
         RO1eQ6htyIu38GZFzyjI2XC5R5kXOEhNQDpYfjZ0JdUneBEbmssBl2E4/rO9DIbzyOJM
         ZDMkaR7bmKVKCDgYonnulTE/ppWIcjI3SNTgh2ACqC3LlBXW4KAuiCl7h5ED3FyVZp1m
         d8cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbrSb1WdAHGTreWoKTW/CXA1mEBDv2hwCK+vuYHXSPhFEupebQUbbct1SGce5kpXWFJpE93gowjYcuvFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/aOGoit0fjK/ZfkrWsmpLlnw/2Xyt1R3jGtekory0VThXwnqM
	n5l0PrlEnddJIuMHJhge46dIbC3QRUu5IgHzYn/igQP8CcPAcGTkeaUud2XPj/AsbDY=
X-Gm-Gg: ASbGncuqutLSj3swQoylw88wGesIZb7uVWZ2k/nTdSodOEnyiI8lIlm96YHvVO83ZJ0
	vSfWk8ChgvAcW+agYXfXFPBBtQE7MqER7CpToNnbTy/XV9V7CYM7Guqel3fdILfq2M8tQ9V9nkX
	SVEvOkjAtnxx7e47p+L+Rpis2XknpQVtWwCTUxTkpPX1VReoE2takjBplwi6NOB/OMWoFG2QAiT
	AU06A+SIBYw5dVjPDxjPy6+HX9RR7A3FPP0BLyW0OtOkyAf+6LW+4xy+o9g7cY2QDj7hvOsM0Tu
	VRVDgyg8wAnj/7wUKwpm3YrmiT3MrffkBfvocU5vL8g2Y4j/kSXO6cJLIzMK03yATy2Erixj57c
	wtX9hHOOCu7W80dPjkb6ZseRdolkIIjsSaqvdR8oMS8xaSCHy
X-Google-Smtp-Source: AGHT+IHF+khwSUVbi38c6jhWBuadogmIeY/qCFpX9uS8IQMaxlml1sIb3wH8o1wLSvvGA3Y1kGkIjw==
X-Received: by 2002:ac8:59d5:0:b0:4a4:3147:41d6 with SMTP id d75a77b69052e-4aa35ca9258mr235602601cf.15.1752531494043;
        Mon, 14 Jul 2025 15:18:14 -0700 (PDT)
Received: from vserver (ool-44c5118c.dyn.optonline.net. [68.197.17.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ab3a1ceae0sm37822021cf.25.2025.07.14.15.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:18:13 -0700 (PDT)
From: Richard Yao <richard@scandent.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akshay Athalye <akshay@scandent.com>,
	Richard Yao <richard@scandent.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Junhao Xie <bigfoot@classfun.cn>,
	Caleb James DeLisle <cjd@cjdns.fr>,
	Kever Yang <kever.yang@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Tianxianwei name
Date: Mon, 14 Jul 2025 18:17:59 -0400
Message-ID: <20250714221804.25691-2-richard@scandent.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714221804.25691-1-richard@scandent.com>
References: <20250714221804.25691-1-richard@scandent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tianxianwei is a company based in Shenzhen, China, making LCD screens.

Add their name to the list of vendors.

Signed-off-by: Richard Yao <richard@scandent.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5d2a7a8d3ac6..a2151e2aef4b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1548,6 +1548,8 @@ patternProperties:
     description: Texas Instruments
   "^tianma,.*":
     description: Tianma Micro-electronics Co., Ltd.
+  "^tianxianwei,.*":
+    description: Shenzhen Tianxianwei technology co., LTD
   "^tlm,.*":
     description: Trusted Logic Mobility
   "^tmt,.*":
-- 
2.50.0


