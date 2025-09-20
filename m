Return-Path: <linux-kernel+bounces-825803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A779EB8CD89
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A631B261E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23FA221F26;
	Sat, 20 Sep 2025 17:01:43 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A371CD15
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758387703; cv=none; b=WQorC1cJ2lswFPBuvdkN0s/Zqgg7s6QBBfs0LQmloCJD2FgZk+hUtx0DxEB9zRMZo6+qN1Vic9LUIHi4oxa20nBRyVSp/0q+OEydez2Yjy1S9Jz5adUjHAVDTqVoGI0iOy3/14v5N3gOs+DmHF0wJ286xhTu1Qx07E44THrQHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758387703; c=relaxed/simple;
	bh=fYHLnc6B7Sp5mOFfjYQLABWn+g3o/H5NmZbhNSbBVR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nm1ojxzhquYUez5XW0XoOxZEXzN8235vfybUI6g0Prw+1GH8QR5NDtqzWq17lk0wJ9ME+JoveYqxKo9zHmZACPRXzu7p9TJFSiZDOVKNo+joyBQggwhvaloh20kc8WJwJiJ8Oygx0NkuuYMc/xWFLZdS0ts6GW5ygoo9vFmHdT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-42408b5749aso57268665ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 10:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758387701; x=1758992501;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcA9Yux/miLrkYq7N9DxyxygIxKwKnBgy4IPa8hHFPM=;
        b=HrC1BKcOSTuTqcVRXh/ymvruvsV3WVl7Ejr0o051I6t4GjPFqXnIbEXOmQH5h1iIqp
         x/yNqnJ8AuxufnlGEcbM4kpq2/Ri4AGb9lqP69LAbaETd2iATh7XxECA84oNxKdcYRz4
         hVOGz0uAumDJmEFxCWH/jBlH/1xQ9B/+TC6dwRZrRHoeoj5nC+rbS5k17GdzbsLX9clE
         VEpcPBuD4ZCWB+hVbeE7G0ptq+fqGD2V9unbMzdrVYEyWRKM9lLUhc/MdQB2K2oGbydQ
         DwOFq6c9R4YM67Vy0sxGSFVnv8xO2KuQ5crTI5JMo/kc2TFCYmhJX1GPh/cxaPSpQV+R
         PtRA==
X-Gm-Message-State: AOJu0Yx1Iz+H+ufhjKPJRBG+v+3iFmQ/YqSJvWQ4aEHraHbQqUxhLgyb
	qvRldyXsj2zKElvIBvQk6Hgd3yHC7VJf9xGkhRAZGpB5ojllv95wUKM9jAloQ5G0T76ae4mMA3t
	iZY0MyYgrz+25efFKVeayMVp+Kgd6ngKQgR1Xw8M1tRTgUPM4dxqllWBO20o=
X-Google-Smtp-Source: AGHT+IHHOM8K6D5tDSlC55IhdCcYEBEcUuqNRWLrC/izmfHLsm/E3+Bjs+2wP2BUh3SgMDwV1jTz9HzU3/VxqMBggwByXqaHw5B3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1087:b0:424:29c:dded with SMTP id
 e9e14a558f8ab-424416e12b5mr138222895ab.8.1758387701255; Sat, 20 Sep 2025
 10:01:41 -0700 (PDT)
Date: Sat, 20 Sep 2025 10:01:41 -0700
In-Reply-To: <6880f58e.050a0220.248954.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ceddf5.050a0220.13cd81.001c.GAE@google.com>
Subject: Forwarded: [PATCH v2 net] net/core : fix KMSAN: uninit value in tipc_rcv
From: syzbot <syzbot+9a4fbb77c9d4aacd3388@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH v2 net] net/core : fix KMSAN: uninit value in tipc_rcv
Author: hariconscious@gmail.com

From: HariKrishna Sagala <hariconscious@gmail.com>

---

#syz test

diff --git a/net/tipc/node.c b/net/tipc/node.c
index a07fb073368c..f64f653e775a 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2117,6 +2117,8 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 		goto discard;
 	__skb_queue_head_init(&xmitq);
 	hdr = buf_msg(skb);
+	if(!hdr)
+		return -EINVAL;
 	usr = msg_user(hdr);
 	bc_ack = msg_bcast_ack(hdr);
 

