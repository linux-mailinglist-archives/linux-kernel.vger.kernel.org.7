Return-Path: <linux-kernel+bounces-813822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A992DB54B20
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0E57B8A1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93404301495;
	Fri, 12 Sep 2025 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EO+SzWsv"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CCF301017
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677027; cv=none; b=AGHiULai1LAQ0m9IJxB1wTKvIIIB6YWruDjeMQRY+08eaC6slnRhgfdhbK+x2k1UP398BTh7aSxRDsvsx/WBt6G1yYmPRoKMg8SdJPWoGpsIGDtBT4osoIM4WdgxgLSjxRQpkRvE+HM9j6LAzCbTs98EES2SuEhgohpNfHpf2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677027; c=relaxed/simple;
	bh=ujDEv08XqW7rfLhPYFByABK56QwgaG48UU/oBf6Umk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g81wJFd4xv/y6gu550vyOhtGIFC/a+GJwnbe+7pg15a24N5toXBN8+amDMxEaBlo/1mTWRkoxaX1sJM2kUKQhxF5mAcFoSA94jsVfdKjZK5ZHW5pFwsmFIRxcT03nRUUl/h/wzygrhO1DqJ4rLa0nbG/VKoXIenlP6z/qlWmRcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EO+SzWsv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3df726ecff3so1039501f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757677024; x=1758281824; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=agTs24kXpvfK2NjZ1FaOGupYKSjo+weNDR5D/xFPjyE=;
        b=EO+SzWsvQUUhOK2jsNK9eUvYhtAfRngmFU+w/lalkCbyqML/fR2/NxU2CJiTLa4p5B
         NBc7V8hloO8WaNYi2C9CXggUhjpz0Ye3BTSF4WSnjk+bdqTmfBr2iciTKzIq9U9M712R
         izqWeqRdnkBgkUSlr1FDKgNAqM7uceTvFzSk9ZR6E0qOBIFiHYvHRqsvTA7zadyf56t2
         hrZdBCnDr2rIyik9+HMuSzHcm1/1ae/OEUCCDr5AHIwquS2a9n7JhhKg5Y2DxyaXfuqu
         sJ75qsS61AQ8T+owPXTI64e32UmYGQPVX0hVhDViDAeC4gN2591txZAlLTrLIMT5PpOH
         7h0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757677024; x=1758281824;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agTs24kXpvfK2NjZ1FaOGupYKSjo+weNDR5D/xFPjyE=;
        b=DAANjeJanDzS5ETLqzFMcNOTfSV/IoPPcRgeSbcIyjaMBKf7h2kmLXNVy/YRtZh3on
         SEcEklLh0EUeTLW1qgYJUm5G0Dqss8n1FZ2uUauzNOW28lNzZMVkx5+rTqsK8zf8JzBB
         otgoLdLqeTQqso8ITKtOc9zCIipHBzNHFMkxMGv/+WemjKzD8oOUeGGHrWQZLdSo+4fA
         DdTn4c6tlOs4H7/6GYO+9ZjIryjt7hyuF/ScahmiGmQ8OOob6nV7um3VE5R1J07u7D/l
         szo7e7G/XpmNJfXRKAtcgxnoa1XDA2VuajM2kBnP4U1r8w5f3qNq0LKeE3SnyQSgPwMg
         w2Hg==
X-Gm-Message-State: AOJu0YyYs2wk8DrNaWKoSX/v1RO8QSD0QYKFciJ+EFxypVzNIuj4pIw4
	LBATFOpZJL8/oV4Dbcy8OmuNNUwcWlOMWESMDgW1crU7kM7hxSlgHdApMRLeCg==
X-Gm-Gg: ASbGncv9PNp35XebZage2YSl8BDEv1jYpWlLm1HP3lgsp1PSEQpf0nlCx/t4rXMuyTr
	qK5rjtDcCZkkGQdZpbGshSq0GLNkEFuChGxl1hdOR6O0HlmIcP7VrR93RmXQweL2qESEyRIMyNT
	h1xLnHP5SlGghyv+KFzXqkUsomQaP4L7BxKlo3L46MOqfljKUD5EmG/ZT8hIrSZ0eFM8CaECXnw
	zw1WlxFX9aPABdoGwlCwmhpJiAkMfCcMlPSskTlZ6sPrk7+/R2gRcX5FAliSVlrsLgNxLe8X2Ds
	qNn5o0kDjumv2Pot9CmbkMgwsCiypepax68NSUye0JFlQ9+ohfUAvhPgxImXMcD01twr5i5JmuM
	cpUl/2dwWTesBAoe/p/NMELJUx+GxqbRmlA==
X-Google-Smtp-Source: AGHT+IHOXut1I/Z15yQu3rGyIZEgCBIGbBt3BHVc1SqSraXZwCae3IepHS8Czi07Y3I58t3FyF/w4Q==
X-Received: by 2002:a05:6000:22c6:b0:3d5:4967:1886 with SMTP id ffacd0b85a97d-3e7657811ecmr2096629f8f.9.1757677023763;
        Fri, 12 Sep 2025 04:37:03 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e7607d77b2sm6491829f8f.45.2025.09.12.04.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:37:03 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Fri, 12 Sep 2025 13:36:09 +0200
Subject: [PATCH v2 2/5] media: include: remove c8sectpfe header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-master-v2-2-2c0b1b891c20@gmail.com>
References: <20250912-master-v2-0-2c0b1b891c20@gmail.com>
In-Reply-To: <20250912-master-v2-0-2c0b1b891c20@gmail.com>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=rgallaispou@gmail.com;
 h=from:subject:message-id; bh=ujDEv08XqW7rfLhPYFByABK56QwgaG48UU/oBf6Umk4=;
 b=owEBbQKS/ZANAwAKAechimjUEsK1AcsmYgBoxAXbbHsyzdy44VlXwGhO6OZBx2i22mfaSN4x7
 cadnfNuO8eJAjMEAAEKAB0WIQQgmXv2E+fvbV/9ui/nIYpo1BLCtQUCaMQF2wAKCRDnIYpo1BLC
 tRcVD/9nFbywKwcQcdzW5NDPLqob8jPfoJ9m7ujpVDr3PyQE+T5FVIrcEmk4/bqxHw4ticlM4T4
 NrqTTLxdBlLMprrBWIoJGP+hOHZzUchcn+bIBsjGQJU5mD8uPBYNOR4sWGOCMRrWB/q/Jl8h1cf
 bHbfaEgEPAZZpoYgAStYq6g7nfdvh/UjXZRC5y1Pl5IN5UtHNLWxXWqQZxXmNBHBJtLfr9p0w0y
 x0RxbvnPWydU3JXQpDODyBkbLyyOcAazoBLyWEe/uzb1OW0pjnuMYjdVSwfL2iNCQatG9YWuxNc
 64Fj8AgKA3qIVWD3aqbb8qEE4MiEpxbY3vCmHFLaNalh7pO8agSXQainf0aOlzuOEq54Cg2+Mfm
 roXQfRybIa6XPZsqJrCRJHtwzLwyMH8inDRdx/gwIJlEpWqFgn5wRvU93dWCPf1puhx1T50Lf9F
 YhY8aGfrr/7vVUXRf2zE794A69xHzxEaz/7BZXKL6m9J5Hc0IbsXjESeQBbso/DpMTr0iAd+HsV
 Cg6sXBnL/Iq3RojEWpjZuczYT9helpbhXkX0ighKcf4AKZQNGeuxpMj9FmEduIsasg4oenfBMA/
 wjNBXGCgd1CL1ATztFuRN6O/l+w6fbLfA9andVHKAd6lDgdSn02XIbSuqVJHZ4q/DFb+ML+dJDp
 D+RHMnDP9W2ofdg==
X-Developer-Key: i=rgallaispou@gmail.com; a=openpgp;
 fpr=20997BF613E7EF6D5FFDBA2FE7218A68D412C2B5

Driver is not used anymore.  Remove header file.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 include/dt-bindings/media/c8sectpfe.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/include/dt-bindings/media/c8sectpfe.h b/include/dt-bindings/media/c8sectpfe.h
deleted file mode 100644
index 6b1fb6f5413b8c5fbcf7dc2d786468ee3428caaf..0000000000000000000000000000000000000000
--- a/include/dt-bindings/media/c8sectpfe.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __DT_C8SECTPFE_H
-#define __DT_C8SECTPFE_H
-
-#define STV0367_TDA18212_NIMA_1	0
-#define STV0367_TDA18212_NIMA_2	1
-#define STV0367_TDA18212_NIMB_1	2
-#define STV0367_TDA18212_NIMB_2	3
-
-#define STV0903_6110_LNB24_NIMA	4
-#define STV0903_6110_LNB24_NIMB	5
-
-#endif /* __DT_C8SECTPFE_H */

-- 
2.51.0


