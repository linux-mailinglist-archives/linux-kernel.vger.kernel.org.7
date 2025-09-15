Return-Path: <linux-kernel+bounces-816682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D95B57718
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCD91A23A34
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A40302CC6;
	Mon, 15 Sep 2025 10:47:50 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2379A30216B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933270; cv=none; b=YOrwfxlMNI8oj90OE8FJZ2hbME2nDxxw/I/KmI1YEJ4QvEjgQXJIeakTggT0lItba6d8DwK1pGcpHNjQHJUX4Oe1UdsuN+Mou2+esPgf6O9pRtKMZJvHaDJxCzXMjo2l5liHqG5T0ZXMuI8QC4aJLxK+rN8MMHw/GAUNF07Fqbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933270; c=relaxed/simple;
	bh=b8e8OaWNtnadVIxSNP9KePI7AvW3rS2UHvHFSh890lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tS2nBV9/Dv60EmaCT3nVzQMJ/b5U1EbZeZl5mVQXdrCt7D6jsf1XP8qeaDgTQ8l7swdD3p62joSdfJHCKpqYOt2HiLDwjr/ObEvI6H+udhSJcQ+D+l5BiZthkNaP7F58l0KrjngTsxzwzVx5pOxLO8mfQmYcrmj7Qen+Caden6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b042cc3954fso727378866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 03:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933265; x=1758538065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7HyATeze4iHdtm3Jn5UcYkJ1c2GNNZC+W/TqjLRDmY=;
        b=aMLf6QxvToejt7VTgF/nByCZScJp7MiDBwhHsuP78psrIMMdhNOfFs+9PKK2nK5Vja
         oFGPQzQ3KXr9JHto6MLns0MPicALp5iya+fMw6WdjMFOUtW5A63qHI98IUGhIgIAayiv
         09VCxoWEUPbsKawdk9N7k9XhLTsUaD7Q4Yx9KLxPJIeJ+0G/CYeKLuEC09OBeusQ7H8p
         SceHE+9TisoFXPy3wazjv+prCMFrE7VhveJ0LIRvAhTwYBjqSpgqI0iH2Ce/Cnih3LVF
         usSQKg0QM4J7SQqMURtdTCo3Bg7Z3JTQibyqkDq1h5ophlG31aQvOSRKLbjS2BmWY0/R
         Ir6g==
X-Forwarded-Encrypted: i=1; AJvYcCUD54nuG7wrv20nJtT/zMzNv/RNtNtImwj7TYg5FqmCnqFxYUVJc4HsktXD22ge6UGrfCzDTsHQanp14Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuyNU94DPC8LSkKhDPp+sCwgEJ8zcbzkOfqzhpEegBSKEJ41SC
	Halgx+tO6S+l7YjsgxPTrevcRQVep2yi/rGskIp+iZ1YbScm1TQbZ3Na
X-Gm-Gg: ASbGncs8n2i0dpCI7jnYzNf/mYd3XKfkKLgzHB/1DFdb0ST5a1F08RpjBOOD+b11TkJ
	PqjM2bMOEzeqI9hNOSVeo+xl+5sYpjgTcNXXe6PA9GsQFFfllkHxE5L2HAAcWmVGYnLAc09trI/
	BGVFDekS8JDKeGQbzBeIp9n8fVbRw2s9MnpZk/jmTekipu+gyOioYBvNc5688k5iH6sGf5XXUXr
	hLmQrgU5tt0UILCBaRobu+0LM5jnORL6CwyjMe0e1lcNoxjE8ibTByZkh1DgEuHnsgDyUqlBi/E
	tIs9VlHVD2fzekBo95MtGUojx+3cc74oDXUiJZ//mCrV6kzYH5H+WEbyteHawNnNKyKIeDQMgP+
	BcKMAPqBF3yxs
X-Google-Smtp-Source: AGHT+IGp/mJO2oohkJBO9wkXgeZW6c1+lSdmqvm9cI4B/RVB1WNWpeBKx1eZf48BYogf1YjTyHGKeA==
X-Received: by 2002:a17:907:9617:b0:b04:c7c5:499d with SMTP id a640c23a62f3a-b07c3833a41mr1095994866b.47.1757933265119;
        Mon, 15 Sep 2025 03:47:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm908527566b.67.2025.09.15.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:47:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 15 Sep 2025 03:47:29 -0700
Subject: [PATCH net-next v3 4/8] net: ethtool: add get_rx_ring_count
 callback to optimize RX ring queries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-gxrings-v3-4-bfd717dbcaad@debian.org>
References: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
In-Reply-To: <20250915-gxrings-v3-0-bfd717dbcaad@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=leitao@debian.org;
 h=from:subject:message-id; bh=b8e8OaWNtnadVIxSNP9KePI7AvW3rS2UHvHFSh890lk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBox+7HwVVGDRCgyCtSdI1fF4Q6fbRHuHKhZJjhV
 IHl21NhkU2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaMfuxwAKCRA1o5Of/Hh3
 bSp5D/4mvnlmyjVJSm/vLWnl0aLz3ZcZoum4iaB+BznlaOH0XVWCgGs4WSLKBBKjLB30Xlsg9WD
 NiIROe1uA/sPL2U2YRLnvW38W720g1vf+iFyDCiJ+/fYcc41l06bSIvtcxZdwezPs2JLpVuhwQf
 o86uQdBdPDsO5kg56YDD/j2W49t36X/KhVkDN23PJPPn+VFRvsLdNHSMDGO9fuc6gPFMRqyzNmC
 rJ7DOCarl05LOScu+uap5Xyw3kICe6fPMB8/zUQ07kXI96IY7+F5cTR0Ku7aHqgRiSKcXGewjhd
 bfYaK6RoTSLN1wxE708bBcfP6d+TVDV/Mx+DkG5E84b7RdVp0jssyqq+Pl9GDgW2Aqfkg5o8r41
 ntyA9eDoq9OFssebdIvQh/ZZMKbwq///I3dutP5BjH0sIDTv3Fr4Vrl2D5Lp6Ug10IBaRK4iseY
 TKt2DHCl7dp/ysGGtWHp0T6Mvl43v5rDFTp7CJpuzpeLFxs7C3xhAFmqyEPYPeVY/Z9bb+riezd
 wd5nEyvCRT+5HvntJ3i5S+s1PLNCuRCRZyCJuisTiSXhJeFGoGOgDFEV/Qc+X7e4IAtFY1kD2tx
 FZ+hObN5WQIt6R/citTQ4/JvZKvjiDmdjIQx6VExcrHJv1Tpq21gvC4AxBtlGXyV7QT50/hsLfl
 Q4I2ZEakH9zxwtg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new optional get_rx_ring_count callback in ethtool_ops to allow
drivers to provide the number of RX rings directly without going through
the full get_rxnfc flow classification interface.

Create ethtool_get_rx_ring_count() to use .get_rx_ring_count if
available, falling back to get_rxnfc() otherwise. It needs to be
non-static, given it will be called by other ethtool functions laters,
as those calling get_rxfh().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/ethtool.h |  2 ++
 net/ethtool/common.h    |  2 ++
 net/ethtool/ioctl.c     | 26 ++++++++++++++++++++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index d7d757e72554e..c869b7f8bce8b 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -968,6 +968,7 @@ struct kernel_ethtool_ts_info {
  * @reset: Reset (part of) the device, as specified by a bitmask of
  *	flags from &enum ethtool_reset_flags.  Returns a negative
  *	error code or zero.
+ * @get_rx_ring_count: Return the number of RX rings
  * @get_rxfh_key_size: Get the size of the RX flow hash key.
  *	Returns zero if not supported for this specific device.
  * @get_rxfh_indir_size: Get the size of the RX flow hash indirection table.
@@ -1162,6 +1163,7 @@ struct ethtool_ops {
 	int	(*set_rxnfc)(struct net_device *, struct ethtool_rxnfc *);
 	int	(*flash_device)(struct net_device *, struct ethtool_flash *);
 	int	(*reset)(struct net_device *, u32 *);
+	u32	(*get_rx_ring_count)(struct net_device *dev);
 	u32	(*get_rxfh_key_size)(struct net_device *);
 	u32	(*get_rxfh_indir_size)(struct net_device *);
 	int	(*get_rxfh)(struct net_device *, struct ethtool_rxfh_param *);
diff --git a/net/ethtool/common.h b/net/ethtool/common.h
index c4d084dde5bf4..1609cf4e53ebb 100644
--- a/net/ethtool/common.h
+++ b/net/ethtool/common.h
@@ -54,6 +54,8 @@ void ethtool_ringparam_get_cfg(struct net_device *dev,
 			       struct kernel_ethtool_ringparam *kparam,
 			       struct netlink_ext_ack *extack);
 
+int ethtool_get_rx_ring_count(struct net_device *dev);
+
 int __ethtool_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info);
 int ethtool_get_ts_info_by_phc(struct net_device *dev,
 			       struct kernel_ethtool_ts_info *info,
diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index a0f3de76cea03..5b17e71cb3032 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -1208,6 +1208,26 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	return 0;
 }
 
+int ethtool_get_rx_ring_count(struct net_device *dev)
+{
+	const struct ethtool_ops *ops = dev->ethtool_ops;
+	struct ethtool_rxnfc rx_rings = {};
+	int ret;
+
+	if (ops->get_rx_ring_count)
+		return ops->get_rx_ring_count(dev);
+
+	if (!ops->get_rxnfc)
+		return -EOPNOTSUPP;
+
+	rx_rings.cmd = ETHTOOL_GRXRINGS;
+	ret = ops->get_rxnfc(dev, &rx_rings, NULL);
+	if (ret < 0)
+		return ret;
+
+	return rx_rings.data;
+}
+
 static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 						  u32 cmd,
 						  void __user *useraddr)
@@ -1217,7 +1237,7 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	size_t info_size;
 	int ret;
 
-	if (!ops->get_rxnfc)
+	if (!ops->get_rxnfc && !ops->get_rx_ring_count)
 		return -EOPNOTSUPP;
 
 	info_size = sizeof(info);
@@ -1225,10 +1245,12 @@ static noinline_for_stack int ethtool_get_rxrings(struct net_device *dev,
 	if (ret)
 		return ret;
 
-	ret = ops->get_rxnfc(dev, &info, NULL);
+	ret = ethtool_get_rx_ring_count(dev);
 	if (ret < 0)
 		return ret;
 
+	info.data = ret;
+
 	return ethtool_rxnfc_copy_to_user(useraddr, &info, info_size, NULL);
 }
 

-- 
2.47.3


