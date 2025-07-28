Return-Path: <linux-kernel+bounces-747496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70355B1347C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D46818975E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595B92236E0;
	Mon, 28 Jul 2025 05:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3shpi7V"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14824A055;
	Mon, 28 Jul 2025 05:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682204; cv=none; b=RlFvW+K7AloCBVb0gCmGP8PT54jdQyTZ7uGRtOXq1HQmwwCdBESsZSjYlD1iFCvwj/eJ3bFEmpcovS+BavTzjP8qZr8n4iQ4jEOaPgqo+HlKeeVK8YDI4kYOJXhHATq7xWag3j9oesAZ1BZ8Bva4uNdrZeLYeEQe8XGHBfKGY+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682204; c=relaxed/simple;
	bh=M/eAEw0WGY3XlA5M7etcluqGBfr15RsdGKCKj+VOgMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRCiPlGTq7K1IcYOKm+k+E1KbBTnCvSsWTRwxLhKJciBY1YoMFf6IFGFM+yWJENkqBXFlEpbvctwUGPkbmGYTdpje1NVHwH+1YQuoxNFcMH7egfGQtkIHmXf+eskGOzZFiCdJyXvlPqWrozRf4UtFQ15sea12rZYRAY7pq9KCxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3shpi7V; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2401248e4aaso8187205ad.0;
        Sun, 27 Jul 2025 22:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682203; x=1754287003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwv8jVW8Cpw1HdPZHR5pkIUQOrnV30U4PbqXFmi6s24=;
        b=N3shpi7VTFyRK2V763aBz9tKAw/B978OlMkYSinGpDYz+eFNiq7a9TSBsOTw1n9o3t
         yXXF+9yNw3CuP9+22UIzRyNB30pm4Lpkb157NGxregquVm736GbK1i8C1ssj2VzafKE+
         ujmTGBMH+LiaG7u0JMGLNdfSgG9BOwDh4UZwdQFefBoSoDIubn9UlpKi4bd/2eD6/0Xc
         fxMjVqtAVI02vJ5jgRQI803UCWQAc890zVd+TrUQQMzS+kHTs7I5syfv37yPUFHeCoY0
         lsYJDHVxcIML+2tfzYQzy7lTunekh49myUe7zwF+61bL3N1GhuQL2kpR3MkWhewXeiGn
         MJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682203; x=1754287003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwv8jVW8Cpw1HdPZHR5pkIUQOrnV30U4PbqXFmi6s24=;
        b=IPXDk3Q7RW38+JALxqwVKZupLYZqytBQ5dt15oe1fSFOrHCPmm0azXJjY7zQoK2lN5
         QkN6iZlp3GcEeWLteo9cWm0JZGegiZIJiQEHG6FxsX4QHtjfn+dARF5USoMnymePVIpH
         cbCC1LbeJHo0gNFmPfd7j7rVScL48dnTQJSWwV/uho4QnsDKdGM3jqVTgJ/3RUIAi1FY
         a0Vhc7rTI0VqluZZUtzLCaHoZGy/kr1z8rfJOzTb8EFfO8w9h67F6F6mQ6NXiIdpyTS+
         qDILyHLMRZnBt5+ODmOmdnrLZa4DMSVGGWrEFOt+H38oFeJIWlS1mGLbdKjT2eiAV/sb
         VNCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwppsBaDgrmTCyjnaf4CUjkLp1l0fLMrFVv1Xe1FODiR/pgVX5sjRaXlyfzTDQupeNLgw8i4tUzux2@vger.kernel.org, AJvYcCWJakzZup9XIsHAcGZGSy2QYCyJ51GDgeFseqzugBexzqrs2V3eUq1x7MwsF8eteonwiEJO0mcSp/BKyoHh@vger.kernel.org
X-Gm-Message-State: AOJu0YygmdQzE/niqmVOeZf901vfdX/INKJTiM6twuUdKdDXcvML83IC
	0saZ5P7NIECA8nzwLQwurFkqS+UIh9fxWiJBvKQZXdC52UpUnvyG9kwTRRj9bf6K
X-Gm-Gg: ASbGncv2IrhBXYKzSUhiBve6Zvr74K/ri6Ujm6rvYdgAo0HSaHva1mrF7dBH68Pa2eI
	kF3VwU/lJtIH2xXmvCLw1B7hIlENQrMj+9Hrf5bnLbgDAJ2y32axSB+WYn49hzt6PL1T4thzUMI
	y/ctiw5Wb5C+/+lfEklJfxd3+ofoyb2Jkji7RjkS3ETZQJNt/CS92fDC4wSp0E/2OSzQgDhQ/M7
	JU9Y62GsaoViUUyOuVME+mQCpWfJn7TIduHUsX7BSXP60PsMcecmYkIBuIHIYkqdJFg6R6FU4+s
	t539xv8NuOeRbcZXS1Pw5pETyqHgtZSJuZ7KwOG5D2U5xYYnVdK1FKhRbWIvB9ZKuEM8yhmt1Cm
	BZUH6gNEAlKfZNF7v299mYPWY5etTXjt2XqsAVpUWZ/njaViYWKXT+xu8JLOkosS4j5RKRSfwA/
	w=
X-Google-Smtp-Source: AGHT+IH9RbYstZRftDP7K1JFfq4K9/bJOuDCvgnQtsdkV8ZotM7LNFEtIGdprzRSpoN4SreniMPYxQ==
X-Received: by 2002:a17:902:dac5:b0:240:aba:fe3b with SMTP id d9443c01a7336-2400abb2552mr50892895ad.16.1753682202708;
        Sun, 27 Jul 2025 22:56:42 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:42 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 12/13] dt-bindings: arm: aspeed: add Facebook Darwin board
Date: Sun, 27 Jul 2025 22:56:14 -0700
Message-ID: <20250728055618.61616-13-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250728055618.61616-1-rentao.bupt@gmail.com>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

Document the new compatibles used on Meta/Facebook Darwin board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v4:
  - None.
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 3cc6e62ae5f3..2887565d4170 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -83,6 +83,7 @@ properties:
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,cloudripper-bmc
+              - facebook,darwin-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,fuji-data64-bmc
-- 
2.47.3


