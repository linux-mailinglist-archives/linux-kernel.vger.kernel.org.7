Return-Path: <linux-kernel+bounces-614044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93018A9658B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 12:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE7B189CA78
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Apr 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CB8214228;
	Tue, 22 Apr 2025 10:11:37 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6B020B1FC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745316697; cv=none; b=SP18TCRToZsiSNO/zzlyatyUviseHvMWTXSAWKuwdOQjuzH72TT2L/7c9a1Zf5ickIQxHZQMUcJtgkqDG7lXBIdBXr+QAkIF4eGQJHNM4gitvi7EvKrvMxtMt4DjjfI1YVRn/iewVSQtl9h3DjtKn/TgQLVBRZ4YbnU5pcz1Mhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745316697; c=relaxed/simple;
	bh=MyddPXEqkT/ccEpbWGrSBV3tL1l6iZYEwssAfmCAvZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lOkIKbfYQXbnPlrKHuMpB5xpGcJO5UvraUW4n1ZJEUsy2whrE+RvDhZcOc/Rfz9t9h4x4mGKislS/hjp5CCOuwECMDSZ7+Ou7y9WWwXT41TxeQfWoOBXYlhssfz5vNdYC2mW5x1ChcPEbx401PFfcHrAda2tJraM3UNaYU17fIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d9099f9056so56729495ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Apr 2025 03:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745316694; x=1745921494;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJWypGmhAyE0A0ZD6qLvLINF6ckB8EvT9cNMNlbIZ24=;
        b=awSjuLg/efocPym8vYZ+YFWTcddch25QT3PabZ+mbeeITo++aQRbRtLkD9qHPpLS8S
         VuqoMKiXACd93XkX8VS8CNnZ1mT4AmP1c5zeB5NTYRd1XTRjeJLExUDtGKksdx4eyLdU
         uCBYjvLJsPgDb2n28FaVaNFg7p4S7705Apy3XiuDC9VP4AP71JrMSpnImsQgt5ex6Vru
         SuE/1M6jo7qhh4DEP1Iqxq01XyJxwDtYj37j6tJfObTc0loJe4/4J4YE/ZCiasyKoe2s
         6+CFLGxiGnvdmyNSWrtzAIv7KApSLtYjHzuKlR1C/D21sPmtz5UVgA1IslPUj76DDF12
         /ntg==
X-Forwarded-Encrypted: i=1; AJvYcCVsCrzUoqMuintKnM2x0thxEakoBuCqo/lcyPj9WCewUXMnbiJwK3rUQcZ3DgLygX+rUCjvocAXbDEsBMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvBZRqi3yrx86PJfYqR5oQAbVtCKRf0TTIczHL3ViBWwbRZohu
	BWKbg10KpKe0sFtJOGhkVcPppbYoD4xy3qPMsnPisGGo3XPD0BqSj5dfkxyIA+U6Gyee+8vaG3B
	sitvGZSkU8sWl9Btgdeu8RsPprc2tRB5mBhSBJRlhSEh00olOV0ZJZDo=
X-Google-Smtp-Source: AGHT+IF3Pzr6mNNm3jKbTEmt/tdnyT6K4L/LfgukilGYn+EG5iVlnNcj8TwE+lTNnTv55J0AwtB55Iq05Bdjfx8vUwv8lcpJaQDX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c6:b0:3d5:8923:faa5 with SMTP id
 e9e14a558f8ab-3d88edc18eamr129416475ab.10.1745316694304; Tue, 22 Apr 2025
 03:11:34 -0700 (PDT)
Date: Tue, 22 Apr 2025 03:11:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68076b56.050a0220.8500a.0005.GAE@google.com>
Subject: [syzbot] Monthly hams report (Apr 2025)
From: syzbot <syzbot+list7d5d7954b33bdb027232@syzkaller.appspotmail.com>
To: linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello hams maintainers/developers,

This is a 31-day syzbot report for the hams subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hams

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 40 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3688    Yes   possible deadlock in nr_rt_device_down (3)
                  https://syzkaller.appspot.com/bug?extid=ccdfb85a561b973219c7
<2> 303     Yes   KASAN: slab-use-after-free Read in rose_get_neigh
                  https://syzkaller.appspot.com/bug?extid=e04e2c007ba2c80476cb
<3> 256     Yes   possible deadlock in nr_remove_neigh (2)
                  https://syzkaller.appspot.com/bug?extid=8863ad36d31449b4dc17
<4> 90      No    possible deadlock in serial8250_handle_irq
                  https://syzkaller.appspot.com/bug?extid=5fd749c74105b0e1b302

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

