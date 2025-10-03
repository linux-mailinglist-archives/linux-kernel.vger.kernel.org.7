Return-Path: <linux-kernel+bounces-840942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 448EBBB5C92
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 04:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F152619E042F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33D2C0262;
	Fri,  3 Oct 2025 02:02:09 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDF2C027A
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759456929; cv=none; b=kSRQM2sd+vgmr0qfRT4hKQ6ryZ8zrHtQns7F30SofRETMlxvsxzWA0T/PLpg9Zz6+CT+7hoKgY6gskqaTY6ukoVFSZZSK5oV8TtlhlSTQ7kFAZuseKiThajDfCC28TD/JqfTkCP/MYeB/aYyefhOg/RszHbVzvNfMZCvxTaodYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759456929; c=relaxed/simple;
	bh=9vZ07ROU1rEOt7Wf3Gv3iV+TBegZiBlA1p/e9d3bl0A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WBLeFvjvQziNW5ScWV7IZBiZSszduh/mWbl7zKa3qcBbEL79B3nWXGWi+PrWW8MXESrt+L22fG8xQrKQUXOTV5uvg6mRUaHWITnCY4Iy87wYNoMP/emKzzAN+03AK/XPuoCK9x36ja9+7MoZa7SyNvmcMu14UVR1JEDpIaO5yxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-42e6e5c1d04so32508945ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 19:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759456922; x=1760061722;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mi3LfTD/I8ILkkzvNqfq0VxTYgMIPyJeYMPlTy6qrlk=;
        b=BPqkgsfDqSWZRhFhSA1Y4+YuqaA+QhBrl6Z7eqwvSRbqZ060ehYMMcGw1Zv+3K3qne
         yGlcPphoB6afbiIU1sZwYg1vDcLdjZJtrtg22g52gLARiO8iugicEx5pG6ztR+m2zMKo
         tI+aFLz0xQKNyRSdkBZDS2excwJ6V0/iT9b02D2lP4UhbulegBQrv/U6ZQupHpFlUnwF
         rEyF038q5YWwp5Tdhb5HaZ4o3JkvlZmpenR2iw5W0gA9Mj3rEqTDVtL8ABWyQHfJRnB5
         a5ygPL9Inu4zvIvVtG1BPmdFd8J1ekowK0IKLifayW2HcMQRRiY3Nea1KrYD69Oy6ypK
         hIkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMCXa6EBhtCxIjN86yn9+MNHJJpuYPytxXFst3suzmY4vpA0JK9khggscGBC9NHKqNu2JBQPsT53Bsm+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZq5SFxx20V4szkfkKx50lzJbvKLrRCf68uDGEjF4Q4M/3GNu2
	Iuqbp4+5Rlocx+BgNEN5lkJ3M7GTYigIKbOE6XWd/uXDOj0uYL49uRYJXo5FSsePI8Hd2WBpoyu
	XsgyM8B2TTtfNkwa79UAkx/sxIWzmj1DlmQCkcRIdrKwgB8rR4gsTw+ip2tU=
X-Google-Smtp-Source: AGHT+IEYiQijjNOqjOY5kc0rZL95Ch1bFopzeGum1WtpHuHbkFf4XtVx/cf86Uq8nquM/hIJR2SpE/Xr2l5Vey/vllMsAc9a6UQW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214f:b0:425:8c47:13fb with SMTP id
 e9e14a558f8ab-42e7ad6eba7mr15942655ab.17.1759456922404; Thu, 02 Oct 2025
 19:02:02 -0700 (PDT)
Date: Thu, 02 Oct 2025 19:02:02 -0700
In-Reply-To: <20251003014049.2407777-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df2e9a.050a0220.1696c6.003b.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: kartikey406@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         24d9e8b3 Merge tag 'slab-for-6.18' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b1c92f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2bc5f6d89013f5e0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11a49334580000

Note: testing is done by a robot and is best-effort only.

