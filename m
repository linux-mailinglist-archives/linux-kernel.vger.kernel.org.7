Return-Path: <linux-kernel+bounces-867978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE65C040DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 03:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC721A0791E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F82F1E7660;
	Fri, 24 Oct 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7R45KQ+"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A31C3C18
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270938; cv=none; b=HnF6wNCrPZoncEYBBIv0aIklyxH/gxvi6AFb+5kfA00oKFmADYeedLFtpag0qzFtHsFe2JWzVfg+F8uYRDmFR7HkiK9KFUMXECOH0njLVFFV3ntuh5WmWJc0z7QtStHqegsUPhfGIR6At7Gmz4n03rcLM+dyAwMH3GzMdYBoMQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270938; c=relaxed/simple;
	bh=DFXDK1dq0hZtDmvIA9ZvRGa1Eqyq6GKOH8gUqjVv1bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HB9078xaG1ccdGFtQcHMyPBisNHXybvHbTz94Z1ad/51vek4cbqvbvjB0kDTnFmHsNU0oeni+uFlyWBmbN6I8+JKZUrmQr8bTJYNC06ieU78YtvW/vXmpa2IrCPyCNdjAxFTOxoD5SDGmPLyC8XaeXLRJ2tLHOPV87pU4QpFGPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7R45KQ+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3327f8ed081so1980381a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761270936; x=1761875736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qM2K5UWuNXprZvBDJ5c1mMhJQmIFaH7Nb7GuoKXsnbg=;
        b=i7R45KQ+HKIZnwZA7TEAxwgektKV+Ifjnb9xExKvyPZxNf3gzwCkB/PTQblkRmW1Hp
         ze4seehUn71GJHErvfPjOLMsBvuVw6prEv7+JdF2BfROfS3YC5brF8UCknQc52rVdzwt
         IJiqPiyVVyPfaVJAquL3Wkj9mOcowhJNfaIDi9S9hGVw2b8fEA6IdF9uj//BXSyKpZIP
         qP1Vfx2t5QZwieQU8JX7u+9ailFq0S5UVIiRu/2ce5zvxxnU4l2VCYZ7eB4neBsxE/CR
         d6emKMlJYD589frzlVMteR+v5ydbMq+nmInAPA5W7ac4x7VDnj6CH5XchEGxmkQTOpAw
         XEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270936; x=1761875736;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qM2K5UWuNXprZvBDJ5c1mMhJQmIFaH7Nb7GuoKXsnbg=;
        b=V+NKs4J90LSs98vnMOjDfc1pWdW3m3wHbEKHUC5HbKPlxhoC41eZkIKLQrBn7SfiYG
         KV8bji68QGaPF9adpQYQZ2RVXKqI8viNsejuTNaRatQso4qHqIMhFO1XnZAI4SXPvFjk
         r9h8MHzzArMya7m3jeQ1c8wTrDF6JMlFsvtm+hVBJ1mGhVqwgzjHX1aoT2awMDO1cI1M
         TUTEvVmN+MRlFJJ9Howed+X9vh/DjDNM4viXYZsWxwXA53qGlcULx7+0e3D4/Q/Ah2t+
         fMqDU+B2GbispYpqXfqWFxup0iGKAKMuv5uckkZ+ofKcMgpJjKnL0chYwEPj9DWJxcSO
         m2bg==
X-Forwarded-Encrypted: i=1; AJvYcCWIEd4/wtTCcx+0gg6T2AFan06tKhfs1rsNUVlL28wD6L43qpZf0b0qOyAnMbaLC92mNjE7/7LNzYpnk0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zbMff3/DImqs1q9gSjd8nKTPxZCZL4Iys7SoPZ2mJ5F6HJs6
	EQfMpLAe4q/n2wwPI24d1O4ou/ekaTnh7TI1Z03QOoCmw0K5GPk8ch6J
X-Gm-Gg: ASbGncsUlLJmXlMiEhyNmYXmn7qrVVuX8gmkofyIcQzIysERtjB2JUrpDwKqtMhm5iM
	cmoP7poa78ItjL0LsU/2P4MYg68iIOx2hdFdsxudHm0kH/3eCZ0C2aHXyfy/5tL9VTEyBFDO+8c
	p2cdCsb5NwM7P8pH6EB142yHEPYKMds9j/6SoTVshYQR0NLe5P1NJA06z7DWuS/0q9AOdn9hroc
	D7m7t8uJs8Eho4siqg6ziCZMstJO0vy9RlSHjktqKkIQv+L/+ftC9f/UJYIZZ5lsCfOTKPTEvVp
	un7n57e4VL9VmsSa2l3RwJ+CpCW30NKN9w+yIhuZi1aqmTqvzX359f3xhI3TTojzSrQVwtlG2d1
	1EAJisfqbbtT8jdOh7P3FvhnskTjwsuMu7EzrrTUw3B/3v7j6HWwvtWPpdwMdI8pcYdKThS2ol+
	5m+kO57mYahw==
X-Google-Smtp-Source: AGHT+IFGuiuD5qMaB237ASMVYM5OY1+My1nEaULow6/U2LgSioG18/RvbKuul7ZQNTuvhLccqeac+g==
X-Received: by 2002:a17:90b:5386:b0:32e:749d:fcb6 with SMTP id 98e67ed59e1d1-33bcf86b5c6mr38689912a91.12.1761270936488;
        Thu, 23 Oct 2025 18:55:36 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff3c3a6csm4951393a91.5.2025.10.23.18.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:55:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Han Gao <rabenda.cn@gmail.com>,
	Icenowy Zheng <uwu@icenowy.me>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v3 0/3] net: stmmac: dwmac-sophgo: Add phy interface filter
Date: Fri, 24 Oct 2025 09:55:21 +0800
Message-ID: <20251024015524.291013-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.51.1
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

Change from v2:
- https://lore.kernel.org/all/20251020095500.1330057-1-inochiama@gmail.com
1. patch 3: fix comment typo
2. patch 3: add check for PHY_INTERFACE_MODE_NA.

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
 .../ethernet/stmicro/stmmac/dwmac-sophgo.c    | 20 ++++++++-
 drivers/net/phy/phy-core.c                    | 43 +++++++++++++++++++
 include/linux/phy.h                           |  3 ++
 4 files changed, 82 insertions(+), 1 deletion(-)

--
2.51.1


