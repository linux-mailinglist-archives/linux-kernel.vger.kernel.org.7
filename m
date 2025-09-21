Return-Path: <linux-kernel+bounces-826157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E13B8DB31
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 14:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B78189D79B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 12:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4738F2749DF;
	Sun, 21 Sep 2025 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="GcUb6wGP"
Received: from r3-17.sinamail.sina.com.cn (r3-17.sinamail.sina.com.cn [202.108.3.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37A2E40B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758458366; cv=none; b=tnOA6eMeboCNpaFBN4SMbbF+WDdI3q/w1xXuerTmoMOIqzp1YqGsB9qwPGph/56tXORFmt31dzLWdYkIYgK/LBirfB/y2RTtlnVAarXgcMhKI7weSG/sCWhCq+5OiTIApBIO2qfIEFLKOy2UyCFe6zBRWynck8aeZodEqnApj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758458366; c=relaxed/simple;
	bh=eq7RDuwC0ekMoevZPp3xf6uLEcB1cMf425QzMWmDGgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tq714/kcGfTdlT/PycNUuap48vc+q0YHExzBTSBNzYyf78qQzEaMXnFvtMjPTGD4LfdJ45y8EsXZHnxAa0jVlsCPD8t6s252K6naHe/rv1uHdf0brjuo+wn9jkNVvloa6UePiUR5dm31UROBE9h33/cMY87LMqfm3S7q3VHdLKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=GcUb6wGP; arc=none smtp.client-ip=202.108.3.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1758458361;
	bh=YyeYsMvAWaXmiafs4fwmbZPiJ8D/eotR2Y5ePIRxu7w=;
	h=From:Subject:Date:Message-ID;
	b=GcUb6wGPQed7ctlBuuzR/jrJlaMC2FhvgLGFQ9PoiSyGnLSF77bEkR72Ocks9j2Ne
	 zMNntqSGB8uKQLUFqFpwfAnbbaJPDgUlrmBW5x7pNHvYalJ97lJNjptxOwzrD5QBGZ
	 AGtiXyzpyWm/xieg81ZbB/5p/ZpzbUfYhtCv9zZA=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 68CFF1CA000015FE; Sun, 21 Sep 2025 20:38:36 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3499526292056
X-SMAIL-UIID: D335D5EE4DB54E2B86337A4963FA5351-20250921-203836-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
Date: Sun, 21 Sep 2025 20:38:24 +0800
Message-ID: <20250921123825.7352-1-hdanton@sina.com>
In-Reply-To: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sat, 20 Sep 2025 21:04:28 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    3b08f56fbbb9 Merge tag 'x86-urgent-2025-09-20' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14ce5858580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
> dashboard link: https://syzkaller.appspot.com/bug?extid=a56aa983ce6a1bf12485
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15571534580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152f7e42580000

#syz test

--- x/drivers/comedi/drivers.c
+++ y/drivers/comedi/drivers.c
@@ -961,7 +961,7 @@ EXPORT_SYMBOL_GPL(comedi_legacy_detach);
 int comedi_device_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 {
 	struct comedi_driver *driv;
-	int ret;
+	int ret, detach;
 
 	lockdep_assert_held(&dev->mutex);
 	if (dev->attached)
@@ -1004,11 +1004,15 @@ int comedi_device_attach(struct comedi_d
 	dev->driver = driv;
 	dev->board_name = dev->board_ptr ? *(const char **)dev->board_ptr
 					 : dev->driver->driver_name;
+	detach = 0;
 	ret = driv->attach(dev, it);
-	if (ret >= 0)
+	if (ret >= 0) {
+		detach = 1;
 		ret = comedi_device_postconfig(dev);
+	}
 	if (ret < 0) {
-		comedi_device_detach(dev);
+		if (detach)
+			comedi_device_detach(dev);
 		module_put(driv->module);
 	}
 	/* On success, the driver module count has been incremented. */
--

