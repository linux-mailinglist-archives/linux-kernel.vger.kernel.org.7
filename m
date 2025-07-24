Return-Path: <linux-kernel+bounces-744938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1FB112C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E351CE34F6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4CD2EE27C;
	Thu, 24 Jul 2025 21:05:22 +0000 (UTC)
Received: from plesk.hostmyservers.fr (plesk.hostmyservers.fr [45.145.164.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3783F1F541E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.164.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391122; cv=none; b=TMYeB3N4QqiXvchG/6+J7LhyIOz7+Ztxl/q6b7nTzxbCk1f04Dwc+ylVfshscx/BvuJmNujXT4Fj1a4/pNH6hOvQ/SKRV4ul8tzit48U/JDLMyeQrNIJ/FWX2Ry5x+7s0f5yoeZNArT5O3ExiP4ChTZyEqr3+KGztUJB/nBcLmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391122; c=relaxed/simple;
	bh=KqToSfIUN+x/XmDI37lRns79LvoBblyfmGXxcoh20xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmSTU73vI5zBBlzelBO8LX9VrP//tueKOWme0HST3JEAntX+4EQZGG1UEvt4IjbzqjJHlQUbvxfKwW+uIgrLWoH3JCpv/gbpucM0Sf0pE+qc9ptHlXR/lFKbhx15YOlMQd2U8curVmz0ZGdPzao3MryvxRQ66uUHcHcgitgoj6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com; spf=pass smtp.mailfrom=arnaud-lcm.com; arc=none smtp.client-ip=45.145.164.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=arnaud-lcm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arnaud-lcm.com
Received: from arnaudlcm-X570-UD.. (unknown [IPv6:2a02:8084:255b:aa00:3262:d069:d197:592c])
	by plesk.hostmyservers.fr (Postfix) with ESMTPSA id B188540434;
	Thu, 24 Jul 2025 21:05:15 +0000 (UTC)
Authentication-Results: Plesk;
	spf=pass (sender IP is 2a02:8084:255b:aa00:3262:d069:d197:592c) smtp.mailfrom=contact@arnaud-lcm.com smtp.helo=arnaudlcm-X570-UD..
Received-SPF: pass (Plesk: connection is authenticated)
From: Arnaud Lecomte <contact@arnaud-lcm.com>
To: abbotti@mev.co.uk,
	hsweeten@visionengravers.com,
	gregkh@linuxfoundation.org,
	syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Cc: contact@arnaud-lcm.com,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] comedi: zero-init data in do_insn_ioctl
Date: Thu, 24 Jul 2025 22:04:51 +0100
Message-ID: <20250724210451.108177-1-contact@arnaud-lcm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <175339111633.5018.6615576046600949931@Plesk>
X-PPP-Vhost: arnaud-lcm.com

KMSAN reported a kernel-infoleak when copying instruction data back to
userspace in do_insnlist_ioctl(). The issue occurs because allocated
memory buffers weren't properly initialized (not
zero initialized)  before being copied to
userspace, potentially leaking kernel memory.

Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
Tested-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Signed-off-by: Arnaud Lecomte <contact@arnaud-lcm.com>
---
 drivers/comedi/comedi_fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index c83fd14dd7ad..15fee829d14c 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1636,7 +1636,7 @@ static int do_insn_ioctl(struct comedi_device *dev,
 		n_data = MAX_SAMPLES;
 	}
 
-	data = kmalloc_array(n_data, sizeof(unsigned int), GFP_KERNEL);
+	data = kcalloc(n_data, sizeof(unsigned int), GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
-- 
2.43.0


