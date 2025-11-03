Return-Path: <linux-kernel+bounces-882230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE65C29EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D8F34EAB9A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C62882D7;
	Mon,  3 Nov 2025 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TM/2558W"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F828B663
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139710; cv=none; b=klGHEaPfHEJmREswS5+ACVcW82P5zIWJSO+0A3YtG0ofAHOpWZzng//FhU22zxtP0mboe7Ax0I3RUvN2Y7F4E+byS2wUZB5vOH80DeK1K9ZH69ih35F7wmcjg9VnP1F11amec81/iNpbVQsVAsgpb7jQCwvVE1675LVZfj3/5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139710; c=relaxed/simple;
	bh=6SQN0vecgbgR6BRspTq3+ZfoO061hFhPK3vugcQ2Ork=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oB2r6joA4K0d0DqrkhBh7oXq8pB/X7voJl7zZbir8BQ2VVzNm7SEe4Fi2FaB2McvKOy4CLooImloh178xKjmEzo7/hag6AK20jPGSlG0TBG6JFgnrJYSVc6iLr3zFseWCsyBmJjJVfdOuVvLcAR9lG9ELXSDfJwpftamu1s3dGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TM/2558W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2951a817541so38207395ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 19:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762139706; x=1762744506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXsyXRBsjl/UJdnzdmn5tcpNjcGfeLeLeRD6/RJCrMM=;
        b=TM/2558WbPfibgmubtZZFCsvLhq2VxiYUx72McFQAyJVswXHE1gRs97zGzXX83d9pM
         6nGtGAhiDRAO7pmfZxlCOmhewr4Sw9XVIBc1wY9NYECSDrvF7vPhEjFJ4n3vW15mfiUj
         yNv1iKXHK1vKJFxex7RNoGc0Y2DKy9UBGTc50Fupe8IwZ28Bfmu6Hkrl9uIe0JiMXVUv
         MwztBNsIlCqBTEW/n5qIVr/vuihAq2Sm0r2MSvnmMkLmVzSpF39MxGZ18bK+5hB+szd2
         vlbFanByBetAAANlpAaTQA3hNvJwuCIJf4ZebfroAdZmaLq76MIFy+CHcnb/pK1NWER/
         McTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762139706; x=1762744506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXsyXRBsjl/UJdnzdmn5tcpNjcGfeLeLeRD6/RJCrMM=;
        b=XszWtjJd8nuTGhm03+KW8RGL0a1K84RsSbvO5BzYoQLeZoN6vh+qgmiBnNJG7oiCPF
         gw1kjNlU0T9QZ/Dw2ALhS0wlU5A/WWsf2L+r1jlgHie243N/ey109hfQ+BJaPVbQVXkk
         aMGL1+Ip5QRM//ZtPnE5zDo6DC6kV9lITMHzNYLCKJERt8Ezw51pe1A9gxVrWCq6yQ5n
         5QpX/2fXn6hkL0DSUgdBtd3RGO7uRhrzbKLu8wIQkik3uNNrosUID8XroKJzwjPcEngl
         fO4wJ9LpC1CnQEFvhtCKw7VYus9Ij+niVdq57i3FTZVKeZZl1Z3UXKeSNJFihMW67CL9
         fFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiW9wRbdrzk23NT9M3CQYmTHGKu0Y8YRapyqKngNAwkgDG4br7M8F0lgVVRRcRy1lt2pQlEdYu6rNzcaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcLBXN+eTOcoI7/+tzFYUDUJ6hQ8Q6lnLSuia5pjabMdgphb1
	HeR4dOCeEK0IUYvcPwaDhZ3ww1CfiZGL1DUqroe33CjUBOAEVZBJ8vqO
X-Gm-Gg: ASbGncugSKM1vtIUPbOkDgv5Xv+UI4+mOsVIPp1PeBiQRDWNaV1G3EEU9D1F5YsLfuL
	HG8mgX6NcZAAHEzudvAjRvFoACOjzyFIhuljXUZXNoFeQ51m+L3yf2U5uW0GYpYZIFD1wI7ZhK2
	bioLKTdZOgsNNQxZrmtaGFwjhICAaw/572fuBoQEcAOws7+QaZS25hf0ZI0fgmXmWS7eXO09AAS
	YHrBu/bJNmXoY24OoUCEIHtE6FK7pC6/mCQVf/Emczwb8XREMMEV20A95bEL5zkEs9DtapZuTSk
	t7iaA90e3p+J2i+fo/yn8Eu4YPYk1R6nM7e/7VuqLBTYfVu8liZ1wji9KwC/7X3GaxkJJ526zJw
	68IoOe3r6MJrasb4TwSdHAdHWm0C4FhZ+r3U8KiGu7/Lo+AAEW4n3
X-Google-Smtp-Source: AGHT+IGG+q0ieQsp6YHQm4OSNdUh6TFKKIYVrooi6skX+w389/d71u+8qnyE0A7jThdV080hsrl80Q==
X-Received: by 2002:a17:902:ecc7:b0:295:7806:1d73 with SMTP id d9443c01a7336-2957806269fmr60832765ad.24.1762139706174;
        Sun, 02 Nov 2025 19:15:06 -0800 (PST)
Received: from gmail.com ([2a09:bac1:19c0:20::4:37d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871058sm102183285ad.3.2025.11.02.19.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 19:15:05 -0800 (PST)
From: Qingfang Deng <dqfext@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] ppp: enable TX scatter-gather
Date: Mon,  3 Nov 2025 11:15:01 +0800
Message-ID: <20251103031501.404141-1-dqfext@gmail.com>
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
Enable NETIF_F_SG and NETIF_F_FRAGLIST, and add
ppp_update_dev_features() to conditionally disable them if a linear skb
is required. This is required to support PPPoE GSO.

Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
v1 -> v2:
 Changes dev->features under the TX spinlock to avoid races.
 - https://lore.kernel.org/netdev/20250912095928.1532113-1-dqfext@gmail.com/

 drivers/net/ppp/ppp_generic.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 854e1a95d29a..389542f0af5f 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -498,6 +498,17 @@ static ssize_t ppp_read(struct file *file, char __user *buf,
 	return ret;
 }
 
+static void ppp_update_dev_features(struct ppp *ppp)
+{
+	struct net_device *dev = ppp->dev;
+
+	if (!(dev->priv_flags & IFF_NO_QUEUE) || ppp->xc_state ||
+	    ppp->flags & (SC_COMP_TCP | SC_CCP_UP))
+		dev->features &= ~(NETIF_F_SG | NETIF_F_FRAGLIST);
+	else
+		dev->features |= NETIF_F_SG | NETIF_F_FRAGLIST;
+}
+
 static bool ppp_check_packet(struct sk_buff *skb, size_t count)
 {
 	/* LCP packets must include LCP header which 4 bytes long:
@@ -824,6 +835,7 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case PPPIOCSFLAGS:
 		if (get_user(val, p))
 			break;
+		rtnl_lock();
 		ppp_lock(ppp);
 		cflags = ppp->flags & ~val;
 #ifdef CONFIG_PPP_MULTILINK
@@ -834,6 +846,12 @@ static long ppp_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ppp_unlock(ppp);
 		if (cflags & SC_CCP_OPEN)
 			ppp_ccp_closed(ppp);
+
+		ppp_xmit_lock(ppp);
+		ppp_update_dev_features(ppp);
+		ppp_xmit_unlock(ppp);
+		netdev_update_features(ppp->dev);
+		rtnl_unlock();
 		err = 0;
 		break;
 
@@ -1650,6 +1668,8 @@ static void ppp_setup(struct net_device *dev)
 	dev->flags = IFF_POINTOPOINT | IFF_NOARP | IFF_MULTICAST;
 	dev->priv_destructor = ppp_dev_priv_destructor;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	dev->features = NETIF_F_SG | NETIF_F_FRAGLIST;
+	dev->hw_features = dev->features;
 	netif_keep_dst(dev);
 }
 
@@ -3112,13 +3132,17 @@ ppp_set_compress(struct ppp *ppp, struct ppp_option_data *data)
 	if (data->transmit) {
 		state = cp->comp_alloc(ccp_option, data->length);
 		if (state) {
+			rtnl_lock();
 			ppp_xmit_lock(ppp);
 			ppp->xstate &= ~SC_COMP_RUN;
 			ocomp = ppp->xcomp;
 			ostate = ppp->xc_state;
 			ppp->xcomp = cp;
 			ppp->xc_state = state;
+			ppp_update_dev_features(ppp);
 			ppp_xmit_unlock(ppp);
+			netdev_update_features(ppp->dev);
+			rtnl_unlock();
 			if (ostate) {
 				ocomp->comp_free(ostate);
 				module_put(ocomp->owner);
@@ -3539,6 +3563,7 @@ ppp_connect_channel(struct channel *pch, int unit)
 
 	pn = ppp_pernet(pch->chan_net);
 
+	rtnl_lock();
 	mutex_lock(&pn->all_ppp_mutex);
 	ppp = ppp_find_unit(pn, unit);
 	if (!ppp)
@@ -3562,6 +3587,7 @@ ppp_connect_channel(struct channel *pch, int unit)
 		ppp->dev->priv_flags |= IFF_NO_QUEUE;
 	else
 		ppp->dev->priv_flags &= ~IFF_NO_QUEUE;
+	ppp_update_dev_features(ppp);
 	spin_unlock_bh(&pch->downl);
 	if (pch->file.hdrlen > ppp->file.hdrlen)
 		ppp->file.hdrlen = pch->file.hdrlen;
@@ -3579,6 +3605,10 @@ ppp_connect_channel(struct channel *pch, int unit)
 	spin_unlock(&pch->upl);
  out:
 	mutex_unlock(&pn->all_ppp_mutex);
+	if (ret == 0)
+		netdev_update_features(ppp->dev);
+	rtnl_unlock();
+
 	return ret;
 }
 
-- 
2.43.0


