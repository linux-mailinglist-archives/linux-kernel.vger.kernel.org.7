Return-Path: <linux-kernel+bounces-889619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62AC3E0E5
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDBA188639A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BFF2EAD09;
	Fri,  7 Nov 2025 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="cOwvxIaF"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFD2765C4;
	Fri,  7 Nov 2025 00:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476889; cv=none; b=cfbwKQeH3NhUDp0b7f/Nvv61LW6q2ZX9qggYh3aGH8cml8e8foloo+AeufikxE3bskXrU+7VIst5HJjpuhKwyFUMutPIH5Dddd8Ac4TtpS+hJc2DOL5VydEVZKVyJ0/lW/xSgvLGVXn+SA5h0T2zo4LrnVSBn1QNsETjQcTW0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476889; c=relaxed/simple;
	bh=AalEmbiH+w8UnS5jXrzbNpRUW084oOmylpSbo8qID4o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oMXC26EMqiPkt/PiRRZnR+LvmPIu/1hNXNiA8E0LhiPNhzRbq5dermuGmq1JYOw/Zd2LDF7HWf7tfAroZ6lnt2SyEQZjMkGCtKbsoF3EqR7JmVNmoupQWURxyV5Yro5jG564CcV+w66uxPIQui/bTunIj/7xOZSBUC+WNE3r+wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=cOwvxIaF; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A6Lg71e2475800;
	Fri, 7 Nov 2025 00:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YsL2DerlqsXU5xZbFOu83W1kPeiEkYggTA+Rau7FWFg=; b=
	cOwvxIaFmUhjVglFQ/rd548c3NYoZ7XkkdyUhnr9IcdRX7bn2YZpn42AgGOxY5wA
	hkkS9qC5Kf5CZI049okLenb4L6+p0TDTWT5MN2p/h0Jy+ZagSoxGadIdMMINMW4V
	MG6qX7LaAaEzIxmG+JrCxxHtefpOKT5WLmMsL2HI6qETinnGA3z/XpfJrkC1oGl+
	jpKiKAspENxrljQbN6FMdKnY2SlJwqXOWiELNtb6MY6bcbjIduBsSd1BnuJDnNXJ
	vIoydvWK5Wen1CCjKHaM9P5NNC58ECNQ5Gn5t1wAunU0dbqBdMJCR4Pm0okMzm/m
	BOg9yf2HecjdP+7FWPoz9g==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a8b4ctpkn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 07 Nov 2025 00:54:24 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 6 Nov 2025 16:54:23 -0800
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 6 Nov 2025 16:54:20 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <tiwai@suse.de>
CC: <hdanton@sina.com>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <lizhi.xu@windriver.com>, <perex@perex.cz>,
        <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
Date: Fri, 7 Nov 2025 08:54:20 +0800
Message-ID: <20251107005420.3537826-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87h5v7ru58.wl-tiwai@suse.de>
References: <87h5v7ru58.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: b8x5A2osoIiJk9QcW-QDuFFqHZktWgxn
X-Proofpoint-GUID: b8x5A2osoIiJk9QcW-QDuFFqHZktWgxn
X-Authority-Analysis: v=2.4 cv=M6hA6iws c=1 sm=1 tr=0 ts=690d4340 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=3AuMGte_ST6wI1pK_wcA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDAwNCBTYWx0ZWRfX57eM7/Y1iQd2
 GceM4+7U0ngtiPNdLjFD2iq9Wikjgd6Q6DaR+9+MeC9t2aADuYuHC4gR7yAjK5g1I7uk8KTvdP0
 wxLC9fXt+hSwotFOdvNltfo2BanqrWWxlHYLaPuIW5ZWsRC+Y7M5QYZaBzLb6p/zSB5KcjWnjst
 fP3OffavyVuc6ewGVfOoW49qfBTEOawnmjb3OQMhH2gtplQn1u6JLqMmcKJvjoUxP6grTl1/ZSO
 X2s+h2VwwK7S8g11CHSFqZJgxs/ZkNEqAVeO8pNO8hPOtepy6rMpJhGCmp4gljiUPRSignxt5KL
 bOQB3JUcxe39L4WNFBJIjYpQnYZI4aDR0EAckYC3e2vbG4oVSZ3LBbJraVNYIm8debx4JFtUzlF
 4woVLOAWT/Vsem1i2r/3jUP+cHT46w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_05,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511070004

On Thu, 06 Nov 2025 17:41:07 +0100, Takashi Iwai wrote:
> > > > > > The calculation rule for the actual data length written to the URB's
> > > > > > transfer buffer differs from that used to allocate the URB's transfer
> > > > > > buffer, and in this problem, the value used during allocation is smaller.
> > > > > >
> > > > > > This ultimately leads to write out-of-bounds errors when writing data to
> > > > > > the transfer buffer.
> > > > > >
> > > > > > To prevent out-of-bounds writes to the transfer buffer, a check between
> > > > > > the size of the bytes to be written and the size of the allocated bytes
> > > > > > should be added before performing the write operation.
> > > > > >
> > > > > > When the written bytes are too large, -EPIPE is returned instead of
> > > > > > -EAGAIN, because returning -EAGAIN might result in push back to ready
> > > > > > list again.
> > > > > >
> > > > > > Based on the context of calculating the bytes to be written here, both
> > > > > > copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> > > > > > the bytes to be written before execution.
> > > > > >
> > > > > > syzbot reported:
> > > > > > BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > > > Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> > > > > >
> > > > > > Call Trace:
> > > > > >  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > > > > >  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> > > > > >
> > > > > > Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > > Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> > > > > > Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > > > > > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> > > > >
> > > > > I'm afraid that this doesn't address the root cause at all.
> > > > > The description above sounds plausible, but not pointing to "why".
> > > > >
> > > > > The bytes is frames * stride, so the question is why a too large
> > > > > frames is calculated.  I couldn't have time to check the details, but
> > > > > there should be rather some weird condition / parameters to trigger
> > > > > this, and we should check that at first.
> > > > During debugging, I discovered that the value of ep->packsize[0] is 22,
> > > > which causes the counts calculated by
> > > > counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
> > > > to be 22, resulting in a frames value of 22 * 6 = 132;
> > > > Meanwhile, the stride value is 2, which ultimately results in
> > > > bytes = frames * stride = 132 * 2 = 264;
> > > > @@ -1241,6 +1252,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
> > > > 	u->buffer_size = maxsize * u->packets;
> > > > 	...
> > > > 	u->urb->transfer_buffer =
> > > >                 usb_alloc_coherent(chip->dev, u->buffer_size,
> > > >                                    GFP_KERNEL, &u->urb->transfer_dma);
> > > >
> > > > Here, when calculating u->buffer_size = maxsize * u->packets;
> > > > maxsize = 9, packets = 6, which results in only 54 bytes allocated to
> > > > transfer_buffer;
> > >
> > > Hm, so the problem is rather the calculation of the buffer size.
> > > The size sounds extremely small.  Which parameters (rates, formats,
> > > etc) are used for achieving this?
> > rates: 22050
> > format: 2
> > channels: 1
> > /////////////////////////////
> > stride: 2
> > packets: 6
> > data interval: 0
> > frame_bits: 16
> > >
> > > The calculation of u->buffer_size is a bit complex, as maxsize is
> > > adjusted in many different ways.  Is it limited due to wMaxPacketSize
> > > setup?
> > Yes, it's because the value of ep->maxpacksize is 9 that the maxsize
> > value is 9.
> 
> OK, then a fix like below would work?
> 
> 
> thanks,
> 
> Takashi
> 
> --- a/sound/usb/endpoint.c
> +++ b/sound/usb/endpoint.c
> @@ -1362,6 +1362,11 @@ int snd_usb_endpoint_set_params(struct snd_usb_audio *chip,
>  	ep->sample_rem = ep->cur_rate % ep->pps;
>  	ep->packsize[0] = ep->cur_rate / ep->pps;
>  	ep->packsize[1] = (ep->cur_rate + (ep->pps - 1)) / ep->pps;
> +	if (ep->packsize[1] > ep->maxpacksize) {
> +		usb_audio_dbg(chip, "Too small maxpacksize %u for rate %u / pps %u\n",
> +			      ep->maxpacksize, ep->cur_rate, ep->pps);
> +		return -EINVAL;
> +	}
> 
>  	/* calculate the frequency in 16.16 format */
>  	ep->freqm = ep->freqn;
Of course, this fix was added after packsize[0] was assigned a value,
and Hillf Danton has already tested it.

However, to be more precise, although both packsize[1] and packsize[0]
exceed maxpacksize, this example is about packsize[0], so judging packsize[0]
is more rigorous.

BR,
Lizhi

