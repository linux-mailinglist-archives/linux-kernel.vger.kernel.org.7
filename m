Return-Path: <linux-kernel+bounces-873578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF091C1432E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFBE1A261CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C3130FF1C;
	Tue, 28 Oct 2025 10:45:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78872E8E10
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648305; cv=none; b=Td64pV0NYQ9TyrSNNaZMKxRXZBlKzQPww+cg9KLvqs5Xul65WT0zlprcgkv6dGUPdEloUOd2szTWjXmsQ0MHjUM8vLpoKywDKah/5Oj4XtvXOYTF+LAYQoEtAOTkid/ky9Yvydmd5db6E9xoJ8vXeIx1rk+FuA+64O0WxElg9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648305; c=relaxed/simple;
	bh=YAXTLWbh8RUAaXrU6IVEx7MB3ZLeAsNmj7+lNIYGoyc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RFe/1KRJYTjOFXhdwzSXPdEygb1MhAGHkdOhlcaOntXYgelyJT9X+KvYkrTksLPhImVMSKS0D+ltwJb0+cqdjUzUCDSIWjL3nFmXQ3W33jFqdWyPBjjEqnOEA+QfB7ljAfhO3ZoDXCGGOAXUhXhMd6nGuKeSxP8dWZIheyXlCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-431d84fdb91so171705035ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648303; x=1762253103;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jV4iT0ivpQYQdRZ4x/ZFiJYktuzbR8o6QVV9FuIXIRA=;
        b=ln+5D3PDuf2McJFnd4UbvUGiDN4CBro+9+QUf+Ri5WfSNutH5b+Fltu9M43h2ek/db
         TZw6tE9pdXaUJXjp3kxB1qRwWypQsoHywyt9ExyaerQWYI60Z0BXyxQiF4AnM4u34seI
         8bZ+TtIYcTj+/X21YvTggwe79n/jtmFrxLtBFWQ6hH7g/cACKfeV+/ckE59lkESutyil
         FASUlD6UkkLtFCV3a/+MrPla98pe7l29+AbItkqnPsyU385ups2w11Ei/swEqqObgKUd
         DbFHJWUPLV0hKAtLb++IDlulf/48kC7puydU26nl8IKwrYZFs4DtcW6s+AqfYYJLr2aX
         Ka+A==
X-Forwarded-Encrypted: i=1; AJvYcCWNUrFGW0B1AimrkX6snIovwrRyw+MeJNhDbn1m215Ccs4SCel3E0VxzythL3y+eO3pjKem9z8UGDLejAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLf99owvuF83Pxq75PfAnJHMwq2qtmaEDibWtn61zyim0Pav+D
	nVbqhek+WGxnQh8QF7M/bvGV4Qft/Puev3FUTYHm8aNmOVI6tiTwsQUF25GvFEeICPbzGBjeTpO
	EXnchtbXQEFhSQvcQvCjy0zWrlaeRFFoYVtibVLtIgMStbmca0lAEZ0zBZcg=
X-Google-Smtp-Source: AGHT+IEF8U97np0yA/SGiXhwJHLPRlg/GEiobnTPHUfVsyXTTQrhTWaZy3YoPDI4Eqi50xUubM5YYorDtTEN5MgTjkNhFRvQJXjk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b25:b0:430:cecb:9e77 with SMTP id
 e9e14a558f8ab-4320f8464ddmr45772085ab.27.1761648303169; Tue, 28 Oct 2025
 03:45:03 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:45:03 -0700
In-Reply-To: <20251028104008.88VPQ%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69009eaf.050a0220.17b81f.0014.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_commit_truncate
From: syzbot <syzbot+c16daba279a1161acfb0@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/linux-5.10.y: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "linux-5.10.y"]: exit status 128


Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-5.10.y
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=c16daba279a1161acfb0
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c76258580000


