Return-Path: <linux-kernel+bounces-815805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB925B56B3F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 20:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6757B162CDA
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CC62DECDF;
	Sun, 14 Sep 2025 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9w61XOr"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41762DE71E
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757874702; cv=none; b=cFNzd/eUtg6Ydy6MuYl7J+/NiN98MLsD3rYbaNbPT0bUXZRfcAwmJN6awd21yIfxuYNOuPLZijDiafuiXnuttu7dew1T6wLhcHFWNZ9YbmMdJpd5e2B4zRucOTqGFatXRr1whYdpc9F44qNO+dM/retaBwOnb5A4VnTKxejmLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757874702; c=relaxed/simple;
	bh=7n4l+yd/t9dYFJyNm3d1lZn7lll+HFRskxQ0eebhwSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sfxk+Ad64gE5ybOtYp6uNAWmlH7U2pK1PJtyJSjg+1SHwld2L8UFmztehsLhd6VSVFD2lao9DXOl/PDhQNiZcA3zyl1qeuhMYHFpmvv/2lkyrQd+Qh22eJ7e9XbwJjg1NxeD5oGAXtmn1R4cYhA+eeVEw6bd+ESHv93vQ5CsI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9w61XOr; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so2160057a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757874700; x=1758479500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V72sOLpArLpSzz2BXmWvU3GzOolHbwO0RKkipSbHAww=;
        b=b9w61XOr9Y4dZVPLsn2XwH72ki9hLNuMj2MXWUcdMcH9d9VItki9xt40ZzZoVnAhH9
         siUCf8A1T+IEpumoj4kNlhfpPRw2c7hx00sss00H7Ab8P7Yh8PV/RiB3HZ0vI3N/DqzF
         qCTdIVdbNj8Egc2DT9rSFNmz5EXpLufdsjLoyrNKRBRump5+adcx+KqOODb9FE8undah
         EkT1UCVs/BrzMOdi2ghdt02YybREtW6c4FnRzbzaO1/niwCJ8KVU0NFN0whIllS24KzJ
         Jcytd2bsNAF9W8eUilXagUgKAzp64wVALBgQNEp+3cSTc7KsT9o3WRvI29LkO51nO0zz
         bK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757874700; x=1758479500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V72sOLpArLpSzz2BXmWvU3GzOolHbwO0RKkipSbHAww=;
        b=FI3rY7ybhDo6nJqMxkw119KpIVGayZTJNn12heLstHLBpszAWQxsJ27Gl/R5RaY6HE
         637pJ/sFZqsVKujmrdylENY/XDIqrbNc05VSlBFbkrcjK2KRluY91rqFbHZd90jsXXHe
         rA1sNZlT6F1ybZebMNlyzMIQWWnululTYqZ4wdrgKe6ttdhzUDDhmO0uJT9o6Wv+oBPo
         bPzWQO29fbifCXMiG/HDndGkzKASHBkmanIIW0wMlDxOZNISMp6b1vdgjVC9cBHjkCcC
         prf64+VrYeHGwUJ7Og8ECFHnnqi2XKCWMA+NvQQlr+eI3O6O8EC75KddTYNFS5OtZpcP
         /TIg==
X-Forwarded-Encrypted: i=1; AJvYcCUmAyoQ5PTauhRA9mElJ1nffQOEDRg/LyuPd/MFesvIFblMl08qIQ5qucIgUzvMMyVQ1EcEJqgkt1agnuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIb64quEcYPsvmJWbRxI/ChU+J3Qx6fsIY3NjPQYhtmk5TpYC5
	b4GqdtY9LXAF44N50mHb/PLAQqlf3DINNuglurjnfRjGeUxT+bhE635b
X-Gm-Gg: ASbGnctmbUhuqnJfBXC93fGH+drEfLMqeAMjpAmJACZofdH2yQz5DJ/Afu+7JpDCUQm
	Y2FoTrZ4c6lT2jcXGnTgBidNbwzNJxtLGVZ7omwHc4j8Bhv2qKr4JNW9iilXXPQj9AI8M40+1Ah
	6J6LRPG0JHJYC9CuhlSUmLWC/53FZn/mJQO38pW6oOUubIxdp9MDz0NnkplabAi2eQF6Og7XvwJ
	wEDKKxDgdb8wk682vQzrjgakBQAeZguJbagkr4oYXP8t0V68xJ7LZacxt23ed1J41PGtJ3E3YTP
	JIlDjuJIKjBgfHCe19L3RPDUwLfEebjzYVCo1LJ1aKSw0ulxcrE6mF7SPirkfbRRzLiOCUQVhSx
	IGTCq9GiDDgjeckOY4CEfMWZEMID5HwHewHgiXhnY56zE0R38ryrBF2YUq898hqoPIy4=
X-Google-Smtp-Source: AGHT+IGmaVDfD3oDHDJpd9fsoafiirPe2B8PuFLQIPHGMomPNEO50epFPEOlslvGEv0RscjGM1SFbA==
X-Received: by 2002:a17:903:3c2e:b0:240:3b9e:dd65 with SMTP id d9443c01a7336-25d26079293mr119493085ad.38.1757874699961;
        Sun, 14 Sep 2025 11:31:39 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e2fb546f9sm71760225ad.127.2025.09.14.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 11:31:39 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v2 2/2] net: dlink: handle copy_thresh allocation failure
Date: Mon, 15 Sep 2025 03:26:54 +0900
Message-ID: <20250914182653.3152-4-yyyynoom@gmail.com>
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

The driver did not handle failure of `netdev_alloc_skb_ip_align()`.
If the allocation failed, dereferencing `skb->protocol` could lead to a
NULL pointer dereference.

This patch adds proper error handling by falling back to the `else` clause
when the allocation fails.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-on: D-Link DGE-550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index faf8a9fc7ed1..a82e1fd01b92 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -965,14 +965,11 @@ receive_packet (struct net_device *dev)
 			struct sk_buff *skb;
 
 			/* Small skbuffs for short packets */
-			if (pkt_len > copy_thresh) {
-				dma_unmap_single(&np->pdev->dev,
-						 desc_to_dma(desc),
-						 np->rx_buf_sz,
-						 DMA_FROM_DEVICE);
-				skb_put(skb = np->rx_skbuff[entry], pkt_len);
-				np->rx_skbuff[entry] = NULL;
-			} else if ((skb = netdev_alloc_skb_ip_align(dev, pkt_len))) {
+			if (pkt_len <= copy_thresh) {
+				skb = netdev_alloc_skb_ip_align(dev, pkt_len);
+				if (!skb)
+					goto reuse_skbuff;
+
 				dma_sync_single_for_cpu(&np->pdev->dev,
 							desc_to_dma(desc),
 							np->rx_buf_sz,
@@ -985,6 +982,14 @@ receive_packet (struct net_device *dev)
 							   desc_to_dma(desc),
 							   np->rx_buf_sz,
 							   DMA_FROM_DEVICE);
+			} else {
+reuse_skbuff:
+				dma_unmap_single(&np->pdev->dev,
+						 desc_to_dma(desc),
+						 np->rx_buf_sz,
+						 DMA_FROM_DEVICE);
+				skb_put(skb = np->rx_skbuff[entry], pkt_len);
+				np->rx_skbuff[entry] = NULL;
 			}
 			skb->protocol = eth_type_trans (skb, dev);
 #if 0
-- 
2.51.0


