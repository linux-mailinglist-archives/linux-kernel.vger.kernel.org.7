Return-Path: <linux-kernel+bounces-772939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5FB29996
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 08:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AF81B2006A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB90274649;
	Mon, 18 Aug 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="JduY+tti"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD752741CE
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 06:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755498152; cv=none; b=rlAdLsGOKBphONHSwDNQNX99nLN++MLsey3VQyut6sLa3HXEjTQc1udO39js78Tdiyj06iMwneC+jZGeTqZpqe9Vk1vCWlv6+PZcLPQGLwWlszjFz50KxZ9y7bDQpmEzcDCt8ISz6eW4jTuBKRUQrAXeurCGzURDXawcEzThpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755498152; c=relaxed/simple;
	bh=QkCmELx43nhKBx9DWqiZ4e+Fzw+hmR+b95y/LMQT2HU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBwVAmbFGbkSjleIaBDKPlkdPCDq/5FVtUgSTOuY5z3A1hAm2hy5COfdds8fXjtddlfj+m2S92hN/KQkTnjBXUHxXI4m26hZmMsHLJZVIYkXFnmY/zcdj5OVjryEeAGZ+quIG260QY+n1aAaCMeNmAha9zACddrAT7hXMrKB8vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=JduY+tti; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1755498151; x=1787034151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eHDl9di2azKFP6hxmEmdkExgr6ZhGV14JdRIo7MEkyY=;
  b=JduY+ttivkNpV41RLAibaVGaZqQIJIw9fYg+xbx+tuwW2ORv9TAb+qoN
   nK7PQ4XfabwkdhAAdOBbU9At3AgdD+CBsUEKuZSWDndzATlfew1dBGLNQ
   Qe679Y67WsbPHXuXfUuOMRme0Bxd+o951GrEPg1l/mfgRIO0zsUDVVc9q
   kCTwyyBdpOz4dt180BkDwcy9M0FEBo17gOXWccMqHAKTUzghKbuO+DJFx
   kM+RyJcEOBh6hdftH+a/UKY7+NSQy/5PbjhUSKYQUu5vohMdspiBwGjnS
   xL5gFdtc0Q0wASwHF9k/U4DgJX9B+YflPxl+uZmYg3zDHxZYtVLiRcqLB
   g==;
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="430088303"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 06:22:30 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:16884]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.67:2525] with esmtp (Farcaster)
 id 6e44d647-ad66-40ec-b146-a62a38577547; Mon, 18 Aug 2025 06:22:29 +0000 (UTC)
X-Farcaster-Flow-ID: 6e44d647-ad66-40ec-b146-a62a38577547
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 18 Aug 2025 06:22:29 +0000
Received: from HND-5CG1082HRX.ant.amazon.com (10.37.244.10) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Mon, 18 Aug 2025 06:22:28 +0000
From: Yuichiro Tsuji <yuichtsu@amazon.com>
To: <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [usb?] UBSAN: shift-out-of-bounds in ax88772_bind
Date: Mon, 18 Aug 2025 15:22:17 +0900
Message-ID: <20250818062217.1231-1-yuichtsu@amazon.com>
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
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

#syz test

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index d9f5942ccc44..792ddda1ad49 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -676,7 +676,7 @@ static int ax88772_init_mdio(struct usbnet *dev)
        priv->mdio->read = &asix_mdio_bus_read;
        priv->mdio->write = &asix_mdio_bus_write;
        priv->mdio->name = "Asix MDIO Bus";
-       priv->mdio->phy_mask = ~(BIT(priv->phy_addr) | BIT(AX_EMBD_PHY_ADDR));
+       priv->mdio->phy_mask = ~(BIT(priv->phy_addr & 0x1f) | BIT(AX_EMBD_PHY_ADDR));
        /* mii bus name is usb-<usb bus number>-<usb device number> */
        snprintf(priv->mdio->id, MII_BUS_ID_SIZE, "usb-%03d:%03d",
                 dev->udev->bus->busnum, dev->udev->devnum);

