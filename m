Return-Path: <linux-kernel+bounces-761142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9CB1F4DF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 16:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E71C17EB3B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 14:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7E2BD58A;
	Sat,  9 Aug 2025 14:12:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E448D263C8E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 14:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754748726; cv=none; b=bsgM6vm6Ujj5ztDS1+RSxYTBdNgtJBuPJ4q47fN5Qj+65veVXJ7IHJzKWLnzoIcMpCNfJCcCRgN2Nx6LxZBjBx0mPYz4lvpVhwj4KJ9stE0nvYKQQtX/Nz7eMqjzi5feKjtUIzzk6dIXbO334G3fVE+LV2pKiw6gZSDdZySJazU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754748726; c=relaxed/simple;
	bh=5XTl3hfM+i6PN4ZwADVuAT0eW5YL7EYH2VQC6mJoZis=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RmVqJFAdSQG++Zm1CtJ/kBbxt/WUEwIYsMojq+ysU3c6ordNaaUzY6K/i8H3qL6snVzE6QQr1uZplXuu1E55j2WefNt5gWscnqLVoDAQxMVlvYTsOkl5Q3Dbf0IFtGcEKTJbydROH6uN/7Oq8lYheOuQkTNVf10UWl7zyZ1wWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e538a3fecbso10419585ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 07:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754748724; x=1755353524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d46NLEbGCYNLGtaOAWCwaD/PrTEZTMI64r4n4YxYATs=;
        b=ToIevGBulisPhD+c2jhc7wcZJh2WR+fNOcIq73JM7AxIyYGD/OvJ93Z/ZnBfRdqpE9
         O7+rmCbk50uKsa/LT/dSJGfxEvJFsQNHUduqQnNY/dhdFjOiPTNeo/bv2NWxxcTowQ50
         iNryCw6MI/Mdhfe3cozUrNaC8Sk5YUvDj1ZXNG6cJ3hXbdure6DAJWjIUwLQRMNpYtjX
         hhQjpwsde7lG6Y/yoEA29tIJaPfksrbKjgNV/TJicd79VxnZJtA3zbgBEAanGv5daG2S
         STPssqbrEBJSbJlPyL3YzbnLSZabQ/jrPXYEQP8QpdP2YfMPGljUUWWTN9RKXNIPjzu1
         2Yww==
X-Gm-Message-State: AOJu0YzH/XEZ8Ag/YwxzTqQpiZcnL7Do35vNe0GkLGNStzjN8HpTJuGD
	WMqtNd+ftRPadggi8d/S2mX74M2ySby8+25n5ZjBGesx+BSEkDI33xNjuKhE1/0h4+t9nmBeSb2
	CtD+XY7BWxmch+BQoShjWU5MN483wfc0VMmRk/bJQ926JFjhYWOAMrdBj5ho=
X-Google-Smtp-Source: AGHT+IFhr5rWJpZrv2FA37kUzChbKB9UDwP4rrYi6P4b5BFiIw7puFs8Pd3dgqz+UiQKtCAuklKNXx/nyghnU/ok9Dl9HlyGPOIY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8b:b0:3e2:9ab4:3ebf with SMTP id
 e9e14a558f8ab-3e5331ca273mr136804555ab.19.1754748724083; Sat, 09 Aug 2025
 07:12:04 -0700 (PDT)
Date: Sat, 09 Aug 2025 07:12:04 -0700
In-Reply-To: <64b5284b-73e7-4ac1-acab-a1eb092e8b16@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68975734.050a0220.51d73.007d.GAE@google.com>
Subject: Re: [syzbot] [fuse?] WARNING: refcount bug in process_one_work
From: syzbot <syzbot+a638ae70fa7b6a1353b4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a638ae70fa7b6a1353b4@syzkaller.appspotmail.com
Tested-by: syzbot+a638ae70fa7b6a1353b4@syzkaller.appspotmail.com

Tested on:

commit:         c30a1353 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11aef1a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e163e02b14cf5481
dashboard link: https://syzkaller.appspot.com/bug?extid=a638ae70fa7b6a1353b4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14075434580000

Note: testing is done by a robot and is best-effort only.

