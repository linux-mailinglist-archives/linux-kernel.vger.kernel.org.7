Return-Path: <linux-kernel+bounces-772882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4DBB298D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 07:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2845B18A243C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 05:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4626626B755;
	Mon, 18 Aug 2025 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="tsTLch9I"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E713AD3F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755494040; cv=none; b=SMXNy0qjv1+pT5S4BQkzHEKX+KYp+Kq1YLXwmKc4DkBbNUCS0IC5Pe/VnQW8Mjd7O+qWYGAkWJzJfmW3fBZt+0DneBG0rW+Ze0YxW+6WCIOfQWwS6PGpJ4CgLin/mE9jJWBKaCL8Bopcsz0dOLyFIIto9/39XS9BCNXRpl3DPzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755494040; c=relaxed/simple;
	bh=4/Lo7ANAThpJ2jKTanmgI8ssEdDpB4ycWMSopZHxwbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq5JKwUYuNxjikiUkwmjHRJ3niHbACcimCatQDnJFAKgB0SXrI1i6wtdmvKUqDjY1Ro4+sv6Cw6dHSTdPq/KnRZrFeGRkMPjDOTGMeWO4DheCRFue1CCF+j0mZYD5R8dn8Z+Mf0QK9fT97y8qa1QMDj5LFFAg+QE5FpfpM+l/WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tsTLch9I; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755494039; x=1787030039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3q1NPV6E0XEHi/HPl47VDsSSGEfiKlQQ/KVoLITUTiE=;
  b=tsTLch9Ig4zqBg/UHzjqt2eBpcb5Ss2UzH8rZ6Wa+l8g0Z160T7aZNL+
   BSeWOWsy8qsb9dxYIZhenQmpJiJ3TDErYi8ZcLLimz2pniNKV4GS4p7nP
   jllzKucOppMHw6nh5NRGEynr/XMHfy/uSOoZh7fh+qUQCmMmOCWIkMPF5
   BLJaBq5hHifHUk/huBePWOBVvYUWVmle1D2bocZYngc8+fwlfOv+3pOEX
   Xn/+za81cmzGJyXuxum343qGMGiZzkJbpb2K3DqH++ujHn4VVog0KLMZJ
   noekboEpKmytxKhgO6lYCWhbihveyzcmwZsi5KyaWsCEgLfNWCx1AX2tR
   g==;
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="225310762"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 05:13:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:43968]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.152:2525] with esmtp (Farcaster)
 id 6b62d0b6-0e01-406c-886f-149212ee19bf; Mon, 18 Aug 2025 05:13:57 +0000 (UTC)
X-Farcaster-Flow-ID: 6b62d0b6-0e01-406c-886f-149212ee19bf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 05:13:49 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 05:13:48 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
Date: Mon, 18 Aug 2025 14:12:10 +0900
Message-ID: <20250818051210.850-1-yuichtsu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
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
 	snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d", dev->udev->bus->busnum, dev->udev->devnum);

