Return-Path: <linux-kernel+bounces-865964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7057BFE706
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EFD3A7795
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C1305051;
	Wed, 22 Oct 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/TVuzfV"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F62F39B1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761172729; cv=none; b=lP+3jkn8d4d2nODAqpG+tuOZlgZTnYZD1oVIu4CPanCgRI2kEbaunZGVUgetH53D2Iadg3yD/+jqEsQ2Qf1tN5d+DNEHyh+uNK9pRg/Kq/+1h/77OWPRx0YfQCUj0Z1y0fMfe0vLSumlm8e8cxTpdBOQxcaKKfkyNXgAoxQVVxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761172729; c=relaxed/simple;
	bh=ULKv6OA6DP41wT5L4cbEcKCtaPLTWzh9900cBvwjo/M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WNNZlBGQGasL9tI/BKMjqvJagvwBYCA0Q7vgMmo4CNK5A1r8TAWbEdJmPSESZmexXJGtgxg6vupveft+tUvHFPmZeoGu/Qhw3OwqSVrOQUo4LU8Od4IbkKhqg0aBjCGPvxF4//QLuhVoC4SLKT6gu2BIJsepJaCmsNSeD5zY2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/TVuzfV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-88e525f912fso15105585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761172726; x=1761777526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5VocPRDtVk+dIE3iw2ib7QtB3Kc3D8UgJbJMrfJb3wI=;
        b=R/TVuzfVwi9fOhdMrqNAFxbxvXM8zSXaPBUkEUb1fCuM2OTalT6qao+D2Aqx6nXrua
         Xas+ZUG0SH8YH0kWz/gTGsBT+Ql1SIlO5ci5s6Quv7E7KoxKu0JPCvDtsRERo2ZoUWZi
         8S4ghdPZEAW3IN9b1QilRHGSAtdWkvyYf0h21hA9XizEH+HOq2G/Y2K2Rtk8iAY9nPVT
         Kqu1ONF/jJcFu+6ExSyV2YzF+yRBP+NwmeO104eCWWKs+NISz3J7HidGCG0mN6JmpMM8
         AnnaOsmn2l1yKqNHRK2I3SvvyFvLCfj7D/baTLwbM+rclPAnhCqxLwZUsaQYLuSv6ukA
         OxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761172726; x=1761777526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5VocPRDtVk+dIE3iw2ib7QtB3Kc3D8UgJbJMrfJb3wI=;
        b=RhunbbCxhGMwxUV8A1rKYx3k5HYd0/AHnPe9RamSFemZch9uE8juDdDnFot7iJqi6d
         dwjAoy/NQnxiNJkJRNUID9aJF++4N++PkIgjKYjCGeE2GWqwwnz/Gp2Vk4TPN3mqcIZy
         sE9L7IHTUcyDf8Fzgd/tzxjGZIhMlbi6UNXN94TVe1MMFajQCdvThn3ihB1mG0+V+Gxi
         GiQoteo1Iyyfp0LC5/th9ZNJtSu199xpgYItpBsAuWdoLe2Bv0vkdCr30UKz4+oryJzn
         vGfXA3e9IcvL+LzbEUGdKDx9eCNZC26qItadFe4j5X4NXqazo+lw0YHzJ/rpWtGRKhLt
         LkNA==
X-Forwarded-Encrypted: i=1; AJvYcCU4HgBpy8fQ9oEcY7NOQZnEAcl1AhM2qMbpAXQlpp4mbZ7vHRGfI2upBhp3OQiE0m9ZcT2b0UOITM6/Lwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMicqDHYIhJqDGMWXJcKqkFbyMwPrnDzlm1tk79tosi9aiPcXG
	0zeidiQzdkBJic48BYjwO4r3kmN9Yxo5fq0khJG2ZE/w/DVV49F8mAOa
X-Gm-Gg: ASbGncvQ5IQxHecxF3JHTivDnFTXcNUI5vLDnW1ffI2A7VtMftu1WhOOdywGEEqCw3u
	rqU6RAlPvabh38XgNBUggbmRdtuQE2JSh8eHLqQmYNGjmT1aTw/JNjK+hf0ktvb2IibbfbKDmPC
	QSWOivvRqdcQ/kxlWUAdS3zMBRqpKnng8fEqhSyVxf5AZYnGUwHrgZojD+ripCGf4edY4NzKF15
	rT9GZd5NobzuXvkFQtNMaH5nqq10MrLbYzWqUxG+ogwRpmIKwNrOpW3RAsZX8RCEcm2at/IwPcS
	CN9QKTtozIG52mFXesvUkm+hMBHpWloxHjk+lp87UCD+anCXPTwOwGaHgOA0uUW2XjSOdTDiJpb
	qleiuZDLzrPGDApoFS+Kq2h1dNglgG7B38EwFUb/ovgVsPWDWdC18Px2AL3DMgpeZh+VSP5mTyc
	cuRiXEcImYv2u/UwQxz29M
X-Google-Smtp-Source: AGHT+IEwf7KTlPfmIBbi2nVEJKfKO6Y8rFXq7vPh5m0MioYFQ+fvpto6UGE7cIpu3l0BBWVrrjj6eQ==
X-Received: by 2002:a05:620a:1724:b0:893:5433:741b with SMTP id af79cd13be357-89c105a9550mr92282885a.40.1761172726364;
        Wed, 22 Oct 2025 15:38:46 -0700 (PDT)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c0e586d32sm30609585a.18.2025.10.22.15.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 15:38:46 -0700 (PDT)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org
Subject: [PATCH] Bluetooth: hci_event: validate HCI event packet Parameter Total Length
Date: Wed, 22 Oct 2025 18:34:16 -0400
Message-ID: <20251022223417.139332-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There is a BUG: KMSAN: uninit-value in hci_cmd_complete_evt() due to a
malformed HCI event packet received from userspace.

The existing code in hci_event_packet() checks that the buffer is large
enough to contain the event header, and checks that the hdr's Event Code
is valid, but does not check the hdr's Parameter Total Length. So,
syzbot’s event packet passes through and uses the un-init values in
hci_event_func() => hci_cmd_complete_evt().

Reported-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a9a4bedfca6aa9d7fa24
Tested-by: syzbot+a9a4bedfca6aa9d7fa24@syzkaller.appspotmail.com
Fixes: a9de9248064bf ("[Bluetooth] Switch from OGF+OCF to using only opcodes")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
 net/bluetooth/hci_event.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d790b0d4eb9a..5e1498cc04cd 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -7565,7 +7565,7 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_req_complete_t req_complete = NULL;
 	hci_req_complete_skb_t req_complete_skb = NULL;
 	struct sk_buff *orig_skb = NULL;
-	u8 status = 0, event, req_evt = 0;
+	u8 status = 0, event, req_evt = 0, len;
 	u16 opcode = HCI_OP_NOP;
 
 	if (skb->len < sizeof(*hdr)) {
@@ -7585,6 +7585,13 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
 		goto done;
 	}
 
+	len = hdr->plen;
+	if (len != skb->len - HCI_EVENT_HDR_SIZE) {
+		bt_dev_warn(hdev, "Unexpected HCI Parameter Length 0x%2.2x",
+			    len);
+		goto done;
+	}
+
 	/* Only match event if command OGF is not for LE */
 	if (hdev->req_skb &&
 	    hci_opcode_ogf(hci_skb_opcode(hdev->req_skb)) != 0x08 &&
-- 
2.43.0


