Return-Path: <linux-kernel+bounces-793267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA604B3D15F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FC417C3D2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF8245033;
	Sun, 31 Aug 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="i3tYH6cW"
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44405168BD
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756628433; cv=none; b=uMern204c+G46KHZb5cZKySVxdPNcHcDXohwHQP0YeAF25NFrIJgEiWvg38Noxm/rKR+SMQiBCx8U6G3Pek5+YuYUkdtj/lHI8bn4rX/E7MFfbHuo9EmT2t3nURRWImRrU8XksEnsS5Q4G/Dv65rbcoVzaqMBSlor/Hgm5r5O+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756628433; c=relaxed/simple;
	bh=v+ka/MBoOac/NV1cNaNzOfu6MYrHkazh4B88sWRKH+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvO0cl4GpxylwzyxeXWaAWls2oYe6yoTfpNfJtoASK4JdI79KDK8Jr1dSG7y3KpNQqsEvWaEQFmw+1VxyJ4bw6+oPpP3QJQLsOJjegShJUzS2GCxFVTLy4Xchbc9Pds5LhJmFT2Gh7Hum5D0d+9Wzn1qr/AUWCiB1wBb1axBw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=i3tYH6cW; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1756628429;
	bh=kQMYHqbv/O4f5Ayov6cmuzEMugP3k+GFB6cSptEPIP0=;
	h=From:Subject:Date:Message-ID;
	b=i3tYH6cWZkTc1+aHHfpOefVCnNbuWk1loa/EaseQVqMtEI8JNhEdqcK14xEWE9NE+
	 I2E7ZiIUU3bqUhg2EhBLEXgJfXwa4sxk7Fj+PZRrvzeVRIjzKM7kySil8mD0K1A2lV
	 K7NQDJs3w2CeRRzJcbRmXi39J257WtOD0JuDrWNM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68B4059F000009F4; Sun, 31 Aug 2025 16:19:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7032544456623
X-SMAIL-UIID: C3D4DE28560E4CB980BF1411F7191665-20250831-161944-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+535bbe83dfc3ae8d4be3@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] [nfc?] WARNING in nfc_rfkill_set_block
Date: Sun, 31 Aug 2025 16:19:32 +0800
Message-ID: <20250831081933.6215-1-hdanton@sina.com>
In-Reply-To: <68b3f389.a00a0220.1337b0.002e.GAE@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Date: Sun, 31 Aug 2025 00:02:33 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    c8bc81a52d5a Merge tag 'arm64-fixes' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1508ce34580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bd9738e00c1bbfb4
> dashboard link: https://syzkaller.appspot.com/bug?extid=535bbe83dfc3ae8d4be3
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11019a62580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1308ce34580000

Test Kim's patch.

#syz test

--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1154,6 +1154,7 @@ EXPORT_SYMBOL(nfc_register_device);
 void nfc_unregister_device(struct nfc_dev *dev)
 {
 	int rc;
+	struct rfkill *rfk = NULL;
 
 	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
 
@@ -1163,14 +1164,18 @@ void nfc_unregister_device(struct nfc_dev *dev)
 			 "was removed\n", dev_name(&dev->dev));
 
 	device_lock(&dev->dev);
+	dev->shutting_down = true;
 	if (dev->rfkill) {
-		rfkill_unregister(dev->rfkill);
-		rfkill_destroy(dev->rfkill);
+		rfk = dev->rfkill;
 		dev->rfkill = NULL;
 	}
-	dev->shutting_down = true;
 	device_unlock(&dev->dev);
 
+	if (rfk) {
+		rfkill_unregister(rfk);
+		rfkill_destroy(rfk);
+	}
+
 	if (dev->ops->check_presence) {
 		timer_delete_sync(&dev->check_pres_timer);
 		cancel_work_sync(&dev->check_pres_work);
--

