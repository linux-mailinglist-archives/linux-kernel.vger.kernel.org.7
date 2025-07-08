Return-Path: <linux-kernel+bounces-722548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE3DAFDBF7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6689E1BC7DC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEB123770D;
	Tue,  8 Jul 2025 23:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vbzlRsi7"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B4318E3F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 23:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752018704; cv=none; b=B7ENuG5ampS4kKH7VTSgS/TsRgYwpOnvRUZYxVpxTpf/0QVvDAFeILeLgaS6xoYIvfZIew5ziqRtQyXpdoIJBjPLKA8IED7qvxUHUibiJu0+wu8qxZeqNbqZ583DE5XzHxhR+jPgLyoA/CVrboGBc9FWkrZpTK+Jc8Vznppv1Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752018704; c=relaxed/simple;
	bh=SZ8iJbDhneSUywETW4QZU6SNd1bynvnX+q6yB5H83Y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OwHKiF97xOdZp8UoTcZn1TworlXAUPZgnfLHAIGmQMeTmUJM0xudu4o9TkBzAfdHocrniAHkAOC6VCtvgISBCROddLZMntf8S661BAP4kLHY7EaT/LK9syFpfa6T3KYXP9FREsPbjrJnuG43SDXk/ktjR+BpHXo5PFXnFfM/hfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vbzlRsi7; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4a5ac8fae12so200661cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752018701; x=1752623501; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fcogKvWsheYKoq8ewdiLtu7cwyh48ck6nDeYdrXjpcU=;
        b=vbzlRsi7lDK7jgb4Bf2nmXAQ1DK615XGyiVmc2KsJXASFr/31pYGg8sj1CSGwnlmm+
         Mv9TWL4Ya/siJ7SWJa6++bRW+HT4iVHhmxVKqoUBwjDqpNwCkmTsCBiYY+65Dxr17tXn
         NU99OlDib5wS0DKeOr5ogCq7DQBIGJ5/0AJqyDgRhLDqzrnYoly0zZ1BLzZDq5dwPSO8
         3TyVphutiVdiuV6z4nSMuhDVciFCdO6IxbVrtRm/BmLc14JJw29kOeq8OzaCQkQTWxjY
         OdZwmq7GipV9xvUMHmWasrMRDiNWKjnEhi9LRBpe+6ERaEJbuOBQT626wyW6/2Y2ve1C
         BwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752018701; x=1752623501;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fcogKvWsheYKoq8ewdiLtu7cwyh48ck6nDeYdrXjpcU=;
        b=w3418fGqQpRRJWm6I9gV5BSApjkX27jC/vZxaOSYbhLjVTZG1JVkDxzOG3QJLmeyVH
         uwho43p59pZt4XNiSpSy2B3x7kJksuX02nHVdZuClscJxTOiqjDAyYbqbyJguSvMwQFH
         LnNL9ukv/hOmmlFGRQUdzp9VaIRErJo9NGzCcIpezn9NSTUCntNm5unapfKvSF6o4frf
         AScqYYVm/F9+LFi2vDM0P/dpz+Uh+mHJrj7z2FRC11sOkI1fUnr3qzWPtAgMGMfLbwJB
         1KPqwcroOjN+APaYVlkCuQ0MjD8/SUCMT4tWsTeoXBHIGuv95AIWLPIyZa9djHqJ92NI
         flBA==
X-Forwarded-Encrypted: i=1; AJvYcCWKA/b4M2IZgXaLpUFqrVbrfmLEjFHJU+SAeW9dTmqr91/QCFkfWYWgYaxeQQHknS9tZ1bZ/TSrV/PByJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVdsQJZcGShGnCKcxp4Vt17lL0qrtCK7tNWTwLkiL8FwuaadOv
	8ohDaoZX+ze88nE71TbwuwlY7U85SsWJz9ycCs5Auv8IqH75efH5k/VKB7BjCKVQSCn0/LMp266
	J3Qme8Ja1UHUUHXtzyp6xDVG2cVzo2UPPnXTW5Tjy
X-Gm-Gg: ASbGncu9EF3SoxjKJU0tqCfvbjlGtV76xUm+AJYrEvhF8YqlBMCVfHDPRoIviCnFdXf
	UhBOqsJgx5Lx48qHyt4fALhKZVVGp9hoTYEnuULpeFQotjoIpjJI+3xhy1UZWd/06OV8vnpZ3Hc
	G3UmdiTc2ovIsgr2j91YKed3NkUeg4mm3JDNAQSXEhXLcwNh2j9GfD
X-Google-Smtp-Source: AGHT+IH5ZRX1UHL+BsFfEl3cPQK5B93EBscOPBUjTsG2NUTxvohxsio1Dc1gBo7FZrOdHKGC/6m/6HBSMMbKQeOXcMI=
X-Received: by 2002:a05:622a:8389:b0:4a9:a4ef:35d3 with SMTP id
 d75a77b69052e-4a9de1106c0mr633231cf.7.1752018700978; Tue, 08 Jul 2025
 16:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <686d5adb.050a0220.1ffab7.0019.GAE@google.com> <CAJuCfpFjLmDRE=3E91279A+diisTgz24+a5D6c+sH8Oh7PzP6g@mail.gmail.com>
 <6mw4p4shg6myw5a677hkvhzytsnfa2e5zb7zpe6kcqlfjglmol@pzwcbowwy2v5>
In-Reply-To: <6mw4p4shg6myw5a677hkvhzytsnfa2e5zb7zpe6kcqlfjglmol@pzwcbowwy2v5>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 8 Jul 2025 16:51:29 -0700
X-Gm-Features: Ac12FXxa9sXsu1ybpB3tJFLXtDRK1pfBrBFB5o1ZkKawju9k2T2yCdL4OdDSm_A
Message-ID: <CAJuCfpGba=tJ=0Zeqz-znHzhxajkjH98RxN4M5Jr6SBbq8YPmw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] WARNING: lock held when returning to user space in lock_next_vma
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	syzbot <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, shakeel.butt@linux.dev, 
	syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 4:15=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [250708 18:19]:
> > On Tue, Jul 8, 2025 at 10:52=E2=80=AFAM syzbot
> > <syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    26ffb3d6f02c Add linux-next specific files for 202507=
04
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1719df705=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1e4f88512=
ae53408
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D80011ad33ee=
c39e6ce42
> > > compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88=
f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1124abd=
4580000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1099df705=
80000
> > >
> > > Downloadable assets:
> > > disk image: https://storage.googleapis.com/syzbot-assets/fd5569903143=
/disk-26ffb3d6.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/1b0c9505c543/vm=
linux-26ffb3d6.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/9d864c72be=
d1/bzImage-26ffb3d6.xz
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+80011ad33eec39e6ce42@syzkaller.appspotmail.com
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > WARNING: lock held when returning to user space!
> > > 6.16.0-rc4-next-20250704-syzkaller #0 Not tainted
> > > ------------------------------------------------
> > > syz.0.22/6068 is leaving the kernel with locks still held!
> > > 1 lock held by syz.0.22/6068:
> > >  #0: ffff8880792a3588 (vm_lock){++++}-{0:0}, at: lock_next_vma+0x146/=
0xdc0 mm/mmap_lock.c:220
> >
> > Hmm. I must be missing an unlock_vma() somewhere but I don't see it
> > yet. Will try the reproducer.
>
> The last one was against v5 patches, is this v6?

Oh, good point. Let me check that. Thanks!

