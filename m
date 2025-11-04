Return-Path: <linux-kernel+bounces-883995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B4397C2F099
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 03:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E73924E8A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 02:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB87825FA3B;
	Tue,  4 Nov 2025 02:57:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024DA21CC56
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 02:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225025; cv=none; b=OtYVtxSLysDmHsKtI7IGGUNfT77buywz1aB4v3LKtY0150P6rP6Mlt3lusesk+ovHnkyzJPMWavJFjYk5LvcoGgMgq+BFPPcfaMp3F605ZkFGEmDQe09YbU2rGje22cWTJbutkEzhmiyiy1dvLzcVuVrUZf9HCf+0E9f4P0BrAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225025; c=relaxed/simple;
	bh=5lpmeUujflZ9L6tJEK6BBGAXNYjMKVOaZnbHZUAh4SM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bqnt9RftTBb8KoY/s/C+YuHh2nShkgvXtRSUbaJJaLa4DVcKz0q/JQe9/Gk+BuZnI+1HUdtgi4h2QbeJBgaO7rAhvrGW7PW9jEUsotqgnLpU0b6MBYrNaesvVbtMYYvBcEYHaaJLWWi3Nc+M+tkHVRvXYrBLCzEtypDNAjsxpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-945a94ceab8so499409939f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 18:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762225023; x=1762829823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5gKdp9FN5/lQiXfJetDPoZyitdeaW51rcjXSicIOW0=;
        b=CW+wfjoYkreVh+BAemdN5ImvUOiHx+bZOzrJItk8yYg6S5BZZvM+pJ9N6vz6Wp/gd0
         NQI73+j2571lxq4vkNW8bHIw4Jnv4m1a8A4qnIR/B6I0LBhRmL/KHg/r3V/Z+2yCtGDi
         DVUYoCQhJnQT1WkztUps+kGmYAPFDoV431YUPRXtxXFPo9018lHmIkKprpTQIZanwkgT
         wrqiCy/WhVYh2B9hnO4qv/s3lNoz6yL4WuASYeKc6gVaFix4jPZoYmk3xeNJdifWBwd2
         ET8q9slWGGe4lFowCbHBIQiwR5wQog0tERuzusI5/otRvF7lelijUctAMwXt+FaiATJi
         AeYw==
X-Gm-Message-State: AOJu0YzqeWLWVlgvmvUnNg6ri9POWlvV+TDBMgj3lcfxhYJPCrLFG8PP
	zg181XR9GwTRDqJvbdOgeDZsWecysPZRtA6/j1M5/J6ZsLQnYuw9icDnWLgUepnNo3tKEl7f49r
	AypOn2AyvmT5O/AwPXMY2EKAFZqB4LyF3j1/gucGVuU88CU1lQ2OWmZSubYA=
X-Google-Smtp-Source: AGHT+IGXB8iPe4AtIaFsesS3a4gdRZX0QJZfN18WzPoocMlSNOC60KUviBvbRw6BfM0ApyfcBbLEqTzOBgVqu3x7agAnWEft0G6/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6809:b0:945:b09c:ef38 with SMTP id
 ca18e2360f4ac-948229cb791mr2064964139f.19.1762225023155; Mon, 03 Nov 2025
 18:57:03 -0800 (PST)
Date: Mon, 03 Nov 2025 18:57:03 -0800
In-Reply-To: <CAHjv_at+y3YVBCJSEqBXSNMXV0bCpG=A5WuoR8uPxemrLZGv5Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69096b7f.050a0220.98a6.0099.GAE@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in f2fs_delete_entry (2)
From: syzbot <syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zlatistiv@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com
Tested-by: syzbot+c07d47c7bc68f47b9083@syzkaller.appspotmail.com

Tested on:

commit:         dcb6fa37 Linux 6.18-rc3
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16a2c114580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eeb63aaf73b06da
dashboard link: https://syzkaller.appspot.com/bug?extid=c07d47c7bc68f47b9083
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ca3704580000

Note: testing is done by a robot and is best-effort only.

