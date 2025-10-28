Return-Path: <linux-kernel+bounces-874862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0D1C17452
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BBA194E1908
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CA43557F6;
	Tue, 28 Oct 2025 23:04:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE752D8DB9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692645; cv=none; b=HBbjGkknsBuFrVPRp40IXfjClOZuc3YUSXYvzrY9+gLaF+omXSN4VqJacAyWhY0lPGE7Vql+kU7TrkOHXKrJUTZtfHbbthqNmnqoXaBYiQGkACM8t9kXkkId6rXeRYyG1retnL5i6vu4f4kQIfcre0VHs9OepkOK+7aY8sGlja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692645; c=relaxed/simple;
	bh=Zb9liPGGUxWigswYt1TUO4Z2gfa+FYyMum5xgCxTTV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tu479R7tjvW6wAZqUQbCJjjjs1hrIlnhfMQEboE8ZcodV5NCRrLW6TPX9L1dLz9nbIVumobKOWeyGFQrOZjbXlF5xgpAbzJcoKStC75jqJUh+A08mdJ9ujWEBFnPOlvTZwKzukcNNkeupXr99s2mBzP7dICVHZgQ8SYWQYjN4sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430d4a4dec5so251119785ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692643; x=1762297443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjePMj9qNT2heJZlNtAjX8Moeq4qEoInIXqVUxhsa24=;
        b=T+Kna+J//M/z7SRlxt3/1uvTmLzj/tF2W0ZsfkIHcxyqT9rmNjszZ+ZRHAb2ObgIYD
         4qNsP+oZQpDeSwPuFZ7ET2LblU1BnmDraAIiyCj6RnuCZsfmGD8Yu6NjK4OIf1e5UimQ
         uvcTPMxXSGo6jQwKDbxEcsc+/ZHX7MN5ymGqlrFcR2/xx/wWw5R05NGj3UZgrSP9STov
         sgs0jrGqAaFevAxd6Tdaxju1umDoheYTSSPirlqUnMF7g9u9i9bEl66yuVTvkePwsyMr
         c8zVbFsuWpkfYWzLIIEGjSHwnT+q4BtZE9GkoBxRQpO5jri9kdGrWoJT9+Or3c3cJVGL
         4lYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV674l/A/w7+jKPJo4CR0KCR8TddX68yreWRzSIYoWCLBSMjqEX86A0voKTkmIux58injiUcY3JwnuXe08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNh6KcoVbLD2HMmFLstF+gY9bnrqAyopEjy1QVORZpxNyRgx19
	09W5EvYK+y1tKqhw4ApnD7n/uAW45TUGT13IUyt1QU5LJFlg5RWLgIt7Zb7WtRWdSuU9TkzSlEn
	U/cDay3hLBQJTJy3N9G7S5KsXE3ZK8XDSkMaTi3gmPO7RXj4RkUzih3I48ks=
X-Google-Smtp-Source: AGHT+IECwkqfBy5VollFhry4LFzR9HRbUECnXkGwCvBxKYcLUHQG0fiKcKX3QfNSQ9qZ3d58eeaEt5Us8vI61locoedrSs1Isecf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221d:b0:430:e5a4:6f33 with SMTP id
 e9e14a558f8ab-432f902b57fmr13033335ab.15.1761692642979; Tue, 28 Oct 2025
 16:04:02 -0700 (PDT)
Date: Tue, 28 Oct 2025 16:04:02 -0700
In-Reply-To: <334646724.2945137.1761684800659@kpc.webmail.kpnmail.nl>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69014be2.050a0220.32483.01e0.GAE@google.com>
Subject: Re: [syzbot] [jfs?] general protection fault in inode_set_ctime_current
From: syzbot <syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com>
To: jkoolstra@xs4all.nl, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com
Tested-by: syzbot+cd7590567cc388f064f3@syzkaller.appspotmail.com

Tested on:

commit:         8eefed8f Merge tag 'nfsd-6.18-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131d3d42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=cd7590567cc388f064f3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c4f614580000

Note: testing is done by a robot and is best-effort only.

