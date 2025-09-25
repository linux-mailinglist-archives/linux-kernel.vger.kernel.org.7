Return-Path: <linux-kernel+bounces-832075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FD1B9E47A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75C6216CA12
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BED2E9EDA;
	Thu, 25 Sep 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaU26Zrs"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953B2E9756
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792088; cv=none; b=j6OvbiM45XcPpQOmN2IMwgvt2dHcih28qY0T2gC9ZwNOYFm6U2u4N2pSqw/zVrgnU4729DNhkYcgfq72TFqxf9BxMkJBt7IOJHcU48GIq5RAePP1cqbM0I4iXdhXWexsVDZM9XLAyUTmu5CCzKt1vF4YGVxnJIg5bJnIQY9CEV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792088; c=relaxed/simple;
	bh=MkXy8B0HvDpu3XB7QRokGYJw4lWQNt80EBtTGcgIso0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvE+Ob1fJoDONKF4fr+tXgNL+I9oQj5mOIdkhSbQ+YWdg+eK+wJV9L2+nCAv/vjB0zbwXzjpR62JRcGCo7c99kd9fdxbJ4PHbOELMYMWV1Q59RnjpM+i+MoBlxfNovVa5d1DZmVf1ladkN6nLzkFzYvH9qM3dnOfPEYCgkcoNhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaU26Zrs; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-25669596921so8138615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792086; x=1759396886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzgyK9PV21LUzCc3kELjlfdCuadwZ4YNSm8kpUWXn6s=;
        b=YaU26Zrs7N0UmkJ9yx7nOs0M0kvemcxjzNro0NhzKLTYBw9QAA/s5Gu/DLpqhJ+pEB
         Rppr9Z8apxk41JM+fui8OHPsNXP4ilcNdnl5PIMWj3IsZK2afENJDlRxRqC6lxQSHCPP
         Mu0R7KlE0LOiOXoOxQzAXIdYme5TB7o1ZwioVTXv1LhlZM+lQNTQ+9o7SSGW/ZbYBRGT
         4wyQ+ezatZGtyhbLF2hqSHXlBAcOfnpQe3ZFa02ScEghQEeoc6oGxQecRlv9I9+mmvS/
         tZYlnizdRQ3lcn/Iz3lP/Xa+ajZRY9U1FvT/yd04i1bpGtFpALmMuk9hHy34JRxxHCzU
         MXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792086; x=1759396886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzgyK9PV21LUzCc3kELjlfdCuadwZ4YNSm8kpUWXn6s=;
        b=JKZE70WWXsCdpn2LE1T+yh+kyGKxfQzy/9TUQfF5tIwzmcgBqAiIpcwUJCLN2D9eMo
         a57RvnwbIC3Vt64/89BJokvjicTM8YMPIHuCVUvCnufWEFXo+2zvaMZC4GDFkuNAI4qY
         lY7iSptWApu372OXNTJP3cKcCfo/V6GbnCWVi3ClfhqC7SHI6dDiR0pHmHRBvn1UwjqK
         WmbgZn6AXRUl5CwHMxfGzQCg0qHnl4aVQ0FVkOtP/FKMkAv8RP97XWP/v+C/pYegcHeV
         wsKa3RNQbDxarvsgcZJKGvC7LoizBQR2Rkb/Myq2kvos1JpWwwACx3sGwk1ompezyzTQ
         KpRA==
X-Forwarded-Encrypted: i=1; AJvYcCUK4IlsV+5r+wZWDpIS4pTFAZPinMqlSt4CZbWD7s6oMKvID4MHYissgazJ3P69YadV/l9dXbO77tC8mh8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqo5XkEza+e5x/6y8pGfRnQQw7d1o6BMUYD3swWOygPzZxigW0
	9Ig7xHUUvEWp7pITIovrkFDkAd1x3RDKTothMFXzgfETWJdbkCZzI7U1
X-Gm-Gg: ASbGncu+A78nKSv+GoW3QhVwOEp7a2VyvvfEO8OEN5wyPvK4sWdXOY94U57XOHhhH+S
	q/rZPPUX43j+y5C35S1QNusQ12LI6dIfwaY2/bZ0RI+1MgJwTLFV3cL41YHeRUv/WXN7vRJiPkG
	fCBFqKaK0FlIQx2gEKrBaCQL5JF2K0uSNym0fNZSDCwwaHOAPsEFqY4HZkqUXOrZpCyAz5RIvZP
	rb9EhM+A5LH+GlVwpRtOgOd+VKAbj+6sfaEjLiWsodCsG6g36Yvolw2mqGXfFp4ZV6V5fkQhWN/
	poIP/yNP97UuWO9GQhICwZlXvdXFhUOSoqu9SqYWCG2tdLGy/3zDun/Bbl480Z7imo4kO+Zqw8o
	PXZfMn4lcM9TlqQrlKD8+Mqlb8dmewSXJbaXZG0T9ew==
X-Google-Smtp-Source: AGHT+IGuddAG2m+l7uqXE77ohvkH5b/2O2Eh2v8gCidWDhuRqQvkIR0rtKEWmswxBoMYHW2Mjz5AVw==
X-Received: by 2002:a17:903:2f90:b0:26d:353c:75cd with SMTP id d9443c01a7336-27ed4a03486mr32626325ad.21.1758792086107;
        Thu, 25 Sep 2025 02:21:26 -0700 (PDT)
Received: from localhost.localdomain ([120.229.16.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm18251855ad.30.2025.09.25.02.21.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 02:21:25 -0700 (PDT)
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
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Document LinkEase
Date: Thu, 25 Sep 2025 17:20:35 +0800
Message-ID: <20250925092037.13582-2-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925092037.13582-1-jjm2473@gmail.com>
References: <20250925092037.13582-1-jjm2473@gmail.com>
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


