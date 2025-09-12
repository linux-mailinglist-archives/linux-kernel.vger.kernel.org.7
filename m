Return-Path: <linux-kernel+bounces-813636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E80B54890
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E276D1889539
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C9D28B4FE;
	Fri, 12 Sep 2025 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtEGVVDs"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB1537E9
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671186; cv=none; b=nk/dN3MSkmEcs36xYMdt3fHyCIxXHyDSHAzcf3Tdc01nv3q5klZ235DUZHekyVdZA6udh4cowwAosK3kfDBSL9Py5XuhwFN57aMEYiZsL8K3ouRU7KZJrpiqrcHq0LMggNj77nA23DeKNJcDAnMUoUFA7ifeoiS+pOeM8pbPr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671186; c=relaxed/simple;
	bh=lTfgKImhQNfN6u2BxK6SF4NKf7soc+1lwEKH6F0tn1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X/DBtXOHRn7qTWsUdResZVZNZi76apwJOMmA+xNzfVCem6nSRHBohnzJzRF5eEIyyQvmqS9EePd957danr6su4p0fpopfEnHrrtLNNEVzqLHlUTsCgVM/F9U9SXNZr0dzNPIu/gNL3i48cBHB1TBcf0SPJHcHspija3m63C2R88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtEGVVDs; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7742adc1f25so1213921b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757671184; x=1758275984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/U/oc7TDR2VUzY00gKP0s0JlDQ9xsneooHDgr8AAAf8=;
        b=UtEGVVDs8lo+SfXJAlTs/ShvRs7lg/G0NbFd0YxfNaqpNfea4yIiNjhAxbSqAc6ly1
         5SJntktBYAhpsZbn1sbkfdktWyNXPjoPspNfdpKWprlKuLno2bZHFCPi/DJAyxg4enhW
         All/bjFhHPEnlUu4MLQTJwYhw1da/X7z47iiEtCKF9h0m1WoteQZHvf+j0/jnehNefT8
         RBXlAzy/4NPz4JsbfgJseW5Jq9bEt8Q8juInDC7yFnbG1F7Do7khCASyC5dh5cJpuOvU
         AeB+WmcAWvfxNpx5QzS0jxk72ciXA/DYGuXn0zL4wMRJ8UU2dCj/36XaoNIhDlKHdQWk
         nN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757671184; x=1758275984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/U/oc7TDR2VUzY00gKP0s0JlDQ9xsneooHDgr8AAAf8=;
        b=CIa3bnwBICu6fHIIh8LXrJege1HsS/Q5sMQmPGfp+4+vY2ZfqG/dmlRost+b0EHX6r
         Ijyb97BFqtwqlvM1kzJYMjCcphTy5flYTW3uHAAjjH7MDXfgI5elFiwLHHtH5h5T/16L
         7vWkXNCAyVaUKy1uGqD96gzORjhu3yvo37kmm0a2EUL3xk9ieUXzNuY0SUX+AD1zEgzS
         zDk73EB124W0hGSB75C0Si5L0OAteDcOJZ9rjdKUUTeClywlx1tD7ygjdBJE2ZR8QRGn
         gX3Ih5J6HL/61MtdxUwNCeZN87lPO/qq4+1bvIZ4tzY2osYarP62oCqIL1ENO/PlLDcc
         rObw==
X-Forwarded-Encrypted: i=1; AJvYcCXD6bKSK/GyjaqlxnAaA3YJtutWJYBifUY5+SBVW8gWxWYMDtN5G1k9Y2pLVkc0TvAeLqeeFUGUomMVAhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOJYK9//hphP6CVxLITmEAVKtuEvtrTgs5m7xiiQfzU9MU/To
	f25fTLwbgnSqBw8bI+Xvh40x0/IC3qq/weC5dn8JM7zXBrJLpGqhFogE
X-Gm-Gg: ASbGnctgawOCvQ6pFQdkHT9wnJAml0Q5sEHXs1BdDbUa4WHZKJIUCleIvqhIx4YFlc+
	iKONMJnQtrkhZlXZCqMubtyK3Ua09f1xqtCz3hF+KNee7Wot5g8YpyKqR9K/4tyFkORbEf9kna8
	llC7Oqx5KXdJ77a2KDbh35TaibweMABhnu0urLZj/Qsf/CY0qkmAxOrx6W9Bc8i14kC9MVvnWDw
	3u1eiJ6X3ISbtvZY1Nc1RrbmDuWYK1v3kQZ45bC6PFWJ6JC1fZXNfS54nCsQlfgcxHavTVkVgKo
	wBLNGRlq0kk98f0S3YKzGqinlToQ9Mk3WprNYQ654vqyMAweGmYvnmKzx2qxUaGx3JHF2QX06sJ
	JpYUtqb6dgieUJQ==
X-Google-Smtp-Source: AGHT+IF3JR3ArS2DE325tp7329BslWJiRQgkK4DDMmc7Q78E5uRK7Xm4SsTgTiPWVL89HRrP3OJy1w==
X-Received: by 2002:a05:6a20:4322:b0:246:1c:46d with SMTP id adf61e73a8af0-26029fa0cf6mr3110864637.2.1757671184180;
        Fri, 12 Sep 2025 02:59:44 -0700 (PDT)
Received: from gmail.com ([223.166.84.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b5absm4192951a12.25.2025.09.12.02.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:59:43 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Subject: [PATCH net-next] ppp: enable TX scatter-gather
Date: Fri, 12 Sep 2025 17:59:27 +0800
Message-ID: <20250912095928.1532113-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When chan->direct_xmit is true, and no compressors are in use, PPP
prepends its header to a skb, and calls dev_queue_xmit directly. In this
mode the skb does not need to be linearized.
Enable NETIF_F_SG and NETIF_F_FRAGLIST, and add .ndo_fix_features()
callback to conditionally disable them if a linear skb is required.
This is required to support PPPoE GSO.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v1:
 Remove the test for SC_CCP_OPEN and instead test for xc_state changes.
 Link to RFC v2: https://lore.kernel.org/netdev/20250909012742.424771-1-dqfext@gmail.com/
RFC v2:
 Dynamically update netdev features with ndo_fix_features() callback.
 Link to RFC v1: https://lore.kernel.org/netdev/20250904021328.24329-1-dqfext@gmail.com/

 drivers/net/ppp/ppp_generic.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index f9f0f16c41d1..1132159a8b92 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -835,6 +835,10 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ppp_unlock(ppp);
 		if (cflags & SC_CCP_OPEN)
 			ppp_ccp_closed(ppp);
+
+		rtnl_lock();
+		netdev_update_features(ppp->dev);
+		rtnl_unlock();
 		err = 0;
 		break;
 
@@ -1545,6 +1549,22 @@ ppp_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats64)
 	dev_fetch_sw_netstats(stats64, dev->tstats);
 }
 
+static netdev_features_t
+ppp_fix_features(struct net_device *dev, netdev_features_t features)
+{
+	struct ppp *ppp = netdev_priv(dev);
+
+	ppp_xmit_lock(ppp);
+	/* Allow SG/FRAGLIST only when we have direct-xmit, and no compression
+	 * path that wants a linear skb.
+	 */
+	if (!(dev->priv_flags & IFF_NO_QUEUE) || ppp->xc_state ||
+	    ppp->flags & (SC_COMP_TCP | SC_CCP_UP))
+		features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
+	ppp_xmit_unlock(ppp);
+	return features;
+}
+
 static int ppp_dev_init(struct net_device *dev)
 {
 	struct ppp *ppp;
@@ -1619,6 +1639,7 @@ static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_start_xmit  = ppp_start_xmit,
 	.ndo_siocdevprivate = ppp_net_siocdevprivate,
 	.ndo_get_stats64 = ppp_get_stats64,
+	.ndo_fix_features = ppp_fix_features,
 	.ndo_fill_forward_path = ppp_fill_forward_path,
 };
 
@@ -1641,6 +1662,8 @@ static void ppp_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_destructor = ppp_dev_priv_destructor;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
+	dev->hw_features = dev->features;
 	netif_keep_dst(dev);
 }
 
@@ -3081,6 +3104,9 @@ ppp_set_compress(struct ppp *ppp, struct ppp_option_data *data)
 				ocomp->comp_free(ostate);
 				module_put(ocomp->owner);
 			}
+			rtnl_lock();
+			netdev_update_features(ppp->dev);
+			rtnl_unlock();
 			err = 0;
 		} else
 			module_put(cp->owner);
@@ -3537,6 +3563,12 @@ ppp_connect_channel(struct channel *pch, int unit)
 	spin_unlock(&pch->upl);
  out:
 	mutex_unlock(&pn->all_ppp_mutex);
+	if (ret == 0) {
+		rtnl_lock();
+		netdev_update_features(ppp->dev);
+		rtnl_unlock();
+	}
+
 	return ret;
 }
 
-- 
2.43.0


