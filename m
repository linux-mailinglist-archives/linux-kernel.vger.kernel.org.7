Return-Path: <linux-kernel+bounces-883714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A04BC2E2D1
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0B33BC68D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CB42D46DB;
	Mon,  3 Nov 2025 21:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxAt2FVn"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6545C23EAA6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 21:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206018; cv=none; b=L9GTQGdP3LM4AoJj7jpdl5aX8ILUCwrsVaE38+qvIhs7Nn3J9KYAn/YBHhFwE+A06n1TxZKAzfI0xUnRo8WhAT8MadSKKDWkBzx44FTzb5oRodBm5JO4LOCrl4KHOGMen5tgJ0llpsOp/FGRKg4O1cRlCgSHbzyLX+6i8GGafNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206018; c=relaxed/simple;
	bh=HxWerGeemdibnR4Waee5AVHxzwyT79KLkozZNFxD0+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8bK5g35dXXQeH0zAWtUNa9qRg4iNm34DmafsRdxRnaOW3vDAHPVoETuRFVLRRjDzQqcX0132QNvEvFYDqCVWF8bwo6yP4JJW04rmIvSrwQmEQvR1cc2VHnOVoEAPyOluSszAPTUq1xT0CAYW01Z2tGZMFIW5UeoS/DNkR5jriM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxAt2FVn; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ecfafb92bcso35721cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762206015; x=1762810815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9HfzJT2TTSo0HCqWtWIYRzi6Bq2mNqIEyj/9kWjbI4=;
        b=xxAt2FVnk2JINfm+yIZFE4eWJ6oKlwaZX6dexQV/c0PGGuodss/zAN3EdDIE2GDsM8
         HzqFboSrmhDrgJ4aEu0h0XBPd53LPEryo3Ee53WNlWySPBtXH+4RW35gWgn4uAckeUth
         MhQBDCVBvr31lneW2HalOkXDLYanrI1Opa755o24sT8cwG+7UrlaMvBK8+gyDppDeN6p
         ULn8q/AeZxOGyJCPnE8iColcChPoMj9Unq+/De7ikqGy7Q6PI+j7y/IxDZlXiFMEUxAt
         0vYwBgYVMQeT5UcRCTqYhQXnFBl0l3urLOm5ozdmIB2FsQaE32hBcXCsNNrgHxE95Mzk
         Js+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762206015; x=1762810815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j9HfzJT2TTSo0HCqWtWIYRzi6Bq2mNqIEyj/9kWjbI4=;
        b=pb1yQIZegM4/mvbAVk7MBumzMFPgTtqLyH+7Ekj1Jfz2VkHehfhYPrgdTqyP7pwf2N
         ayqTUS0XkVm3fRZhWMcIMKohRDw9/c6YiaRMM6kr+qAbwAT24WLbgoQaU52GQ8fBPlyb
         BKDa1ECSMfUbxlqvxpxx0iSGyam/zfQGVWRQVCYbbXpfWbMywDCTSxC70ComLwO0cdvU
         NQVjc71bmaSOCeH56wb0NBA8MC0O2RjJ2K/GnMZCDIih1cniMJvi6fRAiAUgXpx9kZvh
         Ve5XaThnRBzbfYMeP0cWwEehoLsoQyQeL1A3Ky5gRuyuwJOEjjF9XGo2BZqX52yLVuzk
         3yhg==
X-Forwarded-Encrypted: i=1; AJvYcCWbtY37SwDcYUs6Qc74Z0hxOg7xaaihuSfzCjWoIOUPHFFNtz2la/AN2ojs9xHjtElNzeXJehqGwjokn0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeawdmKDyEoD79PagSUogYD31j8y6itzjHSxuufYHhlrhTmL6T
	bcPk7dX3XZ3Id7AqVG0DiGFJWLMBzImLdvPm6ba8SKcZrQeop9Tv26xKnOStfKCeZYrOH5bVvrP
	kRTTa0HsBgMoLZqhhV/z7MbwnvYd3eFSMnyPv/TaE
X-Gm-Gg: ASbGncvLZczsYDrBNLMaL8A/ECnjmI7F6jnBnRq4/wvegv9O9hbDN+01d8UQ/RadIlF
	DZeD6ReRTqxQgG5zcoIBR7IynEucgIT0eY8VLJT1KkaHtrTZ629JODRSCzmicy4snTPq2jVG7N1
	/ltyFmzwEfE6yGcxgrswd/YeIiF9IMvtOvQoM2ay4BnKFQsOngx60f+uZFqfwkS1GraPwiRODYZ
	snC4I59M5oyPOEZyq5lwoc9/dRsc9slo6gQBaUh8gWaiJJ/LVBLNjvQYhGk50B5ZuZ/nDXDXRos
	vdTbGY/dBny4cok=
X-Google-Smtp-Source: AGHT+IF/oU32hdXAaCZuJ6oYhc7Q++htlBafj3EEnI2UBnEGDxNAUIoAl6OW0RuW9qSifhIz8qIHQqC5O1jleKFOd/M=
X-Received: by 2002:ac8:7e8e:0:b0:4e4:f2b9:55aa with SMTP id
 d75a77b69052e-4ed6388ea18mr431941cf.17.1762206014787; Mon, 03 Nov 2025
 13:40:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103185154.1933872-1-xur@google.com> <20251103185154.1933872-2-xur@google.com>
 <20251103211910.GK3245006@noisy.programming.kicks-ass.net>
In-Reply-To: <20251103211910.GK3245006@noisy.programming.kicks-ass.net>
From: Rong Xu <xur@google.com>
Date: Mon, 3 Nov 2025 13:40:02 -0800
X-Gm-Features: AWmQ_bn2cw6GzchnkI7Wmx2ba5usMfwjBir3mDWX15KaHwXzb1GaMPGTv9mUw8A
Message-ID: <CAF1bQ=TA9FZXcXk=eRqN_tHkJztd_BLEd14X8JWu7LoGHMAVMg@mail.gmail.com>
Subject: Re: [PATCH 2/2] objtool: dead_end function change for split functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org, 
	Sriraman Tallam <tmsriram@google.com>, Han Shen <shenhan@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Peter, thanks for the review! I will fix the style and send patch v2.

-Rong

On Mon, Nov 3, 2025 at 1:19=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Nov 03, 2025 at 06:51:54PM +0000, xur@google.com wrote:
> > From: Rong Xu <xur@google.com>
> >
> > Function Splitting can potentially move all return instructions
> > into the cold (infrequently executed) section of the function.
> > If this happens, the original function might be incorrectly
> > flagged as a dead-end function.
> >
> > The consequence is an incomplete ORC table, which leads to an unwind
> > error, and subsequently, a livepatch failure.
> >
> > This patch adds the support of the dead_end_function check for
> > split function.
> >
> > Signed-off-by: Rong Xu <xur@google.com>
> > Reviewed-by: Sriraman Tallam <tmsriram@google.com>
> > Reviewed-by: Han Shen <shenhan@google.com>
> > Reviewed-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > ---
> >  tools/objtool/check.c | 88 +++++++++++++++++++++++++++++++++----------
> >  1 file changed, 69 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> > index c2ee3c3a84a62..b752cf508d09a 100644
> > --- a/tools/objtool/check.c
> > +++ b/tools/objtool/check.c
> > @@ -237,6 +237,73 @@ static bool is_rust_noreturn(const struct symbol *=
func)
> >               str_ends_with(func->name, "_fail"));
> >  }
> >
> > +static bool __dead_end_function(struct objtool_file *, struct symbol *=
, int);
> > +
> > +/*
> > + * Check if the target of a sibling_call instruction is a dead_end fun=
ction.
> > + * Note insn must be a sibling call.
> > + */
> > +static inline bool __dead_end_sibling_call(struct objtool_file *file,
> > +             struct instruction *insn, int recursion) {
>
> Please: cino=3D(0:0
> also for functions { on a new line.
>
> > +     struct instruction *dest =3D insn->jump_dest;
> > +
> > +     if (!dest)
> > +             /* sibling call to another file */
> > +             return false;
>
> I know this is just code movement, but this wants {} per coding style.
>
> > +
> > +     /* local sibling call */
> > +     if (recursion =3D=3D 5) {
> > +             /*
> > +              * Infinite recursion: two functions have
> > +              * sibling calls to each other.  This is a very
> > +              * rare case.  It means they aren't dead ends.
> > +              */
> > +             return false;
> > +     }
> > +
> > +     return __dead_end_function(file, insn_func(dest), recursion+1);
> > +}
> > +
> > +/*
> > + * Handling split functions. Mimic the workflow in __dead_end_function=
.
> > + */
> > +static bool __dead_end_split_func(struct objtool_file *file,
> > +                     struct symbol *func, int recursion)
>
> cino=3D(0:0
>
> > +{
> > +     char section_name[256];
> > +     struct section *sec;
> > +     struct instruction *insn;
> > +
> > +     /*
> > +      * Use a fixed-size buffer (max 256) to avoid malloc. If the sect=
ion
> > +      * length exceeds this limit, we return a conservative value. Thi=
s is
> > +      * a safe fallback and does not compromise functional correctness=
.
> > +      */
> > +     if (snprintf(section_name, sizeof(section_name), ".text.split.%s"=
,
> > +                  func->name) >=3D sizeof(section_name)) {
>
> That is a terribly confusing line-break to read. Might've been better to
> split after the greate-or-equal sign.
>
> > +             fprintf(stderr, "Error: Function name '%s' too long.\n", =
func->name);
> > +             return false;
> > +     }
> > +
> > +     sec =3D find_section_by_name(file->elf, section_name);
> > +     if (!sec)
> > +             return false;
> > +
> > +     sec_for_each_insn(file, sec, insn) {
> > +             if (insn->type =3D=3D INSN_RETURN)
> > +                     return false;
> > +     }
> > +
> > +     sec_for_each_insn(file, sec, insn) {
> > +             if (is_sibling_call(insn)) {
> > +                     if (!__dead_end_sibling_call(file, insn, recursio=
n))
> > +                             return false;
> > +             }
> > +     }
> > +
> > +     return true;
> > +}
> > +
> >  /*
> >   * This checks to see if the given function is a "noreturn" function.
> >   *
> > @@ -298,33 +365,16 @@ static bool __dead_end_function(struct objtool_fi=
le *file, struct symbol *func,
> >        */
> >       func_for_each_insn(file, func, insn) {
> >               if (is_sibling_call(insn)) {
> > -                     struct instruction *dest =3D insn->jump_dest;
> > -
> > -                     if (!dest)
> > -                             /* sibling call to another file */
> > -                             return false;
> > -
> > -                     /* local sibling call */
> > -                     if (recursion =3D=3D 5) {
> > -                             /*
> > -                              * Infinite recursion: two functions have
> > -                              * sibling calls to each other.  This is =
a very
> > -                              * rare case.  It means they aren't dead =
ends.
> > -                              */
> > -                             return false;
> > -                     }
> > -
> >                       /*
> >                        * A function can have multiple sibling calls. Al=
l of
> >                        * them need to be dead ends for the function to =
be a
> >                        * dead end too.
> >                        */
> > -                     if (!__dead_end_function(file, insn_func(dest), r=
ecursion+1))
> > +                     if (!__dead_end_sibling_call(file, insn, recursio=
n))
> >                               return false;
> >               }
> >       }
> > -
> > -     return true;
> > +     return __dead_end_split_func(file, func, recursion);
> >  }
>
> Aside from some coding style nits, this seems like it will do.
>

