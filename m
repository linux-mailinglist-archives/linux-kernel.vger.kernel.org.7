Return-Path: <linux-kernel+bounces-783678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71734B33114
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5277ABE55
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0E129AB13;
	Sun, 24 Aug 2025 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjydjCSD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259D13DDAE
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756048216; cv=none; b=FZqwO3LyZnfXng/r1Ed7cyIAXcGOudRl/iw+YxkWlrjnd2Dj3WDYeqnUuUgSSe/OJOJhy/0r2wpEFHPrX/71DBUtcGL0I1aLJZm+Q3tH6U5HlSFa2SQ+2vQnXUEX9UBBvVmhn+N0o8RZGkW4EkViMRBLmt2FQ91oSaFGV24RFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756048216; c=relaxed/simple;
	bh=eWLBxF+SzhSUfonAmOsJEkV+s9CsfS18KijuaqP9MqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eoy8hh+5fvDuY8/f+7gARCD/ANRRgq85J6J+gyymmckA1naJi2PiCsUU7DYdC+hL0hh3gacx13eiN1xfYipg2QwJpRpie61u/ZQloKhblZ4IffOyzFUD9Dp5ByS3fSZ8i3hyXVPwYKnt1zLJrkT3+s5fGOMfDGBa8JZg87Q1oGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjydjCSD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756048213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRwdmnkQQFUvKbEtvViOVPI4X3UippPIBR7xh7VZhDI=;
	b=XjydjCSD1R7bGZxt6z7qTW38oZC9A15jedzJ3Y+WYW6UwswCSlLT2q+te0odgkBjtuaCi7
	U3xd7zKosNwtxmVvpY2PbdocgZCT62EYvyRD1lVNtoA0LFh6za+DmHvoOsKYimrbbwSkFc
	DP3M4NkyUoD/4desvsfdRe/QeFSSefs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-lqY3LyL4MV28HNAclL76Bw-1; Sun, 24 Aug 2025 11:10:11 -0400
X-MC-Unique: lqY3LyL4MV28HNAclL76Bw-1
X-Mimecast-MFC-AGG-ID: lqY3LyL4MV28HNAclL76Bw_1756048211
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e87069063aso1396846885a.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 08:10:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756048210; x=1756653010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JRwdmnkQQFUvKbEtvViOVPI4X3UippPIBR7xh7VZhDI=;
        b=eBKGpYq9tFv/6CKQoJCnT/aq4AiNOfS5E8vvTr1q4zmZovg9M1gDDma47b4AXXc45V
         jeL7cPgKubA4pE/08HyGoCJunD2/zWtxO6xfTfs6rCNWaiTnVSyOUH5tyQ1jSqOFgvOO
         rMfBBEGpOxBD9Lyy0ZrLXjPWAr9uvBo/5XE8pkILJHuQwyni6kD0sIBPlauuEzDGfOqq
         I5X8az/uCGmNLs7g+KuLCmu5EmQ/Oxwvty12rcmCUqJ/Hr+jwEfn1tQNHtgbNhhJ9xzl
         tSze6zP2LDZjczGLNYdQ91J3uMyq3lH41uBOXHnHfxIu5KQUqbCz7PQkJNnfHl/x7Ttc
         N0+w==
X-Forwarded-Encrypted: i=1; AJvYcCUcKacxyukppG8XA9DtC2kgL4cLvP14L1FhPIKfrzzX/2MRPzwXZxongCGWEDQrLPQbHuYoiWlIVJEghFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8TdyKA2oCsqbfjqyyxpVDUwWxj9POiblniEDhen7Q9SZKJomj
	W+7qWm7NHycr20m0UDpWv6DV4isM7/D0cVhrJbHPh/bdIsLN0H8gRhmBiAFB5GIUOB27bPBf3Vn
	2WeXph1sYRtt2RzxfkC++DL7ugg52lS1InDMlP8095Z8ffg+c7eEGcl33tzjphJjR+DrdjHfjr4
	/bGp2iKoXZIddlOBSVE5XvK8YN5NF99/syBt+leaKH
X-Gm-Gg: ASbGncu642i6MhJc0xzXpvrdS76z2Pvex5rh86UpeKcHRlasUMdVG7/zkXiiblkuvgt
	meeNfIxJnLAIXJ2aYaIrxCDC0HHjg3lC8RrwYqIY4LPVzwT8fCfhGScrgzNB2elSnZbC/f0TaaO
	ESYvS4CTxbXt38qt/9W3DNTQ==
X-Received: by 2002:a05:620a:1904:b0:7ea:793:2cde with SMTP id af79cd13be357-7ea11075778mr928997685a.82.1756048210378;
        Sun, 24 Aug 2025 08:10:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXOSfm4gX7dLdxj7N19GRN/1ONFScCsgWhzR2V0XBoYIj3yyJaY1ibHr2H3zP0OZ8R0SE3OmQyn3DV+vtnM6U=
X-Received: by 2002:a05:620a:1904:b0:7ea:793:2cde with SMTP id
 af79cd13be357-7ea11075778mr928995085a.82.1756048209980; Sun, 24 Aug 2025
 08:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821170419.70668-1-gpaoloni@redhat.com> <2025082120-emptiness-pencil-6d28@gregkh>
 <CA+wEVJb-yBYZqnVs_D4VYvqYsG1k=BFsPzp3ms1=646q3dCLKA@mail.gmail.com>
 <2025082209-laborer-hesitate-76cc@gregkh> <CA+wEVJZntQ6Fx8VWzL-PpKWw7=vxKQewxkUfu_f01Px2EFtRZQ@mail.gmail.com>
 <2025082352-ending-immerse-fee4@gregkh>
In-Reply-To: <2025082352-ending-immerse-fee4@gregkh>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Sun, 24 Aug 2025 17:09:57 +0200
X-Gm-Features: Ac12FXwAK5HzD0ya2jJ0WZLIYd5g6AoM0UQkpjrYqQFwOOwPKhpb1Myml64Mw1I
Message-ID: <CA+wEVJaGGQUisvKxk=1xxJWbao5iK50jByt244weAUvy0Hkc4g@mail.gmail.com>
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, 
	safety-architecture@lists.elisa.tech, Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 10:01=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Sat, Aug 23, 2025 at 09:48:32AM +0200, Gabriele Paoloni wrote:
> > > > > > + * - The file position '*ppos' shall be advanced by the number=
 of bytes
> > > > > > + *   successfully copied from user space (including skipped by=
tes).
> > > > >
> > > > > No short summary first of what the function is supposed to do nor=
mally?
> > > > > Or are you relying on the few words at the top to summarize that?
> > > >
> > > > Function's expectations would define the testable behaviours (so th=
ey
> > > > are broken down into detailed expectations); nothing prevents to pr=
ovide
> > > > an informative intro above "Function's expectations"; I could clari=
fy this
> > > > in the patch for the doc-guide  and revisit this patch with informa=
tive intros
> > > > for all the functions....
> > >
> > > "testable behavior" is going to be very hard given that you are
> > > describing an internal-to-the-kernel function.  Good luck!
> >
> > Well that is something to be figured out (step by step :-) )
>
> Well what is your end-goal here?  Do you need/want all functions in the
> kernel to be documented like this, or do you only want those that are
> describing user-visable functionality?

Yes indeed. Possibly we could discuss with the KernelCI folks how
to define test cases and trace these to the code specifications.
In terms of priorities I would start from the functions that are
directly exposed
externally. I.e. those that specify the behaviour of syscalls, interrupt an=
d
exception handlers, exported Kernel symbols.

>
> What is the requirement that is causing you to do this work?

The end goal would be to enhance the dependability of Linux so to make it
easier to adopt it in mission critical industries.
Depending on the industry and on the target integrity level, there can be
different demands on the documentation depth, however in general there
are two key principles that determine the dependability of SW:
a) The SW must be specified so that the integrator knows the expected
behaviour and the assumptions of use to be met to use the SW correctly
b) The SW must be verified (through tests and other measures) so that
it can be trusted to behave as specified in point a).

Now regardless of the target integrity level, the starting point would be
to specify the behaviour that is directly visible to the user and to kernel
drivers (as mentioned above).

Many Thanks
Gab


>
> thanks,
>
> greg k-h
>


