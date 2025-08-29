Return-Path: <linux-kernel+bounces-792217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD7B3C189
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03543AB6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B31337698;
	Fri, 29 Aug 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SDuRCyrV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AC5334730
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487403; cv=none; b=MYuLEU6EJgEFhQZa7dV/A3zEYDND0PT+G3MhWhcVoNak617CpP27bfAuOC8lAc+t/WgeU/tSEl02OIgT3HQVRt4VFAUvENIEPfFBTQaeFbzIgN6yjTgWAiAcMazfXP0jtodzQ8iQx5iFt5tlgFhHo06/aDFzVEL9tiMJQN4/cl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487403; c=relaxed/simple;
	bh=fD4739ZL8XX1stZE9Og6p4xwwcsU6Q7KYj3wGwFxT7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=la8xGqVcRwZzjd6jgevFjbVdpyC8Zgz0hiKxH8cbISdpe2qyVInMDGmzdinMChgNQlk1NTcjwfdkwFDDcu8ZvE24/SiRJqS7dzId2va2Yv3xNN4L7uzoet3suRKeFmUScdljPz7zE3RPZxTuU2zyQKEZq98Q2gh0vFzFq5ezqRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SDuRCyrV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aff0365277aso146557166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756487400; x=1757092200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad3L86iH5Z7fm1hgP7OBtRKFsr713rsXkiJ6RmeN8+s=;
        b=SDuRCyrVPBk27xdHRXyjeYzJVG3UYpkJWUH+CUloO2LPmXYaKruH50ikg9eyZe2fiL
         WBg1Tkcq6Usl0c6biUig/CSc0A+WGOIPEqyz5T2aunxz28ySNgE3GRhZBjCSsH9TjF5u
         +7+QNb1vwP8kLc8QecJ3u2fRStDlAKTGm83IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756487400; x=1757092200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ad3L86iH5Z7fm1hgP7OBtRKFsr713rsXkiJ6RmeN8+s=;
        b=sfeDihGrjSWb0TDBgh2PIv3luQYD5tN38UJlHlX6bO7uweH5gBywktCfEryS6uJoc5
         ZaxHscrECMn6wxLxuDrsKaXGlxFqyHRnZYYqZhaN9osjj+t7R/3ds/Ai0j/BvhaC6IKQ
         ounhllWo77gMz7hLEiOThtghfFOg9xs/+RG21omb0anpxMWMDPjiX6d+S4CsJVkQyF2r
         VHt4vWpiQeKJYHm6m5rkCC+S9ufPZISRuFxP+7enSzWoJ1/GDLVWGcjSc2HTyLzZDWRn
         zGZ+EQMO86pIaVPrx9PStSDKDQXYRoZRlXwQqs/c1oE/MyGaa0aG+O+PibnR9hlOSxMV
         BbyA==
X-Forwarded-Encrypted: i=1; AJvYcCXWY6o1eRKelw1pe3s4o/SdRSlMK4f0BlfxbDAuJQ6wEzS4naV3PheUO+77SJ8Uo6B2XJ+F6qVSNh/OThM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNwceN4hsVQG92i4DJhFHAEis79RnJZ+H5se+cykj4SPlAMiB
	YHzJZQEwFkqX/OXtOdIrql2cZ+6KpPGvnlJ0G7OR45XEBbgs6A+N9tQ3FqjoTbsSp5gv0R1oM1d
	uyAu+io7XcQ==
X-Gm-Gg: ASbGnct5oQTEwX97TrcZc005RUfWO0h22XfciLY/9hy10q7ea74j3cssJ6tM1hSEw1O
	6HxMxR1u/hesVLYTZqrEsUNmxHbjavtspZUqi4gnzBXpUYr04oSoDTvh6yiseKlNEfLaCV71PlB
	cPbFhpiTeqwLtDRwJkSyKhMJ13yZ//LO12fPN2qylC9x7VU5mXnv8xwWhjn7r3VHy/6UWFXK/qH
	qC784L0N1vAujHwhb+gSOThy1B5NKp2aO998kcL6lH5C6+l5QjB0vFwWfGNhdhib/lBy/VS1AJZ
	BSt1e1UAdZjqLbpTUG+/RJa/RUIX2y/3Jlx/SbjtFsejLN79H2yxPkOloAeqbCdtLTvEMx5t/Ll
	aNyVdtPRhPJ5M2QMcxZ8XWM1oedaGGcFTAReboglHF1oNUkaWCX6Gap6oZfT9e4g8QBH+Ftq914
	Zmpno8Zx4=
X-Google-Smtp-Source: AGHT+IGlfvi+tedO290W+NLIvNOjTHoqP51lFfkNQKYGz1BI5nTBFG84CNhOHg7/mn36YmGdawOn5g==
X-Received: by 2002:a17:906:4786:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-afeafecad36mr1405785666b.30.1756487399734;
        Fri, 29 Aug 2025 10:09:59 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff03e9ba10sm186400866b.52.2025.08.29.10.09.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 10:09:59 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-afcb6856dfbso422646566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:09:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5LzuwTTMAPRkvSmXDp+CSxBenK2A6TrTmgdaStxG2BDGV4BSOm7NiONW0SZ9DYFIAnRZomTb2/+BYKtY=@vger.kernel.org
X-Received: by 2002:a17:907:6eab:b0:afe:ef8a:a48c with SMTP id
 a640c23a62f3a-afeef8ac7f9mr611238166b.8.1756486976814; Fri, 29 Aug 2025
 10:02:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <20250829125756.2be2a3c3@gandalf.local.home>
In-Reply-To: <20250829125756.2be2a3c3@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 10:02:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
X-Gm-Features: Ac12FXypzub4sT_YQp3-NVQ4K7fOdzCL-9SS4ZE75x9Zoqx6YPOM5EIXszDBXRM
Message-ID: <CAHk-=wj-ZfHXfXKtSNKoRXhNz10Do+mqDyUumEkx8H8OqVYP-A@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 09:57, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The reason is to keep from triggering the event that records the pathname
> for every look up.

BUT THAT WAS NEVER THE POINT.

There is only a single 64-bit number. No lookup. No pointer following.
No nothing.

The whole point of hashing was to get an *opaque* thing very quickly.
Not a pathname. No reference counting. No verifying whether you have
seen it before.

Literally just something that you can match up in the trace file much
much later.

(And, honestly, the likely thing is that you never match it up at all
- you can delay the "match it up" until a human actually looks at a
trace, which is presumably going to be a "one in a million" case).

              Linus

