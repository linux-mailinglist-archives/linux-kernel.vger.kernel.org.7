Return-Path: <linux-kernel+bounces-752128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A60BB1718A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037691AA67F0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB642C08CF;
	Thu, 31 Jul 2025 12:52:31 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D01E50E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966351; cv=none; b=HEeU69biFkJ7/iWRIXrsB1xPudRUkY37JW521g5n+38e2/Qzf740u7nO5TKGXeQJdWkjE6Fc1ftTulc4uJrO/ahjdTJJ4gyAlofjfwmzlNMpR6B4Ztvt5dQwRjDD5CaAqYFrNZFrDuiBTt3he2imclz7TFgAXqmW/zoHD+QaYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966351; c=relaxed/simple;
	bh=yHicCcL9U3t0KFPKavAanflT0YgueRr+UiCNnvr87e8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qKUVYSmJve03hKgT9kJSZM+4U5GmtNwrAqcsMZdwFpTaFP6kKSRSzbv8MDMQF+3HlljYIOpWGw0u0XUFrKxQ+9cfsezP14Tbdv0Si27p37uLa8g3HvrUXB6tbSaLUwV/69OBaWqDj6JBnrFOJq9JUjIP02kgAbDSt5IUaVpO/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3d0bcd48fso20569965ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 05:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753966348; x=1754571148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=399+Wb0FRaCeSxFUAh8KUSIXMYbZIz9r7Bc+x+aJ+F0=;
        b=W3686KmrluUhJx8ZG5DqOvFNHb+xRuvBePzGLwnmUJO+5YNg/E2CnlDGR0mmDxE6Ue
         Tu4f+dTNvVA8LlKj5x5fX5qg1V2/EPQXGF8IP9ICJVvLwyYRUrhvm3o/45wWSsD6GamU
         MlKxH3J7cd01QRSW0/k8nbiuK5VHFAkzL5IjmoPPqUbjsXeVcHLHoSru32h5wITKU5jt
         iy+b6xFIt/9K7kWMzvXWVOENrGny5+mR7B8Tq/CDp1H8Zc/Lo+lAsSzEy9FozRZRYju9
         TzsSnhj582Alko8hu3sBZXWEnpMSjwGzWe2K+cJS5M9y+tFA23nhCPCrLjRm8HMAEBIH
         DTng==
X-Forwarded-Encrypted: i=1; AJvYcCWN/mbGLaxUCli1zAGnQkzX8/skss+EtPLlEh7V86cBJFu3hSPMKDY0xjVSrTQkVJ4LKoO8MZyI0H5pbek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6QRcJxX7Kf02WF8YJ14Pdukmf918/MgH+EkD7zuvDQOgJc/gJ
	k9K0+ozXvu9IT7AtR3A6vXMTuHX3vyp4BecrAvcxMfOWHoGhnM08ZLvQkc8Y7kUjgpY+uI/nB7S
	MmP3xYSMUtMS22giuvs8tlOqov66ejyNRFFfutOtujbw7w8cBBcLXddFm/dw=
X-Google-Smtp-Source: AGHT+IElHCqOHqATHCpjNZ/+BdTbd4ngNPmX+IeQ2w6ywYQCGYxz8WLyPy3MuNQfBqirGD1x0L6eXNNwH/5zL/1uo19FpGrx/VxM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1749:b0:3e2:a749:252e with SMTP id
 e9e14a558f8ab-3e3f60c392fmr117815645ab.4.1753966348159; Thu, 31 Jul 2025
 05:52:28 -0700 (PDT)
Date: Thu, 31 Jul 2025 05:52:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688b670c.a00a0220.26d0e1.0040.GAE@google.com>
Subject: [syzbot] Monthly crypto report (Jul 2025)
From: syzbot <syzbot+list563953ef1f0201d6545a@syzkaller.appspotmail.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello crypto maintainers/developers,

This is a 31-day syzbot report for the crypto subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/crypto

During the period, 0 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 110 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 52      No    possible deadlock in padata_do_serial
                  https://syzkaller.appspot.com/bug?extid=bd936ccd4339cea66e6b
<2> 11      No    KMSAN: uninit-value in sw842_decompress (2)
                  https://syzkaller.appspot.com/bug?extid=8f77ff6144a73f0cf71b
<3> 4       Yes   KASAN: slab-out-of-bounds Read in xlog_cksum
                  https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

