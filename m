Return-Path: <linux-kernel+bounces-754140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1902B18E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 14:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C82189E846
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 12:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC5A236437;
	Sat,  2 Aug 2025 12:54:21 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAD1F099C
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754139261; cv=none; b=XWyMdLrQ1iFEfuQ9g7sYG/M5jvZVhTCWdTFWvAWg7mPL8Tn7cifxXtcRbm48u5wYufGN4LKRb/WOEH6wg1WJKQEWcrydw133SEYb/rdDki07NV4X4sxkABzHLyZKmwOcDxXxVoGfGZ/Kfdq7M/qdqNRDZkha8aPY3EaCVXOOdwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754139261; c=relaxed/simple;
	bh=sVoqlJeN0kH8f7+EMVAczPaQekri7zRIqXD0QihzrkI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MA1e1MOKmiepK4NI2m0SmCV3fFeg6G2/8Tf/eDE41KxKCbNmd4j/l7lo2gXmn1mC0jRvZqjIDsSCQpWH/medgZnSAzuZICNNRvEouAK5GprJFQqLOr1V4/DiEvzYwYPZ3Ee96LOGBZiOyah+rQL2rTTwjIFtpafarxBwrbzSSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-87c707bfeb6so168584339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 05:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754139257; x=1754744057;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OBecpoJJO70BCBu/HlWNXeJXFHw4YD4HRwva99qg84=;
        b=Entm7qzWA+2cCxTiq+8VAwblOmrfYuQHxdV0cK/xQW68U+O0rPgZlchhlDYEJpDA5T
         tJJwiansq5vztFZkDGpfUpCgPnDkLr+Hg04cxJxV8SdiD/PCSyqeUGQJdQzBM5WNWQ2q
         Mr8tsMCziNL84JzCo7/60unrd2omM6NZdXCVDgsTQD60h3FKRane2E8QgQKGhYhCsrYQ
         ESUxmWNyAkUuYo2zVx0O20jNW1YhiMV6rSaEQGEv+2a0FWgLpTjiJm/AHtYH3JHJqEZ4
         f7IJ87QbxMVI8ODroxRM86S12tg7wT+9k8Skk4BP9rGOhVmZGtP6JrA8Z8h9clWR5Y1M
         +c7A==
X-Gm-Message-State: AOJu0Yxhad6JO2mJmkG0hXdQ5LXbcpQnPR/Ctp5gCVuP+Zg41z0lcNdh
	q4ehwxDDr1TqwcHEPWFiEGKrIB8JbNt3x1gqEId8v3bcF9YiVEyADSLiD1Hjw7n5GvZt0AhlANF
	t8Vyn9v2sh4kTQ+R4KHJNavL+Cs0kYtw5/Zc94lEheyoTAWSzBe3AGsKtDDs=
X-Google-Smtp-Source: AGHT+IHE5CiqdAMUDsiU0Whh8ubStGnFDaAY1+n8tAeFL77I5W2dbAKi/pNs5NgSk3tbm+YIpfqkYTXuaFk4Y8wCH7eHTU0eNS21
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:da:b0:874:e108:8e3a with SMTP id
 ca18e2360f4ac-881683e7e9dmr520022039f.12.1754139256821; Sat, 02 Aug 2025
 05:54:16 -0700 (PDT)
Date: Sat, 02 Aug 2025 05:54:16 -0700
In-Reply-To: <6834671a.a70a0220.253bc2.0098.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688e0a78.a70a0220.249f57.0000.GAE@google.com>
Subject: Forwarded: Re: Fix reported __del_gendisk deadlock
From: syzbot <syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: Fix reported __del_gendisk deadlock
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
-- 
2.30.2

