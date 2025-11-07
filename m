Return-Path: <linux-kernel+bounces-890282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE889C3FB36
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 12:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611121891944
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D432254E;
	Fri,  7 Nov 2025 11:18:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682542BDC01
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762514284; cv=none; b=hjnE2siEW21S4AhjifQwRzvzCGCKVdnzNpWsbFDL35P38vOHkgLAVDdy7rek2P+K9q23gePZoppCDlXR111SDsrNvC9cSjT7MwrQ+eXsuXAcNsv2dr5M9cv4OoJQOl6/S5hg0VBlmcbU+ctX71JVYaWDebPb31BOJeaplopfTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762514284; c=relaxed/simple;
	bh=if0ZDB4OasXDDlWaQnc0bNl+dcouw1erlLPEsSVmJww=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JkbMt/jpN/y5kDdjd8y8XaG+YoJvLj12CmzfO/zcEo01Aw91JukOxZYJw0IM15Ex2Szja7dIsvS21NrX2psElipX/+921/yvEYnqGVs7hF36KnqSTXdJ1F+VmYafoPJfByDqRxZkFUlQ+5+ktDD+ATK/HG0dv55lWFAHKLvRAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-9488163e81cso51094239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 03:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762514282; x=1763119082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZKsYEZDiFXI8Uay+Fih67P6BNMt755M/06Ft9N1qB8=;
        b=Wu4Z0pr8NUOgnSn9BV1tm6F35SxNikovpAwcS6JBGAX107Kga6La+GxF7kfdzBK1yO
         CR7zWcUqDmWDZUZ0yHrGl6tuRwJ+rVzRcs7MDXzFLBuGoTwyAEtKJ7Xa8aVNCZ7qG7fL
         rsSJGq8mBBcUmMx3DRmJ8zfW9YUheEu7r11ykPrfiVgyoc1N5KOODDL1lIRBadAj58YY
         CIzZfnWrBCoe/MZsCgnpPGKqNF8MXwhgpq6l9ETxrHqFAHdqOFggL3Qd7YxV7FjC/UKP
         x0i1MRv04hVNo5qy016QOVnhT16L0sLXsTLWxiHlE2AEA+BpCeOoVrsfhH10TO0KJnEi
         ZPVg==
X-Gm-Message-State: AOJu0YwQcNNOqyAzOyYgz9UZYBWVh71XKeoq5k1vYHdCFCzndT7XoqYV
	5Ne+M/NbAo4z9a0QLO+lCkRCEUKa46L4VDXxKlvCIXx79TyGBOxLuajOtyScmaSVAS1YvxX4N2i
	kCT+WZpfojMtkHHX/emWrxfqv+pC2k3PW7NkmyPV4HpC2yl//P2fqE5vQSKM=
X-Google-Smtp-Source: AGHT+IF7NII11Sdz0p6yi3ddySwiiTXZj13rhk3LTfNhP56Ul8LWw3bfJzBZy7OYPyitCINAbjIJYwQHEDqGPvbD+d067ux0AuGa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fe2:b0:433:2aad:9882 with SMTP id
 e9e14a558f8ab-4335f45bad5mr34069745ab.23.1762514282604; Fri, 07 Nov 2025
 03:18:02 -0800 (PST)
Date: Fri, 07 Nov 2025 03:18:02 -0800
In-Reply-To: <c0c9b486-94b6-4130-b281-8c71f158612c@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690dd56a.a70a0220.22f260.0040.GAE@google.com>
Subject: Re: [syzbot] [jfs?] BUG: corrupted list in dbUpdatePMap
From: syzbot <syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	yun.zhou@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/jfs/jfs_metapage.c
patch: **** malformed patch at line 6: diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c




Tested on:

commit:         4a0c9b33 Merge tag 'probes-fixes-v6.18-rc4' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=4d0a0feb49c5138cac46
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153f2a58580000


