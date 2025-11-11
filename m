Return-Path: <linux-kernel+bounces-895811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 01865C4EFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3288A4E79EA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1F936C5B7;
	Tue, 11 Nov 2025 16:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbSEVh1O"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1F355041
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877913; cv=none; b=GPis3ObiNIIH0Api+J6DEPr6a1UoJ2qB8AqT0AoLy0uCT50v7gJu86iO7Cx9QQGTC4MrZZ4VUjWo/CsWEfXXTErfsKsA14uPbN8n7yhyOr+poCuyXTTd2ESFGzUF5rivh++HCHWzvFQC5O154rUCDFJHKn5bK5vdhtOmyY3tb+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877913; c=relaxed/simple;
	bh=WSs/db8+nhSabxecFzkCzX6InR0ma3FBdaaIZ2kzUpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YkU5JJAQP4/qejgffUkGJF4xMIn+lLDdHwj7IoNMswvEil/+9eURcf9LYGjjCMkbiSCntrMUWZi6V+GJksNzykDozqCeBFu7SQgd2R824npjGCUX+6TWi0TXZHUd1k2yD+P4d6uQ97U+6fg+ip6/mgvYsNEGYDfK5J7wAQRzVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbSEVh1O; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so7226498a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762877910; x=1763482710; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZa3zooHjmwGdeVp4+48ce5dKd796p2blxghBtAzxUM=;
        b=cbSEVh1OeZZoo6FOxXOjQ5h+K/em9KpOlp9APL5omynfBfQ3q1fFIsIdNj4vPWEyN9
         pPi8mwyxxPQFOlKJ5Rt87b1UXbkfkqVO3i2BbcikzkHX2+MHs9lEn93QVLsiCaf53n72
         1C+6tFHRE3U2MGL1NFQTDXwtkVT/hSuc2OSoIP6qYtC/A7H5c/3MTwjXcKnNrKdM7ttI
         1+aYzP//yNBaHM8pG9XJWi8LSpYHGtudMB53O19iEAgNOstlRJUtYYRgT+jBjpHtMvtD
         AIonAKmZ1PitE2KHHt58lOGcB2qKPcB/ddsrwideQnTO7u0aTtczjZac3goH2y0Y/B45
         1x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877910; x=1763482710;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZa3zooHjmwGdeVp4+48ce5dKd796p2blxghBtAzxUM=;
        b=rcj2nzMfs0zzzhtXvgE7sFUIO32zM+pl2C3nE5OCVVf4rcwrHraXhDRqTA3s2D3Wcx
         CUDxNIqHvuuVjb0c2ilM4n5UpLPjMz0HVyNEFdLC1IUA1hvbXcvJVLbJw5Scc95gTILX
         Xxs0TLLV5x2tsPR2KhYoLxa5hoXUZVqqfANMc1BpxU7J+QUvuAucpKvS8eCptHNRb3YM
         a9L5IevCs/VNZ8hMrLtGvcHMcpQVzvkJR10/un8Cmwc1ZcUxV8g7hqn6IBTBlK8r34St
         1UbX4FMMi1pwtvvVOupvpNN7+R6J9HWkI2l22x2j+8yVb05fFuY8AvQFJuQEHkw2q/p2
         x9HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNq+mCVHfSHskXKP3mdHu/QL4OCa9hnqOkky30ntKbLAzXY5xI6jPqMUBBgm2hZP9vbsNLxgmLZRgbBpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVjxjPhkD8fHoDpmxOyJitUtHqz65T0r5eBupHpEjpbvxmtFKf
	qUAJf5b7Cs+4HEH/50cL33w2BEbyZEdp1V8bv0IkPct2LeLyCvlruczalopU7VyJYzAA6hjDjFm
	mI1LWIZbw1gRc+OSh/mMrdaXYCf6llkk=
X-Gm-Gg: ASbGncvMvcnDkz1OJqrD8g1tmf2ZzXK8u6pauxayYbEPsua8JhHx1uhyvlyVYTNLwSP
	RCGg5aW5I2q58NoulqQSrCA2jfKLCYjmqmTCHqgkooYlLnZ2eMPiZKiicOfXJNHHAfWRd2i611Z
	YiXw3+7Nw8qDEpEBMA4JwCi2mk6BxrWJb1CuZUxnKoDiztjnc9EtxPOB2h0E+4O4+nrA52by8IM
	NbQCobutnlxvWw/oDRpMWXVT8RkqxJ5wj1j1zEnlvLmjiBpvB3UogTPfe33sEMuICVBh/B3TJ43
	Jkag85oJTixCSly1G/5j
X-Google-Smtp-Source: AGHT+IGUflb/HrIfwX7os9w4FgoupDHRvKJcM+K+pNSt5ec2cnSHAhxgNhDKHl4asKuAFkHXaTqgfMClUL0oUEmi1ew=
X-Received: by 2002:a05:6402:34d6:b0:62f:8274:d6bd with SMTP id
 4fb4d7f45d1cf-6415dc2bac8mr10438493a12.8.1762877909944; Tue, 11 Nov 2025
 08:18:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69135040.a70a0220.22f260.013d.GAE@google.com>
In-Reply-To: <69135040.a70a0220.22f260.013d.GAE@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 12 Nov 2025 00:17:52 +0800
X-Gm-Features: AWmQ_bl2TBASxhQf6QXwjigZuQ20ctH9V5NouRRx_4-83l4I6XBy-Wo0B5E1vfU
Message-ID: <CAMgjq7B=OizLoqKca3RjeV0h3p0GQ4uen+gDo3=WdAxQ1gfxnw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING in swap_cache_get_folio
To: syzbot <syzbot+d7bc9ec4a100437aa7a2@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, baohua@kernel.org, 
	bhe@redhat.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	nphamcs@gmail.com, shikemeng@huaweicloud.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 11:33=E2=80=AFPM syzbot
<syzbot+d7bc9ec4a100437aa7a2@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    ab40c92c74c6 Add linux-next specific files for 20251110
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f69a5858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D84a798f69f994=
783
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd7bc9ec4a100437=
aa7a2
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/34ed0f0c2fd0/dis=
k-ab40c92c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a781fa106d0c/vmlinu=
x-ab40c92c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/367c75242dc9/b=
zImage-ab40c92c.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d7bc9ec4a100437aa7a2@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: mm/swap.h:87 at __swap_offset_to_cluster mm/swap.h:87 [inline], =
CPU#0: swapoff/15184
> WARNING: mm/swap.h:87 at __swap_entry_to_cluster mm/swap.h:93 [inline], C=
PU#0: swapoff/15184
> WARNING: mm/swap.h:87 at swap_cache_get_folio+0x365/0x530 mm/swap_state.c=
:94, CPU#0: swapoff/15184
> Modules linked in:
> CPU: 0 UID: 0 PID: 15184 Comm: swapoff Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/02/2025
> RIP: 0010:__swap_offset_to_cluster mm/swap.h:87 [inline]
> RIP: 0010:__swap_entry_to_cluster mm/swap.h:93 [inline]
> RIP: 0010:swap_cache_get_folio+0x365/0x530 mm/swap_state.c:94
> Code: ff 31 ed e9 2a ff ff ff e8 a8 d5 a2 ff 90 0f 0b 90 e9 3d fd ff ff e=
8 9a d5 a2 ff 90 0f 0b 90 e9 44 fd ff ff e8 8c d5 a2 ff 90 <0f> 0b 90 e9 6b=
 fd ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 3e
> RSP: 0018:ffffc90003237a40 EFLAGS: 00010293
> RAX: ffffffff821e8784 RBX: 00000000000001ff RCX: ffff88802e633d00
> RDX: 0000000000000000 RSI: 0000000000007a12 RDI: 0003ffffffffffff
> RBP: ffffffff99cad4e0 R08: 0000000000000000 R09: ffffffff82139c79
> R10: dffffc0000000000 R11: fffff9400022a327 R12: ffff8880317bf000
> R13: dffffc0000000000 R14: 0000000000007a12 R15: 0003ffffffffffff
> FS:  00007f3bed90fc80(0000) GS:ffff888125a83000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005640123d7005 CR3: 0000000034d9a000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  unuse_pte_range mm/swapfile.c:2282 [inline]

Hmm, I think this might be also related to the soft leaf entry changes
recently, unuse_pte_range calls leafent_from_pte and passes the entry
from it to swap_cache_get_folio. In V2/V1 of softleaf (which is being
tested here) leafent_from_pte returns an invalid entry if the process
exit / unmap raced with swapoff.

The recent swap table series added some sanity checks and triggers a
WARN if the entry is invalid so we are seeing this. Softleaf v3 might
have fixed it.

Just guessing now. I'll also try review the code again in case I
missed anything...

