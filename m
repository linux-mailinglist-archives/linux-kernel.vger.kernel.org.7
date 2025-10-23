Return-Path: <linux-kernel+bounces-866808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7611C00B11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8351B35052B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3730DECD;
	Thu, 23 Oct 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEU+NiH4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0930C35A
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761218502; cv=none; b=tcs55FQYIU8pPJmr6MAflGAdgCy/FlGfhJAYjJCCw4twWOjGbPB5RPZNcBdpl+Qx6IJ1YiDI2eBBrcQvwUtiVcx9oRDF5lXZTKdp39x0L1rHSCHj5CENyS+JmuaJJCmIpOmFbTiLzH7CmY46pCQWQpRn7oygteIV8EMwMAZxoFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761218502; c=relaxed/simple;
	bh=RjE+kSOTS/IiW9MLEPxrKjF6SoubNJTDr9T4H60naJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqU6acN1X7Y5ocG6X4wvVQOLCVsBeqVdgb5WndjbH69L0TNH79rA7Khr56ycMT2zUmMfugyZuhJ9sKC3Sob6UMYFBLSJEG7PkGk0wOUncpMPQsHdcrefjs+k6ofhVPQFTbdu2l4WjEAX2dKmWBkI8cJQ8HVWaVeKwixhvVrG9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEU+NiH4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269639879c3so6282485ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761218500; x=1761823300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ajYhoORHhWFBc8HqyGQt4ZFGixfkx5nJ2hdJSz5FZA=;
        b=LEU+NiH4zX4xYRXMXM9GaR4bi4TP4mdxgdEQQjelXjj9FIDM1+p0W4f1VrZl3uCV/L
         VAwbKn3jYvOwB89W0aDGlUpSbeR+5Iefc2dxKJs6n0Z4jqfwIRH4yzZTb0JP4o0sOGtH
         b+MfUGbdXJ2I3TYch71ZvcmAb3AQimNGwF3wBelgQIxVr17wwfjmQb2VcpXo9E8EqxW2
         nkNfBChdXrMcxBMt0pe8inc+GvOXHFc1PfFB4Eg6IjVkUn+ie6X2JnRzTxxBSDdycVOu
         GrKx4du3G6vT2MkifR1osmVOm5xPBVQiSjffwRNqU5VXKmVNRc8FOSAbLmD9hFtvfQge
         cCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761218500; x=1761823300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ajYhoORHhWFBc8HqyGQt4ZFGixfkx5nJ2hdJSz5FZA=;
        b=HCN6MFx0JH0HPl+VKQhhC4kdjD85ZX/vWzPzQ23qilheOVhinZkAOdRnGnuhizDgln
         zQj4v7JBsWBG/qIxhQz1z7Rp7EkjCABhw8QknTSIoWFTnU0xlnU+ijm5FE4jcZarp6TO
         IzWsv1EUwYBCRsi/g1xsIeTBT6JDl8ZuDQCnZ3aHnl5QVS6rtDzdRiUUsEaZVftxCAaX
         PZPyXo3Ao4STDvGXbLoYwvRjmHotvJWRTg2FwL2dD199r1UowxypxOpxDLnFQCg4daQd
         lwGMf/UDgwqnC9ZoJbJgR7mocRFny6eeGztgXEuV70nKrTTJ6lcqk3aoU6X4JmEYQZTu
         rj0g==
X-Forwarded-Encrypted: i=1; AJvYcCUw+/HDL6YfuAckiw3Ec7vZDd/hS3etthAfWqABYetO1ZFjTSZGLvLUzoaZxolhcXe6tscKg7I+myWFCMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzejqyflbq7pfQSeVUetCr7Dr7bzGIGOl1eUF/AwY/gy6b0g22/
	DxuC7irTsUIYJWanyywuO5vTCueSLHJnMzd/xDlAFOsXsaD5uj3cHc9Z
X-Gm-Gg: ASbGncvpDWStDaKpb5T/8L2qeSof4bT7f7CXSOTJdgIHxaEp6skrN6herpf2EfEt30W
	7mEXGgeZH5uuxaW47m7rFbCXwqftXv38ydk0o74KughrAdT/RCULETgYaphfedoJgCtFWwMZsYe
	urouTxlAfFOZ2mg8rNZmn0yNsRMIqT4dGgWyxZVyUUt8FH1S9tfb7NiCr7XaaZZAlpqZxBQq+JP
	zGVlDF3na24WCRIwoLr86qZCPqMQs6CkNP/FkwCOWh3JMuwR1uBnvNMEU4JKCYd/neXrcgP8DzI
	bUIsY/aPh+CYLt3iEN62xYsHWImMq0dGfYT0RuD2Nuph8xVQajcZnjqAL4U4kzUDUc9P9Kfq8zT
	ORvpeFDkkPaw0wb2mJ8vLeYWI0wNUaYRAKz7AamWisGSrtWKbRYf9dTKVgnZYKmRHjlzTGbt6mf
	xUFwAe5ms/UXZCPTPSH/4NsVo48SgX0Q==
X-Google-Smtp-Source: AGHT+IG70LMDucQ/v+ZD8r8xVVgqwdpVy8r9nkjL/iPjUWjvVho9/jKVj6iNLo9FQk+xdUIb+ldKdQ==
X-Received: by 2002:a17:903:1d1:b0:290:2a14:2ed5 with SMTP id d9443c01a7336-290c9c89fd2mr259763605ad.4.1761218499912;
        Thu, 23 Oct 2025 04:21:39 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dded613sm20226885ad.37.2025.10.23.04.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:21:39 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH net-next v3 2/2] net: ravb: Allocate correct number of queues based on SoC support
Date: Thu, 23 Oct 2025 12:21:11 +0100
Message-ID: <20251023112111.215198-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023112111.215198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251023112111.215198-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Use the per-SoC match data flag `nc_queues` to decide how many TX/RX
queues to allocate. If the SoC does not provide a network-control queue,
fall back to a single TX/RX queue. Obtain the match data before calling
alloc_etherdev_mqs() so the allocation is sized correctly.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
v2->v3:
- Reworded commit message for clarity.

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


