Return-Path: <linux-kernel+bounces-863390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD83BF7C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB1D54389A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B4F3446A0;
	Tue, 21 Oct 2025 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fjZa2+QC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB1834A76E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761065047; cv=none; b=RDr7ZXbuslJNKsOhqf1IjR9YkVTN91hXvEabvX0C0TiwSYTuME0jVozF/8xK0IzleJxWZdzoxYxshE5CFrryLmmBcENVwjRcOFotlacpGC8a9owTujWkkFaT/tL31KmSG76EQrV+oUr+U+Baa+hvFvnao8OaQZ8oTcQpPU0XdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761065047; c=relaxed/simple;
	bh=4YmHvcvZpSJVJYzfmLEbibQx5RFd/moigts2aPZXuSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FaDevU/3VF4DZg2VnyDpLHN3HckzCFtp77sll2Zhtm1GIVnfl64BxXg8pQ9QbT6tQ5oZPrDnvNfkW5MqjQLtfBOyuHfclC+CPRVkj6hPzs6EDbn1VjIMqonzy5HDdY2QRmRd7AkX8frHWTSV/MZ37vv747A2lgSTZK33OjLbbrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fjZa2+QC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761065043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lnZSOAVMKEkF8DgY+Fx3pHUy6vCFxXk/5AE4e+Z/Gr4=;
	b=fjZa2+QCNhYcEq8Q51LtvKCGxfmeYviZmFZYCtNaMEYEccveBh4fOAiAKs5Ba5KucYY+jF
	NW3IUptmgYlf+TsPKyv3iIyIaQVptiCim4Qe3tHzDq8IHEvbbpUUvkjua6dcArTSnofyED
	MnAsP0u/IyszGtO3B9+3iP/amFKysas=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-D0Nm1F7DM2aUkyYXuZYn-A-1; Tue, 21 Oct 2025 12:44:02 -0400
X-MC-Unique: D0Nm1F7DM2aUkyYXuZYn-A-1
X-Mimecast-MFC-AGG-ID: D0Nm1F7DM2aUkyYXuZYn-A_1761065041
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4e8a3f6becfso1076771cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 09:44:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761065041; x=1761669841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnZSOAVMKEkF8DgY+Fx3pHUy6vCFxXk/5AE4e+Z/Gr4=;
        b=p4qwdGcaEdeL6kXB0VBgSjW1k2HkgnRH/I9NzEK7VjylFHqalVd7mXo1fwAQ3MqJYt
         UaEP1f9RblfD77w+9ksGtZ4fpg+QGf1pnBB4QEo4htSFAIAh4N06j+EPqU55+bzVv/sR
         ElyoS3eLMfBf9rfXHAHMWXxdJPmjFlQEcAbMNIFV7JITkLbKUThBeSjL6UGBgiVA4NyA
         4EubQwp+YfBUfEK2SmO7WsJIEDvvyA/tgf/1n0HPc+sfK1wUfhB4kY6rZpYsnoHe70r4
         G8CaDmoTGZfMLJLSH3O7J+yNXvUPzdFeUOms9rMMk+Ea7cE6aQ7uZb//AvHpNJkOcTIE
         UXrA==
X-Forwarded-Encrypted: i=1; AJvYcCVPJUWyiwOK43F9j4165tQrqgDF5p9OjPBfz3qAglxpIF+Vy5noz8KETxFl4CXbtnC5N/nPMuT4gfgYkuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOp0PotJvGugHwub+MYk8eOfJiBlggrvK4SqRGKXEAJHggzeCO
	REBJNvqLH6f4lwdIAa0vT3dphiiw1KMM4pJU+yfb+0X/Dk97SOsF6YXZvIxL+YV13+wmiz3hpbl
	wRvtcj5f8NhPPEEKm/UFwOCnZSe5UMfGhwBIYUYzRJZGa+afoLbfLsvu9SENGDPanygVeSgZslb
	9wpFCDi4prWbmw1qbL1fg3UIyz5a77sCYfeHOSueZw
X-Gm-Gg: ASbGncvK4JJk3TbvJ7xTklA1j35Cv97mP61EEPM66cKIvWQGhojaN2bYBoPiYGRhdjf
	hxN7xJPF8mcM60QTF01nRDxnW8xCp8BcdK/M/QLHX51jd9y8nq0opdVBN7/Wfty3TsOYtEBTi4W
	h1bB7nFv2SvOUfmBg4TcaobGm5qilRsoLwuhhumvTo+PSJbs32Dl2zkR3/JyhtrNujc7Sz4UpFT
	RxYyYk6qWB0VQk=
X-Received: by 2002:a05:622a:8d:b0:4e8:a8dd:9ece with SMTP id d75a77b69052e-4e8a8dda588mr204964261cf.73.1761065041340;
        Tue, 21 Oct 2025 09:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAfDFlGk7bvGv6JgbTw1zj++uENryqhdqzCaeJw6qYcicQPAK2zyOIVO/t/8no07sO0cLtemg82e5bbZzJhxI=
X-Received: by 2002:a05:622a:8d:b0:4e8:a8dd:9ece with SMTP id
 d75a77b69052e-4e8a8dda588mr204963971cf.73.1761065040848; Tue, 21 Oct 2025
 09:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250910170000.6475-1-gpaoloni@redhat.com> <20250910170000.6475-2-gpaoloni@redhat.com>
 <878qifgxbj.fsf@trenco.lwn.net> <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
 <CAB=6tBQP3aCDWch4ZcEYMqFsJ4OKXSyC_hb9V9hA7ZZty7vFeQ@mail.gmail.com>
 <042629f9-f295-494e-8fbd-e8751fcbe7c0@redhat.com> <CA+wEVJYLF9T21-V2k0Y0zxcF0zcRG64QUVrM=qHDWHz7+4+ptw@mail.gmail.com>
 <dafcdb6e-be12-4b86-959e-8510a9622358@redhat.com>
In-Reply-To: <dafcdb6e-be12-4b86-959e-8510a9622358@redhat.com>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Tue, 21 Oct 2025 18:43:49 +0200
X-Gm-Features: AS18NWCBpqAbisvSgvvqFRL4j0rCUfXKUoQLmxvhLRhTM9VY1KibLNsIgwn639M
Message-ID: <CA+wEVJZS5GErRThB7wvQ5pDoVo_j=pKD4neN-U2qJEnTgHRYXg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
To: David Hildenbrand <david@redhat.com>
Cc: Chuck Wolber <chuckwolber@gmail.com>, Jonathan Corbet <corbet@lwn.net>, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	safety-architecture@lists.elisa.tech, acarmina@redhat.com, 
	kstewart@linuxfoundation.org, chuck@wolber.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:34=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 21.10.25 18:27, Gabriele Paoloni wrote:
> > Hi David
> >
> > On Tue, Oct 21, 2025 at 5:37=E2=80=AFPM David Hildenbrand <david@redhat=
.com> wrote:
> >>
> >> On 20.10.25 23:02, Chuck Wolber wrote:
> >>> [Reposting with apologies for the dup and those inflicted by the brok=
en Gmail
> >>> defaults. I have migrated away from Gmail, but some threads are still=
 stuck
> >>> there.]
> >>>
> >>> On Mon, Oct 20, 2025 at 7:35=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> >>>>
> >>>>>> +------------
> >>>>>> +The Documentation/doc-guide/kernel-doc.rst chapter describes how =
to document the code using the kernel-doc format, however it does not speci=
fy the criteria to be followed for writing testable specifications; i.e. sp=
ecifications that can be used to for the semantic description of low level =
requirements.
> >>>>>
> >>>>> Please, for any future versions, stick to the 80-column limit; this=
 is
> >>>>> especially important for text files that you want humans to read.
> >>>>>
> >>>>> As a nit, you don't need to start by saying what other documents do=
n't
> >>>>> do, just describe the purpose of *this* document.
> >>>>>
> >>>>> More substantially ... I got a way into this document before realiz=
ing
> >>>>> that you were describing an addition to the format of kerneldoc
> >>>>> comments.  That would be good to make clear from the outset.
> >>>>>
> >>>>> What I still don't really understand is what is the *purpose* of th=
is
> >>>>> formalized text?  What will be consuming it?  You're asking for a f=
air
> >>>>> amount of effort to write and maintain these descriptions; what's i=
n it
> >>>>> for the people who do that work?
> >>>>
> >>>> I might be wrong, but sounds to me like someone intends to feed this=
 to
> >>>> AI to generate tests or code.
> >>>
> >>> Absolutely not the intent. This is about the lossy process of convert=
ing human
> >>> ideas to code. Reliably going from code to test requires an understan=
ding of
> >>> what was lost in translation. This project is about filling that gap.
> >>
> >> Thanks for clarifying. I rang my alarm bells too early :)
> >>
> >> I saw the LPC talk on this topic:
> >>
> >> https://lpc.events/event/19/contributions/2085/
> >>
> >> With things like "a test case can be derived from the testable
> >> expectation" one wonders how we get from the the doc to an actual test=
 case.
> >
> > Probably it is the term derived that can be a bit misleading. The point=
 is that
> > we need documented expectations that can be used to review and verify t=
he
> > test cases against; so maybe better to say "a test case can be verified=
 against
> > the testable expectation"
>
> On a high level (where we usually test with things like LTP) I would
> usually expect that the man pages properly describe the semantics of
> syscalls etc.

On a high level yes however there are two issues:
1) even the Posix standard define the behaviour of certain syscalls as
implementation specific
2) if all the details required to write testable specifications were mainta=
ined
as part of the manpage, these would become unmaintainable

For this reason specification must be broken down over the code in a
maintainable way

>
> That also feels like a better place to maintain such kind of information.
>
> Having that said, man-pages are frequently a bit outdated or imprecise
> .. or missing.
>
> Anyhow, I guess that will all be discussed in your LPC session I assume,
> I'll try to attend that one, thanks!

Sure Looking FWD to see you there

Gab

>
> --
> Cheers
>
> David / dhildenb
>


