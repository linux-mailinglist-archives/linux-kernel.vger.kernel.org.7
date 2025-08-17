Return-Path: <linux-kernel+bounces-772614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AAB294E3
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3893A19684DC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D30205ABA;
	Sun, 17 Aug 2025 19:42:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000014EC73
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755459742; cv=none; b=tT8YDKzAmQWSJOKogByip0aY0f2XxkF853yxNDhsQ5YrBdPWCKBCfrxYCroX7OMRBEf0t341LXX6g8qTyVbGq9rVhLbRTl35vl1Z0Q7u5z5eyUoPVPdsKdpRi57OTe5H/WsoBeQgKdjerEZ5mzhQhjm1SJGlwRHP+HnFwNBachA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755459742; c=relaxed/simple;
	bh=OPSso+li2zas9Ksear1fAAbwzUdJ6P6Ieoy2s+/RJq8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UiUha+mHIj8+EBoGtsnIYKYnJunZBJlgLZGCv70AksweDfdR8FBLQhebiT2B4kfamej0BMZe69sTFZCam7ze08+VujI8e7UyJSgXSFNP6ThsPSmTbwrD4Yku/2Ez9DS7EE6puSxUztdlHQ8MteBj8Wtv8fXNjYKuY8BLSV2LR9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-884454c97dbso161303239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 12:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755459740; x=1756064540;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7sQpv1MqagQQZ1xjW2RiUTSZCUkSBLlQBUtV/wFXo5Y=;
        b=uoxcGFtgrBRk9rLQVb6QsOKWTM2Uyf2Njn6rdocV0dydjAz0mgQWEC6Q94ZNynUEfU
         7P/tLwUvbFDZxu4J2SNEOgEEYLohswlgu9v7mJmnL6i1/p7spkX13eKGeGTBoFdsZxdz
         RIJ98MQHTxvYNDH3O2QhUUZUrApJnY/WaBj+Zi6kbP8wnto+dwwvjxfwOSZuCYRy9d8Q
         cXTV9QmC6i6f6+V6wyc11lmK4Ui47IrrEGQHmKKWBWXe1FJTotyeLuy6bZsgQ95N2atu
         apoJ1VlvwUgq3y74MsKO3hfjveGNTuNFcD2Uu5Mkp9dzNvCm9/hGepI+kRkPa1c2IfM5
         gtCA==
X-Gm-Message-State: AOJu0Yy0XOMMSh442GGg4QmENRvfZwz8KF/OaNEO6etdC0tU2GFdR1y9
	L4dYedF2HHH2L1DIcjrq7g44Foreh0Pp8KGabYHel9iL4JwN7KnhhlYID8JCP9LnGmetUEXlwpH
	CgSsTlRPnUeFxschPJPy3Z4giSNZvA138gTDUGT7NQSKUEb1KieeFmlLa3fA=
X-Google-Smtp-Source: AGHT+IFtVkWkWWC1iVXCdRlJNL5scNpKAvFq6LfUZHNEIlWz9EIHYlDJbWs3jEec+kHyYsO1KNQ5dluGdDNPPH0cBd5B7A974kiV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1808:b0:3e4:2ea:bbf5 with SMTP id
 e9e14a558f8ab-3e57e9c1bddmr200554485ab.21.1755459740557; Sun, 17 Aug 2025
 12:42:20 -0700 (PDT)
Date: Sun, 17 Aug 2025 12:42:20 -0700
In-Reply-To: <689ff631.050a0220.e29e5.0035.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a2309c.050a0220.e29e5.0073.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+20537064367a0f98d597@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: abinashsinghlalotra@gmail.com

#syz test

--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -872,6 +872,11 @@ static int ax88772_bind(struct usbnet *dev, struct
usb_interface *intf)
        if (ret < 0)
                return ret;

+ if (ret >= 32) {
+ netdev_warn(dev->net, "Invalid PHY address %d, clamping\n", ret);
+ return -EINVAL;
+ }
+
        priv->phy_addr = ret;
        priv->embd_phy = ((priv->phy_addr & 0x1f) == AX_EMBD_PHY_ADDR);


--

