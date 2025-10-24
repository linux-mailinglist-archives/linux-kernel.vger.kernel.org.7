Return-Path: <linux-kernel+bounces-868815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D1CC0635E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31DA3B95A7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC9E315D4E;
	Fri, 24 Oct 2025 12:20:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA90315D3B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308405; cv=none; b=KSOwA7LsSpBfiKHH/rKbJPepUhEVL8qfhWjP0btLCmzfDG6HywgwZAf05jZwatz7gWfadAVkNgwnaEYJM2p/EMGjbdgXpu6X5gwViLXePc6zIRlt9iro8dAxoJ1p9tbYXjwF4ZtqeJ0zkgvSXZ/xiEGxzeFKhT6mgWZE5/esCSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308405; c=relaxed/simple;
	bh=pV9VD6OVCnpKcyOBXDrBgi6lSJgh55ChGYhUPu7mDZo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pas/uJunigytY4Doc/d+U/7Q3/dGc+dZ1HhSwf60I9iuzGN9uOFlZnGklg6+yKanyjz/wkkQLM/ik8xJ1xItVBxf103trOZeyuuzINXMm7ieBrjwvftjC7D/v67l93jMoTLKC+8bY63o/Ilomm4v7LJablaULoKD4b00jKaAXWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e8839f138so189482639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761308403; x=1761913203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsbFTpNbDRo7PrhQXMGRNd9f0AuQgaBz09lPeV09Ers=;
        b=vn5cz0weSriuAkNHvOMqJlyJSrrB5KzEv1zG/ymrnEmWEG9o9Xy3Vz6NxMvYiXjd9g
         6y+fesi+aHDUIlDpA8OH8+pL3gK+ZEJzUCrzScCcOoD98PGvY5+BMKrAt11tMa2jebie
         ucRV0yvqy3n2Az3uGMjK96HutfcOhsioQbNzUQBLIXDRybBpLW7/rbVsOa82xp27a6t1
         9+LN2yXnLuXhleB7D3cf2W9oj/LUeNNrwiDmHIuuDQgPICXMH4c05gu3EORJa4jt4z7w
         zMKwuvr9AcOBwpWlNLXahTvGBaCVM3ntMEZCWdOKqAqrDzudvdZE5zMDVWEX8VJAO/YI
         JfBw==
X-Forwarded-Encrypted: i=1; AJvYcCX3FnOu2aSMJQi6BvAt3fHgen+5w1Y/gmXXF75XRHtedQXurx/wvv6g8FJ/Rf5b4gXfqFvU27MrE9ML0iY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCGBshas2zmUqY5V6egbt6hAdo86pPj/OhnwbM0y80NVjrOmTQ
	16Qsk5MgmPS4SZ9ijv8andn3g2Y87FpvVQUfVYxanuTTbTIHenZ3/4KZfSfRkG0LJyGi7ttw55d
	zg25lvUjLKTcg4q5wsXUwXVFXBTMqKrXUjhe70v6fU3cgreAxzQCLHP0+m2g=
X-Google-Smtp-Source: AGHT+IEx6Te6+TIIbOSyQrq9xowJB1QFJUHtuq4gb0EXEUkDBfOn3EazC7LK1DpWKRFgKcfdDQW25orrDDsiteJf0Rk4x+5NXEzi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3983:b0:431:d73b:ea91 with SMTP id
 e9e14a558f8ab-431ebd3d7abmr26204025ab.0.1761308402885; Fri, 24 Oct 2025
 05:20:02 -0700 (PDT)
Date: Fri, 24 Oct 2025 05:20:02 -0700
In-Reply-To: <20251024071518.x1MIZ%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb6ef2.050a0220.346f24.00cf.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in __ocfs2_flush_truncate_log
From: syzbot <syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com
Tested-by: syzbot+4d55dad3a9e8e9f7d2b5@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=12259be2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e2d28458335b118
dashboard link: https://syzkaller.appspot.com/bug?extid=4d55dad3a9e8e9f7d2b5
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=104eae7c580000

Note: testing is done by a robot and is best-effort only.

