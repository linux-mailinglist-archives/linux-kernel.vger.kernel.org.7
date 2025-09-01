Return-Path: <linux-kernel+bounces-794341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AFB3E043
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038503BE1B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D8130F813;
	Mon,  1 Sep 2025 10:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="crKNbjf/"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D230F7E8
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723015; cv=none; b=C5ISJZ2oGlk0E2O8mC+eFNgi6qlNDZWOlNBr5yl3CNUQsYgesAcZtOaZAsBqdk0ptfovx86cHfTnkpR28UtDT5xICv0GusnjOUVl7BQ6zKdbFZ93L81nO1Xiw/CYAMdpjYxTb2k6hp7ZR1ZtM7EtvTkRFkOqVJ1sUAkBpMSwfEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723015; c=relaxed/simple;
	bh=IxGHGdFfILxmO9LAT6iJq8nCvFtGNCBHuBQCWD9Ke3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fRo0Cj8LEFpvdDFUC0718KYblIm0C9hYCGW5bIDgbF7A8Ng5q8EiI1ywcALG7I7JQAj3vAocZ1G6A2Xb/I061c/3oItDY2t4wCtXeO+DKBBKA/FWlLT7ivscc+IBmnTOU3rC7MbECFcwsq4W8gUIx1llD2wy18VmAa1r7V/iFRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=crKNbjf/; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afec5651966so131450866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 03:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756723012; x=1757327812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxGHGdFfILxmO9LAT6iJq8nCvFtGNCBHuBQCWD9Ke3c=;
        b=crKNbjf/h14ZKPlbkuC8zdO9w3lVsQhHSEJz3jFTdGsRNVmyndSqPihhWNwhGjch4s
         T9BcfdnPUcC8htpJukThZtIGdH4MawCTc7mSW8cFk8TpGfNCLCGqv7xV302U1VHpVJpp
         4OnhFUmyQjbZBf7mwaQjB4GP7xkD7MrCRMGOMvYU2xM3uMc1UZfXSN0YIRby/I4eJBqP
         SRK7xLRrOnRcZePk6mr0gCwPwITWZ8/DuN9XPqTHEua92o0VBfZGBnM4pTICVlu37KlS
         lm6hTMy8eg0Sv/PcbB3i70gDPR/9rBjuferBikXGFhbqiM+pN8WX/E2d3OIMIChyUpwr
         2aXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756723012; x=1757327812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxGHGdFfILxmO9LAT6iJq8nCvFtGNCBHuBQCWD9Ke3c=;
        b=sXrZURqG7YGoomXvNhqz8ieapte71bgDDfNW7kc+KY1sVVHTFGwQ28R/c7aQobLnaf
         32kHRiXv/FW+Q+tJDObkxcPDl1x+YH9Z7os6wq1Wic13ZVuovusyGmClgL9QHafDqdJ5
         Wt7I20j12+oOZfpN4thrzyCCLdiGDGk0H/oYepGP3SrzOvTQYEWKKw3HFcdcLd92JT/6
         3e6IcquxUzAVYLJP9NhhA/Fnu2l7O7ZOMD/cmmcWt5Tj0JJbkXdGH2vMFDXS4+5qYy+1
         73TFGKCwE/TR+VpipRrgsmn3OrtdDTpGZGTGFv4cPBlacRTRgHbM8oDXH+QdT7Oz02yn
         PYig==
X-Forwarded-Encrypted: i=1; AJvYcCW7siIjdNl4SFkNgEHPHasc7kxRVp6gEgvi+OUGetvGVWIG6if9i2WMxJBkzimYvcfAkYfWhUxCACVY0Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhtR2mIZodoyE/OpMNgTBkczWaMm3YZU0bMALAQVQgSnn2Uzyg
	YNGaidobtsYdtSK7/0xghM16XH7AP8jOUNjKx1NmrxifTy7Anu8LVNe6p4W3M17MPliYekA0xmg
	bcNf5L0muShpQxknivwttt0YmnkwsHT8wIAK3HdIlRw==
X-Gm-Gg: ASbGncuFldCjjMqm0WUYlNh6igUzHlIRZtOi30ZtvRLk23HBLGFugKabcdsLr9L9Ohe
	HHl/FkKqCpXQ+QUUJ38q/g42IjCrOzGw/szGhUgSqp6zwfzIHW9g7lWxNXPA5y7ahqoX5i9t2f0
	wm95knSMSRpObWMKRM028wTX0EFPDuPJLu+4g6LSpiXOggC8EEs30U+gYc+QLD/IRsAaNuT9BY6
	tGBkSA5qWAgWF/7JHn66aG80g3/mzes1H68conlX9Wywg==
X-Google-Smtp-Source: AGHT+IF7b7Fa96HeawzlccNm19A8JZGLHL8MRKn42K1Wdqx+XBHi7MGJjQr+rqYT76RP2cmaJo0VhIiErdCjMF9pXhc=
X-Received: by 2002:a17:907:7b8d:b0:b04:4175:62f7 with SMTP id
 a640c23a62f3a-b04417565a1mr57680666b.33.1756723011734; Mon, 01 Sep 2025
 03:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com> <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com> <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com> <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <661e6140-572b-4480-9ca2-6a127730f32b@redhat.com> <CAKPOu+_KbBRdtB-WiZuiva7Fqsus4x7zBOPkqdhwfYFkdS-doA@mail.gmail.com>
 <25f468d2-8474-4d27-9013-d4cac7675897@redhat.com> <CAKPOu+8YMLrtqbhhQ0SgfQN2xErVhZCLEoStRL-YJy-SeHE8ng@mail.gmail.com>
 <5636a473-2a0a-4d25-95a4-1db48a1752ec@redhat.com>
In-Reply-To: <5636a473-2a0a-4d25-95a4-1db48a1752ec@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 12:36:40 +0200
X-Gm-Features: Ac12FXzuAjDMNh01gCwDOq89AniTuQvmvFYacWfktC2xpar8D-emOZa2oiRnOak
Message-ID: <CAKPOu+8JwdcK4RJDt7amCj9-V0K8Xjmtt=HHWsrET=EEyPBthw@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer parameters
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org, 
	hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 12:07=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 01.09.25 12:00, Max Kellermann wrote:
> > On Mon, Sep 1, 2025 at 11:53=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> >> I'm sorry, I have no time to argue about the basics of writing a patch
> >> description. I even proposed a simple example of what we (multiple
> >> reviewers) would expect as a bare minimum.
> >
> > But Lorenzo Stoakes and Mike Rappoport wanted much more than that.
>
> Sure, if it's not a simple "test" function as the one I commented on, it
> might make sense to explain more why it is okay.

Lorenzo and Mike commented on the very same patch as you (i.e. 01/12).

I remember that you provided an example, and implementing that would
have been easy - but it would not have been enough.
Matthew's patches would not have been enough, had they been judged by
the same rules.

