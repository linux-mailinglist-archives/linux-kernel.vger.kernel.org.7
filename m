Return-Path: <linux-kernel+bounces-780915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD20B30AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74A631BA70F6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 01:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982641A2C0B;
	Fri, 22 Aug 2025 01:41:39 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC20686340
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 01:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755826899; cv=none; b=Uw/LxQxYuib812PnEEfc5S2NPNPBrl/WR/uUQNPuSPo+d/jIs6dwvxgcuZoyg0J4uh9sZ5+voGSfnoC58MTixiu37gWCTk4YmM9yJa7el/ouYFJ28qmZflMsOnN9eaGQ9REk5123okXdi1W8rhMlPld1CKTQW1nOYbYaenQnWc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755826899; c=relaxed/simple;
	bh=ZlMbDuTIaOtSBuyKyXfp79QP3D7NXD43H4a5JZtqDCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tu6br/Usaq+eiRXLBr9Ap++xeIopHjVhJDhTN9uBKrP5A0n3M1ny4pNb3k0ORD5d7jwa6cLu6OQBRoQgLYxIogrHpEIUO014FKAP+zxS+nMDV2k7m+uBGD74BTJaA7yOyetXOB77ImFMxWQ9Cx0otQ28o2i5aUUupNpx9XjJfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432da036bso165832939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 18:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755826897; x=1756431697;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rs6BJL90Yxsp2vHaIqlNvTGpI49bEiUly2bA2t65LE=;
        b=CmluXp0OncJoWOQnmW/6PmAkt3kEWU9FFtGkZZi2CrzYPkUdwuws07bDM5SxT0dZ8B
         NZW/k1+4+HgNHLiDpAx7bw4rsEfQBMFaLDfBd10FnyrAl05M/zohPTgpn6IUvjPWOnOq
         YoyK/C343RYoHkjLapUyFxPStcA2lM5e/KCr+3+Oz5Z0Vl0CLIw4xG4FtPRZvm6n9DTQ
         kMtXeiYD50Qenm1HUBKO/Xd0Z7jAzbf4NAO3kmN1SQ4Ey65EMrH2OT1V6j/FeB5yTIy2
         N+lU9BEKpNMENWbY51r5LW1P5i8cMIS0ucg+4wT48bTST4uHEy3Zde48ezOaePnuA3A3
         dtRA==
X-Gm-Message-State: AOJu0YxuGW38pjLqz5jLl0XS7k7eu9oOBm9zqOga1PDHcHk/PgMkpSqU
	2XwvOJAY3vf91CTnUMV+lpYpbh/PbeyaTwPRoALqHZT8lVD5NQVMmxqEiOMMg+vci+BEyM+3FK0
	7/tjYEWJjQq+0U9Nxqtx0Az3e+UZ7XJUDA7SmU7LQMH2tkmvrpqvTz8V1Cto=
X-Google-Smtp-Source: AGHT+IFS4atHsfex4xybOuZXEkm5XRUnLZtYVJ2kiP523EaS+AhjCMGREqSnFlpDTSe9U+Aiqe6PkJ5blrNiQDwWjbbLCR2gdfYe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3e5:6bc6:4dcf with SMTP id
 e9e14a558f8ab-3e9209c64a8mr25144255ab.7.1755826896981; Thu, 21 Aug 2025
 18:41:36 -0700 (PDT)
Date: Thu, 21 Aug 2025 18:41:36 -0700
In-Reply-To: <68a7b69f.050a0220.37038e.0047.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a7cad0.050a0220.37038e.0048.GAE@google.com>
Subject: Forwarded: Re: [syzbot] [media?] general protection fault in su3000_i2c_transfer
From: syzbot <syzbot+d99f3a288cc7d8ef60fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [media?] general protection fault in su3000_i2c_transfer
Author: lizhi.xu@windriver.com

#syz test

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index e9577f920286..17b0bec53e21 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -257,7 +257,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 	res = 0;
 	for (i = 0; i < nmsgs; i++) {
 		/* Limit the size of the message to a sane amount */
-		if (msgs[i].len > 8192) {
+		if (msgs[i].len > 8192 || msgs[i].len == 0) {
 			res = -EINVAL;
 			break;
 		}

