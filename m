Return-Path: <linux-kernel+bounces-888023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE3AC39990
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 09:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6728534ED3B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 08:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D409D308F25;
	Thu,  6 Nov 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="SSFUhgpk"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BCA26F29C;
	Thu,  6 Nov 2025 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762418008; cv=none; b=Z6ltu82JOzTj9nyRYJGb/2RrBg+eAolOq+v7GMX/ExdJJyV+6p7MI1SFF3LoQWOMtQ+tvtCLhKClFaMpITBqeUsTiImwueVw7v0CVl7YJcYi+cVEWizjPNbQKt1s2Hu5OCp5Y1FPV55HIy2EzKLsFs0SDsHNu+N37BwD4BwAej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762418008; c=relaxed/simple;
	bh=w59sk8vcSHzKV622h6OWGLWzimTJs7Vur6YmdxuYSzc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLXt2DYva1nfjr/6Ji+ekqocsyFda9C0R6yMqcZvjhRezXQ044jkTxYAPZZWyIpsq0x6l1mzfSL1Qm9dLYbFXf/luI3QPWR4gExAhMoouKYQYGIcPabUL+VnrbCf5JMn5ylqegKTFxABBDBjdT5sijyqBSBKb2OHA6cBm2uCzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=SSFUhgpk; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A641HDM013424;
	Thu, 6 Nov 2025 00:33:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=O487AN9Qnntu1rGtxcf6wGG9afoKi8Zn4oa0oCHUyBQ=; b=
	SSFUhgpkt6akM9PeJrwxJplk2V8Vc+bzU01qBgjcklN+xi95WRmTRlQ+OFf5uGWc
	L3gZiV+gvEUxuHsbqQRAyjhlh6x/1psWXD5m7Or3IhF1JCrBsoAK3bGYc18D4x+9
	0/h0iTxH5Ap7s2Gc/J46dn3m75N2jSwpb2ARQJ8wabTDw0eZGQDh3UgdOIZasfhD
	HwXaZhU1+C7xjgJxUKQA6VB2qP3TfT0zsryTJ542lhR0dvbm1XsjXWcwE7MLHmG6
	Tv/+dS+qSTxW0S6PP0b8riOMQyuLKzYb8s5c+7ASs7QU2iceHfoG6Wpx9m5zPL+q
	M2pN3InnXfvSTG8Lyzzrew==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a7wd7j7wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 06 Nov 2025 00:33:04 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 6 Nov 2025 00:33:03 -0800
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 6 Nov 2025 00:33:01 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <perex@perex.cz>,
        <syzkaller-bugs@googlegroups.com>, <tiwai@suse.com>
Subject: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
Date: Thu, 6 Nov 2025 16:33:00 +0800
Message-ID: <20251106083300.2947700-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <690b6b46.050a0220.3d0d33.0054.GAE@google.com>
References: <690b6b46.050a0220.3d0d33.0054.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 7VqEdDCi-EMUYwmD1IBhPhKufOly51CO
X-Authority-Analysis: v=2.4 cv=Dacaa/tW c=1 sm=1 tr=0 ts=690c5d40 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=xYGITZzX9cmXqUHkxiYA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-ORIG-GUID: 7VqEdDCi-EMUYwmD1IBhPhKufOly51CO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA2OSBTYWx0ZWRfXwfczWpc44ZQv
 xn3h25peCqXDgINhlwn0XE1bq3v7TX7pBZEF23K+td8XBOEopZKrUUndLrK9E7WlLbJ0CVBgPgs
 QlVZFQ6B9DilixuYvtIvAqDzqu80hwd3MBhARoUIwj3D0KLY6Cal1BD1e2K40kmpWAAlsiEeSx/
 +ND8PCNtvfuOW+teoG/Yk6mrxd/MTCUOfD3Xuf91swKQQytCB6sn3+/fs9dYjs1CS52WgwhIGFE
 f4ZpWl5KToW5FnBAhONxQaL9U2wi+8oUPpeBbNeP4LRpucPIxz+RE6wyfJNIE2TiX5lwxGu+rqN
 r2b4Vzz3XoAwLlc2LNpzz5+cSRs/8prT+QBUwuzJuMm5vI0E1XaTCPUkBNKV4TnjKGItGe0RnbL
 T6xUr/WjdyU5lvGHgvkWl/P0S161gw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1011 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060069

The calculation rule for the actual data length written to the URB's
transfer buffer differs from that used to allocate the URB's transfer
buffer, and in this problem, the value used during allocation is smaller.

This ultimately leads to write out-of-bounds errors when writing data to
the transfer buffer.

To prevent out-of-bounds writes to the transfer buffer, a check between
the size of the bytes to be written and the size of the allocated bytes
should be added before performing the write operation.

When the written bytes are too large, -EPIPE is returned instead of
-EAGAIN, because returning -EAGAIN might result in push back to ready
list again.

Based on the context of calculating the bytes to be written here, both
copy_to_urb() and copy_to_urb_quirk() require a check for the size of
the bytes to be written before execution.

syzbot reported:
BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461

Call Trace:
 copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
 prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611

Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
 sound/usb/pcm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 54d01dfd820f..a4c0ea685b8a 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1606,6 +1606,9 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
 				    subs->cur_audiofmt->dsd_bitrev)) {
 			fill_playback_urb_dsd_bitrev(subs, urb, bytes);
 		} else {
+			if (bytes > ctx->buffer_size)
+				return -EPIPE;
+
 			/* usual PCM */
 			if (!subs->tx_length_quirk)
 				copy_to_urb(subs, urb, 0, stride, bytes);
-- 
2.43.0


