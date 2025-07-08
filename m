Return-Path: <linux-kernel+bounces-722449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63CAFDADF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B8F188F9D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E04266582;
	Tue,  8 Jul 2025 22:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBGymk1l"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05535262FDC
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013172; cv=none; b=DKCJhkPBbzJDhexCYwDcmMINCGYlzSiDnb05HSZvncDPiPnZA35F3WXdO0PFXd2PNp1aOEcevm86vdahXOCOb7Owm1FXUQFGVdki5w0MbE7MRlG8XMWj21NLE87XMc0kWqe/q3Y3VSwqgc/RPU1Ro6cJsZDDT9aTCZLJ9Qsp0/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013172; c=relaxed/simple;
	bh=JPvTY25Pk/8o533i7jK2UJpTzyBaTWyww5ytHdHXGLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVO1pAX8WqiFXS5sA3rQ592HKsXO/ZZQZsH0wPzJClpkZNuh5KByz/WkfP94/NQ0fwoOoxz7Y1mbLTqKhpRthmaHaJgcziJJzvi68WEfM+TTufSCfS992laueOPjs1VkMY5Z/1/JIuE8kxDjE+pK+rfakA7YZkU2f7U6E/Q+wkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBGymk1l; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a7f5abac0aso104291cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 15:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752013170; x=1752617970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQzfvEQmQQeoBZSzRvu5cB8BOzN+DkFbRbSnZHuUFIo=;
        b=ZBGymk1lJ9/fAlY1Gnx9XkABDaXWo2ND5meKlTznIgtCy05TXjyEe/iS+vkho2O5vr
         uIdW2xa6SNWZPTaeAbJmvIFkByac2cn/OxqF7PxU6thJyGpHTB8ID41+6Tje9WrTNexv
         ZvDLciAYg/ZzvCffsnn5gjLFn7pouGD872t9XGLjOKSunc/dg77psoKhXc3mvXYZMSLM
         5AVa47+tjJUr0aAUQu8cAlYDGOuhrtJ3E8z/zvEnfJRRRnbFFZtvvPLesZJA/D1OmyMD
         LKJgpJdWTyPraFj9PqlGffvqAYSJwZRZKXzbFS5F/+WVlNpv1GZQJkUmuOHgbv9jZ6gQ
         qQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752013170; x=1752617970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQzfvEQmQQeoBZSzRvu5cB8BOzN+DkFbRbSnZHuUFIo=;
        b=fdcRss0zuI+iX3ZRXjQ4c98sdZZi6wUpmQ58hrftgHYNX785fLfImgIowHxnxMuxm4
         6fpioRSKr0YU0NN1kf+9eqA5IA3jO5n54I61LV9jPhe3NOPyRdiDA/7KIqljBEsrhjYK
         AUCQ65pBppSN+ZVIjkYhrNCG3zQGe/E2+xWBUs+sZZUKlcvn/CZ4s2zil1H3y8SjMDnG
         C1cre3lP0xqQeRHLLFo0QjEF1xqzNJf8sHRZ/MHaE/U7qKmVEKIm5lSPf/it8NRTBHhU
         zbre1fbxTVpUt98JICxZJmPZsAIvi2J/5NOMZxzpi1Rj0F/szFsqD5HwLlF+VVyk3Ntj
         E+4g==
X-Forwarded-Encrypted: i=1; AJvYcCXn1Xb3gNzZyFmG57K349KaLSxRDy4tlfC1yfQSqJqzPYcYbQsrNxIFeWCftYL+0ZY0K3nPCTZlH/pEMGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqyq8Z3o/vRveStlemq1Gi5ds2f7ZOEMjMNm20tAU2HN/SPWoe
	WRsNCbK3jfKKkjK4O6GuOLYbV2VXLu71oRb+ZNnbGQKUfgA98ZP7lX3TSQ7f8k2oa5zL76kbJ2l
	NiG/f4PqdTnEK6CdNk+vnpFDB03aotQ9sN/mCoB/6
X-Gm-Gg: ASbGncsqex1bLAlVSojVh2mHl8GYRc78T6rS2hq+4JXwoQQ+ZCfUmp0U+TtKCa6+IAv
	nENfbnCAHf+eIRpRYneNC5S/71ZGNYo3O+VugM0/quKWJZ+k/WvuoUyD7SweiiNhYr7KcGaP57g
	3wJcYWi78xx9G/s46yKGO574LNv1vRxghQ6bfxx/gWeg==
X-Google-Smtp-Source: AGHT+IHG2ft+82mU4lblk/kURpyiyIqalg6n0naxxMb9IXAk2HUd/IDuLB/JQ70FWQqNoLQqme0nfDl3jJGGZsgCxvU=
X-Received: by 2002:ac8:5790:0:b0:494:b4dd:befd with SMTP id
 d75a77b69052e-4a9dccbe6a5mr1298321cf.8.1752013169391; Tue, 08 Jul 2025
 15:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
In-Reply-To: <686d5adb.050a0220.1ffab7.0019.GAE@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 15:19:18 -0700
X-Gm-Features: Ac12FXxnI-j_UYRq-rnoC8yiztaNSV2yMsuQ4m_MGxvn2-h46mgI8zyEM_qGA5w
Message-ID: <CAJuCfpFjLmDRE=3E91279A+diisTgz24+a5D6c+sH8Oh7PzP6g@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
To: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 10:52=E2=80=AFAM syzbot
<syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    26ffb3d6f02c Add linux-next specific files for 20250704
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1719df7058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e4f88512ae53=
408
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D80011ad33eec39e=
6ce42
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f604=
9-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1124abd4580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1099df7058000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/dis=
k-26ffb3d6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vmlinu=
x-26ffb3d6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed1/b=
zImage-26ffb3d6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: lock held when returning to user space!
> 6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
> ------------------------------------------------
> syz.0.22/6068 is leaving the kernel with locks still held!
> 1 lock held by syz.0.22/6068:
>  #0: ffff8880792a3588 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0xdc=
0 mm/mmap_lock.c:220

Hmm. I must be missing an unlock_vma() somewhere but I don't see it
yet. Will try the reproducer.

>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

