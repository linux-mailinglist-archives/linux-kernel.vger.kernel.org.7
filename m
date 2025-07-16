Return-Path: <linux-kernel+bounces-733619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB72EB07710
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2813B324D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ECC1D6188;
	Wed, 16 Jul 2025 13:32:36 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50451A2C0B
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672756; cv=none; b=Q4Bn55KjvaUHUSJ12fDcMJGosZIARQcIcE2yeL+hSeATB6E4a+d8K/wjNCHHfJu0fLGFloaCd+vgpE79Y31BG+ozy9gHoNMSz5WBv+kDL0sMXhYJxcpYspYOnUoVV7zgho1rhYY1/6AhHhsoV3QV2RSwJ7mIr9tn0quLVfI+SSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672756; c=relaxed/simple;
	bh=0LjF+WEpfWxbMuI94iSle2uStVAP8+DyETXP7hJ2nWE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JGN+3bKvzPkD5qQfNhXuYK1Jio0wIr+zZqMbJfhNQ/2e/kZSF2nu+WDD0OTTLwkaLiQWoYRYlamgcWW1r3YR4q2pnz1cj26AKP1JV/wXyf2akPSlCES+GivuML1dgHbENh7AJHuhav8DWKlHACber6G/PwsHi+N3xGF9WXZjjAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-869e9667f58so1467466739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 06:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672754; x=1753277554;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FKo4QvDVoH70iqyD4IXeGiSxCF2PDv2mvb9DgjsTuQ=;
        b=fCInHK2pJ7Uepdh3D27wiQrTh7evU4fbVQ76IudGZ3+A/nVELa5qq8E/Fg/Cq0Xv4c
         XdkvKQdszVnY6+xCLqfhTsJz3J1oHevCqdBQ0WhP5tOyYksgLi1mJ32lpyh3LrLl7ecB
         Rl4m27XJSNNFhaIu47cFp4T7a1cfo1K3X/5Qs4sjs5Pdq/A53e9LKNpxTUMWGGZRUDLT
         EeCwnCNaASkKSDHnzjLK93C/2pjfQXDs+/td8ueiL1/mS6jZ7M23/xo+E0XjUYkqdbLe
         nNiikOCT/1TMV0QagZa3F20tSaAms29a/u8NEFc5yeLhzjkZjiiOKZqQ+8mZjzNvi284
         4VLg==
X-Forwarded-Encrypted: i=1; AJvYcCUpcPB1GiaI7MbMbqfgBZr1eLdsRIF3Zvex9q5InlXJn0Oo62soheiuJEZ29ZwHh0U9thUhwUMvTlKFJyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBRh1KqsVw2dER6AubsP6FHjLsUKyp4lSFm3Asqjv5G7t1hb4
	E//3MN22Zy6Pw1O3+O58gGWHxQVbzS05rEmHyBkbq6PR7Lonvk3Shs4U64gzpm0MZT4uP9PILev
	IO3ST0FMECFGC8ZJgJkRrlwYfNGZs9asY5GW35PtHebJf/KOXjS26QfLSVsE=
X-Google-Smtp-Source: AGHT+IGF/kwqN7mja3XdkF3JMxQnYsfIzdVe8SJG2JlSEMJrev647LnGXH+ZgnnCfb6c21qzpSjvMFXxHCtaE/I2Xx80WB5mV8aY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6305:b0:879:72d5:96e7 with SMTP id
 ca18e2360f4ac-879c28da0b2mr283284239f.8.1752672753981; Wed, 16 Jul 2025
 06:32:33 -0700 (PDT)
Date: Wed, 16 Jul 2025 06:32:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877a9f1.a70a0220.693ce.002a.GAE@google.com>
Subject: [syzbot] Monthly wpan report (Jul 2025)
From: syzbot <syzbot+list57b57add8873522eb296@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wpan maintainers/developers,

This is a 31-day syzbot report for the wpan subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wpan

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 26 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 286     Yes   KMSAN: uninit-value in ieee802154_hdr_push (2)
                  https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
<2> 36      No    KASAN: global-out-of-bounds Read in mac802154_header_create (2)
                  https://syzkaller.appspot.com/bug?extid=844d670c418e0353c6a8
<3> 23      Yes   WARNING in __dev_change_net_namespace (3)
                  https://syzkaller.appspot.com/bug?extid=3344d668bbbc12996d46
<4> 10      No    KMSAN: uninit-value in ieee802154_max_payload
                  https://syzkaller.appspot.com/bug?extid=fe68c78fbbd3c0ad70ee

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

