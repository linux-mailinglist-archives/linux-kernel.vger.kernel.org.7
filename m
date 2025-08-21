Return-Path: <linux-kernel+bounces-779310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF75B2F27D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E01607C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9EA2EBBB4;
	Thu, 21 Aug 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEmNxmHT"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF22EBBB1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765133; cv=none; b=Pl9rE7escPYaE2u8hB3nS698qUpCVlJCPiy7vz0aJmcKvuWNXGzTiH/CQn2bQIyMzSZ/Erlw+vpymFg1P2uHwMBN3trpJIqW3iPNLaMNh7A+lYi4WPIAkslHHP5wlNrPtzBC2v3hH/HnvLROtFFYYgO67Mu2vWEKmcvx3bmcvA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765133; c=relaxed/simple;
	bh=tmlq5TL4b9hR5e4/dbfvMZDDic0MixP/CpVI5rMMnYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSCi6a5C12VfPEzB4XKsgpxkRxFiSSrs9gqpO4LllJqI8q0ja9T2Lu3mew926n4VFKOcxI2SfYAL1o5/wwCSzLt+FS1mBtHLGHQGDHEPz6pa8B5MB6dvCqNagDR0/yymMho5FYqz5GWeMhwpGdc2OIXdZTypxsIfbUI4E592kNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HEmNxmHT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b67a951so138766a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765130; x=1756369930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRvAzDPMBGNTB2v30IPH7YjhXyJsEociQ69t9ryyTSo=;
        b=HEmNxmHT1r+AT4YAu/omZ1TP5BwnP31sfav6csaOPjR9WyviL6ujGU04HcOLN5ZrjY
         THCZezcXAcs2jdNIlZ7PjMiiBtuuK/k9oxscnYuW5nHj5cgUPrkj8WoH4l79lw2LWjfP
         pWKO2RC6q94dk8pwBZ5mtL9X66c7CcHMaJyt+Kio3Tm0DHe2d9orJimPxBWcbQrYowxW
         iH904DWKfz59W4qoXh3e4jNpiRxVsfjKFm4jnzHZLNRjb6suUbGI6J7vSP5SInj29Qfw
         9LQ0/HOogu/OzsD7nx6vtMdb5+5meiqYlBguQp4h1qRVAK2esHbYY6sjr9N618jNwET1
         qisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765130; x=1756369930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRvAzDPMBGNTB2v30IPH7YjhXyJsEociQ69t9ryyTSo=;
        b=Tz3T0Og/vUL8kTLPk3UFhMnUmDAvNfkD6nlJawYyKYr4erAtOJX/IiWxitq7AQMWqD
         NcfaD7lE06pWI0M/1DNngqkr+c1oTVwzsoX3AXPaYp+kEK/z/rnB+QbY7umqN+EycgWn
         7u2rWvq9kQvNp49HcFBCgKg0otDz1MUWObpwmKcpXWPxSJpDf2STTQ6r9aqVRMjwhdwl
         p+u3RfP598wuWyYDz/y41oD+KNjcL+/7Dm9+Imxl3UfGqeux3CRGcd9+5zy8oED1r3Y2
         KyC6/4LSZzfL0YrXmqcTt0SFRyjN7YJlvnFf72GmkLji2uNvGxjYUNzR4m4fOg/nb091
         sDlg==
X-Forwarded-Encrypted: i=1; AJvYcCVUap883Z6o1IppjTOiBGOmVh48TKSITpOHp/MwpBoiDdcOqJICexusO4P7yXAxbjABQRzT3fhAY8fOCAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA6LF+6KBhunWHyCgn8akfsH0W15A2MkniwZx9cvBjX6nCJHbc
	mjxEKS79ZFC9M0Isx5X3kL4d33+x6K0miiBJcjJs46SrF8Yujz3xpMMVUjA2Zz/6/1o=
X-Gm-Gg: ASbGnctdIJS484ohpymxYG506nyNeEIW2/7eUNfGn41C85kPfuUd8sCIQqMO8h1/bty
	QaGZiMRJMyLjW9GwCpQVULhxcSg4EFuDdXo1NHALh09BxCX4qta4mbREV6Nqr6AMpXClpEgYaDD
	cpHlnLNgZ8aTpMl4NiIZNFHv8HFBY3dc+gLMK7GQag7Z/RPRF1K5pr+tGwzkeJJ8QF0GI0a3nbz
	F/TQwe6QtRtEGmb7b65iyq8XwIIIPZ5TU+5aAxMSggCSA6sav/jY1rbp37nOvsk+TsQzl/3Brd6
	BoIGOjrInSssSaeXaCSRldS3HuzVdOvlimPGlCeZk63XSrxMyYx584L9fnrwt3hijaxB54ggQ+h
	zTJKI/7jidvcarGYlqYjwvOm2GB4V0qCYZw==
X-Google-Smtp-Source: AGHT+IF0yeyXaXIgpuu1Hv3lLvysTAldvCSV3g0j/RrKOaK78LX/7Pw9plJf47pUTviNVdCxtnVOUg==
X-Received: by 2002:a05:6402:40ce:b0:61a:1fb2:3297 with SMTP id 4fb4d7f45d1cf-61bf8752115mr668450a12.5.1755765129957;
        Thu, 21 Aug 2025 01:32:09 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75778077sm4761880a12.35.2025.08.21.01.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:32:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andi Shyti <andi.shyti@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@gentoo.org>,
	Troy Mitchell <troymitchell988@gmail.com>,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: i2c: spacemit,k1-i2c: Minor whitespace cleanup in example
Date: Thu, 21 Aug 2025 10:32:06 +0200
Message-ID: <20250821083205.46600-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=tmlq5TL4b9hR5e4/dbfvMZDDic0MixP/CpVI5rMMnYM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptmFHk9waBle4RJFYoExNjWScWzn/KVPJWdEW
 BqaXrS6HQ2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZhQAKCRDBN2bmhouD
 1x42D/485/LVTQzYX1z8T4Dqq80f8hCQ+UNg/m5AB19ZV8QDVlKt9PxBtXSYVlrqlxXdGQNHCSt
 LFf2hNYV4kNJJ+h0no1myzXlxiZ9WTZgrMxi30rVtI45a7F/oSaDRvYeXuqO/Gdrn1mUYd7Y1Vj
 Q624yu1hlY7YZwuj3XOyCFCMLLRSfOVmhJWLqJwGuS+4KCFfrb2YepHxi8ASZ5xbpWadcUj7OhQ
 Da4NJRGWPR9PkJh0O1u6HIMIrmWv6xW68tYEvSV/VwZDAwAXvUsVWLDBtnGz5o/+5+1bz+5Fxmp
 fJv8nRx5XnfNkhPbNzy2v4fbLJPdl/V+txbIcpSstL4K6TzBime+E1H9TBfD6AFS25ZgnpnIVyo
 oopwye1lfa3leqALpx+l6SRr5R7w8FrZmfK0C0IsV19Lk7eJTPxl9R8KnfFKAtVe/xoLmH2Uo9r
 SjR6c2JH5JL2VNFDmgTG0VZ8OqKsFy+neJ7tqzWI7vbMCJL/xY9eyVORr+41/QyeLu7poqivik2
 nrquKx1qCgtciT1Oxcxi0H3v+KiNp/l/hVlnJEdHfpZ/u76Z4tZ7UOeiksLT+jWbXUObKM8Mi7B
 3LUIMoaw9qrvLJnSb58pUofJauL/oGGv23A0Xq9P6+uQZZtC7HyScojqleglxnzrviIq027h+hS h63Oi1GCs8FPyPQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
index 3d6aefb0d0f1..c1a3004df71d 100644
--- a/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/spacemit,k1-i2c.yaml
@@ -53,7 +53,7 @@ examples:
         reg = <0xd4010800 0x38>;
         interrupt-parent = <&plic>;
         interrupts = <36>;
-        clocks =<&ccu 32>, <&ccu 84>;
+        clocks = <&ccu 32>, <&ccu 84>;
         clock-names = "func", "bus";
         clock-frequency = <100000>;
     };
-- 
2.48.1


