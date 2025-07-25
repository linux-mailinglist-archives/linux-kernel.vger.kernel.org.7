Return-Path: <linux-kernel+bounces-745868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676BBB11FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AD443AA4B9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603AD1FC0E2;
	Fri, 25 Jul 2025 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="s17j6S4M"
Received: from smtp88.iad3a.emailsrvr.com (smtp88.iad3a.emailsrvr.com [173.203.187.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21C1DFE09
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.203.187.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452705; cv=none; b=O7aPMBPrUSxeXSFFj4rgA0tpCLgDXAaHT9wh0pUayMtaiERgPktZFtwArYxFcL20dbn/zCwIROYdPhiFgC0az5weIBPfYZGKaScnCWt5A1gg4wH8IkRiiNDEQQIavcHFLCWQBbrXvBTgpwBwT+BWJeYy0Vqy7Via24ucncYqYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452705; c=relaxed/simple;
	bh=lkIWUunyv3x/dZPZ/tcijNWfCqbJR26FnC55X/GlDi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXTta+gRf4XqVISiodfOck0BmkT5nWZ57aoLrEOp397wYnAC6kZ6dGo9iyiogp00fjRWsGD6dbf5uLx4RHLFfs6EMKNSDCM6GZ57Ik+OmcAcb3caxF08ITex/iSLl1+gCKD5f5zJiXywZ3FAzhHffcK4CW/u5Np6ecmoJubekvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=s17j6S4M; arc=none smtp.client-ip=173.203.187.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Received: from smtp78.iad3a.emailsrvr.com (relay.iad3a.rsapps.net [172.27.255.110])
	by smtp28.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTPS id 6DD0138A7
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 08:53:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1753448016;
	bh=lkIWUunyv3x/dZPZ/tcijNWfCqbJR26FnC55X/GlDi0=;
	h=From:To:Subject:Date:From;
	b=s17j6S4M9YteohsTH9vchjxZvjniukgjiZJDiYMI+9hq/NXmD+bvwuHtDi/m2T8eO
	 WFGGEgFOehxkzf3Zo55Sfas+EItgahBGKNqiVFxwhhXLn8lu9zGZV5bUItNRYSKwJv
	 BFrye3Z0ykFpzj0FpOO+eHw+Y2VWTw/36or1aNcI=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp26.relay.iad3a.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3CF454276;
	Fri, 25 Jul 2025 08:53:35 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com,
	syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCH] comedi: Fix use of uninitialized memory in do_insn_ioctl() and do_insnlist_ioctl()
Date: Fri, 25 Jul 2025 13:53:24 +0100
Message-ID: <20250725125324.80276-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 52ef133e-236b-42a9-97f2-65e8f65113a2-1-2

syzbot reports a KMSAN kernel-infoleak in `do_insn_ioctl()`.  A kernel
buffer is allocated to hold `insn->n` samples (each of which is an
`unsigned int`).  For some instruction types, `insn->n` samples are
copied back to user-space, unless an error code is being returned.  The
problem is that not all the instruction handlers that need to return
data to userspace fill in the whole `insn->n` samples, so that there is
an information leak.  There is a similar syzbot report for
`do_insnlist_ioctl()`, although it does not have a reproducer for it at
the time of writing.

One culprit is `insn_rw_emulate_bits()` which is used as the handler for
`INSN_READ` or `INSN_WRITE` instructions for subdevices that do not have
a specific handler for that instruction, but do have an `INSN_BITS`
handler.  For `INSN_READ` it only fills in at most 1 sample, so if
`insn->n` is greater than 1, the remaining `insn->n - 1` samples copied
to userspace will be uninitialized kernel data.

Another culprit is `vm80xx_ai_insn_read()` in the "vm80xx" driver.  It
never returns an error, even if it fails to fill the buffer.

Fix it in `do_insn_ioctl()` and `do_insnlist_ioctl()` by making sure
that uninitialized parts of the allocated buffer are zeroed before
handling each instruction.

Thanks to Arnaud Lecomte for their fix to `do_insn_ioctl()`.  That fix
replaced the call to `kmalloc_array()` with `kcalloc()`, but it is not
always necessary to clear the whole buffer.

Fixes: ed9eccbe8970 ("Staging: add comedi core")
Reported-by: syzbot+a5e45f768aab5892da5d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a5e45f768aab5892da5d
Reported-by: syzbot+fb4362a104d45ab09cf9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fb4362a104d45ab09cf9
Cc: <stable@vger.kernel.org> #5.13+
Cc: Arnaud Lecomte <contact@arnaud-lcm.com>
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Cherry picks to fix this for 5.4.y and 5.10.y not yet available.
---
 drivers/comedi/comedi_fops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 23b7178522ae..7e2f2b1a1c36 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -1587,6 +1587,9 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 				memset(&data[n], 0, (MIN_SAMPLES - n) *
 						    sizeof(unsigned int));
 			}
+		} else {
+			memset(data, 0, max_t(unsigned int, n, MIN_SAMPLES) *
+					sizeof(unsigned int));
 		}
 		ret = parse_insn(dev, insns + i, data, file);
 		if (ret < 0)
@@ -1670,6 +1673,8 @@ static int do_insn_ioctl(struct comedi_device *dev,
 			memset(&data[insn->n], 0,
 			       (MIN_SAMPLES - insn->n) * sizeof(unsigned int));
 		}
+	} else {
+		memset(data, 0, n_data * sizeof(unsigned int));
 	}
 	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)
-- 
2.47.2


