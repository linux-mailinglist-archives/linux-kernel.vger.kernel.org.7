Return-Path: <linux-kernel+bounces-720720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE21DAFBFAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09321AA3841
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 01:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E525383;
	Tue,  8 Jul 2025 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="FM/sP0YU"
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03211CEAC2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937129; cv=none; b=BVhIq2FCuV1vFev5onEkEomdp25dVZbvVVS75d2P5QTKlOdrkC7jn8iUvogM8zH5CMML+huFFcBsdYqbEO8kudgL9p4RS3Ocy9tmf2DsqxfYFOY2PfUn04qVAlI8ICAZraqVPsFDAJVqQ2MsdVDLcP5poJbpzXKwn3lLmHgIVgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937129; c=relaxed/simple;
	bh=LxX0jf8sh8Yz/E6kIHKZeW2E/bEnRuwGJwzuq5FgUWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cm55D54Q4IRLlcUcv+Zd012JyjsxvOiaw1ouCxmtm/+EtSeSOh6BRZ/CTziEOD1WKLMh3zlMEc0RPI9xlgy5xcyj5JnJn+Y6G0kCNLuhOb6cf4hzlaLhD+JMZSZp8swD7sMp/35KhHC6tMDwTUFzn6sMTWp7Ll2nC48CnVHNC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=FM/sP0YU; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1751937125;
	bh=CIS4JY81OPJ4Pb7RMZw4G/MWhkUGLgSljkUbe1geWkc=;
	h=From:Subject:Date:Message-ID;
	b=FM/sP0YUixIvsAz47ydebWz/eRXqkf1qL6KNg1n9g+cCDfJ9D9WS9jbrbOjgI9QhS
	 LNN0/sGis7dJILIJXZ5ItPRCj4z2lTUWE3HVE0dO17DLxMS87S48OlBke82YAB8S3f
	 VTR6eosIKBes6lwM2JYfC8zErbGpJHlISQlUdMVs=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.34) with ESMTP
	id 686C705A000018C6; Tue, 8 Jul 2025 09:11:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 8780886292077
X-SMAIL-UIID: 4395FDE9C53A4B20B460B269595D449A-20250708-091155-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+eec47f88bae8951c6afd@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in waveform_detach
Date: Tue,  8 Jul 2025 09:11:43 +0800
Message-ID: <20250708011144.2840-1-hdanton@sina.com>
In-Reply-To: <686bf660.a70a0220.29fe6c.0b10.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Mon, 07 Jul 2025 09:31:28 -0700
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    4c06e63b9203 Merge tag 'for-6.16-rc4-tag' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16528f70580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
> dashboard link: https://syzkaller.appspot.com/bug?extid=eec47f88bae8951c6afd
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a66c8c580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11528f70580000

#syz test

--- x/drivers/comedi/drivers.c
+++ y/drivers/comedi/drivers.c
@@ -994,10 +994,13 @@ int comedi_device_attach(struct comedi_d
 	dev->board_name = dev->board_ptr ? *(const char **)dev->board_ptr
 					 : dev->driver->driver_name;
 	ret = driv->attach(dev, it);
-	if (ret >= 0)
+	if (ret >= 0) {
 		ret = comedi_device_postconfig(dev);
-	if (ret < 0) {
-		comedi_device_detach(dev);
+		if (ret < 0) {
+			comedi_device_detach(dev);
+			module_put(driv->module);
+		}
+	} else {
 		module_put(driv->module);
 	}
 	/* On success, the driver module count has been incremented. */
--

