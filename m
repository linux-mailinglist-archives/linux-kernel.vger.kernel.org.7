Return-Path: <linux-kernel+bounces-889614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C10D2C3E0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8A7AA4EB917
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B662F6176;
	Fri,  7 Nov 2025 00:50:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F513009F8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762476606; cv=none; b=HiY48sndgp40XrNllaTKrxKs0OE5PkHsElfwRo6Qp+EIvvc4C1wAcWhMNujoSY3j7kCczK7qCWTuJuq1+0RLx0l3LMdjS+su9J/C6W1oyI0JsLlMTqLXhS6oEL8dZ1gFITgt3imTXg+Bm2p2jlJXEmSvHzm1++ZGlRGn5Tv4Uxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762476606; c=relaxed/simple;
	bh=/uGxiUpVwBCUN3pD95xApGVngYUG2y+wBWn2neOR9RA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=meQibdGjfm4xdOCyhWfx5dOaHodcAA7O3G4OhT95rS+vnlmbyKMlxQLzcTM+iy9MqaJ5owiv36AiB+tMa3tLJkR+Yi6wb+NU7qQp4Yn52PlRjpHZXPW0z1QheBHix7YCwozILbiaH+eD9kP1SU8wwQA71wlF7Rj8flAzUzoq1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-4332ad10c91so8460535ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 16:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762476603; x=1763081403;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scf9HvGkj6h9nQoDt/eHw462ipN6/I7qKBtgiEBj0/Q=;
        b=q7dPL+6qv2cgo+tIEhvgz9tzvT1y9nF4imFKY0T5UrtDriwOqqjdqIZzJCIjrif3qD
         +gXDmyzwFYQ181NnlMkN5HHDr4FR19nhJ0VGS+c0nuYqLU+GX4w4SaUUGtF0fKWtJCsT
         wopxncaxBtsbkY3KPwhXCkgH84MkdLQbmsP9aHcQyJEpefvTvcunADpFEP0BSLP+IIO/
         GirHS+FVmbBp64tUbpRFcsp5Mf3hadyulB2POFdkbLh1KflqDqatIzlSVM9e129zS+Yg
         zDuJCnNnNK1bOb8r+qPROzewORc7DtdH4oCb6w70nYURG/ZZu2HBHc1Pq0tmjM7RIfv5
         ZNUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkRS6q/5irix3aWG6ITjPnRH8r1MQyLgfOgz3pEMhxetCCTbrd4T6UY+vnXX1eT9Mr99X9YOxVvAQor74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeA4HWLjZXI7GjUaPsqwaWHZYX4IR64h/zYpMCw0WCUScm7F5p
	BG/cev891zNX3m9om4UnKtQifMmsT1Qi9eljRtCLoeHWrRRe4PjADZMLUsIUWE8X7Iox+itueTq
	hPw9KvLFK/V7AOYrPXpMq0EVUi0I72Vseotz2uTqBd3fiV6xBklXQHMo+2LE=
X-Google-Smtp-Source: AGHT+IHnFCEBkoL4JIf5R7Srt0Ir4FqM6VEIhsdO/2foJ1skJV7nN5HJ7sGRku8OoXDZDqtYlhQ4ivlCIsxA9YPSXakQPDFPPEjF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:433:1e74:9a52 with SMTP id
 e9e14a558f8ab-4335f53dd2dmr23233735ab.15.1762476603127; Thu, 06 Nov 2025
 16:50:03 -0800 (PST)
Date: Thu, 06 Nov 2025 16:50:03 -0800
In-Reply-To: <68dad4bb.a70a0220.10c4b.0086.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690d423b.a70a0220.22f260.0012.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] KASAN: slab-out-of-bounds Read in bch2_btree_node_read_done
From: syzbot <syzbot+ba71155d3eacc8f42477@syzkaller.appspotmail.com>
To: eadavis@qq.com, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit f2c61db29f277b9c80de92102fc532cc247495cd
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Sep 29 20:43:52 2025 +0000

    Remove bcachefs core code

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17012a58580000
start commit:   083fc6d7fa0d Merge tag 'sched-urgent-2025-09-26' of git://..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5b21423ca3f0a96
dashboard link: https://syzkaller.appspot.com/bug?extid=ba71155d3eacc8f42477
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16433d34580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e79f12580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Remove bcachefs core code

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

