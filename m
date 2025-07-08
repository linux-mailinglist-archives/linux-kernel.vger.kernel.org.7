Return-Path: <linux-kernel+bounces-721522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E20E4AFCA55
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0768A3BA567
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B082DAFDB;
	Tue,  8 Jul 2025 12:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZorV0FYQ"
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBF635959
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977406; cv=none; b=E+KMbjD8dXRiArUbUAP7gM8904Ndy/qHWu20eSr/4oHU40Y4OzKcYWF2sFD41eQbxY8V8XhyWPrz7oE1Vd9P2ZkWPe49irG+AGatPMhsgWGbeIF9P84qcOp7JiMIBUogpLMMb/F/tNi66KoNsOrS0cP3ExAxnpl8JuZbqRnJ9JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977406; c=relaxed/simple;
	bh=Lw/kEqkouyTQ2u7yx2oenXYZjd/xE0FH+WUWYamJjnE=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=U3fLhhrIkFwJ5HyIDf8I1uVET0XvzxGufC/f87aUdPn9hNc59m+6E/+5DlS9q1fY3KST7lFiGmmXRHaQ5nplZ14GOpNQUxQfLi9IVoApsUj51270vufsWWKJHaOb1oBKJGYMzw5Wxd2SUwylutiJSNca7msyfbR/O/QQeOJLrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZorV0FYQ; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1751977096; bh=OEH3rVScovzoLL7PVa3bDVTHN3Fk4D6iQFhA9Ow+MN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZorV0FYQHrkG+cJ0wxSuRrBWHP0sPGpChmvybYoZ0shTl3TTgU9T513cWNambxYCn
	 /30Ig/5qUMsj78mIIrNpEqxxAGvKEK4qSEjSTyG2ClWVvXeBQTKaq/61GSxisnYCcI
	 0QWlEAW6FGWL/mnCeQRIoDqyDwQ7pkF6yFVE+wBQ=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.228.63])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 48E928C4; Tue, 08 Jul 2025 20:18:14 +0800
X-QQ-mid: xmsmtpt1751977094tj0wlewwl
Message-ID: <tencent_210D8125898DA092485D96DDC8991CCF9307@qq.com>
X-QQ-XMAILINFO: MB5+LsFw85Noqgm2noJI54eLa+UFXSEDKplMwdwYYzTkh2DDsiVi4N7SUGBCTk
	 QIE1zy87wXU/uYvIaj8M2wKFZOvs8igiDs2QN5NJ7flJl4e3z+tubpXois/SOufzQZ7/FKbhnAFv
	 RziLzRbQ1/dIdgkgb6Ezv97Sbalx+1Brx0sEry8wm+Y592Db2XZbl96Q6lYwiMDq8scf/ydzAbWL
	 Y0rrYCHCPcQp4Bs7lG+wMZ/0Txkc6jygmJaOexi6QCsFZNl++JVLywEyYx4WOKQ03o60CiM9ISD9
	 9+/RgBiGnOocKmD1GSucngsx4ylAWOjc0/yRftxkoMkLkDP6SCfafm6HHajycFr3o5qx20/yzqgk
	 C0YK1IbQ9hilrgJ2zBby5KuHJFOp2w+i+XkKW5GQIytwSIa/PMhCXD8gjcxs5u5VTAvZeRqGVIdO
	 +x7e0d12SKfQR0qTUK1iIRycq83i35VQEZPnuaA97yLiURKlnZ9UAmN5F0rdT+j981W95EWcNPKG
	 ZZc6G1EpLqGzRqeADHHHhBQmwUaeLxS5LpjmZgjUKboiWBfU0NrVoQISA7JQTaG0ZPt+RARsYehg
	 ACQg1bumE++D3G+ZMSPGNTkuAljtlVNam26HdvMSAXUiCZs2rkaeyHvnzxQJh5Ub4pdwMTWdM2jY
	 9Q/OaoWaCrFDL/va4TC6wb4w6dNZ6do/dBsDZBhI1iZjS9G+abAkQ5lPwJKY5NtkNslxH/ddFLeJ
	 5j07hqkH1/4HuuZKbUQhd1H8B+DVLoJf5V/B+IzPFePQKuw0MO0myc9VrBaxq6Eeb62umtIzPHmT
	 m0+UIwRKLX+HOQ+PeovrzOw88mncl+xhav32tNQvbE5n20vwHmfYebgGZOMwJk6BwGq8UGtVvFN1
	 m1zLCatOgaKqck+vU1KKHJ9+baGeeXBDCKj9BwpnLlVLRudQMqTOxG8lW1Wt0KKLAKjTf+N81n
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f1bb7e4ea47ea12b535c@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] UBSAN: shift-out-of-bounds in aio_iiro_16_attach
Date: Tue,  8 Jul 2025 20:17:50 +0800
X-OQ-MSGID: <20250708121749.235188-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
References: <686bf6a0.a00a0220.b087d.01f2.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/comedi/drivers/aio_iiro_16.c b/drivers/comedi/drivers/aio_iiro_16.c
index b00fab0b89d4..e43730f00c8b 100644
--- a/drivers/comedi/drivers/aio_iiro_16.c
+++ b/drivers/comedi/drivers/aio_iiro_16.c
@@ -177,7 +177,8 @@ static int aio_iiro_16_attach(struct comedi_device *dev,
 	 * Digital input change of state interrupts are optionally supported
 	 * using IRQ 2-7, 10-12, 14, or 15.
 	 */
-	if ((1 << it->options[1]) & 0xdcfc) {
+	if (it->options[1] > 1 && it->options[1] < 16 &&
+	    (1 << it->options[1]) & 0xdcfc) {
 		ret = request_irq(it->options[1], aio_iiro_16_cos, 0,
 				  dev->board_name, dev);
 		if (ret == 0)


