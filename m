Return-Path: <linux-kernel+bounces-814456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C1B55450
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114135C725D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B66322A22;
	Fri, 12 Sep 2025 15:59:39 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95196320CDE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692779; cv=none; b=TK3ZbIZHNP72VZDBSUQNUvjN2F3sC92DYAM6TNVkIK5nQ2o5SRycJx6PXJNdUUvfXprIvLfQGGQR+5c1zht70xUjCjI/kOhJZ8rQmWBjDn/AHwoP+8dsuWAiXI3cHuOublCQg1AHr3xOAk9uyfkGtmFgsLnBlR3aOYjU17OdMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692779; c=relaxed/simple;
	bh=B7hiaydeDFqwwV7/Lm9sF9Gk3miD67w67Kgp/MXuDjo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b7RiBaAj665yEqEfvAQZPmXOq/xyLCwB37R9gnqfPoSNA1N4dHfXPEf+WtFZ0ZK7Gvp5ynALy0eQBaQcTs8OeDk/BiXbxQe1+lM1QASXEapmy9xkLPeX4HYKfWWOExxHa9iPxJn/ocVvXR6io4KjDt39FPAsc8T1JavAwgXFhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b7550c0so2530630a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 08:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692776; x=1758297576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c+VSqXxVY9gIzYmafuA9MWcYdBFAas3bxDM3moiIIVw=;
        b=cxvtSzWYS+FhQkftNS/0BQ46TFDznhJBeg1Yi5qQSAB8UNnvgWrs7BnRNQvR9WCYSz
         Eb2mjKTwuECm9AjFhVVJg1DLxMRutVR5VixB7dNGMAj1XtGXPNqALX2w/r/gL417uLjn
         E/RQwZ7wtHupbgI73WH++r9/x1/MUTQ8boQZ0iDHQqG4C4/xCqq+1FpeQwF36esLWfCE
         pQgHDIOqssneM8ch+joivwmmb2BvPrUUdNiFisB45RT5M2p57lI1UQRVgQrlFD3oji8A
         hiG4+AAhMQmLDruD8zfY89cHnop5zFLjRfIwoWSZSzuTBbGzF+LIygCKtFbo/HPocMVI
         E2BA==
X-Forwarded-Encrypted: i=1; AJvYcCUIjlzqmoeQA42hI4sAPu8vRipwbFDqQZ6i3aiVsvbw11DNN0nMt6AiyMpu464+MJyA7iarMTXunk7mE4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpxZJKvHlZjwo2P2D/fknM7T5nYfobQ6JGTLleXEhg7M/Tqqpf
	ScRs9hw1Mj3/IO2Np+wml/cuZVHi7lJDIyRdSTMgi98rA/8VVwu/iC34
X-Gm-Gg: ASbGncv8RLBVkgxTUL6FXTReExG+vW770LcCA3JY4fqfG82XnS9F0+6ZjJLn7lEY0Wn
	dTJ9NKLNjjLyIPNKDlrKp2NuiccrwDT6gehejrBl9Wu6u0WHfaZwLCPHjV3V1CAZVerOV/5r/4Z
	ewGFej49FCy2BPz7+lPw5+hps0qrxxP4WeHD8E/jCGXXWyaJj2BM2x9g63oD7Nf2xpx8qRcrvOp
	ePULQ6AD1LgMGfgDrGeASXEnX0f8Xjs1NnlUECmWAxLfVEK5S9ncpf6LyMDAvF3PJj+YCogzC98
	J+O5/OoSDEzU7N34Xqpr4uVlDwLh2Hra3ZTfz+GlgxFD14TxCp6/AwXM1jjT7v4+tSOzw35GF2v
	78zvryPTBSd6MnOoXp+vVyCOw
X-Google-Smtp-Source: AGHT+IEyPqi71zP6kl6VEGAReOmXJHzMcQ+n0SiMqyw3a6ODKWCPj/FWUp7Nx1bPfsfRlrSOfwQ5HQ==
X-Received: by 2002:a05:6402:2686:b0:62e:de67:6544 with SMTP id 4fb4d7f45d1cf-62ede6767d9mr2651900a12.11.1757692775394;
        Fri, 12 Sep 2025 08:59:35 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ee7b531d7sm1217307a12.51.2025.09.12.08.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:59:34 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 12 Sep 2025 08:59:14 -0700
Subject: [PATCH net-next v2 5/7] net: ethtool: update set_rxfh to use
 ethtool_get_rx_ring_count helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-gxrings-v2-5-3c7a60bbeebf@debian.org>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
In-Reply-To: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
To: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 kuba@kernel.org, Simon Horman <horms@kernel.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, Breno Leitao <leitao@debian.org>, 
 Lei Yang <leiyang@redhat.com>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187; i=leitao@debian.org;
 h=from:subject:message-id; bh=B7hiaydeDFqwwV7/Lm9sF9Gk3miD67w67Kgp/MXuDjo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoxENeny8wo36PzH29kKSTTe9UiH4dRoX00y9id
 9gt3DbRna2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMRDXgAKCRA1o5Of/Hh3
 bTVlD/4ob6FbB9AUn7BHarxlRnL2di0HojfoD96flzMkcDD1E3vYwDsJM0mGKzlcNz8pMNf2Y/X
 dKrsIl8OgCTBy4E0hEMnQ+8jStaeEzciIcEWVR1iIdBZRQHSvMmpj6PCn7INArj6mkdpkOo2ihY
 DtfX61FSW13am3yyJDybf4CehRuejNqr7D+2Hw9sAnSvKq0L8QZ534Zh79gHihK05PQYOxfsmQ4
 KhOyFXLJTpnW0Fd4H1DH+ED4r4vSQ8iFqMPXL3tSL7ik7mcBHBQmzqMAwUfNxFzHB1KK9+lz8nW
 oOOUhOp3WJdrjr7ppzOUrZ/MWEDUpQUYJnykPgUQVrdz4PrwBL/8IiKZFPQRpVU96nLoor5eYf4
 XeiJIA5wNADLGjUIePe3QlsaeT96c9JDuS2EeJA3167N0EQf2HNXTQ2g5jV4yKl3ULAg3dSsvVf
 LyTYM3KAP9/tMrR/zAjaUd2y+3vF7L4Eo95r8Zg90lR5+4VZ14njU/NF0TG33Fxf9FHfoBDHNTY
 kGVTE4XsxE0EEySosjc0S+GUMqlWQcEcmnBy9iuGNJtoBdb/VZn9Ggth56OZXrtZHTe8yUsWgac
 hrDOteKtNm+kh2GL7/q/KlAQkGWRYp1IAvLsHP87DLOdjIZly0x+2OvPBAIfNknnkV27mPPlqVV
 f4Q/2UHxQKvGuxg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Modify ethtool_set_rxfh() to use the new ethtool_get_rx_ring_count()
helper function for retrieving the number of RX rings instead of
directly calling get_rxnfc with ETHTOOL_GRXRINGS.

This way, we can leverage the new helper if it is available in ethtool_ops.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/ethtool/ioctl.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4981db3e285d8..01db50ba85e71 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1548,9 +1548,9 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	struct ethtool_rxfh_param rxfh_dev = {};
 	struct ethtool_rxfh_context *ctx = NULL;
 	struct netlink_ext_ack *extack = NULL;
-	struct ethtool_rxnfc rx_rings;
 	struct ethtool_rxfh rxfh;
 	bool create = false;
+	int num_rx_rings;
 	u8 *rss_config;
 	int ntf = 0;
 	int ret;
@@ -1611,10 +1611,11 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 	if (!rss_config)
 		return -ENOMEM;
 
-	rx_rings.cmd = ETHTOOL_GRXRINGS;
-	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
-	if (ret)
+	num_rx_rings = ethtool_get_rx_ring_count(dev);
+	if (num_rx_rings < 0) {
+		ret = num_rx_rings;
 		goto out_free;
+	}
 
 	/* rxfh.indir_size == 0 means reset the indir table to default (master
 	 * context) or delete the context (other RSS contexts).
@@ -1627,7 +1628,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 		rxfh_dev.indir_size = dev_indir_size;
 		ret = ethtool_copy_validate_indir(rxfh_dev.indir,
 						  useraddr + rss_cfg_offset,
-						  rx_rings.data,
+						  num_rx_rings,
 						  rxfh.indir_size);
 		if (ret)
 			goto out_free;
@@ -1639,7 +1640,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
 			rxfh_dev.indir_size = dev_indir_size;
 			indir = rxfh_dev.indir;
 			for (i = 0; i < dev_indir_size; i++)
-				indir[i] = ethtool_rxfh_indir_default(i, rx_rings.data);
+				indir[i] =
+					ethtool_rxfh_indir_default(i, num_rx_rings);
 		} else {
 			rxfh_dev.rss_delete = true;
 		}

-- 
2.47.3


