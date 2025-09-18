Return-Path: <linux-kernel+bounces-823217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A92BB85C9F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C8027AEAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C58A312805;
	Thu, 18 Sep 2025 15:52:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF392D879C
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210728; cv=none; b=XYlZIQN0nMEVuC5O+0/H5YUbwVV3thNF0elnP6IrtzxM241XrlqBoSC6lPqwffOUW6VP+HIOGyUAd7wgUiILsn8Ic8FEmmJ82bmoDHdMRjTIJruJvk+R1bEUVUGIBO02N707zcsogLpKJWC4Nw4/K/tnL7oZD1rIll7dR90zt2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210728; c=relaxed/simple;
	bh=iSO4jFqbGqp/SMXiHzcHfZ4w5dIyIY8oEtvueueoH5A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PIRyHIGKxjRzmtBvoaIZqYYiCvCmKRKITgkoUE+dUM+HzgMe4XFrsgeC8Iz1vEBQBmp6CVWA0Lo+AO3xGdgXtSb+wIwMMXjfJPHxXCNB+FFFU+hHC8WKrRD1TTfwZZt9arbh4cpXR67izCWDpCm9f19NZxo+etr6uUeVUeHVwmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-424048cbe07so14576005ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 08:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758210726; x=1758815526;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEkgHzQVx1nJY3YTfcVkUHaUjVfk83/UlXuTvnuxo0E=;
        b=Rek/yZoOS9mhMNJbRz2Ee2d009zAqphgHWd6UQVT2NdeDFjvKv+E/d3dyUFOOgzMN8
         xxk4pjdW6iWvt1sFbkgqZITkAjUOXsLGnq9Os+06wEOFxi/uGuyVQW2kH3xGaCOazHV4
         ZUyvH9sEMHRPKoqvqicyda3L7Qf9U+2LIavH0F5xlVRpMi4iwHYsADuWutP0eLIDDYGI
         htuD9wANLTeBzImWLNlWQ7GGxeVBWyX8NKaBVLFR2/2/4clnwhb/Gmp6QsKXWYOfSs5T
         7xkxQFGJjm4+grMgeIjYo4VPTzzv2Q0ieSxihygbdxDpu/1vn0+OuZBIHJCvwH5O2vxn
         zPNA==
X-Gm-Message-State: AOJu0YyYc+ZlT9UONCPkC9oa8FqjqBbPJIWbH0vrVjkQmhxzcdX7SMu+
	lhZ68RO8d5GCFg0LE5LFvBq+VtCxIriBOVrBBSyFB37eXdqVr91f068fp8i+SrawOKbA4neRfBW
	v5j5XiKKsq7uiqz5j2LVfznNKor6OYe6YRqaqgW915lrgy/FRM7YslOcL5ug=
X-Google-Smtp-Source: AGHT+IFCP67oNGuYHaCgDdLqxs32OFjlHpOxDXX7RRhaD+08Ym/nKH37/lRdXe47pT3WNpl/T7TvSPIH49r5JcRshlPA/SsS/6Da
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2192:b0:3f7:8b02:285c with SMTP id
 e9e14a558f8ab-424819ac558mr485355ab.29.1758210725736; Thu, 18 Sep 2025
 08:52:05 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:52:05 -0700
In-Reply-To: <aMwdsFGkM-tMjHwc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68cc2aa5.a00a0220.37dadf.0001.GAE@google.com>
Subject: Re: [syzbot] [kernel?] WARNING in __vhost_task_wake
From: syzbot <syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, mst@redhat.com, 
	peterz@infradead.org, seanjc@google.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com
Tested-by: syzbot+a1a3cefd6148c781117c@syzkaller.appspotmail.com

Tested on:

commit:         ae2d2000 Add linux-next specific files for 20250917
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1070cf62580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d737cfaddae0058c
dashboard link: https://syzkaller.appspot.com/bug?extid=a1a3cefd6148c781117c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14bca534580000

Note: testing is done by a robot and is best-effort only.

