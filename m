Return-Path: <linux-kernel+bounces-858296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D39FBE9FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95F84584B72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D85C336EF8;
	Fri, 17 Oct 2025 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtE7O4cg"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AD3328F2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714368; cv=none; b=C2VB9vlGmvY6Eq1QHXyusPQEWvxwiTTL6rdUCvN5VEq/UXrUo7zCd9T7Y7I8bZzz2AT0CHF+RjUs86yGfCLbUtSFfer9RCmvN1Db+mIK+arYQ2svEjSv7xpHLMLC+7Dr/1OgjO3807tcE85HZuuUg/oqRf2qN6tGHWBjjYlNrmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714368; c=relaxed/simple;
	bh=/osEKnWe3mbTF3iLxYWox4eoxzoJvmAFu4soCr3U8BU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afOHBXU79JlrUnHd9asRQv/B2bXG+gjajN3KeMAJtdzJCJ705Ucc3bwMb2hf6NEXxg++/y7k+gtfICv5VdTziIaXuXySIg6LL9rmtfy6SMjGc9zbGl5PzPzdwmS1lQI5JL6xwRPi5C7bDridyAckp2Qc8V1v2XbI1lkHyrCaDv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtE7O4cg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290d4d421f6so9348905ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760714365; x=1761319165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypV8vCzrTsVuGY3EOGhG77XH5/MdfxUEKyYPHv8FMv8=;
        b=GtE7O4cgk1KAhOF09i2N5n8DnUFLJoRKD7T1kxKNi59WhwqByApft12o5zVwuuCLwp
         3kUo6+APvf0pK963jxw/wfuyA/AJZ47c7DZGLCwLuiEtb5JQRp7hBOAz/7wvLExV+sv8
         zeBXlDoj+tOQZzKpo3dzRMNim9mAgMaVFimswuOtSfrzJ7TK8sHITFgIBOHBWaYiS4aX
         NQupAOpPBLKQazh4cTtNFK0L2qyo+zIoB35kMJn+ugsFWkwlr7SEXKKe+kTRln7snsBI
         Keysawvk+Su+tiuvEt2ZplRwCJPl6XZ14nfniq6uHF6JHHoDIQXsO7e1OJXbTeO0/0oD
         lNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714365; x=1761319165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypV8vCzrTsVuGY3EOGhG77XH5/MdfxUEKyYPHv8FMv8=;
        b=SWzWZtvrj+XYkoI360/jcarj+lddHwGiiezWruOQP8HVhOR4JR1U84FQx6NHRZKMIw
         9DlHwPN3XbYY5JKpMK7XIBinOSNv3BMqvBrQcGI9Y8Ev82v4EnKG1A57po9Gm6CEiIZy
         1Z0FF8TWV0aBMPWab/oxXxd1oerjRsygOslwiyiJeyAgvFR7vDDQohgPmnT0B/ydlXkb
         vc5zBF5eZNAt2vUv16c6MhWZnT8hXf6iGacSoMKtp0AHaPpbqMPwe9U9EvfAAhgBXFis
         YvceJC17vfAJ8PfOBX5+4jFbOrhTQ2sBfZ7tuoUB0WQMI07TtSlrczw5PxaRLASyF6je
         FYRg==
X-Forwarded-Encrypted: i=1; AJvYcCW3eVrj8H0AQwqvKT1yCoQNaSIiI+YI8qCFF7MTLAHW6JENLqbMTBAZCEzrYCzqT9IdTudMJ2D04NAzaog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyczJLlCql9oK4XmLZNxE+bNFwo82UTapG8HbT3pvHdUKWbqyXD
	Rsz8qybh2WmLWAGGaLry9C7B7yClPg3lrWUgujyVoUv/q+chpuEZ67YH
X-Gm-Gg: ASbGnct7tscTBxKVWSi85d7wfmJ2MqhuUrabX4O03PxqesngDqc5oSOd6hrvDPzFNsx
	+EgjxJO2S1XmWCIH2dTPF7u+S4hOrbxzEDpt11ohPh7e2VMbh4JA/HLkzrieaFB4d8rBwFlKzCv
	xez2SVzoU4BZgcQPN/84CLmFUJcgQdEXUifLSTbqMR6D+Z/+vkuIeW93QvW8A73TdbfJITnAH2Z
	iExsn/k/bHt15E2yfJ1MOki10Ofx+HGp1nFo9Rxd0Ikbhgyh7ZAhJXZwXEdc5JF25Ec0XFyD/3m
	8WbovCBsmASKy98FafOx5F8MH9p3BSC72XEcnZYXRJQju63q5y6yt4ql5YLMuX+gNgB5fJc770g
	JMXbOEMEha0Q5Kk6/Sg2uXp9fGKyDtvby3oMmZWt2JXVmMykflJbV6bgEPzFpJ8J1X1sLs7Ylmb
	MH/E4UrbFCrYJPAT+H4MjQXw==
X-Google-Smtp-Source: AGHT+IE1hfFHdVPrDeSlhIdBoaTiwvbReDsJmEBsFsJOoLMNH4uCgErVwW/AKE1pXjv0R63O/gY3eg==
X-Received: by 2002:a17:903:b0e:b0:25c:d4b6:f111 with SMTP id d9443c01a7336-290cb65b633mr50748765ad.47.1760714364884;
        Fri, 17 Oct 2025 08:19:24 -0700 (PDT)
Received: from iku.. ([2401:4900:1c07:c7d3:fdc9:5e8f:28db:7f80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a756sm67193955ad.14.2025.10.17.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:19:24 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH v2 2/4] net: ravb: Allocate correct number of queues based on SoC support
Date: Fri, 17 Oct 2025 16:18:28 +0100
Message-ID: <20251017151830.171062-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

On SoCs that only support the best-effort queue and not the network
control queue, calling alloc_etherdev_mqs() with fixed values for
TX/RX queues is not appropriate. Use the nc_queues flag from the
per-SoC match data to determine whether the network control queue
is available, and fall back to a single TX/RX queue when it is not.
This ensures correct queue allocation across all supported SoCs.

Fixes: a92f4f0662bf ("ravb: Add nc_queue to struct ravb_hw_info")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v1->v2:
- Added Reviewed-by tag from Niklas.
---
 drivers/net/ethernet/renesas/ravb_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 69d382e8757d..a200e205825a 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2926,13 +2926,14 @@ static int ravb_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 				     "failed to get cpg reset\n");
 
+	info = of_device_get_match_data(&pdev->dev);
+
 	ndev = alloc_etherdev_mqs(sizeof(struct ravb_private),
-				  NUM_TX_QUEUE, NUM_RX_QUEUE);
+				  info->nc_queues ? NUM_TX_QUEUE : 1,
+				  info->nc_queues ? NUM_RX_QUEUE : 1);
 	if (!ndev)
 		return -ENOMEM;
 
-	info = of_device_get_match_data(&pdev->dev);
-
 	ndev->features = info->net_features;
 	ndev->hw_features = info->net_hw_features;
 	ndev->vlan_features = info->vlan_features;
-- 
2.43.0


