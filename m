Return-Path: <linux-kernel+bounces-852911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10290BDA360
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 81CB9355FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C35B2C3265;
	Tue, 14 Oct 2025 15:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAA+UG0E"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95692C028E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454266; cv=none; b=b2Ppaqd5+LZGPU9AuMfYv9C0Y2VHsIo4aSpMsJJKPJ3J1V1gZLPOQcBzIw4UDHBO/BBP+mvlPuxXV6xrO5dSEH0bvk9WJc1Nl85vTaVnd3AHjLq6EFX0cuPqOOH2Keiyt0qFKBHk29bQoQpqnjKS6129KV3QkTEOzHpn4LcDwBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454266; c=relaxed/simple;
	bh=octx4ZTnNO/R4DCoPqgavGVNNjwOBSkdB0RJJeuCRxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uawVX+WhLoFnJcFs/8tIBO/hsRtbfTidz0M2/1wJzqPu9KsPRGxcGUq4R6PagYvuD2vRFL09WXw1hbnhHWp0LXQO9FJd33epegReuATBvV8tMnMWndpVvtJOHMuY38gJcukX8IAbrSKKpPbXWr9wya6WjJx1mp768wOW2djMM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAA+UG0E; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7835321bc98so5240649b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454263; x=1761059063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7IroGFfuMHil+70rPWoixnASrFWM1LVOm0U4Tub+go=;
        b=BAA+UG0ETnBrCzFeZ3UYo7cyDdqInlevCxBpEudaJC8W+Mj8y/GYYJIocDNC8YRS9n
         UuPQOHODrB437rPc2WP0nASn1dLxKQohvJtA3aE+fXhBDyJ68IbX24AvHkprJETscxQ2
         X3GlXHlpiiPwVZkPRtJ0tTxsaYnXqrNQbMZqTeojebFUCUTaQboS0TB+5ual25YIeGQ9
         sNMXniPXtOBo7hZ7bI5Ms4H4+FmBRck1MiPh+5ZWDvQk8AloL5CFv9ADYO/8rNy9DzFm
         RttT6rF9D/PQzXoa6ZJK67q/ENxuwBxnIeAepUoV69AlI8wnt43/wyf0honR3T/BvJIP
         qpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454263; x=1761059063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v7IroGFfuMHil+70rPWoixnASrFWM1LVOm0U4Tub+go=;
        b=ZO00aM+u0h9Khlnr7q1ej8fZYsog9+zob7yikUhXcM2ofAwHBpRMVL2GB8iOtY4o/4
         9GrP7l68JdsSmSoRMUyqSARV+pyAHRGU9V6AVxy5GXfu/Jd2n4RQ1thIkB7UhpM3q0Si
         9rrlJTWsdvhCVpVE2vCsbhFbPDVsmGmIWKUmsv/BvVW0bf/r/wjDCb0FzKf3ocPh3Eu3
         ujaTGS9RB9+mHbzGR7h3dQEYp2fA6IWfo4R5wGWWvxu+A4aGHPKrxDHQ2qqEB/puibOD
         vAwk2UVLXylJCIOVjt60hwVU+l//+hemixVX9qibGLK60tq9A092G12xqTJ7km1jqNc7
         Sh6g==
X-Forwarded-Encrypted: i=1; AJvYcCUgQJwsE1Kv0wHtjuTbcQKdD21TP4qq8qEMd6GQBBWMhT3aAG0C9QQkO2JYHiGwv1HMqIFBAfzZMLpzDjI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp0w3ctxpKk6oUEyP3Tzr9xp4pk5ymGRJsNkPZnSCiq96T/xBy
	7d21INohWNw/s5Oc0niIie5DIfpAOkYEP/qIxR2rE/KAMqR3fmsi+oWt
X-Gm-Gg: ASbGncu6Ze6PyYIXiZMOBly9jqy0Eo2YLUSW+RKlUv9ofPjtmLOv3VMRoAvmSx5ACMV
	DECbTRlxIaMDEKOUzk3rc5SoUnWkr+mAKv4JQyTHbnHPs0tOjrA+51/csUt8l3wkvBbTEJOs4tQ
	6m0N/QfMbg2u1dC1z0xrSyGcrl0jrLR68Aw8eXX8ar9VTGSU01lQzbIiIPBkqyus69DWxrWrJZA
	YWJCG0fCxs5GCsaG9yJuarOfRdumXKkr0B0Gha8iVv4Z75r/M1PsAO5NoYOgGgAHUuzJiW4HmEl
	PCt9M++dVLIE9VfQCKOkTsZMUVmLteSOdvXwNnWOOIQ1Imfwt7HU5TLgfVfuCQnRvOAX6D8cHyS
	LrcxGJBqdwr7y+xqFX1Yd3nYkI6Z7pxNt4HdYpCq89kU=
X-Google-Smtp-Source: AGHT+IH1Ue4p5OCLX4CRfhF+JPw8oqTqN7O/BSJ9WA0RvFwdGeAb81e776hbse5RQcmrAj2fPtdD1Q==
X-Received: by 2002:a05:6a20:72a2:b0:262:9461:2e59 with SMTP id adf61e73a8af0-32da83df936mr30917032637.39.1760454262600;
        Tue, 14 Oct 2025 08:04:22 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33b61a1d3cfsm16258161a91.2.2025.10.14.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:04:22 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Tue, 14 Oct 2025 23:02:34 +0800
Subject: [PATCH RESEND v8 01/21] dt-bindings: arm: pmu: Add Apple A7-A11
 SoC CPU PMU compatibles
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-apple-cpmu-v8-1-3f94d4a2a285@gmail.com>
References: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
In-Reply-To: <20251014-apple-cpmu-v8-0-3f94d4a2a285@gmail.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Sven Peter <sven@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
 asahi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=octx4ZTnNO/R4DCoPqgavGVNNjwOBSkdB0RJJeuCRxU=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBo7mZsiLQHOHuDXQKieC7EAHvU1ZyAcFv2c7NnB
 u8sNmO0kKuJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaO5mbAAKCRABygi3psUI
 JERND/9BESP2xLUOegwP5HtDf4olDrM+n/Nf+ieBcAXuVPuWct0DXG5/WilKWfA/ucbdraT0ZRA
 gOUSCkdD3PQZhOkfiqLuI3yNYdJuwSBep9h9IaoibF6w+vX9nfD3RXq0J9HUhNwkBuLQUKiHvL5
 1XxrLqauIaAKgo0IHvcsfxJ0R9yk5fg0i5X6pZ23LgUxQsKuou04zkS6NQWVNa3XZLyerev5D15
 7V886q19ojxV/AahWKOAG+uJQlK/SIq4V7uU4vGicAiOVQEyObgrHJ+75rqRZXltRC1kmXI1Eje
 qAVdMu9HHQtHNfx+RTVLfZy+8mQowXCD4mS9uI2RSanf3NH1NXoc9xC0HJZ5JkWwwkznuB4180a
 mSvILhVUtdx5ga1P1wDIfsqE/qEof8LuICuv5dgVyTgyrfDhyKtAkcRubxx4Lel1KaxR78REw2U
 W2jKUc+cnwoK3KUUFXD/3HlMYZKeSjcQe66yYTkObNJh+6Gy2XAhRbK1A9o1NEygIU9ut3Gve6K
 Pw8moaYQpAY3niul4GMPotz8eiLK7zPkJ7dmpvdjfFhf3CkJknFlr3R4njVOwJsYB2L8pRBckMs
 0OaU1t835QMSvdx7T9iSt08WbuqRsE6DPyGeDJpz+qljG4VeDTUXjt0ogUMZunmHAnS71rwACto
 xYZpCZlxPxOXcsg==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Document the compatibles for Apple A7-A11 SoC CPU PMU.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/arm/pmu.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
index 295963a3cae799a54560557137dd6b3cf4bd00f9..3726e1b78c42f150cf1dc68a6b3aa3541517c311 100644
--- a/Documentation/devicetree/bindings/arm/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/pmu.yaml
@@ -22,8 +22,14 @@ properties:
           - apm,potenza-pmu
           - apple,avalanche-pmu
           - apple,blizzard-pmu
+          - apple,cyclone-pmu
           - apple,firestorm-pmu
+          - apple,fusion-pmu
           - apple,icestorm-pmu
+          - apple,monsoon-pmu
+          - apple,mistral-pmu
+          - apple,twister-pmu
+          - apple,typhoon-pmu
           - arm,armv8-pmuv3 # Only for s/w models
           - arm,arm1136-pmu
           - arm,arm1176-pmu

-- 
2.51.0


