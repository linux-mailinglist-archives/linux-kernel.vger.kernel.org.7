Return-Path: <linux-kernel+bounces-746156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AD5B123B8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4B9817CA04
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF3C242D8B;
	Fri, 25 Jul 2025 18:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VeWIU96M"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C295123C8A4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 18:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468024; cv=none; b=CXyIobVzvsg5btWlGFcynT2FCKnaGGczHvt1Gb51o2Bmm5i9CqY7//VC80LD7boR2FpmZZMvBPnVvyZf9byGTCl+vB46/E/oKgDxhErb+sM7axgzY5J7iLatTb7gVWhwrWX6ReOCDGdvtiZPcjgI8Px751ZoE5myMc7fmRNGbLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468024; c=relaxed/simple;
	bh=4jeILVLb0s4IfxpCIa9+VmISKWYD4nx4nfZiE0kz1wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqCYwPK5SAaS4AfMiQGgKawFgWhPB6EUU40K9li3a3Seku9hH0iNyO5kLIotSMQT61o3+74B8KSSiURnmf4XxfSu8cb8s1GvwBmA1+duETYF4jzSIgGYZ8fkWFTAoDv1+RXgicyqJmyEfLi50sc9MmdraqLZw0/1bMLfpFLzuM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VeWIU96M; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-302db17fa08so217295fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753468022; x=1754072822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alGDq6Ry3t/6owOKcyElG/+ugV+qZlm3QpS2noyYRwo=;
        b=VeWIU96MhEpLVtWR90mbLdwWM2N+VVjPPh50YAkCuvdIM16JzotwIl+Oj++fYS1jAU
         dkQPaqEKGNwIEuc0BPoUtTrWLJxHNP5nQE3nkNao+7k3lmdU6YF2zUGuuRd7NUiE/gr/
         J4Xi7inzjJ0G2bWPYAHLSxGf4otH98bjVKO4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753468022; x=1754072822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=alGDq6Ry3t/6owOKcyElG/+ugV+qZlm3QpS2noyYRwo=;
        b=ASdvXnSDXBiidgvDJEkhLUHcF/mv8OWABF5VAuuzlXgVnRMaqEisPVPDqe/r55OoVE
         YNyQ1AnMqNa2xseeuLqiUikRJz/DK4Vx8v+UtEcRdS4QQL/wkbhHyPExTPWRPG2SqEBc
         p2QPVxQvz2ZhAln0fPqQmdpRkfM/blYeIx4wXi3JFQ8ZRBAQTNNDwG8I/c1rOLPWXm26
         BTwajFOmzRLbR3LMUGKqQXJWLfSWlxpaUjCY2B/Ffl41hZTrIYEyo1qQ9bfDMYLZvur6
         w0t3OpZlBQV7fxNeeL3Hyl/MAzxeNOI5+SKYmovT5WR9CjEuuFebW0XPbcvedIQLWsGE
         ijUw==
X-Forwarded-Encrypted: i=1; AJvYcCVT81l5+NLOULRo0/AiLUvo3U9DNDnx2O6F0hXyXAV0Nkz1FMaNCh79GqrPT1zwE5GhRtydZSzZ/QPXzmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyChvN0RQOufUBum9VKiiaohEoTdb9L/26M32bJv7PY3c+AUTz6
	BUkpB8fq/LEkobi97iWAfOUl5L32YIkKNWNtQo6l8z3Mg/sS+2FAVVash2U3Y3I4fPJ/oMG3njY
	CIhppE8BaPK+AT25jjw+iJQY7nDnIWeOsCR9ban9Z
X-Gm-Gg: ASbGncuAQ8mBuzjwjS5MtQEFRhg+9RkLkYTWI0pqCdGv1hvyUuKrEhF3yGPSWEwE4oO
	PxkwUPsokFURhl3rH+l0LHB8P1arR2g9dWhxhmOTW5GGNvInj55mOl9Rhh006vqogESSL0yK+DT
	KRRLzeYRq3y2LU3uTjkZeNLKK398Y9tduX3/jKkyzMbdHvbPa6dIbUxC1p7S58Q7Q8LT34NE+RK
	x06GUj67/dND+MQZgMmd71lXmIWnZ/Z1u+vdA==
X-Google-Smtp-Source: AGHT+IFngRzgfoejt3mlP9tvAddRS2UA8uH+ymeb855nbW+1wntTvnE+e8poGwzJ/rhE3BnJFtfzCrluyDBgcx0E7IE=
X-Received: by 2002:a05:6871:758a:b0:297:276e:7095 with SMTP id
 586e51a60fabf-30701db3c7emr663346fac.11.1753468021761; Fri, 25 Jul 2025
 11:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1753431105.git.lorenzo.stoakes@oracle.com>
 <dd50984eff1e242b5f7f0f070a3360ef760e06b8.1753431105.git.lorenzo.stoakes@oracle.com>
 <CABi2SkVeHWt+SKWWodXUNhXZi1Wv9YazEOGWEUJLvgPbopqBrA@mail.gmail.com>
 <ca6af6bc-1c5b-47fc-a00b-11d46867b5e7@lucifer.local> <f860d082-384d-4230-bb1c-09206c7daf72@redhat.com>
In-Reply-To: <f860d082-384d-4230-bb1c-09206c7daf72@redhat.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 25 Jul 2025 11:26:50 -0700
X-Gm-Features: Ac12FXxhETnYd5YWTH5JWBSDO_QT8rIt6KG98Nmkcj1shWxdgrRx71TTjPQMff8
Message-ID: <CABi2SkVJ6O4GbEB9OAHwf2FjWJNj+1dJA7nUynRQYLZF9=LGKA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm/mseal: simplify and rename VMA gap check
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 11:10=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
>
> On 25.07.25 19:43, Lorenzo Stoakes wrote:
> > On Fri, Jul 25, 2025 at 10:30:08AM -0700, Jeff Xu wrote:
> >> Hi Lorenzo,
> >>
> >> On Fri, Jul 25, 2025 at 1:30=E2=80=AFAM Lorenzo Stoakes
> >> <lorenzo.stoakes@oracle.com> wrote:
> >>>
> >>> The check_mm_seal() function is doing something general - checking wh=
ether
> >>> a range contains only VMAs (or rather that it does NOT contain any
> >>> unmapped regions).
> >>>
> >>> So rename this function to range_contains_unmapped().
> >>>
> >> Thanks for keeping the comments.
> >
> > You're welcome.
> >
> >>
> >> In the prior version of this patch, I requested that we keep the
> >> check_mm_seal()  and its comments. And this version keeps the comments
> >> but removes the check_mm_seal() name.
> >
> > I didn't catch that being your request.
> >
> >>
> >> As I said, check_mm_seal() with its comments is a contract for
> >> entry-check for mseal().  My understanding is that you are going to
> >> move range_contains_unmapped() to vma.c. When that happens, mseal()
> >> will lose this entry-check contract.
> >
> > This is just bizarre.
> >
> > Code doesn't stop working if you put it in another function.
> >
> > And you're now reviewing me for stuff I haven't done? :P
> >
> >>
> >> Contact is a great way to hide implementation details. Could you
> >> please keep check_mm_seal() in mseal.c and create
> >> range_contains_unmapped() in vma.c. Then you can refactor as needed.
> >
> > Wait what?
>
> do_mseal() calls range_contains_unmapped(), so I don't see the problem.
>
> We could add a comment above the range_contains_unmapped(), call stating
> *why* we do that, which is much more relevant than some check_XXX functio=
n.
>
> /*
>   * mseal() is documented to reject ranges that contain unmapped ranges
>   * (VMA holes): we can only seal VMAs, so nothing would stop mmap() etc.
>   * from succeeding on these unmapped ranged later, and we would not
>   * actually be sealing the requested range.
>   */
>
Adding a reason explaining the reason is way more helpful than just
stating what it's doing. Thanks!

a nit: I would use:

> /*
>   * mseal() is documented to reject ranges that contain unmapped ranges
>   * (VMA holes in the middle or both ends): we can only seal VMAs, so not=
hing
>   * would stop mmap() etc. from succeeding on these unmapped ranged later=
, and
>   * we would not actually be sealing the requested range.
>   */

To make it clear to the reader, because VMA holes might lead people to
think they're only in the middle.

Thanks and regards,
-Jeff





> Something like that.
>
> --
> Cheers,
>
> David / dhildenb
>

