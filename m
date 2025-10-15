Return-Path: <linux-kernel+bounces-854419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75433BDE52B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7B6F4274CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03CD322C66;
	Wed, 15 Oct 2025 11:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUWjeze+"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66EB322A3D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760528841; cv=none; b=V6dUbchJwlaybdtrbHbLCvZMS+91WGlnE8WKKAfC/b/mpOYIpWVLJ0nAxneXh1KsuRgyEQAxtX0B8Wf+V5rH4B++RXSfM/8FNeSwqEdGoEY7Zjl2tZaYkn7jHRgMq1ceP4SHTITRFZKc7F1qJgGF31H4VF5fiZOzo5B4kffR6ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760528841; c=relaxed/simple;
	bh=K8Ef9394U0xGAO1FYDn+Orh4zfOf8Xw0fy6jgoX6rKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIc8kBhseawq3oYl//oALZprM7zKKJwf3JEzW2uiWDtAJNR2E80/mzqosEcd0igYCH4QU8tN6dHZAAUz0vAzI4dDlIUzqVun51HNx/UmwZJaqZ1Sp5I5owZ7XyxN9FpxN3eu17GOANjSWmXMlnuI2IwuFuDrjlZWupkfP/4QaQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUWjeze+; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-368348d30e0so55435651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760528838; x=1761133638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kjD7nlR2YEzkS0lnkW+YD90/WFAnc1y24O/rAXSwJ4=;
        b=cUWjeze+0jn+DyGKQDUKmZdDgaBIws4sKGEIUXggyi/qc3KSaJoLEBP99bUv8PrDRR
         7MyVQNPi+gJgBdaoj2KA2oPPW1ch+MZvnlx9y7brtgTdAWKhsW0FgNaB6KH37seNTae7
         AFh98HJJhw1ggckArc0L+Q1jJ45leg3eLCUAILo9kEYOCslYJoo0T0y1/abdUZFA6PpQ
         6hwe2snxGdmPfxwPpJD6zQCJDdQTtO7X201LIw5tHvSX5VI3HChhGRZZY3kHstgll7hp
         +K+viBLvmK6oEg7PJGBAdA/Gd2EVA/OzHJGLhCt4i5R5CDdaoR6nTDdz/z31Gc38R5wf
         P0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760528838; x=1761133638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kjD7nlR2YEzkS0lnkW+YD90/WFAnc1y24O/rAXSwJ4=;
        b=o8+z4PKzr2o6mmLrnjWAYwV9rYxjkbRkhRKQj5hyrdOI50/nOGCXRRY2bEUnYIqUQm
         Y7JQBb7zlsAPB0LY4sEvQEtPXwauwjqqxUXYicTK7UW8LAoC26GTcMhBpuY302Ha8U4R
         B5bWHqo9D5iE241BtAP9b1dp5rxDzeVvz6xJkaZiZhX/Nz8WT/2WQ8/IjzBE5uRsphFD
         kB0tkHWeMwClKC1jh4B+wiYx7SmaJz49yo5tq9v+bdy2yG8RSy7wP2toJIbYT2+8EWcV
         OcHfoD7RtseGcovruXgaeW9PMBprwyH26vb/RxqksCBrYN2pGHoiaxgMyo39FmmzZKqS
         oSlw==
X-Forwarded-Encrypted: i=1; AJvYcCUn9TNLVKm+oMQ/MgFHBOj0RdTYJ37bQJARTdzbkfbuZ1N3KNqixblGoVAgpjB+J3Vtfj8qoG0YnSp3dSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEkJu2J0nCtZ7ww5tLUyzvItgV24Lop6va9G1LFVsxLPg7aBS9
	zN+Yq5+j6+mhqjEVR7B6PVKQhYmMqHcPS4vqLzZIusT+U5rBltlBFTcxY7Tfb1FKVMyAxBGWbDY
	SDK4HQjUlgPNLvL74TdmUfqNCIgGw7/U=
X-Gm-Gg: ASbGnctRFyXIHhF8ws/MD/jbx84GCdBjpR/rtSuBpMeEoJJ5nHWcsePbstsVKmULWOs
	SrZdqD1eBnrzb6CtZhz8Uylisb3fLmlo5Za9R3rQCmpF0rgFkOMwjzCdI0u8/Nn+5NlKiUby7mC
	h86TO/6+JFB3CTsAyRujiqKKO6jZtutylo50lIzD2M9cLNE5Nx/jOEsnTZUOJEDH3hf2XX9odxV
	A6J5mwHfccrTnosLUJDKlmUVFeYXArTXFQUAw==
X-Google-Smtp-Source: AGHT+IHB7Q6zZZMGHVTDzzBJ7VX3uS6ZTaxkupI5fWKfSKIZBSRc8BqdSXDaczSqzz1xMTR2k41s6xuNNoZwhsfFZGo=
X-Received: by 2002:a05:651c:1543:b0:36d:54b3:9f71 with SMTP id
 38308e7fff4ca-37609cea713mr76878821fa.1.1760528837594; Wed, 15 Oct 2025
 04:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
 <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
 <20251013161429.GE77665@e132581.arm.com> <CADHxFxQg2ZKwLEOa6wic_KP49PRBp=hF=cY16aVmR0O0pa8ZkA@mail.gmail.com>
 <20251015093037.GA109737@e132581.arm.com>
In-Reply-To: <20251015093037.GA109737@e132581.arm.com>
From: hupu <hupu.gm@gmail.com>
Date: Wed, 15 Oct 2025 19:47:04 +0800
X-Gm-Features: AS18NWAkVWEMyCdv0-Y1CwBUX6NfnUpUNHXCsHsXsJw9gljovloSmphazhBJKPc
Message-ID: <CADHxFxQyOBurB0LB9qRdc3DEDNU+vatqOybNdcizPnWZngiPZg@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: Leo Yan <leo.yan@arm.com>
Cc: Ian Rogers <irogers@google.com>, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Leo,
Thank you for your reply.

On Wed, Oct 15, 2025 at 5:30=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Have you installed the GCC cross packages ?
>
>  $ sudo apt-get install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
>  $ sudo apt-get install libc6-dev-aarch64-cross linux-libc-dev-aarch64-cr=
oss
>  $ sudo apt-get install libc6-dev-arm64-cross linux-libc-dev-arm64-cross
>
> My understanding is arm64 cross compilation tries to find headers in the
> path /usr/aarch64-linux-gnu/include/ (I confirmed this on Ubuntu/Debian
> distros).  After install GCC cross packages, the headers should appear
> in the folder.
>

I hadn=E2=80=99t installed the packages you mentioned earlier, but after
running the installation commands you provided, I was indeed able to
successfully build perf.

In fact, I=E2=80=99m currently working on creating an SDK package, which
includes a cross-toolchain that I built myself using crosstool-NG. My
initial idea was to install certain third-party libraries (such as the
packages you mentioned) into the cross-toolchain=E2=80=99s sysroot director=
y.
With this approach, even when developing on different host machines,
we could simply specify the header search path (pointing to the
cross-toolchain=E2=80=99s sysroot directory) during compilation, and the bu=
ild
should succeed without requiring any additional package installation
on the system.

Based on this, I think allowing users to extend some options via
EXTRA_CLANG_FLAGS could be a flexible way to handle such cases.
However, this is just my personal thought and might not be entirely
correct, so I=E2=80=99d like to hear your advice.


Thanks=EF=BC=8C
hupu

