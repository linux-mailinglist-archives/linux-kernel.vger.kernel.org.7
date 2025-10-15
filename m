Return-Path: <linux-kernel+bounces-854739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCD9BDF456
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064F519C124B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970512D77E8;
	Wed, 15 Oct 2025 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drzMuTQC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC972D738E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760540865; cv=none; b=hXmTsatI7+EMkzMocKlM/185u0tdmNEQRn5ZFDmOTmD2TywiaSvdJUsM5Wgoh+6EdZw8AbXi2ZlW0oxmCJlO/lLhFnoN94oyoRHLWzYe5iPBFA1oPZWGILvDCEpI2BbynIDsULQPX7aQNcQcwv+W3T4Lu2107zx1eIao8wHUGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760540865; c=relaxed/simple;
	bh=wFM7U5xEYjSSvnb/zcMAdN28R94rcUc3Ud2fIkD7+eA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALWASjpAik0uGsBTxTVlDuGWu47jtv6aVtVp6pWxaK/CdoPR5Ks6oT6nKK/ZkjSQ6BsIGsPP3NDAtm/UijvCDJWfnBqT6hbG2GuXUW9tzrYbaqAv17YHD7/e0hJ9J9AFUat/qsI+iXQxWtfnKfhcJAhcfcaINJd8PEBy2dERn4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=drzMuTQC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7810289cd4bso6391567b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760540863; x=1761145663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=peC4fBCpVsJx1EbcTEa7mPVjNA4XLU1693R7f6y1/j0=;
        b=drzMuTQCIHG/4/2y6WzITU06aol4E2xnbrfsKsuNcw5NE/ognk6kY3KF6s8KN7DlnS
         wTlzRfWqjHSsh73jros74OkW61bQqWEuAfpBVCfP/l2BrJpdurXw0dhj6a4s5oxOwuXt
         T4yMnBcB6iQgAeKposhpbdTZ2EBhKWxbHmgGbFIaQuWXbyqAU5+fCkzMD1w6/m2iFAjG
         VPLnGTRFordswlZfjZCIydVmDMDMJM7B2WrcaKjuVF8M39qmumNdjp65TP7Z/33XeUFw
         OpqIqOo9p1by6NCfEVRx28RwU4dvRypzYAazmoUixFH3FAqeB3mo7hQ/kl/128MaUgCg
         1qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760540863; x=1761145663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=peC4fBCpVsJx1EbcTEa7mPVjNA4XLU1693R7f6y1/j0=;
        b=TAnvxYrJcTg6/2u+3UJ3pgMKfVjeNHQuSx4EhLlTUPxmPKYCLKxHKww3iMiXbvcjd/
         IzMgtSAg22RAQjzFYJaBDLOplII0k/ysQc1hNlKyi6HhonDHXbJechusq3+UR5TmJ7+N
         vDfpPn0wS9mtUUQhwQll+uOYjewji2KAp6aEeGfWVKVeaVPsGQmtMtfyhQQlJqABTwuR
         sY0UK6/siRj/4CSWlSzh181yrjH2mKKBNvZWNRCA4QOdfvd7IXfELVFReIt8DK27E7kp
         IrrNQFaLtle4qOp50N433GO2f5vfuO1DQQyTksAg4WusphoB5/iJT7pNCggMI07+0Wau
         mLpw==
X-Gm-Message-State: AOJu0YwuIuDnchX8Y8Zw0eS0+IYIilMD+6b5ydvBBQM10vera/74njcw
	YTOmmyYJfPMS2mmHuZg1O0JKOmfgLpE4xCSymr0D2RYfq7lQPWUHlCKqljQyrQ==
X-Gm-Gg: ASbGnctJFowruI1/t4CBg5jNUTPqQfkldlKDQSDtXqdcf82VOVdxXsmKaMwseo6QtJR
	z+prVLDZ2txHAgUzdS0yEGNMWbRc8DiOOQhZJYJ+/JTTfQD3mDt4XC6YVoHei0aHVapFAhVyPnv
	ITmOQmY8FtenF+oM5IqEQOZ5t1oKOzA0XpTshNX6QW5q/H5cJ/Ck/oRj1iQLy9+d0F7fCxU5h1Z
	g4/tVmSU6RGRZt2YRQe/xUU6FF6UB675NXKCYB5OgXZyhXPfmZrRtgKy+VWHkmWvYrpG52WMyuM
	jZhk7NgBmBk2olVJDBxCC1xN9SZ02hbhyba/ZwyVfWpkQKqGa3FUosVd/k3CBiNixUObIJ1Hbip
	oFF7GNyk+U/V22GTorNJEoLOARsI3gtIr3JyqhRt2OrBAtX+6Yewz0GD1m6/Ceyc=
X-Google-Smtp-Source: AGHT+IGYY64BKA7qLQ5pLlCX93/uTifpzYi4y8GygO52N9tFVQxsy/9rYr8eNMrWa9JF/Zp3Es2rzA==
X-Received: by 2002:a05:6a20:7289:b0:2fd:a3b:9349 with SMTP id adf61e73a8af0-32da84e8482mr37991402637.57.1760540862311;
        Wed, 15 Oct 2025 08:07:42 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:f449:63fb:7005:808e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b97853829sm2959821a91.5.2025.10.15.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:07:41 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Nishanth Menon <nm@ti.com>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] arm64: defconfig: Drop duplicate CONFIG_OMAP_USB2 entry
Date: Wed, 15 Oct 2025 16:07:28 +0100
Message-ID: <20251015150728.118296-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

CONFIG_OMAP_USB2 is already enabled as a module in the default defconfig
since commit 8a703a728a745 ("arm64: defconfig: Enable USB2 PHY Driver").
Remove the duplicate entry to fix the following warning:

    arch/arm64/configs/defconfig:1705:warning: override: reassigning to symbol OMAP_USB2

Fixes: 91fe3315cdf9f ("arm64: defconfig: Enable missing AMD/Xilinx drivers")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Added "Fixes" tag.
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e401915e2f2f..478ca72c0aeb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1702,7 +1702,6 @@ CONFIG_PHY_UNIPHIER_USB3=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_AM654_SERDES=m
 CONFIG_PHY_J721E_WIZ=m
-CONFIG_OMAP_USB2=m
 CONFIG_PHY_XILINX_ZYNQMP=m
 CONFIG_ARM_CCI_PMU=m
 CONFIG_ARM_CCN=m
-- 
2.43.0


