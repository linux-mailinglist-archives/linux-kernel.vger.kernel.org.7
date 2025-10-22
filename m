Return-Path: <linux-kernel+bounces-863998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D249FBF9AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7E6113554CE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E23120A5DD;
	Wed, 22 Oct 2025 02:11:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA54D1E9B37
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761099065; cv=none; b=rDBLntc8ZpI/pD0KcImmRijuQrRutc66EvvPxFjFjUqE1UmjcM+0eJURcFSZ9qsIJ0sXMHGFLx1sus2GmC6nUsWeRPUSuRSx3FvbCNCGKG7w2fr62iIOKYTxXbwA5QomzYuZS6haHsFcsFXyhCuvXqd9QiykR7woJAvWfFMJZh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761099065; c=relaxed/simple;
	bh=IXY4fvSJRHLFO75TpbPu83+IVPZfStVGP/St8G/Dzcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U5nctevNbEKwrVyKkA6AA6eiWCRYaomYL8IHq/kSXNF2fdHjk999F0cF8v2jghhpmi0nNL2qk1flg9vtkbYCtwSMynlnkX+u1i8EaKdztoCt3iEqJEEFwvZce9JGpNnmIsjEmTUxcS7d1pw+KnFYOq2YgxnY4o6sJOAc9xE8Xc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-93e8839f138so437877139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 19:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761099063; x=1761703863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLSOgAbH4fajGF6l2x4+9VAs94l4PA4ks6BTQ5XcfjA=;
        b=lYQ3OvuGdsRVxsLWFHZNVW+LlBROU3Yxvqday1KoZzW3vo1nKDJ8OcjLInz4RR7EZW
         bO3gD1N12dROUA9bi9h/GppPn+hEnDBkW6PcpjYqx8B9LFtKequSupjYk0WlNMgvBsFA
         m0WG7V9ZmHzq2IAX4l+OUo5XHQdgWtMIt3FzjWl39yHlNobKx4ZZksdFbgDoKhs6Yl2F
         hL2kZopBJkMtHqD5lC0KWpI3aZHSbZ2EtFU9mUYswbK+Iy95CjbPMEtgrMbsL0swRHoJ
         nnD2OTSPIVCZD0Hyohf8eec4eppzFvicirugS9D1nAJgECwOLDFsDhHeK49L/UXDfhWB
         csWA==
X-Forwarded-Encrypted: i=1; AJvYcCVKfTKQzCpSGyYvsMIrJtNUEXkOjDHI+VWhHTRmPtiPA6jCC+MT24zv4Y8SFzdUx9yuAn+YXpoX3cffLnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz34SNga2PDw3Id549Uz5osN2UXHcOTTbdeuzp9EWBX9Hn4ZnT/
	WCeKDuE2MP3Q8f1s+6zdA1CFkBm0sbDT6Jn2ILEwjMgkttaRJKiXqxlOYqGADK8EZGzBsvBMOCB
	gnEGXJ2KAkzDG6t2x0IjlimAriLbfuPRzxwwnoxkNqH6p/0+Iu5FqkIPJFRw=
X-Google-Smtp-Source: AGHT+IEVW9cLdrHk5gyQA1WxfkhrgghwzYO929NE0/bgIGqUiwbHvlKzK4+WrKpOwbSYRX9B2Xshlsy9wmnlEgO83Es6W9TxsQg/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3418:b0:93e:8c1d:3cdd with SMTP id
 ca18e2360f4ac-93e8c1d3e70mr2259497639f.16.1761099062740; Tue, 21 Oct 2025
 19:11:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 19:11:02 -0700
In-Reply-To: <68ef003e.050a0220.91a22.0229.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f83d36.a00a0220.9662e.0000.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in do_xmote
From: syzbot <syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 669d4eb0b91817f2451a0210c79ef4c21af66f49
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon Aug 4 22:07:02 2025 +0000

    gfs2: Clean up properly during a withdraw

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f57c58580000
start commit:   52ba76324a9d Add linux-next specific files for 20251013
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f57c58580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f57c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=353de08f32ce69361b89
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1589f304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1492bb34580000

Reported-by: syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com
Fixes: 669d4eb0b918 ("gfs2: Clean up properly during a withdraw")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

