Return-Path: <linux-kernel+bounces-761952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E145B20059
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C11EE1898ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01AB2DA740;
	Mon, 11 Aug 2025 07:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azoz/T7L"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB22D97B7;
	Mon, 11 Aug 2025 07:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754897537; cv=none; b=a9QXwJ6+lUfMYcQ5WgwzOKVg3nlGJrJC0vYvvRyQrvSmLlkgKaiv8n7tsc3PjGfUD0LqFzDAysItffDx1VbZSwDWpXOBVfBOxQfQRfAx6cuWu9VAMewO1g0SGZi0JbOnqxXmlyeMIRQ0p6FuwyFncnMe7tMtlhtuNzRw6D3ZM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754897537; c=relaxed/simple;
	bh=IAqlCxzofDR75AA8ywTBmu9dZZswE2kZqQ1tF0P7HXI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQE4jM8G13Mh+MtiFKjyc1qKpyuYwDCuCxCM+3AyCIPNTgJXXXgNZwkniPaEv3BgL1ckcOHMxn8KFm861FMi6XH1s1RUzyOG+c1a5/niX7pdprXCfBdrQG2/A8G/vgobFgTKIFGhuI6Q0Au9XIX7p1bryS9jVvDA9h0cGI1IOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azoz/T7L; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4233f86067so2355245a12.0;
        Mon, 11 Aug 2025 00:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754897535; x=1755502335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiIt8rDf9PzwkCULipFjt5F74mFBlv9AMUVadk/6kZU=;
        b=azoz/T7LQmCsObUK6Ik0Hr0tzoGDVgeRk4tnlQ70A4TjAqiPrg8/agZfn62UTAvlwx
         j+xtRpP+buFUhJ1ljlBy9VZvGJixiTd6eRrktxv1Koc+/VaDU8bU6ummuDDXJe3q7e+8
         x4duEhxCyK/TS9g6pJ70isPG27G9mUihfJgN/G4HDAeiJ1ELhQXp5pqQihUtE/Y2kGGK
         g0nHzH8/lU7AfqKgf3DkVBiUb8HlnV9pNUZpRVKQ2K8hUN2/usb3+2PMKBUbgQKvS5SZ
         xm2Zy68Roasi29fzIc98LXOBGp0+cCVejSsN3RDqKKhX35KcKJTifDL23MpPCfSCG0eG
         bJYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897535; x=1755502335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiIt8rDf9PzwkCULipFjt5F74mFBlv9AMUVadk/6kZU=;
        b=oBEIn6rhSsRoz1oPg7/f4gTdhhaSsR65lITz3B862CDGmMWhsyiedEHtk3R0hGGoBv
         G9g/Q3sr1/UzHgeHum97v7IlCNcbvC1xdND+I6rrfWAxSATYS5IDWgYY+m8MI1d7MDRS
         p0Wh1B3ZARfSXkPonbe1qCY6aCcav2KXa6EskjWh7L9BrZV9ThGGff0GKWlapC+f6UIU
         uAaadiI8AbTSrPnaoi8mpzJ0+Q9zEU3Xc1K7FFwqVqmqfvlvkkvRGy/qKfpGEqzmsrNf
         iovqngG28LkvGYd6vE3xUe1rFn6CBUq9aoxTMMJC99JHdQEmy9nk8hv4J/yD/5xVAU0a
         lttQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiULeB8TUfZqB5STkw5jISG+Ki43/k2eiy6C5WdZIHrDf05cf4cgmFeh4Nz5pljq+DeHmZy4jds9PPgzvt@vger.kernel.org, AJvYcCXNycG57cp1pcbeYFK1RVsWTFTxxDKYd4uS5INXY/stKBfdbZp/iYRaqtHc1ZhL3CKYxHCw2NMtdGI6@vger.kernel.org
X-Gm-Message-State: AOJu0YyjzfBU1NPIMFG6hVHUzl96Hjjw1UckUfd/kALZqsg2r4pfadFw
	jWMyrb1p4Cma6SLEXIRBOVkDqxVze0Mfftgxl8YRAcasZ0ji1lZQ8lD0FbAnEPzU
X-Gm-Gg: ASbGncvbNHTHJ4u/1/RBaEWgIk9W1DIpblU9nceRsaoIZIDbJXyK3EkC7ZT6qx5CVZw
	MCak9FN2atkfIzg34LpR6jVivOJuIjV9u72+OB+WexpmUuLoaDyLWl1ttLadPcKXheakS+BQV/0
	u/57pKkQmZgnstIQ4nfnJefvgTyKc0+gy5YS9dexrfaD+INU5u5muczQ9/pCyb96FoY+ZEZFJ2i
	7FCqPpT1KGFHXj2yriHJj7cpr4r+yxYQghewLgLKylUHVTVbLtPTcc4+Hwd2K6dWrEoYDreCjHz
	itMMBxbxgSNx1np7ZDMRryIlhKOQRjTq4LlEs1eDSv2HpUZndYMXNn7MsBmtxFWp06XelmQPmId
	QS+/2oJpMocnIOABw9KLL+89YhvKkx4tV6AnEf1kbxf0bsGbSgnDkDeRruAMDEz2lBynOAWhLT+
	FvSHEm0P/jtMGqkfM3u2VnxNys70aN
X-Google-Smtp-Source: AGHT+IGQHxLvRHaO5AnELd5J7hy0PgS8cem/4j+c/MAN4VOfDSifl4layNco3O50N4UNoO5r58BnCA==
X-Received: by 2002:a17:903:1acb:b0:23f:c5ba:8168 with SMTP id d9443c01a7336-242b0466eb6mr250081165ad.0.1754897535067;
        Mon, 11 Aug 2025 00:32:15 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e388-d3b1-e90a-ba63-d547-4584.emome-ip6.hinet.net. [2001:b400:e388:d3b1:e90a:ba63:d547:4584])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm267624575ad.7.2025.08.11.00.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:32:14 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: aspeed: harma: add power monitor support
Date: Mon, 11 Aug 2025 15:32:06 +0800
Message-ID: <20250811073208.787063-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
References: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add INA238 device on I2C bus 4 for the PDB board power monitoring.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index b9a93f23bd0a..741d2d9b6d03 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -373,6 +373,12 @@ power-monitor@40 {
 		compatible = "infineon,xdp710";
 		reg = <0x40>;
 	};
+
+	power-sensor@45 {
+		compatible = "ti,ina238";
+		reg = <0x45>;
+		shunt-resistor = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


