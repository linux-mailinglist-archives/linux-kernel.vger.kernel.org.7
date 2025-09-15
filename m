Return-Path: <linux-kernel+bounces-815976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8BB56DD8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EE83BB7D6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353911EC01B;
	Mon, 15 Sep 2025 01:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="kVR9k2Us"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BA933E7;
	Mon, 15 Sep 2025 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757899749; cv=none; b=SIZ2VUyL8H0Nxg2pX08cCUTYNDU7SDKcqwyUVOmxV2KX7n7dumvYO5hv81TnV1U5jIMC7tWcvnhXUQ3BQazBhWhH0o5D3XSmigF3ZuYSuzSLQN4Ar0KLBgNbzjPzRXj/ftJHx+GMaMTo7oUTxcafarTB3vvPtta+4tVcuR0qL+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757899749; c=relaxed/simple;
	bh=2MlKAYm7yrQrGxGujK8xQVyxnpm/lcPNTVDilg2v1fI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEwYnv6itOrLLpSUJxtCc9tIZVRgrHdePJYx6MhhvMVUCb2szGXn4ccD7784T0z38Tx2Yjzg/NcLA9fNVpAlB6R4Vdwhq5Ik72CpPsnihxRboV9+Iy3FVzMFT88wEved7ugx0HA1ISP/CQcooVQ3TJObN9UaB93H1LS7/R0++OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=kVR9k2Us; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 58F1GuhP2870035;
	Sun, 14 Sep 2025 18:28:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=y6fXwu0IxA+IuoJSpK1cBwOxgIlm26NM+dYcdXUKfJI=; b=
	kVR9k2UsS7k2y1GqTt+Mi7wCl40i6r2/dBuFc74eUVuGUQTgFmNYm8LfnIchoOY2
	VXHbikwdXv3qUIWJ7xWS6s6EHLWQbdm//4oaSuPzx25mJh50GrcGHJqjX2CKKSiG
	j5b632Uy6+YsKDurEXliunHUHCotxEGVnuMkopYZyA+g4TGaJ7jWcQQVWth//2zZ
	XAmtpxiLvDdWSCpU1hGxQcuBJTQzDc57JzbZ4hbvSQARSqlyynJ+0Yv72lCq+hjI
	S20E+7ZpPlg7/GirLpx7Gs1ao+QBV7iufOGyneoAxakpjqBZZ1tMRjQg7K7An1l+
	OBVLna5FstlhxVpfCS4pKA==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49584hh788-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 14 Sep 2025 18:28:53 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Sun, 14 Sep 2025 18:29:21 -0700
Received: from pek-lpd-ccm6.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Sun, 14 Sep 2025 18:29:19 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+205ef33a3b636b4181fb@syzkaller.appspotmail.com>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH] usb: mon: Make mon_bus::lock a raw spinlock
Date: Mon, 15 Sep 2025 09:29:13 +0800
Message-ID: <20250915012914.361334-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68c4cfc8.050a0220.2ff435.0369.GAE@google.com>
References: <68c4cfc8.050a0220.2ff435.0369.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Pbj/hjhd c=1 sm=1 tr=0 ts=68c76bd5 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=yJojWOMRYYMA:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=HlowLYmpaW5TbMPn4j8A:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDAxMSBTYWx0ZWRfX3bQQUjivvpQ8
 Wjr99af/Y2I+GMWmWJbQsaJJPI7JwpkRC006hQ/jccOFEJxPAxWR034otQ8b8Xjdr86BX+WNYFA
 CHb9kvuTSHjoqwZcfuZH1ojuqP39VHv47r4lPBXbQn0iXHyElwxmdD2+Hcf85TPbe4HK6DYF9+8
 i7V6Qt9fH9MbaXTM73tupPI4JHxQwtmt74KYAlwLpIhLqoYtT85lYYXD2GuyN7XSdzWBaIPtaip
 RIGzPHfPF+czdqNlT0O7+AzuvZUpOkcvGuGEJdU+yRJozF4XEz4wbcFnMLg9rv+N9aGiF1NBDEk
 1S5qNM5xjo5EJw0MCtct6TM6gNAbe/asRjD5rxi2R9jf2/XGHJcqJk/GJpKZWk=
X-Proofpoint-GUID: k2vhVHEL8RpLEvNZmr0uo2SIMcLHFjzw
X-Proofpoint-ORIG-GUID: k2vhVHEL8RpLEvNZmr0uo2SIMcLHFjzw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-14_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2507300000 definitions=firstrun

Interrupts are disabled before entering usb_hcd_giveback_urb().
A spinlock_t becomes a sleeping lock on PREEMPT_RT, so it cannot be
acquired with disabled interrupts.

Make mon_bus::lock a raw spinlock so it can be used with interrupts disabled.

syz reported:
BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
CPU: 1 UID: 0 PID: 45 Comm: kworker/1:1 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 __might_resched+0x44b/0x5d0 kernel/sched/core.c:8957
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
 drivers/usb/mon/mon_main.c | 24 +++++++++---------------
 drivers/usb/mon/mon_text.c |  6 +++---
 drivers/usb/mon/usb_mon.h  |  2 +-
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/mon/mon_main.c b/drivers/usb/mon/mon_main.c
index af852d53aac6..83d19b769d84 100644
--- a/drivers/usb/mon/mon_main.c
+++ b/drivers/usb/mon/mon_main.c
@@ -38,7 +38,7 @@ void mon_reader_add(struct mon_bus *mbus, struct mon_reader *r)
 	unsigned long flags;
 	struct list_head *p;
 
-	spin_lock_irqsave(&mbus->lock, flags);
+	raw_spin_lock_irqsave(&mbus->lock, flags);
 	if (mbus->nreaders == 0) {
 		if (mbus == &mon_bus0) {
 			list_for_each (p, &mon_buses) {
@@ -52,7 +52,7 @@ void mon_reader_add(struct mon_bus *mbus, struct mon_reader *r)
 	}
 	mbus->nreaders++;
 	list_add_tail(&r->r_link, &mbus->r_list);
-	spin_unlock_irqrestore(&mbus->lock, flags);
+	raw_spin_unlock_irqrestore(&mbus->lock, flags);
 
 	kref_get(&mbus->ref);
 }
@@ -66,12 +66,12 @@ void mon_reader_del(struct mon_bus *mbus, struct mon_reader *r)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&mbus->lock, flags);
+	raw_spin_lock_irqsave(&mbus->lock, flags);
 	list_del(&r->r_link);
 	--mbus->nreaders;
 	if (mbus->nreaders == 0)
 		mon_stop(mbus);
-	spin_unlock_irqrestore(&mbus->lock, flags);
+	raw_spin_unlock_irqrestore(&mbus->lock, flags);
 
 	kref_put(&mbus->ref, mon_bus_drop);
 }
@@ -80,14 +80,12 @@ void mon_reader_del(struct mon_bus *mbus, struct mon_reader *r)
  */
 static void mon_bus_submit(struct mon_bus *mbus, struct urb *urb)
 {
-	unsigned long flags;
 	struct mon_reader *r;
 
-	spin_lock_irqsave(&mbus->lock, flags);
+	guard(raw_spinlock_irqsave)(&mbus->lock);
 	mbus->cnt_events++;
 	list_for_each_entry(r, &mbus->r_list, r_link)
 		r->rnf_submit(r->r_data, urb);
-	spin_unlock_irqrestore(&mbus->lock, flags);
 }
 
 static void mon_submit(struct usb_bus *ubus, struct urb *urb)
@@ -104,14 +102,12 @@ static void mon_submit(struct usb_bus *ubus, struct urb *urb)
  */
 static void mon_bus_submit_error(struct mon_bus *mbus, struct urb *urb, int error)
 {
-	unsigned long flags;
 	struct mon_reader *r;
 
-	spin_lock_irqsave(&mbus->lock, flags);
+	guard(raw_spinlock_irqsave)(&mbus->lock);
 	mbus->cnt_events++;
 	list_for_each_entry(r, &mbus->r_list, r_link)
 		r->rnf_error(r->r_data, urb, error);
-	spin_unlock_irqrestore(&mbus->lock, flags);
 }
 
 static void mon_submit_error(struct usb_bus *ubus, struct urb *urb, int error)
@@ -128,14 +124,12 @@ static void mon_submit_error(struct usb_bus *ubus, struct urb *urb, int error)
  */
 static void mon_bus_complete(struct mon_bus *mbus, struct urb *urb, int status)
 {
-	unsigned long flags;
 	struct mon_reader *r;
 
-	spin_lock_irqsave(&mbus->lock, flags);
+	guard(raw_spinlock_irqsave)(&mbus->lock);
 	mbus->cnt_events++;
 	list_for_each_entry(r, &mbus->r_list, r_link)
 		r->rnf_complete(r->r_data, urb, status);
-	spin_unlock_irqrestore(&mbus->lock, flags);
 }
 
 static void mon_complete(struct usb_bus *ubus, struct urb *urb, int status)
@@ -277,7 +271,7 @@ static void mon_bus_init(struct usb_bus *ubus)
 	if (mbus == NULL)
 		goto err_alloc;
 	kref_init(&mbus->ref);
-	spin_lock_init(&mbus->lock);
+	raw_spin_lock_init(&mbus->lock);
 	INIT_LIST_HEAD(&mbus->r_list);
 
 	/*
@@ -304,7 +298,7 @@ static void mon_bus0_init(void)
 	struct mon_bus *mbus = &mon_bus0;
 
 	kref_init(&mbus->ref);
-	spin_lock_init(&mbus->lock);
+	raw_spin_lock_init(&mbus->lock);
 	INIT_LIST_HEAD(&mbus->r_list);
 
 	mbus->text_inited = mon_text_add(mbus, NULL);
diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index 68b9b2b41189..b482c610dad1 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -307,15 +307,15 @@ static struct mon_event_text *mon_text_fetch(struct mon_reader_text *rp,
 	struct list_head *p;
 	unsigned long flags;
 
-	spin_lock_irqsave(&mbus->lock, flags);
+	raw_spin_lock_irqsave(&mbus->lock, flags);
 	if (list_empty(&rp->e_list)) {
-		spin_unlock_irqrestore(&mbus->lock, flags);
+		raw_spin_unlock_irqrestore(&mbus->lock, flags);
 		return NULL;
 	}
 	p = rp->e_list.next;
 	list_del(p);
 	--rp->nevents;
-	spin_unlock_irqrestore(&mbus->lock, flags);
+	raw_spin_unlock_irqrestore(&mbus->lock, flags);
 	return list_entry(p, struct mon_event_text, e_link);
 }
 
diff --git a/drivers/usb/mon/usb_mon.h b/drivers/usb/mon/usb_mon.h
index aa64efaba366..d2a342feaad3 100644
--- a/drivers/usb/mon/usb_mon.h
+++ b/drivers/usb/mon/usb_mon.h
@@ -17,7 +17,7 @@
 
 struct mon_bus {
 	struct list_head bus_link;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct usb_bus *u_bus;
 
 	int text_inited;
-- 
2.43.0


