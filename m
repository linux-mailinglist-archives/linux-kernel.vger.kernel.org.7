Return-Path: <linux-kernel+bounces-762780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29829B20AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E57B420A3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 13:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28301F91E3;
	Mon, 11 Aug 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUBAWapY"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD621F3FC6;
	Mon, 11 Aug 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920454; cv=none; b=Zu4LXteRd2biqQb4CP7e7CCEkS2OZnoh/X3OPyVwn/oseAN2o9WabXqATc7ZaFubyEK1IrU7O0FLBZ+NJe/GfIzHTEJtNgeCu8Ka1YpOL6PEMHOksKGkWXW9TBg00DYNKz1ZSTy7LLQ4UpnZa6djavqT5gbZfVXoLtwB4x71BPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920454; c=relaxed/simple;
	bh=9HAo2qif7NcILZ/7noC4GfpbcMRkxTO9P77K8AEkp7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o43qwOdphwMMf8V9cr9KDR0emrFO3OXkXJPjF3u6HvK6lYMQWVi5nws2Y+bs4NWrNt311p20nd1bfrHykFjulb8HuROZSMC+UWaoZe6kPRVw0YwrSOahcOal8aOMxJ6fVOHoXu47HBf6wzAfpe6KGN0jVGe7SfRcXLZSerXqsLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUBAWapY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-242d8dff9deso17257235ad.2;
        Mon, 11 Aug 2025 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754920452; x=1755525252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGKMtQ+STHWX745bXtM33YEEtXLhlCq2s0TbaL9pJps=;
        b=nUBAWapYeVyVOLqyFDvvOax64sLfQqGJUwlIhWofTdv9NZThoCqkPWuqpq/p9SVyT9
         /MViYTdjVapY09cELHqttjcPtEgDXFEZt39zoj6aHp+6gR9no9WZCgv5arHYXl+z/D/o
         OmSb9jbgeePq6dChc6qxI8HwVn0PUo+OmxvTEv3RWUIDPNwo/SJz8RzaimtWn5MWCil6
         eNo4srkcHXUvX+IFET1npSbaUwEP5qkSGTutLVr3qXNjuJEUi1asfXIE5Cxim4M0ePnW
         uhuoRUkY3o4qOGezmPjlygj0yl8GqBMuAi8g6cz7xZac7BMsLyXTRhYl0r9BPqYsKSnd
         3+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920452; x=1755525252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGKMtQ+STHWX745bXtM33YEEtXLhlCq2s0TbaL9pJps=;
        b=IGcxuqZKrHHYga/f0twyppGk3ZKMuEvQ2Hoy1YFU0TTa8my2qwGot7KZI1VA5QoZGO
         OKewIPZx8HjsSt2bgjyu4ZG/6vbXSlJi0RFCXycGYkGZtWvR+P0MQjtuuiD5vtrqvLFJ
         DS0bLyy+P9Xzp1QJWgv+uUh823KAREdql+VuMWgsQ1lse2YepkQxQeiA3jFBE6EJQ02I
         KcCt93AnM0R3vL7I1U2PkGIIdO+XupzpiQXLnkoT/ETbnwMFazbmZJHDO9DSC3cCCtsz
         rsYDBfmRi4h4bB1k/1IfuAD4KEQJWDDEGyp/cSAedbdt5L7NtkPuItrwIzUky6oPUuwt
         Vbtw==
X-Forwarded-Encrypted: i=1; AJvYcCWEIL1cLcqeF4/36WIVAIfoiFUbhFjoMvjh3qu3ePtKWwQBV+Kpcz6/t3eY6bbkDqTNyDec853lxhQrs4jy@vger.kernel.org, AJvYcCWXhHv6tSjD/LwkBDC8rWMnKjS4W7HQA/3Z7FthId+oHtslw9/KJKIZplEnK+ZxicM4CZQbG0U7Tx9z@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4l2OQA0JdHYXfkeXuFcYJs+LtZGKZmSvGZXsB+XcmHSdoA/N3
	5wSxoPrAwE5hl2BXziwfTMecYs3Ae+b6F5FTm7E/U0lvm1T3o9DsRG/T
X-Gm-Gg: ASbGncv3MAr4nFbdhgIAc5uAtN9gump+D5phCahZeJrs4T6m9KnU6J3Mg/JpaZVUdtK
	xpyL4lqhYqmcRvHYcG3x86XoTK1g1TJljeR1zdilc8iAduJ5244l4OnmIkE0CJrtdPx3OqH156B
	0oRUZxf3/fxuT9kaa/noCj2E5I4IFGcYniw2hBlC4s7sO1ZQKiGm6UYsboaCRaV6499SWM4R9kS
	OJ1mDbLl8wi6zXKd5OHZ5LvJ00YlGTxmXoIIOmGwAox6BHL2/Ul38lgEzkbnpEdU8930XrlQgQT
	N5gBS3qVaC7BrJeVIKhaMpEZ8EdFaV9tY7e9sZKOIigzxuN+jSpy/GAc7MEBtwNPfWeb4BHKu9a
	9MMz3T8h+ZbOgtRWOciRbVxlQeI7yd3yrfVeC3fTneM7dSZ8=
X-Google-Smtp-Source: AGHT+IEIZ1XBxPcTymwBYPPzyBCGW0yUeeVKd+RPAU+9jNiS+qis3B21Ff4YXGCY5xSPEvrFPxt0qQ==
X-Received: by 2002:a17:903:1987:b0:242:abc2:7f32 with SMTP id d9443c01a7336-242c1fdc798mr171527345ad.3.1754920452155;
        Mon, 11 Aug 2025 06:54:12 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e899d272sm272976285ad.135.2025.08.11.06.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 06:54:11 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 11 Aug 2025 21:53:55 +0800
Subject: [PATCH v2 1/3] dt-bindings: spmi: Add Apple A11 and T2 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-t8015-spmi-v2-1-a291acf0d469@gmail.com>
References: <20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com>
In-Reply-To: <20250811-t8015-spmi-v2-0-a291acf0d469@gmail.com>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Stephen Boyd <sboyd@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=9HAo2qif7NcILZ/7noC4GfpbcMRkxTO9P77K8AEkp7A=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBomfX7zpLvmxW6s7UUY89esgb/8NQNOYxgktyEQ
 CIi3YkAfR6JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaJn1+wAKCRABygi3psUI
 JHyLEACfcKHMzV7MaDy5yhlGO0zb7Qmbh/EE9jV7lEBsA6WUdpVKEYudEZKG7frX7YqluWR2rrl
 JKJAOu9bbzMV0r+8x4fDc/pOSP4i9rL+ZPXcA0r/0MHCPIxSBbiAYWdu8N67QxNyGQb8ksvzgxy
 3VCVf25yoMTJ4NYKyPm/mLsna3A0XrYdPkPD5nwlof6Hk670AivzxmagJUFeZVXls7NK+nDg5g6
 9Y1Pem/ZRkF4//k+SfxXf8iG3WgboJt6B9UcitWYXqDi1D4of2RzBtfUAUlPDLSoIY2vcjHjWAG
 utKhXlWsHYGFoXsmoevSOtpEEGPuuKlFbEYCsoVDSwCLoFSoo5VThZIU814WiuBrLCOcEHEI1cI
 JDEXRGKaDMDDHxJrLZzHz2TX1RLpHz2xpppGBV9ytOt6Og04Pci+WnYR8K7d2CHv9OIMBq1Cftf
 C/KOa8z7oa+jVMfaGpv0f9NihDGP+LW/cg798sLv13g/d5Fdmb445S7XPcFKWQ1wAPfbyHUo6lE
 L3SpaiILTtDs76SU9RQY3V0pxiU1x9aZZ4VVPk4dDFgK9GwB62ttCk8D4/BGSBYg43El06fla5P
 ijtMF6YpEycsEBGi42THgas0zGp9ahkZKtDHkAg8bhQAFEqufiTEkITpjJm40DQF2Rl3UG2vLE7
 B1HP2s+pMXkRhaw==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

The SPMI bus found on Apple A11 and T2 SoCs are compatible with the
existing driver so add their compatibles.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/spmi/apple,spmi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
index 16bd7eb2b7af2c0b176f0e5b1970f4670af691da..e3aa248c0326c36bb0307e8aad4025b1bc05540a 100644
--- a/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
+++ b/Documentation/devicetree/bindings/spmi/apple,spmi.yaml
@@ -18,6 +18,8 @@ properties:
   compatible:
     items:
       - enum:
+          - apple,t8012-spmi
+          - apple,t8015-spmi
           - apple,t8103-spmi
           - apple,t6000-spmi
           - apple,t8112-spmi

-- 
2.50.1


