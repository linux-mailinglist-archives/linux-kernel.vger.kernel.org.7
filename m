Return-Path: <linux-kernel+bounces-738240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAA3B0B640
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A5E17AE34
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CA41F4180;
	Sun, 20 Jul 2025 13:33:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDDF149C41
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 13:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753018385; cv=none; b=b4lY3dX1b3IsEZOMVnzUwHRO1K3Ep1jq068L1NbX5jAzH6lVm7ga2YK1hVZDbD8uywQIlyk0ZtamG4h1/J2uFzvVCtmOQ/W0WxNxAODzNgzdzSig6LxW4VoSuyM1p9dgMLfD1ARzo9W3UuV2eBmiF01lmbWqmQwpk4nQZbtQRoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753018385; c=relaxed/simple;
	bh=hiadyt6JiRHKKPeaNbaz5kGv0eXF2X4V7RwiBqCUDKE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=adP2RIHM2k5ZKGgMbGv/ROlSqVM/W8Qp65ZGztfj44E4SctdlWFV6+Or5rRe5Yw6Msgt3i/gE7VoBMLQYiK3Rj1Vs/TFiPfkZrODSnDcS3csbFdxSWXGGdwtB4yH3p/Yh89j8Q51g275V1unyGYhLQyRLbzbj8Delhe5OcCiWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3ddcc7e8266so44824625ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 06:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753018383; x=1753623183;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEPLNc+uW1L8mXsEcE+3SJcG8i3IDrc7XAfrgDWHR3E=;
        b=D0UrvXeXqGb6pLMJ48js02SxVkVSJ3Qt+Pb64WLFGdDMdj+8QRRbFtjA2lcnkqAr4m
         6LJVfXMX38lH4Q/Km6n9kRLOiVI5GzdPgILZ3NTSuRvWxXPlziVxinIVcROXdMp01MJ3
         NWipaFVM8qlgZzuUBDRW5mJpTF5N5hJ2Jhgbm4K1dCxafYniPq7edQ88mGGeDzLqE4XI
         cQ/ONlsy5wlqAECST+sRnGijNpYlffj1KTYYhwk9vjVqpbUE6JXh4xr6/NmWjfyxn+mk
         GbK4vnr2PZP+ohnwPqsGcy+4Wr4xcez04yXoOoDxd38GbeCqxKgxZuVXD05o8lhc5VwK
         7xzw==
X-Forwarded-Encrypted: i=1; AJvYcCWWbBwVi6pgn2t0LZA+hm57YBZDqlhovqvyy2aroJiCCPstYSDnGLkZNm49gmMpY92f6ZutxguVbO1Sv64=@vger.kernel.org
X-Gm-Message-State: AOJu0YzycPvbJ1XHjAgeu4GdHyRxn1fCq5V1vzuvsXpzUJvIZr9YAJtB
	HL0v4QDF52YyQ8KrgQfD+ieFOqrNr0NXWlret84OAoTHQYdOSmBGaXh53pHZciZ07ECxCuxUghw
	wgKSFJUPF3+M9isZrhHqfjWWx5/mYSGChS3PNu0a3FD2mLAAmSiIV1SGbTxg=
X-Google-Smtp-Source: AGHT+IFN/a7rk4RMZ5ezNaybTM0CicPgG3FdrMd19t169LMXbn9w3qAsF0VojC38rPQzMkgAtcagQu8xCrh/IrjBseGWVwFOpX4X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2196:b0:3e2:9f30:c05f with SMTP id
 e9e14a558f8ab-3e29f30c214mr46710155ab.5.1753018383423; Sun, 20 Jul 2025
 06:33:03 -0700 (PDT)
Date: Sun, 20 Jul 2025 06:33:03 -0700
In-Reply-To: <67eba499.050a0220.297a31.0009.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687cf00f.a70a0220.693ce.00c1.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_iop_getattr
From: syzbot <syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com>
To: axboe@kernel.dk, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	ming.lei@redhat.com, syzkaller-bugs@googlegroups.com, 
	thomas.hellstrom@linux.intel.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit ffa1e7ada456087c2402b37cd6b2863ced29aff0
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Date:   Tue Mar 18 09:55:48 2025 +0000

    block: Make request_queue lockdep splats show up earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12d9a38c5800=
00
start commit:   bf61759db409 Merge tag 'sched_ext-for-6.16-rc6-fixes' of g.=
.
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D11d9a38c5800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D16d9a38c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D415e83411fefd73=
f
dashboard link: https://syzkaller.appspot.com/bug?extid=3D4bb2305559463e8f6=
a2a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1242b7d458000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D12b6238c580000

Reported-by: syzbot+4bb2305559463e8f6a2a@syzkaller.appspotmail.com
Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earl=
ier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

