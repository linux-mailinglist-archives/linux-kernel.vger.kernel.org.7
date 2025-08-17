Return-Path: <linux-kernel+bounces-772615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17473B294E5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 21:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F37176A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Aug 2025 19:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2BB221DB3;
	Sun, 17 Aug 2025 19:52:41 +0000 (UTC)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376F126F0A
	for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 19:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755460361; cv=none; b=K0d2YzK/TM/d80GnMDoI7OGRgbKbeXOObEaaYVaHa62TO2VWpvAvDy5VWvZZfnnyfBc4YZCfPX1IXDVQdZcCt8S/7ssLefcYmZ4iJOsUtevgMde4udXFefl8JN9YIQLVaB48ufHzMNjDIy5o2buTu6lwh+Iqep98nkTSPaZqt9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755460361; c=relaxed/simple;
	bh=A8eYQwHjwGlFOcPty0B+9E+tVfdk9G0FcjDEYyovMDA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a4t6qlsZre1yNLPnMnW/P69s0sucenGpq0r03C2GCcj/HuDp/tXzw7yaN+UmkWudxfz14rDd9qZ6itU+1sEyfsjfZSFdKzTft8q6Tb3OWiVzadovIl7vb1M8H8CEth2e8CnRqTYaLszR+jtdhhTXsAPfKLanEiNZ5HtUvXbNCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-30cce9bb2bbso7248058fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Aug 2025 12:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755460359; x=1756065159;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tevae4TQ8Qqk5cj2nIja0teocE2cFTqKuqmCPfW7cEs=;
        b=WVhgFEIglf5tCD73aiLlsRYA8+oSzYvCeRPC8NhJidJNup7JpFhMba75mlIlvBUUqJ
         TQlW0ff4HKp+QFvE0r9nbpJXyjzaPDh2fI/BaEL+xZJN0HUsyfflgTHeiESf1EzImB9g
         qMtHPFn35VnK1pUVddNvN6oO8QIHnhlqOhu1TdKWSF1hXVXIt188dPSjecuUKMqKeXD2
         MpX1ZbE2J1mQwPGiyAV796dyy7SbalwNp7oGloDbmqaEBNdFHnJSCXcbW8UYiShvWduZ
         P/GTN3eF4hUrJOb2Q+5mdZY0C39lUGkpgjtQEjs7Wh+0LEwWOkvBhZkwIMUxnE2u71m6
         HQwQ==
X-Gm-Message-State: AOJu0YxaK0+Mq9IZV0C6+7CT6v6u8dyLuzZ5tkW+yYI4Q5BGkSw8lUWB
	pSKT6oC+uaiUnb7k/To1VjsEYHcFvllKALydI9vggMt2GnECRhyUXQaWTZeVCvZDslNqco65Ttd
	mZ8wzvnxQobgUp5DIZT8YYyb1ycAMeGW6WlSYS0dcBiLMdN7mmP/+KNQGcOw=
X-Google-Smtp-Source: AGHT+IGQPt5NhBgpgo86Cc2n4YB3yUkONL8NOxjQl0bGi+MIqlTEkh5MKX+wY/FAOqWW/AOUYOWyYhzP0qEd2TYN1QbhaGxHSkYS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23c2:b0:433:fe69:fd85 with SMTP id
 5614622812f47-435ec4c8164mr5575111b6e.20.1755460359306; Sun, 17 Aug 2025
 12:52:39 -0700 (PDT)
Date: Sun, 17 Aug 2025 12:52:39 -0700
In-Reply-To: <689ff631.050a0220.e29e5.0033.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a23307.050a0220.e29e5.0074.GAE@google.com>
Subject: Forwarded: 
From: syzbot <syzbot+ec9fab8b7f0386b98a17@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: abinashsinghlalotra@gmail.com

#syz test

--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -33,6 +33,12 @@ static int ovl_cleanup_locked(struct dentry *workdir,
struct dentry *dentry)
        struct inode *dir = d_inode(workdir);
        struct inode *inode = d_inode(dentry);

+ /* Avoid unlinking an already unlinked inode */
+ if (inode && inode->i_nlink == 0) {
+ d_drop(dentry);
+ return 0;
+ }
+
        if (ovl_is_whiteout(dentry))
                return ovl_remove_and_whiteout(workdir, dentry, true);

