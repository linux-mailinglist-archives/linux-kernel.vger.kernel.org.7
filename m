Return-Path: <linux-kernel+bounces-790688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FCEB3ABC5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331DD567C21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922D629BD82;
	Thu, 28 Aug 2025 20:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JwX2w2/e"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E45287506
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413471; cv=none; b=cCGwHPROr9pXupbzE2ZrSpEqq7IAVyCEKMjgjYjG3J/P07piOjCJ4pYk2JNCtOXFeW0Zea9CRW2qI4HumZdrAesWTAqB4qQG6OG6rFYaD2a9RNy8VSnVrzJ05elLv86Mi4X6+spVaCZOgMVmdy7uE3+H9MKOZCDPbXdxdJHCjYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413471; c=relaxed/simple;
	bh=y4xkTZyyIp9xVQ83g6/iKJQ8eneIBd8o2R89VeAI4cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KaPEHAEIMDUBRGO1F+mdL5MWPmVMmTgEACeKauJCoqBLrjEsWiHsmL3ZvNrBdiDcl1BSrBAYxEdKwLejMWe+qfW0rTluoHw+zpTrzU/VwQ6KEIWYKL0Lu5QD8f2M+lxw9rb5jnhL/6rKZA9a+MH8EewKNA70AmxezP2uFwwT/VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JwX2w2/e; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb78f5df4so241826466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413467; x=1757018267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGpm2okOCdPx1/l3bBzBQf+T/Xu4e5L+15QkBeqqePM=;
        b=JwX2w2/eFZ9naCVlu8Cn0Tar+zaOWkDRz7rkz1/6Hvdyxw9clBvPtCOT31zI6ezEwa
         CXzFttcAtJywAqsKBN60wb0gj4IxKiFQml4W9FX7DzUDn5wKxK9hAmBPiCAtgY6PrdfZ
         YDUAhujdA24vIJEeo0n0EWNakRsVrHfEvhsac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413467; x=1757018267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGpm2okOCdPx1/l3bBzBQf+T/Xu4e5L+15QkBeqqePM=;
        b=rfEPoWlEEJU6d2Lkf+FfA7+IUKn8guA+jHBi+wggSEgC4VrkreRCO10/dZrJo1Vfo3
         FFKD6QhN59bcJnC5OUVJqlcKDJNL0TWr/xIuOtM7SReNQuC52qyJfL5u3TLx87q7JTEf
         /ZB11IIKhS0GlOTaNSVYtXyG8Pd3YmCyOvTFfXiZ+rC5iGnfLS9io5jMtb+lJZkVX4VP
         dhtIhOiFfhVbnVnF/MnrePgZm/zYrBUR/XhhiYLd5otD47X2qOr2XYdme2sIGUaDlbVd
         RNb9FVXPCuZw4sw0p3V2MkGfmCaglJH1HuC7hXOS+uh/izuX1aFUqn808yj4tDvPzIY6
         pCyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPYYzi3GnfZtd6NumRP2osHAASMBE0IXLBpJrFZ2Zor7BtwznrLVO+2TM20yA/CnVHUuuDyjrnTe/eptw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3y5Ry1PVlPjVvbOrlR2ZHrwPq04Yhn05QJ6eF5YOGurSGptjD
	cWz7ZMwUB+RC0w11YKRFKfDQsZaAvCEWqW3zdrwqHtcUk0vymGDU3A14Jpqz8MNCA+p7Qq+gpq5
	HRFJzDRs=
X-Gm-Gg: ASbGnctrJ0socmIGGnv9mlUdFUylUUN31pe3dsPB3yCncp9Z+hyl87V6RPWMG+RToJ2
	vsjp4kIi1NqXLojT2CzgFAjys6a0wD7zVoslYZClPIk0skQ3bDVzJ4iWL940P26gGbu91TxO0vb
	j3hgVP7WVCt7m/VMcNnuLMBn3SED4hgUsnmFpiIYuUVOZjZrcf5VZFeHFlDEF52htCDFuOB8VdB
	ojzDK+nFQHN6A5rB0ByYIaaqS5itYENaPJdGL+Vblc4Hi3s3mHk/ZP7o/D6WviQBaWiJW6usajx
	5NPfWkf4WDAq7vpWoRUe63a2TZZKKkh0xk/pQv6JOIM1s1NWiyLnH6PxV8MO3x31Q/MOHrjvbew
	2mKLFKc2S+F4skP2/MPOpL6A8Sry9qiQeHEMBCBzNFwuSBHqpE/jw05O+1ELbh2jpfkfyzw1A
X-Google-Smtp-Source: AGHT+IEYymIZqnkIbOLXG7Hhxp38Xn3BGjUKE8h1/VVF66VHF6o19CcpGFLs8YaE6x+HgUVl8ibtiQ==
X-Received: by 2002:a17:907:1c9a:b0:afe:c1e4:5562 with SMTP id a640c23a62f3a-afec1e45726mr836742166b.30.1756413466982;
        Thu, 28 Aug 2025 13:37:46 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd6fd2sm34495766b.55.2025.08.28.13.37.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:37:46 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afede1b3d05so249192266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHiq0mCubZimzuwaaiG/3PEsdUTswjmnbHivwv/+Q7hJ9dbD7MRhGFIsy3xz3hO0Zgt90mjm4vlwlmzyY=@vger.kernel.org
X-Received: by 2002:a17:907:1c17:b0:af9:1184:68b3 with SMTP id
 a640c23a62f3a-afe296358ebmr2525636066b.55.1756413466215; Thu, 28 Aug 2025
 13:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <aLC2Vs06UifGU2HZ@x1>
In-Reply-To: <aLC2Vs06UifGU2HZ@x1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:37:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiELUbwzPCKuA7xbN5SGyZSD12q6W6=eK4NfHDcMY58Zg@mail.gmail.com>
X-Gm-Features: Ac12FXwzzxmh7ZDt_iicZFn3gldj2XWLlsQdgYy8wB5yLOCnfQ4IOOdrcFwGY8M
Message-ID: <CAHk-=wiELUbwzPCKuA7xbN5SGyZSD12q6W6=eK4NfHDcMY58Zg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, 
	"Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:04, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > That said, I think they are problematic too, in that I don't think
> > they are universally available, so if you want to trace some
> > executable without build ids - and there are good reasons to do that -
> > you might hate being limited that way.
>
> Right, but these days gdb (and other traditional tools) supports it and
> downloads it (perf should do it with a one-time sticky question too,
> does it already in some cases, unconditionally, that should be fixed as
> well), most distros have it:

So I'm literally thinking one very valid case is debugging some
third-party binary with tracing.

End result: the whole "most distros have it" is just not relevant to
that situation.

          Linus

