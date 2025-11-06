Return-Path: <linux-kernel+bounces-888747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A7FC3BCF0
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2DC1888735
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B80633FE33;
	Thu,  6 Nov 2025 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="COi4CY7i"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E1033EAEC;
	Thu,  6 Nov 2025 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762439722; cv=none; b=rj4PB8nswD7UoFuxW7VkVboMgpnSM51PYLW+RPoHBduIIQ9+DZd4zNc6gCQ/3CpGLK4Wnsrs+X7Cpk7oYBB7GoyuQjcdP6zm3KjChkPZKMaw1K1/NMF+9TOejGX3L2xmjOM62urxMgWVr8g4EcXVKvVO4J2L2U20UDd040c6wCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762439722; c=relaxed/simple;
	bh=57fdUNIOFbvLlfOS1BtY/XcfitZ1Mmlbw0An1LdVwsc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmeAooON5o6f8/odICDW4TvOdiZIy50jVlqC25dv03p40rl6d7+e5nA3378bnAd6nzpnw7DWy3kdKm2Dvd5YG0WdNWH7H0UGBTsMuYZyOhvEQAJkhnOL74I7Zm31LI2gNtlaLhdN01WtlTVlX1CmmM/y9iF+1HGcsI0QkfJ915E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=COi4CY7i; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6ANcRb832900;
	Thu, 6 Nov 2025 14:35:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=e07CdbUuMcpazLb8YhQmHovdkB5Hk9FWCovi1Xt6lxo=; b=
	COi4CY7iNZ88TwEGpvl1OYck5Abb9osB0f86G0ENPdaFddufFNOWFDScpfeEdqJs
	I3hx6jWuORtApbhN8IkgTKUPp2ZP+sCuSOz6OLwOSZRKguAresDS9KhBflroElXY
	DeYLFsUsUE18bgRLCn82cW2p8qQwF/GwX47xkf4ubUWYEzSWJHHCqYFpTdDz+MOv
	aSeATxjX3CN28jUOGS1OvhZuNZiULx5GGJUlRFAQQvA2XtGin6pePDMi+IBSY6PU
	KTJIwf/8HjnstO5rYGZltUAHmbJdktqBFJx8e8DAUPxpMoW/zxz/ALAlXa4bWbMi
	GLO41785bC57CaY1fX1Low==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a8b4csqb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 06 Nov 2025 14:35:09 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 6 Nov 2025 06:35:09 -0800
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 6 Nov 2025 06:35:06 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <tiwai@suse.de>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <perex@perex.cz>,
        <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
Date: Thu, 6 Nov 2025 22:35:06 +0800
Message-ID: <20251106143506.720545-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87v7jnfkio.wl-tiwai@suse.de>
References: <87v7jnfkio.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Qq1t3bSpdbfWqxKO3wd3QNfd3NF2t7iW
X-Proofpoint-GUID: Qq1t3bSpdbfWqxKO3wd3QNfd3NF2t7iW
X-Authority-Analysis: v=2.4 cv=M6hA6iws c=1 sm=1 tr=0 ts=690cb21e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=v4leo8fFWbreTTM7-MYA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDExNSBTYWx0ZWRfX+W8jDiDDJPzN
 ObOoa72l+ngVAUrrLIEab8d1WsSfYGTD816wxadtAX3UG0lN35J1G0sVYFDeQYrFPIcvYZzwaZ3
 z1GVH7VLNMxJuWE6u7NqEy4aG3Qxlv+LVQk4j8kY3nI2narM9Qz31RnAzacUU/wIjOSFUjeKqFs
 UMhqLZeKloo17zjzjs+UzEe7B7YvLURXSs3CbR+ihocwzxJmwqwHvsUcFwGJL+qxlCAEKXfw8xp
 YxB87vk5AJBDWsW+3YlqlZ96ZCvxkzOhZ0+yevuXICGCKJjTOxzI1QMFqEW9HVRrEAdSykKObDm
 PpbQYslrRDy1vhghCS20bfTxCBcx1OfHGKGe7a35ARr7g/I8hL45N0soVi6ooBHZ/LfklTZdB9H
 OVRU0p8JDHaxrGwivck6NblGfowpgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060115

On Thu, 06 Nov 2025 12:49:51 +0100, Takashi Iwai wrote:
> > > > The calculation rule for the actual data length written to the URB's
> > > > transfer buffer differs from that used to allocate the URB's transfer
> > > > buffer, and in this problem, the value used during allocation is smaller.
> > > >
> > > > This ultimately leads to write out-of-bounds errors when writing data to
> > > > the transfer buffer.
> > > >
> > > > To prevent out-of-bounds writes to the transfer buffer, a check between
> > > > the size of the bytes to be written and the size of the allocated bytes
> > > > should be added before performing the write operation.
> > > >
> > > > When the written bytes are too large, -EPIPE is returned instead of
> > > > -EAGAIN, because returning -EAGAIN might result in push back to ready
> > > > list again.
> > > >
> > > > Based on the context of calculating the bytes to be written here, both
> > > > copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> > > > the bytes to be written before execution.
> > > >
> > > > syzbot reported:
> > > > BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> > > >
> > > > Call Trace:
> > > >  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > >  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> > > >
> > > > Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> > > > Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > >
> > > I'm afraid that this doesn't address the root cause at all.
> > > The description above sounds plausible, but not pointing to "why".
> > >
> > > The bytes is frames * stride, so the question is why a too large
> > > frames is calculated.  I couldn't have time to check the details, but
> > > there should be rather some weird condition / parameters to trigger
> > > this, and we should check that at first.
> > During debugging, I discovered that the value of ep->packsize[0] is 22,
> > which causes the counts calculated by
> > counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
> > to be 22, resulting in a frames value of 22 * 6 = 132;
> > Meanwhile, the stride value is 2, which ultimately results in
> > bytes = frames * stride = 132 * 2 = 264;
> > @@ -1241,6 +1252,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
> > 	u->buffer_size = maxsize * u->packets;
> > 	...
> > 	u->urb->transfer_buffer =
> >                 usb_alloc_coherent(chip->dev, u->buffer_size,
> >                                    GFP_KERNEL, &u->urb->transfer_dma);
> >
> > Here, when calculating u->buffer_size = maxsize * u->packets;
> > maxsize = 9, packets = 6, which results in only 54 bytes allocated to
> > transfer_buffer;
> 
> Hm, so the problem is rather the calculation of the buffer size.
> The size sounds extremely small.  Which parameters (rates, formats,
> etc) are used for achieving this?
rates: 22050
format: 2
channels: 1
/////////////////////////////
stride: 2
packets: 6
data interval: 0
frame_bits: 16
> 
> The calculation of u->buffer_size is a bit complex, as maxsize is
> adjusted in many different ways.  Is it limited due to wMaxPacketSize
> setup?
Yes, it's because the value of ep->maxpacksize is 9 that the maxsize
value is 9.

BR,
Lizhi

