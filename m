Return-Path: <linux-kernel+bounces-751831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 886B1B16E06
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DBD3AC3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA3D29827E;
	Thu, 31 Jul 2025 08:59:33 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF747218E99
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952373; cv=none; b=m9ejIphqL7kjTVyV10V/clRELzoaBiHXBGuC603UPlBEEeacv2bceqZHCyp48CAZKhXeaFYkPCdymI6iH7uafKUYUyBXRwwmPghxsfOKU88IFZX+j2TTR2DtDQ4EtNlGIHz7FMkY6b9DamrtodNrdqxt2/gKalD7UyQdxq0v6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952373; c=relaxed/simple;
	bh=3mEddPHZsFvJ9Cwt+PYalgpR4EylEMSlJ1PF5CyMsOY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Tgufheb+kAe82fIOrlLAOiNCk57msQH78Dc9JidKUrxc5Dz/MlUM0ht3hQl+Ewve4IcYLTk92VoqjcTCIBQeiwNO9DOTs1KfDkfKmJ7ixpliri5sUybwH8cIevxto4OfVTb+MsJmiIH9VaEHSb6FKz5sJ9JVuhFQ5A5lZy1nqLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3e69b2951so6457615ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952371; x=1754557171;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bpD3IXUoJUWT7+mzB7fHXG7BExrdSpXHnx0WRFCL1Ls=;
        b=KjkMADV82KxfZv7dyK17tTQqt5kigeIRl552I8UYOrgxZz4h/li+Bcn7sck8BfHQLW
         jHy5nBwvt9zI3yiHMnqhr1hxuIK5cpA9sNlS0jJp9YPJNPHgfC8Q8UO7NU0CT3qLUMcu
         KsZoHg5pyUiC5BG3OtX8Kp2F9pyKW6ymug/ZiFYII2+/tw3XGKsMvXGNgreBPuUSPml+
         Wk29P1rLeDESIcXgtqFywlqoMsAjk2kaOKAiYS5GgCguJ32444mB9xQnlfkmxs+cxxGI
         QbhCZpSBYuNyAigOam4gLdQODQZSHfou8h+0ajspWwSNXFeYir5wXwX+ltJMcmbBK2zF
         zsJA==
X-Forwarded-Encrypted: i=1; AJvYcCWXY6FE+5+ZpYWZDMTDQUNs4tc2TjZ7hWomDOscUAhD+A06i2TYnrD+u3EI+sce/w9AMXbcYvj8oufk1VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Ss+JY2+CFUW70CuxkA4561LWlAMJ6VxM0Qmu3p4PImgDwB0S
	LDkNTX3l1bPdrinM29Io15Dp3cYXcD0ZibI6nDA9lsR2VhPfD1tFWSEM00m0zf6RMxeL4qttJTD
	tWD4s/8eVIOHVTrGCT3SEyqz+gZESglxl/6/Zz4zote3p/Nt5qSJeVQKJa5U=
X-Google-Smtp-Source: AGHT+IE98xAoVtpMaY/lDFNzB73p9SJWWnoamk12G3HWmE0rJr+lqsqLsAldxvjeC52RzI3naksfv8UQaoLGmvUOT4/mclx1lgx8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4b:b0:3e3:f47e:815e with SMTP id
 e9e14a558f8ab-3e4058e8c65mr16279685ab.6.1753952371137; Thu, 31 Jul 2025
 01:59:31 -0700 (PDT)
Date: Thu, 31 Jul 2025 01:59:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b3073.050a0220.5d226.0015.GAE@google.com>
Subject: [syzbot] Monthly kvm report (Jul 2025)
From: syzbot <syzbot+listb4a8dca9c06e0ff0ef85@syzkaller.appspotmail.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello kvm maintainers/developers,

This is a 31-day syzbot report for the kvm subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/kvm

During the period, 1 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 63 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 613     Yes   WARNING: locking bug in kvm_xen_set_evtchn_fast
                  https://syzkaller.appspot.com/bug?extid=919877893c9d28162dc2
<2> 4       Yes   WARNING in kvm_read_guest_offset_cached
                  https://syzkaller.appspot.com/bug?extid=bc0e18379a290e5edfe4
<3> 3       Yes   BUG: unable to handle kernel paging request in vgic_its_save_tables_v0
                  https://syzkaller.appspot.com/bug?extid=4ebd710a879482a93f8f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

