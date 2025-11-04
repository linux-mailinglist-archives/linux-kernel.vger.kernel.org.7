Return-Path: <linux-kernel+bounces-884493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E53C3048F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 10:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A588561001
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 09:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D03112C4;
	Tue,  4 Nov 2025 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tY4Qw5zC"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161C1DED5C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762248190; cv=none; b=Fa8mbt4GzgI1OP0JqOzRZ3dIoSPVmc/Ru2RXinQNF0e7V7RrAk9fUl1jm7C+Zn2wJz60f56Jp7oiofiqlJIqZWSofRoI2BbvU91t7itXEyoK2gUxKa8C9lT0fWDbEfdGbw0n1UkPLBaZstKYMw+zP7Z6khDiCGKZYVHy9qZ9MzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762248190; c=relaxed/simple;
	bh=Kl3ymaOvdEorHq/tMtguwV4BY2XHxKvD+d5JmI4NcA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdA7NYXF/YlL7pR6yyvURFV+CVIFhJD/GruWqPNQPULVIj6XWMnnE5vQQwmc2JKdjPlfej4iWx3WuZhIxc8zl1Qcv5sn2HjKpLmsAMN2WKlDtG3vxS9EvVhcZ9XuHlh5x8rrHbTUTKpQoSRq8gXHlR5TzNiLpY6Qu1Z9ICtYcfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tY4Qw5zC; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6504c33afb1so2920980eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 01:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762248187; x=1762852987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uEcY1THHyfzqAcDD0/EuOc65ogk6e82VPZCm7JWUeo=;
        b=tY4Qw5zCGke4wX7tr3I0xG2ky1UINjUxh/XFUfqos3pdtBoT1okR7VUUeGhwH/pXe2
         eq3+BJDZqiuZrkjmd/gSHf8yv9BqjSUNg2RY/OYL5eECInufDU4/6/PVKcd/JWysv874
         9IIDbCcZX9978qJIAoG77R1zXqkLRd2ZjN+j7YqV7cV7Zw6YrUicAG3JqJ4eXjZwBaST
         4iz8F7lHSOcEYU9hn3O/m9MVtqtKeePXW40SLVXxs3y04ZN8WZzKQUoTFHZOx14bhZ+q
         RtQJ/HdAl3AgB1lnZcylVNu6BbFYrk2VFHmHJktQDZ15TUDnta4V16C2s1Cya+86ZSwt
         B9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762248187; x=1762852987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2uEcY1THHyfzqAcDD0/EuOc65ogk6e82VPZCm7JWUeo=;
        b=k+yOvV59hvmadoHxyR5zdz4K2eGlGSxbpRYy8O9sE+8xnoOB5vKk/x/9iiPaejkg/R
         QYzXxCtkTRTIQjVCx+X5CTVSCmmTWcgTzVEHbxvGketg2vso+sW8Y9VgOHDMorcuZJB4
         1py3vtmNb1jnjq9498C1fsiZFNWL5LVP1eFWbzetV3CLsy3nmE0xo3oY4YsEnNDsCCRR
         61cYhqX8Gq22WwTfbC62ZpngWMlmK6xGXsn9Nj7o5mY1XbgllyjQIOoWbD6KC6tZGi6K
         OWSw30oTWBn+6mzfN0IwNWMHTpejmfvuvm0h4nJnxQ5C1Ab6ywB9SqSzzJnD/vANFYZC
         TZlA==
X-Gm-Message-State: AOJu0Yw5VrIGkT/cBP5rAU620ThPvH8YVgyMZwy5JUzpIEf+XsDzQHND
	KzFa66Se6tLgvSG6aCi94XricSKUJvN2eX0qkVNgtwast2rVgUEOE7xCU1fKYhhTagPWll8EEzj
	m/GiFUDRYlkrfQjPnomNYuy59b9x77h7jokkNdhmZI5fnYAQhpyt+ZNGYJ3g=
X-Gm-Gg: ASbGncv6KOzftMAyq3xFdkJm6bzurjfCt98Kms+3Knccap/JY+Qo5dbUSHsaI5izBQO
	DZqgKs49BOydMfSpr9mwDyOiUqnNaP7JOiyhjZC3Ty09AEtuXORri09WSE3nzZw6Z49dWC9OXZ7
	eiUQyfH05G4RI0OUUMzXQpgk2/k28d9x/+4u490CvUi3cpm6HqXA/2Y6Jw21pept+RBa3L8Fgpn
	xNz94HX0+BSQb1LyNuMxoMhHUIqImo28l4XUPse0QbZNG8f7mfdvlyPEbM5lvR32KUrYzPXV+lU
	epn5f/hyR+S1+hWu+ysl1NUgEflfWgofB5Y/HTrszQNJLCIhn61oHZLrP6+v34EEaxrc
X-Google-Smtp-Source: AGHT+IEAsy+Ag+yaItapCExK24GtCcf/j8K63MuNbVIu7hQfCrBcuGDModsryJjrA8zmOkQf1hkkbI/HJmgX9pS7YQM=
X-Received: by 2002:a05:6820:4cc9:b0:654:f93d:fded with SMTP id
 006d021491bc7-656afa9f1eamr1006743eaf.2.1762248187177; Tue, 04 Nov 2025
 01:23:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6909c4a9.050a0220.98a6.00a9.GAE@google.com>
In-Reply-To: <6909c4a9.050a0220.98a6.00a9.GAE@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 4 Nov 2025 10:22:55 +0100
X-Gm-Features: AWmQ_bmGQf2nILT2ScyTlAWpbuk9uek2__b997E7Chd9LCNJiYdk3ZcAgWaVrbM
Message-ID: <CANp29Y4L45Z1OK6mS2rGwHmA-0CP2a0qD7G3NCz=CcbqEFNUyQ@mail.gmail.com>
Subject: Re: [syzbot] linux-next build error (24)
To: syzbot <syzbot+c78a89917a1b7c0fa4c6@syzkaller.appspotmail.com>, 
	rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ rust-for-linux

On Tue, Nov 4, 2025 at 10:17=E2=80=AFAM syzbot
<syzbot+c78a89917a1b7c0fa4c6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    982312090977 Add linux-next specific files for 20251103
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D110f817c58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1cf6c387ad3e8=
e7a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc78a89917a1b7c0=
fa4c6
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+c78a89917a1b7c0fa4c6@syzkaller.appspotmail.com
>
> error[E0599]: no method named `data` found for struct `core::pin::Pin<kbo=
x::Box<T, Kmalloc>>` in the current scope
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>

