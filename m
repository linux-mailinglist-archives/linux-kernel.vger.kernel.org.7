Return-Path: <linux-kernel+bounces-830037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F9BB9888B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105241B20BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 07:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3A274FE8;
	Wed, 24 Sep 2025 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PwqkYmX/"
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B5157480
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758698876; cv=none; b=hYwMOAarDVw+GvZ4h5+EjzoxE1/ByXM9M0gsqzqiPZ4oQVl+Mn12Zym6WfTxEPAmO73pTFhOqE2RohiNuCHCtsAInrdFDfwQIlVav7OxmrCcQXBbWLUgB9orFOoBKGXa9VyM3OVjll2NoqBjub82LgABUu6WGUbm6qstUC6Bd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758698876; c=relaxed/simple;
	bh=jtlr3CzskCMgRQIyf5Z/jOncrmxpl1QpXBVZm1auUpU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QOyc5ME/7dldBZ9p9KWdH6lqKEtIj+VzbRC/MrpZkIG2m6/2HIBrmo0O34fkBG8GvywMplMXIPJFCG0qled79g8TPqYzRD6hDXXYZausRfAL8es/pzXUTO2of2NvQ9ORWtl7vDfwaovN+yNSjnh/VvXOMJbxYhFhO/d6xVhwki8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PwqkYmX/; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758698569; bh=syTZ2ErbqcBrv/fo3/fTPOQN1vuhv6P6yicAX6Yb/CA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PwqkYmX/ArGGjbtbqHT2Ffbo1UG2x06eiDTXfi7JACywcIm416Qn8CLebOrB+Le5e
	 jXNH6tCvgtjXh7EsZox9RD4Gau0OjxLHm3c0QdnzTeJfs6Y3AWHpVkYwKCGMiECG84
	 zicBMQrjQg8dspTy8MynCou4y75RMsMcQFKk7ZcI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 5AF22472; Wed, 24 Sep 2025 15:22:47 +0800
X-QQ-mid: xmsmtpt1758698567tep0uzhrr
Message-ID: <tencent_D75AB77C177126CBB3776374097223A1E405@qq.com>
X-QQ-XMAILINFO: Mg/0DM1Zd+nHcJco+VMJ2EJWDLo8lkMgNOOWeMylWKC1WJOyAGeV4+jfySd8uG
	 fFr1+br6hmcI8gAMST2E2AgD/BVxBN+3eU+HAkWAxbqo2texvF8ps5A23TXV0NLhmu5HudEYg8pc
	 zTrJnP4ulC2z4hOzjJjEkw7XRuOc5ecYg+dejkURv3bCntuNIl7BxofgSD1VCPA8czIHk3Pgu3Ic
	 Moqg5/xfF01WJMHUW5yJc6YqLUv+swYCZmDrt8Vj3BaXzbdMSD9Bd265aHwszqVVk9lrzWUFBozW
	 AS59+xTAE4Ou9urlNc2D6dFqY6ntca3P0zAtBPosWSgncVea3N9QwpnF4jQf7ij1iyj3jsxUddpe
	 2HnHjjMvN6bto8NuCEsmxt1lI+owILfLYshHrDJmZQ9+qCPFFwwNMBi9e0WTvz9lqyoe1p+fWrrK
	 UWaZTMlde6EEvd0KhRzCZfY+S/8yVz7swJgHgMD2lcCWCvvz1VtUrC45MTBFt0O/PFH1iaCaHP0S
	 n9Dxp09MBXFxRagjzkDZYsHPVpl/2knnXeHxkTFUTrTlmSWivviTFjE3jO7wD2ni6cbRbw6ADAoo
	 duiYWrtqCg9vfnNgwlWmqqGD9BjI+Vdkl4/GaXBqbmvdORL9lO9O4L6lnoBBbBwuBGtduD1rWLV0
	 3YxiMONCZ6l9wL4f7/aTuUujcQzJKtXNgQipvjv9RcgXwaShZfaxEByUMFJKTb6xekXRXZKEyD4Q
	 fn03+oezBShNVzG92blV9vTEzriPbkWWLffDDwturLl5UV58f1hB9A0g3Ub/4NMAp3T34+YQWMVE
	 Pa61h3ak4amMP8Wzqz9j5nyHeNX7mhfdbh/9VeO0lo9ChJQHLS3ckOkMe72f1wLIX/msdxaIPfJs
	 lV0uXEiVVK/nb3c21TompMcGAmG5XLURMTF1qY1klMU7vBqtpHBQqNmGjKD2IBip5yfj7Ikn2zMJ
	 RzJy5bPsnXkKMa8ZcnVElqxj/6I3Ex
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f6a9069da61d382bf085@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
Date: Wed, 24 Sep 2025 15:22:46 +0800
X-OQ-MSGID: <20250924072245.1321194-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68d39041.a70a0220.1b52b.02c0.GAE@google.com>
References: <68d39041.a70a0220.1b52b.02c0.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/drivers/comedi/drivers/c6xdigio.c b/drivers/comedi/drivers/c6xdigio.c
index 14b90d1c64dc..023c72e589a7 100644
--- a/drivers/comedi/drivers/c6xdigio.c
+++ b/drivers/comedi/drivers/c6xdigio.c
@@ -242,8 +242,10 @@ static int c6xdigio_attach(struct comedi_device *dev,
 	int ret;
 
 	ret = comedi_request_region(dev, it->options[0], 0x03);
-	if (ret)
+	if (ret) {
+		dev->driver = NULL;
 		return ret;
+	}
 
 	ret = comedi_alloc_subdevices(dev, 2);
 	if (ret)


