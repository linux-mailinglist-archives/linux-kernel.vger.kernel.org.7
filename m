Return-Path: <linux-kernel+bounces-805846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EB2B48E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE7F3A4DFA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2075F3054FE;
	Mon,  8 Sep 2025 12:55:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E216304976
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336104; cv=none; b=WTtUpvfRPsx8MKkdPZsJoIF4999l9pMFXTgJtHH1CACNTHx9pYioaxVe73RxjdE91SPUsADjfbqpW342LvA+Mj7UfDsy3UvXu4EZsBXs/hmK2D7HfTmt+8mmyPQTBVUY1mYA8luq0OsqJYh/bjb8DPP5KNbh7sFklszr0s5/fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336104; c=relaxed/simple;
	bh=zcyFjxqRHxIeG+/EVJR7ZE5irtpcteJhHWGT7WnX1mw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aikW6fsgZouJNEo74cnM8ItOnIOxRDR2KaBFccsBVsbCcRR9FjHQ6I1e3tlw/dALGyYgbctnIGsUDDLuWGXSaiOoaGHY8tBpU57ktGjbtEvNMApeR6Xqx2vW4iz/wGA6x6JKLa6CJDktj0yaCzAfUcEBZ+VE0kM3MJIGJfbzNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-889b8d95367so135473339f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757336102; x=1757940902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IT/aaK+szV1uC6Bh7iWAL67U1ZdrLgrTmI3Ir41Jk00=;
        b=qV4A3YP+m1SCWAejFt0FhPkY582RxH2UpQyaZiBMbWOwK6TED1+FywI5GhXbmG0Oj2
         c5+3VvMHz5PCdVifs8wMNgWrPcPLuhauGzDIhEoIEH7ecuEogG2l7OmlwC+0MCn6P07r
         NsP2LbQo0pRLctxj0kWy+tznfFyAuZom3B2Es4JtgD3vN+wQ9WdYBSapIcN7Z/CCs0+B
         SqUTV/7tmY6U2412H/M8xrJEvBWS+HJ4M2pnZbGX94s6PvsLAuVBA5FVjoDYUSPGCXw5
         jxF2zfk2tCmjYKxHUGwViZzzkfzkBSBe2twUmt0S5WMNcKIc1/dv4qnQ4SNtaNPhRtnN
         iD+w==
X-Forwarded-Encrypted: i=1; AJvYcCUD1993sE2e3/H1e5ySNpCeOnQ+vTPzw22zXLtZIEmPi2mNVZsifVndnd4833RXzzX8KAoQpIlwCuOdv7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNIYTEVEE/I+z3YBCj08bSB8VnKOECilC3SESUneltVVOg+g+r
	02DfxceMs9llEdKJke9gOO/hR4fKIRNsMPr/BQpYoNfVQj3Divg3YCP2WY/EEVnqu4NUMhbJK5Q
	ZJ3uvgPLkMhsEJWRJoqm4SjQB6HCIpxiC6o5+Gad3Mi4xfZlGdOEK3qWMSGQ=
X-Google-Smtp-Source: AGHT+IEN9yK4Ht8Ns2kvBpxRlBEMru0d0yWbFDCdN5HbIPUEFtz/kaHT4/YFRiSNhcoZqhc2jun/y/XYuuSyH02yV29PKLjPGuNn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fcc:b0:407:24:250f with SMTP id
 e9e14a558f8ab-407002426a1mr45727405ab.27.1757336102257; Mon, 08 Sep 2025
 05:55:02 -0700 (PDT)
Date: Mon, 08 Sep 2025 05:55:02 -0700
In-Reply-To: <tencent_A10DB8A5C88DC712765D8D5D85191DCFBD07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bed226.050a0220.192772.0879.GAE@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: wild-memory-access Read in __sha512_update
From: syzbot <syzbot+e37eedd918576774ec80@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e37eedd918576774ec80@syzkaller.appspotmail.com
Tested-by: syzbot+e37eedd918576774ec80@syzkaller.appspotmail.com

Tested on:

commit:         3e8e5822 Add linux-next specific files for 20250908
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15e7f962580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a8386ec460437f2
dashboard link: https://syzkaller.appspot.com/bug?extid=e37eedd918576774ec80
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13ed2562580000

Note: testing is done by a robot and is best-effort only.

