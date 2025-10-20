Return-Path: <linux-kernel+bounces-860529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57874BF054D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46C134E41C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56C22F4A0A;
	Mon, 20 Oct 2025 09:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOpCblow"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDC2F5306
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760954157; cv=none; b=D/MxsEvhRZYiq835HjMQGpU5Kndn3ncHhlut34lWO5ro19HrHOy/nR8AsMZ4Z7+rGTvUklq4LcVZcHV2g/P5dJ3Y8CIkKBpjRKNWj3+QL0WvYTcytMtAgO/GE7ozNU07GOQLtlC1GHmDHIsxWHyPVfLE/rVvoP9MPPTMPj8D++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760954157; c=relaxed/simple;
	bh=rIsPkq1dARb1QczmgvcZPGvLvmgyJgmOrN52SnXRNk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Msi0S3Yj/Foc41oj3/xYyLDRbgkqMOOxL/fGs6aSL1C3ShHm/gb8ch6MS4dRiRSorPqAmcHttOo1RrHKNLuEKVqhy5stsVnIOpjbFhpj5Yh6JfAlrK07OQO1bkHp2IcBObHFUgk0fWLFop3zTXnQ7dNjd8kqwYPFUCQK/VmObNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOpCblow; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7930132f59aso5638006b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760954154; x=1761558954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HnjCj7JbAdjNvBUGLpD1SpiGs6GWZ/iOIsdOQuRNQDA=;
        b=jOpCblowY/KCSAxOwVAMm0hPe1+P5MBrZ8O/Cx74d5DTs5At3SXOZeGJ5NaaOcO8Gj
         dT+BTbdUJ7AkzHZXBHBw8/tI9IBzTgr7765qOvjPBaER2wJmB0fEHn9lAB9C95GUDWwW
         aVQ7QrZM0sfss0KCitdlkmJdE6U8dktIFZgt9/iDWqqc8+zcZHmzKW7Vopnp39I1wGTI
         RqpaWZw20mjMqFWtHwQQyLFd1SSPaha9Y/mZrRZqCzCOwdysy95YdldZr4vQjBB8Xetb
         Z/ft8gKi8rOy2epOhZ2+E0X1WdzgBSPMCS14ntL6sp8uST7sncEc5CxsKaflgk8FJD5I
         LUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760954154; x=1761558954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnjCj7JbAdjNvBUGLpD1SpiGs6GWZ/iOIsdOQuRNQDA=;
        b=VxlNq/vlP6X05gXsm//LmwOdXi2ExHpU48dI99z+eXWTKEBqyICosQ25yahnZsMAlb
         tr9tN1x2tt8V/ETZZ2Ia6kE5uBEYdFfDBsTwCKoA2UZJbnVqzIHaIS2AxGyksG4sso32
         EHcwfu3BsIfL22zW62MbjmxOBYzXi+hFJOH8Nj9DvhyzJzExcpIWk+WL2tyhK0UP7CsB
         Koq20FgiNYfYp7VqdJ1ZmfqRY9N2BTxevlX4DoX0GzrM1o7Dsy8A/+ZvapEAhHLH09zY
         QxyxhwdHmsZRXc0ii0kablCO7v/WBNaUFiNc3mB1xpKCJ+93FKkzQ9EyxLMtjm4TzGU9
         LtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqDIxgKEhYWI9R3TmFeiEzaSRWW2Tg7LkTrnhKb6LomvZ8/9iIJRmvcKOqhffILBDURX6B8xT7gXXf1tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPmIvYWdmKz/ZX1/99LTor3YnOAgvWKCIpwTNZKhZgO8TxDs0i
	OOAZKVSX+kPN0+usOrgC8cq+jffD/JtjorAljYetxo/zaK+fLiuEjenC
X-Gm-Gg: ASbGncvxx9IJWCTixDyT8263IIo2EtKqGBgE44Rda09mi0pmi7Izv3vMQIlF2ialFYr
	tzT77hq4RmscoaTxtw9TGFlhC5fmlM/MPa7LnvIswgg2YG4RdQtTVEm31H35DqpVGu68KDcToe2
	DfbNKuSlZGa9ofwifG7aibxNqKeWwoQUYH5qdkEI2Cw03noyaYMF5FJDeq1PcVTqNWRYNuGjEyq
	uWllttpyViKzH49JF/dDtmBMTSLrw658FLQyCMFgN+KKiyMTMWf5Bh+q2u9Fv8LcOUwNFV0yTuq
	8jRs08Slyt9emKh2H7m6LXvgu56hn8tJH2WGHoLgNbgoWmiEc1AbruysJLZSPjrnCmefiIQxXJM
	ebXZDP2BzLk82itdj44D94uXjQPQvNSoSh4Qei16jn/manXnJn2HzkKcCMcYfcfp4i1dZ3XU97v
	g=
X-Google-Smtp-Source: AGHT+IGgDyGZ3OQ57iwdb2555NKJghSCCZpCKxoCPXr9rM53NE7X3m8ehUVd2NOzuBByD+q6WjfyCA==
X-Received: by 2002:a05:6300:8088:b0:334:b8bc:1031 with SMTP id adf61e73a8af0-334b8bc1040mr10403992637.58.1760954154496;
        Mon, 20 Oct 2025 02:55:54 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm7256845a12.38.2025.10.20.02.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 02:55:54 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Mon, 20 Oct 2025 17:54:56 +0800
Message-ID: <20251020095500.1330057-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the SG2042 has an internal rx delay, the delay should be remove
when init the mac, otherwise the phy will be misconfigurated.

Since this delay fix is common for other MACs, add a common helper
for it. And use it to fix SG2042.

Change from v1:
- https://lore.kernel.org/all/20251017011802.523140-1-inochiama@gmail.com
1. Add phy-mode property to dt-bindings of sophgo,sg2044-dwmac
2. Add common helper for fixing RGMII phy mode
3. Use struct to hold the compatiable data.

Inochi Amaoto (3):
  dt-bindings: net: sophgo,sg2044-dwmac: add phy mode restriction
  net: phy: Add helper for fixing RGMII PHY mode based on internal mac
    delay
  net: stmmac: dwmac-sophgo: Add phy interface filter

 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 17 ++++++++
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 17 +++++++-
 drivers/net/phy/phy-core.c                    | 43 +++++++++++++++++++
 include/linux/phy.h                           |  3 ++
 4 files changed, 79 insertions(+), 1 deletion(-)

--
2.51.1.dirty


