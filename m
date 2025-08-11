Return-Path: <linux-kernel+bounces-762781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36585B20AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A05D18972E6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8FC218584;
	Mon, 11 Aug 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LAq/Dd1q"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9201F9A89
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920456; cv=none; b=bJb5Bt1veJhX6EQqL9kaBCKcwWA9kQom6UMT6vRFTPx6RcUDJ+Hoy+ciN+wBZGYF3jm2M3hVmFIyCL6izHXTgG2ScTnxLZF4Da/5GPrwrWbPs24CcIaeaARepQVx2ILIXE/hIP2ETIh6J/CstqW52DxYgMF9guPDzEDJnqAH1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920456; c=relaxed/simple;
	bh=D32owlGLOdlHqubNLaI9nkgZDRqlRnVWNbolwyy8jW4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AJPjzs5RJtFOvkNrqtLab+k+TpyWr2LbAzEeIeHpf6yp31i+BwzbRIfR6+Jczh/VjrXEDC883tFNpVlwU+N6Mx3y/5rj1p8dq7EHo6i7pIOPer+QPgeKMz/BOhdTM4wif/zzJ1dx9VqU7Y33gna//0ahA4BXx6Nkbvy9mrfpKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LAq/Dd1q; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af940717331so58855366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754920453; x=1755525253; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X4E1w+hIQ4kce+iEv51gMOFHtMhwy1x6OT83N+mRbe4=;
        b=LAq/Dd1qi2xQtn7ftL9p/dtNdmzDr2IxZheU5tlQswqWtwk/SU/AI15qW7jtmr5K+A
         6gvDnjCXnFmk8yqxVDX9v5bcIV9r+YEwViwWjimD/DO7QrYERMtImFULyGIkrmW2jiXG
         l7gvYZloCED6lMY3uptAMmIH6Z6ATVZZ4pbsUQDSdRvr91azAx7Ns5xTcRXmaACz12qF
         pp1h4OhFV80s8/RZrsWrwqUzMnFWo3GFguXs8GKXJbdr0JsvWuA7Fmn6P+qJtFrOCwwn
         mIHiPjkHNcx/iTkOivTK5XVDWC+EIjMMZpUiQAQfPTh59m0lfC17vw66DhZOchMVEXPC
         OALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920453; x=1755525253;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4E1w+hIQ4kce+iEv51gMOFHtMhwy1x6OT83N+mRbe4=;
        b=b2NsNflph6mOrdkxPZEUpTnznZD0vmdCnJ6S5F8WH6ZG++g6FFtWeIhEdEqMWYkZA4
         EDZZ/mK20qjCVHRKTlAlVRF2pSTnxAci2mqy8wZH/eZKtCTWlLdqOjMXSLWfSXq6mCqU
         ubeYrtCiunLnxI8E/hKZ/4BG0rvw/Er6lwY04efUn1cuUiI4RTh8zkJ5KhH1RCHvRk4d
         TKsH2fc7AO6ci/o5hnLyGSYYiFsUvMQQ2EwKUkzX3o5OZ3V4BDbhuv3kY35Qn17KdqrB
         8HQHAzT3cOCUppbHzDD+N7xFYfKuyFOg61ISZrN8h7ApQlR/A5zEn+ENT1Dr4QFQ9mjX
         0teg==
X-Forwarded-Encrypted: i=1; AJvYcCUhnqOZ0LhnfGhj9J8RZTvsl8L8/AMTVjgQszpfF+MxC+sevcArig45Rh+lvh/hrMzljvU8FWRnWJjkngs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/e/8+K4DzZ/42CG+vF5oUpnEUX8Oz7kAW6vzEbpuun71kcn+G
	AZ1cJW/LdY7cNrxUdW20fvztq4m0HmBYu/8We5Gh1KsS1boa4B+SBMHdHhbVtHbraxE=
X-Gm-Gg: ASbGncu07TLjAj4PXvNIfyrhzu4+j3EYSzuX8JNhLHuFYq+GLgTl/aQaHuvkSfI/WAR
	74eP1YvZ/I0uU0KqmE/J5g+t3PHBn+wjPQu3ow8kgP5pP4hIzNKcZCKWGQWbG9CJLDzQD/S4Ayz
	vwpb2MBEPukxh2bovgFwYMe86p1531nb/cA0bNF20jlet6alF9WdmgzO4hQMORDjYQBNyoxGS7Y
	Ubi5KUmlJfYejwyYUtAH7Db1jDJAVmwwCjKoSJFH5uSeECgaef2gcdYjUO8O0WHKmO3qaIS33Li
	LfDbKeXR2a0zHZaoe/Lyjjo419joCgyrjcOqvF3SgMjZBWAIkOJADXcfLPxTM25WLacsfeZQO+e
	j3Zy++oIp3sr9xebMFbaqFfBiQxmuIGX3eYGlVqwGIv+eQsW9vA==
X-Google-Smtp-Source: AGHT+IHeQhtn+GwAGxZiHen5xqVtV0k6a2xfnhqG8tq/SVPZOQOhdgU7YDXqOB3wSUZppQOTSjZ/QQ==
X-Received: by 2002:a17:906:c114:b0:ae0:bb1a:8c4 with SMTP id a640c23a62f3a-af9deaae559mr346505666b.1.1754920452931;
        Mon, 11 Aug 2025 06:54:12 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af986a477c4sm1179029866b.56.2025.08.11.06.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:54:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND 0/2] dt-bindings: Drop 'db' suffix duplicating
 dtschema
Date: Mon, 11 Aug 2025 15:54:02 +0200
Message-Id: <20250811-dt-bindings-db-v1-0-457301523bb5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPr1mWgC/3WNMQvCMBCF/0q52ZNrJFacHOzqoKN0SJOzPSiJJ
 KUopf/dkN3xe4/3vRUSR+EE52qFyIskCT5DvavAjsYPjOIygyKl6agadDP24p34IaHr8XBiY4i
 0tY4gj96RX/Ipwifc20d7u0KX81HSHOK3/Cx1af8plxoJnbYNNcrYnvkyiTcx7EMcoNu27Qekh
 Yi0tQAAAA==
X-Change-ID: 20250627-dt-bindings-db-38eaa005ccd0
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Vincent Knecht <vincent.knecht@mailoo.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=812;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=D32owlGLOdlHqubNLaI9nkgZDRqlRnVWNbolwyy8jW4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBomfYAbFp5nM0BuZDzZfSz7NhlghSfON8hIYWfU
 2/PI5axk4SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaJn2AAAKCRDBN2bmhouD
 171gD/9jmTBJd9weX4PdgWSBrNoi+OhK7XHL0dkfzxWr3gPih+Y1CUjQ92GvArexs7OSIVhb4um
 uOseVt8Dbup/XMM/MGDC1PpzpV8p8XdF4UAveq0pNbCcwYY+v2XYNGxnwnL4nr2wVEz4bperF8u
 dXljljLZlxUmioRkuVKfQKFeqFOtxTReuj30Aa1L9Jg/AM2lHWl/AmseQLt3bI04m81KnQk+6ZF
 /A+5PtOtF8JDNhBb2n9HXWyKslYnHGcIyYrxP5+zENqV+23fWNdCmQVV/fWzsxtgt89k8g5H6te
 uSi9CXUxJ3l+22rW4UIfWcMXIXV+mlAU/GpP8qc5TVPjGU77+0bOFKAR0MiClggadETQk6wUk9s
 e99hsxBC137+fpYgSjm1gZhF2MIA9Rr/f1DyY6NRlpJVod55+/W7eQis1d6OwEden9HaoGSqqIR
 gKnpWi6HkStV7dKm39wIzBWqty3KqqzAoFy+kQCGtY1A7Egt0bEEsRjlmyN7o2GDRdAAEH+FWTq
 r7/nf+NA90ybfUzoI/QgozgEPiLCljf+/hRtID3Xp+1rHHpIOhUDJRb5MdW2JW2TFpgx7aRDW7e
 5TiVtDmDj+sElyEwNNXEVSzWPxAIgbI6HY1IsRvzCTgAw01ZXRmBAhjO4Rt8MGOEF1hGglmN/VS
 7xnWoAozbu5jkoA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Resending because all dependencies are merged.

Please take individual patches via respective subsystems (phy, leds).

Previously:
- Link to v1: https://lore.kernel.org/r/20250627-dt-bindings-db-v1-0-d5c7072acbee@linaro.org

Best regards,
Krzysztof

---
Krzysztof Kozlowski (2):
      dt-bindings: leds: issi,is31fl319x: Drop 'db' suffix duplicating dtschema
      dt-bindings: phy: fsl,imx8mq-usb: Drop 'db' suffix duplicating dtschema

 Documentation/devicetree/bindings/leds/issi,is31fl319x.yaml   | 1 -
 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 1 -
 2 files changed, 2 deletions(-)
---
base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
change-id: 20250627-dt-bindings-db-38eaa005ccd0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


