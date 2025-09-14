Return-Path: <linux-kernel+bounces-815803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AFAB56B3C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 480DF7A84EE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2562749C9;
	Sun, 14 Sep 2025 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQrVfDyT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C925F96B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874674; cv=none; b=gI3OAaJnr7uJWcgO9JqUVenZm8/3Jc3ws/HgG3Aet+oG87swOrxvVFoh1RVr/Bz4e5I52bNEovGpG2F3iHKSoSf6uXD7ymiLKSqwyb0t6A8tKY7fREln0MpIkLQvjEjK4CDd8jokFee8EjvNi8q+QOUZrVWcgH5tT8vQhFu1+zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874674; c=relaxed/simple;
	bh=hlVIDWDHCPjEuC1vuLoMmRL4KsevmOFTtv3gSNI6JAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJq5cpyESNqAUgnrBBEHU8SVc76kbAQZo7sfDvuMl1GR8MdGDly9PGzEOF/dd0xA9Rnk6Q+WEB5DhNpy0OGe8GLWQCRo+AfKNeKDOtm33JG6VSTvoO6OYQxd6fBLHbn9SxJvPVmyRYIxgjf1WycIhhlmESTh65lrmO3uZ0WbV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQrVfDyT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7761b83fd01so1763957b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757874672; x=1758479472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJoarhscg/bd5gj/01c/KD7zFwsiQugi81p4DTjaNh4=;
        b=NQrVfDyT+MuFGaThCgySw5HPXmvqxwEyIJFu8lqhLo5U6Xa439JkfKKVTmLz9GBhfo
         Dt2RyU1/BD0f8btdLq+ChtQmp31HwruQdXiJdTR1GA0FWx1c+Lwx5RPIwgIL8OHhY9Q8
         mEgTMDjem6XpuYIwS+Moqd4MpJOfyvxvqpSGkliTpuzgYiIuDr3ORpg4JfL9uk1qURo9
         0pdOxUUpAI7j/BddTmjILAnpX9+S6kUGwUwcNjsBM7uQp3dQZW23l7NGBfIeGcZ7bpS1
         ENHAOl2qtmngduOg39bkD0zLRynaPupvPy/NvbEAIOji1Yn3GGySPRv43bCXM7w1BHoJ
         qWkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874672; x=1758479472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJoarhscg/bd5gj/01c/KD7zFwsiQugi81p4DTjaNh4=;
        b=BbE9Vv2o1rQaSrhwMBWc8GxxjGNuIaS67fQ/S7ltu5S7OMfUcuiunx6ltiamRA7yuN
         qkdiTjIITBfkBR2Xkda+JM3TL7A8ystN372ZPJ9ozODb6ThXQSXcX/Uqkr7bKNJIDu85
         +aW0J0XmITuKszvF1LrY2phOkC4ZSRdUCamCPSLtKFiosrhc4iALdZFczq7YfXQ0pApo
         r2/3tpKQOnz1jTkYr9WgTQRoc9kET1XavzqrtmvctTFAieuChRk+e1zkYoVnKmaBhDp0
         lLSEvVFJA+iF6vOZsd1DzllslkgOChpbZ9jddmks6FL5LT0v/dAkKel7XujxgmM4+fvx
         zx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0juFF13784ySBIXjIE+mcKen4M887fV/hGKa7ojNtBPpIIaDKFjp6m92RokMfQaNeZe08hdODwjz+vNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzquCo/mEKiKZfpGQ3UZ/a684SDzgwZ2Hlim7aYv5HS8AcRlmdN
	5n879QKDA9YZSpDrs3ZkCoJvkmA79/Ax/s8sm2e/kYRHfZ7pL+11Ulfh
X-Gm-Gg: ASbGncskdug4h7HmKNImTOYodQFoVehcV3YMpJXOI1uJNu3JYUMnl8rjQfWx9yeT5Eh
	R0T9zBnKj+EFFjCVSUacs9pdMU8RSvE6/s81num+u9rE9YwMcHgg5cRuWl87FGNhclaDgnF4/nT
	qU1xhUhSCQkNRTW14kVQiGnARxL42od5aUStwMvVJ9sul5hLpTQMyTJLFbPRhm6h8IJi/DpxRj7
	6dlhZncpfScsjT6SkVAgMupFQux5qm9S2J+2WnMr2G3alHRUA0hA1NYZUro9/zmz3voJVBZDVZ3
	lJJqY27uwzM8kCvXOSEfBeg1sAqfJlG5Dnf6lVM1MeoXziY04qwusMQZSy6l8dxIUXrhGQtmcFp
	tnlnDYA/QRzkgBAw9pbaDTHoPQwSpnKz9y9hG4uc174i0RPZNy5rSF/W+
X-Google-Smtp-Source: AGHT+IEUFU4BYFN9o4D9Viii5u2+CmO2YQayD59XKN8HcFLpmj2+2aDTFKDY0y/rzl+8+RCxZQYAkA==
X-Received: by 2002:a17:903:11c3:b0:23f:f96d:7579 with SMTP id d9443c01a7336-25d260795c7mr102687595ad.37.1757874672454;
        Sun, 14 Sep 2025 11:31:12 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm71760225ad.127.2025.09.14.11.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 11:31:12 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v2 1/2] net: dlink: fix whitespace around function call
Date: Mon, 15 Sep 2025 03:26:53 +0900
Message-ID: <20250914182653.3152-3-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250914182653.3152-2-yyyynoom@gmail.com>
References: <20250914182653.3152-2-yyyynoom@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unnecessary whitespace between function names and the opening
parenthesis to follow kernel coding style.

No functional change intended.

Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 6bbf6e5584e5..faf8a9fc7ed1 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -970,17 +970,17 @@ receive_packet (struct net_device *dev)
 						 desc_to_dma(desc),
 						 np->rx_buf_sz,
 						 DMA_FROM_DEVICE);
-				skb_put (skb = np->rx_skbuff[entry], pkt_len);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
 				np->rx_skbuff[entry] = NULL;
 			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
 							DMA_FROM_DEVICE);
-				skb_copy_to_linear_data (skb,
+				skb_copy_to_linear_data(skb,
 						  np->rx_skbuff[entry]->data,
 						  pkt_len);
-				skb_put (skb, pkt_len);
+				skb_put(skb, pkt_len);
 				dma_sync_single_for_device(&np->pdev->dev,
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
-- 
2.51.0


