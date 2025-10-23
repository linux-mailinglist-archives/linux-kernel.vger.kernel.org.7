Return-Path: <linux-kernel+bounces-867018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFB0C01584
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF07D4E14DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231E1314D20;
	Thu, 23 Oct 2025 13:24:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC852C325B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225846; cv=none; b=iM2VXlrbqFuqsUxfAaHQiH0tkkbF8V6m2ruDbaSAA+rowfJH5p49oiLFtsH4+1bJH7QMG3vOzOHF4hThGQ0OJkUMkUFFZ7se/Ex7C5zNvEjw/xtNl/DF76bm7mOHlu6Y/NWNSH1W7uD/PObpD1qtXSlgiwmpzCCCBwJJK4vQeLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225846; c=relaxed/simple;
	bh=4v9kRLHmHPRxo/rDuZn2MjhUQt8BZhtCIO2+mh29dlc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TvKrconnwH8u8zRls1Bv9TCAA+U7XCWyWmLRNpFgKvJXl9L95GVET7V57NwV+E6pfYxerHHaYllHDe8JJHVHErAiC72WNHl0BLquZHeFl0zUVe+3d2RjfkUuIfhJ7iACLQJiam4nziKkrxcpc3gxOlOiIZu5vrcWOBp2EsPrxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430db5635d6so10320645ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225844; x=1761830644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Rbf5LSo5qbbkJ6qSLA5AxwAP5tPAdCk53EnRchaRh4=;
        b=quM3X7/lVwLtoU1TvMq3RsqfXTrNrv3b7HK/ztdhmVRvu0jr9iD5R7dY21Pzrg7S+k
         1BhSNgukwJ41H0VvKxEc+8qPGI07hVqF8d8lYN2+J/Kf9IaZjGevv65IAwync8DuT8gO
         ZjxptaH7mB61zXtRngqqEGahIsQuiuNsameVcS0zzKdKzO/LGLC8ZB9bJ4wNv+4X+yg1
         70YkzW0ezfMtTb2xnT64Qb1ge7rFawaAqsgnZRybGjmZlmOArokPVmeMPYdLpjkD92wC
         6x0HcCPc2ovbb0X6/nLtRaj+fozx3c/czulWZXYerw13L2G8aJnzgksPtEnoGEatZFSR
         lajA==
X-Gm-Message-State: AOJu0YwWcE5YeGjqm7kveXyyobA8hdHkw9yC/LPUPxqaZqnQvVLiNKKG
	CPic/uMwLMHAFOveBxY793PhFVgoOkHvTxrV/gj8Sh8e6NTQMJa2paMdOhgxcAPJK4pdTKPRE/p
	Pl8FYa13GwRE90ClKgMGC5twq9xYQS+SLjm1R3Nd9/RGpzVE11MAfTtiaqQ8=
X-Google-Smtp-Source: AGHT+IE9TpLhjVH0zokXztZXXb6yKJg6ep/fYiQaEcDsl3T//JbAX+wPj0nOTMlqk8nhZiXMGBh0y8skpjZ3rq3lSIo/r4wgnJci
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168f:b0:42e:2c30:2835 with SMTP id
 e9e14a558f8ab-430c519b57cmr357053165ab.0.1761225844073; Thu, 23 Oct 2025
 06:24:04 -0700 (PDT)
Date: Thu, 23 Oct 2025 06:24:04 -0700
In-Reply-To: <CABGqKE2GOzKZYcFnd3uVq7qWvNVqaavKQNy35PYebnKjMh+sXw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fa2c74.050a0220.346f24.007c.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: ODEBUG bug in gfs2_fill_super
From: syzbot <syzbot+19e0be39cc25dfcb0858@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, nirbhay.lkd@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/jfs/jfs_incore.h:86:13: error: type name does not allow function specifier to be specified
fs/jfs/jfs_incore.h:86:20: error: expected member name or ';' after declaration specifiers
fs/jfs/inode.c:55:35: error: expected identifier


Tested on:

commit:         efb26a23 Add linux-next specific files for 20251023
git tree:       linux-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc275090905d8fd7
dashboard link: https://syzkaller.appspot.com/bug?extid=19e0be39cc25dfcb0858
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=112e2e7c580000


