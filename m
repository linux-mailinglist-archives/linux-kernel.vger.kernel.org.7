Return-Path: <linux-kernel+bounces-868867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F87DC065FD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77BCC3BD9EB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124E3316915;
	Fri, 24 Oct 2025 12:54:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CA2580F0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761310447; cv=none; b=USaFr+ZkxY8FfESA4Z+AHB5eyieusY9DtphMO7y8Q8y0kyjd4rvn/qOGgyx8qeY4AD69TvLhL2uHAEmGUdNRWUYwI8/CesC5bREsb8cvVuWeiga6HfvOnJLfCfb0BjqZF4uSLZk2vHZGDS6NTIhLPK/AaYDd7URgS7MTowy1mfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761310447; c=relaxed/simple;
	bh=sqco1SkbpPeN/fkoFbx8UUPzur0HT/v60YYHcfVUFVU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gw6gJ1vCsOJl+/ffk7KySqyOJsGkdpyfshGwiRduSSy7Zzgb5SbZbmSWEAbm+IZfmKdcp45CgrYeissdhlCzWPM9Ws9GEXP3AjrUzv0TxBj8M6OfpidQnYCKtwnh4F8oi25dD4IUTgSeoTC7q8Q/KBMVsJJDUxwNhYbau+A6w9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-940d88b8c15so181735939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761310443; x=1761915243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jXfjPyujap8wSrwcOSxEab06xkdmM7r2zrJ/GRA6FPM=;
        b=qHXGOjFjesJn/7lQOQKGeotc7yu+0Y5z/HT56nty3Oe6uWjhdpd7n28gzp5zdx2att
         kHa99sY44n1BK40cOLp29Vk5Q+sOTGNo5rc0PV91n8DOzWW37FPt4qknNPdQj/W9qVZH
         JHYQyuif9tZSTdMPwt/pJTbW9Hs2c4CGeotno/bSUFwGNMefb2yn62bWQCW/HcavXlaR
         3/m5GFl2ddxfOi8vo2tHlXw7fGSSx3NIfvPdqj1NIQN2cguKk82Xb3x98Ruq/b63Fkus
         f5ALMQi8FAq8cAJDi3qMegGYQMfJAFLBKKJYaA6kZtu3R85A3u58Kz4c0twp/I/RT5Gi
         56RA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBO5FzcNGFkYkv4pl9JNGByUc3gvo4YZTbb8IKELXxIkQhrlg1rgXTFEQNpmvZluPpTPeWmScGaNtPjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOHS/oKuf8IHk+zVsLht2iJGAtOA174hq7sfjf47qMrHasdPLB
	bsUnpyPWWc4lCB088EeE1MkOrwvw7nlQuSaduVMJDH++BANN7yG5b517NEc41NMjb/nHndgwrR+
	9+mAyra4kqXuLkFGTF8ZxX729dCTTd/iMqJUKdDGwoF9/6I+LncHotFds6k4=
X-Google-Smtp-Source: AGHT+IGDaNPZGTE88sO51qJBO0et5Z9tEvKa1D/wS67N7q0Z0fayJif6Sj+fttpvPe3U2Dd/Lo5NDowYdscw25LgWLEplWwv0lX/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1522:b0:42f:e334:5ec3 with SMTP id
 e9e14a558f8ab-430c527fc65mr351501825ab.26.1761310443287; Fri, 24 Oct 2025
 05:54:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 05:54:03 -0700
In-Reply-To: <20251024071523.5h4jc%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fb76eb.050a0220.346f24.00de.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_dir_foreach_blk
From: syzbot <syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com
Tested-by: syzbot+b20bbf680bb0f2ecedae@syzkaller.appspotmail.com

Tested on:

commit:         8e6e2188 Linux 6.1.157
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git linux-6.1.y
console output: https://syzkaller.appspot.com/x/log.txt?x=17c17734580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fff88b67220f824
dashboard link: https://syzkaller.appspot.com/bug?extid=b20bbf680bb0f2ecedae
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164eae7c580000

Note: testing is done by a robot and is best-effort only.

