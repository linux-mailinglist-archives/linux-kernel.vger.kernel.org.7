Return-Path: <linux-kernel+bounces-817668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFCB5852B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6A0A1B2092C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4D280308;
	Mon, 15 Sep 2025 19:14:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747727E066
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963648; cv=none; b=EUMsOQjYjQwUyQKLNmUlKjD/c/Ys7oq8MtS5wmLc+W03PMcTs0ZNzv+YACt8RriJNQLCV0ws7KqT0ZdK7cVsWQnjcwV5uD/y3/01yIvgdeZCKTDGy4hNYariikol1kf/XJaoKAE12e2ECJfPi7fKmyxcv8OA+TPwdhCLrpJDr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963648; c=relaxed/simple;
	bh=HQo7gECfUj2MZ5v+hbQo63hvW56mGKcbbxadCTI4/PQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ghyt0WKYKexqwAB1KuUyKnUA6hfBDEcHuj4yuJIh/4P/w41RsbgcUqWeu1P7e37HliD66wFw+eJ2KHdDeHJIKqF+e5YqB1vKv3NeLCbrnOguqRy4TMpOB6SfTesUDSTFP1qrcqZkAt9bkJ7HeMkegimSg0+qyLc0HwdUP1RJSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-40f7be8ecf2so130124935ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963646; x=1758568446;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R4UQUCfEQT8ITYqE1NUPEjW0YCqUm8im4+P3CCHTgyU=;
        b=Z3h15GkIfOBT/7Bw4gt3VfdZTF8In2Ak0xB+fO7dQjDboedhNroJ23BnfUKDY7rbzt
         PUncOCfGlzQUPAZQLpgMXPRCqtiqO3jow8qxoRldyYYStUWpOmWKj5hzhfn19S6Y6bl3
         vSAYyDCxs7bqj5MkAGOMIliqpYA7VN3taikW5eItTPp45KFZvGuA8/3lGFgy62npdOVE
         MYNQxO56T7DUV8wwWfadUWZVkwJk2IW53etPo0GlkyE9Bb7mzjuCP5kcoGgMzRPCV1N7
         i6IIozCes9hBMhEncW7Op8SWC+F2lq5jnj7dflafahQYoRwGWef3HNxxH3gDRcZtC0Qv
         T61g==
X-Gm-Message-State: AOJu0YwRkARv4AkS/a/LjUZrJGSzW8ojPtWTaVt4Sf8IxUfW4PNCsjM2
	fFcMxnLf/LiEkNocjRbgJAi5oePkUGZsYgg9UZoQMeQkH/2zXHzPlgEGgZdVFI98qZrn9uplKCq
	WNPDpOvgmwHgsCxdFPTyKKYeIMS/IxdtDn9kiBlTFIcfF0KNsgZKNFeChyyo=
X-Google-Smtp-Source: AGHT+IEVVrzztOqwAkHvH3iMI0wld5ci5RY68q2B1LvbRVFsc18hUfeTn0tL0R+bwpQnIWKWPbhKvhIUrEhdp0ihtuePfkZx8/Ej
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc2:b0:424:49c:bb46 with SMTP id
 e9e14a558f8ab-424049cc711mr45213425ab.0.1757963646164; Mon, 15 Sep 2025
 12:14:06 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:14:06 -0700
In-Reply-To: <68c85874.050a0220.50883.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c8657e.050a0220.3c6139.0d1d.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
From: syzbot <syzbot+7617e19c8a59edfbd879@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [input?] KASAN: stack-out-of-bounds Read in cp2112_xfer
Author: deepak.takumi.120@gmail.com

#syz test

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 482f62a78c41..8e17500256f1 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -689,7 +689,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
                        count = cp2112_write_read_req(buf, addr, read_length,
                                                      command, NULL, 0);
                } else {
-                       count = cp2112_write_req(buf, addr, command,
+                       if (data->block[0] > 32)
+                               count = -EINVAL;
+                       else count = cp2112_write_req(buf, addr, command,
                                                 data->block + 1,
                                                 data->block[0]);
                }
@@ -700,7 +702,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
                                                      I2C_SMBUS_BLOCK_MAX,
                                                      command, NULL, 0);
                } else {
-                       count = cp2112_write_req(buf, addr, command,
+                       if (data->block[0] > 32)
+                               count = -EINVAL;
+                       else count = cp2112_write_req(buf, addr, command,
                                                 data->block,
                                                 data->block[0] + 1);
                }
@@ -709,7 +713,9 @@ static int cp2112_xfer(struct i2c_adapter *adap, u16 addr,
                size = I2C_SMBUS_BLOCK_DATA;
                read_write = I2C_SMBUS_READ;

-               count = cp2112_write_read_req(buf, addr, I2C_SMBUS_BLOCK_MAX,
+               if (data->block[0] > 32)
+                       count = -EINVAL;
+               else count = cp2112_write_read_req(buf, addr,
I2C_SMBUS_BLOCK_MAX,
                                              command, data->block,
                                              data->block[0] + 1);
                break;

