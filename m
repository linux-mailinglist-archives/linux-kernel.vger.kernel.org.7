Return-Path: <linux-kernel+bounces-683127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9433AD6958
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 09:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0A03AF20E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4FA217704;
	Thu, 12 Jun 2025 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qSfwi0d/"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B94214210
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749714166; cv=none; b=MyIMpbJgD7xaXAP3GMv4GxFssG4CbzmJovQvzls99d1plXsLesIXciidlZwauIrr5XYCM9Fyu5lXLKMk6hm7h3WpTj4F7LfrISEbdTziWG7EBDgUh9zbXtPBH9WbVIlKTYiQRfd7h3yxvG0n7gjqLJcjQo0H8MWM+nBtCr3FNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749714166; c=relaxed/simple;
	bh=FOQXFaiVwO7dhrkbgNrBD2ORgwbO509L3NsVRqNVEVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/l8Dvb8sI0IAgSCxX9AWMKTFbrpEgC5gc3jFyYqnR08i3Gs9m6DnfGMq0H15INz7oUQ2u0Vu4Rd599v49kakK/99qRHkhJREgzbUnZuixkXGz/gJva4or9cur6iNwAZVz+naiy5xt+Rpty6AEPT2ZC//149iTIyEuVh1wjb9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qSfwi0d/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234b9dfb842so7068785ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 00:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749714164; x=1750318964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EqLSwnInI7/pMnd5ysWVbRy8uvQJPmZ91Nx+44JVcw=;
        b=qSfwi0d/Q3YbWvcH3abb1v/U4sMurxcSDSPjzXYbk9+9XLnPnMqcWOdFvWBKXeuTJh
         we0gKNyBP98BZgrPB95VV0h0rYKWa9CGn8XdT4Rk9dcBzdEHWFelLNqqgScxykOZ4DxU
         JUdnxG1+9y4Ag688nCexDNbFLcMCHyLDRqAS+yBs7hTcf1+LERbQZcCYubXXrIYecghG
         Fh0IWJV+q+E8EoTttE7T7YfkhDC7NidUrwsxud42A16rdeFzVKlV5wOmsF2mFOBpg8Pd
         Q2xv59/MFuuMgh4/DwQpsEkXIPeUwbyM7SrKK4CSsgKG/3+Q/KjAOL7564o8HhiZ38IE
         jOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749714164; x=1750318964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EqLSwnInI7/pMnd5ysWVbRy8uvQJPmZ91Nx+44JVcw=;
        b=m7C8yTDRw2/QwAVq5ja8vTuAzbhdXdnox72YObV/eXw50Ow5UGFJ3Z1Y+f8MxsxD3R
         MxPnRfocWCAbhC5HAmJQQ1k9m491jawL+9dVTs3q+T5KLDeETxLaTyvqebH7ySw3P4nw
         7n585v5DWtz6iqGKs4VodeItLO+m93of2LSK9uwsQYYJX0HmrFI3ZJJL2M6Ij+MUrhb8
         n07i714kKRkxbPi8KYeeQe+nM6qiYrg35GJmNYtpAoE1EAClUxS3tw0u8L86+9m9kTqW
         yd5SFRq9QnyIMvEGYv2oXx8a1wbXwj91zsLAt0fZ2KENwU1kXUl53IvRJDcarAyxinqi
         voog==
X-Forwarded-Encrypted: i=1; AJvYcCUk4XGKIK+D/eWCquagtlRBXzbdZiMMaE1ySLM37TNlDjQXduDWD4QumA890Dvo8iWkPiC2UtMt+fMBe2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rJ63GD4gIOiw+G+Ke4gmgV6IyRXMX8qOPqHtVFPCfzMRpOiX
	9BcliG559pdHy+788zm4ZNSpF+6y6jByNudGuGasinV3VUg0D3BVvzDAhrC9DtkM/3TtQsgdrg/
	hJK+rSvCE0oPMI2tjOJwAyusRJJY+UwhfFGYOp+Bz
X-Gm-Gg: ASbGncte3+G88hToI9AJoE3PDBySyrqgY900fC32mG7CYg6K3vP+jgOT5qK4byxJ3b1
	7rWHifK8y1aaaZVDeDmHwjG1QE53SHCSyRd4apD3vUffaK2OAJVAwIro9C6t11pi/nd7/dBWFzs
	IrxnymDdAZalG4Gfr2egOC0uBJ/XC0fbDiPIENHMxtgv111wtOapGNnWRqT4KsrBrCMdm4fydAa
	w==
X-Google-Smtp-Source: AGHT+IHWfz6ueRsBMvrL8ANKlYfntcz1uoa4QJR1XOifNxP+96m170S+IXM1efDQIk8mUoonHiE6qKHXDmQCeffxrW4=
X-Received: by 2002:a17:903:2448:b0:234:c86d:4572 with SMTP id
 d9443c01a7336-2364d8b7d4cmr29659685ad.30.1749714163932; Thu, 12 Jun 2025
 00:42:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEnVuzK7VhGSizWj@pc636> <6849df90.a70a0220.cc01e.058d.GAE@google.com>
 <aEnuAp5w6QSoSu_M@tardis.local>
In-Reply-To: <aEnuAp5w6QSoSu_M@tardis.local>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Thu, 12 Jun 2025 09:42:32 +0200
X-Gm-Features: AX0GCFtO9O5G9ZnuVX3i1JpfXbgajBNsH_rdffk0L3gbJwN5FPeRccN9TijpSvM
Message-ID: <CANp29Y4d3de3cc9weuqHCw2sDMdtArOFz5B=783KZ4419Ux=Ag@mail.gmail.com>
Subject: Re: [syzbot] [bcachefs?] [rcu?] BUG: unable to handle kernel NULL
 pointer dereference in rcu_core (3)
To: Boqun Feng <boqun.feng@gmail.com>
Cc: syzbot <syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, josh@joshtriplett.org, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, paulmck@kernel.org, rcu@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, urezki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 10:58=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Wed, Jun 11, 2025 at 12:57:04PM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger=
 any issue:
> >
> > Reported-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
> > Tested-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         488ef356 KEYS: Invert FINAL_PUT bit
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D129a660c580=
000
>
> Is there a way to see the whole console output? If Ulad's patch fixes
> the exact issue, we should be able to see a WARN_ON_ONCE() triggered.

If WARN_ON_ONCE() were triggered, the associated kernel panic output
would have been at the end of this log.

>
> Regards,
> Boqun
>
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D713d218acd3=
3d94
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D80e5d6f453f14=
a53383a

FWIW the last time the bug was observed on syzbot was 100 days ago, so
it has likely been fixed since then or has become much harder to
reproduce.

> > compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07=
757-1~exp1~20250514183223.118), Debian LLD 20.1.6
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D170e460c=
580000
> >
> > Note: testing is done by a robot and is best-effort only.
> >
>

--=20
Aleksandr

