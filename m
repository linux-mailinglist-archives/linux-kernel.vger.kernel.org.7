Return-Path: <linux-kernel+bounces-878707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F3C214FF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 803774E6F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A07A2DC33B;
	Thu, 30 Oct 2025 16:48:41 +0000 (UTC)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4333B286885
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842920; cv=none; b=rir6oFBpRKvwNsrOtKjKWAp9VGW2Xr2ElExebG3hM1N95TUR899r7gO0Y0l3sxsuhW3DQAYK4XXSx8bb5Wr19v4E64pUygtkpYZkVJPeAJbzyc40/dXKgMIzrIR+nTszFXMg4oFgOmvE5t52CapMyOLBpJRcmovurWJuAL6MDr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842920; c=relaxed/simple;
	bh=p14RUDeAUGxmUyMq3WOavZ7XrOgeM8GVTwdiO+BNbys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmxXGA8gsZvgN1zbW2QaPY+xSOL/aL5jurjemJ82bLzlcpyNm1i83qPvV6NaeAD+C7SSTYTAbY4If9JQZrETT04cecnbqn2QXrc13pX/3H6DEgdQa2d12Oami+7/F6kLEfjQMB5pE88SXv4slE21XX67aXPRHYoxxhSEQEhnQec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-89018ea5625so668966241.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842918; x=1762447718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hreLLxVwoZIv1vtrLF1uQpFX+MBHZRjdsbs+eOIPXhU=;
        b=WvQtnLOdmbpENoS8DOsRsl8+InQ5wuffVwMHnMI4+GzmOSV3Ixk/FFYZWvelSBbvpc
         UYfe/9W/W6+ixYcwKKcpbCqW/xpTNvAQ7dk7NS2MbTe+tHotBHY7NaBgLvEfScSgkSSe
         JfcBn+sGkejMeTrMMUHHG6EmLx3EEcsCDxJOIFj6fMPtCI0j1iweIjW1044fhgEr9Psk
         adABACvSf0+it9X7aol6wLDg8OTHCtvW4lWE/r/JXakaTTii7MrgBWhmytetqblgwFNJ
         yhtHy/nffBQnvb/38JOWOXTGjtZej4HAtfVu8bi6NPLvav6NtRZbhsnKEUYt/hjuw+c9
         rq8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQvCK9ketmPa8wvhTaPJRlT0SdFJcrvIbxsLFSuDVCYJbC2QRUQp+XmtiZU+O+0a6qEDau4D09kah8lco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8fM2XZuuq+Ma6UN1GBhn48pIL6nMpKO30CdIccFa0uBKnoHVX
	BAEkVtQBHLTMHJ0CNyJ00OA0rtfxnhk0Eczxb7lo2l8GgqgMomRxzc1gdoCxUA==
X-Gm-Gg: ASbGncu4ifU6jgPQ4ruaTtsSiQajPeCFOtQ+TxAE3e5qFZrfPQqgzxJ5ic7OiFQGGRv
	20hTzWfxE2awnBE/B7Lz+GKGMPJAEEVMIJC950WuT3kRCyq0aAPu97wU0v9CNDL8r53URyQkYP4
	+9CA+W/gDi29tPQTH/YEBs0zd2VXrEUdjpkmAJxn8qltZwxy1dPjNDpUXxKCe/kVzodYkWpHNxV
	N2vv2P9QxQ4vm135qZhGWOmzWCREJ6d5UfdSfM7phaKVM8qHSdkkkYd1IPYPDWrF4Bginqel7xx
	zUiM0L6WhWxyuGDMKbRtMHj08ti68H8+3hmshyE+gMpNf1frzGwYkHrf6Zhs7kIZbDkc62TY24f
	+aWFp3QGkUb6Qix+yszHz0g5TbNjZE+d6LGZg8zzhvHi0z+FTQVZ9Hpqf7UUygVW5/EFwJCr49a
	LAs4bMoTek7jFNB2FTag/loSTyx5mAVFByJ/pmvW5G
X-Google-Smtp-Source: AGHT+IGsLptbyL/GKqJTadLcwowpJb/gSSzE0Jbi/v7thISlo8NcI9LTH5pu/ciI6oDuaPD0xLB2kg==
X-Received: by 2002:a05:6102:3711:b0:5d5:d1ba:439b with SMTP id ada2fe7eead31-5dbb123081dmr86199137.11.1761842917665;
        Thu, 30 Oct 2025 09:48:37 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9350199dafbsm817625241.13.2025.10.30.09.48.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 09:48:37 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-934f0e9d4afso646977241.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:48:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGX5Aktuw4uhPli5T0H/grVezePlF+iHjJCboaEOqj0sInO9iQ+/ULVFbwhcTudvA+/QHkGi2CPB7Qkjw=@vger.kernel.org
X-Received: by 2002:a05:6122:8c0f:b0:54c:da0:f711 with SMTP id
 71dfb90a1353d-5593e2ffd39mr273505e0c.7.1761842917258; Thu, 30 Oct 2025
 09:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr> <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251030102626.GR3245006@noisy.programming.kicks-ass.net>
From: Fangrui Song <maskray@sourceware.org>
Date: Thu, 30 Oct 2025 09:48:50 -0700
X-Gmail-Original-Message-ID: <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
X-Gm-Features: AWmQ_blRN2P8E4UpSirTqfChk89fbu3buxosHqC3dg5TrVhE_4RGdVBUnlMBtXE
Message-ID: <CAN30aBF3MofmVTjTZ9KFq9OBM0nA16amP5VFv+VAEJfFkLx0qw@mail.gmail.com>
Subject: Re: Concerns about SFrame viability for userspace stack walking
To: Peter Zijlstra <peterz@infradead.org>
Cc: Fangrui Song <maskray@sourceware.org>, linux-toolchains@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 3:26=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Oct 29, 2025 at 11:53:32PM -0700, Fangrui Song wrote:
> > I've been following the SFrame discussion and wanted to share some
> > concerns about its viability for userspace adoption, based on concrete
> > measurements and comparison with existing compact unwind
> > implementations in LLVM.
> >
> > **Size overhead concerns**
> >
> > Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is
> > approximately 10% larger than the combined size of .eh_frame and
> > .eh_frame_hdr (8.06 MiB total).  This is problematic because .eh_frame
> > cannot be eliminated - it contains essential information for restoring
> > callee-saved registers, LSDA, and personality information needed for
> > debugging (e.g. reading local variables in a coredump) and C++
> > exception handling.
> >
> > This means adopting SFrame would result in carrying both formats, with
> > a large net size increase.
>
> So the SFrame unwinder is fairly simple code, but what does an .eh_frame
> unwinder look like? Having read most of the links in your email, there
> seem to be references to DWARF byte code interpreters and stuff like
> that.
>
> So while the format compactness is one aspect, the thing I find no
> mention of, is the unwinder complexity.
>
> There have been a number of attempts to do DWARF unwinding in
> kernel space and while I think some architecture do it, x86_64 has had
> very bad experiences with it. At some point I think Linus just said no
> more, no DWARF, not ever.
>
> So from a situation where compilers were generating bad CFI unwind
> information, a horribly complex unwinder that could crash the kernel
> harder than the thing it was reporting on and manual CFI annotations in
> assembly that were never quite right, objtool and ORC were born.
>
> The win was many:
>
>  - simple robust unwinder
>  - no manual CFI annotations that could be wrong
>  - no reliance on compilers that would get it wrong
>
> and I think this is where SFrame came from. I don't think the x86_64
> Linux kernel will ever natively adopt SFrame, ORC works really well for
> us.
>
> However, we do need something to unwind userspace. And yes, personally
> I'm in the frame-pointer camp, that's always worked well for me.
> Distro's however don't seem to like it much, which means that every time
> I do have to profile something userspace, I get to rebuild all the
> relevant code with framepointers on (which is not hard, but tedious).
>
> Barring that, we need something for which the unwind code is simple and
> robust -- and I *think* this has disqualified .eh_frame and full on
> DWARF.
>
> And this is again where SFrame comes in -- its unwinder is simple,
> something we can run in kernel space.
>
> I really don't much care for the particulars, and frame pointers work
> for me -- but I do care about the kernel unwinder code. It had better be
> simple and robvst.
>
> So if you want us to use .eh_frame, great, show us a simple and robust
> unwinder.

Hi Peter,

Thanks for this perspective=E2=80=94the unwinder complexity concern is
absolutely valid and critical for kernel use.
To clarify my motivation: I've seen attempts to use SFrame for
userspace adoption
(https://fedoraproject.org/wiki/Changes/SFrameInBinaries ), and I
believe it's not viable for that purpose given the size overhead I
documented. My concerns are primarily about userspace adoption, not
the kernel's internal unwinding.

If SFrame is exclusively a kernel-space feature, it could be
implemented entirely within objtool =E2=80=93 similar to how objtool --link
--orc generates ORC info for vmlinux.o. This approach would eliminate
the need for any modifications to assemblers and linkers, while
allowing SFrame to evolve in any incompatible way.

For userspace, we could instead modify assemblers and linkers to
support a more compact format or an extension to .eh_frame , but it
won't be SFrame (all of Apple=E2=80=99s compact unwind, ARM EHABI=E2=80=99s
exidx/extab, and Microsoft=E2=80=99s pdata/xdata can implement C++ exceptio=
n
handling , while SFrame can't, leading to a huge missed opportunity.)

