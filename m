Return-Path: <linux-kernel+bounces-888357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC378C3AA03
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 12:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC69461542
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82130C621;
	Thu,  6 Nov 2025 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XIqgUr3K"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F5D2F1FDF;
	Thu,  6 Nov 2025 11:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762428706; cv=none; b=oCmovochkoJHIgb2JpqNpsXA9W4i+ZjYTvYhaUQ47ZijOa288ixhokmdB+STOw5w7II/nOHu/Sxsbatp0oifoH01+2KeMOg7lndqS9MTr5brhp8JvrS4BgdZ6CQ7p9S5xNetBLGUdTIzvcP5EZowmjSNHnddGPEvC3pR/G+UHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762428706; c=relaxed/simple;
	bh=CZ/GjPUL85jve3oW6xzsZVvy/wUmf3rKiIhHb6qVyJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XE1FZnqEjfxjr+VhuGt9z9PU35S9SuoJAc7JQ41p2QNHzdGcrCMFEA8eMaszI77E63nnZcz6rrGJTTznWdPh8KoA8Ei2bj2nT4Db8Cr/E+2FtbR+6qK7nLiU7WH2QuybgOlsjAy+O/wxoX3OVhciVpGUpXV1zSUcwouvWOmINYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XIqgUr3K; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A64ZZu71301352;
	Thu, 6 Nov 2025 11:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=xRwlyiz1dgU2jKWlSXdairnh/5htGEn+FbQbAHGcALk=; b=
	XIqgUr3K6Tc/biuKFJajseSPx7PHHzgHBKbhdkl4m696wsrg+Xx0iNKSQn0NOGZb
	P67n9JpG2tw3RBNgHwyubeVjCKIvaH6X/B0FFjSqRLyM8IKZBEfZK/YqIxrImwB4
	G3b9wcGxEHtKEXcKIYDdhaFh2hK+cNMjRXcLPcJ0+XLvZmOvvcsX0tt58tJXruzX
	J2ytoNwksCRceKr73+cYY+E3zZ8+jsAXYb2MCZeZcezKaNF0devTGoOvtXAgFmJe
	6LyzJ335oqcuE/sg8EE9kutKbRDXH6srbO0jC/Pvmf7oluJ2bwHS3o1xzh5WkKoo
	GETuSj7MEeuA61Kp5Ls7MQ==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4a89w79m9w-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 06 Nov 2025 11:31:26 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 6 Nov 2025 03:31:24 -0800
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 6 Nov 2025 03:31:22 -0800
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <tiwai@suse.de>
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <perex@perex.cz>,
        <syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <tiwai@suse.com>
Subject: Re: [PATCH] ALSA: usb-audio: Prevent urb from writing out of bounds
Date: Thu, 6 Nov 2025 19:31:21 +0800
Message-ID: <20251106113121.4064298-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <87a50zh42n.wl-tiwai@suse.de>
References: <87a50zh42n.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qjDEfIu5ViX03pEjsGq3DrwRXz5kDXwg
X-Authority-Analysis: v=2.4 cv=FYo6BZ+6 c=1 sm=1 tr=0 ts=690c870e cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=fWkikeFuuv3-QYznUzkA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: qjDEfIu5ViX03pEjsGq3DrwRXz5kDXwg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDA5MCBTYWx0ZWRfXz1jjIroafAfd
 qRWbk67ii1PZMSfBDhMpmVJIwsXxBybK3HdJKqX0cu3ALzjFSzVgxHoQr9xTSpzV5asOipNHpKt
 h/FiVplHyFBku88Wf68mbgPV70ikC/s9cP2plovfft4If679CJBYTsRFYPeTB4S8Rxx5BixkYfz
 noApWyvm2Pw3XtA5CfXeUqMlCgePOT0+pZJ96AW/jc6p4pIKX77jT5eEzxGGFnxv5E/jka9GANX
 Kfvkcmntv3n51u2B+iso8qQ/tM7ovIL5zgn/s9qh9cVlXk0OiTj6bR6JSRLrUXy0xwTy6nfnQYC
 +8x+HpGEZ8fRb+We8gT7Mm8nO+D/GAEMKs0oo33YnvoGsEuvGx7iZd3CJSk4bJys1ww93thC8LV
 L/rsgW2k2DPmk9y1WfYidhqhfbw4jw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060090

On Thu, 06 Nov 2025 11:02:08 +0100, Takashi Iwai wrote:
> > The calculation rule for the actual data length written to the URB's
> > transfer buffer differs from that used to allocate the URB's transfer
> > buffer, and in this problem, the value used during allocation is smaller.
> > 
> > This ultimately leads to write out-of-bounds errors when writing data to
> > the transfer buffer.
> > 
> > To prevent out-of-bounds writes to the transfer buffer, a check between
> > the size of the bytes to be written and the size of the allocated bytes
> > should be added before performing the write operation.
> > 
> > When the written bytes are too large, -EPIPE is returned instead of
> > -EAGAIN, because returning -EAGAIN might result in push back to ready
> > list again.
> > 
> > Based on the context of calculating the bytes to be written here, both
> > copy_to_urb() and copy_to_urb_quirk() require a check for the size of
> > the bytes to be written before execution.
> > 
> > syzbot reported:
> > BUG: KASAN: slab-out-of-bounds in copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> > Write of size 264 at addr ffff88801107b400 by task syz.0.17/5461
> > 
> > Call Trace:
> >  copy_to_urb+0x261/0x460 sound/usb/pcm.c:1487
> >  prepare_playback_urb+0x953/0x13d0 sound/usb/pcm.c:1611
> > 
> > Reported-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=bfd77469c8966de076f7
> > Tested-by: syzbot+bfd77469c8966de076f7@syzkaller.appspotmail.com
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> 
> I'm afraid that this doesn't address the root cause at all.
> The description above sounds plausible, but not pointing to "why".
> 
> The bytes is frames * stride, so the question is why a too large
> frames is calculated.  I couldn't have time to check the details, but
> there should be rather some weird condition / parameters to trigger
> this, and we should check that at first.
During debugging, I discovered that the value of ep->packsize[0] is 22,
which causes the counts calculated by 
counts = snd_usb_endpoint_next_packet_size(ep, ctx, i, avail);
to be 22, resulting in a frames value of 22 * 6 = 132; 
Meanwhile, the stride value is 2, which ultimately results in 
bytes = frames * stride = 132 * 2 = 264;
@@ -1241,6 +1252,10 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep)
	u->buffer_size = maxsize * u->packets;
	...
	u->urb->transfer_buffer =
                usb_alloc_coherent(chip->dev, u->buffer_size,
                                   GFP_KERNEL, &u->urb->transfer_dma);

Here, when calculating u->buffer_size = maxsize * u->packets;
maxsize = 9, packets = 6, which results in only 54 bytes allocated to
transfer_buffer;

BR,
Lizhi
> > ---
> >  sound/usb/pcm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
> > index 54d01dfd820f..a4c0ea685b8a 100644
> > --- a/sound/usb/pcm.c
> > +++ b/sound/usb/pcm.c
> > @@ -1606,6 +1606,9 @@ static int prepare_playback_urb(struct snd_usb_substream *subs,
> >  				    subs->cur_audiofmt->dsd_bitrev)) {
> >  			fill_playback_urb_dsd_bitrev(subs, urb, bytes);
> >  		} else {
> > +			if (bytes > ctx->buffer_size)
> > +				return -EPIPE;
> > +
> >  			/* usual PCM */
> >  			if (!subs->tx_length_quirk)
> >  				copy_to_urb(subs, urb, 0, stride, bytes);
> > --
> > 2.43.0
> >

