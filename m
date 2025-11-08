Return-Path: <linux-kernel+bounces-891350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19593C427E9
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C5D04E4D40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4492D3220;
	Sat,  8 Nov 2025 05:55:10 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7628851C
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762581309; cv=none; b=YKFrNbUO+D3u8JKF98gASjqlCxNrDNTaOn8PnaZbtcVEqDroCbWRbyAuRt+zK7g1iIhudlJky5s3azw9T1bH/I1IUnZJeRk6MCut+JiP5JLJjHp9pDYC4B/3eU/3rS1AIOp1h0ua/C37fYGNWH/6bOlNnwwb8s2Io2Ky8f4vVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762581309; c=relaxed/simple;
	bh=sAcJxeAGzbJ3YUbx3XcNgWbvMCTHnxdNS6YqewEGwgo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QKPFFNoizhzWqYAV4kmGt2Mh+NgUEWf1lpXPS1O5FBymNl3VwrXRPn+NeINvLK5ovWhUZEEeaFlf+i8IW+dtTkPVSaVYCOY/CEfQcPsQJy0zu+pfnQVNb9VLIqQE38xr3zYAHXMDWKsIqke2G6H2xshSBWai6Ann4/ZoJv+q/F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-93e8839f138so130686039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 21:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762581304; x=1763186104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajbG+QUBroA7ub4kooOnfBGano7D1Eb6FduUZ+aJG2o=;
        b=Klg2cBmjJtiVswn1ODFUYOtx3ZqhZr97R0nO3MBCsGMRkxri9zPQTt/Hclf/VW2R6Z
         dkz/ww1jovDQLlW4ZMglM94OjDhC5PluM7PJr5hNYpCyiPx07H3n/PicmjyPju4UVepR
         b29NRwwR2l+yH0XW2bnK5+UVfY5Ljp7hM9XJbuZDGR8Ekh1qDzq6Sk4f8vpypfDDPyud
         5W7Wr5wh+X9OLZDMjC575QGXfBjJ3UDhyJahWEdEPbJB1ThgQhVMOThiN+ySoMgdut54
         M+mi7n/gf89HMuiJZRVPwG5bzTb+KmzAc+YK0xsUcnnEnT7EcPtnt71VoQgn3bA3r9gY
         rtGA==
X-Gm-Message-State: AOJu0YyLWmRUkuCNpKV/9q4LaiFNjohxw0K414Hya7/jQTWzBnVUyFp+
	46YBYQKTVhMwpYIOZ8p7c/fpPEZLF/lEctIdu1veXTEQOswNcyAY92gGRZjSPBdC8cw6zl0dypL
	O8kveg5UvKEdSGoyxjsj3OpS6uzrY3DnAkMZx5UInnhfWGBC/xTK5oXXglX8=
X-Google-Smtp-Source: AGHT+IErjeWcw4f1uPvf2VK+rGDADAuYlBq9x9auAh53DiBb+iP50IHDmXi3N3/ureeJ/0vfJtLEPVFbNsP/yDlbAyg0GaWMd4G7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1946:b0:433:51eb:7f49 with SMTP id
 e9e14a558f8ab-43367e38d24mr23598965ab.19.1762581304398; Fri, 07 Nov 2025
 21:55:04 -0800 (PST)
Date: Fri, 07 Nov 2025 21:55:04 -0800
In-Reply-To: <aQ7WfQOMTIDiPBin@rpthibeault-XPS-13-9305>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <690edb38.a70a0220.22f260.0074.GAE@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-out-of-bounds Read in ext4_search_dir
From: syzbot <syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, rpthibeault@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com

Tested on:

commit:         e811c33b Merge tag 'drm-fixes-2025-11-08' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1388b812580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=486aa0235ebabcac
dashboard link: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13dd3bcd980000

Note: testing is done by a robot and is best-effort only.

