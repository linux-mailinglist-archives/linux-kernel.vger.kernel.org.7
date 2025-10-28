Return-Path: <linux-kernel+bounces-874904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B38C176A7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378C71A61A5B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1222D9EE2;
	Tue, 28 Oct 2025 23:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I4hiubbC"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C092D877D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 23:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695658; cv=none; b=l7emyDEDKkVyRZ9azQjhcRqn97NKu4gMDmHGdoKRbzneFEUkwNBGA5IQlW1oysQc4oH/NeoYMKUcxaKW3u1eHYjeGkZxs8OsfxIejIyReTsi3wNjC+c7RzOGzWATyDBBMk50E5myEokIcCzzQOgzuStor5mAkC2lKRNYauADRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695658; c=relaxed/simple;
	bh=cWlgHGOtfSt7tIaISCcbrIt/pV55e5WSj3LRJbov54U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIXk8qUwbKunNzKel668xwd+kKkR5yWepSid+gIJ41FtJ6BmdhD6aYWzvp5IiFl5Oz6iZocHW3zFofZF5VX9r0pj3UOOh4/BktWqsH1gY8slmKfpNGdYAJFliizKpOWKcMPux+IFvYOTlQro8xO+T1QfJPzQjpryCJiUOT3rboE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I4hiubbC; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2697899a202so3018225ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761695656; x=1762300456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWlgHGOtfSt7tIaISCcbrIt/pV55e5WSj3LRJbov54U=;
        b=I4hiubbCZajyJIcq0EzybQmQ+4TBp/+SzA2Rh9wEsGnH/XqMUf6ddMpA5oz2LHY9/y
         U6K5i2kj9ahilHC1zGslEUPVycin10XLvpjGKUmw3cJzk5xIlNAZ2jcvjR2rYOS+TRXv
         NWj5WNgoRzJpRWUQNdhrWg7duJUIr78ukQWhpVXY9oLcAdDuJhpHQHQ9fH/AHhxsRvvh
         bnJVeUvi8B9StMWwLnJvB61+LTVE4mCgXbEQUX5SgGlBk5gop1+ZoOJA/D4zt7mdxYEw
         2PuItCQ66BiDwf5h5++nIurG4DNGjnJD4szqpMmSmbVupNejYInPlEPHnm+FEgPUrm7j
         VXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761695656; x=1762300456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWlgHGOtfSt7tIaISCcbrIt/pV55e5WSj3LRJbov54U=;
        b=vq48+Wd9rW4w+mLAvxdzGKt4XfgJcmAUwCTAdIxAO6FZ1yWu/k53nKkgA8Gf/62Sgc
         VbtK2bPcqGwCCQkSFhFxbwMId9bzV88uh9n+ZI1V+0oXqKfKX/jCVyLSLjRA5AKHqMQp
         xHUEAwbtfTEBeM58mRTy6pOXsGbBA+IXJgeLyKSHsT/M3YYa3+lrOmS6tWS/f6m44dyq
         BNZdEcvLdFPWqDoCt1LeZDIA53GAPBuESIe2Avyrn+LYrRiUb+DPjYOs30wf54bZV5wi
         KIn9G8klcdT011z7EswMiV6RDUUhrGZtjY6YPl8hc+mu0pT6mjCC67hxcJ8eA5VNDf2I
         +pvw==
X-Forwarded-Encrypted: i=1; AJvYcCXZNh+BaCZYhUHU6f44AtM3OFLQX4uG7g8vJMe9PH50dXgleVFweYyVa7IMl8uzeJdBD/BgpTnDU74EaQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5l5VgRxpa8VafnhqYs1D37makJqAWfS/3Nq7bVxnCvH+wwEe+
	4omseSCL5zHklIpdH90wIDbnL2YP57fIvXhP6gWU/aUayXNQqlBEPS2/2D1ld39/fmp42MeERQu
	6IqxONFlSeGt/Y3ZLIqBuw4SJpqwp5hU3P1SN3HPR
X-Gm-Gg: ASbGncvDMjYpukXLUPeM2J04yOSR3tu88MbORIT/NsMDiVUzW44s2qLkOJT2Wi/OqUN
	PX5L7IuSONnj9V1k2f7YIIiVIOQ72e/STBYTKWsaKjJCidtRBFIkFNpDhAgkchKk4TOHWebWko4
	khusXWP4SNV9u9dgJeXcGFrWVSHQvGxgoNBQfYVQ4/jzyh+B5uGtwjjmoA94RiY6zMLsza+CNbf
	VXxEvx20UEnM9TVvA/EIdv237YD52TVMmuBMcPzBMWgwueYmYeO0OfW5mkEzatFHI+YSuzau2F1
	OaTWegoQXX5zWhOAEiCiSEOcqg==
X-Google-Smtp-Source: AGHT+IFup0B2nTqV79YPEbtafgKs655fF3V8G4NXh7YZFmx8qXmynLB/NFFmZEI3BEJKq/dfY7xg41/30IZOzA6kP5E=
X-Received: by 2002:a17:902:e808:b0:267:44e6:11d6 with SMTP id
 d9443c01a7336-294de7f3b95mr12979265ad.6.1761695655715; Tue, 28 Oct 2025
 16:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org> <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org> <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
In-Reply-To: <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 28 Oct 2025 16:54:03 -0700
X-Gm-Features: AWmQ_blCRWQ09fMUDpVGLUvfkkotj1qXZ_C99Ycg2hp8MBCvCnTaAW7B48KRr2I
Message-ID: <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, junjie.cao@intel.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, thostet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 4:45=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 28.10.2025 23:13, Jakub Kicinski wrote:
> > On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
> >> From: Richard Cochran <richardcochran@gmail.com>
> >> Date: Tue, 28 Oct 2025 07:09:41 -0700
> >>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> >>>> Syzbot reports a NULL function pointer call on arm64 when
> >>>> ptp_clock_gettime() falls back to ->gettime64() and the driver provi=
des
> >>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in t=
he
> >>>> posix clock gettime path.
> >>>
> >>> Drivers must provide a gettime method.
> >>>
> >>> If they do not, then that is a bug in the driver.
> >>
> >> AFAICT, only GVE does not have gettime() and settime(), and
> >> Tim (CCed) was preparing a fix and mostly ready to post it.
> >
> > cc: Vadim who promised me a PTP driver test :) Let's make sure we
> > tickle gettime/setting in that test..
>
> Heh, call gettime/settime is easy. But in case of absence of these callba=
cks
> the kernel will crash - not sure we can gather good signal in such case?

At least we could catch it on NIPA.

but I suggested Tim adding WARN_ON_ONCE(!info->gettime64 &&
!info-> getimex64) in ptp_clock_register() so that a developer can
notice that even while loading a buggy module.

