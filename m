Return-Path: <linux-kernel+bounces-819418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F587B5A06C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1611B26615
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C225287273;
	Tue, 16 Sep 2025 18:18:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F11397
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046685; cv=none; b=KrtsrVKk5FetukPyKxWIahuoVpFRaYvrFd8+rf6XFzks92Vj5ObsY05JVPe4bo7i0EN+zrjPRvaIx/Tw1tvlKOWNNwwTFe+drVhCrkz5O4onNlUt5NX8M8USC/VXn03+j7HzKLXwJlPHeBxHtjHJwIaLiOhHuhkEj7JxQ0EPvZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046685; c=relaxed/simple;
	bh=1RAPhH4ssAlkZF8L2GU4Z2iMnCjOWlqH4PSc3IELGmA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aURlwQIFI6OmhEeXWTM15/VnMsITjtjXZlIVBc/9Tl6xiVX7ZOsiDE05IfI6bGMbNwAAQ55lrK8zs2MaYEVNVMxzN6XR5i15cw93FhW96It673jbO0U61lk3KM1VIVOzgdi46M/SS6PwMSfOoKsZldOrRlxma7OAdridJCwTvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88c2ff21d59so1444401939f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758046683; x=1758651483;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2rU37PJG/RwAlClhGWIfSNoA2jBYu7p5oZH2qtNCwBE=;
        b=lpQ0BmcvL7BChz0vwGYXT/hiL3pv2EQWVZJ72Wi0UasU2TlxHa+lJJaIoQTnD1t2eu
         HjEKY9/Gs59b6cRkSyoaO9cYtsL+NtVz8jGElt5c5PXLoVKJMeq8pGuUxxYaqpGGOJN+
         AFlAD43yqZuMl0a2WrwGzRe5zAdjfpboRMCkq80szRa4ikcyxKQD/t5PBa7+lDJUFn1g
         /J79PwIKM/1QW/PqSP6mrjm28FoVBrrgq6JLJjcPw28q1rUjq/3pDJLbEjRmH4+q/g3F
         CWpm1mSSL4H27fm7KHC8lAuHc6ocY+9r9zHjDG6cQGI5RXSvcQcH1GhBdyXYbSfYFS+q
         Z+hA==
X-Forwarded-Encrypted: i=1; AJvYcCWN0ZrTdmsOX4nRdy6kHm+S6qUiwt6eL1Zr4a29yR8DRbfGxRj/vBFIDHfoHF64X3fjbZ7y8A25s6CIiU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ZIF3OJx8I4qfLc9FS/DNGnXLc5yYDo4G/JPzit7+gZUN8vYm
	qmMyRBmPdTNxmxlRayt8mNz6YunuJbSxXNOt1xGh4dZCdA0udAKH4bsNyYd8RXUsTJ2lrWcJwZr
	bRCkrz4TrfpRqx1kPD6IV8oNfaJ6hiLHf+edZqQTBslZoc2lTTRiU82KK/Uc=
X-Google-Smtp-Source: AGHT+IEE0JCQta35npizPSVTe6sFCWoRUEX9n1n3GCeKWgrL2bjN/I2LJfLEexYuxkFPCyOkGkU33NMtalVInu1mss5FMlOrx++e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1568:b0:406:7c54:9f6c with SMTP id
 e9e14a558f8ab-4209d31bb8emr150067625ab.7.1758046683445; Tue, 16 Sep 2025
 11:18:03 -0700 (PDT)
Date: Tue, 16 Sep 2025 11:18:03 -0700
In-Reply-To: <686aa557.a00a0220.c7b3.005d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c9a9db.050a0220.2ff435.040b.GAE@google.com>
Subject: Re: [syzbot] [nbd?] possible deadlock in nbd_queue_rq
From: syzbot <syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com>
To: axboe@kernel.dk, bvanassche@acm.org, hdanton@sina.com, 
	josef@toxicpanda.com, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ming.lei@redhat.com, nbd@other.debian.org, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com, 
	thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has bisected this issue to:

commit ffa1e7ada456087c2402b37cd6b2863ced29aff0
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Date:   Tue Mar 18 09:55:48 2025 +0000

    block: Make request_queue lockdep splats show up earlier

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D11eef7625800=
00
start commit:   f83ec76bf285 Linux 6.17-rc6
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D13eef7625800=
00
console output: https://syzkaller.appspot.com/x/log.txt?x=3D15eef762580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8f01d8629880e62=
0
dashboard link: https://syzkaller.appspot.com/bug?extid=3D3dbc6142c85cc77ea=
f04
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1009bb6258000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14833b12580000

Reported-by: syzbot+3dbc6142c85cc77eaf04@syzkaller.appspotmail.com
Fixes: ffa1e7ada456 ("block: Make request_queue lockdep splats show up earl=
ier")

For information about bisection process see: https://goo.gl/tpsmEJ#bisectio=
n

