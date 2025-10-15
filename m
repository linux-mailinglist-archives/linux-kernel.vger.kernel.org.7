Return-Path: <linux-kernel+bounces-855211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E49BE084F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44B1A507F27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326F3310764;
	Wed, 15 Oct 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BEAn42dl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558430FF01
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557482; cv=none; b=iCeJWuY9LemWYGXfDCCnNrf4V7CsoyrZ9ZpuuASoJ79n9aUvKU8+kgc1/GcJgbQr1zTU9RKrXqBNXnmHUUkKJn1FBhZPl9g3BZWksCkbtWXDhsELCS06ZOqvxSEYkpAZSvNqxgpK7XEs/XYT4wp2tkZPVSKADH6iMLH/AR07RZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557482; c=relaxed/simple;
	bh=MBbQJW+NHrsJ62AtPx1M8sE2HSBkT7GHiLm3T35Aq1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZllaLGhh7tXIen3bgk6DEGG36o0dkkaIaTiyUqZWZ54S0PxEWJF59itFUrrqM70sYEVpN5hYVlD6S2BNfpqq+kUqvfaGaaNGjzLAxG4Sg2z4QH0SzD2qUTFmac87CvnBHQ0zWJI9dtokMsRsJQAW9LQLmNULRMJJl75sJf1q/70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BEAn42dl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3edaa784f6dso435083f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557479; x=1761162279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hoBQP/hGH1uLF8kGVmHkT4rf/U0Rs81FCeVO2XCGGEo=;
        b=BEAn42dl7ZGNnrnb8r0W5chHjp6Y7LTCwur1yfKyvkJ6GGyrD9ker/c4eFr5OsXbxy
         sT9ABxkpEnSG0CtdT/IVkb1GcleI3cVgSg0gyEISPt1gBx5ZyF9W6ygw1luTJRIPpi+O
         S+3zBQ6F0yJfVg7Kmd479TVPTYJtMexMitpmb2KTpLwBtxjNPDOiznqH72l1buIWiq2Y
         J08i8lR6BifEQWNshKdzgC7Y+Ca6deq4ZPpO2tppZXwj6UKhjf6QR1fNDbkbgNrfADyI
         /enOdSxsBD3y6tkp3l6ZIXmBSr/bcdmRJxGSH1plymSHIXSpONmvA57MSRGGkJEStViP
         gF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557479; x=1761162279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoBQP/hGH1uLF8kGVmHkT4rf/U0Rs81FCeVO2XCGGEo=;
        b=AIoing9YwQXN3gjzvUIK73B1JLY0WdmoSm8R1zrs6Ze2usedH+pq2tGSQ1GQ5/styZ
         gteR5vXC9p2awzNJvN8bfMMx1NM78gcH4aiptXoo5IfZsFgbTeMmPyvItoTaDckLqL1W
         QC6zg/d7s2IswuDrqQZWx6vaDbvS4p02U4F4sqawq/IuREEbArh7bzKAS1T/UcnQRqvv
         ipZSJbY2KTR7sV4yqXd0luN01drUIGJL0G5InV7s7q3M4WNV4n41ZJ/R5RRWf+XeQGm8
         KI9w3TWjUdWWSnpUGwKJfmv6IdlvvjP1w/6pr3m5id4+Vkm56jt6D+nZ+wVVkDuFmf1j
         dm1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEjPrC34yXKaD+Di+p1zCdeJjhbwOr6VurzbO6UMVUygASKf/a0l6eeh+nL3hoTXHHHj1PP5LJD1iL3ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtM6va3KwVcpWvgKLlZF+mUnhqlbZj8qyAOqPyw0QAb11apgU
	1SanFvgN67IwR3kQYyXX9RILvf8OlTr2R1VemylI6iuAh8w1BnjeuLYB
X-Gm-Gg: ASbGnctkL4PMEEkCTkvaRHLD9mU4xSW2mCxNi4tABSFFv7V9rj5VQLcBB5I4ert4j4N
	TqMcHA2QQigz4zfh1Tp7IyghVa8y4pt+Aa+WVjc53lmeQN9JmEP/eYwiPWo8CdXYvWWMNJe4Y4H
	Hi5hLJCWFr/Q0gTpTfE2S4zOUNyW+GyZn43/jikusKVLezC58TR/Tjd9Tb1B66wt0dKK72FwZGN
	y4Qh7httLDeqpJBNvUOlUTwrLQS2zI02I7F83Wda6FBoq0GRwroQA0M5PCWEPmPDcXdNpuyv8p3
	TM+pDnamDEUWYS3PHKJzkaonrBGnhetSvrE8AhCMVnmXd+z1qZzBb9K7O6MQdwKAs6KTKqTB5Kr
	fp8H9wn0xdu8DEdB83JskM6FCTdGHVpjPMF73UMAnP6gwIWIdbz9Z7YmFRhlVZNRCVCHC01N7+2
	xLs726mfP+UCtTaA==
X-Google-Smtp-Source: AGHT+IEFnPBBNgrbjKe/zQNquXEgrG6ZSegL+rvJWEPlqjHP4bubJYt+JfDeTNKd86AxPjjrP4F9Kg==
X-Received: by 2002:a05:6000:604:b0:3f3:1695:7c49 with SMTP id ffacd0b85a97d-4266e8e0af6mr10229731f8f.7.1760557478658;
        Wed, 15 Oct 2025 12:44:38 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:38 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 10/11] dt-bindings: altera: removal of generic PE1 dts
Date: Wed, 15 Oct 2025 19:44:15 +0000
Message-Id: <20251015194416.33502-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015194416.33502-1-l.rubusch@gmail.com>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.

The removed Mercury+ AA1 on PE1 carrier board is just a particular
setup case, which is actually replaced by the set of generic Mercury+
AA1 combinations patch.

In other words a combination of a Mercury+ AA1 on a PE1 base board,
with boot mode SD card is already covered by the generic AA1
combinations. There is no further reason to keep this particular case
now in a redundantly. Thus the redundant DT setup is removed.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 73ba3cbff026..db61537b7115 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -31,7 +31,6 @@ properties:
       - description: Mercury+ AA1 boards
         items:
           - enum:
-              - enclustra,mercury-pe1
               - enclustra,mercury-aa1-pe1
               - enclustra,mercury-aa1-pe3
               - enclustra,mercury-aa1-st1
-- 
2.39.5


