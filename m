Return-Path: <linux-kernel+bounces-740838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D02B0D9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 14:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B135C17AF25
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5E2E1C61;
	Tue, 22 Jul 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWSeNUvb"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11809288518;
	Tue, 22 Jul 2025 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187932; cv=none; b=mxqgwWLpD5BfA11Zw17bNrhe7CQO6I+sBmWTNKtIQFA2L1fz0+qvK+HWFSBscva089LnslnhNvq2AqRUR1iPpnPijES1rARpb5bWfRw9+AEMC06c5T5rje6P8v755J5Xg6x3He+A5c1wEfRM52aqnfg/BCSWfHDGygCJGpyrV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187932; c=relaxed/simple;
	bh=92HkkJP6zvatheJ4wBH4adOxsGd5ZbuSby0AscE/0Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/beRmjFTVwBtoDYv7mQ4jaV5EI81aU2kE7dxgDSWiK8y/CBmi12lxxAY3sXhK1PaYIrICD8sdJcdtgm8jYRialoN2gyujYSVxRMjBHIpKalJcWoH20/SJrgcB+uQofdhiXNykI3EfD5PQVaaYOklLExPxgo0NhZTxr8DarT1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cWSeNUvb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ab112dea41so3179676f8f.1;
        Tue, 22 Jul 2025 05:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753187929; x=1753792729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iA+c5Pv9/CEehwhoCiWsw+/fTrurkwoLP7xmk75QXCk=;
        b=cWSeNUvbcLsjflKOxIMaS+Z/IXkpAoepC1/QPvjBkRBHHCAtcpd3lSX+u8gzn4QD4/
         FFq/IhbP6Y22QdoCxW0SQBtwwIu7Mln0sBTytmA30dsk68bfdVggy4cSsJ92PmuitmPm
         gKl948kKoYjp/MCGQg0SwkwD2LWabwSQkoRxNoKTaXK3gNczODs0sffJ4Y4AYwngg8mb
         lyb9zmMHlaMvFuCDLjbJUd5E6jnoK+y+ZaMsTzfQUBMyEnQVjepcWZFuw7Ft/UN9S/rF
         mdx+zIE132wxStVN9sVnzW5aIj4AfJjJxJafRQPoa82AFZtdRXuoLtX5rWU0vTfXfDaJ
         FFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753187929; x=1753792729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iA+c5Pv9/CEehwhoCiWsw+/fTrurkwoLP7xmk75QXCk=;
        b=lNQ1Tz/ExFTVpfd6H1SuPpbXIvR4/DTaZ/Zd6xjEPAoq7C+hucqoQKc4m8P61/2Lf3
         sgD7Q16uo/2YBXeJ94MnLGZMY3wedFQFNeIlBqTy9SZjfaRLEaUZw/+clf7wKUOs2NNy
         RNmjOikwbBz4Pau2TBFIHVyIKmF8x+zfedhJ682Gx1a67FDS3T4PQew8LQmHaG9J5Czi
         BxgSJU53kr6bnJlqgZj8KW5BHUAx/tzHxwvFk/HbsBWKMW6h6ELEiNa5chZTA/8LK7xi
         hVudiaEGrfRdbwvkfDn7q1BM4MsGbBOLcZdaNzntl26Mzxy58/7lu/A7f6+xs2/MyZDp
         Q7mg==
X-Forwarded-Encrypted: i=1; AJvYcCVwIasf2pFo5pH8oTPJzeSP8OcSLEsKnHMKjgmyCHvU0h4wusSPh2vGj2XjotQCdWuQhb90Z5xoAj3gxqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhosX9YNQXVCpRUb7Uj0ZQtgXHlctYy7w8z7bypLaIKKRxmtN6
	hpUccs1erOADNEnXTAcRl8VKgdWWwVMi1h1h6D3l/DS89FoqeQf5aG6H
X-Gm-Gg: ASbGncvYZNxDHvoxS3RXRpKvUiRDQvqFjHcljUsoPZeAuGXJhEy1d0WmU0VyegouF72
	RHXbPSalMfQ05T8GuAOKxYSPGvdBoDRoWTSD5r4kwbugOs2PKepAGCBuJ3sVxE7tjOpKnSr0FlV
	BEI+KDb9s2rXy9B1BPDdyzS+2aqVOWaDXWt6wp1OJd/jOzdnVpwMKhSES/7MKGjCtS7RWf51QhL
	tEicF/1K/k0W5yhrQkxYhzU5m5+mWMaPgDgkx+9U9mlGeJT5WZ7vVMeHVXun8gIlRITADFm1Fjh
	9VmFoKPo3160rTJxfg0H+GDv2mDA+pVcs7qUCZFWFE3eEB/0HnV6Z+r0ElqhUb/RRZAdbUuiMNI
	KYMSb4jGQKy66+Os3QS6ApSqJTkY=
X-Google-Smtp-Source: AGHT+IFGeyK+QeZM1N0c07OjUQkxi0BPV4rB9krjYHbqPUETa+tP2IlFN/9f5P/Sb+JdAB4YU44LxA==
X-Received: by 2002:a05:6000:2c06:b0:3a4:ee40:6c85 with SMTP id ffacd0b85a97d-3b60ddc61d8mr19147649f8f.54.1753187928796;
        Tue, 22 Jul 2025 05:38:48 -0700 (PDT)
Received: from tearch ([46.104.48.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48c40sm13525197f8f.58.2025.07.22.05.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 05:38:48 -0700 (PDT)
From: muhammed.efecetin.67@gmail.com
X-Google-Original-From: muhammed.efecetin67@gmail.com
To: linux-rockchip@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	heiko@sntech.de,
	neil.armstrong@linaro.org,
	lee@kernel.org,
	rafael@kernel.org,
	efectn@protonmail.com,
	daniel.lezcano@linaro.org
Subject: [PATCH v2 0/5] Add Khadas MCU and fan control support for Khadas Edge 2
Date: Tue, 22 Jul 2025 15:38:10 +0300
Message-ID: <cover.1753179491.git.efectn@protonmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammed Efe Cetin <efectn@protonmail.com>

This patch series adds support for the Khadas MCU and fan control for Khadas Edge 2 board.

The first patch updates the device tree bindings to add new "khadas,mcu-v2" compatible for Khadas Edge 2.
The second mfd patch removes unused nvmem code.
The third patch adds the Khadas Edge 2 registers to the mfd driver.
The fourth patch adds support for Khadas Edge 2's new fan control registers to MCU thermal driver and the last one adds the Khadas Edge 2 device tree node for the MCU and fan control.
And the final patch adds the Khadas Edge 2 device tree node for the MCU and fan control.

Changes in v2:
- Added a new compatible "khadas,mcu-v2" for Khadas Edge 2 instead of cooling-levels property in old variant.
- Added Khadas Edge 2 registers with KHADAS_MCU_V2 prefix.

Muhammed Efe Cetin (5):
  dt-bindings: mfd: khadas-mcu: add new compatible for Khadas Edge 2
  mfd: khadas-mcu: drop unused nvmem code
  mfd: add Khadas Edge 2 registers to khadas-mcu.
  thermal: khadas_mcu_fan: add support for Khadas Edge 2
  arm64: dts: rockchip: add Khadas MCU and fan control nodes

 .../devicetree/bindings/mfd/khadas,mcu.yaml   |  5 +-
 .../dts/rockchip/rk3588s-khadas-edge2.dts     | 58 +++++++++++++++++++
 drivers/mfd/khadas-mcu.c                      | 56 +++++++++++++-----
 drivers/thermal/khadas_mcu_fan.c              | 20 +++++--
 include/linux/mfd/khadas-mcu.h                | 32 ++++++++++
 5 files changed, 152 insertions(+), 19 deletions(-)

-- 
2.50.1


