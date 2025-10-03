Return-Path: <linux-kernel+bounces-840974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B0BB5D95
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 05:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62F34480557
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 03:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A058D2D46BB;
	Fri,  3 Oct 2025 03:23:10 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0ED1A9FB0
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 03:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759461790; cv=none; b=SK09sUDR+WGcK6jsmHQu0I3YVZfNvwvrInI/Sa25r8XlZLJDyhDFiarmrp6/AK+Hv5FEvjpM/7rzVMPvDtShTukuAA/e40Nko42/ZbOWDirTPGHZOkROpXh/m70WyIGDKwy75UQp5cBfWOX0TfDoSaQn0H4EhIwg4mUA8rl/+k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759461790; c=relaxed/simple;
	bh=tw9H4fn5pgJ/eBcgO99HD9x7euNbseYrqRR2vqxcUl4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BStucicJvq5VI5m09T1Ht3qQZy3IW+rHTC7B92xYm0mC9HVMPkr+6ZAiq6yoP6pFoP/jZ/Lb+ZF8CY1BVAzKt1CQlt81UbF95JKOGtWUG1C4+DmP4ojZPYG/RQUkpbYGKogHuxIndgxEyNO99XPsCvd5JAIImfzbzWmfU+9fSd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-927b19c5023so198315939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 20:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759461784; x=1760066584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3foxNAb/lN+yfmnvrrEYyKxv6IxBXjPBTWN6lnghlF4=;
        b=Dr6tOYax6DYfrTawC0Yy2GHEWDApDpC4QdDB8xCnUaHI8xDxkUQaVG9JUiWA4XnU4/
         FL0xcN376TRLq2/11zExq3Bs1ZKxy8NDzvMlI5fSND8EEuXyszvcHwxcQsw6uL+QByl3
         IbT1n3na0A6oYyUj2tX/mcndv/uBW3z9t0lsI7ZTGXg3ngLjaC5bzd1g3Ef0U/H+bnJU
         n3sTG/yMAUPY0e2/MWj9odJeC4QAPg+yEsw3PIfYLQovHRBzsBTeKA8H/PFB5PemuEoJ
         SeeYTCv7eCKrWKZx6n53SdE82BTy7RrFg0+jsnxYh8EUhj+pra/Y01Gw9xEj2IxCzowX
         oqTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU563kRBpReZEypm7DU5991dTGsVQ4YSiw4sioLd45ricQo6UmHaTAGr97hc0NxSZ53qDnVFdFBFeqtmzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/KNABC5cyra7OL5xGcEjeqX0ILh1zKEXK+7SbxLGth4mWadJO
	wFPeuCSBaVjJBuVBQRb7jneyHMwBseeH70S4BltBItHdnhHn0DJi6Dp0QzfbLYFjI3zjOkWGH+/
	04K0ADtJ0IAUc4c0sZLDWSmZuPY3AIYlCXVxG/tdKRHc/lwq9icrCYZFWieM=
X-Google-Smtp-Source: AGHT+IEVmmd4WpwOR7juUK8cAGHBEururVB563eqgQt1naKfhmDWShY/AB5ywjW4g3az7RjLaMFb/TzbIKXAPTfMgI0WdENJARnj
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b49:b0:42d:8b25:47ed with SMTP id
 e9e14a558f8ab-42e7acef89amr18203765ab.6.1759461784246; Thu, 02 Oct 2025
 20:23:04 -0700 (PDT)
Date: Thu, 02 Oct 2025 20:23:04 -0700
In-Reply-To: <20251003030202.2409492-1-kartikey406@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68df4198.050a0220.2c17c1.0013.GAE@google.com>
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

commit:         e406d57b Merge tag 'mm-nonmm-stable-2025-10-02-15-29' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106ecee2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84e81c4d0c0e900a
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120ecee2580000

Note: testing is done by a robot and is best-effort only.

