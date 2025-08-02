Return-Path: <linux-kernel+bounces-754134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC1B18E82
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410C47A300A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AF222FAF8;
	Sat,  2 Aug 2025 12:43:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6BE273F9
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 12:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754138602; cv=none; b=DF5DnLqVHJSfJoWdcCngRpEWpEyhgoiRdQqm9c00soC0YfAGGkADAU7rFxhp5sDJjDOxqVpUvRj3jz/Dm/dgqaAluTT6ZhuD/3Itkkul3DuPNMbqCz83/Iqo3LdUZQG4o6nATo5LPYvqLxIjL8mM0U7MEFgHWde2NxtB42g8IJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754138602; c=relaxed/simple;
	bh=0Yk62wa4IMU14NUjS6Y/+VV3X80TCau4Bk3WHih/Hf8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=So0PEP+K/AZz5egF5c7WbKQt4MjBu7CxAbJbfLo2AgXHJWFU+GpP5WCltmYWsbyKuvyDNn1zM/OPd3vBCwOGrpvq7aRRczcfN0RMgYlcwP34GCtqASjqs+0c+INf1otB8EXLVitJNgNRYy7S93TLwYcnCSA3TU6rPB3udXtcA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-87c467931c1so631163639f.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 05:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754138600; x=1754743400;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pOp1KiJpscJreHkAk7UWsK8dLRPQ2YCkF1Ze1W2/zcY=;
        b=FDlGzqaiyJ+OoL6n1WcnJc4kMSa8Z0VsGICGMF6Vn1Fc5zXzH006uWoXubmHkut5oC
         bVUhc6acTJD3DcPJfd0ZLjsHcpuUBYfGVZWPB3E+a6I83lIFEcRhWJfM5xrwdnekqxvj
         OwKZPHLGR2fA7rpU0ugRmAz9BUsCktELFdVhgRe+SMh/PnlyG2yhabiHU7Yo2aUiEauT
         Q0mVI+bZ/D0FV1kLf0ACa/WecRf+URduOUJwoudrZzyAFNDyjxfhP+hYn+2zxxYclj5Q
         yUs89JU9JjwpeH0hPTo4dqFNZA+mspdQUaL1Fijz8o33Ytrt8YeRyds6GA3VopNH3Suj
         3UDg==
X-Gm-Message-State: AOJu0YzhgUOvJsjgA+KobPpWc2TjdKNZqzS28e5o5y+yl4v/L6dN/PzP
	xAzptDY26u8rE1A+Zt16fqAh6VIPCYZuJQfw3nGzBVvVFR9N8idA6f3rb0pitjtXQ0gSED3GQGo
	4c7yAj+T4rg3o+DzKS3eiZywizjy0R1wtursWPcyv13ngxvEwZG/wSwatYM0=
X-Google-Smtp-Source: AGHT+IHG/53U/RwvSXX0gvniMAgSbYjuTm2UIRNeRtGvuUUa6dU909jCRogamC65EY0jSx5zpvqAoFHO1k4DoNzLaH792I0xxIk+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:0:b0:3e4:c4:f532 with SMTP id e9e14a558f8ab-3e4161f0cf2mr56993565ab.22.1754138600466;
 Sat, 02 Aug 2025 05:43:20 -0700 (PDT)
Date: Sat, 02 Aug 2025 05:43:20 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e07e8.050a0220.f0410.013c.GAE@google.com>
Subject: Forwarded: Fix reported __del_gendisk deadlock
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Fix reported __del_gendisk deadlock
Author: ujwal.kundur@gmail.com

#syz test

diff --git a/block/genhd.c b/block/genhd.c
index c26733f6324b..bad731186189 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -819,9 +819,11 @@ void del_gendisk(struct gendisk *disk)
                disable_elv_switch(disk->queue);

                memflags = memalloc_noio_save();
+               mutex_lock(&set->tag_list_lock);
                down_read(&set->update_nr_hwq_lock);
                __del_gendisk(disk);
                up_read(&set->update_nr_hwq_lock);
+               mutex_unlock(&set->tag_list_lock);
                memalloc_noio_restore(memflags);
        }
 }

