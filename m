Return-Path: <linux-kernel+bounces-816386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E44DB57328
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1167161239
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B7E2EFDA8;
	Mon, 15 Sep 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2sJIy8z"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5032E9ECF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757925474; cv=none; b=JfADFeGtD/G1SkHQ0ZApnv4tIiVQ1thILd2d37bRWYa4EBHicuu2iSRDJtvtX8Ch3NrKJEL10QKrS446VAB7/xZ2R2NT1yzqoDTQ8VOl5PrhVBHVYdw1dySzG3oSWjRB1QkKc66ST4aXnfwC/JAXdN5Qjv9tebrGuUcowoeGsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757925474; c=relaxed/simple;
	bh=IoXoMYGD+smW4KRtMQddL3etVmp1OCzVgb5FFVRsI1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azmwIvhUO3uhmFaMwjBjR+mRK+ISX78Q03qgTZpjHR/2u+Q1N8ErTLH14fREERqIx8Wv2mNEdhw5nTk/nqVKEQyQqx5laTZNGzKB44KS18C7DkX96258pi6ZBr3PSd1GnJfLSRofeSzf5kqVVILAhTu3uUHBbOhwwoUS/1pJA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2sJIy8z; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7762021c574so1679156b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757925472; x=1758530272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fTDZRc9WfTfrlcFQUerwoODqglE8lQQ10ruQLsCza5E=;
        b=e2sJIy8zJmYUhOCW+jpnt7NMFw+SZ1jZFts/n595W6HGiND++ygDv4HiIOAY6LWAIL
         dr+bUxr5a3ao8JEWe9wV9PU/stZtHlEI6U6Uq1EVazwsEeWky87c6znVIXpYg/XjdI0O
         FPmXTar3VZKM9tBkQFP8pnFspPgLcTPs3Qes7dLqGveM3QbANlaowRohM2Y3/Qswg/o8
         eOS00d6h3v7A1M1tDRRRhdHmk0/2c21aB7R66qOq7w4UIaohCZ4GlbJkmXZzfkAqOUa8
         C9YDCvIfqikbn24Riy+qYyKUhcL0uadV2b/+YTr2Qmzsk8YH4Qg1z6lD2Ztc/0OrUK3n
         SWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757925472; x=1758530272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fTDZRc9WfTfrlcFQUerwoODqglE8lQQ10ruQLsCza5E=;
        b=HpcEMNk4oMFYUV3n1gNVjXWuVX1d9Z8lH2TNUznuLi67bk+iZTFDrcg/pHKDHGNa4L
         EuxoJ1FK+nmcUnEIaw0E5KRQgtFHoDosw9hqyF0ghoHnK2/q6nAf2+aTSSa4sDTwqipq
         8VWgmW1X26uLicNYU+IHcnjrEZ+N0SZeqPbukb7ImPPZ54botxbdP9vxsqnjrUkyavTw
         +SVAb4nEFO40euV3xnd0eX3cgWNxhaGZLGquQhlG6+UaEkNIYetbpDpiV4FCCFbZL1zW
         7yrkhrI4DL1/KaH89cYNBwq853pM273ori5U3XqViYrWCH2rzT2Tv9lpdCCjF8NFs8Ie
         hQpw==
X-Forwarded-Encrypted: i=1; AJvYcCWKgA5PULXqDPT4YvDD29odxV/ITkUcIJ7yXLD0JgNw6aajagzeQO9TbjsRaWAprd7SgmOS1pAb3srlP/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6dQoYm37QeGZnB36Y4frRnBwTIZf+D3KQ1XPKTEI7ltgQ3Bas
	1PMRC/WLlWMCzQhmnKo7IJ6MMw9T6nXNSezF/Id/OmuvVb7mOu5f/UOwg8kUQdgPuWg=
X-Gm-Gg: ASbGncs4xKgHSkhqqzYDk3YRFvMw1mbeZUugCwOvtxHTkJtxanhn5gXR8qNXbZ4F8LQ
	FFTArxfT43A6328sTsi+RZVWk6KMtAVOiWpoyiSkeI7zrVowG3xF+lYEC6bDb+xmDDnCFRhxrQy
	sEeA3ROMNO62MF76mz0RjQRHTSypMADpcQpxIWLjGTEVwaKp5/gc+P8VFrTuoLGwk8wiXci6sL3
	S9lsdgDaySK4KfRaKVaBeAeGAbJgDIQja41sPiPBbtb7bkmnQjJhTvpuurqwbmVVKcudt/kSClL
	YyP59MgKewMjCgmSPypdiDHGCvzsx5bQE6ECyDqqo24VrwS2EmahQnK8VvQBrizFBUY9txw7h7k
	/3tgkYm8cp6FH3RVNVbg6ReSqkdD6/SZqo3d3zv2c8Q==
X-Google-Smtp-Source: AGHT+IHMQRChdT9odsmheH7egJCC4/DPJO3OX7FlwDrV3iyyRGI4Io9Ex6QozyJocQpSdCghkAkn9w==
X-Received: by 2002:a05:6a00:1ad4:b0:772:871c:1e49 with SMTP id d2e1a72fcca58-7761219836dmr13358955b3a.29.1757925472305;
        Mon, 15 Sep 2025 01:37:52 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b1a031sm12901974b3a.57.2025.09.15.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:37:51 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Petr Machata <petrm@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH 1/2] bonding: fix xfrm offload feature setup on active-backup mode
Date: Mon, 15 Sep 2025 08:37:41 +0000
Message-ID: <20250915083742.423741-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The active-backup bonding mode supports XFRM ESP offload. However, when
a bond is added using command like `ip link add bond0 type bond mode 1
miimon 100`, the `ethtool -k` command shows that the XFRM ESP offload is
disabled. This occurs because, in bond_newlink(), we change bond link
first and register bond device later. So the XFRM feature update in
bond_option_mode_set() is not called as the bond device is not yet
registered, leading to the offload feature not being set successfully.

To resolve this issue, we can modify the code order in bond_newlink() to
ensure that the bond device is registered first before changing the bond
link parameters. This change will allow the XFRM ESP offload feature to be
correctly enabled.

Fixes: 007ab5345545 ("bonding: fix feature flag setting at init time")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/bonding/bond_main.c    |  2 +-
 drivers/net/bonding/bond_netlink.c | 16 +++++++++-------
 include/net/bonding.h              |  1 +
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 257333c88710..2182b34226ca 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -4411,7 +4411,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
 }
 
-static void bond_work_cancel_all(struct bonding *bond)
+void bond_work_cancel_all(struct bonding *bond)
 {
 	cancel_delayed_work_sync(&bond->mii_work);
 	cancel_delayed_work_sync(&bond->arp_work);
diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
index 57fff2421f1b..7a9d73ec8e91 100644
--- a/drivers/net/bonding/bond_netlink.c
+++ b/drivers/net/bonding/bond_netlink.c
@@ -579,20 +579,22 @@ static int bond_newlink(struct net_device *bond_dev,
 			struct rtnl_newlink_params *params,
 			struct netlink_ext_ack *extack)
 {
+	struct bonding *bond = netdev_priv(bond_dev);
 	struct nlattr **data = params->data;
 	struct nlattr **tb = params->tb;
 	int err;
 
-	err = bond_changelink(bond_dev, tb, data, extack);
-	if (err < 0)
+	err = register_netdevice(bond_dev);
+	if (err)
 		return err;
 
-	err = register_netdevice(bond_dev);
-	if (!err) {
-		struct bonding *bond = netdev_priv(bond_dev);
+	netif_carrier_off(bond_dev);
+	bond_work_init_all(bond);
 
-		netif_carrier_off(bond_dev);
-		bond_work_init_all(bond);
+	err = bond_changelink(bond_dev, tb, data, extack);
+	if (err) {
+		bond_work_cancel_all(bond);
+		unregister_netdevice(bond_dev);
 	}
 
 	return err;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index e06f0d63b2c1..bd56ad976cfb 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -711,6 +711,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
+void bond_work_cancel_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
 void bond_create_proc_entry(struct bonding *bond);
-- 
2.50.1


