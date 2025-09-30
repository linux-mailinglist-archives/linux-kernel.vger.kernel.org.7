Return-Path: <linux-kernel+bounces-837638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51EBACCF7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01DC19251E9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1ED2FAC16;
	Tue, 30 Sep 2025 12:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KayxsDOP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A217B34BA3B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235109; cv=none; b=eUCfJe73EzqrNPTZIry639kJVkZ1JQ6Q0Sy4h4l9wr/PulAUsmnnMEQDpQKL4yW7xaIdWXdI0+zCID6mvkFtcrjBZv+oN9Dd44rhxKDdi8CiGF+c5hIWK+CaKRmRv7ebDAytMDW1YylYy1su4SilpFLoicCGb8MbdtWLER4z0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235109; c=relaxed/simple;
	bh=N3iWQBr+C6sq5xql6Cd1AX/fvpXX92N8aQvLLb5U5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Xx+bKMX+gHzhvpmRao2PLaABHvF7aJU+WtTYkAanhQoMK35JC25w1TOWwp07QcRFBdVR/Qr5JgCO9IWhFrD4GhAQXLK//oNftOvo1CcsuAfM96l8aSYBdnLhBsfoTEp/JBIRNYX/7Cgz0rBRHqF9n3Q402CECjBeFePlWK7ws2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KayxsDOP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3fa528f127fso4627685f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759235105; x=1759839905; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S6lOcLfmjHHMwdRKIuWAlaFWrbjWxKqUiXJMf1tdzpQ=;
        b=KayxsDOPIF+Wrm+kQOBRpu9ibozip57hTC9ymTs/ic6YA3Pbm4IV40dKAMSqryYspd
         wYOS6DtGkLc2WhIJyhphMPUgTdOeGA+gdXj88PhsNyE7E5BS6YHIlYK7eXN6n7RXvKy5
         eSsT7uEhGonZxy+jDM8E2dQLHBU3uxHcabK/KgG6+e8WCJZ7EKHuvQs0cPEiCbb2jKlP
         Nwlcu6c/YZltw9iltwQRCmPej+iXAk/rqErkHoH7uGuuyvNkFNuy7I24Yy+EWl4yNpa0
         Hfd6fVPf4HkIFQyqMUm/0NpkNPHTuGHD4sEfrcPMEUtawlOtvTdc7CIvgsC7YtcVvIlx
         D1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759235105; x=1759839905;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6lOcLfmjHHMwdRKIuWAlaFWrbjWxKqUiXJMf1tdzpQ=;
        b=bWki1M6Gc9Gmri9SqjLz2Y80FdcFS69CKMpxhp6lK+yvuHdXrAx5Xr9HlZHGD7+6K1
         YldxHYPNz8mlWpJO/l5VfVvwrmA2sQ8YnY3gGg9yOS6viyQ4wHT6xOjOquARQVpZbV+/
         pDR+lz96wtcm6z5LSq6GX8mhtXi+9PEADRFCni3vdjfTYWk1dkaNht7fKs3V045rCg1V
         O21xOTbcPyNgOy6lW/26JEnZxxs7fNINFsSXIMgP1RtGls8u2iqKV0ndXFvC4yayalWN
         etRR+vR1m7yHY/ZA9rX04aLNBxuHxZKU30d0Cs2Zj4sYneA3p3PZFFavQ99P8zEMAfL6
         NVhA==
X-Forwarded-Encrypted: i=1; AJvYcCXd3MQtxm9dY3s2bJQiNulBqZ328e5WKO/WM88QZae3PdN1iwqvnjuylyokfQ4WKbsw2lNaPeBd5tNWQoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3iwv3KWoTs09Gaf1ibrcGDRPp7LbFfHEe7jooTG5RDDmThF0
	DWXggaIRqiVQI8EHY7QegJWfI0WfF/nYyDWMpxoguXxNTva5+HNIfZslSdSLqs+SJU4=
X-Gm-Gg: ASbGncs74jkAbPNmxebf07ZRCOGzO7VDP8YP2/L+rrr+qfAZqoaiYhBTVzqASF605gn
	ttizf0CdWonIZfR6OGLlLutTerw0+wGfR16fM+2UkyEjY0qqWrlcfzscWeEJ2Ie1uN6TPnKGuoZ
	cK576zKfV0HYPnrDEBN7eeCKwADjagmarb+hHU0VX/OnDt3fIuA/Ga7u0jsz76p1w94uIhP2BX4
	UZU3bf7SjpM5zb/vEjgGcw7Rc0oDGEworTYq5a5seSfH2Wu42PKlG9mWgFwpxg5tsB874WAJZ1k
	RmL2Sx4ogOuQWvDeMOYKRKnqdiXPTus6UIxsKNFzYUpsOP2I44v6PCrk8Umolr8D5ppjexMGPYz
	gRRMCA419787xlHHTCEnliY4DgdiN53S7YFJXneD0ZFLYwHQPC9XUU2FP1o1QvDs=
X-Google-Smtp-Source: AGHT+IHLfXLZ95GySBe9ZuBPDMocDcdm4e3YftS67zYrym4isY22xPTXaFrasbFvqRJbXcP0Bwxl5A==
X-Received: by 2002:a5d:5888:0:b0:3ea:d634:1493 with SMTP id ffacd0b85a97d-4240f261673mr4414743f8f.3.1759235104947;
        Tue, 30 Sep 2025 05:25:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc82f2ff6sm22407808f8f.56.2025.09.30.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 05:25:04 -0700 (PDT)
Date: Tue, 30 Sep 2025 15:25:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yan Burman <yanb@mellanox.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Amir Vadai <amirv@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net/mlx4: prevent potential use after free in
 mlx4_en_do_uc_filter()
Message-ID: <aNvMHX4g8RksFFvV@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Print "entry->mac" before freeing "entry".  The "entry" pointer is
freed with kfree_rcu() so it's unlikely that we would trigger this
in real life, but it's safer to re-order it.

Fixes: cc5387f7346a ("net/mlx4_en: Add unicast MAC filtering")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
index d2071aff7b8f..308b4458e0d4 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
@@ -1180,9 +1180,9 @@ static void mlx4_en_do_uc_filter(struct mlx4_en_priv *priv,
 				mlx4_unregister_mac(mdev->dev, priv->port, mac);
 
 				hlist_del_rcu(&entry->hlist);
-				kfree_rcu(entry, rcu);
 				en_dbg(DRV, priv, "Removed MAC %pM on port:%d\n",
 				       entry->mac, priv->port);
+				kfree_rcu(entry, rcu);
 				++removed;
 			}
 		}
-- 
2.51.0


