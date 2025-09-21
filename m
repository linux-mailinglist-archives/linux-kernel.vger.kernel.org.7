Return-Path: <linux-kernel+bounces-826133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E089BB8D9D2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 13:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 086197A366A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 11:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C5C258EFE;
	Sun, 21 Sep 2025 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="f6Be3T/h"
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8C42048
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758453770; cv=none; b=bXZjEIXYynFd+QgOxC9SlUj3SsbcHkSyV/ULV+NnbuqTDqJVZ1ZZZO5B3WeuJe41lRMyK850AAmD7p2KKgORa1/7kb1NtmXWRAt6k7knRyQFsze0ck3AjPTZN9V9ligiav1vS4VEqjwKaFmSBfsYYUqnY8vuN/kMV5jeVOSfjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758453770; c=relaxed/simple;
	bh=C8rIKTMbs5UbY90DuDOGlvfR0sprL6LvaUmyPmL18Vo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=cHSMKpuy2uw8HDtKEES84+vYuW3FmUQDgVRSPRwQKgkNd+25vFxiMPtYpQeU2B3gBso09LosXuiFDkUrAxpBvxhHDXgLNaGtzRxzEbm9ZOv4el9HQF84bHPK+pOZt2IhdTPM6JjdjEdIKesh7al7O0C2YGdxWUGJjimaQ3bMvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=f6Be3T/h; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1758453756; bh=TyV2ofwYztUHtlPG7k1es47ro2tZQhZV1c+sRt+oFI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f6Be3T/h09YCvDRmnX0Mi0u2xHbE4/OCUA5qA+yjralrQe5a8Th9KV/csh4gI4gW3
	 VoVEiYOfBoAQi+BQzozR6NMGq9HzYi3aK73ZA6QHtuDaWQzViCuD5V3C5+Zs1R8t6C
	 /t4sImJph+8DjPaiLSIC8lB38r6kW2G39rURxHQA=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 5A218E9E; Sun, 21 Sep 2025 19:22:34 +0800
X-QQ-mid: xmsmtpt1758453754t3nws9swj
Message-ID: <tencent_F5FF2568BA75BB0C33479E6F1BAF4B4B1B08@qq.com>
X-QQ-XMAILINFO: NxNtBTDMOkftewxbk4WJ7AZ92CfGkRpCBe6AEhEfAXWzncnGi90tFDvsiM6C1i
	 r6LAW3aM8FIBwufLfrBrKFHAoZC9haPyfKCpygQj8DPiiCkv7DqF75WKZVH/b+ogzHqEk75ihyfn
	 6yl3KSMJospnoSXP5iTjZ5Rs8p+/Ct3XqlZkqJAy16bB2NhBFKmfs+yyGf/Vj+N8TotPczV3gAt+
	 9qr5a6ZVByl+BV5ZuoQE+K0W/teQuUemq1BM7vLVk3xIPjEjy6s6pPgEmPPkl7q/o5g4x+Oc30Tr
	 E3RCSHfGQoT5TPUN4FSzOXNhgco4iRv2x2tyCTTmV53fpMw4jT9Nft+/BBuPZIKFv2J9c+u9EhWY
	 spr6VQN24I4Fpj2H2nmzSz7fCDeJP0jhsUHKkCHCS4Pv16EmRSE0at5hvtbcM/6xLw4BV5smO3y0
	 p6zhpkDPtOOOyI1aiQaoN79QHDVtyWgebbnbJjM1LVCYlwkHFzpWcVEr1+Ouy0rYd5N0bsgy2wto
	 Dp7gngMNQuUCoVv/rtceMqO2yweJu2q8TPyhH3KAp1Z04BHgyYMA+etgMPitxhcyodMvbrPDCduT
	 c/DIkuItZdcE+3uNEgFh7Ed7ydJU4U8qICXG96GvRyLrkGMnv9VM8yaM2opxG9MbZJR16906svDi
	 Owbd1yNflJVmLMjf6ndSvvoCTj00vN55lOsdHK3b/X1Wdlom8uDLFtoPlKkIcwvxmyJr3b0PQx9p
	 RwG/i/MzqsHvLn4/guDboXFKSLM7BvjBThEr064VPPniWkrHfpn6SakRRx8VqqdOWimU3nbVFrKb
	 VQCL5Oe7ALCGA4vAgyTxMjjO5a6UtoFyWZ9TxtXm6CeUv1LkVD2a6XQHfX6cGLtlyasFXiyw0tCS
	 ufvDfsT0/I85ZuAaE1aVo+Q/crsJ4M0EBKVxUkIxhVR8LT9q9ptH/ShWxAG0vsIR/NvBY1yA1xUK
	 pKYgfmtWlI8NKfNW3GPw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a56aa983ce6a1bf12485@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in driver_remove_file
Date: Sun, 21 Sep 2025 19:22:29 +0800
X-OQ-MSGID: <20250921112228.2552612-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
References: <68cf794c.050a0220.13cd81.002a.GAE@google.com>
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
+		dev->driver = NULL:
 		return ret;
+	}
 
 	ret = comedi_alloc_subdevices(dev, 2);
 	if (ret)


