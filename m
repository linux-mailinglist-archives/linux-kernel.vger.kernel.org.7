Return-Path: <linux-kernel+bounces-747484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF0B1345A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC93176EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4E822127E;
	Mon, 28 Jul 2025 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU/JI0dn"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611D781ACA;
	Mon, 28 Jul 2025 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682184; cv=none; b=enQyWtx+O7rJZdrVD4v8EUhjhZoxkiKFd5f3xw44jD3oSlKgYbuQJytrya5JlWZQsqkhErhlg1UkfGuGASW7jZBwcfnJRus5uy51tXGU23h3UqH2SMCDm3u9aL0K60Alm68vakWPezckaGvJSLqDUXIddFwtXw4gsX4qzPlEAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682184; c=relaxed/simple;
	bh=jKAPId/urgZV73peSpLEDxCDNG6Wtdr7sc0wU3uwgA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryp5GnkbznNyCPqWxryE43jGeguHFnF1WRZce1eSQ+Mjq7GuSnYZ2/KciNlKB5OBlAaHdufrQnVrKrdV2a0rvNsD9vNYNfEhrxWhWXVsIWd+853cZ6NzTHR84y1AZclaIBAcP8/xcfc3qsiNsMUQvDFjaM5PIBFhIqV1+wBJ6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU/JI0dn; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b3bdab4bf19so3366100a12.2;
        Sun, 27 Jul 2025 22:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753682183; x=1754286983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AfBX2Dn6gQHlMzI4pjH3b2TDwu+3+H5wPtDXO245HqA=;
        b=DU/JI0dnUupGm0AQRXxYq3KdhL/3Ilo1djCAD4dVxyvHlUMYeNEfCDk9SaFzOFbys3
         S6loHIoydb2BLh/WKHlksGUDykRJf06Wue9UJd+pOF/FCQGtIGxvt1AV+8xcE9D6pn9M
         RasdR3CQlAtBf8Ay7YN4C8G+4LNVq5JywAX73cM9J0xnaL92ed+G3iMd2dgP810CReB7
         BCm0YzSG32rvdlEmEO7Vasve6aXXq8Qa/eLPnt7wBiDM0ZNrVsr5L+2ZwhNQwglPg3wg
         ix3ONnvLfKOVLwEpoOTppEHiZfNYbaR1CUsy2lAIVaCFU/89AOKvTPfzmas4hSmUY4m+
         iaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753682183; x=1754286983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AfBX2Dn6gQHlMzI4pjH3b2TDwu+3+H5wPtDXO245HqA=;
        b=ntGpaXNfralxdP+47ih/i1HJa16oBDn3aLDSoKy6ske/W7sufY2OJ7AyCgdoQ17g2K
         9XTTNLGwBDNoIQx5mpPSHBbfbzwQXCHOpFpz+kQe3PtS6UCRVMhKzv6ag+iSfFqt4r74
         g96mZXkJ7n8OAzzsCrJVoD3htoctTvohNDgWShM4NWhjOEtej4GGgDxKW+0zn1Awgku7
         1N3KNfX5Ls+L8Ie0896gU1Ea5KW7m9RtO9RKmVyWipTxN++QNaJnI1w9ek3NQXezb9nc
         f8rvdbBmfyH0b9cu2WA/n66KCs1lqg5OgBH7FAuJcLYA1RTTuWybmGf46+2tiv42y8Rp
         xyjA==
X-Forwarded-Encrypted: i=1; AJvYcCVuzpmrV6KQrk2kJiBlJsMOk4Wr5Pr9/7AbP6LbXVl4/p1ZtSNhbPVCDAJZLJp0MgTteNAF5WAH5Ii1b0Dc@vger.kernel.org, AJvYcCXFn4+YHFiRSvOzZbpGWaVd+l7+xjmWndd/pWDqsbAqJTNtODC58Q+cHCSr8RIb+ITwSpyK7FNS/WzC@vger.kernel.org
X-Gm-Message-State: AOJu0Yzio5j/2kzL5dJiudMw50qzpReRzmEUjJzKmleVkl8FVIdRE0s8
	FVCCKJx4Vl66iHZnEU1lz7OHffzpPSNC2/LK3vgDzEkMn6zARd2do55Y
X-Gm-Gg: ASbGncv5FxkXnY4VfTmj9KpHyj2fAvH5ibjsP2gRNJXsFQwCDDMyF1SKy9XEf89VT42
	N+vPJrUnDqPOYTubDzPZm5NRG+TlIlBD9wgl0xX+N5h0MiUvPMCfnxzqaJKDxUIYOypjNlXDQ9O
	qCtBL/THiKvKF3Qj3srGsIO8XV/DDc1s92/N2puGkulqGuSJLf1+pIItu7f7IqoI2RulAX0RMXI
	L+nVmMm2+JybJL2idqu47Sl5eYsIhyKDh9jiiz+CRcnl7JFL5R9apnHR+yJZAM0koIpWUaJ5W2j
	/oqafDawqCOPAm5r0JyfO0ydOhrii4xTDj5loL9U9L8mgkk5tk28iJHFJPlNn1i52SfUHu8Lfwn
	DZgBk+ViVvWDx2pyOoZbgBuITD2A2Z9CjKIF3pcyk/u+YOQvNpe+xUJsmFzhGIlMn38FmoPeAGs
	YUz9LzMn869w==
X-Google-Smtp-Source: AGHT+IEAtZDtFkeJNbSH5GWI9Ubuq7ax/Mj9S7hmCp9fOAX7SqKDyq386D0ys1EjsIruhFyyf9MRaw==
X-Received: by 2002:a17:902:ebca:b0:235:ea0d:ae23 with SMTP id d9443c01a7336-23fb304f9b5mr141625795ad.6.1753682182526;
        Sun, 27 Jul 2025 22:56:22 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe514b59sm45091795ad.128.2025.07.27.22.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 22:56:21 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 00/13] ARM: dts: aspeed: Add Meta Darwin dts
Date: Sun, 27 Jul 2025 22:56:02 -0700
Message-ID: <20250728055618.61616-1-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Ren <rentao.bupt@gmail.com>

The patch series introduces the initial device tree for Meta/Facebook
Darwin AST2600 BMC.

Patches #1, #2 and #3 fixes the DTB warnings in wedge400/fuji dts and
ast2600-facebook-netbmc-common.dtsi.

Patch #4 moves eMMC entries from ast2600-facebook-netbmc-common.dtsi to
each BMC platform because eMMC was removed from future Meta Network BMC
platforms.

Patch #5 introduces new BMC flash layout with 64MB data partition.

Patches #6, #7 and #8 add "wedge400-data64-bmc" board. "wedge400-bmc"
and "wedge400-data64-bmc" are identical except BMC flash layout.

Patches #9, #10 and #11 add "fuji-data64-bmc" board. "fuji-bmc" and
"fuji-data64-bmc" are identical except BMC flash layout.

Patches #12 and #13 add Meta Darwin BMC and updates devicetree
bindings.

Tao Ren (13):
  ARM: dts: aspeed: wedge400: Fix DTB warnings
  ARM: dts: aspeed: fuji: Fix DTB warnings
  ARM: dts: aspeed: Fix DTB warnings in
    ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Move eMMC out of ast2600-facebook-netbmc-common.dtsi
  ARM: dts: aspeed: Add facebook-bmc-flash-layout-128-data64.dtsi
  dt-bindings: arm: aspeed: add Facebook Wedge400-data64 board
  ARM: dts: aspeed: Add Facebook Wedge400-data64 (AST2500) BMC
  ARM: dts: aspeed: wedge400: Include wedge400-data64.dts
  dt-bindings: arm: aspeed: add Facebook Fuji-data64 board
  ARM: dts: aspeed: Add Facebook Fuji-data64 (AST2600) Board
  ARM: dts: aspeed: facebook-fuji: Include facebook-fuji-data64.dts
  dt-bindings: arm: aspeed: add Facebook Darwin board
  ARM: dts: aspeed: Add Facebook Darwin (AST2600) BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    3 +
 arch/arm/boot/dts/aspeed/Makefile             |    3 +
 .../dts/aspeed/aspeed-bmc-facebook-darwin.dts |   72 +
 .../dts/aspeed/aspeed-bmc-facebook-elbert.dts |   12 +
 .../aspeed-bmc-facebook-fuji-data64.dts       | 1256 +++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-fuji.dts   | 1245 +---------------
 .../aspeed-bmc-facebook-wedge400-data64.dts   |  375 +++++
 .../aspeed/aspeed-bmc-facebook-wedge400.dts   |  366 +----
 .../ast2600-facebook-netbmc-common.dtsi       |   22 +-
 .../facebook-bmc-flash-layout-128-data64.dtsi |   60 +
 10 files changed, 1795 insertions(+), 1619 deletions(-)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-darwin.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400-data64.dts
 create mode 100644 arch/arm/boot/dts/aspeed/facebook-bmc-flash-layout-128-data64.dtsi

-- 
2.47.3


