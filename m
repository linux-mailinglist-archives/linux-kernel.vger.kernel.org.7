Return-Path: <linux-kernel+bounces-870868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0BC0BDF8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7752E4E8C73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 05:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED4D2D7812;
	Mon, 27 Oct 2025 05:54:35 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27DD2D63F6
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761544475; cv=none; b=TZarHEutqzilnrdjbjB+7hDzhgnyH7Opmhi/AS5Gc0CwVp0CQ3VOzoIQHq72eaA7h2PpQfcDcYMj1ArwwMtPEz1QGHnVnxKeW60zVisE2RGS3sJ6fiKA6NHf1qNrcCxj4y+M0Fd4z5RDLYc3uxv4qn3977qYsvQUAvHTO73da2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761544475; c=relaxed/simple;
	bh=oX8hJRy7IBEIAZ/1zm+0hkLe7OsbAjVeMtyeB0Q9dLU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DHEmk0j+ud/p33HaeOvOrUntRBQVLpJME/+LLlWqtyLBf596zdNCKrRtxkW8SV7USKGNf2t4fgJYcNhyKLRpnGX9zE9B5A7Ad02WQS9cdMP/jDn9KWWAvqhlgIDUAyWsWhWJOXFPgWhEQICTo//LpfHBSh0lKZDrQx7bfnMedqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-430b3c32f75so44453545ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 22:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761544473; x=1762149273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9HuDiteO2SZsDgJsN6+6JREKwnlgoCNbEs58bpVhLU=;
        b=dbWOD14QFo4u4ex1Za92C/v1+W0qU4h8EXDLB+HeKF+4uxC7th6u5shdLTX2jir79F
         gzLL8m2bkkxKTy352wXQ1B5eZHAYWRBx7tyU9wPaUW2toovd6YiQG+NijhUo+pWymXOz
         VjGZbASBVObgJQWhA/7aANfClg6z/JqVScQtljAD+2PtZiF2QbOlwJqZBtBt7ntgFEKo
         DTbcMgERd3Yzb0OGB2qIc3JGU97ScylZqkh6il7bJMS5ARC/vUEgtwULfNQnclA50xHW
         aISIPhceSCYKO4iwDyf+5G5/0v7+2o8IzkQvQrDRldjVKAbZlZRrCdX7RCWNyUDDUzDm
         86cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFhSJtBQCDpH1/ePT+DBUs42ltHGhBqWs2mEYVwYXIrSNjgPOeUyBxLGkIVJAq/Gh39+A65nRMnatc2YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXT4SNqqoO2Gpiu6gpqslUz3otFw2kc97UkgM9aas6jsJwWvV1
	YL6RUe2Ak+8+vJnvRXHHMJ4WsA7ZuuWB1i9I8Ril05b4D9bkur3gVeNPL05WZ+o/GAEoJWZteF8
	q4ZK2zjpgAk/4v7vQAQ2GzceJllu1JNRLOM1oubimvyhFYbY9zVMHQbff3VM=
X-Google-Smtp-Source: AGHT+IHfSwoDwEH++j2Dx7/xHP1y+OQTZzYZ/Wt09xZShEqKiuhnU1Y9NTvEUrZBaaO0VYLteaTM0kNA7lQZip729pWXA80ePN1F
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:42f:e334:5ec3 with SMTP id
 e9e14a558f8ab-430c527fc65mr446839375ab.26.1761544472906; Sun, 26 Oct 2025
 22:54:32 -0700 (PDT)
Date: Sun, 26 Oct 2025 22:54:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ff0918.050a0220.3344a1.0289.GAE@google.com>
Subject: [syzbot] Monthly comedi report (Oct 2025)
From: syzbot <syzbot+list1daaf45abb4087c8cf3a@syzkaller.appspotmail.com>
To: abbotti@mev.co.uk, hsweeten@visionengravers.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello comedi maintainers/developers,

This is a 31-day syzbot report for the comedi subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/comedi

During the period, 2 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 9 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1039    Yes   BUG: unable to handle kernel paging request in subdev_8255_io
                  https://syzkaller.appspot.com/bug?extid=f7ad508e3c76c097483f
<2> 471     Yes   BUG: unable to handle kernel paging request in parport_attach
                  https://syzkaller.appspot.com/bug?extid=c47f45cfb7fc1640ced7
<3> 5       No    possible deadlock in comedi_do_insn
                  https://syzkaller.appspot.com/bug?extid=4a6138c17a47937dcea1
<4> 2       No    inconsistent lock state in valid_state (6)
                  https://syzkaller.appspot.com/bug?extid=a0cafc3f8cfebb67a088

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

