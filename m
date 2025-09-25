Return-Path: <linux-kernel+bounces-832074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E082B9E474
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019411BC4B06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187D2DE71A;
	Thu, 25 Sep 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzq15rjT"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF72D9EF5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792083; cv=none; b=ryKf7piOjmROHwPprrSBhX2kpiYH6lTm8pIgk/q31BM6FRNKmDQyUFRUcf5yCSXdjN0Gs1r0eGj+phck0ZSU8+lb+qLIvNyFFyoX40m6vyGI/nx+sfBjfXvhwE9GjMh62Vit3/ZGnGC3gGvOG4B7qitbxbnN/lmKqWz7iL1FQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792083; c=relaxed/simple;
	bh=jUgn42r5a8mNNBXp0C9lNyB4hr+HTa+eeMoWV7f//J8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VKwDryh7RR4YSHNkBz3nF6Akl3s2+89XAFv/zQQoLVHWAZ3zVJuTanwG0x6szz524B7xrg3I46a7BEYqlbgpCrNdqktnaq6QsWg+79L8apmEZLEq7POudjjgdosa/rTORXh+ONAr+SunY7PoHmSwn8GkABvih7KJRtTmEpR2O1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzq15rjT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27ee41e074dso719025ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 02:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792081; x=1759396881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUgn42r5a8mNNBXp0C9lNyB4hr+HTa+eeMoWV7f//J8=;
        b=lzq15rjTodpavZM6PxRaiAzce2nvWNVMxUwAdXCUxt4xCPpRdSxfGvREwNzS2YsxZ4
         /UIGFgzGF3YgC3JBp0AR5fql3a7GJHPtHq8jSwNKN0kXISPEUM5qzwh4O1WgrLWagfns
         hDtldiukKc91WRlOblv8nqlkx03j/M2yCEIKBqVeLk2CFomuvRORdf8a6jfbqctugMkG
         THIZMCNPyzwl/lFILtsLKPAqB4b8qPlsk20qzQyEiSAh6iLvEFInKYrhgdZRW1uHJlxA
         gXiIniq/luVHLum0jpNLETTjBSgK1lwzLQ00eLVfIvJE76x5WGWZ/wGVIzL/0rL+CoD4
         BQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792081; x=1759396881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jUgn42r5a8mNNBXp0C9lNyB4hr+HTa+eeMoWV7f//J8=;
        b=ff3/IDhG6ZbBq/jyHjyPDzjUSgDSPigUnza6lQu9oLS9m7npbDky2lmxclsNcytZLU
         qJr9kgPjveXbNue76SxPi3Fgj8ax9v13QfL5o0RxXsZvp6HeTSHB4ihJJNyzk/Fjxf7Z
         1O808ESzTmf6+0atvXNe1dLj7vNwUuucBIU6OQPfQxXzP66xoV85Gp2s13biHqqaLUVf
         oV7qbC+umNfKW4V7Tu3Nveni1n4zuCChVfWyII5KPAZhOdhQflI/r/u8cB6MrZA+dCd8
         DK8NNe1fH7HgjU3/Qspo0obTynwAqvdD6XWQXKDbH6IsKNz/gvIO2R6CxYmKwpF8Uv5Q
         GDjA==
X-Forwarded-Encrypted: i=1; AJvYcCVUlOxzh+frdtb2NR4bwtUF4qEP5nRsnpRu37RbAU/7bq/32bqBVfxr/LPXYZxBLP+QxWSnDkT7UZ3S7SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8cFb0HUO638w7031Jn4EO+ZlBwszCymx8pfz/eqi9tJfn+yc
	QMCt56d4DYIbRkxKPeSA38aTpaV8pZemUPNbvkUboGEvpxGxbYq8i1QH
X-Gm-Gg: ASbGncspk/pxTii08rDBbvDgGq84geEomaFrOViYyb958kKnDA6y9QQ2pFT2+wEO6Uh
	fY0nKEAQpwIPzs3e9ux6Ve9V2DMpLqQ4lYE+mtB+o1mVGWhgYt0RBm7sBmHajg+66PWZHnN9QEJ
	tTXexbu2WTCeloQXTgRCrRIkDBtRpa7eDu/TfYiD13ofJF2e0twJ4Miau5hqnN5fVyzmAOMyjZN
	RKdWeRKq2caDEf131P6XNVMGEACJKW57RXyjB0Q+gel+eT07FCNSwrPnC1oRUqJveWkEV3k+s8l
	d6HzrCJ5t1YK9WEeSgMoM24l9Z1GeWVhWXdFxWOwGvTWB6sUKcVjSvnmi3f5ivXb1Jtds+jjoms
	Zhv3GQUzL6gvLnOjdFelQUY4xDtelbAir7iPvJj4MEg==
X-Google-Smtp-Source: AGHT+IFnE3x/HOJtgYIO/KfGDkE6OL9Yv5CTm7GbsosRRNTd2+C/2E/tc4yHiROdLQZc06HYbTLMNQ==
X-Received: by 2002:a17:903:384b:b0:260:df70:f753 with SMTP id d9443c01a7336-27ed4a7eadamr32620015ad.38.1758792081013;
        Thu, 25 Sep 2025 02:21:21 -0700 (PDT)
Received: from localhost.localdomain ([120.229.16.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cdfafsm18251855ad.30.2025.09.25.02.21.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 02:21:20 -0700 (PDT)
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
Subject: [PATCH v2 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Date: Thu, 25 Sep 2025 17:20:34 +0800
Message-ID: <20250925092037.13582-1-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
Changes in v2:
- Change deprecated "rockchip,system-power-controller" to "system-power-controller"
- Link to v1: https://lore.kernel.org/r/20250925055906.83375-1-jjm2473@gmail.com/

---

