Return-Path: <linux-kernel+bounces-766350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B46B24574
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC73E1B677B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C466C2C17A8;
	Wed, 13 Aug 2025 09:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zspjrytu"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BC22BCF67
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 09:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755077382; cv=none; b=uQFFgVpTc9c5T/kobOQh3wdPw8BMBeYC40B9lKEjTDkvn5J2B3s3QWFC9FK6lOU8Fzn/6Fd4/2Ww2Ou+N1Nd65ucmfZxRrwXL8350RpDt1dgKseh++4VDUUkcaxAG7DwQnViZxcoIyN2SXzrKKgk2UtW7s4Nxr3EYWnIfzIedsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755077382; c=relaxed/simple;
	bh=NKC0Kv8Vlc4bkBI+DCmEQb9RfILcGe4WcZOgNG0vwHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeAZL090ibJw0dAovU1J5NNCcdJjOqSYRwgjLYQHDUXJrHnvaLT34qa5YXNjYdO64x1fBPiD2zuGOskL/gJKqkUFsDNZBMVN40HpgrrWnrIV4L5EsAxZWYALO1nBfedVQ2uJm3cynQwd0prvc/gkk7CY/OdXBxC19nmb+Me3Br0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zspjrytu; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-88ba493e984so410284241.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 02:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755077379; x=1755682179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4kWL3Gz2TOFzlWsu7ST+2B8+6Bmel5cv9oUEg978SI=;
        b=Zspjrytu53tv7gEOx44VdZGGaR4JzcHm+uqrCeW8iUTZq/YF/7okwLBaTYfxOgW0u9
         HBcqHJJgZ2E6qsBNIDH7z8rgMMDFYMNxR5R+s9yOKJImt1XpyZxlb55ox68jLsxMn5yi
         EQWjXoD/3zcoGtSUKDy8AZ/IByi0zI+RPKgXe+I/emezzkNklVC7iuXOCm9WJ0YerJhw
         grwjO8kvnipKUMavMZzyNMPbLOCEhm6qs9V42VTtePsElzrPPTuYnqu1hydUAKY7Q9ge
         +q5Fi9WpR0bJ5hY/vPVB+lKxawgqPIQ7TkmOY0XnE4nUpJtXqz/pYQ9sDQDlVjJSDpyI
         VTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755077379; x=1755682179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4kWL3Gz2TOFzlWsu7ST+2B8+6Bmel5cv9oUEg978SI=;
        b=t+eDZU0Df6t5NJomLM+J+v8C+YAxwlHLIEJxVXh610GOdQi900Nr+yIyeoBsribJu/
         NiFW4XcGOB/zRzL2rQ8APU1G3tr16p/+vcaBf05TCP+LwK9/dkEMzPbza70+k81GxZW+
         018QIKfrAJqaqnkdN4OV75ONixlvU5nN2WAlLbqThjIYYn16XiZM5HLbzrwwNN80eaNX
         AzkyLteQbDTw3WmxDaemKT5/iWRGAcEHJXkAjlKTLTAHaO3CpZzHtO7WistMB5vZihBR
         Jo2JdzlueXE7nu5YRpKDS7Rc9BKWV7YIuxEth2h7ONTqmWNb865xQpzsO9SwHaY8tEmH
         mpBw==
X-Forwarded-Encrypted: i=1; AJvYcCW7742me4Of+hVAN/1e+6YdfJvAW8x7J2ArWj3bNb8pAeEF3fDGmqz3Z782ijoPOWgH59WydR7tqEfysRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQiETS3WyKuZReSEb0TIPruBzEjTL68hrDMJF5njv4pl9ORVh2
	0mmcf+xeQiRrQTucFJgw8uteVXq3RJt2kD3H2CYR6onAaUJ/TZopowd6GOeyRPNHJlbkROZpQyu
	NlPjrQKpYhdy/QOz20EEwFv3Mi6lmunCcDoWT
X-Gm-Gg: ASbGncuCGLQujm9NE4YSZicpV98nvUu89B6iDQE8Fr6NnpvoGsIsxk+fuiFy2W+ANgM
	9++7inAsOSn2AjNhqAMaNxKxZVw7KMYrtuPF5DNqkYAWZfB2v3ZFUP2BIeHY6ISiz6aHs/AbsFR
	5oyJtMclq85pQ8UGWmc7f/6p9uLq/u7ujMdMCj0eyHeohfRnIu7Q+ki0d6MgjT+4vqaiCX1UY8R
	7py9pZV1cw8uBOPBA4QvL/JllRC
X-Google-Smtp-Source: AGHT+IHzVnB+RySoeR02l/m4FBqF9cFbiEyh6+2R3vKbPFEwr3aiZ81rtngMx46hTALCeVUB86t+4btFV54x8MopFRs=
X-Received: by 2002:a05:6102:510e:b0:4e7:866c:5cd9 with SMTP id
 ada2fe7eead31-50e79f44bd9mr550744137.11.1755077379395; Wed, 13 Aug 2025
 02:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810062912.1096815-1-lokeshgidra@google.com>
 <CAGsJ_4wbXkfaAn+79g20SfE-0Ak4QACVP+Mw2vAvMnxBCcLAsQ@mail.gmail.com> <CA+EESO4JFCR5P9PFoY2zo+X1Y-qv+-yy8X887isoqXwfQBtn1Q@mail.gmail.com>
In-Reply-To: <CA+EESO4JFCR5P9PFoY2zo+X1Y-qv+-yy8X887isoqXwfQBtn1Q@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 13 Aug 2025 17:29:28 +0800
X-Gm-Features: Ac12FXy6n9uSdRGJV-oDkgvaggWtIQ-s6auZffzcE9MoRq2yoNDzUzt5eVn4S5U
Message-ID: <CAGsJ_4zK5iLtYaT2o6ctnZNUgRoxrxkDJ4gnGrTOD7CW5vuRHw@mail.gmail.com>
Subject: Re: [PATCH v4] userfaultfd: opportunistic TLB-flush batching for
 present pages in MOVE
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, aarcange@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ngeoffray@google.com, 
	Suren Baghdasaryan <surenb@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 11:50=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:

> > [...]
> >
> > >         /*
> > > @@ -1257,7 +1327,7 @@ static int move_pages_pte(struct mm_struct *mm,=
 pmd_t *dst_pmd, pmd_t *src_pmd,
> > >                 if (!(mode & UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES))
> > >                         err =3D -ENOENT;
> > >                 else /* nothing to do to move a hole */
> > > -                       err =3D 0;
> > > +                       err =3D PAGE_SIZE;
> >
> > To be honest, I find `err =3D PAGE_SIZE` quite odd :-) Could we refine =
the
> > code to make it more readable?
> >
> Agreed! I'll replace 'err' with 'ret' as the function no longer only
> returns error but also bytes-moved if there is no error.
>

Looks good. Should we also include the following?

--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1246,6 +1246,7 @@ static int move_zeropage_pte(struct mm_struct *mm,
 /*
  * The mmap_lock for reading is held by the caller. Just move the page(s)
  * from src_pmd to dst_pmd if possible, and return number of bytes moved.
+ * On failure, an error code is returned instead
  */
 static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd,
pmd_t *src_pmd,
                            struct vm_area_struct *dst_vma,


> > [...]
> >
> > > @@ -1857,10 +1930,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ct=
x, unsigned long dst_start,
> > >                                 break;
> > >                         }
> > >
> > > -                       err =3D move_pages_pte(mm, dst_pmd, src_pmd,
> > > -                                            dst_vma, src_vma,
> > > -                                            dst_addr, src_addr, mode=
);
> > > -                       step_size =3D PAGE_SIZE;
> > > +                       ret =3D move_pages_ptes(mm, dst_pmd, src_pmd,
> > > +                                             dst_vma, src_vma, dst_a=
ddr,
> > > +                                             src_addr, src_end - src=
_addr, mode);
> > > +                       if (ret < 0)
> > > +                               err =3D ret;
> > > +                       else
> > > +                               step_size =3D ret;
> >
> > also looks a bit strange :-)
>
> Any suggestions on how to improve this? 'step_size' is expected to be
> different in each iteration of the loop even without this patch.

Usually, we have:

if (ret < 0) {
    goto or break things;
}
step_size =3D ret;

Given the context, it does seem quite tricky to handle. I=E2=80=99m not sur=
e,
so maybe your code is fine. :-)

> >
> > >                 }
> > >
> > >                 cond_resched();
> > >
> > > base-commit: 561c80369df0733ba0574882a1635287b20f9de2
> > > --
> > > 2.50.1.703.g449372360f-goog

Thanks
Barry

