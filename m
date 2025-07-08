Return-Path: <linux-kernel+bounces-721686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE65FAFCC74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF5E167311
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59E82DEA92;
	Tue,  8 Jul 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="MBlRUTly"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7BB881E
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982676; cv=none; b=CaTTNriszP5k+dqA9wOoLBpuYNUct+ucGa1rgORJKkIpg+fLfz6+VdLnsR10x6J2q4yEfkTJn0ITT10kyw2xeZqU9nf/fxWqS8opatd4UVjYmOmDb0PktdGaxuhH/RzxGQpwFHDZtwXyTl54nhWI55HtVvVUz99QeKIbN3PPxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982676; c=relaxed/simple;
	bh=qkHV+oubYu/O5KpKB/TIsQpLDj5mKUNq2idhGzy+r7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DdNYHpdsY5hYPTqnGThiDXWGrtfBlMwk+0Ee/di9BD7lRi6LWtRWbE0wlPAapthJAqNMQpL6u+x/ALrXNa2b2Rl195de70rrGah4o3n3oBNmQnjeNDaHuzf5oX5SmG57wVhXJhSlvr5jPzgqmMsLmI1UAdd7SjdKHb3ffho4pYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=MBlRUTly; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-55516abe02cso4354469e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 06:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1751982672; x=1752587472; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=31MqR/E8gvc45qHOvdbZr7UXtdSXHcy53Qh8ZwjxaD0=;
        b=MBlRUTlyH9cxaYU2jSw6vYHjJysk670xKuSrcsrt30nXStnUHx/1DBAyNfDbjxG4Be
         sM1cghaj64PrdF+wd3jieeqiXODHrgk7HH2AmdmRU7nP0AZ9DnY9O9Vi4xdTv6xQOzmU
         zksgurKCsDTu/uUJxP6mUN7N8I2WWEtfRCY5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751982672; x=1752587472;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=31MqR/E8gvc45qHOvdbZr7UXtdSXHcy53Qh8ZwjxaD0=;
        b=bvai3DG3Ofv7PhNHOmAUd84EULxHmaQ3YISYSt3tA9V6AHbICKLCKAqBtwwLwNgwRD
         kTF1FLhlChW1KGqMReRCCyEySTz2hU6YBzdaEHmsIgAS1u5Cl+rU4eFTFTeksXNVpaDn
         m6b0jCU+fxTp2uoCxUFiwZ+orX8z1NlrS/FVKqtwhBUxUlg4jRqw8LXEYhqZQL9NDZiM
         PwLC3+mHw0pFcipkDBRE6NPdZFmusBEwIziVumyCgUSbTTct9nHfzJBoyk96ZIYL5E4G
         EUSeNCI1fd0Fwa8C9yj3QtYi9lBMUHvRoV9d1Ktr7oipP6XBSQCKuLOdOlORq0cUSMZR
         EFWg==
X-Forwarded-Encrypted: i=1; AJvYcCWDW3S0eoeanOiMiNS+Rt52EAFlL6b+AgIzuGrTrzGkpIZbo6Zme60Z3M09WV1/SC3L4o/MznEhhr2Mmpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFXVPvUzSrQTjgv6SB6/wIN6DcncJ/oojKc/D0zGcekd1IbyF
	/e3ilElz86Jkm2Ct6PxX1Z1613687bSQi4G9eCV3VbE1BTcQO3RQ7rCuR4nrbNQnUoM=
X-Gm-Gg: ASbGncvdH4l9pqtjOTSbPbGKFwKpqGXIKyEHc9l8KZO9MvpFI0fAqtUnhPDIItU0Z2O
	CJ98RVlLLrY8umLegrYBzWHV7YwYw/JQ5sc7wj9BBsYXFZY5H0MPQ1iFNOPFtFSimI1EOsrajov
	UtxBGt54UiuUId3e38RSgz6qiBAOJ6PNJe+IRvBLFOkFpvII6b+qAPKmYwlfcFF2NxNnoqHoWQ1
	lkHRKjPrmkGL8MltzkdBQrAbX/BDbrdgC7F+XlSETz7r0cMrw1N+k8f7jb1yBosm4TvzbLWaan5
	d4xKL0q4oTMbE/Qxyg/FEM7xT+lby3U0ZtsgS/cc/ymOZq/OlpJnx5wrcEkL51Z4
X-Google-Smtp-Source: AGHT+IGAGFiZWkwFnSiMkLwKey/goUWPwP6l7a9KOAhmvZ6IpsJt6jVgzyte8sMjjpbz+51yLmRVhA==
X-Received: by 2002:a05:6512:2381:b0:553:2308:1ac5 with SMTP id 2adb3069b0e04-557f8d6a9efmr1017578e87.4.1751982672246;
        Tue, 08 Jul 2025 06:51:12 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-556384cdf6fsm1699987e87.242.2025.07.08.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 06:51:11 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org,  linux-hardening@vger.kernel.org,  Kees Cook
 <kees@kernel.org>,  Christopher Bazley <chris.bazley.wg14@gmail.com>,
  shadow <~hallyn/shadow@lists.sr.ht>,  linux-kernel@vger.kernel.org,
  Andrew Morton <akpm@linux-foundation.org>,  kasan-dev@googlegroups.com,
  Dmitry Vyukov <dvyukov@google.com>,  Alexander Potapenko
 <glider@google.com>,  Marco Elver <elver@google.com>,  Christoph Lameter
 <cl@linux.com>,  David Rientjes <rientjes@google.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Roman Gushchin <roman.gushchin@linux.dev>,  Harry Yoo
 <harry.yoo@oracle.com>
Subject: Re: [RFC v1 0/3] Add and use seprintf() instead of less ergonomic APIs
In-Reply-To: <ez7yty6w7pe5pfzd64mhr3yfitvcurzsivjibeabnkg457xu7x@tkompzcytwcj>
	(Alejandro Colomar's message of "Tue, 8 Jul 2025 13:36:57 +0200")
References: <cover.1751747518.git.alx@kernel.org> <87a55fw5aq.fsf@prevas.dk>
	<ez7yty6w7pe5pfzd64mhr3yfitvcurzsivjibeabnkg457xu7x@tkompzcytwcj>
Date: Tue, 08 Jul 2025 15:51:10 +0200
Message-ID: <871pqqx035.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 08 2025, Alejandro Colomar <alx@kernel.org> wrote:

> Hi Rasmus,
>
> On Tue, Jul 08, 2025 at 08:43:57AM +0200, Rasmus Villemoes wrote:
>> On Sat, Jul 05 2025, Alejandro Colomar <alx@kernel.org> wrote:
>> 
>> > On top of that, I have a question about the functions I'm adding,
>> > and the existing kernel snprintf(3): The standard snprintf(3)
>> > can fail (return -1), but the kernel one doesn't seem to return <0 ever.
>> > Should I assume that snprintf(3) doesn't fail here?
>> 
>> Yes. Just because the standard says it may return an error, as a QoI
>> thing the kernel's implementation never fails. That also means that we
>> do not ever do memory allocation or similar in the guts of vsnsprintf
>> (that would anyway be a mine field of locking bugs).
>
> All of that sounds reasonable.
>
>> If we hit some invalid or unsupported format specifier (i.e. a bug in
>> the caller), we return early, but still report what we wrote until
>> hitting that.
>
> However, there's the early return due to size>INT_MAX || size==0,
> which

First of all, there's no early return for size==0, that's absolutely
supported and the standard way for the caller to figure out how much to
allocate before redoing the formatting - as userspace asprintf() and
kernel kasprintf() does. And one of the primary reasons for me to write
the kernel's printf test suite in the first place, as a number of the %p
extensions weren't conforming to that requirement.

> results in no string at all, and there's not an error code for this.
> A user might think that the string is reliable after a vsprintf(3) call,
> as it returned 0 --as if it had written ""--, but it didn't write
> anything.

No, because when passed invalid/bogus input we cannot trust that we can
write anything at all to the buffer. We don't return a negative value,
true, but it's not exactly silent - there's a WARN_ON to help find such
bogus callers.

So no, there's "no string at all", but nothing vsnprint() could do in
that situation could help - there's a bug in the caller, we point it out
loudly. Returning -Ewhatever would not remove that bug and would only
make a difference if the caller checked for that.

We don't want to force everybody to check the return value of snprintf()
for errors, and having an interface that says "you have to check for
errors if your code might be buggy", well...

In fact, returning -Ewhatever is more likely to make the problem worse;
the caller mismanages buffer/size computations, so probably he's likely
to just be adding the return value to some size_t or char* variable,
making a subsequent use of that variable point to some completely
out-of-bounds memory.

Rasmus

