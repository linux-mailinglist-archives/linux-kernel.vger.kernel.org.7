Return-Path: <linux-kernel+bounces-894191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB09BC49718
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F90188A607
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 21:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E75F3358C6;
	Mon, 10 Nov 2025 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLNs2Y29"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8662E62C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 21:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811120; cv=none; b=tTYLCvvjB1YeC9km+Axaq2hEa7cEy7+aSjVpA/FglIUPqPuurZ6Slns2tmLq3kmzWpXBFHH7QWUfquMLUEnMLbM4OQ9AsOvSVQK/c8Y3mvr0GSrh/JoMNZ0Eze0NLa6BYFrJUiVjQYWgb+ELjeY5r5rJPyubW4VEd4DZhcWe5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811120; c=relaxed/simple;
	bh=ReFJ9OZoON7cVfH4AO8Go6brW2k+pZSXm+hFUwI7Ln4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rZi0xbIhLnkrwhw+kjmhoECimS4tKB4UyJa/+5C3WOP8BQ7WyuDrG+hGefLWs2uzNhDwxJnVOyG48qs9CNuZdJR/oTFLEPtfFqFmPomAzfO0u0+sTRXs6umwnWoG7+9HAZlrqe7F78nSjbvKq6xwVhqqVdPgI7YYqH7cjbMpgSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLNs2Y29; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640ca678745so6166797a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 13:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762811117; x=1763415917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGTgl2i/UyftaOBD+JT6w4rHYAVWvW3JzYB7N9vcql0=;
        b=KLNs2Y29alUdylM+0XTXKln8Nam2I5P6ie/DJLaJ1S/5vuAFlGC+D5qaJwWy6lIVCi
         uGZw1oJUOX6LrGP8g7I2GNWPoDCzzQjC1FNHgQ1+TRWbS807c+DeM/r2cfvrKQszt/Jg
         taho/CWeEFLhQJuhlG4zE06KNyXr3v50icajGrKbJHwQTk3oV4+gzo5MYrlEkbbxW77y
         66BCt39Y9NKP1IXUbW9X46DdBSEB0XjJVL9VpncdiY5xlHXfaopiEYzspMW73jGwYpCZ
         sO/tq2vUDH0IybdqkQ5Tn5b9U84WSPKbkqlCdUffgA63qYkV7eJC4tX3Ro7UcODxjuLh
         p5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811117; x=1763415917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGTgl2i/UyftaOBD+JT6w4rHYAVWvW3JzYB7N9vcql0=;
        b=LFeOyzi292TGkyLYQub9gmjjWUhZjU+1sY8C/2h2H6un/HBF8Bd4nnodMSA6tnnHgk
         XqAXqHyMvxrt9v1o53eSGUG3JUK5ASzuDJrFx2KCerR3JzyK87bODlO0Ynk5RtsDjhgw
         ZGz4vFZ4Vvqx1tL0uYDfptS+MHESw4z2C+vAF9WuEPqILaYh8LZBLYOsnqzW8iqSYEgG
         CiXZVXP2r1pENdXPDmBBd68l2Ms76zR2s8Kr2pmWbYagqFCryGFumutil8yIGn4+SzcK
         gbwBgt7GinDGuEN58D9DwS7ytXIUde15dtlmY/q/b+h74ar5z9JyLGBEWolkHit1xkt8
         5fog==
X-Forwarded-Encrypted: i=1; AJvYcCVI1YQ/RpCALw7HcHjMfCL/9sS4SJpfFySIQVJOBcw0ZD/dcAg1yTmgS8GodB1+0lKd61mIMbQWdbORDIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7MQ/sXt8at/pjQa3Cox6E1trOZuNmvYAIbJIO706UnaK6bDY0
	z0GwEgWPBAYAz3wXFD1bWKwh9lwa9PNVTvg/fMbqwd96h1v8LVS1snaP
X-Gm-Gg: ASbGncutM6zScv6HxJIgIFcpdtgO89Jo7Z08smRDDih0v18KztXPRItY/uGFuaQb4Sb
	NpE4ejnR3DUKwYtacQKcn4/9vNtoibUYpv5NJ59v/K77T4oEtdFhSYL826//9TpMP8fuMj2bjtv
	XGgDpblscP8q1xQ7SMdeNCD9K3jl+eFUZ92XrkV8/K3IpKj+E0XxYRCvU50OgylDMwxgtdm75HO
	vqpTnh8mazJ3YS/9nn63br/3xzhzjvPFQyzU9and23fVytkDoqbnEJKof1RKWHjv13NaLQIWxbK
	8EGIIpARZ+zx7BNK+O2xaMnu/xXaCq992IhdZmMmC+vNiMuWR3tFP7K3DMNuyvItq86Yi9U13Lo
	hFaPxA+aRqOoFKaSgMGBXiKr0BoCIzZQJVAN8OJIoQUHHTPtp8354c08OgAcIrzqSfw9dKgm0lg
	yy4kAbQP0fuuoWo8vLD++KCr7woHMu9/Gt1x9lf9r8ske+NyumDHGSpwBM1l3QFv7AXkY=
X-Google-Smtp-Source: AGHT+IF6YTEZqlrhdD9thiporqdukuPSyaJNyqEDV/zruVy3WP5WgEPYOPf+qwEg0nMSFUgrtstkKw==
X-Received: by 2002:a17:907:6e9e:b0:b70:b13c:3634 with SMTP id a640c23a62f3a-b72e041d1damr1036715366b.25.1762811116957;
        Mon, 10 Nov 2025 13:45:16 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bdbc9656sm1197202966b.7.2025.11.10.13.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 13:45:16 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC net-next 1/3] net: dsa: deny bridge VLAN with existing 8021q upper on any port
Date: Mon, 10 Nov 2025 22:44:41 +0100
Message-ID: <20251110214443.342103-2-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110214443.342103-1-jonas.gorski@gmail.com>
References: <20251110214443.342103-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently adding a bridge vlan to a port only checks for an 8021q upper
of that vlan on the port, but does not check for matching 8021q uppers
on other ports.

This leads to the possibility of configuring shared vlans on ports after
adding uppers.

E.g. adding the upper after configuring the vlan would be rejected

$ ip link add br0 type bridge vlan filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ bridge vlan add dev swp2 vid 100
$ ip link add swp1.100 link swp1 type vlan id 100
RTNETLINK answers: Resource busy

But the other way around would currently be accepted:

$ ip link add br0 type bridge vlan filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link swp1 type vlan id 100
$ bridge vlan add dev swp2 vid 100
$ bridge vlan
port              vlan-id
swp2              1 PVID Egress Untagged
                  100
swp1              1 PVID Egress Untagged
br0               1 PVID Egress Untagged

Fix this by checking all members of the bridge for a matching vlan
upper, and not the port itself.

After:

$ ip link add br0 type bridge vlan filtering 1
$ ip link set swp1 master br0
$ ip link set swp2 master br0
$ ip link add swp1.100 link swp1 type vlan id 100
$ bridge vlan add dev swp2 vid 100
RTNETLINK answers: Resource busy

Fixes: 1ce39f0ee8da ("net: dsa: convert denying bridge VLAN with existing 8021q upper to PRECHANGEUPPER")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 net/dsa/user.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index f59d66f0975d..fa1fe0f1493a 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -653,21 +653,30 @@ static int dsa_user_port_attr_set(struct net_device *dev, const void *ctx,
 
 /* Must be called under rcu_read_lock() */
 static int
-dsa_user_vlan_check_for_8021q_uppers(struct net_device *user,
+dsa_user_vlan_check_for_8021q_uppers(struct dsa_port *dp,
 				     const struct switchdev_obj_port_vlan *vlan)
 {
-	struct net_device *upper_dev;
-	struct list_head *iter;
+	struct dsa_switch *ds = dp->ds;
+	struct dsa_port *other_dp;
 
-	netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
-		u16 vid;
+	dsa_switch_for_each_user_port(other_dp, ds) {
+		struct net_device *user = other_dp->user;
+		struct net_device *upper_dev;
+		struct list_head *iter;
 
-		if (!is_vlan_dev(upper_dev))
+		if (!dsa_port_bridge_same(dp, other_dp))
 			continue;
 
-		vid = vlan_dev_vlan_id(upper_dev);
-		if (vid == vlan->vid)
-			return -EBUSY;
+		netdev_for_each_upper_dev_rcu(user, upper_dev, iter) {
+			u16 vid;
+
+			if (!is_vlan_dev(upper_dev))
+				continue;
+
+			vid = vlan_dev_vlan_id(upper_dev);
+			if (vid == vlan->vid)
+				return -EBUSY;
+		}
 	}
 
 	return 0;
@@ -693,11 +702,11 @@ static int dsa_user_vlan_add(struct net_device *dev,
 	 */
 	if (br_vlan_enabled(dsa_port_bridge_dev_get(dp))) {
 		rcu_read_lock();
-		err = dsa_user_vlan_check_for_8021q_uppers(dev, vlan);
+		err = dsa_user_vlan_check_for_8021q_uppers(dp, vlan);
 		rcu_read_unlock();
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Port already has a VLAN upper with this VID");
+					   "This VLAN already has an upper configured on a bridge port");
 			return err;
 		}
 	}
-- 
2.43.0


