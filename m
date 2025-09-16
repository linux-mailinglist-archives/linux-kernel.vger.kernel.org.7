Return-Path: <linux-kernel+bounces-817999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA2EB58B58
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6073ADB1B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80707221544;
	Tue, 16 Sep 2025 01:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ckVUvVbD"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818421E091;
	Tue, 16 Sep 2025 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986921; cv=none; b=PTf7TDiL0qI54L05CxYB3EHXI9KGOePArOK4fGrSgZRHRkFG8/2cRimNS9Vv0ET3k8w/xv5MI/QJW6MT/PwKqYr2TNRiuIEg/5w5MEaQugecHw05w0kz9svS/FSMGYKSawXNn5J3VxkR7o5t2u2OcqYSxAwjDMoQgg+xRmn8LN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986921; c=relaxed/simple;
	bh=/NPj9Ibu/YPqLUGYduS8ZQ+yboz39j3GCC9JfG/uqU8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xo/RROuQJNxKtlB8kzmNC0nhLsc6l0aZ74JY7Rd45wYs7azVgNlP+5Luubd+9lLyAXuHzeCmV3IkdzUN5kPR3CcWDTMOoADrZNCE5cSae4JBTT9pV2WEwPItgLby2M+qxIs6Hyo65pHhZ+sHuCfyJN1Bjrw8ADuia1L9BinewbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ckVUvVbD; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58G1Qt2f2132534;
	Mon, 15 Sep 2025 18:41:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=uS5bE8x+pR5Prss8iPbMqoOog2KOIzRW5TEeu+WHybI=; b=
	ckVUvVbDPL+bypnY8+3HhViyZ1xjjWjhZOfiLmIpFM1S76S7WiCm6puFick67qtI
	1jlQ6weO1g6e+RxEvCL/8gE2rhLy01BVCPHK7Yyj6Wjsz2Z1VvxF7aCQJZ3mBL+Z
	BC3e/Wa+gW9y/8CWUiAo3RJx40ItGH55+ASsTF5YC8Q5TxcS48bzJHzisYC7+kIF
	KzxzVKN9yvooZJRwXAlVvu7yKuRAg9+h7hbcloH7jAOm5wp6yLqTdT8ACSgcgNdj
	rc1hXEUrGck+pyVCy9arCzcXWI1iWSuWbQjQdacgYKLoc7Z2bAxIrXpFczZ9oTTy
	KMPPxUOdjBXRU6LMMH9puA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4953w2anby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Sep 2025 18:41:46 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 15 Sep 2025 18:41:45 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 15 Sep 2025 18:41:44 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <stern@rowland.harvard.edu>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V2] usbip: Fix locking bug in RT-enabled kernels
Date: Tue, 16 Sep 2025 09:41:43 +0800
Message-ID: <20250916014143.1439759-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4f7805f7-805a-4678-8844-c38a97650dda@rowland.harvard.edu>
References: <4f7805f7-805a-4678-8844-c38a97650dda@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: xibJtnXIw66-bGH7dp6QEJphXQmeAh5H
X-Proofpoint-ORIG-GUID: xibJtnXIw66-bGH7dp6QEJphXQmeAh5H
X-Authority-Analysis: v=2.4 cv=PuaTbxM3 c=1 sm=1 tr=0 ts=68c8c05a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=yJojWOMRYYMA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=dz-7SrBNJNoZnK-ZadwA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDAxMyBTYWx0ZWRfXxR6UQM/DQLzc
 a7YfW+waQOG5LsT9h8G4dbIdZG4gPiPNOxjYoFTnJzjhJMS6+Jav7TZPXZQkjokRQvnaLqcETbp
 8hKzA4bXN/Bva8mCuWs2VMrt7LiP7re9NM1ledNteUjN1wVh1C0mQJ62ku27shB/NfmlYdQT/1f
 /dKv6/JyvVHg2Vq9lKh6BuaI0a3b5KBZg/y95cd2PbbSdqfmXFagO+6oOIvz6J8f0gAjo1rCpxG
 yaKSeuBnHOpSVh+nIgGo9FCbSX/0P6AhXIiiZ8N9w2IbKGfTJnzwquugvq+mOcr1sbVATnVqVgy
 QHxn0L7UsEjYS07mLGxk39R/tnQxiJ4mmHFo8heoB1UQo1ArWLCBtX/+VXnGDY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun

Interrupts are disabled before entering usb_hcd_giveback_urb().
A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
acquired with disabled interrupts.

Save the interrupt status and restore it after usb_hcd_giveback_urb().

syz reported:
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
Call Trace:
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 rt_spin_lock+0xc7/0x2c0 kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 mon_bus_complete drivers/usb/mon/mon_main.c:134 [inline]
 mon_complete+0x5c/0x200 drivers/usb/mon/mon_main.c:147
 usbmon_urb_complete include/linux/usb/hcd.h:738 [inline]
 __usb_hcd_giveback_urb+0x254/0x5e0 drivers/usb/core/hcd.c:1647
 vhci_urb_enqueue+0xb4f/0xe70 drivers/usb/usbip/vhci_hcd.c:818

Reported-by: syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=205ef33a3b636b4181fb
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: fix it in usbip

 drivers/usb/usbip/vhci_hcd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index e70fba9f55d6..eb6de7e8ea7b 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -809,15 +809,15 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct urb *urb, gfp_t mem_flag
 no_need_xmit:
 	usb_hcd_unlink_urb_from_ep(hcd, urb);
 no_need_unlink:
-	spin_unlock_irqrestore(&vhci->lock, flags);
 	if (!ret) {
 		/* usb_hcd_giveback_urb() should be called with
 		 * irqs disabled
 		 */
-		local_irq_disable();
+		spin_unlock(&vhci->lock);
 		usb_hcd_giveback_urb(hcd, urb, urb->status);
-		local_irq_enable();
+		spin_lock(&vhci->lock);
 	}
+	spin_unlock_irqrestore(&vhci->lock, flags);
 	return ret;
 }
 
-- 
2.43.0


