Return-Path: <linux-kernel+bounces-890714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E66C40BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33A48189C077
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D370532C946;
	Fri,  7 Nov 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn5mQn7I"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880CE25524C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531401; cv=none; b=QqsJYtu3tZaooY2uXt3ZJBYR5MQo80HOT1076t7RSqq1yWfQnmlanPLzwY8iTb/caCvDLMUtAB5EZGvB1Rd0b5/HDTXtMKrDsT8wbiTjIThfik4JM2WnXCAyIHEPdbI/RYFZf41/P9IqOIm0sLAZZpjSaV+5f3j7XKY6SgSzM7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531401; c=relaxed/simple;
	bh=YfWQ/2PKyvWRIK3kXIkrEAQ1yaWJEPP99cI4Ld1q7CM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMvILQqIn8FWvvOss2wMxWQbGJ5NVRc0ferSCBoY79IGt5OKU2TU00ZxenB6kOa2xh6+p2WPFW49lIER3FFm3KyVWihUjrHccFxj7yQv0Eb/9KEbWQVxD8c7Ko2Ua/kvgp2wdj5zPByeeoQaURKTmqD2F3ggwD88xBCuML+Wtss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn5mQn7I; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-426fc536b5dso582241f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531397; x=1763136197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn/Od/4YICRZnXAyEJg+dgWKk8kIueyrVLZ2I+p4YAM=;
        b=Mn5mQn7IGf1zK8vcSXyU1KRoj2g/xnnjKJKc3bsYcPPY4kQbdIygGUH6JMFpmMxQG/
         9BDN6pKcJb0c3CAJTSQtZNGQ8VKNdv6FNOCxCs7wF8d8EjLeR1MCSfEAUDhZ12V3Cpow
         x5dyZYpOFdBP/ZfD3aWqJBRqjNpS6CDQpdzd4wfb17nMoJo6CipIfof0XWrhlZ2OeXz/
         CWxSPB/SOErYfxlMqLOUAb3t/SD/K7QsEbMGthrH7JKyGe/DARkS8/xg5rqsjNbdVBPf
         P2z96dZjOhT0Sb42jRw6DigpudZVawmGxLbvkm6iAT/FJeahm+KQISkizi8HBNESax8f
         QeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531397; x=1763136197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jn/Od/4YICRZnXAyEJg+dgWKk8kIueyrVLZ2I+p4YAM=;
        b=Hio3QdgQiNSR76Qul3rdXOvV3ylqXL9cCiDsdLkJOUgAZ/zupd/6lYozsnWoauqUl4
         aWhhddN/AifT4T1BgiAB9QNnBFyxP6BF5EcWSdcs0NiE5BNseziezW9U6FxWQdooVxkC
         mGYv6SoUZP8NjPENjANqaQfIDwvk7UTqjU5HxtReBpuAB7jggLEr3UYwmdOIVASxujQI
         FG4pYhxmpjUAeICrGdWezJmyJsMgcCmzL4UVSe7NCUb4FzkFvn0OgjbyR+rtkJ/SJPUM
         AN4D3YrexYiYrVoL9m1RXgD1GArVAqzvOteAKuvExDFKv/eQzV0U+oTLewUHv7s2jOlH
         q93w==
X-Forwarded-Encrypted: i=1; AJvYcCV5eSgC4b4oo18Af3ZBnEDkKLU+WrlgABasj5kIHD5w7TCgsnGeTA82Om2+ZMG8XZNS31LK58AnDw4Aju4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbkvIyebG8l8iHNvBzRGdLgmqQgHacKm7yxJGssbz1gcStvngG
	zj94H0F0HByh3H6n1hh21Q2JD5NmM+QSzmn1fUdSzHCJtnEGP7Iy3IT0
X-Gm-Gg: ASbGncs2TXg523wxnQL/Zb1pbR+9JK0d2VM7LMKXUnCXGJmXjxW4BRrxcG9iB0vzxsi
	/pc2DRtEn4lhD5usY04euA8/ojdSIb/B/DQxrxjM/6DzCMJHaYfG/H2SzYiGHwQjyc29S6xxWmc
	XfVembRD/JOLSHtyuJ+9xFnwXclu4+0pcgxlLoRRcZ7VYeNtdXCqn9C5t4/V2Dybyj3PJng/AoQ
	ZucLBxa09R8mxq1hDaU2v/g5pVgDKMcz9QTj+iDMwrOwTWp39gMPYy6HbcDRtgU3O5Wk3tGibNe
	JULjSiZXoxn3dXSOvoNJd0JrY2kDIf5f8hj4XijpQJ/ZDeiYdgItYkZRjaI1TmiKdW6Hd7GDgTl
	V9Cp32Igvbw7fOXrg7wXi2+ev4a++xW9z6FkQwKmAMy9GjuTUBWXwua6nsLgubqmrU0K5FEXNk0
	7vJEQu24jwbKZrDxxZkUowDcVuvkPuVg==
X-Google-Smtp-Source: AGHT+IFlyBZfNRMNXVV5qUwRTFWSjWoXooTbJycgw3IhWharvD9aJ29E4znbDQrJZiQenU37vZU4XQ==
X-Received: by 2002:a5d:5f94:0:b0:428:1475:6a26 with SMTP id ffacd0b85a97d-42ae5af41cemr3864192f8f.56.1762531396986;
        Fri, 07 Nov 2025 08:03:16 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-42abe63e13csm6058016f8f.19.2025.11.07.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 08:03:16 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: soc: Add bindings for Airoha SCU Serdes lines
Date: Fri,  7 Nov 2025 17:02:43 +0100
Message-ID: <20251107160251.2307088-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107160251.2307088-1-ansuelsmth@gmail.com>
References: <20251107160251.2307088-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Airoha AN7581 SoC can configure the SCU serdes lines for multiple
purpose. For example the Serdes for the USB1 port can be both
used for USB 3.0 operation or for Ethernet. Or the USB2 serdes can both
used for USB 3.0 operation or for PCIe.

The PCIe Serdes can be both used for PCIe operation or for Ethernet.

Add bindings to permit correct reference of the different ports in DT,
mostly to differentiate the different supported modes internally to the
drivers.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 include/dt-bindings/soc/airoha,scu-ssr.h | 11 +++++++++++
 1 file changed, 11 insertions(+)
 create mode 100644 include/dt-bindings/soc/airoha,scu-ssr.h

diff --git a/include/dt-bindings/soc/airoha,scu-ssr.h b/include/dt-bindings/soc/airoha,scu-ssr.h
new file mode 100644
index 000000000000..a14cef465dad
--- /dev/null
+++ b/include/dt-bindings/soc/airoha,scu-ssr.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef __DT_BINDINGS_AIROHA_SCU_SSR_H
+#define __DT_BINDINGS_AIROHA_SCU_SSR_H
+
+#define AIROHA_SCU_SERDES_PCIE1		0
+#define AIROHA_SCU_SERDES_PCIE2		1
+#define AIROHA_SCU_SERDES_USB1		0
+#define AIROHA_SCU_SERDES_USB2		1
+
+#endif /* __DT_BINDINGS_AIROHA_SCU_SSR_H */
-- 
2.51.0


