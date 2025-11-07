Return-Path: <linux-kernel+bounces-890881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04CC41462
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 19:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4A5BC34EBD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 18:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F623376A5;
	Fri,  7 Nov 2025 18:24:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B282405F8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 18:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539844; cv=none; b=Vy1wSNvjBkapCUdIMn7IdrqpkIHCiUckVZHdxumBp93hN9C5JQJY+Q8bhuwJkWV2uHZEINnsqdMTjwZs/SP+5vv53IyQ/dPA/2l1RJy1ZRvmc+BqGLxOA2+a+ZD+MLfZ1gZeDAOmQ3Wr3S54ys7jyVjGHYUnCddlGgycQ2P7iPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539844; c=relaxed/simple;
	bh=A0zzPJ95fXb0KMUjIe0Cykf/cqitowP81OKJiMksk1A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MLV+qs2zfhs5WIYSQwZ8jjLx80LL2pNM6I5c4GlxeZ1ciZ5+rbdTcCq0lB6QT55Tvin32yiyrnIn/zgq0wqI1uibH843u2jxT+j646gw+37KpBWKeCzm4awniLMWPMuSOMcT4/Kjahz9RgSi7vbmgCDIgiSbuA9rqWZykvcQS4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-93e8092427aso99511939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 10:24:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762539842; x=1763144642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vW34pHysiysVos14jhjVYSX7AcjTObQeQMuKLp05YDM=;
        b=dQ7vryM2jk3WP8R+3yWVdtR+oT21ZKggY0yztwlv0s7E+Noqb5qWnX42q9FPpM+AFR
         JsVa/V9oTaMn3n/tEDariE+Y+ptNL3qIUNGyigOW+xB+9zjnoEWNyWzBf+35OvnVUXfQ
         hACRn4o7ipJ7JRTQPAXKRc88op67aGRglIoTKh7EoqO05qblJ6TTukU0bm/ab6rkcfEx
         X7KiJEH79FjrKkajWiukOis9sDPYoECFuOY1h631mkmzRRYCcnwmBT3MjKHsTuO7yGSu
         v3YyLJ8gSG8lkVhyEGVQro4Ve5IuiwLgqwERQSwo+LQOzIiQS8/vN+MMoFPm+07dSFWW
         2UFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9M/IYwaNa3DpXYd6Upk/ZKEXvXwJcIAhCN1tf1m00W/lkPXIAGfGLzRnZKy0PHbZ5+mDGqpORkMqct2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWExS1mpdvJn3kPeZ54OiA6vs7ragDLuiTOF0XUi9DJnGzXst
	DJDUIRMmppjZXmlbCkgA+0A9z1dSt0PxGfgy8j699/rsV0VU73xHESV3r5gkbCGXsJtqaSRzjq9
	7/huIljDLP/leV0qSon7ccixdkuFttHXv4u4mXATDTJkKm9UopRqtvrBRLfQ=
X-Google-Smtp-Source: AGHT+IF/ev6JtmEiQ5eJLOCv07BIpLLSsnIobs8Bzakdrc2wOM793QMf8M6Xw3OG5mNE8z6YWfnCTQbUPZuAtTd1SRSrUskGtMK6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:180d:b0:433:306e:2c83 with SMTP id
 e9e14a558f8ab-43367e6744dmr5168655ab.28.1762539841977; Fri, 07 Nov 2025
 10:24:01 -0800 (PST)
Date: Fri, 07 Nov 2025 10:24:01 -0800
In-Reply-To: <CAJ9gUkHp+QqiOB+Aegm7Fz01ufDsLseO4VP0TVz3SWWkFSrOwQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690e3941.a70a0220.22f260.005b.GAE@google.com>
Subject: Re: [syzbot] [scsi?] UBSAN: shift-out-of-bounds in sg_build_indirect
From: syzbot <syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com>
To: kshitijvparanjape@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com
Tested-by: syzbot+270f1c719ee7baab9941@syzkaller.appspotmail.com

Tested on:

commit:         da32d155 Merge tag 'gpio-fixes-for-v6.18-rc5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15663812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c594e02a3d7dc77
dashboard link: https://syzkaller.appspot.com/bug?extid=270f1c719ee7baab9941
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ffca92580000

Note: testing is done by a robot and is best-effort only.

