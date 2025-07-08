Return-Path: <linux-kernel+bounces-721675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0372BAFCC56
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70BA1AA77E9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C782DD5F0;
	Tue,  8 Jul 2025 13:41:27 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EAF6A33B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982086; cv=none; b=LXQbgoagbNvxbbtrG7aMgAWTk3S54UkV7SFYeUy/igzVuB+4cQ3T9p/VrDs3lAaxWvWHy+qVENv30hr3k5tJkfwxYBuSyJYzaoEtVS6Jr/1ddms/v1HPW0hJi/X39e9bOv29t2C/oaMf0qhxVPfbG/hKDAdIYifdf4BSFvyRXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982086; c=relaxed/simple;
	bh=DtbB4lgJf9UiUqFjNROhOaOtq+Q+ZUvuWg6zmLKxZqc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pGmWvM1j0CXhaOGUfPdYol7jVIlGa6UTJWfbYLmLRDBFt2aN1FGSchcKFt++h4x3vcKvoodYkeTptRhLU6+x6M6yT3YbgbidORmDB4Fiujdinw280eXLVCt5MS6DGk8vcl4WPzHuePT2uo48goUzwDHYDWKD42Hf+u+/jrbiEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3df6030ea24so46741085ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982084; x=1752586884;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlqaBHX5Z4gTs5jTlvB1HnLAHIY50wvLNKNDyz6F8Uo=;
        b=OBJ9oX3zcauxuJAvPaKJNlqSKvxbhr7kk2JJiIjKZOs7AwBnLd1+teSqtSCTkF6DbL
         0axam53NP2OhoIjMDJdrOLFNNlSL3P3McV4IbopkR/iox8pH7LXMnePLjabLWvvpglZf
         s2EFU9O8ETSjjO2MxaUKo9S8gfP4wCO/WEkEoeWOuHAqBgdgKl8eZaGoirRl4ohGcdHq
         tAWofB1sIKBT0mvNSeJGWW4QrnB20YhZC33m/mxQzBhHpX7+/bpJg0vzq6Ht67Cgynd8
         NqK/7UcaYdGdWravAz40d1+Z+IVc1xyBuCqQCzP/p1Gx37CT+ulMX+xpGJuJdN9HsDTD
         gbIA==
X-Forwarded-Encrypted: i=1; AJvYcCXdYXw6LiDlcjOHTxD5FWiMiFBjtTZhqxH+yJrhvPLoJbT1wXvIvDYKnqV8AIxYS8ND1LUelejYJgVODFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1gAEps3esHOTQQc0iIqGBhBxqKw26J+CO1J7Nic8HCxsp25tJ
	u1MAEA/x6KpfmPzRQ2lvp8mm0g6l4F3UBtU0hMBmtQKW7SDbVlp4D5dbm9oESQsotrR7cw60Ir/
	/VZ4uvP/VeqEa7YYA7CSro0GL0RZUQikzT+Tw5LxCnm8bcjzbP1EjrrNHZrU=
X-Google-Smtp-Source: AGHT+IEHWDHAzY2BOBD1guc6Dv80BuQF/GE+kymFwnh2q2O4DxQH0bj2bZyWxe0lBsXIvMyxgolCgFnfYM1D3NrBPPPMtUM3bDFf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26a:0:b0:3df:3be7:59d1 with SMTP id
 e9e14a558f8ab-3e154e3ca6amr26140235ab.11.1751982084422; Tue, 08 Jul 2025
 06:41:24 -0700 (PDT)
Date: Tue, 08 Jul 2025 06:41:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686d2004.050a0220.1ffab7.000b.GAE@google.com>
Subject: [syzbot] Monthly nfc report (Jul 2025)
From: syzbot <syzbot+list6b8e21ba94b2aeb18e4c@syzkaller.appspotmail.com>
To: krzk@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 27 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 459     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<2> 329     Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
<3> 63      Yes   KMSAN: uninit-value in nci_ntf_packet (3)
                  https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
<4> 49      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

