Return-Path: <linux-kernel+bounces-746008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DFB121DC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 750A05872C5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB62EF289;
	Fri, 25 Jul 2025 16:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hckB/HoM"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66D2EF297
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753460490; cv=none; b=sZ5i4BCNY/+leXHHtOFrf8E+5q8/MyxP2IsGfmRaxmfPaDtRB5D2PRHsh+R/3aKbh75bX5MJBKFJqS62S8xBvOy1VJlGhPbvfGuLCDKxhVUbhHxYEt10YXwrjSvmPi5OfiFcXIFqVuGcRw3ltDiu4piFRVnb+jMYskDJ8Fo15xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753460490; c=relaxed/simple;
	bh=V1gZztT6mGTm/v5bvkFti9UFRufHexvZ/B2J3isAYYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAs1ulN4SjDNdvZlYNeRBTchCpoRwNU4RM/QI9LiWINo/lUSgVdm93uNKu+mumvHV4fQGhOvAoa8Xp1UZkuJlZlGkkuw14jllNXPd5VrFhp6HhXTnVrzwjC5SRyygdLYy6+TBcRLPSNHKx12ZE5S8QtbCvw12byaPwLSuICOu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hckB/HoM; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-302db17fa08so194794fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753460487; x=1754065287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVzrieIwdnPi6sN8Ubq0Mmy1cHqqcphNnLkLj3BPLVU=;
        b=hckB/HoMlOuZf8KkyuvsOJKlVhPYXZHqcrYGaqO21ANBPOhzd1nCsbWupTDPW02Sob
         190W1NORQOHQYonV6aS0B3/EJ7F/+h0yplaQJHzTNkST5rZ4ZA9lbRQal6jA7718wODX
         yCQXk0ed7fjsvO9njt6CqtMHo3wcr//7iL7YA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753460487; x=1754065287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVzrieIwdnPi6sN8Ubq0Mmy1cHqqcphNnLkLj3BPLVU=;
        b=aL6x7yIlzSafMW/dJDgMW9dFqE6jlAkk8rgD+iBSajUS1Mb8zmADF2QQXiSu4gHELh
         /c9ALQBPEhCx+ZyM6fXpz2uzkLhnCVZiq7oX1wisSuM6ELM7QzDdqo0THufD9unHeHnO
         Eq16gpQ08JvMhXCBrbpw4zRZIK9ESPKU2rLnNhyvLa87q6MjhYo9eT6rQrFJEuFti+vG
         Zki58dNJMZRPHiYUcEwPnqmS+lhf0x1vJWN58FZCg1AM7cYyKk8TVOk4NotYy3dNU94+
         WB35HBmUVexziN4mWerk8Fn0Dqonsqf6c7dLQrajKTb4aoq8YxxYEsmnkXbQv+yb9a3u
         h3PA==
X-Forwarded-Encrypted: i=1; AJvYcCUNzM3lQfIQuwliLLMISckfga0PzlPdD0nkIrjSd2SeglXfc7cqEO7h8RKAyAUo4pvrVf/eGbZ1yLD2HbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIL3XLAU4rKStyQXd7F+62GdAhGtkvHCTy8bcd3TZAQSBJ57qE
	fnImZBp9/XtY4Iprp3zWv3GAhYlcl//qf7dFfg0+C/UwzHCDcrtEg+l7/Bay3QmUhvMDp/kWywU
	ZBTgZA20BuCtd+3ihcCjkYQIe6QmSWfN8ueslaemi
X-Gm-Gg: ASbGncs5Z+my1gsTdf9zLvz43YMH6Oq/yACEX/xmNbuHwmHtr33GN7YLvdFpVfshu1l
	mia39EsTFHUpJlScEmCpGwV714C4WGtymy+f9zCkGfZY7hcIYKs9Q9fT4pH+N57gAXrBKjU7ZnD
	PR/8/b2xMh8XjqAb4VifbCF6f18GN0XQDU6RYxyPWwiTeELi/zvv4advwRAsKxMkFwFGbHNGXtx
	tTV3JBVoWZfRmz62yem8dzx2vFz7JFnkJbBWw==
X-Google-Smtp-Source: AGHT+IEPyhNtBJv6l3iiA2DfeR4DXSweFw1h+Ay3otH4M/e2Ztm3RdN6/cXav9yGbayFwPQTfZ8UNLVyy46HelNqwHc=
X-Received: by 2002:a05:6870:a103:b0:2cf:c478:190d with SMTP id
 586e51a60fabf-30701d36839mr516981fac.9.1753460487544; Fri, 25 Jul 2025
 09:21:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <202507241352.22634450C9@keescook>
In-Reply-To: <202507241352.22634450C9@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 25 Jul 2025 09:21:15 -0700
X-Gm-Features: Ac12FXws9vKUmPauXE3BL2RflRgVyk9FnCEdjyJy-p3LV82aBv-BEdrFMBvPZNE
Message-ID: <CABi2SkVV-V1jk+nB8_+6roG1-giM1DzhFP+V0RnT0UMF9qjuJg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 2:15=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Jul 16, 2025 at 06:38:03PM +0100, Lorenzo Stoakes wrote:
> > We make a change to the logic here to correct a mistake - we must disal=
low
> > discard of read-only MAP_PRIVATE file-backed mappings, which previously=
 we
> > were not.
> > The justification for this change is to account for the case where:
> >
> > 1. A MAP_PRIVATE R/W file-backed mapping is established.
> > 2. The mapping is written to, which backs it with anonymous memory.
> > 3. The mapping is mprotect()'d read-only.
> > 4. The mapping is mseal()'d.
> >
> > If we were to now allow discard of this data, it would mean mseal() wou=
ld
> > not prevent the unrecoverable discarding of data and it was thus violat=
e
> > the semantics of sealed VMAs.
>
> I want to make sure I'm understanding this right:
>
> Was the old behavior to allow discard? (If so, that seems like it wasn't
> doing what Linus asked for[1], but it's not clear to me if that was
> the behavior Chrome wanted.)
Chrome V8 JIT engine only cares about  anonymous mapping, not file backed.
I'm not sure about all of Chrome though.

> The test doesn't appear to validate which
> contents end up being visible after the discard, only whether or not
> madvise() succeeds.
>
Agree the test can be improved to validate the read-back after discard.

