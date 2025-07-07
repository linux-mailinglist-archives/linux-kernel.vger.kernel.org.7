Return-Path: <linux-kernel+bounces-720435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1756AFBBA0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C5D7A7B7F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5CF265281;
	Mon,  7 Jul 2025 19:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DDwP69U+"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D08194A59
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 19:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751915853; cv=none; b=BNz/P5frQn+3Kq5MtMmUy0G2NQqs2Q5IsT4i30jrIFiYJsagqSRF82tf9ue2vO5JONwNKg7RcRZ7tQifTeMAes8zgD0SJjFuWMJGocQT/alGAKzFrnOWvQGMLyJOAuKyuZsQV4Jw3/JpgswttZgWGTNCEraNjBZBmay28H/0dC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751915853; c=relaxed/simple;
	bh=uRFpWHfbO2dbX6V289e+RsPoJGGkbhxPuKlvbG4Uu90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUUtj1RvuBnlmPYmpcOLDBf2W6A0UrnUKTplsNZ8d9S+CY65cT1aE3cjYz11VlxBS8o7YTVWABhsHx7iMJ5P07j0BhINuVcgH335XyTW3qftcrhBX6TIUqREu8A99hN4X+ltP89Z2dDWQJw8zQxTV4VdosGKCVW9bVrRub69FIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DDwP69U+; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso6827619a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 12:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751915849; x=1752520649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ORZDLd02UGkkbh45cfJ5kZRWnBYJOZszPOFyiadW67g=;
        b=DDwP69U+Aiyjf8iQE3BnFXro++MXch5SRDaMIsU/KPVpsOi52mb80xuvpV7xhyv++5
         cxpCXovumAtjvwPFuqxlDkhxbOyASH7hLAL0xRpCfd0vvB45tT1S6L2+h0BqIrZa4D8X
         5Rkgqjo8rpPv977zBbdLOJS9jNyDBqMGY6aiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751915849; x=1752520649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ORZDLd02UGkkbh45cfJ5kZRWnBYJOZszPOFyiadW67g=;
        b=pHObRrVDBC5UmVVRJYpo+svOBuTSuQKT3Bhe4p9w1cTFKce9fxuTqAAKMreqhH/XFr
         fOkvcg6BqNzMDAa/dqaVsItQG9CbDCilvnAcE3DRbEzE9sKC1qIRp7Dxi8YDTDXbzfcb
         HBMFv7zw0C3PSa0fFCwVIQG8l/qJ+xy7TMvIyTzbVoOHppiTzim2wDEH/e+TbT8t76wn
         VBrfwBnRyWnqPVAHhWfPP7NA9DW9pNuGdwmR/UDC1UzE+DZlW/BBLHipmzEVfSbg7GoW
         G9RKNeomHPUgqUHHD7RNs3+PofPojucnrKIDmumjwJ3OoV7q2KwZolfrwUNpFiCNfs1p
         BBPg==
X-Forwarded-Encrypted: i=1; AJvYcCWQfOiWSj9O9MYUw/hoNg//gQ+N1MVeSZDJyOuez2ZACiXM6k5N9YXKiHDT8dyB7cklbUCrZJx/xkrJCjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrAQsyD9B0IApbsDTaisz70RNSK+PZmJQFeD7p2WJL1sRxvVe
	5DIA3b//gfJWWzDAtwJMgfqaoD/Gfe8Ntwsc1hHKP6/kO9xiAXphp+x8Qo4Tnecwou8/T15xXqq
	Prhxtluw=
X-Gm-Gg: ASbGncuG6Ievm+lwFqz6oYPICfX+M0OCkXgUipQpUmIKFWvbqvP6iWLwbCH3RtZJpzy
	OMc76Gghyu6UEbwpEukiBZ6ZDraXDgwlkxC57RXBl6arbF9MBsHEseNzNrR2mk3W8QqmVLwj/vK
	PSRt9lgOngBRMYO8kWlL/FjIEXdjmUb5YHJztW15W5KtaTurHIy9M9RS90c/J+9afH7eQOFKlJC
	kf75RgD25ygodK9Q7ON0TkIitAj3rnttCqR0+ywoJJZOe5zAIm5re7kSIms5HXorwAqZl5MoTTO
	YU/8ar91BLs/0P210afaGKQMIvqJBD01XjelE6x9XkUz4lRvaRXUpRwn78aLl7Gwa1k7buuI8ou
	ypXcjCUMFz4DlFwyDG1pwU2yBQG17ui7g/22u7hbZO00vDfQ=
X-Google-Smtp-Source: AGHT+IFLBoFt8czZMUHCk0U2F4qAXKeMlFbb22OX90IRI/RsNF6ZEvC8WE73tOUFVrtnEdixalNiDg==
X-Received: by 2002:a17:907:d8e:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-ae3fbcb398emr1336858566b.22.1751915848930;
        Mon, 07 Jul 2025 12:17:28 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f66d91f4sm752205066b.29.2025.07.07.12.17.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 12:17:28 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso5877013a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 12:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWd32p0iYeCLCWWNeHUoseC2w2bbUJMBkHflMIHEykW8vEz00zrmCVOgRIW4SnNOCXKxinEAWqC/sG/shI=@vger.kernel.org
X-Received: by 2002:a05:6402:430d:b0:607:5987:5b90 with SMTP id
 4fb4d7f45d1cf-60fd30d6669mr12436985a12.11.1751915847772; Mon, 07 Jul 2025
 12:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751862634.git.alx@kernel.org> <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
In-Reply-To: <033bf00f1fcf808245ae150346019aa7b997ea11.1751862634.git.alx@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jul 2025 12:17:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
X-Gm-Features: Ac12FXwOfsR2-wc3VkxaTo-SkUQ3qs88-iLy7sw-vzL7AWJu7PpVDNuYiHFuVTo
Message-ID: <CAHk-=wh9Pqz07ne9iSt1_v0c14rkOGvF9AbEkaq1KnFhQD1SSA@mail.gmail.com>
Subject: Re: [RFC v3 3/7] mm: Use seprintf() instead of less ergonomic APIs
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Sven Schnelle <svens@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Lee Schermerhorn <lee.schermerhorn@hp.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chao Yu <chao.yu@oppo.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 6 Jul 2025 at 22:06, Alejandro Colomar <alx@kernel.org> wrote:
>
> -       p += snprintf(p, ID_STR_LENGTH - (p - name), "%07u", s->size);
> +       p = seprintf(p, e, "%07u", s->size);

I am *really* not a fan of introducing yet another random non-standard
string function.

This 'seprintf' thing really seems to be a completely made-up thing.
Let's not go there. It just adds more confusion - it may be a simpler
interface, but it's another cogniitive load thing, and honestly, that
"beginning and end" interface is not great.

I think we'd be better off with real "character buffer" interfaces,
and they should be *named* that way, not be yet another "random
character added to the printf family".

The whole "add a random character" thing is a disease. But at least
with printf/fprintf/vprintf/vsnprintf/etc, it's a _standard_ disease,
so people hopefully know about it.

So I really *really* don't like things like seprintf(). It just makes me go WTF?

Interfaces that have worked for us are things like "seq_printf()", which

 (a) has sane naming, not "add random characters"

 (b) has real abstractions (in that case 'struct seq_file') rather
than adding random extra arguments to the argument list.

and we do have something like that in 'struct seq_buf'.  I'm not
convinced that's the optimal interface, but I think it's *better*.
Because it does both encapsulate a proper "this is my buffer" type,
and has a proper "this is a buffer operation" function name.

So I'd *much* rather people would try to convert their uses to things
like that, than add random letter combinations.

             Linus

