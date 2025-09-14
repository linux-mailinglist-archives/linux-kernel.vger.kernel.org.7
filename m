Return-Path: <linux-kernel+bounces-815638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2166EB56947
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC34189C723
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DBC221FAE;
	Sun, 14 Sep 2025 13:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6+UKgGD"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278081D9663
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856129; cv=none; b=ZhLQtOoaMI+BdVW64W9CSB3vsH3Fc1Dm4W+iozZCF96jP2bHegvw0VrxJpY80KZ8W718irE13Gs+RXi1VXxCycfTwdw+LCabJ3O8vKD/7IQiQ8qfYNXKnoMxM5DnlEwa1JSWbhf4toklnTg0Wp6ksD9o0HjwIq2GJ1lEOiGxHnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856129; c=relaxed/simple;
	bh=D+jsMAX5sO7tM7JCwP4lIE5kV4IK9JY+U63ovtSevuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bN5WtXzISa6Fr1ZfkGIUzB2d0DnwA5CPgyPCAaxY7ULSYooAAvwskfEd4PG/qqFJc3U/wugTDVxmdAO0fNobegyjYrdEQbbBXQgTCvdXatXZNzDv+I79xs1Yy14iRQTDzz6UEjD/EEuNaXy9V3QpGiEzk99AIZqAli2RK217zls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6+UKgGD; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3df3be0e098so2001594f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856126; x=1758460926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0gwU2jvcuEz7Zmi2rF3iYuLef34+LUaEBtsQc2TxOPc=;
        b=H6+UKgGDXpBjQelfL2yrkcSgIbnVCS+reMOREteoSOhB3VOXmfwkqpmxu6Ie1x2Jlt
         fig6llTKXCF8mTRU3fqhvxdLwgTkh1rhNwlHmAggvKNNZdI6MKIqh/9iA7ZPMIaNrvsu
         6X0nQAmqwhGAG/H+jFULf5xVHCzmjRnC5aeXCaY1R51sQp4ojphTqJKVOdqwWozY1mdb
         8J3kflnotSEtcUFJfqyFKOvh9AMj5mXB4tSsMPUzZE/OEmI+XrshBMF2B1lls6hZ0vvT
         9FZezbDrWkETuSQnUS4rghdibCXtvvSQj/0i7zSXgljhX/ZVIJHAv+CeWge7mhhScu5E
         fYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856126; x=1758460926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0gwU2jvcuEz7Zmi2rF3iYuLef34+LUaEBtsQc2TxOPc=;
        b=gYnnGWYLsXW1Yb7UoJIuUkLtF4JUughhnlEZ5gyHtIKim4rW0ysm8Ro2cjMuw+He3e
         XTK92UOPd3396I21Mf0Qzs+9jm3p7OD7/MlPjYg6gM7W00Cf3djgJHOntKfv4NkXWHNl
         sfPfSvv8S0pIUpCPKXz/JjAVY6PJjNAJ+ex69gjOrsmKCxxumyzfR6W8jwC4HZQYw0Vm
         B8HNWU3LqYOun1Y5SpdOKRTPnB4tbSTOo96MGovunuEFDe8GRsqhRUJLV7tok2GSu5Wy
         UmI64bnz6ZkQFKzldeaB6mPhW/neGBcFWZNIgLrW3kgr5V2S7Kw9Nn+u8TMpCwWNC2CP
         U5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCW+z/eP5iDiqXZ6ji1uwWB8IllX15NGrLY2DTqygpwVCCcwd2XW6PTw6KNZF6YaPd/B0Kif7QGfWlMzBeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzEC0yD2hlBr1ZIYLvKTQIfbyzaSxbVCTN8a080PdNnhUgLAcc
	cJEY+PiVOIe8Dfwe3xER5C8m0POEPAB0E7PDbo9F6YB1Xa+bXLwfDesz
X-Gm-Gg: ASbGncvX7WNfGsVdoQj89mvdU+nDX533nwdcgD8R+LyRRxmk6LJGJhMIL2tqmCTrnKu
	i93+0mkVMflFYDTzcafoBGUON37FVubu5FiN1MZxffhpaTawXGAJN2isW3U1NtrtIE21BNUjO4u
	CZd0eosSGPRLjSjZK/lbySpi0eltKc8ZfIRXTpqRBdbmfTZlaFcDFEIfEPxweTGtwRKx+IjsKqg
	yk/6S9yEStnb1rVJh/wlaznoMXah7zZhLdZN7SreLNNiZjBn1ELWig3BAQh9barXJG7o8Zn0MQA
	W31CnxzxqFT+oQOglTU2zzEf2aQavVlY+Dzk2vE/qq5BVn+mr9tzPD+kse/lXu+tIqKSL/5UVl0
	WZD8b/Ao6zfZBGKAwSLdZyQr8e67mrtfR7LL2bqtN/xs4HbhE7JOEmTrnzZl+lyz1+RJZqJ/GFa
	9PI5mSt/N/
X-Google-Smtp-Source: AGHT+IE7WXHLfVH2u4+DSdlsFQ3ngfdBOj6lQTdYHkhX00KlElTNErFlDHZmemjLFy+aNAvICL1RWA==
X-Received: by 2002:a5d:5f42:0:b0:3e8:68:3a91 with SMTP id ffacd0b85a97d-3e800683aeemr6491401f8f.60.1757856126372;
        Sun, 14 Sep 2025 06:22:06 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e80da7f335sm7274707f8f.8.2025.09.14.06.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:22:06 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: serial: samsung: add samsung,exynos8890-uart compatible
Date: Sun, 14 Sep 2025 16:22:01 +0300
Message-ID: <20250914132201.2622955-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dedicated samsung,exynos8890-uart compatible to the dt-schema for
representing uart of the exynos8890.

Like exynos8895, it has a required DT property samsung,uart-fifosize,
so reuse support for it.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
index 1a1f991d5..6ebe8a869 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
@@ -49,6 +49,7 @@ properties:
       - items:
           - enum:
               - samsung,exynos7870-uart
+              - samsung,exynos8890-uart
           - const: samsung,exynos8895-uart
 
   reg:
-- 
2.43.0


