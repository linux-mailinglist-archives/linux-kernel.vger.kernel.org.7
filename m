Return-Path: <linux-kernel+bounces-852732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AA8BD9BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03D53AD7F3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E513130C377;
	Tue, 14 Oct 2025 13:34:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCD81D63F5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448846; cv=none; b=iDhPDxqWUXO0OA5xjJ+Wzq7s8c5RZx/9y/WW03rdntFMqVSrTdfPxWNrQ2kT40Bs4yA/jqpDZuQ4JWDlJEYVEEE0r18x+54ehki2pJEUhfSCk9ndbW9drbAQVliA1osEQsRH+vwJedkv+PYgnfSZkJ9Pe/Ww3NmEfEfSS9q+u84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448846; c=relaxed/simple;
	bh=Oolezyqw+kvNC+RWO1uqutmHqpU9z5Wcp55o9OelYVg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=urIaHHuEBlWPj3zDPOOUJkPl1LEvmdLtVLT/djsI/R++oyqMZNDeg2UBhXwd4Oh/X8qnwoqwXtUqOSqZ7OJTeehcLdpf+qAp8GL9KY3jvYJYL/ZGXGvKSM6HsUVNKmwQcliq6pAlLZ7iBRkFaDg7zqWV4rd/fh16OnBIAgVROR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42fa6ace903so99317995ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448844; x=1761053644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lluWPSgKsvJDxp8SvDJVrTNnwYAQggcgTTnz8HrJBw=;
        b=Gc5hBeQaPW+iVJRj/6Z0cxMkig+dEs/oK2q6YyJXzwpix4tvUVQD4Kl3z6rIl/GIW4
         XA7T723vukplK3uncjJENhS150hns6ucjW5UfTIwjUyGHZrNzlaQfJI+JXTYUkKT0Fmy
         xpJS8p8MrI3tmD1+OnlwWm8S9QiY9Z61uo60Uv8PPSQjeXYeS6Z7te4IDA5bNSu9MCaU
         bZqSLlRT5xZVBlLSI5ZC3Wi5eV45KktocAAceOSVml/Yb0V+JUq/nWeuob0AG1ZTkqw/
         U1fkh/64o3p5ohlWvG+QYjejdtv55D5ZwtnVOoq3xuiQBYdcaz/PmB8Y/etY/KXAQ3sS
         bPiw==
X-Forwarded-Encrypted: i=1; AJvYcCXyLpv2ejljTZarrIFe1MdXm4CRx6FVNRtcL/XJRwdojSxb5A1JXB95jy4rSa3mVOXbaPTda17dnYhrXL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MC9nwyqeXPRkfFN0fkMOvz0hQaFLlloGI+C8Zr8vePOTpfu+
	QqFgt8qA6oykA0b/QcgBURNKmSW7+Myz2uib8Qy257anoevayRj89B7fnaFOsZuGVzmE3+l0Zod
	t5o7m2sBl0LZi/hKstXdmzkLYStHySzaD+Sbpb8gqubJAoIr4BypjiL5vORk=
X-Google-Smtp-Source: AGHT+IGucV46oB6P2mfvmEcjzDfsoZtk7fur/6WmtFMn2gnDzGLDBRpIamMK/U6EleLdnlIiXACJgvgI35Yh/z7KIl+xW5WnC7SF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:42f:9db5:26d0 with SMTP id
 e9e14a558f8ab-42f9db52b1cmr158682585ab.1.1760448844106; Tue, 14 Oct 2025
 06:34:04 -0700 (PDT)
Date: Tue, 14 Oct 2025 06:34:04 -0700
In-Reply-To: <20251014125319.639727-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68ee514c.050a0220.ac43.0107.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: trying to register non-static key in ntfs_setattr
From: syzbot <syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com
Tested-by: syzbot+3e58a7dc1a8c00243999@syzkaller.appspotmail.com

Tested on:

commit:         3a866087 Linux 6.18-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1125f304580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=af9170887d81dea1
dashboard link: https://syzkaller.appspot.com/bug?extid=3e58a7dc1a8c00243999
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ffcc58580000

Note: testing is done by a robot and is best-effort only.

