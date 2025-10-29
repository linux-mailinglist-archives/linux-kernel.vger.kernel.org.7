Return-Path: <linux-kernel+bounces-875616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E71C19692
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBEB1353949
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6992B32ED39;
	Wed, 29 Oct 2025 09:38:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C9329C4D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730684; cv=none; b=t1sEJBNkrWNmJKuup3yGZ5MqXiVfCRvF0TMRE0nt6iF7dTg1PLPj7SYLXJW32+Oqao8PNjgRSQ3Hv+WjfTH8g/UD7jMvlf9TP7FjATAhAqUOJTTGHGHTSx93P9pH/6OeAUHJCDkLrQQgSzBZtnMH2TvguBhGcKdKxAlXtagiiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730684; c=relaxed/simple;
	bh=p1Ra3tuJOrUrIl6KVoRj7ZzJcUv/Gfufm41mUci2PD0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nqRXBdIWpR7foBBTOHejSFsdjXREIUGUjISt8AFkZw7OYE4jg6lcaj1BGWvWbXbq71OpJm06KAsxciEIzW+jdPtPttz4jxR0f6TMQROA8bbG2IVaJRIv9IDj6//BGmjtMDVrXKQ1qlsOoC2oy5egszPffXG115ewzhatq/ddE+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430d003e87eso252299875ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730682; x=1762335482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPwwyWdhJ+QIIakkGtW78WW1UD5dqRPGfHby8kRgXqo=;
        b=IbjL/OUqQ8cGnH/QItIQdPOD9b4E2o0PAO0TPcA9YDyKLyXaoa07Msm9xsEXBhYJkV
         u7e7stE3HacpH0+nx+vK20Rbcvti3A1e9mS8pyZgQPnoxxW8bBrmtzRJuBH7CWVYPadY
         xzY8M/h85EVunbnTGaJ4s/EjnWrlxOjkUkru05MvyuD+ygK5mjA7yZY/Xhce9u7fRCv7
         lFRWeb9joaamuJK4+MDKyn5Fm1O/x1BJA8N7WjRoBVgp0jfLVYGIcq8CR2fmTk/f8UlB
         97DXMrqy3QivS91MtCiSzx+UzsGTyJ0dq8Xb775/l602dqj0ZibAKsRlgAtbeM5LyOC5
         s0mg==
X-Forwarded-Encrypted: i=1; AJvYcCWiyEHLNaCL20/TOoTxDdSFsar+V3iKQGHo91FPYTe9wDAw3tQUXTcl7gulyWpHctWX5atiuTWIDwPaNkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPDOFFJE5GguYMBSFVKfg4XWAmErO7YocoEiqZ8v4ObYEbJ90
	oqShWcTy2pOShCybIGXLUizS3n/T91eMYfOEKIjwafcLIrCs7FUUwOkIAi/e1CXvjuOoSLJV86b
	zL5/e2z1gbZCyxWpnVxZJODqeuIYRY783mWc9QqcD1mLq8lhFfG6gFxbDlfY=
X-Google-Smtp-Source: AGHT+IEwMAof3HRDi+oh4TGKN8rQZfZUDGQGxMlNUPTrfa9k5TB44wyu1mUznk/vnTY/daZE9Kk0PX9Mt+AMcBfBexIEfRfSfE4e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f07:b0:430:b1ff:74cd with SMTP id
 e9e14a558f8ab-432f8fe127emr34463435ab.10.1761730682562; Wed, 29 Oct 2025
 02:38:02 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:38:02 -0700
In-Reply-To: <20251029062742.zUtLz%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6901e07a.050a0220.32483.0206.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_truncate_log_needs_flush (2)
From: syzbot <syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com
Tested-by: syzbot+c24237f0eee59c0c2abb@syzkaller.appspotmail.com

Tested on:

commit:         4fc43deb Linux 6.12.55
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.12.y
console output: https://syzkaller.appspot.com/x/log.txt?x=14844bcd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=45603f6730eb4fd7
dashboard link: https://syzkaller.appspot.com/bug?extid=c24237f0eee59c0c2abb
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12b7c32f980000

Note: testing is done by a robot and is best-effort only.

