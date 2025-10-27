Return-Path: <linux-kernel+bounces-872466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D3C1143A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632773BB9F7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27F2DCF72;
	Mon, 27 Oct 2025 19:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHxajL7a"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0482DC766
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761594395; cv=none; b=cu8hPcwQVfKsvmvKV4XeAcePJf4OKAFWSIATN5J54pH7U1ao5a7qNL2kCu15q4vaj26siNUxWs/iBnWnwpVS9mqQjmBA5t8OqDocBGIdZ4WpbAJtw1JwLH+K1XZQLxEwLtcJd8BBuBDzOYZckTx1Byx3jHRd/wbPFyO58n0GuW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761594395; c=relaxed/simple;
	bh=znaD9C1ITWlqa4RUrGrN4zi74wNoaCwyD9gcXPwB/h4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aCbVfxNoPAX6yv2owolPhq4chxL8HMOH7aAYoqgFopBmGjqfCW/TB7G18mC3FS3aP0QV83jOVCQGRliMyjAEK93d0CM4R5hoI5FyKGhek+7gmNvpTo0l1baiXWg03HyK7Slsx+hspQn3NAmCVTEMSoXM9lQ3uPEpV3xtfccxo54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHxajL7a; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso8128750a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761594392; x=1762199192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfHwNRKmLdBsQOGHfDtNbPOh+J8Tob6C3j78UQkTd5c=;
        b=cHxajL7aQYaMbf3bHhbnBgGDxxlSUUi3CsB4Y0WLXZzuTNXMAQXeHHNSDQyrzIXUzf
         FV8mxEF8jKWhq5J5Fhf7rAzitR0nvuUklaPpsg5XZdsthPQ2eSlnIPZ2wQDQiQTGwXkA
         mdfItaZKxWQ6ucmn6PTV9by14b8lj+4SvNNdnHrlu01lhbJplMVMPZFvMw0KJ+EWv4pG
         lLlmm+nj6N9H0nZue+gfMJtwgTMgSUCouZ28DURFX29C08LC7ls0Ydh7dkEVFPXr9BME
         OtzZu0rhcCa4k0D/owlaOt72Wufy9FXQAXWwEYhOouMWGfIct8Kl37YluRUhH6dxFNmb
         YKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761594392; x=1762199192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfHwNRKmLdBsQOGHfDtNbPOh+J8Tob6C3j78UQkTd5c=;
        b=FFUoPvgJFqPIvR1XMLm2kGSTSmMg10tvTiwWRt709I6YjRsUY6SM4/AK2gyr2E5HnC
         4iajzQwXvR2MgT5dySZemEN9Wg+Pzp0C35OTkwNCtaWZnPXjUNqB8zCqHsS8L5xFLRQ7
         JfdDW/b+yIdpP5PhyzQqZKFrPjtrPgN4pNl0iYYqlPFdWJ2YJDJDSclnIxAi8+/JKiif
         BVD212lvqsGdpsCA9/wqLYLEh1T7xycHy9YssJhteCT+IDgW6UXPrXLeYqrcuosTt3yu
         OKWFRzPFu11QYnSSjaVlL3KjgzQl08UAL1lYdUk88GJ2VDLF12PhLVrGNJ+9iv6HrYRC
         Z2gg==
X-Forwarded-Encrypted: i=1; AJvYcCUyZ4SUX6rHm4PQ5lEEHwUuzC2RaZfoBEAEiz90MLZeL08WnBjEx2x1Rrolse7a6J5HFACDmu0IcM9wOJk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4B7XvAgwsS4TKVSF/JbVtFrOr74gHs+7uUiP6P7zpVlyqTLQ6
	pMmkiomg/4gQrQsaLL/n7qQxSDVGrYh2izZq8JP1sFSKELOUzzz4lypA
X-Gm-Gg: ASbGncvCPtlzJ/CTt2bDlF/bSAaOtqjQRL7By0gSG/0IT2BFvqczR4IWfr0iGiOnK/1
	ZTqiUvsNYYNzja0tji32nhMvlmAnD1QihdW1maVa0RyJuZjM8otQ9CgKt3MiJn2bJ+F5ey4sqNO
	8wfyK4OEv1zBuHZUf5zHyAFnOODZCYEBgik1v1sq0trx0Wkdx25tXV0kRTTB08MRteFSjqCozgo
	F41rKSHbqOHCElHmM8BYjPj++R763K4HvmaPnycON36n1o2XVNrAO7kdJMK+FZzG8vdQlOPA2jT
	IY5PYsK67dDG50OwLPzf7Hd0cxi3KJvCOozDKS/3dtIwJMBIr4cxdSGddV6K+WdPadICaHveOtI
	yDMJYZWhD5xkM40S1rB+049t4IwDckuzbab+7q4CIhHZMZLCFxoO90P7eUkJx8AHU4234+KJxT4
	hfA9dTIJeJ+U7sDDpHJRa+Qkkf9H4VZ31Dgjr1ibXSjb8depvQZKisjh5uP3GLJaSqsw==
X-Google-Smtp-Source: AGHT+IFaQrXgEZiPvJMRaaPNtsLgHDcXezwU0wDasdjJ3W+gyc1PWGYIPhmSCVU2aunfIh4C6JTOOA==
X-Received: by 2002:a05:6402:50d4:b0:63c:13b9:58b0 with SMTP id 4fb4d7f45d1cf-63f4bcb05bemr575785a12.5.1761594391575;
        Mon, 27 Oct 2025 12:46:31 -0700 (PDT)
Received: from localhost (dslb-002-205-023-060.002.205.pools.vodafone-ip.de. [2.205.23.60])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb9fa6sm7039317a12.31.2025.10.27.12.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:46:30 -0700 (PDT)
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
Subject: [PATCH net v2] net: dsa: tag_brcm: legacy: fix untagged rx on unbridged ports for bcm63xx
Date: Mon, 27 Oct 2025 20:46:21 +0100
Message-ID: <20251027194621.133301-1-jonas.gorski@gmail.com>
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
v1 -> v2:
 * rewrote the comment to make it less wordy (hopefully not too terse)

 net/dsa/tag_brcm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
index 26bb657ceac3..d9c77fa553b5 100644
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
 
@@ -237,8 +239,12 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
 	if (!skb->dev)
 		return NULL;
 
-	/* VLAN tag is added by BCM63xx internal switch */
-	if (netdev_uses_dsa(skb->dev))
+	/* The internal switch in BCM63XX SoCs always tags on egress on the CPU
+	 * port. We use VID 0 internally for untagged traffic, so strip the tag
+	 * if the TCI field is all 0, and keep it otherwise to also retain
+	 * e.g. 802.1p tagged packets.
+	 */
+	if (proto[0] == htons(ETH_P_8021Q) && proto[1] == 0)
 		len += VLAN_HLEN;
 
 	/* Remove Broadcom tag and update checksum */

base-commit: 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
-- 
2.43.0


