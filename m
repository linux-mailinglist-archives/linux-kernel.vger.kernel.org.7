Return-Path: <linux-kernel+bounces-849726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF1BD0BEB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 22:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28BE71897489
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A82222564;
	Sun, 12 Oct 2025 20:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceYVgSEK"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714CD1D416C
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760299251; cv=none; b=Vp3CmzM2CvCElc6Z2fo1IfU74h/QSDW7Sua8qJSJyQKZ/aF9Rgqwm6kjQLc2SVXB8+xxx+ORabN4cX9tOyrV1EOatHfaepd6p8BYcyCBZETWRzI2+tUzaEO/hT41+fZ2E9HBL+qQwr9TO6spMre8jM40Sk6lqSmYPXML2Yf/IZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760299251; c=relaxed/simple;
	bh=gsR6VLtEWh7Ep7Ju4BrPFAE2zcsW59Ip654xHVUfQTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qHxTH60vfGxYF4VsZnyalyzOIaGH8piirbX/x+jYhWXhJOdwRJs5QrqopzveUjmJcRRMNtRFL82jZwpVs/Haorx1vrQDt8y0KMkETAWVRpUoFctqsBymNMPV8zZmKCdbqaNOi6dAQeeDJ6dAkPr76Vch+qal/W84zTozV69lTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ceYVgSEK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63163a6556bso7024850a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 13:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760299247; x=1760904047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qhBizdbTK0z+OclNT8Vb7bFkHGH494w/g8TAfLl99kc=;
        b=ceYVgSEKYo9HQ2EpicwV4tUvownrShgL9CFnw7TjLMqZVb4cVGmmsfXJ3ZL5hQ9EJ6
         UHOU7t1y9Pstw4nMMzD1Az7YfwdtZTJevI+DoAF0s4JA4hIZ7ud7p6I9N/G0pbUEvImr
         orpryvnIZB0VwJYvM2ku7dnLgH6KfuMkAKqaRyJ0EEX7TrSE7YEDgG6LEoMmlUE4MeZM
         m6Uhfrp+lbu//GPKKRqg/opq/KfJp3jJtgrZ7O/9FsN6yiRVCiiKnLjJq0BaAiUytpbG
         RuRP1T/r+rTiXTa8NS7VORrQLBMyyfdIk9FambNx+GtjBT3sydNVGLWZOTmqFMdxfljl
         dVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760299247; x=1760904047;
        h=content-transfer-encoding:mime-version:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhBizdbTK0z+OclNT8Vb7bFkHGH494w/g8TAfLl99kc=;
        b=CQkCmOpGv9Jdz3ZR7x1NBHTIMtwb0RsxwZD8jx5HEgm6HusOrTADsJee/R+apzsEQY
         e0p61rVJ4Vccgf8/lFyYdE2eSiskBjIbRzZMoL5bfu/QPUb7wg9rElpD3zoKGgJKdEKt
         HRrIE2LOSkPueXGPytC8RIK7elQDeF2hBnMB1fI+a07HxKeeZwgi++mbFVridM0jMaa1
         DCOgFJ5GpHOxACaPHav7Ge37z6DXK0Pnoxb93oM+cCp47kYztQeAM3a6yTMCmLbQrZOb
         a5CkC5O6T96dyzISvlwor8jv5jDy425PwMZZJFln33rEI2iARm9Zms9x96Wu8ApxQJlb
         NK/A==
X-Forwarded-Encrypted: i=1; AJvYcCW+R3J1Z2ZZBb9lvGAQLIdP7MNHr8EGt0RGfQBfzJNf6+cPnwAyDClB6QJZ6bQV4uYg1Jwm2GK7m7x4YGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMlemFk8PC2x6lCNoi8QZOLsYSnpFoe3hLPKobSIBksm0INjG
	AY+3ZWacHVd98UPDK5ETEcNCrval7GhFg7dOjhSD1dBZOVCaZlmRLRHj
X-Gm-Gg: ASbGncsfYFCgVjuUSth444I0YEm+379Yi7vvb8cRLtzy6scLv7/5u/GQXxmPUrdyvMI
	NsOK7XycyI8RwyGaB6tde8Ju8zvhrWfb/ie4b7q8nAEtJzklfgM5PUrNoqhOt0jb/miY/OVIqGm
	GQijgzSLK/kbBY9GjRaotgwTlkWGN0V+GdQ+9GMGFe3Q0vLcelqnLcO7onVbDdIkunGmEy1Si6w
	Q42qjXdxk+iR5O8X87cEl3ei4o1K5sEwq0T8gcikoMM8P4hNOvLIrDpW5zKzOgfV5xqejfS5ZVY
	0IbvOc9tU3v+wMMj1Jj788k1qVNT+vJ2svCJ3IAcfty0dB3xQwscf6xiX3k0eTeH0Y9BZLlUtT9
	NukJcNRsvtZwZdhd85kJTeEvXNf+Pdry8cUOKsrSo3z1+XkztiYv6Sg==
X-Google-Smtp-Source: AGHT+IEuMwBGN8leVN09ZBnD48z+ZF3LbUxEgujm4n8TM9fKLeko+pSXEDUltw4QDk+L+Sj011ZL+w==
X-Received: by 2002:a05:6402:3510:b0:634:c4b5:5d7 with SMTP id 4fb4d7f45d1cf-639d5c6fadamr17675616a12.34.1760299246552;
        Sun, 12 Oct 2025 13:00:46 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a5c1348b2sm7454711a12.37.2025.10.12.13.00.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Oct 2025 13:00:46 -0700 (PDT)
Date: Sun, 12 Oct 2025 22:00:42 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Petko Manolov <petkan@nucleusys.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net] net: usb: rtl8150: Fix frame padding
Message-ID: <20251012220042.4ca776b1.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

TX frames aren't padded and unknown memory is sent into the ether.

Theoretically, it isn't even guaranteed that the extra memory exists
and can be sent out, which could cause further problems. In practice,
I found that plenty of tailroom exists in the skb itself (in my test
with ping at least) and skb_padto() easily succeeds, so use it here.

In the event of -ENOMEM drop the frame like other drivers do.

The use of one more padding byte instead of a USB zero-length packet
is retained to avoid regression. I have a dodgy Etron xHCI controller
which doesn't seem to support sending ZLPs at all.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/net/usb/rtl8150.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
index 92add3daadbb..d6dce8babae0 100644
--- a/drivers/net/usb/rtl8150.c
+++ b/drivers/net/usb/rtl8150.c
@@ -685,9 +685,14 @@ static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
 	rtl8150_t *dev = netdev_priv(netdev);
 	int count, res;
 
+	/* pad the frame and ensure terminating USB packet, datasheet 9.2.3 */
+	count = max(skb->len, ETH_ZLEN);
+	if (count % 64 == 0)
+		count++;
+	if (skb_padto(skb, count))
+		return NETDEV_TX_OK;
+
 	netif_stop_queue(netdev);
-	count = (skb->len < 60) ? 60 : skb->len;
-	count = (count & 0x3f) ? count : count + 1;
 	dev->tx_skb = skb;
 	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
 		      skb->data, count, write_bulk_callback, dev);
-- 
2.48.1

