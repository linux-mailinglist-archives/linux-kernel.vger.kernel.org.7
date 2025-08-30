Return-Path: <linux-kernel+bounces-793124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BF8B3CEE6
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65DC56016B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401362DAFD2;
	Sat, 30 Aug 2025 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N9xjW2FA"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32CD27A47F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756580655; cv=none; b=GmuSVWPrdoA1lsWA6agthEVE6wl4tpN4waweTsWGp8ENEcwbue8YSO18qIWss6doCzRM84jnwILCIiJjFen56Ya0Q/h5732iOcVSO61wXX+Ho3Gdr+PiHSEAgNkB2dNx9Xz0oH2sT6Hpga7mLJUmMCZpY4sabURAh1ub94yULbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756580655; c=relaxed/simple;
	bh=APZRD3R5mQMFLWqOyeRR80xS4Xl7AJEaecu1Pv4PsOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RpyKmYvk1P4tCpX/8S7op3mCsYw3eLQU+8G57K0USHi/U9XjBpXuyrJ8/dxMq1yRGRn7z8vFu6Oof51KO1ATHlypF5YUymyi298jCl7sqVoO1XNaY3U83KwvQs6K8sz3f6zstTUYarrOs/H291AgNscytHN9SvaiofLiBwXgqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N9xjW2FA; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afeee20b7c0so410897666b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756580652; x=1757185452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7C7HDDF1V0ye1jSQLTEXSfhzx7+YOYStSyUtu7nMWFg=;
        b=N9xjW2FAZLWTnANDMuuUTurweSJVg+W+cMkhqkeQ+jIvV0MqgoK9mCVkCwb2WM7+sx
         2bpgNSOQrLMtF9ygUXM3HIJU7oWNS+pTyBzHJeCPmJwRug+jAV2IHOxXTbg7w5SIVw64
         e6hqg0dPcFO5a55Fokww6K2l5rqiHJbdhK4As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756580652; x=1757185452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7C7HDDF1V0ye1jSQLTEXSfhzx7+YOYStSyUtu7nMWFg=;
        b=jiwrknjZvMlrub3bvbrKS3OsARXpAZg545TIVuc2sSHa+zIeTCCb6AJz5vFXI6GbAq
         HU9tlN6EIgKwdg3y+C2u9QkpyzroZhXcVqV6r3DajaKO9whiCUNF8tycQMceI0j8ybAE
         vs2bKBTDzDhiAckKg9atMZ6BLieshlOX37uL2OfshmYmupBLOaXAlHPrbToMoHCkyuRo
         CYibtwnnWEbMjrN9d1p372rOdqfJ4APhelzutIRQpoWG1d1KXtyJZalAHeYWxIi2ndaQ
         2Ff99RR3oLdA2E3KOz1nVoljvdYw04ZmcdbcVxGPR/sGSXdBHrLIjLHcKW/yK96SDM0r
         oosw==
X-Forwarded-Encrypted: i=1; AJvYcCVx8Ydv69HlDH1+snUlM09UUj8T5V+k/OxjwgJZLDRAldBa7opEfPOJOHvbgWBE1Es5i5gJnJmJ3uq02VU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBrgYANqoJAvazx8xTHMwhO4yQ3midiqyNkGGJXzvFfer5rhi7
	Ou/bESkEr5FEbgXp92rhe8E8bzwQNVl3/AjK6bYhTi457eBB6wHRfumf6lBr2/WKz/dJ8B0H5f+
	dZ3xOTEiTQA==
X-Gm-Gg: ASbGncv/0/Efvk2baejBvzevwA3xmqJ5+owL+WajcKGvzjXMt7PiyH8TutxHWd/ItXr
	97vsqDou8XOo4srylRrVaeblY8WZ4LcGGyYLEEaxcYTzFTuixzmCfur+fM377oh53LH91OyPh+U
	SBcPVrTjSmH/1xJV6DNztP7AfCSfxra612YP0DCrwpjQgsVfy5szTrnuvX2B8ClPLh6G8p6HCvy
	Gt2N4Z5R8oOBf6FhgFGflCBCS3zSd1M/uJL/X4kNTmWFNOeQ15QIoixFJ+ovAuX8LiHJYNarfB6
	4ZfUgoYi+plcCqM/HPzjT9Z6FQJcGhgoZo7xLGjcnuFfCgTDmzfwshzxFNRzCqlY1Ol1HV+DD93
	+AvCK1p4Gg5ZNyMn9L1TPETw0ZUqXJzG3X+8VclqVCkgm5e29rN6on4/WXUBGTKG/pLnLvK1keT
	+cra7EvPs=
X-Google-Smtp-Source: AGHT+IG558e4ZlRaVifRtiHUDU+emPcnMI+T6n7BudTbgnQ6yQ1Hq9exBrPFOF0BCF8ZUBzM4zT92A==
X-Received: by 2002:a17:907:1c87:b0:afe:ca26:5490 with SMTP id a640c23a62f3a-b01d8a71328mr319261966b.16.1756580651658;
        Sat, 30 Aug 2025 12:04:11 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b040e6845f8sm91943266b.51.2025.08.30.12.04.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 12:04:10 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so25990a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:04:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBQ2WlMuKDNDaQyIr3U6FT/cevsDJDPBUEO16Vx4TNQuBSqHRDC5eqQ6RFhlKqJDWdMFtzJG7SAI9tPiE=@vger.kernel.org
X-Received: by 2002:a05:6402:26c4:b0:61d:1cbf:bb4a with SMTP id
 4fb4d7f45d1cf-61d26d7904amr2319235a12.29.1756580650360; Sat, 30 Aug 2025
 12:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828171748.07681a63@batman.local.home>
 <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home> <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
 <20250829190935.7e014820@gandalf.local.home> <CAHk-=wgNeu8_=kPnKwFpwMUC=o-uh=KjJWePR9ujk=7F9yNXDQ@mail.gmail.com>
 <20250830143114.395ed246@batman.local.home>
In-Reply-To: <20250830143114.395ed246@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 30 Aug 2025 12:03:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
X-Gm-Features: Ac12FXyz3WKCTj4mxXVo4xp6AMniUURUWjQ5DeVA017M_IaQp-7QOD-FOUdEOvk
Message-ID: <CAHk-=wjgXGuJVaOmftxnwrS6FafwrLL+yHrH6-sgbBRB-iLn8w@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Aug 2025 at 11:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> If we are going to rely on mmap, then we might as well get rid of the
> vma_lookup() altogether. The mmap event will have the mapping of the
> file to the actual virtual address.

It actually won't - not unless you also track every mremap etc.

Which is certainly doable, but I'd argue that it's a lot of complexity.

All you really want is an ID for the file mapping, and yes, I agree
that it's very very annoying that we don't have anything that can then
be correlated to user space any other way than also having a stage
that tracks mmap.

I've slept on it and tried to come up with something, and I can't. As
mentioned, the inode->i_ino isn't actually exposed to user space as
such at all for some common filesystems, so while it's very
traditional, it really doesn't actually work. It's also almost
impossible to turn into a path, which is what you often would want for
many cases.

That said, having slept on it, I'm starting to come around to the
inode number model, not because I think it's a good model - it really
isn't - but because it's a very historical mistake.

And in particular, it's the same mistake we made in /proc/<xyz>/maps.

So I think it's very very wrong, but it does have the advantage that
it's a number that we already do export.

But the inode we expose that way isn't actually the
'vma->vm_file->f_inode' as you'd think, it's actually

        inode = file_user_inode(vma->vm_file);

which is subtly different for the backing inode case (ie overlayfs).

Oh, how I dislike that thing, but using the same thing as
/proc/<xyz>/maps does avoid some problems.

                Linus

