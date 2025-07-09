Return-Path: <linux-kernel+bounces-722554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DAAFDC09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B831B1C24C6B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248BA2110;
	Wed,  9 Jul 2025 00:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3PlKsbNJ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A67FD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 00:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752019538; cv=none; b=a4tiu3wDJMX7Ca7A2tjTdq3pe2Q8z5BnQRfQkPJGR1OWEK147NmWwLJ7+jRvfBS277ERjpPBiBQGk+kpG4NpJsypXbrpHICd5Id9FES6WDLRNQoML9vo3SFtMByn9IG2DVHqlWQLgwY91/wEZ8xowSABPXHyWUuqcUGGZ+AOHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752019538; c=relaxed/simple;
	bh=tPExyhDsvWP3cutbr2HzVarSQYgLxO434w4+6NOKLW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s6UC+WsWttTABJaolxSOmLhneiTBJp5is1n5KZYz2VvlNdjj7HdccJteEnhhji2xDpGeBZCi+EW9chICvkTOwA5Lb00Z22Sb0NgeJEoVywA3I+mQrMkIf22OGkLRdWC+8eNZJhfJszKosF/UxSpg0HHJpZf6qkoe8GVfvy3DvMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3PlKsbNJ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a7f5abac0aso125711cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 17:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752019536; x=1752624336; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWjmIXsiTyzaAn5Fvq7Nu/1reyNyuSmU/HozRGcMIrE=;
        b=3PlKsbNJu+XvOlThQGRRRMXRW2qnswW5n9btldzoEFXmFn0GII7lTTjykAoCme7fF8
         oalOcFhZCXmXoT5HzYYOdMdHbi28QMZ6ByBWGB+t07jmcaO+8Mk/DBbX/zU1WFBbfMMO
         hZdauDjeQD8zwJRjRssLTLxf0wAjghQEJY8Jesn0mwAu+N5+XGUZbvzR3N07yiQcnfsj
         Gry9/xav8+SeAyrf4D2AhJOCSAMFbjcb5PnJgC3+OGcmBOqw4Q4oTdOrqwyJshlXsCKK
         BB/VeQR5gFzHJd9545b7oocI21FQJZ3zbsN0Xq2ANmExjqNpevxnmZmKYZ5EwGrhFV3g
         63LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752019536; x=1752624336;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWjmIXsiTyzaAn5Fvq7Nu/1reyNyuSmU/HozRGcMIrE=;
        b=W67IfgajevRrtpDyOoew2cgu+CcGllE9FMJDhUt5VRUgpAs18zkYYyjDuKenJMC8C7
         l8RrgzIdEE5TJtH9k2Jfa4WUOlcgfrz2mN7I723pmVrPtEc1jbR/evr/1RopH5kJRfeh
         DCIt3jkgfFvpVbrDhGf7p6oVJLc932qFriwaCPbqr5uEgtc6IUODo2sbk/Yxq0YPdLoY
         DxLtqSFMFJhQRNVStmVc/H6CBQkLQTF/LGKOoSV2RkO7W76Z7X0gxBM4ejIOtuQdiqCv
         KPmPUxuLNGTGg8SN0CzdzQieybZMisDZYAklS4Je46p2JdDDbuGsDXxETtEJw6Kh7Nxq
         JVhA==
X-Forwarded-Encrypted: i=1; AJvYcCWWGIGD8J2w+QBIYphN6HQoWwzULOxENkvnHPANuFOf5mphsKGgu9MLbAtGTk+K03DpkcgBt6Q2G4sR1j0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp29SFnHflLu2CwPEI4wWYGiPQ9dozzKCdPBhIbq+Ew44JyGTO
	IkfwCj+F0CaBhxvzy7SuIvMX+EDd0wSuu0HW7wPumSD8vBvKUAXY0xbpq3DrXHENixf9sSUaDdc
	Qkvwb3gwlbISC2dbztnJ1J5hhRhP+NJgjMjZOzTSj
X-Gm-Gg: ASbGnctmV7luL9tvWhVKDhIyyvaJ0Q+/qcY9y6wK9DlZMeQQ77dZ8VUNcVPvy28LlKU
	LtLaEI3Mne0hyC1FssCNksVikb6n51i6x+FYiF7/jgeBwW8V3VS3Af5S/g6/VDBSjX8vDIaqGsb
	Qe9XaJTd8H1RPwJmFc1ldaJNyQ9AfmceyfkvidD0mHGA==
X-Google-Smtp-Source: AGHT+IHY7n+pnCpWvmYBvTTrjFt/p2CigV+mAgbzyo/AY9N+OjnQzJxIZ/GAfM8mkwlkpDMfJq1aaqANRZJpt/HDRTU=
X-Received: by 2002:a05:622a:468b:b0:4a5:a8b7:6c12 with SMTP id
 d75a77b69052e-4a9dcd8571cmr1319261cf.26.1752019535521; Tue, 08 Jul 2025
 17:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <686d5adb.050a0220.1ffab7.0019.GAE@google.com> <CAJuCfpFjLmDRE=3E91279A+diisTgz24+a5D6c+sH8Oh7PzP6g@mail.gmail.com>
 <6mw4p4shg6myw5a677hkvhzytsnfa2e5zb7zpe6kcqlfjglmol@pzwcbowwy2v5> <CAJuCfpGba=tJ=0Zeqz-znHzhxajkjH98RxN4M5Jr6SBbq8YPmw@mail.gmail.com>
In-Reply-To: <CAJuCfpGba=tJ=0Zeqz-znHzhxajkjH98RxN4M5Jr6SBbq8YPmw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 17:05:24 -0700
X-Gm-Features: Ac12FXz0CW4SBrAA1WRZR5__MUBdwP84Q55k8xLxvpsDrGylkCq9MsPwlvZffoQ
Message-ID: <CAJuCfpH=65SBkKiP88CwKPv-zGfTBCRgyHJU8Cz-0K2mKKrCpA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:51=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Jul 8, 2025 at 4:15=E2=80=AFPM Liam R. Howlett <Liam.Howlett@orac=
le.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [250708 18:19]:
> > > On Tue, Jul 8, 2025 at 10:52=E2=80=AFAM syzbot
> > > <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    26ffb3d6f02c Add linux-next specific files for 2025=
0704
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1719df7=
0580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e4f885=
12ae53408
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D80011ad33=
eec39e6ce42
> > > > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a=
88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1124a=
bd4580000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1099df7=
0580000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/fd55699031=
43/disk-26ffb3d6.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/=
vmlinux-26ffb3d6.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72=
bed1/bzImage-26ffb3d6.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > WARNING: lock held when returning to user space!
> > > > 6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
> > > > ------------------------------------------------
> > > > syz.0.22/6068 is leaving the kernel with locks still held!
> > > > 1 lock held by syz.0.22/6068:
> > > >  #0: ffff8880792a3588 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x14=
6/0xdc0 mm/mmap_lock.c:220
> > >
> > > Hmm. I must be missing an unlock_vma() somewhere but I don't see it
> > > yet. Will try the reproducer.
> >
> > The last one was against v5 patches, is this v6?
>
> Oh, good point. Let me check that. Thanks!

You are probably right since the latest linux-next does not have my
patchset. So it must have been reported with the previous v5 version
of the patches.

