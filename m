Return-Path: <linux-kernel+bounces-725751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CB0B00343
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23A948E330F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071272264D7;
	Thu, 10 Jul 2025 13:25:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320162253F2
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153904; cv=none; b=WoJjpdHI21CZPC/HroX6UugVmJe74btjfqUmX4WK4ur8R1Q220+m8jmNBeNE7g4qvMJA1G3XPd3QTYc1eFK9DBNrT6WnQKfZyjBWpczQ6SCHuAxrTVwH9UnjE9S4KAr1HxgB/k0AAj3kTjLDjXbSp1JyfTmav1ZNswpDN9ESITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153904; c=relaxed/simple;
	bh=Lii70f6gzPIDMbKlPdayDzaD0M8RbP62cwJAAwBDR/M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q2d5nwlU+E2gOFqqSY9w8o7KezmpBZxkvYEeXEuFdx1Rx+cxJpcg/y9BbSkPze9kYxs6bmQOTZ3ctv25X1yhOW4fz5hEatEinL5HFSd3QL9hiEuCSXrTbQEJZB+6UEaQWi+2DBXZqbqpDBE5g2yET3DkFTHbCq7/DLy+e81RsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cff1087deso198203839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 06:25:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752153902; x=1752758702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aama51lnbCkKTHQyi2ffhoyVeN2SCyPVHXZxBzf72PI=;
        b=Yv8IYidzWlSYMXtFnyYpEq+iz8S9U552TbdAuueUvkWKTOzGoshwaX49qUlVgCGUik
         SNJtXvx83X4DLhSLPMv8Xhu3fNNjK876ZhJMIPGfSrbMRRiY3bRCOfsRy9Doh/UxOsiS
         93NSb7RjNKXDcrkcUPmrD8eNon4evXIiHYoZs26phgDeiaOnLoJuA8y/+xOECMZA4LYV
         m6cwUHDGy89OoPHvPFtvoESMc4DiPnGXbYbOh5nAGvoRpOoEdpskvHXW7twM+meEQ22q
         QuZea+y/SiSlxmzr9etgkIRKuhVLych2AeG7N7outq7AIos0irTpiEzL4Rww8NK1Y4De
         1E3g==
X-Forwarded-Encrypted: i=1; AJvYcCWUyld0LdKoY/y6jSajx1sKrm3B0sRHMCP2ikRxvOFT7fKvvohCtkOcI6x3ODrrkOniHOOZRv+LdK8Zl6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdYFsJIBpD4xe6JUULzy2kLWm3on0ZH2+ilsksxdM/ZJ6SOS93
	1KuXyew0DpwM9ZZ0tvr++gV8I5x5U312pMUYa34QyRzvN7T+ST1i7IdR5H5MPXDGAwO2d/Z52pk
	UvYegiFKnhyBOBSvz9/d9ZNqEWFRRsgzp/BM/adHzZzbqbjGDyaNtrQjGQ0w=
X-Google-Smtp-Source: AGHT+IFXUIBn8mMj2Jt4loNBOkrjGbseKi8e9RkI8v3/qz31d8HlVZPSq/c64sSl8ndGebn7fMd7catcS4mi0v1CQ8fxJZjzhgGp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:875:b998:7ff7 with SMTP id
 ca18e2360f4ac-8796627b35emr448940739f.3.1752153902321; Thu, 10 Jul 2025
 06:25:02 -0700 (PDT)
Date: Thu, 10 Jul 2025 06:25:02 -0700
In-Reply-To: <20250710125902.3195-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686fbf2e.a00a0220.26a83e.0013.GAE@google.com>
Subject: Re: [syzbot] [kernel?] INFO: task hung in uevent_show (2)
From: syzbot <syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com
Tested-by: syzbot+592e2ab8775dbe0bf09a@syzkaller.appspotmail.com

Tested on:

commit:         b4b4dbfa media: stk1160: use usb_alloc_noncoherent/usb..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14529bd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b49da22b2184ad70
dashboard link: https://syzkaller.appspot.com/bug?extid=592e2ab8775dbe0bf09a
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123540f0580000

Note: testing is done by a robot and is best-effort only.

