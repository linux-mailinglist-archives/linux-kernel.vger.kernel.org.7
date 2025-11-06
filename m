Return-Path: <linux-kernel+bounces-888587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1750C3B37E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82B8C4FCD0E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45178331A48;
	Thu,  6 Nov 2025 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ew1Q5m2+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OepH10N3"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C22330B21
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762435702; cv=none; b=ctCFuDQNkAdMoLUrcOHChH8NJ7eiYocIYPErYhYFYf3uAkjVdS50hXzvd6JJiPuIXyj48Lbf8RDHAEh+gR9YTEu1EBIYHx4yziVt8ch0XsXD64+wG4yOfdtX75KCi6sUybwXnuRBkXQcHvvaXy3PsxHTdSdV5e4+mxlcqYa4vYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762435702; c=relaxed/simple;
	bh=J6zorrtuzfJ9+H3G9W9PBxJnY2nLxcDhfse6SvzTrG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWwrsrEM048GyBOPpTc2Mkug9rZ/6YAkufMNodbHt69acQpPTr8KIkHiHoiUTjsJjdkDcCVTRC9PceY716mv29DriitS3uFUx6jgZLJYcB/aT8OoBQzOmLsi5kCm7s7VOPtMP/gLo1IL/cEnbRs30mvUsYs5WqDhr2QJ0ssS5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ew1Q5m2+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OepH10N3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A66f7ga1784631
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 13:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IUULajFqgSD+MEsGRsQuIGs9v68mJqzbhXQWTGKyrrk=; b=ew1Q5m2+fYRaoGvl
	dlQ0g2GCk86vEzz4ILvE1AtZpu91AjuSsDEdbnnlYFiwh6nPg7XA4RY9CJDLkO1z
	eOOXZj4cOtVV9W/W+iX3KhEk9CSkPUFcN2+lXsDkM8e11XZ4T7ilOHIPnmLE/Tv9
	Nv3aNPuO03CCUCLfPBo4KTqg5eG7jBySyB54cr9QxQsH6s9eLj6Q70p2AQYNZzQP
	ZIYJ2ekJErfFdTPNFgg7BN7DODQt+XQXWxLXu9XRkDW3b5cyTbcI1CQ5UHxTTsId
	LEM44Nta6XeANi7VgZhUN3NZnMZDwUOu+qzNomxTshotp2paeTdLPX0gsk+qqjIy
	BVlz/g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8amxb68x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 13:28:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-294a938fa37so9066285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762435699; x=1763040499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IUULajFqgSD+MEsGRsQuIGs9v68mJqzbhXQWTGKyrrk=;
        b=OepH10N3WpQLk5L7M7f5ad7eFJGbmSjlGCPuBvZsWO7bwptUBNo/lYyH24cU6zSVT5
         sNzQ24U4V1xhnrfUqKfpKTsi5uMuW3khsoPveDWgLzbCU41GJJCCGbWL8t3U7fxv04Yi
         D3PFWkgja2xRtnoT/e6tYf6FFEBPI7bxX+UOpY0qDWHBPefWls8lnyVsTUrK7UmSvquV
         18oMwRfJTQzmhRQB9rHhPZi2zcNymKcxOy/RJ+DokZ6fjkV+Np+MZeGXoGKjNvHznk7p
         wmtaZotW8juAicClXwhJJgX0hkxMZnMDmk30pTE9OIRlX4OBDz2w1t/TbPmBt5H7ZWCA
         kObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762435699; x=1763040499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUULajFqgSD+MEsGRsQuIGs9v68mJqzbhXQWTGKyrrk=;
        b=BcCveH03ikpkqmi+C8z+CEp5nPHo2UTfp1763E81+HbBqL8A4zpu768fjw95PHTmV8
         kMBrf0D7LN3I2PlTbl+3aKiv0KjAZ9MIaJWIz9c5cFXpoUPNWHZFDdAVq35njgtG+XzW
         7MJytxBraHaazy/8DIbf1DL34CXxOURvaoUR9+N7PiCIMCX0TuZfxIkZL3Bl8Ub7qjaM
         IdDs+CC+fbvR8LIx8HIgSAI0VcnxuwL1oVGY5zcu8jau4Jdtf9Ec8gVH0h6hoXlFvdMQ
         6w5Hw5tKBrQBsGaIVPl8dgWElibDbEW1/gzadATEK4gYad5QN/et7R4/T7LY399bO2xm
         6qhA==
X-Forwarded-Encrypted: i=1; AJvYcCXhthxjF8WwI0GnvUc4kHO8nTZ0j6mRGlc6e8VpKwMzqVDg2c+0ACB8JWMosmvxV3TGZr4d5LdkzLfRMpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEf5Y3/d/FHEPHgrM2Vts/MyfU7b9DtRx3ahtl9Isc5hZahTo4
	j2DHzJ3vFEeCI8nnyIt+hpkyVWgv9/neYzmLLXOxhOxSdFc6VJiEI6COOeQjmo3cDniXRweFiG9
	KPV1NoWL5otb54sE2g3+wAG+AK51tiHLJ42AzaOcErQeKuyUC4LEymsoSsYhNot3R9eU=
X-Gm-Gg: ASbGncu2WUjCtQlFazuwmE+hspEV3Gf1AOaxnMN0lkqp/21WJX3VEFr9m/cS4nlpNhk
	KU0G27vqKb9Ae5T9wxkeRIX0K2s/igE/1MjPACUveJXYC4ZwvtblmTco/6/eWZiq63h1EY22Cr+
	M5edqh9/JvQUNeXGzGujAvrU2sTe+wZq6FKFaPeHH6Q/3rQRDvXAhu6rhQGgs09AH0qFWtgLlv3
	ZrXCQzMcvwMjB8+S0AKkoilxUIYUpP9yE3q3E7AtcT1DHQlpAD+1xn9CDAHG/EBWWymi4SzrJ4G
	kupMznzZg7ScY9xzhO1xXowmX8IACGZJebBwKDzFWDt8Vdstd4pNyUqUiNgQ+LfBNt0pPCsQWR2
	ev9e1g6kAom6lxT7ypU5urxv7hA==
X-Received: by 2002:a17:902:f087:b0:295:8a09:bcf7 with SMTP id d9443c01a7336-2962ad0795emr60349675ad.8.1762435698819;
        Thu, 06 Nov 2025 05:28:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT+G1yauZO4Uv+PfZ3aECTSqA9E9PkcEkVrxDWVGX+7zjYUsYEQqTXS/fB/MUWl5vKsoZHlg==
X-Received: by 2002:a17:902:f087:b0:295:8a09:bcf7 with SMTP id d9443c01a7336-2962ad0795emr60349345ad.8.1762435698220;
        Thu, 06 Nov 2025 05:28:18 -0800 (PST)
Received: from hu-vpernami-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1669sm28770225ad.94.2025.11.06.05.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:28:17 -0800 (PST)
From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Google-Original-From: Vivek Pernamitta
Date: Thu, 06 Nov 2025 18:58:08 +0530
Subject: [PATCH v5 1/3] net: mhi : Add support to enable ethernet interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-vdev_next-20251106_eth-v5-1-bbc0f7ff3a68@quicinc.com>
References: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
In-Reply-To: <20251106-vdev_next-20251106_eth-v5-0-bbc0f7ff3a68@quicinc.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org,
        Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762435691; l=5343;
 i=<quic_vpernami@quicinc.com>; s=20241114; h=from:subject:message-id;
 bh=yXbU8lihwC6jWxLS8hKE4wQ+g81A+06ust1izcTc/1c=;
 b=C+ugZf03olTTYXndYJ6d0WtEXnj133d6yNzphLVPkFegdOgzSJdnLUsdi9KHO9yldpeu2M+Li
 1AxciM4QWzyAidwL0GYOqlX6KPjIoewTMZCAM5FUU76BECEhd6Hg5vD
X-Developer-Key: i=<quic_vpernami@quicinc.com>; a=ed25519;
 pk=HDwn8xReb8K52LA6/CJc6S9Zik8gDCZ5LO4Cypff71Y=
X-Proofpoint-GUID: 7T8fVA2Peu6hlpp5xTpJI-69l2w1SfuH
X-Authority-Analysis: v=2.4 cv=P443RyAu c=1 sm=1 tr=0 ts=690ca273 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=896jBCbtMXEWOMTOa7wA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEwNyBTYWx0ZWRfX6Yy9FNbdU6Bd
 03NcX1+mGZZ86dl/eEVkMdDuYrfKWHD4BL6aZAOou8jWmNgq26f4earc/t88eZ/AZNkvZvUq0G3
 GtAbRLdHqj5um2rcFp7Eh7VxU26sgMG/2mH0ag78dyxnaVi62li19tJ/TMhWuj7wUfUG9IexH5c
 OdENtqVQQqM+ynW4dOOKwDpxnrE5uVVMXZFVIvj1CCeYN+2mY5HjqXBi07uNmggmxvuJaNVwlD4
 LikY0yuoQs3+H+F9tYcrGMEGenqItwate5A5KhrLwS4Zi32Uf8kqgSZ5gPu0QJ/m9AeBJHvyifU
 1xTy8PUrM7yMZPn7zSsSlZ8prEUHw0rxSpUhPELiKmmMD1MDTUgcXpaqiDNxOE+hDt991VuRUi7
 b8BnjKBXPAEYGfRtnpvMT+QbeTiARg==
X-Proofpoint-ORIG-GUID: 7T8fVA2Peu6hlpp5xTpJI-69l2w1SfuH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060107

From: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>

Currently, we only have support for the NET driver. This update allows a
new client to be configured as an Ethernet type over MHI by setting
"mhi_device_info.ethernet_if = true". A new interface for Ethernet will
be created with eth%d.

Signed-off-by: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>
---
 drivers/net/mhi_net.c | 84 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/drivers/net/mhi_net.c b/drivers/net/mhi_net.c
index ae169929a9d8e449b5a427993abf68e8d032fae2..aeb2d67aeb238e520dbd2a83b35602a7e5144fa2 100644
--- a/drivers/net/mhi_net.c
+++ b/drivers/net/mhi_net.c
@@ -11,6 +11,7 @@
 #include <linux/netdevice.h>
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
+#include <linux/etherdevice.h>
 
 #define MHI_NET_MIN_MTU		ETH_MIN_MTU
 #define MHI_NET_MAX_MTU		0xffff
@@ -38,10 +39,12 @@ struct mhi_net_dev {
 	u32 rx_queue_sz;
 	int msg_enable;
 	unsigned int mru;
+	bool ethernet_if;
 };
 
 struct mhi_device_info {
 	const char *netname;
+	bool ethernet_if;
 };
 
 static int mhi_ndo_open(struct net_device *ndev)
@@ -119,11 +122,37 @@ static void mhi_ndo_get_stats64(struct net_device *ndev,
 	} while (u64_stats_fetch_retry(&mhi_netdev->stats.tx_syncp, start));
 }
 
+static int mhi_mac_address(struct net_device *dev, void *p)
+{
+	int ret;
+
+	if (dev->type == ARPHRD_ETHER) {
+		ret = eth_mac_addr(dev, p);
+	return ret;
+	}
+
+	return 0;
+}
+
+static int mhi_validate_address(struct net_device *dev)
+{
+	int ret;
+
+	if (dev->type == ARPHRD_ETHER) {
+		ret = eth_validate_addr(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct net_device_ops mhi_netdev_ops = {
 	.ndo_open               = mhi_ndo_open,
 	.ndo_stop               = mhi_ndo_stop,
 	.ndo_start_xmit         = mhi_ndo_xmit,
 	.ndo_get_stats64	= mhi_ndo_get_stats64,
+	.ndo_set_mac_address    = mhi_mac_address,
+	.ndo_validate_addr      = mhi_validate_address,
 };
 
 static void mhi_net_setup(struct net_device *ndev)
@@ -140,6 +169,14 @@ static void mhi_net_setup(struct net_device *ndev)
 	ndev->tx_queue_len = 1000;
 }
 
+static void mhi_ethernet_setup(struct net_device *ndev)
+{
+	ndev->netdev_ops = &mhi_netdev_ops;
+	ether_setup(ndev);
+	ndev->min_mtu = ETH_MIN_MTU;
+	ndev->max_mtu = ETH_MAX_MTU;
+}
+
 static struct sk_buff *mhi_net_skb_agg(struct mhi_net_dev *mhi_netdev,
 				       struct sk_buff *skb)
 {
@@ -209,16 +246,22 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
 			mhi_netdev->skbagg_head = NULL;
 		}
 
-		switch (skb->data[0] & 0xf0) {
-		case 0x40:
-			skb->protocol = htons(ETH_P_IP);
-			break;
-		case 0x60:
-			skb->protocol = htons(ETH_P_IPV6);
-			break;
-		default:
-			skb->protocol = htons(ETH_P_MAP);
-			break;
+		if (mhi_netdev->ethernet_if) {
+			skb_copy_to_linear_data(skb, skb->data,
+						mhi_res->bytes_xferd);
+			skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);
+		} else {
+			switch (skb->data[0] & 0xf0) {
+			case 0x40:
+				skb->protocol = htons(ETH_P_IP);
+				break;
+			case 0x60:
+				skb->protocol = htons(ETH_P_IPV6);
+				break;
+			default:
+				skb->protocol = htons(ETH_P_MAP);
+				break;
+			}
 		}
 
 		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
@@ -301,11 +344,17 @@ static void mhi_net_rx_refill_work(struct work_struct *work)
 		schedule_delayed_work(&mhi_netdev->rx_refill, HZ / 2);
 }
 
-static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
+static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev, bool eth_dev)
 {
 	struct mhi_net_dev *mhi_netdev;
 	int err;
 
+	if (eth_dev) {
+		eth_hw_addr_random(ndev);
+		if (!is_valid_ether_addr(ndev->dev_addr))
+			return -EADDRNOTAVAIL;
+	}
+
 	mhi_netdev = netdev_priv(ndev);
 
 	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
@@ -313,6 +362,7 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
 	mhi_netdev->mdev = mhi_dev;
 	mhi_netdev->skbagg_head = NULL;
 	mhi_netdev->mru = mhi_dev->mhi_cntrl->mru;
+	mhi_netdev->ethernet_if = eth_dev;
 
 	INIT_DELAYED_WORK(&mhi_netdev->rx_refill, mhi_net_rx_refill_work);
 	u64_stats_init(&mhi_netdev->stats.rx_syncp);
@@ -356,13 +406,14 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
 	int err;
 
 	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
-			    NET_NAME_PREDICTABLE, mhi_net_setup);
+			    NET_NAME_PREDICTABLE, info->ethernet_if ?
+			    mhi_ethernet_setup : mhi_net_setup);
 	if (!ndev)
 		return -ENOMEM;
 
 	SET_NETDEV_DEV(ndev, &mhi_dev->dev);
 
-	err = mhi_net_newlink(mhi_dev, ndev);
+	err = mhi_net_newlink(mhi_dev, ndev, info->ethernet_if);
 	if (err) {
 		free_netdev(ndev);
 		return err;
@@ -380,10 +431,17 @@ static void mhi_net_remove(struct mhi_device *mhi_dev)
 
 static const struct mhi_device_info mhi_hwip0 = {
 	.netname = "mhi_hwip%d",
+	.ethernet_if = false,
 };
 
 static const struct mhi_device_info mhi_swip0 = {
 	.netname = "mhi_swip%d",
+	.ethernet_if = false,
+};
+
+static const struct mhi_device_info mhi_eth0 = {
+	.netname = "eth%d",
+	.ethernet_if = true,
 };
 
 static const struct mhi_device_id mhi_net_id_table[] = {

-- 
2.34.1


