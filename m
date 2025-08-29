Return-Path: <linux-kernel+bounces-792229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5FB3C1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222721CC2019
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CBF33EB03;
	Fri, 29 Aug 2025 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RlDU8ldG"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E4221D9E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756488063; cv=none; b=TE5Mz41I0kOvYSyxBqMTwc/RiKkOd5o8nmZubAuFxMPf2NOu4xV3UchwI7DKZbCnzZMukR8k225luJrsGuM/XgLsNjrUw6jpFRd9NZb6/htyXNB90HszuH8No9GldoTRhbHqp3owAPH3KKYa35agqGSRkRNSbs6OECJVzqmpPL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756488063; c=relaxed/simple;
	bh=iHb9WdSbAWsQISH5SeW0HmAsw6mcHOltHvAyxrfR9Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/Ax7Z9FvkLKDw2XlvYRWpbOqM74gLDygXy8GD4Hg8+nNP5J3QjKpJKdUAcio7tnWwMR/i5mSvLpTDutK6so5PFD3hswNrWdiXpo3hIkp31IKUDPyPZu5v8tpo+lin4UVuTWsZ9raw3IAvkopzSXMN0qLQEW7zG0lnXTAdQI6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RlDU8ldG; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb731ca8eso379923366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756488060; x=1757092860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKGIjOYE1ze9iH1dgqLKf8Xyy++WiMU+AjEh9bVOYgA=;
        b=RlDU8ldG4BSfOAll5l45nCLuc1arfApMKAPwx2RdhIHy28lgCkZ9Aqp1PyzY5jZksG
         sAhYaFSlKN8cIMH4T5g+Ju1mixo9eMwywZJ5So6+7LVywfp0XHo/DAMmGoVuaVKJ/4iV
         +5ESlvE2RSySpeMvhD50j8of3qZa4cKuKzeXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756488060; x=1757092860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mKGIjOYE1ze9iH1dgqLKf8Xyy++WiMU+AjEh9bVOYgA=;
        b=xSw24USj/Ss4e5ux+cFZn6jFj8IORCkou6CsPC938MAZfcvmruxXnxQrFTrQdtwSmO
         LyPIomdGk2IB1bcDoxW+iGClfBBqGQb95U11tN9O6Mszmgu4dI9DjpYoUDQje6e6Mb2t
         NK3uWvbRoQHBRhpcjE8Fg/6FOWshSfhh8aYLTDzk9i3pmiCG2mqsQVMywtI168KQCxV3
         brTnov932gtYs+c46b5tYek3z/tdIWGarjoZQyB/fq/oqZ+wwBbGTfCIBfua0pnxjPEL
         BiqMtWVqK3g4l3Zb2mJPDXM/cWd4Pb4iY17OgKuOXOYLgsHarIZLWnhg6NaCTPEVK1tj
         xKYw==
X-Forwarded-Encrypted: i=1; AJvYcCVLPSpyOXf0/1cj7GY46BpE8/F2DU/pznbbcXD6vh5SRFWDb4NOLJGPouyWcpDhLWCvaZ+s4eO3CiA7Ts0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaiXATYatVczHCMmuRGusnIwpHnVu/D8Odg7eNPREBbbIXcxUk
	pjLv/qKoQ/+WoIH9i+OZXCnlnyfDTbgJJrnczOCzIktPsIxRIQGop3Bcqvx1SwCi8ltwT8t2Rj7
	GPWkEccrqDw==
X-Gm-Gg: ASbGnctPG3jHaopImVmxrXCr4r/P0xo2wdled4AnsRe8W8RHBiV056xFMGS0D3krSeD
	MREu12H744MKATEc32gLTz77HKt7/O2NgD2NBNbg3lBOPcEns6wCZ8Cw3xBRwEwWBcHe4OlG21U
	/4QSnlAh+JMsVB2AnWs4U+JRUTgb8xMifzRvJfc7+G2ksXPs2e+Vay9ab/N5btho30tQ9LJfOeJ
	SY3aif6V+zM5RXjZU38tSESeIubWgOF6/AcxBYh4H3rL9kyh2XO80w3HFplPuxV9Z5YOWaGB9jT
	ljo00FTj5Ss1JoYD1ZGSZ0Xb7F08OHCt268v79EGu8wu9CRfkNUDWhbqExipQN8C3fZtWnnG5YK
	ksp9PJWOh3cqLUmPymOLEN/t0o5slN4JMTFU28iUdN25h3RQk5gzgHceed23GM4oClNHoh1iuRa
	l2UwmKj8U=
X-Google-Smtp-Source: AGHT+IFUVYuvhM0cqW9KHlZ01Kc7ZKzGG3JDeeiTKzhhVnabJ3BeZIS2XrRjIhItQNyovOwrz7mepw==
X-Received: by 2002:a17:907:86a3:b0:afe:8b53:449c with SMTP id a640c23a62f3a-afe8b535789mr1788210366b.34.1756488059871;
        Fri, 29 Aug 2025 10:20:59 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0f238sm242151166b.43.2025.08.29.10.20.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:20:59 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afec5651966so431589666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:20:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwVPf+kk2PoyDVVt1d5uLxqdoE0UhjtFzbccwSQg5PgFxUVgvDvnT1WJFMiJRlIm/MlWL96P6pDhNfH0Y=@vger.kernel.org
X-Received: by 2002:a17:907:9410:b0:afc:a190:848a with SMTP id
 a640c23a62f3a-afe2962294amr2593662266b.60.1756487629636; Fri, 29 Aug 2025
 10:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com> <20250829130239.61e25379@gandalf.local.home>
In-Reply-To: <20250829130239.61e25379@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:13:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
X-Gm-Features: Ac12FXzOUr821UWDaFJ2PkQOv_cHIiiBd9eyjGJVTqCl8VoWLaBc08lTL7Mwpbc
Message-ID: <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
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

On Fri, 29 Aug 2025 at 10:02, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, the ring buffer can be mapped to user space. So anything written into
> the buffer is already exposed.

Oh, good point. Yeah, that means that you have to do the hashing
immediately. Too bad. Because while 'vma->vm_file' is basically free
(since you have to access the vma for other reasons anyway), a good
hash isn't.

siphash is good and fast for being what it is, but it's not completely
free. It's something like 50 shift/xor pairs, and it obviously needs
to also access that secret hash value that is likely behind a cache
miss..

Still, I suspect it's the best we've got.

(If hashing is noticeable, it *might* be worth it to use
'siphash_1u32()' and only hash 32 bits of the pointers. That makes the
hashing slightly cheaper, and since the low bits of the pointer will
be zero anyway due to alignment, and the high bits don't have a lot of
information in them either, it doesn't actually remove much
information. You might get collissions if the two pointers are exactly
32 GB apart or whatever, but that sounds really really unlucky)

                Linus

