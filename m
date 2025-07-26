Return-Path: <linux-kernel+bounces-746922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D366BB12D1B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 01:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618103BFE4B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 23:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC24D22E004;
	Sat, 26 Jul 2025 23:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eTLtIXgT"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6322A1C5
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 23:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753573075; cv=none; b=rlxVCW6A66lt2DI3V/LK5S6hz7nGEqcdSmRwR91RrnO8DtTWWLRFfJkku0U4eAYasJUfVXLLBmaVVhuvdMYb/2dDIu3EqzZO2cAmDukn1bqCKzNJvsyVAfbqpeZZH9E9SOtXAMVdYT3b8lBW75mGXx2ox+oaSTlL/dy5asL1fYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753573075; c=relaxed/simple;
	bh=7B24QJDsbG9O9xyrIOj7H/k5Wjt7NkdzQ2ZYcADPiko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATpGkCAiHPY+H1uzri6Y+CGqRshenh69R677PMusV0ClvVMCTDD5CE0L5CyqZLc//4dSSlLnb3Y+yioxzdcfnYrBNZOKgDt5w0bSoJ/No0+4Ne7NG0nUDKU7KblTpSOMrUJEkGVu77Xz8fUn1eeSA8PRZcDJzXGbwLGIz7Kw+X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eTLtIXgT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60780d74c85so5555792a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753573071; x=1754177871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=eTLtIXgT0zbAfXDRgiRTBv4ioN1hvrP4L3ImXMowXnQYMmK1QSZmAjXbhCEFTdXOl/
         /GJmCRliQD056zT9kndf+Rp2cdmHgFIk32h6uXtxTqC/K9PediVqd7r8GY/V6vitgVWM
         7Vin2WRj12D5Zz7ws8u9Cb9vHk6ehzko0+1HI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753573071; x=1754177871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tHg+Y1g27jBmEKsSCwCSS49UstWUnsuEvPhc+oks0Q=;
        b=vpNnoYaLostDGn8pTQ+n+5VemrVeLVfTAPJwXUqQ4x7LHlEpU0Qk6s6bvEhuasdCAZ
         Af8UqWpXCGHBBR5HYVQiR3DOcyQJNH/xe/Bdlg6Wv5fbut6HEIwjc2FSjK0TdAggJJjH
         4/y4DWtZ71Wgy83M465aUeRjDA0U9/HRgcC189MMQUqXPMIt+AXeUmjBTxyTMei7PEYv
         V/KINK5ox6xOCncaD5lGCpcsGulPaHZLTFip3WNDPwYZ4bb2WFrdQahSiF+m1IaQZrtC
         4g630f9dkVD9WdDhlrGIASqcSiUMlkEhZ5gwJun3qyRyVH/TAsr9wlQ3SKEwS0QCrUnP
         i6nw==
X-Forwarded-Encrypted: i=1; AJvYcCVBU5bXY6uTCSS0MIZ4a2Dntt5q/VxRXJha+v55UDFOoKysVkXLyUkOIM6kNNhlbmsWf38axtcrhXSWB/E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Ugy+mFXgm9n+qTnoGCf7AB2/ozJHuT5uGbwDUI11TeHihnxK
	0NvRjjaJkTLl2T046cQogx+mNtARBxGFHQi7SPS0e9iBh25g5P42J1DnfMqlfuSfT5GxkPLr6D+
	CfnJ4PxfO0A==
X-Gm-Gg: ASbGnctJjIzZ10vD5RQEE2LLmUMq2i9ajEMEqfm/xjaSQoliJdEcYRWW2E/kirUuz91
	r5ujesxHxIt3YIbf+JJny9IbohgPIlSUqg0StwOCHNHuoYFsfSheyWW6B+QpvB1hcED+RYuvIiy
	G1aXUT+F4D05DE4Uvj/w6xOSYkm75ROEn5Yfhk5idSIbUso/CqgvMyKi/CSQvyibJ0iZj2thg7O
	SL5QKvJYUFPwqTGas5AHyK8ZL7O7fhsaHJsZINJrHninhjWQ5qpTQwO9ljtAc/kIccJBo6h/tcQ
	kbTvfXSQqgkyB3UZ9stMChdBEIcnkG9BaxDmYyiOLqGmWx0L5soIOx7kiU9DvkCBQxXYjV+aMXs
	Ua9wFCEOjeAYsNRXVB3+pMr46x2eACzjIYfkvCCo1fRDYzzDO/e3LDRmE4kdy6FtfsTSSfVu1
X-Google-Smtp-Source: AGHT+IFQ6lMNf+rhe9gb9HfRkgpYHimtf7fy6CvVaNRiI8XeHwU6q5ntMp0cC5zp1pO1pV4pELtZXg==
X-Received: by 2002:a17:906:d550:b0:ae6:eff6:165b with SMTP id a640c23a62f3a-af61ed064aamr663802466b.60.1753573071332;
        Sat, 26 Jul 2025 16:37:51 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af635aa42cfsm208233966b.103.2025.07.26.16.37.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso5286891a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 16:37:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXx1VU9YROApDJO9k/RPnI7d1stGhMVkqSdfo8D2Ez4UvIWnvzBgdaylgMmw4I8Tx8LjJgIhBYcoP8m5fg=@vger.kernel.org
X-Received: by 2002:a05:6402:483:b0:611:f4b2:379c with SMTP id
 4fb4d7f45d1cf-614f1dced8amr5514831a12.20.1753573070075; Sat, 26 Jul 2025
 16:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724123612.206110-1-bhupesh@igalia.com> <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook> <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
 <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
In-Reply-To: <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 26 Jul 2025 16:37:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
X-Gm-Features: Ac12FXwLhT2VoOEv9kNeOdgouvN4zZ9YLvHzVMPIsLMuRmQFnkSkLFn13r5tjO0
Message-ID: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com, 
	laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org, 
	mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com, 
	alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com, 
	mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org, 
	david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com, 
	brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 26 Jul 2025 at 16:19, Kees Cook <kees@kernel.org> wrote:
>
> That works for me! I just get twitchy around seeing memcpy used for strings. :) if we're gonna NUL after the memcpy, just use strscpy_pad().

I do worry a tiny bit about performance.

Because 'memcpy+set last byte to NUL' really is just a couple of
instructions when we're talking small constant-sized arrays.

strscpy_pad() isn't horrible, but it's still at another level. And
most of the cost is that "return the length" which people often don't
care about.

Dang, I wish we had some compiler trick to say "if the value isn't
used, do X, if it _is_ used do Y".

It's such a trivial thing in the compiler itself, and the information
is there, but I don't think it is exposed in any useful way.

In fact, it *is* exposed in one way I can think of:

   __attribute__((__warn_unused_result__))

but not in a useful form for actually generating different code.

Some kind of "__builtin_if_used(x,y)" where it picks 'x' if the value
is used, and 'y' if it isn't would be lovely for this.

Then you could do things like

    #define my_helper(x) \
        __builtin_if_used( \
                full_semantics(x), \
                simpler_version(x))

when having a return value means extra work and most people don't care.

Maybe it exists in some form that I haven't thought of?

Any compiler people around?

                 Linus

