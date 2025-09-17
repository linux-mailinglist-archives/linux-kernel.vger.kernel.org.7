Return-Path: <linux-kernel+bounces-821174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D10F3B80A52
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F6E467B55
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F78F3397FF;
	Wed, 17 Sep 2025 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwzOoffO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74F330C0E5
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123523; cv=none; b=UnWgRS4XPt9ap5pBWBOBVcN92RmKndcyM15/2vSTmtCjlzoowWf4IM0MJRI8VDyACh0KHvC6hZ0uK/Ds0/9+CDKKgZVvlMTn4g2WFy5qdTatUiGIsKLhYPra+ZiF/qg536o9aEpZXwor+VJzs5a5HOOEZr3PiTeNUNBN4uO+uHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123523; c=relaxed/simple;
	bh=LB7piiKR7QrRUi/bNOQ3i5gVlRn+pQtHDDNHk6T+viw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nljcPn6NOZbGOTmA6YP4M1Ilxf9+75ZmuHECx9duyVX5XylyYaQgx+3sIXqQGvqXenzM0WJs5a7vcXp3fomQfaU4QzAjnHkaU7/rGIiGH7nn+wYjD0tsv5B4mmzLrTKqVPH4mKpkN2ERhbj9dj/Ehq3XphEVCz6Hwxoz5AyRcis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FwzOoffO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758123520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzDrhoqrJLVBFYiFwQ2SZoCYFfAfOJ2dJ5Nixz692Nk=;
	b=FwzOoffO0zNYYFFRu7pvsxmoTi4haHQOECeg4zcFmTR08q+IRRXRaD78Goy/K97rl5TbRv
	PxD8QWG5lj3jnYenwH5L0e7wtUzangoS8HEiK5mXOS8vwf9Ym3u/cqMPXJMu++oB5oy5I0
	RD9C6z/YM3LpILdmjFM49GHVGtd25KI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-E7xbJuaOPM2Yy696_xMHTA-1; Wed, 17 Sep 2025 11:38:38 -0400
X-MC-Unique: E7xbJuaOPM2Yy696_xMHTA-1
X-Mimecast-MFC-AGG-ID: E7xbJuaOPM2Yy696_xMHTA_1758123518
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b5e9b60ce6so183274991cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123518; x=1758728318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzDrhoqrJLVBFYiFwQ2SZoCYFfAfOJ2dJ5Nixz692Nk=;
        b=pCtCxKQI19O8uWoIjPl2Hjxp/MbUBRTH82lVCwxKFAU+nAgYWmHS0KLf/gr8icpv7+
         npWtBCdQkHaVA+mNzh/F5xFuFN5Nwsf3YtpHGcwTjRLkwKLv4Lu1bNCgprlWB0EIacxW
         pa9mkPE8/EbrqkgMPDouNnANY48kNL6/5rQ37fJPOrudC7TXgMyZ1JTq+9etlzg/xkat
         MsDRrm6THvt6FEu/zuYh+H313qaEBkAg8K9ZjhmFHwV4Cs4sW5Q4IIVQy+nHqZc0fYKi
         gaCOtnf/0vdyGcWXGRFZpndh89YKL3/trHy5NnAKO6s7Wgc2SsMJn+tBPQSTlWCM3zuI
         YrQA==
X-Forwarded-Encrypted: i=1; AJvYcCUji3TroScjHxvgmXE+5T9muU2TFbdzvfbdoH0L5+jHHsFGllg6E+Wvj1Qzcq95jVyufV1I3jaLLSxXBS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMPH0GzAZ6U6YzliyP6VPeMbMMaYjtPPSuo459YbIcddu1Lss
	3pq+Eb6O24q7qAk6KkORK5JueFZbz1Ilh4zkcgLLL9qW0yRERk+FyCojlbOBvMNKv80rWNYV/7R
	EddkeISX58QXuCOXsBtgO2Gk7TU8eSL2r9Kqhx1Rk7vytvIklSl1hEmGpCctTyVNm8ei5+6flSB
	7/IFD5ZUHszhSarROZPRV0nRr+1tb9bAM4x4eZ0NeovFG7Q22i
X-Gm-Gg: ASbGnctYXrlOLQEEaKGK6Vw9dNHutMN6ru2m6+BDgpn9IzNFm/p/Uo7Pi7aSBG/UjXj
	1wXGrLzmYar1KLBm3Xv6VlRs4K9wRarcLaQ0xoRtucTzwvV5YBkN1GUWSIY1AbwkkSK/b4R+WR6
	KGp3Kw9noZufhU9QGL0njbaxvpNBsem7ZqbnoYBjkILX8SoyKPdkvzPw==
X-Received: by 2002:ac8:6f1b:0:b0:4b2:fdda:f7be with SMTP id d75a77b69052e-4ba6618b9aemr26320471cf.3.1758123517647;
        Wed, 17 Sep 2025 08:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPZbhJSMxuKHfrTjKxJCkJbacm2wHdKQT9Bzco4e/BiqN9eL3IFcF/vIvKnAOF3my7lb81Pi2uNb/6ZJFMKnU=
X-Received: by 2002:ac8:6f1b:0:b0:4b2:fdda:f7be with SMTP id
 d75a77b69052e-4ba6618b9aemr26320041cf.3.1758123517106; Wed, 17 Sep 2025
 08:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-3-gpaoloni@redhat.com>
 <874it3gx2q.fsf@trenco.lwn.net>
In-Reply-To: <874it3gx2q.fsf@trenco.lwn.net>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 17 Sep 2025 17:38:25 +0200
X-Gm-Features: AS18NWDxjPkZ_bdK-V6Pzd1fFU51OydVEbc_fWStALboJrBYI93hRwf9Wba0uR8
Message-ID: <CA+wEVJatTLKt-3HxyExtXf4M+fmD6pXcmmCuhd+3-n2J_2Tw8A@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 2/3] /dev/mem: Add initial documentation of
 memory_open() and mem_fops
To: Jonathan Corbet <corbet@lwn.net>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuckwolber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan

On Tue, Sep 16, 2025 at 12:39=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Gabriele Paoloni <gpaoloni@redhat.com> writes:
>
> > This patch proposes initial kernel-doc documentation for memory_open()
> > and most of the functions in the mem_fops structure.
> > The format used for the specifications follows the guidelines
> > defined in Documentation/doc-guide/code-specifications.rst
>
> I'll repeat my obnoxious question from the first patch: what does that
> buy for us?

I tried to explain my reply on patch 1

>
> > Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
> > ---
> >  drivers/char/mem.c | 231 +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 225 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> > index 48839958b0b1..e69c164e9465 100644
> > --- a/drivers/char/mem.c
> > +++ b/drivers/char/mem.c
> > @@ -75,9 +75,54 @@ static inline bool should_stop_iteration(void)
> >       return signal_pending(current);
> >  }
> >
> > -/*
> > - * This funcion reads the *physical* memory. The f_pos points directly=
 to the
> > - * memory location.
> > +/**
> > + * read_mem - read from physical memory (/dev/mem).
> > + * @file: struct file associated with /dev/mem.
> > + * @buf: user-space buffer to copy data to.
> > + * @count: number of bytes to read.
> > + * @ppos: pointer to the current file position, representing the physi=
cal
> > + *        address to read from.
> > + *
> > + * This function checks if the requested physical memory range is vali=
d
> > + * and accessible by the user, then it copies data to the input
> > + * user-space buffer up to the requested number of bytes.
> > + *
> > + * Function's expectations:
> > + *
> > + * 1. This function shall check if the value pointed by ppos exceeds t=
he
> > + *    maximum addressable physical address;
> > + *
> > + * 2. This function shall check if the physical address range to be re=
ad
> > + *    is valid (i.e. it falls within a memory block and if it can be m=
apped
> > + *    to the kernel address space);
> > + *
> > + * 3. For each memory page falling in the requested physical range
> > + *    [ppos, ppos + count - 1]:
> > + *   3.1. this function shall check if user space access is allowed (i=
f
> > + *        config STRICT_DEVMEM is not set, access is always granted);
> > + *
> > + *   3.2. if access is allowed, the memory content from the page range=
 falling
> > + *        within the requested physical range shall be copied to the u=
ser space
> > + *        buffer;
> > + *
> > + *   3.3. zeros shall be copied to the user space buffer (for the page=
 range
> > + *        falling within the requested physical range):
> > + *     3.3.1. if access to the memory page is restricted or,
> > + *     3.2.2. if the current page is page 0 on HW architectures where =
page 0 is
> > + *            not mapped.
> > + *
> > + * 4. The file position '*ppos' shall be advanced by the number of byt=
es
> > + *    successfully copied to user space (including zeros).
>
> My kneejerk first reaction is: you are repeating the code of the
> function in a different language.  If we are not convinced that the code
> is correct, how can we be more confident that this set of specifications
> is correct?  And again, what will consume this text?  How does going
> through this effort get us to a better kernel?

In summary specifications provide the criteria to be used in verifying the
code (both when reviewing and testing).
Otherwise:
1) Developers and reviewers have no criteria to evaluate the code, other
than their expertise and judgement when they read it;
2) Testers would write test cases based on the code itself (so it is more
likely that a wrong code is not detected due to wrong test cases).

WRT your first point, if specifications are wrong, a reviewer or a test
would detect a gap between code and associated specs, hence leading
to process of scrutiny of both code and specs where such a gap must
be resolved. This is the reason why the duality of specification and tests
VS the code being verified lead to confidence in code becoming more
dependable (also from a user point of view that can now clearly see
the assumptions to be met when invoking the code)

Thanks
Gab

>
> Despite having been to a couple of your talks, I'm not fully
> understanding how this comes together; people who haven't been to the
> talks are not going to have an easier time getting the full picture.
>
> Thanks,
>
> jon
>


