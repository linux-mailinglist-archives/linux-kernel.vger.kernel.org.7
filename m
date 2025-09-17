Return-Path: <linux-kernel+bounces-819807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FBCB7E0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F8E548809B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 00:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5191E7C19;
	Wed, 17 Sep 2025 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Aj0MQMiv"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68586258A;
	Wed, 17 Sep 2025 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758070328; cv=none; b=X8OGdXQUlpPrvx6Qu7ZEs20wBQQcP3Gsq25FJvAuk1CPvdaDk5W3g9YEOxhb+ZdF3D1zYaadKgj2kLrfjkfWKQpMvDKjJSd3jTzkPoN1gCWF8Ao//sI7rnSNzQp6mGvkPu5uFFNWUnAEwXPxYA13hfup2Dbqom1l9cU/453eqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758070328; c=relaxed/simple;
	bh=OxwCZnJC5isXmiyPNJpyp0+DmSUnFI5Drm2wReP3NdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQz49o//Q0bzgI1PkKvBl2Rb4ZbxK3O5PVxr4dmbOBalVIWRPDxJXbrmANxsPx0lLsnBShZzUSyMCYoX9264Y0t7260Wm6J30XJyL/6tuTl5/fX4O85a2ue/Oqu7KeM7c0aHbSxWDqmy/0/uHhWxCuKwad+XoODx+UxGv0Hb9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Aj0MQMiv; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58GNwSkG3713697;
	Wed, 17 Sep 2025 00:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=r1gWN7yB1juy+kFtfwJcBQuVd+foLiAL6hMf8DPhb0A=; b=
	Aj0MQMivyrNifXPvt8IFpuRL3+m0ZcxnfChi0vw6U5W6RaPO7g/yxpv8gFP14H82
	uoZcM0Fy44IT2tijv4dIP2waleTWxsW2aTzX69ZC4AeVyWveFy8Qu03Gdv4zkvO6
	+hPkNNYSE5kNDhoElqL7Gx2o3qQQijFwVIIku0RQkDfZNDBW7IHpPLUm5TeVpGZM
	MM1q9IzuGPR9ThAatX6vakSXR2/gh3IPmX+QGadUbk9IEFTf5Tyw+2d4cIq3+S2A
	fUbgAKFBKVHLvkHSz4otHIursy09TYq8seqvccw2+lbSvO8Fu7DXl+UF67pW5cy6
	TypaDruy159mroIFyxPryA==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 497fwrr3je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 17 Sep 2025 00:51:40 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Tue, 16 Sep 2025 17:51:39 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Tue, 16 Sep 2025 17:51:37 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <skhan@linuxfoundation.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <shuah@kernel.org>, <stern@rowland.harvard.edu>,
        <syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <valentina.manea.m@gmail.com>
Subject: Re: [PATCH V2] usbip: Fix locking bug in RT-enabled kernels
Date: Wed, 17 Sep 2025 08:51:36 +0800
Message-ID: <20250917005136.1801295-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c32f5c8b-0c62-4567-9d82-081ecb0889b1@linuxfoundation.org>
References: <c32f5c8b-0c62-4567-9d82-081ecb0889b1@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Fd3qSLfHJEgL2DhVEOdTnAmRFrOhjAtq
X-Authority-Analysis: v=2.4 cv=Sdr3duRu c=1 sm=1 tr=0 ts=68ca061c cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=yJojWOMRYYMA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=f17w4hqU4zeInAolt7YA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDAwNiBTYWx0ZWRfX75KBoUEw7qWU
 o54yBgMshkmsCSzRql4nmB86P5EuY4AEUyHazOGHt55IMc6FlSb4DWaLwl0rQJRTt6GleAjgVHx
 gprly9JTQERxcZtE+TBqLjRVycU8xer5wGuTETHjRLTPBatp+AYNMJeZ71Q7rt1auTb2pJR6196
 2qqO2QT/cHdo/+18CCSxcbKvDi/HAHkoARXdcNU2uz8p2PrAGL2vYnX/VzToO1lMr+8xe5bG6A2
 T2NHevGRhBAE/1QXjYR/7isgyqVAeBE4LrQQMUCIBXQoX2glkQpfkC5dZ6mzTZti0xzge29iwU3
 PoSfHf69lv4Ef45KsRwUT+XONrKHZpwCWB7MLR/kPfbYnbx01isiQfdXM04QDA=
X-Proofpoint-GUID: Fd3qSLfHJEgL2DhVEOdTnAmRFrOhjAtq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

On Tue, 16 Sep 2025 17:33:44 -0600, Shuah Khan wrote:
>On 9/16/25 09:47, Alan Stern wrote:
>> On Tue, Sep 16, 2025 at 09:41:43AM +0800, Lizhi Xu wrote:
>>> Interrupts are disabled before entering usb_hcd_giveback_urb().
>>> A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
>>> acquired with disabled interrupts.
>>>
>>> Save the interrupt status and restore it after usb_hcd_giveback_urb().
>>>
>>> syz reported:
>>> BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>> Call Trace:
>>>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>>>   rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
>>>   spin_lock include/linux/spinlock_rt.h:44 [inline]
>>>   mon_bus_complete drivers/usb/mon/mon_main.c:134 [inline]
>>>   mon_complete+0x5c/0x200 drivers/usb/mon/mon_main.c:147
>>>   usbmon_urb_complete include/linux/usb/hcd.h:738 [inline]
>>>   __usb_hcd_giveback_urb+0x254/0x5e0 drivers/usb/core/hcd.c:1647
>>>   vhci_urb_enqueue+0xb4f/0xe70 drivers/usb/usbip/vhci_hcd.c:818
>>>
>>> Reported-by: syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=205ef33a3b636b4181fb
>>> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
>>> ---
>>> V1 -> V2: fix it in usbip
>>>
>>>   drivers/usb/usbip/vhci_hcd.c | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
>>> index e70fba9f55d6..eb6de7e8ea7b 100644
>>> --- a/drivers/usb/usbip/vhci_hcd.c
>>> +++ b/drivers/usb/usbip/vhci_hcd.c
>>> @@ -809,15 +809,15 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
>>>   no_need_xmit:
>>>   	usb_hcd_unlink_urb_from_ep(hcd, urb);
>>>   no_need_unlink:
>>> -	spin_unlock_irqrestore(&vhci->lock, flags);
>>>   	if (!ret) {
>>>   		/* usb_hcd_giveback_urb() should be called with
>>>   		 * irqs disabled
>>>   		 */
>>> -		local_irq_disable();
>>> +		spin_unlock(&vhci->lock);
>>>   		usb_hcd_giveback_urb(hcd, urb, urb->status);
>>> -		local_irq_enable();
>>> +		spin_lock(&vhci->lock);
>>>   	}
>>> +	spin_unlock_irqrestore(&vhci->lock, flags);
>>>   	return ret;
>>>   }
>>
>> This looks right to me; it's the same pattern that the other host
>> controller drivers use.  However, the final decision is up to the usbip
>> maintainers.
>>
>> Also, there are several other places in the usbip drivers where
>> usb_hcd_giveback_urb() gets called; shouldn't they all be changed to
>> follow this pattern?
>>
>
>Looks good to me.
>+1 on changing all other instances - can we do that?
I'm replying to both of you. Personally, I suggest this isn't necessary
right now; it's safer to wait until a problem is reported before fixing it.

Also, the context of several other calls to usb_hcd_giveback_urb() in usbip
differs from the current issue. Enabling RT_PREEMPT shouldn't cause similar
issues.

BR,
Lizhi

