Return-Path: <linux-kernel+bounces-816674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8122DB576FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F4404E1B67
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CE830147F;
	Mon, 15 Sep 2025 10:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N91mQpWN"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B793009F0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933178; cv=none; b=ovMzsH6OiGj8mO+ZUgQ8Zz9psC3+QiLzh9Ax7nzVdDUUWYQNvwVGgUSiC4PD6ulPuOcWWYhBWgRRM5lHeGV6gyvT7GngjRVi/3X+nWDv4BiUYq01NkrzbAoc9Rzz8mfxt8CcisHCDnT/rQuruQKO1efHQkBP0lBVcdlqrZnzm5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933178; c=relaxed/simple;
	bh=cR+i0j2nFSKam+gq7FWSsr5apx+a/lZwZMhEZIsHfcA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSa07xG0B+Tza79fs8N9gTGfBwhV0StrP4JJjDIp80zoDmzSmZKPXNcr2ckqyFirbJjX2kBAAzKlwaq1XoNHL6wRlR7KGyl0TMHfRXxOHzyHpvHdYTzFMbM4TwCOY0pHg1pvEPXH+W0cjWVBd7z+05J0QTZaS79r4obxWAa3qB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N91mQpWN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ea7af25f42so625055f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757933174; x=1758537974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=N91mQpWNaQHTgCwVV33H7/ObwAxHX08/a4lGFO0SpWfrYJNwKBeLW0APAUEMJFwNX2
         zBraJXRDxxiKY7clEG9VCWP/FghRcLnP1QFah1epg7D5TBo7seoxqDcI2hveGMPItCZ7
         slJ5Gm/FPkTxXCEZDlH80Elp7Lo+ICiFCGadTQmHXTdkB3ulk2EOB7V4YOrlAaL9FOWc
         CXFwFdQp3cblEWLLgcutmF4Hw8hgefOQa4yJhS5mgBhR/eO68ZdZsIDx2j9qZvk5bXRp
         2CV2N8FUZYcyrsavS5+uMyUGditB4gKJZnGP/Ki4bLBA24c+2LqOaT5fmDCX8BQ96g9Z
         vCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933174; x=1758537974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxXWRqnFqGYPd1tnhNthT3WKgGhl9VmDbyQfQ/+snwM=;
        b=PxXSyxUO49v8oiZdcEqYSDahAhqW/v/wv1dGY2eX297kZd+7S9ZiP8OOkOkVgnRBXP
         cFkDQ82NdIzBatOWW3dA7aYu3eAYGq8WpJfIHk+9EozR+zDef6uDlK6purLMPDraGa2e
         2UmXc6b5TYtiWg90piHf7pMidIv2p44Ze2/LbD5D+Ymcj7n20Q4LjsYhrjbz7rG40Do5
         YF+mxbm17Ba+lAnl56fFanaohaSYKA9JxXTGQMNSDiwG33ptXb1fsL+aFWk0Usl5fS82
         AOcLnyZlUIfXOX9ci34bESAdpXQyZn/3CsGfnZGg7P0SB/uWsFrNstyEPxCMTsPMfyRR
         YhQw==
X-Forwarded-Encrypted: i=1; AJvYcCWOktcIPUOkbFwldZ9KY4cHb0FtAlsRR3fzcFm4HQHPiDwxZPfXo0fEJHDbcnoTRydPt6jbZ2u7dKPmdlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3zrO8PWZXeoQukV2beJCvYCJ03z2l0APOVitLuLH8BWaArp4
	+frMOrolo10ptXDm9cXk5Rx8FdAt/VX4YOXMFBn7ZRMJJ1g5OI8dNpFN
X-Gm-Gg: ASbGncsL0M75FNr+gPejcPx4aF0f7GqlwgwwMaXaW0X8NCOXJ3I4E6/pc+IdUYTXVM6
	xWEVCS+PknKi1bg04oUi5rpN/2BU45pf1kyu9XldsLgHlqGNmXckuVUyiLXxlsHy782nmlupZmy
	OcBbUdrAkqmx1XvIV0piq3Skvrx+iOd/bTzzx+hnCDmiZ2riGL+teMGgzCY0QapPy3vqGkV3hAk
	RInvwHkHAV3sXV7PQPGbpgGF9fxgdQ7dG3vdZJaOZOv+BcakQU+Wcd1ihuH9BzcEtUKSrEH6kie
	sNCqzkZRdWZmMLSXcZFPvWeb66yB0g4S3XP+mmiRBlIsN4dl58Wak0LiUIjoVXg9zaSsntZEOzb
	T8pnRI/LGivWpE/ox+m1mLaDiF+FsHueafTea43wKWPg4751QQ8GbleXJLwpcbSoU/0zMajP4tO
	KVSj5e6Uwcq1cphBm2
X-Google-Smtp-Source: AGHT+IEiFbkrpONQ4XqXk19ByjgEAHG7EmwNVeSeBkfcrYsWrMW7FZrDKlSQ24Q5Qd7fFkQP/hDrrQ==
X-Received: by 2002:a5d:5d02:0:b0:3dc:2930:c7e3 with SMTP id ffacd0b85a97d-3e765a13065mr8441662f8f.35.1757933173856;
        Mon, 15 Sep 2025 03:46:13 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm67163365e9.0.2025.09.15.03.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:46:13 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v18 8/8] MAINTAINERS: add myself as maintainer for AN8855
Date: Mon, 15 Sep 2025 12:45:44 +0200
Message-ID: <20250915104545.1742-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b81595e9ea95..818fe884fb0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -740,6 +740,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.51.0


