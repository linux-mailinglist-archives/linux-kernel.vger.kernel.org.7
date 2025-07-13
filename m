Return-Path: <linux-kernel+bounces-729053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C78B0311C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 651CD17D2DE
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F7277CAB;
	Sun, 13 Jul 2025 13:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9nKTHnN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29C19CD01
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 13:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752413254; cv=none; b=HODqKvs3xch9AWUPbYWcYPVBnlUxa0Wb1HO8QNzsovGzYEaVWmTzbRLiKL6OueciwMpcBiscJRrYOob++63NJUxK8xn/fPMCNBdIVTrjw9rVr7H6qXIS+D0ID9x1Fzmh2aDxZYXKymawqCRJT7EH1Fz2yvosGkZRWEX3eghA0cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752413254; c=relaxed/simple;
	bh=sySgaK1WJdiCy0OaVWHnKivQ/76zBxKaSyFfGWHXB2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVSwqMg5C9Cb/QF9LOwM7e3ImP7ZB34FlIK+N+4B5rG/bIisc1pFKWR6jtTcSy5VNaxBw6DQG3U8w3mLEr8wGr6gFq+f7Zk1JKNY9tAAHCXJYWRFtkg8WCw7ORxZw/OqKBrQeNi5tp9E8JXERp6EFQT2UYKTry3MomhxL5QLm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9nKTHnN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752413251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SbPUMGX8ZxgFnHeeV/hiD/+ZSjBKC2dEHsGM22BJ5fQ=;
	b=Y9nKTHnNcGr0lK+YsUzaMMdSz4yTGJJHlyCAO2LVC1NvvQKWj+J1S6y48NZU7CsEpLsnfu
	RrnlJljfjuLoKaGDpVF/hNf6+aK5XOCBZaDlYsRlrnAYLCgsjBTJhja9oy8MtNNU0W2A8N
	QRYWHqYtUODyPcQlsOwO+ardGPl3d7U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-oNgilVvzMSOVVBwqzBCUkg-1; Sun, 13 Jul 2025 09:27:30 -0400
X-MC-Unique: oNgilVvzMSOVVBwqzBCUkg-1
X-Mimecast-MFC-AGG-ID: oNgilVvzMSOVVBwqzBCUkg_1752413249
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60c3c9ba04dso3724576a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 06:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752413249; x=1753018049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbPUMGX8ZxgFnHeeV/hiD/+ZSjBKC2dEHsGM22BJ5fQ=;
        b=mtnikWjLH0fhfTWBEUjwnUcuhqJHivt+ay4OJckSgyCZY2JSeV9Cne8kWUaIbd90M5
         FcSG6WfOUlF09272b5naHnkOKD9r/bFw/ggyXEBpjVmK1ODyAiNV8BakcqZQUpZKwpq/
         /5iN2nWlh9QMoJ4ZkroHqH/z7cFroq2PyqFWkDWGlugrV8Cayrl+CkvOG7UqqQi+9DQz
         e1aGzakq+f6fUpmARbR+a5JUXuy8I6XsVYQ2HR2je2func5kTCqkROGAdbpekennFhkx
         aE3O88JijKuPJrSBpZd32i7hPHPIdbuPEF4Oy4JXOIM+naf2nNpBUFiJMMai9+yS8AJ7
         X8Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUQyBkecoxPc4Pw1Xmibx/lDSTz/n2yltmVR3xbxpgwfGKzSJiBnmtrFhbw7486aZ+rFX2BLgc95kvUm8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJkBmxMSR8ogq5FG0Mcy8mIKP6wwNfJWYcfqVqt5QXeNmdCoq
	Q+34WF5MV1sYnAvzxQ1lsEeZ1XmPt7QBytTrV2+bDhLEWsGg13q1fVbdfHjZv2qw5+HjuFTxUVw
	k8BQZVnPV5b2m3PCt1rHSao7FBqvbAvAwKtp1TqUSOh8QpQWwqhjcjinUidxyvGIOdGx23z8mMP
	ZH7BNQNJrXUbKkM+HOlC6zxcm9Qn3Ak11hgDfyVipg
X-Gm-Gg: ASbGnctktsFUnclYI4tPlu/vMZpOfxbjsLdQb7oqONdLm26LOWtqGoR/HbcjZDG/tyB
	rvGi8mwUzDwQGwlGj8dvNZcn85cKg7MJulev3m5aslFdBb5vR3TQwkKwjTyIObC1uwcBFo+xPYO
	UGEx7bscacrkAOdwjwGAy1Vw==
X-Received: by 2002:a05:6402:5208:b0:602:e002:9602 with SMTP id 4fb4d7f45d1cf-611ed0b48a3mr8984307a12.22.1752413248653;
        Sun, 13 Jul 2025 06:27:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIlJvPutpwR+W9sYxwViMZl/nxrPvYhgmffq4XbNJHFHpRjpXPpPQW6Oj3vKgX0RqUfCjFSDen0AZNhqrle4U=
X-Received: by 2002:a05:6402:5208:b0:602:e002:9602 with SMTP id
 4fb4d7f45d1cf-611ed0b48a3mr8984268a12.22.1752413248167; Sun, 13 Jul 2025
 06:27:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711053509.194751-1-thuth@redhat.com> <2025071125-talon-clammy-4971@gregkh>
 <9f7242e8-1082-4a5d-bb6e-a80106d1b1f9@redhat.com> <2025071152-name-spoon-88e8@gregkh>
 <aHC-Ke2oLri_m7p6@infradead.org> <2025071119-important-convene-ab85@gregkh>
 <CAC1cPGx0Chmz3s+rd5AJAPNCuoyZX-AGC=hfp9JPAG_-H_J6vw@mail.gmail.com>
 <aHGafTZTcdlpw1gN@gate> <CAC1cPGzLK8w2e=vz3rgPwWBkqs_2estcbPJgXD-RRx4GjdcB+A@mail.gmail.com>
 <alpine.DEB.2.21.2507122332310.45111@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2507122332310.45111@angie.orcam.me.uk>
From: Richard Fontana <rfontana@redhat.com>
Date: Sun, 13 Jul 2025 09:27:17 -0400
X-Gm-Features: Ac12FXxrW3BGCO-1ZfGLfyWGLr1WX6guqRW-xwVntrFMkfEbUP4U2wTWbTptYug
Message-ID: <CAC1cPGwa=0zSL_c+HrjQoPryus6w_LCw9Cha7uENKHqCKOQkRQ@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: Replace the obsolete address of the FSF
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Segher Boessenkool <segher@kernel.crashing.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, 
	Thomas Huth <thuth@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Thomas Gleixner <tglx@linutronix.de>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-spdx@vger.kernel.org, 
	J Lovejoy <opensource@jilayne.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 12, 2025 at 6:48=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.u=
k> wrote:
>
> On Fri, 11 Jul 2025, Richard Fontana wrote:
>
> > > > while this one:
> > > >
> > > >  *    As a special exception, if you link this library with files
> > > >  *    compiled with GCC to produce an executable, this does not cau=
se
> > > >  *    the resulting executable to be covered by the GNU General Pub=
lic License.
> > > >  *    This exception does not however invalidate any other reasons =
why
> > > >  *    the executable file might be covered by the GNU General Publi=
c License.
> > > >
> > > > does not seem to be in the SPDX exception list. It is very similar =
to
> > > > `GNU-compiler-exception` except it specifically mentions GCC instea=
d
> > > > of saying "a GNU compiler".
> > >
> > > https://spdx.org/licenses/GNU-compiler-exception.html
> > >
> > > is exactly this.
> >
> > No, because `GNU-compiler-exception` as defined here
> > https://github.com/spdx/license-list-XML/blob/main/src/exceptions/GNU-c=
ompiler-exception.xml
> > assumes use of the term "GCC" rather than "a GNU compiler".
>
>  I don't know what the legal status of the statement referred is, however
> the original exception as published[1] by FSF says:
>
> '"GCC" means a version of the GNU Compiler Collection, with or without
> modifications, governed by version 3 (or a specified later version) of th=
e
> GNU General Public License (GPL) with the option of using any subsequent
> versions published by the FSF.'

> which I think makes it clear that "GCC" is a collection of "GNU compilers=
"
> and therefore the two terms are synonymous to each other for the purpose
> of said exception (in the old days "GCC" stood for "GNU C Compiler", but
> the old meaning makes no sense anymore now that we have compilers for Ada=
,
> Fortran and many other languages included in GCC).
>
>  NB up to date versions of CRT code refer to the exception as published
> rather than pasting an old version of its text:
>
> 'Under Section 7 of GPL version 3, you are granted additional
> permissions described in the GCC Runtime Library Exception, version
> 3.1, as published by the Free Software Foundation.'
>
> References:
>
> [1] "GCC Runtime Library Exception", version 3.1,
>     <https://www.gnu.org/licenses/gcc-exception-3.1.html>

I think we're basically talking past each other. The definition of
"GCC" in the GCC runtime library exception 3.1 is irrelevant because
that file does not refer to that exception. In SPDX, license (and
exception) identifiers are precisely defined. Unless I'm missing
something there is no official SPDX identifier that corresponds to
this text:

  As a special exception, if you link this library with files
  compiled with GCC to produce an executable, this does not cause
  the resulting executable to be covered by the GNU General Public License.
  This exception does not however invalidate any other reasons why
  the executable file might be covered by the GNU General Public License.

I'm not personally a major supporter of SPDX and I'm the last person
who would want to be associated with SPDX pedanticism but it's a
standard and if the Linux kernel project is going to use it IMO it
should conform to that standard, otherwise you're basically making ad
hoc definitions of pseudo-SPDX expressions or redefinitions of
already-defined SPDX identifiers, which seems to defeat the purpose of
using SPDX expressions at all. Under that standard, there is currently
no SPDX identifier representing the above text (as far as I can tell).
The solution is either to propose a modification of
`GNU-compiler-exception` so that "GCC" is accepted as an alternative
to "a GNU compiler", or to propose a new exception to be added to
SPDX's exception list, or to use a custom-defined `AdditionRef-`
identifier.

Richard


