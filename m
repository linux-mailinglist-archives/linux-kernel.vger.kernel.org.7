Return-Path: <linux-kernel+bounces-889630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1A2C3E1A0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 88B544E3CE1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FD62F12CD;
	Fri,  7 Nov 2025 01:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="BWYVaoqX"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94620C038;
	Fri,  7 Nov 2025 01:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762478027; cv=none; b=QbsMnRPIiD91yupmRgeMXItuEUKzkhaSohrszFxd/oHirO1p9Ytlun6ZLCL9O8n/LsG4cpz60NnCYKfUwmzANs8YETnWZ7QWYCt3H3n0+9NI25cAUii3yla2H4NKKnLLHAKhx7TQh59sbNZmJn/wtHMtfbfTkHfJVtsOQ3Ge0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762478027; c=relaxed/simple;
	bh=LVcwvitxXT+GO9q9AlAfehfHp+F8o+JtYzguFsyrkRM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ULF8Wtk0EsIxyJgwY59d8m2ekzn/3QsuYDxKIqrVE4gBtr7gNcjsYSgyv5QmHs1eCrR2/yTHVtQ6H6QisQ9rJukmqBd5bFNZml8wh4XNABwlja3V+xkoivHz1sBQ6qDPoXzj1CL6En+3vSZa+5Sg4wKkFzX+q81kFW1DlsDssOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=BWYVaoqX; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A70dUod3833776;
	Fri, 7 Nov 2025 01:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/80x9LTFL93+e5d0gCu0vIGNXzUwvtYtIIT2p+ZzPKE=; b=
	BWYVaoqXpZ5Yc8eOB+wpoaVZMMOmsT0n9w/zZtdgY5FE/LHspqI5rOP9kCj4lpqm
	yvt5ZSaGmejplfmeMIHru5cChKQ6vQzdAcLG7zHg9aYOSpB5gOW49OmIACjgjIdq
	XVMTcDD5mRombj4RrVmYgp3Nm0zYanmm3JgwTvgIFQe56wvdj9vdf/Mbl9/0wu1B
	bJIfo/YkT8EkMVkmh9eJ75BC8NeJFl7YtGamp90W4FesHFZES1uRT8g8h50f6cTn
	IQ5BTM4g7xUMGz/LwoLULRk3h0TV4NIAT4r1eH4SIKCiSgZWTamHMs+FMe7vxlTM
	D4akeIjnU683OakGrQ2HdQ==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a89w7aw74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 07 Nov 2025 01:13:31 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 6 Nov 2025 17:13:30 -0800
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 6 Nov 2025 17:13:28 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <lizhi.xu@windriver.com>
CC: <tiwai@suse.de>, <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <perex@perex.cz>,
        <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
Date: Fri, 7 Nov 2025 09:13:27 +0800
Message-ID: <20251107011327.3634361-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107005420.3537826-1-lizhi.xu@windriver.com>
References: <20251107005420.3537826-1-lizhi.xu@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZR4DEk70KcDxg6sLse0TDYCOVkTEzCvs
X-Authority-Analysis: v=2.4 cv=FYo6BZ+6 c=1 sm=1 tr=0 ts=690d47bb cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=1YUZrdWEI19fyJzY1ckA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: ZR4DEk70KcDxg6sLse0TDYCOVkTEzCvs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAwNyBTYWx0ZWRfXwg3ia0vXPajz
 O+pxeVWtW3azM6q2cF/rN3rlnQalc+wmUp0xDAfmy6Bh8rsbCPlDskyKzdrzSNSZVTtHdU292ol
 zwaTBwWmXO/HK1zBeCwTc1ZS4An/uyIDn2eZp5GHgb3jYzcJlaih+pPP26ashSht+QwyOjPWMfu
 jXO2I6A9g4XJI4hyDTB/cr6pCXCI0yuTPEtV6kvMZ5mqQwEORBcuzUCV3PYc1Mu+pF9mjxqZyXa
 41+xIfb4jxdUDU7bBuz/hcqQkjis8XFJVYmjJAFf+bPtGaSjcMIs8c2e3oV4543RNWRrCbZIjNA
 T5HSvJiJkfbcPy9Sp+awZ/9n7iO6tyk+j6BGKLVnv36EZ11mZWuWxoI5cLwISbeKMqc5ZWNmeMA
 gcnMt9+rSIhpbikmLgHMCKoTZ7Z80Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511070007

On Fri, 7 Nov 2025 08:54:20 +0800, Lizhi Xu wrote:
> > > > > > > The calculation rule for the actual data length written to the URB's
> > > > > > > transfer buffer differs from that used to allocate the URB's transfer
> > > > > > > buffer, and in this problem, the value used during allocation is smaller.
> > > > > > >
> > > > > > > This ultimately leads to write out-of-bounds errors when writing data to
> > > > > > > the transfer buffer.
> > > > > > >
> > > > > > > To prevent out-of-bounds writes to the transfer buffer, a check between
> > > > > > > the size of the bytes to be written and the size of the allocated bytes
> > > > > > > should be added before performing the write operation.
> > > > > > >
> > > > > > > When the written bytes are too large, -EPIPE is returned instead of
> > > > > > > -EAGAIN, because returning -EAGAIN might result in push back to ready
> > > > > > > list again.
> > > > > > >
> > > > > > > Based on the context of calculating the bytes to be written here, both
> > > > > > > copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> > > > > > > the bytes to be written before execution.
> > > > > > >
> > > > > > > syzbot reported:
> > > > > > > BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > > > > Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> > > > > > >
> > > > > > > Call Trace:
> > > > > > >  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > > > >  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> > > > > > >
> > > > > > > Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > > > Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> > > > > > > Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > > > >
> > > > > > I'm afraid that this doesn't address the root cause at all.
> > > > > > The description above sounds plausible, but not pointing to "why".
> > > > > >
> > > > > > The bytes is frames * stride, so the question is why a too large
> > > > > > frames is calculated.  I couldn't have time to check the details, but
> > > > > > there should be rather some weird condition / parameters to trigger
> > > > > > this, and we should check that at first.
> > > > > During debugging, I discovered that the value of ep->packsize[0] is 22,
> > > > > which causes the counts calculated by
> > > > > counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
> > > > > to be 22, resulting in a frames value of 22 * 6 = 132;
> > > > > Meanwhile, the stride value is 2, which ultimately results in
> > > > > bytes = frames * stride = 132 * 2 = 264;
> > > > > @@ -1241,6 +1252,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
> > > > > 	u->buffer_size = maxsize * u->packets;
> > > > > 	...
> > > > > 	u->urb->transfer_buffer =
> > > > >                 usb_alloc_coherent(chip->dev, u->buffer_size,
> > > > >                                    GFP_KERNEL, &u->urb->transfer_dma);
> > > > >
> > > > > Here, when calculating u->buffer_size = maxsize * u->packets;
> > > > > maxsize = 9, packets = 6, which results in only 54 bytes allocated to
> > > > > transfer_buffer;
> > > >
> > > > Hm, so the problem is rather the calculation of the buffer size.
> > > > The size sounds extremely small.  Which parameters (rates, formats,
> > > > etc) are used for achieving this?
> > > rates: 22050
> > > format: 2
> > > channels: 1
> > > /////////////////////////////
> > > stride: 2
> > > packets: 6
> > > data interval: 0
> > > frame_bits: 16
> > > >
> > > > The calculation of u->buffer_size is a bit complex, as maxsize is
> > > > adjusted in many different ways.  Is it limited due to wMaxPacketSize
> > > > setup?
> > > Yes, it's because the value of ep->maxpacksize is 9 that the maxsize
> > > value is 9.
> > 
> > OK, then a fix like below would work?
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > --- a/sound/usb/endpoint.c
> > +++ b/sound/usb/endpoint.c
> > @@ -1362,6 +1362,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
> >  	ep->sample_rem = ep->cur_rate % ep->pps;
> >  	ep->packsize[0] = ep->cur_rate / ep->pps;
> >  	ep->packsize[1] = (ep->cur_rate + (ep->pps - 1)) / ep->pps;
> > +	if (ep->packsize[1] > ep->maxpacksize) {
> > +		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
> > +			      ep->maxpacksize, ep->cur_rate, ep->pps);
> > +		return -EINVAL;
> > +	}
> > 
> >  	/* calculate the frequency in 16.16 format */
> >  	ep->freqm = ep->freqn;
> Of course, this fix was added after packsize[0] was assigned a value,
> and Hillf Danton has already tested it.
> 
> However, to be more precise, although both packsize[1] and packsize[0]
> exceed maxpacksize, this example is about packsize[0], so judging packsize[0]
> is more rigorous.
Of course, since packsize[1] is always greater than packsize[0] when pps
is greater than 1, judging only packsize[1] is sufficient to avoid judging
packsize[0] and packsize[1].

BR,
Lizhi

