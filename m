Return-Path: <linux-kernel+bounces-733892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FB5B07A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DA61897C72
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0572F5C4B;
	Wed, 16 Jul 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeFCOxI+"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA142EFDA0;
	Wed, 16 Jul 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680899; cv=none; b=d4oFopOQTuusj05NXdOvQirGR0c7RTN9sfn0pRK4qP0J5/TTx4RE7ZVOXu5v5BJlgA4iOaQxbZWHYzfkZaPeR5Wa4bVP/OO6cofa/higVU6pWnHYu69sdzNx+oW4Ej2Weh15nGnQFFIl0nm2VC6zw1wktE+cEYxBkB0xVCT0PPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680899; c=relaxed/simple;
	bh=KPPLhBl4MQOOqUtzFDuqHAu4KG2FSZigpCahI9GPht0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTaVXV+5KwfuJhB2Pn3Aknx/g0lX4G7k9folVkliF0cyjwGq8Qr7o8/n8U0U43J/VCqWPb8LA2TiAnLPdG31ZrxRrUMxZze7E5sM3EQQynI97ZrSR5slPVtF1i+vFDGwHZfuYkvjRKNhorqRES5YhKaZZlvjoGsXK1GXLMBNxX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeFCOxI+; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so11824344a12.3;
        Wed, 16 Jul 2025 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752680895; x=1753285695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrltEk6+3hF6VsUp3/raIH9c76LdjZyg5wwwr6SNNp4=;
        b=YeFCOxI+65L7n2pUhbyBTqQuqEBs1ZvGDS9FLoDBgKdnQ/tLhfQGQzfUq/5jHRQ0Jn
         d9ffP5DTrtsWO85fhV6mdWlzfrwnF7sntS4RbYIRhEDPpy/SRFE+OM65trQYhoV+pEly
         GgDpYbWOFgx+AzfBQRZPurQ+qcSj0AtDiwxVulSNmbZfFWJUETbcd57w+umJjcn7rYCp
         32jwo2iOgaxYPluky9zCHLJFZYPtVjha0FE6PjCw4sJmSunXXVghV3wz/fT2o562gNU1
         lv8lKEQ7gIuQk5xLW9bGWS/Bs0NZmqBPDS8XO+7MOSSJTyH95BsM75590+RxTKcCy8ly
         8o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680895; x=1753285695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrltEk6+3hF6VsUp3/raIH9c76LdjZyg5wwwr6SNNp4=;
        b=kwC2IHeq57G5uwswLsIXwIB1iLrIKbsvCm8cxhe9hWptOtzRVPX8iedWgZlP9vOWYX
         ozxjkMbHtWm93RhG3YFftjC4cz4erWA03P4rnGHpzY2Iu8PZOWDvxRQNXjnmMbdwROvc
         t8gDjyz8RLxZn5yRKgA1EKC/rXlNq8NMgHbcAeTCp2hCS1QqIUeTgBAJepodjVvNg1Ja
         +CfkrsfPH5rj8NyWdFZ4KUbBT1+FgUeyeKfyNrP0ImV1fJ7eKu/qbDn9hwoyQfl2cnfm
         dV0Giwz/5H4CDYrJA+OPG3Oax+vLsWyYLRR3HPJRGMcqp00lhxbf6lfxbZ8GmyZihvP0
         Qz/g==
X-Forwarded-Encrypted: i=1; AJvYcCX6kNDsYwD3C7mg2ZtA+OiBSndN6IiF3F8icnf9qs6B5KtzMVVwFmsTC5jRqdzISN1+cGSRCgJbb9Bh@vger.kernel.org, AJvYcCXMFkW9ab6YuIawZUfSpN9wrRxDbwnODAugYgRNUMk4xnsfJkD2DPS5xD+IbKI3HhfMhG0IXF3qZX3IEXfr@vger.kernel.org
X-Gm-Message-State: AOJu0YwwllwGyH3yvdxS57KLm1I2ZAhe6PPOoHx4kya7vgmlNLVP0DLV
	hJWsOVyRW6DmeP85eAl0en/B3FTtkdnzOs37G9R+C7t+iV2XgiUps59a
X-Gm-Gg: ASbGnctoOkBd9+p4UXqqjHGJp3rj4MOY5YJgnXb3QL1Y3Rpk6dgROlX8+03WI0Zf5uO
	gsz1ARnv0nX03YFJKw98GPvvW0tvJYnMqsGdbgxhzsRQrnYGpJUK7BxyWTdgQHyLVO4NfStACCd
	9v7Eu7gxY6ZI67aBRpHpVN27Qt/K0dZ1nXQ2j94JgcFYKgf6ey6ZJ2EykoOhZ9jdwIepqAQcP/3
	IgTq/SGPTyiw/49CckWKH5VdI9C45xqY2IQfCBZ0oQxdJC+aJnbHyJ9CHR6mqQ2PYVNl1bb2d9G
	u0BU4ZSLLaoM/tx1Co6crgf0YFjOBV+i6abrKIGJ7qlKblEmMtBx/yhgqCWzvWL8GcBs7UzDTD5
	PSrvfkvOJUd20NFV3hWQbtuOHEQyM56/LsP2b
X-Google-Smtp-Source: AGHT+IE8vN8iDrpEck2ZL8pFvrdx9RHifPaHz77OU0YQTwxeYuEHRH4jGkcTFVSWayZ6ccRSNRHHTA==
X-Received: by 2002:a17:907:cb81:b0:ae9:c494:1ade with SMTP id a640c23a62f3a-ae9ce199db0mr319557666b.53.1752680895141;
        Wed, 16 Jul 2025 08:48:15 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8293fe7sm1196705266b.123.2025.07.16.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:48:14 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Frank.li@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	boerge.struempfel@gmail.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	kernel@pengutronix.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/3] MAINTAINERS: Add i.MX8MP Ultra-MACH SBC to ULTRATRONIK BOARD SUPPORT
Date: Wed, 16 Jul 2025 17:48:04 +0200
Message-ID: <20250716154808.335138-2-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716154808.335138-1-goran.radni@gmail.com>
References: <20250716154808.335138-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The i.MX8MP-based Ultra-MACH SBC is supported by Ultratronik, and its
device tree has been added under arch/arm64/boot/dts/freescale/.

To ensure proper maintainer coverage and notification of relevant
changes, add the imx8mp-ultra-mach-sbc.dts file to the existing
ULTRATRONIK BOARD SUPPORT section.

This follows the established pattern already used for the STM32MP157C-
based Ultra-FLY SBC.

Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60bba48f5479..0ab09226e0aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25450,6 +25450,7 @@ M:	Goran Rađenović <goran.radni@gmail.com>
 M:	Börge Strümpfel <boerge.struempfel@gmail.com>
 S:	Maintained
 F:	arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts
+F:	arch/arm64/boot/dts/freescale/imx8mp-ultra-mach-sbc.dts
 
 UNICODE SUBSYSTEM
 M:	Gabriel Krisman Bertazi <krisman@kernel.org>
-- 
2.43.0


