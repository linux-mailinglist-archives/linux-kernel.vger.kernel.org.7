Return-Path: <linux-kernel+bounces-825835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3051EB8CEA3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 20:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33D81B26B02
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 18:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BCC312814;
	Sat, 20 Sep 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dq904hFE"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5D82877ED
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 18:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758392363; cv=none; b=EedLlpKosRFi9FqlNn/XX9fIT1v28Mg6OL1VengD+O0Nhz7XTaXhb3IkSabmSLKyTZl3098liPedOQKOegaV7o7KknhpVW5b+1G4WqM+bvx1KIi00zRtxl+tl5fh8fOeER4qmms/gtmfZphMjaJMBu7IsNI0JZHOCQ7nHpmSlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758392363; c=relaxed/simple;
	bh=j0KscSpgDTh6p8uZuHcSUU4TuFDxi/q/TSOCxgtNYQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VeAqS1Rptq4lOHoLpci/75KMKBT72Jtb0qjJwBiEauN+ht8EH/9jaQVloS3y0sEQD/S/uISPhOwlbfbbfOl0wXqo4zL4swTRomRRcqcM9eGWnnLY9F1PxBO83IilUoWIK5qw97tn+lpRvJx1RbXN5/fShxQLZI7M3aUsicyrrOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dq904hFE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32df5cae0b1so3459137a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758392362; x=1758997162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsB3ybCNAwm9k2yVhlgR9mb4hVI5Wt65HmznqvnReQI=;
        b=dq904hFE+q7FGUTHXB+lpmZFZHKbdi4zPfYbbqIpEUwG2jCl+ocOR3umI7awo8B8cI
         XZRuzudSN4OGtqDclA3tc9eh97fDhCUT7s8eQ6SbF9BGY3MncRA6ZFASOPFnfpvmm8iW
         H+UEENhk0VJJHgQUYZXjtXeeGppPGeORX4jDSr72LJBOB8Sj8c9S6W+/8eTCruiol0hx
         Zr/MURbYtFlnp5KSLUYx3shQf9uwPN/iwU3t/I+29OCgcShLVEY2FCfOMFaGtTO0fk1e
         9qGFgPtNo4jcvYXi2Cysrir4cEFBIHMphxwOzGbDcD/knyJ0HvnF7+vuvhDJ1ipiI9wf
         rO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758392362; x=1758997162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsB3ybCNAwm9k2yVhlgR9mb4hVI5Wt65HmznqvnReQI=;
        b=IwLG5FR+t4inPwY7RRVnfKXMftBYom4g4E4YcnTFtgxnBVcDgYMXv1GYoff80XuGOm
         sAwfUw1OcNYwHxj6w8gwXLeB8peU47x6hvLr+HFvNlLBfwxiJq5Ddyzr17s4za4aWc17
         cey6U3nUlLFKvPwoeKiBxxi6lC2zPS87eja1ygYUCazXZD329xOS1cKL253pWQwmXeym
         tltHbkJsqvL8+8cSaTcwjW7EKxTyhI265846ljNGLLUkbiMleDLjTs4raaoZGC/ny1TI
         Zg38HwEZsuG8TVcdMNX7gI9O8xtmonxpeRA8XpZHJoIwjSc+PK28aSUfS8unzR+op/KE
         ddAw==
X-Forwarded-Encrypted: i=1; AJvYcCVgT4o4JoaLAJnRkqyyfupTO/oxygIXLaVPWqe/OTUYTeaahYoejx5DTTImpqVgvO5b95x1ymv6XdX+aU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxir/okh4s5AQ1TQZUHHpe2G3ZReyQlAerWKmCxm7Iv28v7N8+o
	ZuVJuFPJdMmiNIXIK5yr8gNOGXZ02SoeCAGIr8B+Ydh/bbSQxBJwfcUy
X-Gm-Gg: ASbGncsvCHDN8In7ictiSyhm7rYWT6YJUjlaM28yw4RRMRygTtlM2OKcbk4XgSdza2l
	gMNC7TtFrGI17inMiN5l53lFhK+ujIxQq4yVHiPVVXcgt3DtV5vd7PFIDsl+RFd6QeFila4/E+b
	3t0xiyBWU8oeh4tas264QGfLaD6/3aCcyvPGW62X5oEttzkvwbxFrVQLJnRC+glCjDdxkUthR3e
	gBN1TNyJrlADrmCSLOaP38dnMTrlhzgYXh0Z8OCGNTFbDXuS6+5JParcikMyUpsSk8ncPnk9S/+
	UzhsDSvKHVQaEVR0szKEQ4F3xktA4GWC3ZcHkm1lhqEOPjyEylZgO2K6QtbABZEi1bDGztJD7N/
	7wl5TGtHgryqPuhoFRXVqAgaINQsiNhYdpW8KiQ8U6vieXrKITYkduFo3u0U/AVcicA0+qFOmXC
	cedI1CHB81nYLs6MIEit7DvdpB
X-Google-Smtp-Source: AGHT+IEaTWmiA3XTR7Y1Rj/vhL0ff7KTrbIcR7Uh/NeSNgRJpoApT9tUEOXDbbipmuTXwbyEfyPk2g==
X-Received: by 2002:a17:90b:48ce:b0:32e:d16c:a8c6 with SMTP id 98e67ed59e1d1-3309800002cmr9978667a91.16.1758392361524;
        Sat, 20 Sep 2025 11:19:21 -0700 (PDT)
Received: from debian.domain.name ([223.185.129.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-330607e9475sm8811270a91.19.2025.09.20.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 11:19:20 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: andrew@lunn.ch
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	kuba@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	skhan@linuxfoundation.org,
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com,
	viswanathiyyappan@gmail.com
Subject: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
Date: Sat, 20 Sep 2025 23:48:52 +0530
Message-ID: <20250920181852.18164-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported WARNING in rtl8150_start_xmit/usb_submit_urb.
This is the sequence of events that leads to the Warning:

    CPU0 (in rtl8150_start_xmit)   CPU1 (in rtl8150_start_xmit)    CPU2 (in rtl8150_set_multicast)
    netif_stop_queue();
                                                                    netif_stop_queue();
    usb_submit_urb();
                                                                    netif_wake_queue();  <-- Wakes up TX queue before it's ready
                                    netif_stop_queue();
                                    usb_submit_urb();                                    <-- Warning
	freeing urb

rtl8150_set_multicast is rtl8150's implementation of ndo_set_rx_mode and
should not be calling netif_stop_queue and notif_start_queue as these handle 
TX queue synchronization.

The net core function dev_set_rx_mode handles the synchronization
for rtl8150_set_multicast making it safe to remove these locks.

Reported-and-tested-by: syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=78cae3f37c62ad092caa
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
v2:
- Add explanation why netif_stop_queue/netif_wake_queue can be safely removed
- Add the net prefix to the patch, designating it to the net tree

Relevant logs:
[   65.779651][ T5648] About to enter stop queue ffff88805061e000, eth4
[   65.779664][ T5648] After stop queue ffff88805061e000, eth4
[   65.780296][ T5648] net eth4: eth name:eth4 SUBMIT: tx_urb=ffff888023219000, status=0, transfer_buffer_length=60, dev=ffff88805061ed80, netdev=ffff88805061e000, skb=ffff88804f907b80
[   65.790962][  T760] About to enter stop queue ffff88805061e000, eth4
[   65.790978][  T760] After stop queue ffff88805061e000, eth4
[   65.791874][  T760] net eth4: We are inside Multicast dev:ffff88805061ed80, netdev:ffff88805061e000
[   65.793259][  T760] About to enter netif_wake_queue ffff88805061e000, eth4
[   65.793264][  T760] After netif_wake_queue ffff88805061e000, eth4
[   65.822319][ T5829] About to enter stop queue ffff88805061e000, eth4
[   65.823135][ T5829] After stop queue ffff88805061e000, eth4
[   65.823739][ T5829] net eth4: eth name:eth4 SUBMIT: tx_urb=ffff888023219000, status=-115, transfer_buffer_length=90, dev=ffff88805061ed80, netdev=ffff88805061e000, skb=ffff88804b5363c0

 drivers/net/usb/rtl8150.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index ddff6f19ff98..92add3daadbb 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -664,7 +664,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 	rtl8150_t *dev = netdev_priv(netdev);
 	u16 rx_creg = 0x9e;
 
-	netif_stop_queue(netdev);
 	if (netdev->flags & IFF_PROMISC) {
 		rx_creg |= 0x0001;
 		dev_info(&netdev->dev, "%s: promiscuous mode\n", netdev->name);
@@ -678,7 +677,6 @@ static void rtl8150_set_multicast(struct net_device *netdev)
 		rx_creg &= 0x00fc;
 	}
 	async_set_registers(dev, RCR, sizeof(rx_creg), rx_creg);
-	netif_wake_queue(netdev);
 }
 
 static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
-- 
2.47.3


