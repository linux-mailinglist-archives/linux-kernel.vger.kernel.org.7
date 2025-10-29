Return-Path: <linux-kernel+bounces-876729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B5AC1C5BD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF93A624832
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4970B345CA3;
	Wed, 29 Oct 2025 16:28:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F84278156
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755286; cv=none; b=GqJXUG4RrDkDzw62jrYDTKyQS+09irdK/HQBhPJ6MG1sdDCOz8EWPTlCFe4XggdHdGV4whN4zEPxmt4ncPhdLs3W3LevlMREyGNEkGHB2FsTiJ/yULaCJ2oAv9fycPqrlQOyRTtzdc6r9f5ToROh9fPwqRBq5ZH1tIVBaUDykO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755286; c=relaxed/simple;
	bh=T95+ENlPecEDWOEdlEE4JdIs91Ubiw7vbOK8TMPlFt0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F7oVTb0d467P7nvhT4inTHiNWMKnpSXfIEZ2BL45+aMO3DgrIgCPi/KVZ8gunmV/wuTZU2MziqDU1QghZJ/irx4ivccoaKazT+emMLfv+252DSVt0LcIhPve+ZAIcF67TRBUHeXSdh2Dj75XtYFq9vARVFHsFRItWHoXJzVwfKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-430c9176acaso1358805ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761755283; x=1762360083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nnyllXfPw7Fz7I8jkpsNYPHju2xpqhbg5RT9nTezGo=;
        b=QQNhn1P1QS53t0uhNXEP9jMdspbaCJmyap5O2MlObCbLIGO21mRvFApLM4hJzx+88u
         SLfoYpyQ3dXhFkP+jqAmAtfhsa5YpX7gMPN3POif7/F9XHDdfb5MZSbaE1CB/EKWbqM+
         6/KuzSpxapKENRONI9SGhGyUt6AdLEYTZZSo08+4ZUawrKWWGuVVtjKfnczGqsvhMQTd
         09ng4Ca0X45PrUFq9lnLULR7AevbK0VZpLnpbbkFmPudO1PI5GWM6BmTlf2WWkfOQ9SQ
         /umgOOMFV2vl263+5Sv70XbR9O/z/9NKIcPvK8ZxI4fNmjgobSJMiHB8lY0i5LrkrEMz
         Dodg==
X-Forwarded-Encrypted: i=1; AJvYcCWxcewE48/J3ToRr2l/7tPpttrfOw2UCWDDKmaAkTotnz+lgXFqWztAgQuoHiMQDb0MwdvAObESYaUXdSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbdy31qX/CVpb2AYItCn8vrTbC30FiX+qk9YkjhueDAxpr42L
	fbBmDsdWuNlYYwuSwD0eFwrjF2cmV8v7Wq8wOqOs9vS1RTzLlL3OaxJw0jI2yg6NQ8GRiqsnleJ
	G3Eim7mWO6yvFcgwx9HQlnmZlJnfBiI00otX0znT5TuHj8MbzhXTODkci28A=
X-Google-Smtp-Source: AGHT+IFI2DRWhYK9wG0SDbHW1OQ0/BBVHRRK5AhUyfapV6RR9xajpaL19JUXk4fQKpNr0sLp/NMhDCusTj5C3Hhi8iL2B7QpvHuV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1252:b0:430:e5a4:6f26 with SMTP id
 e9e14a558f8ab-433011e3e3dmr2385585ab.6.1761755283482; Wed, 29 Oct 2025
 09:28:03 -0700 (PDT)
Date: Wed, 29 Oct 2025 09:28:03 -0700
In-Reply-To: <20251029062743.QhV3K%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69024093.050a0220.3344a1.0428.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com
Tested-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com

Tested on:

commit:         4408a3d6 Linux 6.12.56
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=118dbd42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=52b41b67187b07bc
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11511258580000

Note: testing is done by a robot and is best-effort only.

