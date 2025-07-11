Return-Path: <linux-kernel+bounces-726862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87490B01222
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D94A5439F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 04:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB141A08A3;
	Fri, 11 Jul 2025 04:28:09 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBDBA933
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752208089; cv=none; b=T8l8JAzqqij1l+BPZJFABSfs4w0gjpKW8bJVgaF4MvQoZUkAEuXhhUB7kc/71G7lCFVqLJa/kHsaxsqL+x/WtI0N6FAztdz/XjcmydduYGJf6FKqzNRKRZ3bBZ3PAa7R53AmgK4w3UBGg8C/OalmDuMg+fZzhkg6UleKOqWzsXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752208089; c=relaxed/simple;
	bh=NvY9guXs5P3gXmOPnwhKNlfQ883gWUSgS17jfFWKcUs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HN3jwzp6ZvPvqZnZaSlAC1vXp8yzWTnT5Wwb7Y/i+7esPU2eFyBl/riE2Po6TS3XkgKC1YRDPtR9j3ZzBqDSDgrAH0EtHXX3+xe8OHkDKq6IBt7W+mA6ko8Lew/e7EnbRGdDrw75nTcgUFJhOF/ErVwDYV3ynVA+7P+jo3fIvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-86463467dddso180050839f.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752208087; x=1752812887;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iChg5Xiq8SYRy5eZqU1B/24VOR1KRhdHUM1AOqDBCpw=;
        b=DnUTPZtT86ox/fTiTj+Lnu4NvoMsz0Y8/3Tb+HitygaYWwb1dALCSRJecYUkmqc/Uw
         96r3ZXM4RmoZKRfvK3nYYiPD9EmY6PGEbMuU7IH6bGMJ5q915Vh6m4gg/P13XJCYUwm0
         6YBN7Q3eOT0gUMEjJol55l37r8gOr9jGFs9LebjQ7OCsh0rk36A0R5ATLIfiredvt6M0
         5T3Rz+vWctA8o8TbwGy9ZhkGUoFq+z0cLQshagd/5w3dGTjJi1dQh+EViAlSOQsgzw49
         v+BMShpaYRHsIXgRDcKXcQwZuB/z88PHNQ7+uljHIreVbHl1vBPXxhr0NIWFYcicxGh5
         r1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiY9Qgdx9wPlkpspjsGLM9Ts71YivGys8GXH5lRV3bNqQWRAyh2DrbwUjLbcpoN3ESvteMwSXMinf9J1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjQgmglD/jIMlllS4AV+JydQToesAFLX6sFeBbGgM2yGppjzFP
	RPBK9XRgf3otnTtTZGCUXl27KTcUDaVLB6UF27gLrbyIF9d+aviyVK/iG3XnJj+Sy1gvISgsmHs
	iG7BDRJhRmD7tb+HS0Vw3SYsDkDifNPsNF4TSSEdGaH6P0frApiOAxdeRP40=
X-Google-Smtp-Source: AGHT+IGJbWqC9rR+uQ8RFAllZqNmaexsvRqP4rKt0ZrvL6W1up4xxMQJzJ045/VuLdsP5QKTR/p4dBOT9j09iw7EURZMynFpqO5q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3941:b0:86d:9ec7:267e with SMTP id
 ca18e2360f4ac-879787e9615mr251332739f.4.1752208086928; Thu, 10 Jul 2025
 21:28:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 21:28:06 -0700
In-Reply-To: <20250711040302.3352-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687092d6.a00a0220.26a83e.0036.GAE@google.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
From: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com
Tested-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com

Tested on:

commit:         b551c4e2 Add linux-next specific files for 20250710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1498ba8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90b2e63e925474ab
dashboard link: https://syzkaller.appspot.com/bug?extid=80011ad33eec39e6ce42
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ef868c580000

Note: testing is done by a robot and is best-effort only.

