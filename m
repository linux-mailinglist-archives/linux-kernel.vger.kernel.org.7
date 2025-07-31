Return-Path: <linux-kernel+bounces-751593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BA2B16B42
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5381918C6F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C8223B61C;
	Thu, 31 Jul 2025 04:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1aNK3pn"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636AF2CA6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936586; cv=none; b=IhgfWN9OPbkCje3L6Ri2msIttnhFM94fJ2TiXnG77btq3zdKqu7Ycwbu+DbseOPTyRNpfw1iA4n/+Ou0Mm0CC9ajbzhFY+SMlIoB734vr4EpEV3ORohLO6H6Su2sdm0blCjewgO8XN2qeIwZo3NykuvsFK7nZw0lsuA5egt3gEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936586; c=relaxed/simple;
	bh=21OF6T2HE4ELxQs2mP8X4ESpa3O4vj0vAWBbSYVti5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q/v3heaTy/6tx7rrsPPIvoibj59MQMscxJkXdKqm9N0G0/KQIuYnzIl1FK632T+qhLGOqcaUNG7Xp/jBbs9VJuRXU9Lpcis5Mni59nuCAgTkwiqcdcNKMrTZsvwO/FKMIEjThNoa+b8Up4+xnOG5GybkYllowrhA54r6Lt/6ZSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1aNK3pn; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-af8ffa04463so86284866b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753936583; x=1754541383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=21OF6T2HE4ELxQs2mP8X4ESpa3O4vj0vAWBbSYVti5s=;
        b=S1aNK3pngv2y/JIwJhdgHevoRPfhkeoDDA7LX3D9jgjSPwwAm8tmPbYCEVMfP0iLGW
         ezAHkDeR1EjBIqxr1oq6s955GfKUww/8Ob90W+tmAmNVFWybv1srLL4ZBSvojcngaPJj
         2mMWWAW4eFPLy63u2cnDbaOsy3UjVDlEojiGs+8SAzIdydoyWt4PuOqNskpuUFw2GTA7
         8Vv/09t1jl6rTTTrKAJTCUMqNsoXIUyMUOWVWwXBj2vb/ggQSHzK482qlXoLrGeI/DkE
         dGStmMUoQS5oUNjSgYJWMqDSyTW/V/51d6RC4KIJaOz4/nzGfgGOVrULRhVJ4xFFGhmU
         2iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753936583; x=1754541383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=21OF6T2HE4ELxQs2mP8X4ESpa3O4vj0vAWBbSYVti5s=;
        b=r/UxUTB9fO0AwUW1wlYmNXloiBPO00vaqgZk/UneDQS7l/9xOalSN3BFm48uRUXc8S
         CB47oDreakdSzdY9J+MoAXOilieMO7R3IoRVxeOoYIhxEdaw6QEZA0B7fMrMgJP6Vxh6
         adsGuCNhjdMs4m6SCNZF2mrpMBnZoTdi/csP12d2+SPCRT1NOPgcfaigao9RXYQlOehZ
         Nla86fms5HO/bsuAN+2nfbrtBmuUI18lhtcFNASz3hBUcUGnumjHfC/7zqfVOFLfmAQU
         b4Zgc+jdvaFSyBVjB6yJVwebwRi7me4QPJvumDcDvtPeWWsnyp4x9TD6MipoMkY45r/X
         RKfA==
X-Forwarded-Encrypted: i=1; AJvYcCWf7usXCpByAJUbl3wx0oHFqS6I1ba1O3XuCU+g+FZ56jDWTPKnGT3Uwm3kF+4wuLvBBRhk2SSCxyyUnhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwckknuLqmsLLWnRwcBiTcS/MaTmITiW1/ZZiUHM5sY1MdDDhjc
	frpKi7YEVszloxX1vMgzZ53NfYl48/7iKLYQ3c7Bj0ia3Fb8m8Ftu8ipZ8sSSY68a3dbkJsdX8Y
	Vn3+fOeSYc7lCFDlHWyFR15rJsdFz3+M=
X-Gm-Gg: ASbGncsL/TNSTPG+oqXGVbE+7qC5ITeqTuoFBhQlP8E5qkj3d0SoSx4DcZI3xg6GQK3
	xpx9M3dKSil+zsZBRdGFcUtUs9JkjZAMy562phtIBiz/LB1JXBQwkZoY8KwK9NX60/AASQmLnOk
	MDav3t66bx5T32xPxXSwqw/Zzt05Fd5iX8HY2xA0h34IdPyBToobxjruBjP6NX71bQWEwrLH6sj
	YDwEw==
X-Google-Smtp-Source: AGHT+IHt8zXUEbU3uDBO2OBPjItSRqo+K1Uvvu2Z74SY8+04QgQzeq/5DUZSTY0K+0y5LyFUphTzmyk7hHFZdAjXVJ8=
X-Received: by 2002:a17:906:7945:b0:ade:44f6:e3d6 with SMTP id
 a640c23a62f3a-af8fd9ad9c7mr655825266b.46.1753936582675; Wed, 30 Jul 2025
 21:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9tzVm80-v6_5nt6kko3nR+aQLZ7R98i419FV8f4-ayQWUw@mail.gmail.com>
 <CAHk-=wirxHy+KU6jmtO2dzmGQ1BwaOdd5Mjtrc40fGvZVULQQg@mail.gmail.com>
 <CAHk-=wjn5Pg2Gp=o2NVv-nRKqE=E75AxUypWCCpQ7MDXuHx+YA@mail.gmail.com>
 <CAHk-=whnuRuQEky2GsCDRQSf1dZbpoqnK+puw=qdR-D7aap9SQ@mail.gmail.com>
 <CAPM=9tygJqtbmYzB5gktxp-7fBfv_9gNq9p9+SdZ6wiYE2-6PQ@mail.gmail.com>
 <CAHk-=whB1X1c6rWbY34wZVGcnaY=yfPGLOtjd5h3mMDGV9Lbkg@mail.gmail.com> <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
In-Reply-To: <CAPM=9tyb1mELymOJv62KJom4mGF0UBifbVqLJUFdS1C7Eeu3jg@mail.gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 31 Jul 2025 14:36:11 +1000
X-Gm-Features: Ac12FXyggAnv_vUCzftDVLdOsUcon8a2AjoKpSc2jMLh64RtNqK26XHwib2traU
Message-ID: <CAPM=9tzDWmYBKQGB0ybDzhYHkg0p98_6PJA8OuPahRep8+QPvQ@mail.gmail.com>
Subject: Re: [git pull] drm for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Simona Vetter <simona@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Jul 2025 at 14:32, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 31 Jul 2025 at 14:27, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Wed, 30 Jul 2025 at 21:21, Dave Airlie <airlied@gmail.com> wrote:
> > >
> > > Okay I don't have an rx580, but I have an rx480 which is pretty close,
> > > but it is booting fine with your tree at least, DP and HDMI connected,
> > > so it's not widespread AMD breakage, anything in journalctl/dmesg?
> >
> > The machine doesn't come up far enough to mount a filesystem - my
> > disks are all encrypted, I never even get to the "type your password"
> > thing.
> >
> > So no logs.
> >
> > The good news is that it's bisecting without any ambiguity. So nowhere
> > near as painful as last merge window.
> >
>
> You can boot with modprobe.blacklist=amdgpu and then modprobe amdgpu
> once it boots and see if dmesg
>
> But hopefully bisect lands somewhere good,
>
> Just seeing if there's been any NULL ptrs on old GPU reported.

https://lore.kernel.org/dri-devel/20250717204819.731936-1-mustela@erminea.space/

is the only thing I can see that might not be in the merge.

Dave.

