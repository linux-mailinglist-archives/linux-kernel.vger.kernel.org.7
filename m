Return-Path: <linux-kernel+bounces-853892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D305BDCD48
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D17333E1893
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2821313282;
	Wed, 15 Oct 2025 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcI6kY0q"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD13128D5
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512160; cv=none; b=jR+UPJ7QKKMBlgq31k++ksiFpisSnKF2utsZl+DioSQCCjG4fgU87XVUT0PrC4HbwqkwbwpT16zIuE/MD/ffI0X20mbh/Us220DvL0ixGe+dQYsUNIl/XBkozCk+nmM0bxUaD1NexLAPx4yCAFr1wgfeYYQu1cvE7qfhC7VStQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512160; c=relaxed/simple;
	bh=yd03i++/xv88QJgZo0ZPNbQK9vi5VCi99MKHAR0GtX8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoyYjCW2w6dEJCKs4HqwVblwL65BFLA/QJK7UaDr6KAO4QkVON11nWlRZ904jqRxTtiFfS9H8dzj91IigQqo0yZNPY/u9nU5PCDdnzK2d2vP60tSEJni79jASEnUKXDtXPppOX/2ezOnhv+rDEt7mAvfgw2GOC4TIAPifKxtFlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcI6kY0q; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b3ee18913c0so1000763466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760512157; x=1761116957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R+Xzhf/EFNne2mEAT5tPrrO/yOV+bjpVxO1xTpLKaG4=;
        b=QcI6kY0qbUbz8Ug3dXubOLDfLs9mt3HYi16UDdTcjdId67R8GCJQVTdP9MvT5a2+9T
         NRfihVnPc2ZSUmCOgW5EZyw3dJJuobkiDdjqwUv2L5msE45UiY8q1TUahpS1g6KbshFo
         XVO7bMkGND2ylJWOOM1Lqeognb4Y0HuCBOIvso/2bCPPOpf0nxJFEOnu11bPPBEefgNN
         Trp0BfCeMRXUCAq4jpCI/edshoKP7BTXV7SQv2ySHTrSp1v3c4CY/han68RztRDq0zCn
         j7EBe+hI2EaWsoM6y0XLI8lxsP0HCgCQTgDdJouVE/et0FTfp0nWnLXFHjULP3ZQ4XWe
         NkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760512157; x=1761116957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R+Xzhf/EFNne2mEAT5tPrrO/yOV+bjpVxO1xTpLKaG4=;
        b=AtBJuVlqOpLW1ZZ8k69MjS1wJT5P/iNhyjz9dM19VFy2eDmjvCbHsowxciJPlI99YP
         ciwhWj7C/hiNkpNduzK0WF74tCYVOsqsSUqCe12MNtx9xMdx5ek4L5SJH6zu4o6t8/+G
         Wr4kMZZQRrjoHN5a6RIzaGFftqdYiiy3K8jXE8HAuMhH3YthU/GgpT4C00+qFtPhrM2O
         RUPoXaFjH6UFpM+b0YsaX1p+8QHs8ku6lYnfVJPpMglPpgz8rRlD4qKbpGIigJ6BGRTE
         d3QiEkHyBTmwu1jqkSBuQUwCg7V90HeTqt/JYEHbfMjiDl3pB9r0nJsRw+j+m2YvV49T
         RMVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgeG/RSbHhykQzpCFCMXga2b+64kpsLWzTL12iahHXK+MTgFu0pV+5vR3EFj6M0s+0RMOlXaJZpopaIUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh2yGyTGb4RAPR0fjY2rb9D0LE8vaTjNtVkP5hNXrn1EA4lYFu
	WlArmFjbL3Wl69HMF1k1k5gQpfm+WSnnTNFBRKH3O+aHiRknt0/D/MGg
X-Gm-Gg: ASbGnctdCkMC/W/yBQ/mJWghO3X8RK+EMVRdam4Vs7ZaAReVr+FAinh40hexvgKiWdn
	HjPxjm9zqYi5CclUp4ora2NXyLFueUiRmiQHGED0oQID9DjdqrQsAUv5ygrnp2+VUDgggc7qi48
	wzrL5FRvoqcF9nj7SGQCZ6ZanJaxq1ATQiNHnNk/68iux9B6bRbT2CoRlKkGOP+/PmoTDmsK0eV
	xH8gL9uLyzYhIdnDwQP6TSWWOPEXfHjqFuy7jqdiMChuvXSCitgllAu2Y0ayMLzz9Qy+JEmkE6d
	wn2TUZhW+/ouQbYGiYs5FxD2KlfL3Swr4WBg15KvxnTyLzqrQ5NFXty88vWxtNpviVQmDVpwg0S
	fzFLpCujnWzQca//pzzZkHrzl4oXCEtS3VdF2zOWdVNf0b8/xHjGKSfBC+0QyNa1zupLdaCgMW4
	1Zg+3us6zjW3w57vWSvmohOQ==
X-Google-Smtp-Source: AGHT+IGi4c772T1EvouKGzfpRwCrJWZt2fsMF2Lmdp3HYx9/OqUd/nTP8dW704aXN7545LxIfOBBMQ==
X-Received: by 2002:a17:906:4788:b0:b0c:fdb7:4df5 with SMTP id a640c23a62f3a-b50aa08f7f4mr3152911866b.18.1760512156566;
        Wed, 15 Oct 2025 00:09:16 -0700 (PDT)
Received: from localhost (dslb-002-205-018-108.002.205.pools.vodafone-ip.de. [2.205.18.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5ccccaaba9sm157597666b.55.2025.10.15.00.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 00:09:15 -0700 (PDT)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
Date: Wed, 15 Oct 2025 09:08:54 +0200
Message-ID: <20251015070854.36281-1-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
tags on egress to CPU when 802.1Q mode is enabled. We do this
unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
VLANs while not filtering").

This is fine for VLAN aware bridges, but for standalone ports and vlan
unaware bridges this means all packets are tagged with the default VID,
which is 0.

While the kernel will treat that like untagged, this can break userspace
applications processing raw packets, expecting untagged traffic, like
STP daemons.

This also breaks several bridge tests, where the tcpdump output then
does not match the expected output anymore.

Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
it, unless the priority field is set, since that would be a valid tag
again.

Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/tag_brcm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 26bb657ceac3..32879d1b908b 100644
--- a/net/dsa/tag_brcm.c
+++ b/net/dsa/tag_brcm.c
@@ -224,12 +224,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 {
 	int len = BRCM_LEG_TAG_LEN;
 	int source_port;
+	__be16 *proto;
 	u8 *brcm_tag;
 
 	if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
 		return NULL;
 
 	brcm_tag = dsa_etype_header_pos_rx(skb);
+	proto = (__be16 *)(brcm_tag + BRCM_LEG_TAG_LEN);
 
 	source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
 
@@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		return NULL;
 
-	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
+	/* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag on
+	 * egress to the CPU port for all packets, regardless of the untag bit
+	 * in the VLAN table.  VID 0 is used for untagged traffic on unbridged
+	 * ports and vlan unaware bridges. If we encounter a VID 0 tagged
+	 * packet, we know it is supposed to be untagged, so strip the VLAN
+	 * tag as well in that case.
+	 */
+	if (proto[0] == htons(ETH_P_8021Q) && proto[1] == 0)
 		len += VLAN_HLEN;
 
 	/* Remove Broadcom tag and update checksum */

base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
-- 
2.43.0


