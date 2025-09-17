Return-Path: <linux-kernel+bounces-821369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 655CBB8114A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4713B9529
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6312FB081;
	Wed, 17 Sep 2025 16:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XnNrvRQ4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14502F8BF4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758127812; cv=none; b=PU7WZYb47W2Q0YjZGeqODFD4u785qGTLAUO+vTFJoSODBpLzyBkeCuu3tNglyvj6F5lc9ilsuGiGEtuOthoOnxh0tP6YiXR+2EVG+1JmUF7PsJr0iEbV0ef7nri6AoTK5X8kDcH9JzMcKw4OokWa2mlp99RN/jU+qAP9DhckXt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758127812; c=relaxed/simple;
	bh=1H1iuJrn/iWHh0/FIddtuyxCZaL0dzOSp1DYiZsbMY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=arut9fVKPfGH9ar3rcl0yi3yB1RdGZSbnOkXv/bhzNOyF20A2P2NW+1/YMQVcFUCXvJgDcVu3jVUVtuYijgGsZBFc5n3JWIqXHGTXbxP97EUEQ4g+IRNV7wDhHtvgYhM3PP9TAie9mJn3ElvGxew5RWIsqAOdazlecvAr/JVccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XnNrvRQ4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-267c90c426dso2505ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758127810; x=1758732610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8PrCNixuKjn7muO0S4+O0quWRgO8+yd5D10C3h36dQ=;
        b=XnNrvRQ4WvjwS11ZRsSOfZudwYfX2Y6GCcIgrW/+rSTbb/vgBLPKHuXJzKZ29MUXj/
         D8j4kprbjNLh74JDhMEz5g8m+N/OcHqRd2DHl8w/7FNYgM4ztO1iWmRLKbCvEVCZQ6b3
         Gimx9bJiD8MoeaAzwDRtsW7hBdTMKxcgqaxEFZqrwcJBxPTyDi9+F+O1RuZ5S6ySNLvf
         xtbOz9hocSLvDviuQ48dexhZyKCT8ifOhB2WtQcKeQRiORaEDszzY6BtAP3/T69MOHV6
         TN2qSZdlQ6sOqoH9lYmiz0xSQDLx7a8xVrCC12nj9wlLeOU+BoZrO6QBIoF8uzSSG8gx
         n5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758127810; x=1758732610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B8PrCNixuKjn7muO0S4+O0quWRgO8+yd5D10C3h36dQ=;
        b=V6PjaHB6CsVc0nf38C8H68d2V1ReTLKfeLuRCL7UuKhOxzbMf2DKTgBLuj5GeniGNp
         ZibH6qlkFoilAvkgLf9sm2+ZFuO/zXhNzWFuf6cWi1mI3z7iGw6UQLfnWp4u14+RUwNA
         EA2yx0r/3Nh6I66qfHAD9tCb9EVQdbV4EScLcoDx27/6hZ+iK5Cu3k7fq2jDpwY0oyCz
         J8xHZVl153qYDJdwYbTvthhAoW8GVYlLNZIZOp9uh/MZsMoc7SyfmrARPlocJwlymNaF
         m4wQddQQp2k3jeiA4IRPCi6UzJyhtOJnjEvc70s6ecj/8mDhsOb0Cpv123z1wZ0x18Kw
         +uVA==
X-Forwarded-Encrypted: i=1; AJvYcCX/PAjwB5uX6FAWrCnXQoDEXPYfeA0fwjaXEZDUnUY/MSQded3ezsb3QPelz+HOk8ckxTb7ULOopp5zl/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz4Sz6BosGdvWOhzEL8i8r6jzLUamaY0ZmmA9o2YA0P/5YDmSB
	8psZfqocHrhLGp/NVVhOTPMfA52u3+gj9JDtNi3oIAYRm9X6FaY2dXRU1Hl0JVOH8JzMTLmkjYz
	B/q+xOuuWQJ1hTUWMONExStbvE4FrEjStrUt4f0Qr
X-Gm-Gg: ASbGncsI09gKCVQKmMjv9PB6J5V/ep1Smu9cUhn5lf8yHwPNApXU3gEm1CINccgHfoD
	ALKeAIzBcDX0coiPR0HjSGwdabjWJw7kk80DHL2o2vn/amlwvhtRGFKjwkbopW9RatJloTfaDZh
	SJi0uaC+wyROPHrXZ/P0Zc1wsHKmKvRrywz0a1NV3Ny9EvZADoDVzlpJTvfd9seZnGz1exCcMQL
	sZkyJWTOiRO0inBa55Dh6plnpJZREQ9kQLHzGhJ64j6
X-Google-Smtp-Source: AGHT+IGtMrszeVWUnHllJskrp5Iflf/E5+ZGwWZI9QGzgm0SBtqy/zo9xqbqUXTBv+hZMCoJ44EWquT3yuXDAoQpNaM=
X-Received: by 2002:a17:903:183:b0:249:1f6b:324c with SMTP id
 d9443c01a7336-26808af17c3mr5103615ad.13.1758127809488; Wed, 17 Sep 2025
 09:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-3-kaleshsingh@google.com> <1308de0e-bb5a-481f-a447-ee4440ffb419@redhat.com>
In-Reply-To: <1308de0e-bb5a-481f-a447-ee4440ffb419@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Wed, 17 Sep 2025 09:49:57 -0700
X-Gm-Features: AS18NWAaVY91WPhjDqAP7fbiSZehTHu_vaxEm9l-M13vdtmPSNl69ObH0kjNDtM
Message-ID: <CAC_TJveQks8qnqTUq-tyY6VV34mPz8ZmQ9XmsDRAz0-yW535MA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] mm/selftests: add max_vma_count tests
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:58=E2=80=AFAM 'David Hildenbrand' via kernel-team
<kernel-team@android.com> wrote:
>
> > + * test_suite_setup - Set up the VMA layout for VMA count testing.
> > + *
> > + * Sets up the following VMA layout:
> > + *
> > + * +----- base_addr
> > + * |
> > + * V
> > + * +--------------+----------------------+--------------+-------------=
---+--------------+----------------+--------------+-----+----------------+-=
-------------+
> > + * |  Guard Page  |                      |  Guard Page  |  Extra Map 1=
   | Unmapped Gap |  Extra Map 2   | Unmapped Gap | ... |  Extra Map N   | =
Unmapped Gap |
> > + * |  (unmapped)  |      TEST_AREA       |  (unmapped)  | (mapped page=
)  |  (1 page)    | (mapped page)  |  (1 page)    | ... | (mapped page)  | =
 (1 page)    |
> > + * |   (1 page)   | (unmapped, 3 pages)  |   (1 page)   |    (1 page) =
   |              |    (1 page)    |              |     |    (1 page)    | =
             |
> > + * +--------------+----------------------+--------------+-------------=
---+--------------+----------------+--------------+-----+----------------+-=
-------------+
> > + * ^              ^                      ^              ^             =
                                                     ^
> > + * |              |                      |              |             =
                                                     |
> > + * +--GUARD_SIZE--+                      |              +-- EXTRA_MAPS=
 points here             Sufficient EXTRA_MAPS to ---+
> > + *    (PAGE_SIZE) |                      |                            =
                             reach MAX_VMA_COUNT
> > + *                |                      |
> > + *                +--- TEST_AREA_SIZE ---+
> > + *                |   (3 * PAGE_SIZE)    |
> > + *                ^
> > + *                |
> > + *                +-- TEST_AREA starts here
> > + *
> >
>

Hi David,

Thanks for the reviews.

> Just wondering if we could find a different name than "guard page" here,
> to not confuse stuff with guard ptes
>
> Will the current "guard page" we a valid vma or just a hole?

It's a hole to prevent coincidental merging of adjacent VMAs. I can
rename it to HOLE in the next revision.

Thanks,
Kalesh

>
> --
> Cheers
>
> David / dhildenb
>
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>

