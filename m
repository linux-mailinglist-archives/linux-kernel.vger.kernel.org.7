Return-Path: <linux-kernel+bounces-869921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE1C09015
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CF094E6E9A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F752F6587;
	Sat, 25 Oct 2025 12:19:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEDC2D6612
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761394745; cv=none; b=h2uBU2medf4E3nvdDJGp2Gsw/3WYUVRv+oTXJP6z//aBatp1pGpCK80P4/TlzXAa4mDWoRydIsm2pBaVuL/egcYruoqWHndKLHl1pGIRlsprcWblnVTnOrfhhVsNd+kbu+OewcCfME4c3chz4547k8jb8uAUxc0JxlNdV00HsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761394745; c=relaxed/simple;
	bh=EVlFebBa6swtthoo3XMik13PZNNqhlB1y4EKOTdvLE8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Dqjc9XAoEZQiC+j41xpdJPKLVvsf/QvY8R6v9xvSzzPdeuAiIuwLqPL14fs4xlse5pmSIU6ydYE1Z3PtdZIeAwltwVLz1IAyBiH76OJ31AUT97VxJsMLxkErk51u5TlVK1Io0joOSjtkZwxaVyrmVp0QZr1p4nG0gcXzlikfCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-430e1a4a129so39484755ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761394743; x=1761999543;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=detJ0ZqNeJlrOsDrnLZMjTVhzUl3dolYqWJSe5Y+Nq0=;
        b=CpLEApSHSem25Z5G+xWXjbapSxdV/DgywIUNd4t6a8ylxogGVYMLk9cBWYwM6b2Ia4
         46Q+PQa1Ceuv8BP+jDoeLM5xRYQyD1Pbpemy0A0QZp/P8cI37zrIOin5kv2EKKJPaKb1
         zwYPs/juk7u+RJM4pQAibf6LKTUzmGBLGtXuoGUipARbdfSgsYTeRMXqf25sHRusjvvK
         Phd31k9V0BmVIHp2rrGLAlZ9g+gKmaLqGvM6HOCJcPMvIreDDuVGCR5TTkjwGluksyiG
         9G0BWSkAc/8m9o3ntKNPCQcf1yoisjdod0xaemuwKMfeUrsTrduYW5NNKUdu55jHm5AG
         9y8w==
X-Forwarded-Encrypted: i=1; AJvYcCVSVEcbwBPT6z2lqZ5UZI0C8mBjrcCC6D0S+o7ZiDFiihiBnxqWqIWcPADCc1h+YYbcuGaIXkF8Uvnk7To=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFjezOCzdgZ75OvqY0hvnO77KpdViFtOqdNASXeF/SZ1S4YM8
	5Gjgpbwy7U8+uTg7RwCG95KwFoJxxHSPKGy86DMgB/LF6DFG+pSgYvGaR/Z3A0De7RHIThGrcQQ
	rR3R6mp3JISXsb7JzRnriWwaz7Z6hXary0Ss6EH8+8EJWRpB+2qlxxDKKLu0=
X-Google-Smtp-Source: AGHT+IG0oFMhPB3qHtmC1dmKqk1sRLQIj1ue+TTfk/yvBRc/nkTT76FySFISbYfurl785uiqw6lIns7SAqbjDTDaXjD7xmlkbQv5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f04:b0:430:c49d:750c with SMTP id
 e9e14a558f8ab-431ebed79admr68309205ab.27.1761394742947; Sat, 25 Oct 2025
 05:19:02 -0700 (PDT)
Date: Sat, 25 Oct 2025 05:19:02 -0700
In-Reply-To: <68fc07a0.a70a0220.3bf6c6.01aa.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68fcc036.a00a0220.9662e.0017.GAE@google.com>
Subject: Re: [syzbot] [block?] [trace?] WARNING in __blk_add_trace
From: syzbot <syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dlemoal@kernel.org, johannes.thumshirn@wdc.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.petersen@oracle.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit f9ee38bbf70fb20584625849a253c8652176fa66
Author: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Wed Oct 22 11:41:12 2025 +0000

    blktrace: add block trace commands for zone operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1750c7e2580000
start commit:   72fb0170ef1f Add linux-next specific files for 20251024
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14d0c7e2580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10d0c7e2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f02d98016cc9c137
dashboard link: https://syzkaller.appspot.com/bug?extid=153e64c0aa875d7e4c37
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145ae3cd980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f58be2580000

Reported-by: syzbot+153e64c0aa875d7e4c37@syzkaller.appspotmail.com
Fixes: f9ee38bbf70f ("blktrace: add block trace commands for zone operations")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

