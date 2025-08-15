Return-Path: <linux-kernel+bounces-771123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F63B28324
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B85C2429
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1812D3074A7;
	Fri, 15 Aug 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1BQUq9L"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26315307496
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272597; cv=none; b=L4uJBpuhnsxOV5kwJY9R7jYa7fSus5aq4FnLLOO4/AgE1qr+zm6N39W9a9pSJu3tprTMMQwD6ancrmKVSSdFRR+o5tAa9iaZXWmCW1G23msU5fnqiJJXlaMUUp4tlmv5DV6zMAXIY8GfIiJGoguVK1sWAvEF1yw4LeuVdN5Gz4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272597; c=relaxed/simple;
	bh=oeSalf/yLwgjR0IO65N9CQyedrwdJmUBVZlN9f6Yfqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Duj8rmfz1fAjhwEXHqx0zqCiG88uU82sC8DSgYe49v1gojOKZkNdkALQZEQYed4QfzfnfoQW4wLpfJiTGryoVSrJDEAx6nB0tSu10YnpRqxpAcjiIB0V/gF4UZTEggXkCB0Eo6eFhgjKdz1NnA7FFuJ2jDSOQAie6UR6FOuPlEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1BQUq9L; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244582738b5so18964955ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 08:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755272595; x=1755877395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buVtBGpVO2qFuCJLRA/MQVbYJ8Cn6PLF5emLFEWzGB8=;
        b=E1BQUq9LmugYF8sWbZ3OA492aA2l+yRZs6vsbgL1tkqK2b2TKPnzAclwAXVvVN9KKL
         J8vmdXdMaEoeTD7xOCigSkg6SUFFiFBIMX7aaX2F8w65K7O6pyRkVdcR5RvEkuvsm3dT
         hPZwzFqj2rvK0CvNRSt8jzTIkCEZxxjY47DS6BIbbm7wpEtvDGwrCIPNyTxw4aZTb3Rs
         jpGTPaH+aTybfyScOCBFJplga6dlsZkmhtS9brzSxSG4CjG+WAeDjw2nhSLIoxcfK1Fb
         6Uqquf9iNadAwOvBlmNWp6JskAgQsBWzIOpIKc7W4MXKEyU2+QHCVt0tP44FSioa8xl5
         ln3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272595; x=1755877395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buVtBGpVO2qFuCJLRA/MQVbYJ8Cn6PLF5emLFEWzGB8=;
        b=IJfzzIpyWa4TaUpgIdto5+9gGmuxsuukbMY6qUHNqBVMYP44pKp49iws7V1wunK9bE
         F23YltWMSZj36y5YfxedvmmmMqUHd1AELdKrWp7st8Dz8q/Kmsk2crrjA3rBG84uh+WV
         kd5UsAoobNinsr8Iodd8AxYr7WNsKBbP0CGxEUYz7BHbJikkfCmKSydfQety0P4kt/gh
         cM9a09kyP9qLd1rQ9SsCldenr6cCdNRURn/5xR9Lo8DgXtASfN1aN+NCNJYSMDAMQM/q
         6UIgReMRO3J/psRluriINhb6KSO271L9PNn07pR8lKP9Wtgr4UJTmuT6fnzls5BSScY/
         3ptQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+hgLVxv1w5Gw9qeF3SqVqE2/S/jEAeGh9DQZ/OZmkWYBrvtmol30Tm8j55awz8G6t89gpo3jVfVTMfKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyINocqPF9f8Nyh0z+SrXrA3eMqrfyaHbVJyxPQoMT3Yc7OWtSu
	CSe1zeLr7izEIYl9oDAcYl28RMHezNL3j3UuL0ufOB3iyLE8oenHuuwNLPVcppI3JkdiiTFP+Fv
	Tgqv5duqJGGtknqeoOTJ8Iol4TBJyV1+hlhALQeCH
X-Gm-Gg: ASbGncsphLT8IKcfjs4gx7clrFqK+eSaJjca7fJv3OCWIndlA4Cl4RI0ofnf+B6lKbk
	mzxdFaeIux5jEuwRluKZY5XcoEaggxdBfnMT9Z3C2AiLPa99Do9lq2auUP0kjWXXpZzaSwABe5j
	ExmNawd9k7bmZsh38Ri58rYJQvSWa3rz/QRsG8HPMFrRh1+9vf/ofwVVt79/5GxLm+sN57HHwAx
	UTQKcMUWgsSdtO2DdqIdbHDPsqHsFy/OXkYo2QTNR72sg==
X-Google-Smtp-Source: AGHT+IHLN1XcC4qoFNA2fwnUs0VOxxNCeh0+rqp1dIs2ILG4ZYpSyxCFz5Z9x+hJrPTx/BfQ3rEN3ennhyaJk7Nlv5c=
X-Received: by 2002:a17:902:ebca:b0:23f:fa79:15d0 with SMTP id
 d9443c01a7336-2446d939290mr42172865ad.46.1755272595233; Fri, 15 Aug 2025
 08:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <689f5129.050a0220.e29e5.0019.GAE@google.com> <b2667c4ebbe5e0da59542d2d9026322bd70c6c6a.camel@infradead.org>
In-Reply-To: <b2667c4ebbe5e0da59542d2d9026322bd70c6c6a.camel@infradead.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Fri, 15 Aug 2025 17:43:03 +0200
X-Gm-Features: Ac12FXwZeTLz5pSIIxD3s3_BO2OVk5Y7yPGqJiF3VA6MqkLXviIJ0ppRoKfOrWU
Message-ID: <CANp29Y7BFtp9YrgzMTJhF1rmF_xx_48zMuCwbkP978LHPazD1g@mail.gmail.com>
Subject: Re: [syzbot ci] Re: Support "generic" CPUID timing leaf as KVM guest
 and host.
To: David Woodhouse <dwmw2@infradead.org>
Cc: syzbot ci <syzbot+ci156aec4dff349a40@syzkaller.appspotmail.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 5:36=E2=80=AFPM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> On Fri, 2025-08-15 at 08:24 -0700, syzbot ci wrote:
> > syzbot ci has tested the following series
> >
> > [v1] Support "generic" CPUID timing leaf as KVM guest and host.
> > https://lore.kernel.org/all/20250814120237.2469583-1-dwmw2@infradead.or=
g
> > * [PATCH 1/3] KVM: x86: Restore caching of KVM CPUID base
> > * [PATCH 2/3] KVM: x86: Provide TSC frequency in "generic" timing infom=
ation CPUID leaf
> > * [PATCH 3/3] x86/kvm: Obtain TSC frequency from CPUID if present
> >
> > and found the following issue:
> > kernel build error
> >
> > Full report is available here:
> > https://ci.syzbot.org/series/a9510b1a-8024-41ce-9775-675f5c165e20
> >
> > ***
> >
> > kernel build error
> >
> > tree:      torvalds
> > URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/tor=
valds/linux
> > base:      dfc0f6373094dd88e1eaf76c44f2ff01b65db851
> > arch:      amd64
> > compiler:  Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1=
~exp1~20250616065826.132), Debian LLD 20.1.7
> > config:    https://ci.syzbot.org/builds/590edf8b-b2a0-4cbd-a80e-35083fe=
0988e/config
> >
> > arch/x86/kernel/kvm.c:899:30: error: a function declaration without a p=
rototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
> >
> > ***
>
> #syz test:
> git://git.infradead.org/users/dwmw2/linux.git f280e5436b3297ebb3ac282faf5=
559139b097969
>

Hi David,

(FYI) The syz test command is not supported for "syzbot ci" reports
yet (but it's in the plans).

--=20
Aleksandr

