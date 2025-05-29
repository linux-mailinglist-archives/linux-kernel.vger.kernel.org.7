Return-Path: <linux-kernel+bounces-666458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33FEAC770E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80F8E7AAB69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE4A24E019;
	Thu, 29 May 2025 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fiJy4fdN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAE24A07F
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 04:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748492054; cv=none; b=vDhMBU2fZyuNAP4p0FdVquymYmVq5vzEzEALx4IYshL64q7SkW1yy5onD9SvgCxJfVoFTvVITzhmX24FFnjnesv0Daw1Xg0g2KnzpYlJ4XrKUw3tky+S6AnGJ++DB7p5LKV6TEnhIHAGrqqqGAzylZRPadSNmAr4XtcJK6xFnzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748492054; c=relaxed/simple;
	bh=TRiBrZtZLp7fMUSE080O6cwCKmkxt3TgoZAV9VRK0iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIqmRya5P5ASlZCVilSq1Xsuv+4CsvPKc8CVMDHy6llQ6BqLqqLIMMk16A13jT0/Xolv5rvS9+RfsCo3v9Wiz1P5BIJVq41LKSLJjxYgLsyD8V8bp0V0WMrruwaKfJ1UuvjE8FweO2AgS9mlDO7dEUXtdetX1GmOMlmyOAyA92A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fiJy4fdN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748492051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTuUac/kp25gU0dpv6T903TN/Brxa98Rb4iI8HbABdo=;
	b=fiJy4fdNr1dB8l/YQokxIGjXtE99Hsn3gLhsfzSRzfdR+Xj0vhaHgHsU/fVEKPKThs2zT9
	e3cNpyNP9f/3auVUgIoGs4ABpPDByHoB6YGBzwRbA/4uAJy2Hgr/EhTKyupPbN9gDWKQVX
	W7PYB4IBxn9ScMrvprjtaN4cGy6AWx4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-kecQk4A4NC-rGfvnyQpexA-1; Thu, 29 May 2025 00:14:09 -0400
X-MC-Unique: kecQk4A4NC-rGfvnyQpexA-1
X-Mimecast-MFC-AGG-ID: kecQk4A4NC-rGfvnyQpexA_1748492048
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b0f807421c9so378336a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 21:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748492048; x=1749096848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTuUac/kp25gU0dpv6T903TN/Brxa98Rb4iI8HbABdo=;
        b=Z8e5qLt77EVGUKTVyPbUr0gm7ausb54lUcDlbYB155FJXdxPSbVw4n+Aov9zOYbNzq
         HdX5+R/eV1v2bdbFl/S21RWOVixW89P6BBsmK+dI5Nd62S7Gh2mEv/W19pdeVwjRl+3Q
         3fQpfmV1RrTeLK672/POoe9Mhnzpr5uesJjO4QsTlNqDZuYB2ZUWnnX+bSOCNBpvmMvu
         fKZOCc2vMNNarLIb7rD9mDdOag8+cuhaypV3tAOwZkFosnMfdEM8cvYzFpCzyQDVVhm8
         ymbCGHU3DILtf9PZBnTJL6d48WjoX9qXxmUm/2+xaYOt8YymNsJVsTPxJvLMBa/uymSC
         WpgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0ywAnARijU3x4v/cg/8ylp6nBW1mSE31EL6yG9AUqTs8Bu1KFxAyNqFVZ7mcnuoV0SS5PbuWJhANEkag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyuYaXTRv4xQW05XP4QBwd9Yi+Shhm9PGnsXp/xG2PhBLXzw1t
	2UMzb+/IgXyYhkAG4AbGrywfTJAz8qA8dPjT77yOYDg4Fc9BcYh/Bf3Z10UvruUWUVCCcPIJ5KI
	/jIgB8UnhNDIfhAgztdpLHSQjg8Yhp0utzrVKQ5cmoqnz34o0h4OU3jZN10W6BqMktbiYx0fXPH
	0R33xkyEb0zk2/SiBdaBWFyzqVLprnjcWhd5fCa/hC
X-Gm-Gg: ASbGncuhZ+CdcwEY8El0sO1SMoM5WENq4y3C/VhvBwMDg9bZ/HLaSjzKSP1nOIDsQwW
	e0/AfvNMgrOqXFKZIobU8pebA3OJFPqDFynQ8dhoD32uaUx2Tsi/tzuN6To0Yegtc+nt07Q==
X-Received: by 2002:a17:90b:350f:b0:311:b3e7:fb3c with SMTP id 98e67ed59e1d1-311e7470ad2mr6043683a91.31.1748492047892;
        Wed, 28 May 2025 21:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJlBab55b5zw2yF/0qOrDv/7rcdItifY9mMu1pnfIqfsxVzRej8fOLqwH/iIyya4HFe28Cu7wYMPHCD64nqOo=
X-Received: by 2002:a17:90b:350f:b0:311:b3e7:fb3c with SMTP id
 98e67ed59e1d1-311e7470ad2mr6043655a91.31.1748492047430; Wed, 28 May 2025
 21:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515233953.14685-1-bhe@redhat.com> <aCaFNvHbYxrCaPbe@MiWiFi-R3L-srv>
 <1d2848fe45dbf58707cecf16c4fc46b179e24415.camel@linux.ibm.com>
 <aC6Y3S9hEB1snvwj@MiWiFi-R3L-srv> <c0f1df02160138d0782cb897eda844287b3d7792.camel@linux.ibm.com>
 <aC86NSypHlER2C3L@MiWiFi-R3L-srv> <CAF+s44QHJs8J27TEy0AW1m2wT=LRSz59nHf-8AuqL8px_zKGUg@mail.gmail.com>
 <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
In-Reply-To: <0e794fc984c8f37a6d3eb5acdb6cc094f14df940.camel@linux.ibm.com>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 29 May 2025 12:13:56 +0800
X-Gm-Features: AX0GCFsd4RqYWFQIJl58p55SOSnLlBoBDcDzdR7DF_r9JTI4jvZQrXBHdfSkduk
Message-ID: <CAF+s44Q6ZJ8rdi1VG40JVJmxX-1hmss5eNaKvGhJSOS6xYLx-g@mail.gmail.com>
Subject: Re: [PATCH] ima: add a knob ima= to make IMA be able to be disabled
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Baoquan He <bhe@redhat.com>, prudo@redhat.com, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pmenzel@molgen.mpg.de, coxu@redhat.com, ruyang@redhat.com, 
	chenste@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 10:18=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> w=
rote:
>
> On Tue, 2025-05-27 at 11:25 +0800, Pingfan Liu wrote
>
> When responding to kernel mailing lists, please use plain text not Mime e=
ncoded.
>
> > On Thu, May 22, 2025 at 10:52=E2=80=AFPM Baoquan He <bhe@redhat.com> wr=
ote:
> > > On 05/22/25 at 07:08am, Mimi Zohar wrote:
> > > > On Thu, 2025-05-22 at 11:24 +0800, Baoquan He wrote:
> > > > > On 05/21/25 at 08:54am, Mimi Zohar wrote:
> > > > > > On Fri, 2025-05-16 at 08:22 +0800, Baoquan He wrote:
> > > > > > > CC kexec list.
> > > > > > >
> > > > > > > On 05/16/25 at 07:39am, Baoquan He wrote:
> > > > > > > > Kdump kernel doesn't need IMA functionality, and enabling I=
MA will
> > > > > > > > cost
> > > > > > > > extra memory. It would be very helpful to allow IMA to be d=
isabled
> > > > > > > > for
> > > > > > > > kdump kernel.
> > > > >
> > > > > Thanks a lot for careufl reviewing and great suggestions.
> > > > >
> > > > > >
> > > > > > The real question is not whether kdump needs "IMA", but whether=
 not
> > > > > > enabling
> > > > > > IMA in the kdump kernel could be abused.  The comments below do=
n't
> > > > > > address
> > > > > > that question but limit/emphasize, as much as possible, turning=
 IMA
> > > > > > off is
> > > > > > limited to the kdump kernel.
> > > > >
> > > > > Are you suggesting removing below paragraph from patch log becaus=
e they
> > > > > are redundant? I can remove it in v2 if yes.
> > > >
> > > > "The comments below" was referring to my comments on the patch, not=
 the
> > > > next
> > > > paragraph.  "don't address that question" refers to whether the kdu=
mp
> > > > kernel
> > > > could be abused.
> > > >
> > > > We're trying to close integrity gaps, not add new ones.  Verifying =
the
> > > > UKI's
> > > > signature addresses the integrity of the initramfs.  What about the
> > > > integrity of
> > > > the kdump initramfs (or for that matter the kexec initramfs)?  If t=
he
> > > > kdump
> > > > initramfs was signed, IMA would be able to verify it before the kex=
ec.
> >
> > IMHO, from the higher level, if there is a requirement on the integrity=
 of the
> > initramfs, it should take a similar approach as UKI. And the system adm=
in can
> > choose whether to disable the unsafe format loader or not.
>
> Yes, that is a possibility, probably a good aim, but in the case of kexec=
/kdump
> that isn't really necessary.  As filesystem(s) support xattrs, IMA polici=
es
> could be written in terms of "func=3DKEXEC_INITRAMFS_CHECK" to include th=
e
> initramfs.
>

Just aware that we have such a cool feature. Thanks!

I checked the code. IIUC, the relevant code has already been in the
kernel. And the thing left to do is to install an IMA policy, right?

But there are still two things to be considered.
-1.The UEFI partition is FAT format, which can not support xattr
-2. Just like in the UKI case, the kernel fd content is not necessary
for the kernel image itself. The initramfs fd can be used to pass some
extra data if we use a temp file as a package. So checking the
signatures at the initramfs level will block this usage


> >
> > This other thing is how to make a handy signature on initramfs? It is n=
either
> > PE nor ELF.
>
> IMA supports signatures stored in the security.ima xattr or as an appende=
d
> signatures.
>

Good to know it.

Best Regards,

Pingfan


