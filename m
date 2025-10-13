Return-Path: <linux-kernel+bounces-850949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B026BD4C60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B458189D1D5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503973164BF;
	Mon, 13 Oct 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DbZQn7QQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379613164AF
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370376; cv=none; b=KmRcRD1+Fj2o0aPDzl6SyvfW8wtskE8/SQfdf7JfoWAGaVW2rKniWQctU1UAf3VObdO4nTrLnkmvdEYzonjSQ9BrK4Yt7y99hwvMTJI5f9gEo95e2bOlScVhSryni6d+sdnG1tH7/sQ/5DjY+ym6Pjf6ZodlzWRSJHjajgvPu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370376; c=relaxed/simple;
	bh=Gh0xkG+HEMAZ8iif2uzqr6cU9prk01bUy/kDmxuuS/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/hpvClIj27ArnhEv422Ds7v3HasvXzXe9zZWyr1mycep8ZN2wBxE1Q6y8giMazQ8xU9MgT2mxkNtQ9CBB32RIXwfGoqyHNu8wdVTEWW4POePrRlVbVaw7hZK8d/ZRymORDP5ZQ7CEh0L9cCPPOK4sJZASFmjwF+CED1kGu2/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DbZQn7QQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eeafd4882so467765ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760370374; x=1760975174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gh0xkG+HEMAZ8iif2uzqr6cU9prk01bUy/kDmxuuS/U=;
        b=DbZQn7QQbkVwvsxfGu/hYMBmKynFftcCyOlq/COHZFBSI9BSDQP/hENqqZ23ARVy4e
         5fP5H70U8y2B/W+9JDXDq/hne8iG4+El6tNlHR3G9riowKdjVvIQ95MSuLN6vuaqybZD
         HhzfkRRQms509DdMecs7MnSwBrDpvEiq1MgmikBOaYS6hMYk/re8Zt4mH9GIr+QVceuX
         vXU9TumgIpBFInDzA7WoIEofZoL9q/5so9zlswLKx4mSiWtPt2L0ZO6TPEx4jwRGEJ9b
         W6TM8v3KRoU8Atzllx/GF9Ev3PCxJeCADmnmBaSWL4W5ppXA+Jy5q5/1Ccrn3i8/d3W0
         Udqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760370374; x=1760975174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gh0xkG+HEMAZ8iif2uzqr6cU9prk01bUy/kDmxuuS/U=;
        b=Aq6eeREAvOp4rNb/s81J52jloJjs046Y4OQUP0NcIvYyc8W38pc8Tob2LL+D1xo886
         2VZ8XZLbJ02mMlAf0GqUN4nBCpL/uJiMoOx0Eq3vgIK+d92cYPl+t8DkngxIepMJED7K
         lOGcgzCgIXVbsrrh3rzuR/3hROv1Saxlid7ytecN5OwXiij06rmEORj3oFfF01To8YjM
         jI52j8e3As0yAKlnqTsiRJ6zS/3y8fOPfSe33kUr3KbwLv+r5w3ViFDWnZktwRvRFnbg
         unqbsNj+cahxhw2DprnpjcO+RDo4Vop4lnCsGUg75WoDHCoe7mLeWDJ4ClbErYuzTNnX
         jwbA==
X-Forwarded-Encrypted: i=1; AJvYcCXBGIbIbAERXAG5gCLvFHuOR+C0Jg9zLT/6HarYHTYfApXMRnJ0lGmbhpjlPKuz+YpBbWKqae0RmmfLAL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYydg3/J+pEpMpbbAHtOoqZ/ls9AsVndabQBQs1D8Gjs7CDUqC
	UAhoxJa26EytgMT8zgyjLhh+eThxLRB2HjN/FlESqLyZOzQIj6YvBjjdeG6WZWiSZi4rI1Sr6i6
	mAzQ6Gs3OtqvS1rU2BkGZdumUZA3MJcP+iJEesRdD
X-Gm-Gg: ASbGncszJz2zKMKVsCLKcmp1A8ymizvn2YqR5K0sk2H734T21WpYDBUl18Bi3fr5ZEv
	FiMgztMKwP4gXSmorsWcOatYCDQTGzzdbqSG+h2e3ygRtFPzijqodZmSiKioCpQVcIDXcCd5vaI
	7x7FHr2ihAebUEQChbywQfF0V2cjRe7zaw7twYg0a0Zsyww2KOoQXI9rMB2CFSHkWXjpj8bkBEL
	YJ7vijBrsXUhfe3RvHNngLv1HXDig7Efa+m8pH1IyKeNs6Mnsxt+wayfRrU7EQW7M2RVL9hnQ==
X-Google-Smtp-Source: AGHT+IFpkUdbriJp23+2Jb8eOJGaVHdsjhGARS/bTOlZqK6t4o+Ul77JlTrOQ+g9Lp/XnQzRqj62GmvLzwrp3fj478M=
X-Received: by 2002:a17:903:1b66:b0:26a:f9c7:f335 with SMTP id
 d9443c01a7336-29027699597mr25468055ad.9.1760370374228; Mon, 13 Oct 2025
 08:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013080609.2070555-1-hupu.gm@gmail.com> <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
In-Reply-To: <CADHxFxRMUhn=VdG5uzrosTUpwAMHi+zO7NTYVikWzFdnKrUJ4w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 13 Oct 2025 08:46:01 -0700
X-Gm-Features: AS18NWCYdUVbOnDz-j3sbDrxzDX70h3ig4G8MD5wGb1R-4xJxXjeiEmchhKFwHI
Message-ID: <CAP-5=fXykcQ7n3rw6RX3S+dLoLUC9BZKh=BP8yx8ak+f623aEg@mail.gmail.com>
Subject: Re: [RFC] perf build: Allow passing extra Clang flags via EXTRA_CLANG_FLAGS
To: hupu <hupu.gm@gmail.com>, Leo Yan <leo.yan@arm.com>
Cc: namhyung@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 1:08=E2=80=AFAM hupu <hupu.gm@gmail.com> wrote:
>
> Hi Maintainer,
>
> I encountered some issues while cross-compiling perf (ARCH=3Darm64),
> particularly when enabling the BPF option. During the build, Clang
> fails to compile BPF programs due to missing header files. The
> relevant error messages are as follows:

Thanks for reporting this issue! There has been some recent work in
this area by Leo:
https://lore.kernel.org/lkml/20251006-perf_build_android_ndk-v3-0-430559079=
5b2@arm.com/
The patches are in Linux v6.18-rc1. Perhaps you could try repeating
your build with this tree and reporting issues?

Thanks,
Ian

