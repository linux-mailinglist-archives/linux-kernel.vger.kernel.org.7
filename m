Return-Path: <linux-kernel+bounces-723885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB69AFEC05
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B571B5611CA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311212E610A;
	Wed,  9 Jul 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nfen3Mtd"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BD42DC352
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071410; cv=none; b=l3Mv9/wqrlUv6Tk2HlUQow/mNb1/GcCnli6WCq5t3HA9Ce06H69Q7gjrX+m3Dfl8qaC87BMP2FCyjlqZE2IpGT53Ip9955F9I3j/ueOeAWoFRG1Hw0mqy7+P2oyw3LUD3unVdbWndk7gfHH1f8aSvvEfyn5oeUqeCcf5LDPWOYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071410; c=relaxed/simple;
	bh=F3dvKncn2pcIja2ECCGGBTnxHyJj8FiOiGOniPMnCxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JTvI29+7WEdiWGOk630afl7q9XDULBPBI1iXOH6d4iSZrHESX16YMGd9O4N8o5DupKK0oUkXlf+fYDf/VSCigNc76W8ygKYRO462e+rruHmRwqvilDadoErVQdbqx87m41E1vItIOVpF7CFA6cs9CJQ9Ze6jA1GkQPBV+lvKIWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nfen3Mtd; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a9e8459f28so36511cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752071407; x=1752676207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsN2p04xZdCA9/Flow0v+8yCuT0IgoS2UP74R5FJw50=;
        b=Nfen3MtdIh4/2DVCM2P8Mp96ie79TCp/G1m+AtJeEkd1SM148/2KFIBjvQK6aQMVvI
         DMgYWOSA8hE5ucxA24UnReC+xomVE533UBXnJuCmaXmEFFJF8Ait1D7cYgjEP1bvhIOf
         xZnHJXtnYk4Q3cYrJUGb8DCwRiQacMR5TQuzR08OzQ+vi/rWLkFxdn4fwYjaIWhBB2ZO
         c0AcjoReYkQ8QSY7b3YSFKXlFGX8/mc8ck3KDC8vR0FlsSkvdmhMzKm4vKUjqZq2eUZw
         +b9t44O50mrgZ/aTJLam+DCLziM0NpoRI08tNYKkPn2d4+ZWE3IYt9g2UiOd1qqojfxr
         gkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752071407; x=1752676207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsN2p04xZdCA9/Flow0v+8yCuT0IgoS2UP74R5FJw50=;
        b=cC2ovM68hksU9DhA2J8nGNaP5Lz8/51IC8+IXaA8GCAikrPtdM1eG+NO7StlZxU7jT
         hin+zgK5TDpirSOCQCt75Yf9LB4J05rRq/cuxV/WoF0Y6hD+tGj88Afl0qg8oJKEUTv5
         adr1/+l4Oc4Lk/VwUZtwok9HmrO9basxpygeifgdsBpVcOXUQ6p62zGj4a2TaFazVzVr
         q/iq5gHrstNOS8kXcfYp+DTblAv9T0DDxuCNqPtQfZqa4Cg0NiJgk4lI24y6e4Rzz+Cb
         FoeoBkHnYJEka/tGE4F5M74ovk2oQk8RcG5qPrV6jElXppPGFwh3A4vogPmwgOGgFFgS
         lu0g==
X-Forwarded-Encrypted: i=1; AJvYcCWYpGugutOdQgaK6NQPxA+Ett5/VMdDCHxse0VyK6gEHEvZ42xe9c551K3mLFugMK0x7AAzBE/dsT648Wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4g7ixVsglT0mldIgj8BfPdmUOLmwacHmM2CLzd9j1Wh5rSe8
	BhNuSGA5kg3lEOy5EctJtaMn7GFq726rMsLNN/958oDXXbt/Fx/Fj+qdrQZfQINYzkMH3qhBWnu
	nJMhlzvHe1yiGGB5aKpWr/GbRHq/EW0qLB8+39D5o
X-Gm-Gg: ASbGnctgRiTgkAEgxhOIBuLDktCBZeg4WABWIRijgyQEuqKchehXvRtYAxq+ZCDPyJA
	FxCo9GW79Gqd/E9aGyipt/c4urn5U6wQj2RUWjWRDc0O0tvWdBphGjE0ACJ1jbKHE0fp45gnOif
	48zO5coBlOj0HWaxZdyUxwYsERLAsX+qKKRgbSZaZn/JjAFHDvXHrD7O4bKqAwipuLxqpGZBeiT
	A==
X-Google-Smtp-Source: AGHT+IE0EP513U77FBBexFDPPbUpG+ODi1BvVoUwbY55dt+VaLPanHMoERER6Fj//NhcsOORwkZOF4XnQV0brwt/rPM=
X-Received: by 2002:a05:622a:a7cd:b0:494:4aa0:ad5b with SMTP id
 d75a77b69052e-4a9dccbf056mr3528091cf.2.1752071406495; Wed, 09 Jul 2025
 07:30:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <686d5adb.050a0220.1ffab7.0019.GAE@google.com> <CAJuCfpFjLmDRE=3E91279A+diisTgz24+a5D6c+sH8Oh7PzP6g@mail.gmail.com>
 <54d2b3a2-9314-413b-993f-19e369910fd8@suse.cz>
In-Reply-To: <54d2b3a2-9314-413b-993f-19e369910fd8@suse.cz>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 9 Jul 2025 07:29:53 -0700
X-Gm-Features: Ac12FXyMdbuUz2QgXg2UV0MB5oPekps69T0zs05LeG-iDLiUTsXFReTy7ELCPzI
Message-ID: <CAJuCfpEjGOQYwYq+xMxTBWU9LgcjXDnc=JKOahP4FyvQn7gGNA@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
To: Vlastimil Babka <vbabka@suse.cz>
Cc: syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>, 
	Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	shakeel.butt@linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 3:26=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> On 7/9/25 00:19, Suren Baghdasaryan wrote:
> > On Tue, Jul 8, 2025 at 10:52=E2=80=AFAM syzbot
> > <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com> wrote:
> >>
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    26ffb3d6f02c Add linux-next specific files for 2025070=
4
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1719df7058=
0000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e4f88512a=
e53408
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=3D80011ad33eec=
39e6ce42
> >> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f=
6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1124abd4=
580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1099df7058=
0000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143/=
disk-26ffb3d6.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vml=
inux-26ffb3d6.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72bed=
1/bzImage-26ffb3d6.xz
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the c=
ommit:
> >> Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com
> >>
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> WARNING: lock held when returning to user space!
> >> 6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
> >> ------------------------------------------------
> >> syz.0.22/6068 is leaving the kernel with locks still held!
> >> 1 lock held by syz.0.22/6068:
> >>  #0: ffff8880792a3588 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/0=
xdc0 mm/mmap_lock.c:220
> >
> > Hmm. I must be missing an unlock_vma() somewhere but I don't see it
> > yet. Will try the reproducer.
>
> I don't see it either. I don't also see v6 being substantially different.
> Hopefully this (and the other report) was some consequence of the kmalloc=
()
> under rcu that v5 had. Maybe it can lead to sleep and when it wake ups it
> doesn't restore the rcu lock section?

I'm not sure. The report says that vm_lock is being held, so that does
not look like an rcu-related issue. I'll try the reproducer with v6 to
see if something fails.

>
> The unhandled vma_start_read_locked() return value I pointed out could pl=
ay
> a role too (in the other report) but I guess only if syzbot would be able=
 to
> saturate the refcount (I doubt?).

Yes, I should handle that by falling back to mmap_lock, however I
agree this would be highly unlikely.

