Return-Path: <linux-kernel+bounces-831752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6AAB9D7BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 07:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5743A19C439F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 05:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9CA2E88B7;
	Thu, 25 Sep 2025 05:40:44 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B62246BC5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758778844; cv=none; b=AD+zShuHk5HDHFOOMnKLCYtRx83yB0JpgmxhxQKxNB6SuzwF8wMR9O5Vz4Wyx9kbLTPsshr2oddIKj5A/NGKNBSniUK0H68NlYkAhMVl2toU31DNpBzERAo4MDw24I+Bh0QhCQaB7Xm+sSAksvbiTz3YI61ftQ1iJT60B4z3kB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758778844; c=relaxed/simple;
	bh=E5PMkI/JtNBxUNNAeWflgZt0jvq4dHVNGoKdpzU2PYo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jBQ3Cs3qf57IrWOh1g7XlJxngiSIuZjV3oT1lkE9Fjo/LTPPvjfP3jtHzmgS4O3c0KTjVqwLalZ9g4CXODso/thGL5vLK+JMtBd9tVxupw2e5wfFRQ1043CiqnxACVfYOjcnh+ZVNrISyB6eedfcxU/y3/COobSrxbRO+RUnSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-886e347d2afso71121939f.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 22:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758778842; x=1759383642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J06d6yJT00osMsrVcPuPhhHuCXjktAkEXzdm1HtU4qM=;
        b=lFQGdsLee6KpY6b6HFzw26uaA34/gjIA2ILaG9FMepYDUleobKZPn/B4QOmsOOiMaj
         qwr6J1PkpsUPxjTirvDr7Bt3z/Ci6cincPLf/6lsTeMGafFErGECKXhccMZMcI/RXxzP
         /Yn15vbw/iIPMkENMVlfSWkKb6oMv9Cl+ZKKXDP3JPNP9LZgGS5uw+1JKa1oIVZ8PyuX
         +ASFEvs9J7B/YFLcrnpvf6nRJLJ62XKplYtyRwqy1NXb4OwkMgdSzdj5aO+ITyzpY4iW
         cHfeYFohL+tclviqOS+SArBvf/QxfBQbJeZg0rdyrnWTN4TiN7GzY2iNqOiILb7LIeTS
         nBQQ==
X-Gm-Message-State: AOJu0YyxqUJ/8BQoHxGwLK13WsLpVDqk4xh5sBF5WbtGRTR4eyKBEmO/
	R7vyD1z3EzeM5Dwav3Bc/P3YIzhQIqFDm3U9/OB4oJARykNh5wI5d/TiTMRKCoBpiBI8N9KlOrB
	kTPAYfbm2EdDzIghLhS+hpYWrgvj8BS7uKA7H6WYomGch6Iz6VaRXTofMvfY=
X-Google-Smtp-Source: AGHT+IEW8Ji7B38Mq5bn2j/ST5tlxHVuQjiGY/0WdlQXr8apiieQD7s2ZB3lV3xlPotQGR+jVtV7ygDDNHh2LJlojG3vSKLFFKuy
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b08:b0:887:3efb:6101 with SMTP id
 ca18e2360f4ac-901567eeec7mr424874939f.7.1758778842304; Wed, 24 Sep 2025
 22:40:42 -0700 (PDT)
Date: Wed, 24 Sep 2025 22:40:42 -0700
In-Reply-To: <0000000000000a1b9a0620097bad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d4d5da.050a0220.3a612a.0001.GAE@google.com>
Subject: Forwarded: KMSAN: uninit-value in n_tty_receive_buf_closing (3)
From: syzbot <syzbot+dd514b5f0cf048aec256@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: KMSAN: uninit-value in n_tty_receive_buf_closing (3)
Author: rampxxxx@gmail.com

#syz test

---

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 79f0ff94ce00..b297e3fafdf7 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -177,7 +177,7 @@ static struct tty_buffer *tty_buffer_alloc(struct
tty_port *port, size_t size)
        */
       if (atomic_read(&port->buf.mem_used) > port->buf.mem_limit)
               return NULL;
-       p = kmalloc(struct_size(p, data, 2 * size), GFP_ATOMIC | __GFP_NOWARN);
+       p = kzalloc(struct_size(p, data, 2 * size), GFP_ATOMIC | __GFP_NOWARN);
       if (p == NULL)
               return NULL;

