Return-Path: <linux-kernel+bounces-900078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEB7C598F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA073A5B8A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F931618E;
	Thu, 13 Nov 2025 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBfocsAR"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697EC2F5A1E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763059627; cv=none; b=P+D0qTVgwTBii83NIecjrAJQ2qjQgmQiKb6IAwgtSZdg0Ifj6bZ0JzXCS4sfW9V2TKQCxmbrvGIHN9WnyVJIiecFTvme6YyzC3hnOpLAFwcxMV2BVKexzEH9bJAdhGTwc0OZAjzCGQ2J09YcHLBovt7s1fEHN3LUkHbs8+/5WQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763059627; c=relaxed/simple;
	bh=AEYu0vHePKHhlXiw+wtsZbGWlUAKKgWtvlMl4a3SqzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3h1l9RE21Z2iJNwsW05LRyWgYwhDYz7j63sLw9aL9ylkfLfLaeO1O7qMunCv/ezFwooFwg0EwklUI8D9fBYM3ox7F6P9g1xwLOT6UdmjEWbzy58xyDM5l08sDkyORQWM9blC5tppqugWXbKn1pRzyZJnyn/LRDmGs1KHMxUGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBfocsAR; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b1e54aefc5so105428985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763059623; x=1763664423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvsdwBPqpvbPMEI6oTxpi2WOx4rn64tuW/Zp9XGZRd0=;
        b=jBfocsARyT5hQQKzAimm3JzmNcLCQ/jxaQUWaYxsNMMex+2MJ+wCA+wmti24O2MBj6
         /foFSOJ3NFpA3alOxeJGhEarL2S2Z26fI++YkeL4ghpBD/ZQvOY/YF5c0kVu0z2je/hb
         rUKqNkrb0tAS+ktODdI9eLljynaHsx2DQ+AOQPVE1Uz7CTmbmqClka9iJYBr5rpukv0T
         koY0YNgcKK80RAS/r061PAr/I+W61x9xRC7R6QfZdnXoA5cnc5HSrn5SXgufjT5WWtb4
         tB2aTxgvWDyeiTpIForS2V8FeQG5/xLlHLH3SqROM/W52Euk3yTxMq8fPrvifU091G34
         LXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763059623; x=1763664423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvsdwBPqpvbPMEI6oTxpi2WOx4rn64tuW/Zp9XGZRd0=;
        b=LZOhlXJ2rKjHR5/WYqvngXWc8yjuq/HaJO26yC/vgZSKm9WnfhRUj3Y2Ag/pp8TmPC
         amR3WxdKqOM4erM/SlGw1JJs9uhKJGABGEt6f/lTyYZ50UuVR3kjAv2voukmIXKVP2Hi
         Jgrrpv2FQ1uMGXhbFAB9qSY0XGcspGKIzs4NiJI0iKPPcXjFJXAgmDBaZmU3FS0gSb5s
         mmDPvqfjtq8sZ7rUP5eJIwRmw+ND4hoY9MeANWpQsMmUxpKu0rrPlJQIY7Qe3WUCGbvs
         Ir9EuNIEyVQO++aBjMtaiWLho1tS0bQaty25JKK6AFisnmMbpFf+KJ2j5xp5lZLOIJiH
         Xqtg==
X-Forwarded-Encrypted: i=1; AJvYcCVUBrnFCV9AgRxG+lpRzERep7MRD5xoGwSxvmbYYuE7kf9XY/SOFEFP6QX2MbiTQiU5ePoYGcicKwz8484=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysm3+RVvnKFqLvXVJELYsEZaO9Jpl/Mdn6fpBQAKBptJHIonLe
	Vnlzx3dMDByM/HPi3toVbxkfhyAe+1963eRrnJj8nHGVepD/Z7CKH3XN
X-Gm-Gg: ASbGncuMe/LgapW56Hixi7HcVbMkqvjsko7AWCnt+HQe3DQffYASDAYhPgyesjyNm+5
	vx9Pt2ewTztyQzA+pX59qCPxYWM2K627CKWm+lYLo7CLdwoQoXmgeDcqXE9PxYayMBq3yM33AyT
	EMPlRk74vGuJjohAde6MlDdKYt2/fSdFY7I17CWPk0bTEJbVnt+DLsQvm1yq2hxTkK31WQ7QPu2
	OnWlyR23YaFBZ7eK8h8ulziYF3HfQBdbHmMT1Bp8tHFSmt6vfKPUfiUciOR0Zda2QIo0ZnQNxe6
	3Uurgnb7J/sdHSTGa/pOFbJG7Ia+GLsMMKBbfXyZzg0PiwDoolIPRyR272VdVj/VckRDy0VYzLH
	Y3Nd/D3WU0wzGmZA/hTukiN3rF51ovJ591hAOFjuzahayj4jnKNynU6EZ+BB3bRg5a4wdKA872w
	CoycycjIoytYO9nXz1kXRte2MUScHw4vicw41nLIPYIm1uqSpy2RUyznluTHTYdrflFgTFj7Kw0
	IpNi9JNcnq2tm+7e4nTgqn53/V42PQ=
X-Google-Smtp-Source: AGHT+IH3InWBGWlCMYupWUVBrRqlbaHu5eEfs1OoTcoYk3eD1OrI5bKS0JrlheVnrRCn26zA4PKCKw==
X-Received: by 2002:a05:620a:2945:b0:8b2:889a:124b with SMTP id af79cd13be357-8b2c3130660mr64071185a.5.1763059623199;
        Thu, 13 Nov 2025 10:47:03 -0800 (PST)
Received: from seungjin-HP-ENVY-Desktop-TE02-0xxx.dartmouth.edu ([129.170.197.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af06334csm179025685a.57.2025.11.13.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 10:47:02 -0800 (PST)
From: pip-izony <eeodqql09@gmail.com>
To: Hin-Tak Leung <hintak.leung@gmail.com>
Cc: Seungjin Bae <eeodqql09@gmail.com>,
	Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()
Date: Thu, 13 Nov 2025 13:46:27 -0500
Message-ID: <20251113184626.748717-2-eeodqql09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungjin Bae <eeodqql09@gmail.com>

The rtl8187_rx_cb() calculates the rx descriptor header address
by subtracting its size from the skb tail pointer.
However, it does not validate if the received packet
(skb->len from urb->actual_length) is large enough to contain this
header.

If a truncated packet is received, this will lead to a buffer
underflow, reading memory before the start of the skb data area,
and causing a kernel panic.

This patch adds length checks for both rtl8187 and rtl8187b descriptor
headers before attempting to access them, dropping the packet cleanly
if the check fails.

Fixes: 6f7853f3cbe4 ("rtl8187: change rtl8187_dev.c to support RTL8187B (part 2)")
Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
---
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
index 0c5c66401daa..eff42acc11a0 100644
--- a/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
+++ b/drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c
@@ -344,6 +344,10 @@ static void rtl8187_rx_cb(struct urb *urb)
 	}
 
 	if (!priv->is_rtl8187b) {
+		if (skb->len < sizeof(struct rtl8187_rx_hdr)) {
+			dev_kfree_skb_irq(skb);
+			return;
+		}
 		struct rtl8187_rx_hdr *hdr =
 			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		flags = le32_to_cpu(hdr->flags);
@@ -355,6 +359,10 @@ static void rtl8187_rx_cb(struct urb *urb)
 		rx_status.antenna = (hdr->signal >> 7) & 1;
 		rx_status.mactime = le64_to_cpu(hdr->mac_time);
 	} else {
+		if (skb->len < sizeof(struct rtl8187b_rx_hdr)) {
+			dev_kfree_skb_irq(skb);
+			return;
+		}
 		struct rtl8187b_rx_hdr *hdr =
 			(typeof(hdr))(skb_tail_pointer(skb) - sizeof(*hdr));
 		/* The Realtek datasheet for the RTL8187B shows that the RX
-- 
2.43.0


