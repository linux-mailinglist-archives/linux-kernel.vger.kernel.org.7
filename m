Return-Path: <linux-kernel+bounces-772801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E354FB297A3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709531961484
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E8224234;
	Mon, 18 Aug 2025 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="g75xnW7K"
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D445B17996
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489936; cv=none; b=ftf7B5EGtJLVdUiQNZW4GXMELJIHbs3x8YGx7kGq9JYspE4Rbn9EzZFgMD0oeMZRZrdeEc0Xi+htwU6yAc2VLqAORC9qn7Ib2h9z1/oXuoOixHoRm4fFE2N7FZ8H5o6uTR0J90VPQxcurZtFBsIauOrt14IxVgVhuF/U22hDghU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489936; c=relaxed/simple;
	bh=PF/NWQP98V88ESXirITuXe8yFCbVWoj0uhtxpZ5J2fg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmA7lBEEj0TmE303OH4LXTkFlie9zVurELj8kV1d1HUYM20kVfflBV286X4LkZgfTnXyYBEvoQ6asi3Bq/DKX3RTnYF88E2WhiQnb6I8KsloHjgNxzyFjvcMCdEQJdEPpAvvTrTlVlSxeDjwdTkmjOrMHEiDhwQVg6uas6JxCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=g75xnW7K; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755489934; x=1787025934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7zBvKQh64ouPDTgDOIWSM87WqyKKvU2s9e70dMaylM=;
  b=g75xnW7KAo5XmllHCAduaAzLRN5LNPn3z+5YTNI8s5uow9aBzeZnHfYH
   6bGdIAPYfmry3o/ZBdocQLR89xfDtmAZzt2Uj+Bf5i2xQ2eadhZz0BVgu
   tagvvenA52uVQA9yf6Qe8eYfzHasbV+f1w/fqTh8xmmDm9Ot9YxgB0AkX
   b64DsHg1H/yP2e3j+eEh77QpZUseAnJQ9B4sI1yXxDkryPb7t+fwcQl6Q
   HtNNKBbeOrniMbkivswOAPaClIqeZxMYbnaxf7ZkWR/iVA0o/Klb8K0WI
   e8+9gvYxIKFZ/Jt2IFheTNRi0vPXR3eE6gk02bymaNq1EcBwBvNTYemfb
   w==;
X-CSE-ConnectionGUID: S811a9E+T9irz2cK5c2d5A==
X-CSE-MsgGUID: +3/1HGjHRHquMrRwFsRPng==
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="1289187"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 04:05:32 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:25235]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.91:2525] with esmtp (Farcaster)
 id fbf018b2-f0ba-4a33-914b-c655f26bd3c0; Mon, 18 Aug 2025 04:05:32 +0000 (UTC)
X-Farcaster-Flow-ID: fbf018b2-f0ba-4a33-914b-c655f26bd3c0
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 04:05:32 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 04:05:31 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
Date: Mon, 18 Aug 2025 13:05:21 +0900
Message-ID: <20250818040521.604-1-yuichtsu@amazon.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <68a208d0.050a0220.e29e5.006e.GAE@google.com>
References: <68a208d0.050a0220.e29e5.006e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

#syz test

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c index d9f5942ccc44..792ddda1ad49 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,7 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
 	priv->mdio->read = &asix_mdio_bus_read;
 	priv->mdio->write = &asix_mdio_bus_write;
 	priv->mdio->name = "Asix MDIO Bus";
-	priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
+	priv->mdio->phy_mask = ~(BIT(priv->phy_addr & 0x1f) | 
+BIT(AX_EMBD_PHY_ADDR));
 	/* mii bus name is usb-<usb bus number>-<usb device number> */
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
 		 dev->udev->bus->busnum, dev->udev->devnum);

