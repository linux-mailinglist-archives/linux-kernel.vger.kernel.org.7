Return-Path: <linux-kernel+bounces-866238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4ABFF445
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 07:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1181A4E426B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 05:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7565028DB3;
	Thu, 23 Oct 2025 05:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FFQzJ1EZ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768631F5EA
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761198360; cv=none; b=nEr5qk56BHrTTE15lsQ1l6OFpMEcRhFz1GFsMX4Gtka94wGZf5gCDrmGEZP7r3wKUhr8jliFrL/HyMMmZD6BXeSqlbeyAct+emiPWdNm5lsMIWR38iy/SYGoj4yJpEbcvpE89PkOUeCFkeRBdPLSYfigKmnOkQIJfil//kj1g5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761198360; c=relaxed/simple;
	bh=2dckrm/UK6V634aTCLjgAVvs4wo6c6L9h8Gtd9OX89E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qsg5nrq4Szy5U72Zlv+YlRnfEXIRyqM+a68A9dwcDJzWHvZUVOvYeWZlz6gDpckpRlrvh7T9N58f3gVoJjR7bfX9ZUTnNLiwN0D2qNaRh6GO4NhuOJeSQt0o6didBYOV47PIJrlrN1mqjQ4NcBekvsZSthHhXpej+gf6sB0BfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FFQzJ1EZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b457d93c155so81768966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761198357; x=1761803157; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EpLC/YIfU6yMLW4SxxDWNvKdV2xI4uQU1cRoBBYT5xM=;
        b=FFQzJ1EZkPpAz+edc6MJUl7AkMCG0Q5y/OTHQbz0uDnVWcnBEc3jZ7UrBn6MD9fMEc
         6Tee6+G6U6s1rrlJiNsHnaw7Opd0V6hZfIr8r8Ey2OleO6F4spT99QXmas3cTEI3Jtx7
         /crem8p2eN+pQddlvH/QB5Je3MGQLSo7xpznk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761198357; x=1761803157;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EpLC/YIfU6yMLW4SxxDWNvKdV2xI4uQU1cRoBBYT5xM=;
        b=qmB6qW0aDBPfnUU/GyQDHNHrL5mOmPkwFmirx9eJlolooQFEtzwhyom2Ld/y6A8WtQ
         cmPesagELDFlkOaF79YyKpKXuGrHGSAdKOD4uONhoOCPyuZAcE25N3ejLzoVMdI9dk8I
         +V/jfeXDzYIBOE0zUxdB7oLfUz5yFxOYFtipCigkEdFrFprLgtyG14mxwP9eL0pOYRRR
         mMD+W/qPl5r62OV73Xq3KYrK61ydScoj+foDG/96BJfVq6Bla3bcGQbTRQepcXcB8hPg
         Fc5A13yLSLD8RJNslJ8SvGpPKqzJj/DilaJPFzvEXtrOgFuGFut16yf0gxg2Xf02+N7N
         nCRw==
X-Forwarded-Encrypted: i=1; AJvYcCXxF7fcjsgMiVaUK/XekU2jyGV2Wx/KBOmm5TTykCT05WnWU7MijfuQ3tkCrtb0gmOFv25DePj2KL9JJvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGAm5lODYhFBF6nZjcfMaU3oOwUf1HWNJsx0Bf+eiSuncgfFj6
	ujwxKo+32ebCy8Kht4zCxcH0HbZ+fTW8+fTfX8NQCFg+MBwHH8VUBRi4zKTBoUN8HSsM9m2GtOo
	4B7ub0o5aWg==
X-Gm-Gg: ASbGnctt7Ya44Q9g9f4dFB8UOwhcIJOLRe9N0yckCFw/G++8KRkPvZycVMkXS5vzbFH
	qMpHd2FooTwnMXe04Bf+38RElWAmSpg7/RNFhRgrz3sJFm9IrFtfp526cvcHPcZmkI1gkVkB0M3
	bE0gP3JM+KmK4v5Dhgwd7uwM/fweGQA9mTe8LcsB+130KhdwkxJd7/aFdfSQNk6vePE75TPA4YN
	nFSrUxzeayhswLW+w2qd8SlEVuIHxfeVVH6kst+ooe94i5gusdPXcOWjHueve6g/sQlAU8qVTgi
	pgJKKOTd5ixsStNzRYkIPzdDirJizSMteP/zZJZAF2mVC7zhkLnLUVW+T4dhqJS59jpD4Z/iCw+
	bz8pzSRwU1hy9aR1SCJ2I0JOsuwZKz26QSdwH389HQlzPVQjNb5j6l9XOWH0D4dEjRGzAw9smMy
	ali4s1rSSClMfZ9gCHQo7uI8k+NkCoYnNhWTcKzrgn+2omwDd+9Q==
X-Google-Smtp-Source: AGHT+IFmgX0fIlDLM0j71qMBI4zznju0wTeVEYzmrgOsMyl/LvS8o3xihuQTI6Hnmgsw6VcmViHBUA==
X-Received: by 2002:a17:907:2685:b0:b45:60ad:daf9 with SMTP id a640c23a62f3a-b647254f6bdmr2757571566b.3.1761198356592;
        Wed, 22 Oct 2025 22:45:56 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511d2b13sm113380466b.16.2025.10.22.22.45.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 22:45:56 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so312921f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 22:45:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXPNFTY20qUgoD4oA2/Ap/yIX70uTeDamrbIiS5snjpeQ40ISUk/OWwu8+Ja+HJnOZdIgOFM7RikDzXiy4=@vger.kernel.org
X-Received: by 2002:a17:907:7ea6:b0:b41:c892:2c67 with SMTP id
 a640c23a62f3a-b6474940c41mr2905229266b.45.1761197863543; Wed, 22 Oct 2025
 22:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023000535.2897002-1-kuniyu@google.com> <20251023000535.2897002-2-kuniyu@google.com>
In-Reply-To: <20251023000535.2897002-2-kuniyu@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Oct 2025 19:37:27 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjXGvUnmN5ZL3nhj_J0cbiVfeHsM9Z54A55rgHRUaVOfA@mail.gmail.com>
X-Gm-Features: AWmQ_bk45WJyQfjQIDpRb59HoMm72eRtwroHiVS5YhkseklDQ1bsOMejpvZJz24
Message-ID: <CAHk-=wjXGvUnmN5ZL3nhj_J0cbiVfeHsM9Z54A55rgHRUaVOfA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] uaccess: Add __user_write_access_begin().
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Christian Brauner <brauner@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Alexandre Ghiti <alex@ghiti.fr>, 
	"H. Peter Anvin" <hpa@zytor.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Oct 2025 at 14:05, Kuniyuki Iwashima <kuniyu@google.com> wrote:
>
> unsafe_put_user() can be used to save a stac/clac pair, but
> masked_user_access_begin() or user_access_begin() introduces
> an unnecessary address masking or access_ok().
>
> Add a low-level helper for such a use case.

I really suspect that you cannot actually measure the cost of the
extra masking, and would be much happier if you just used a regular
"user_access_begin()" (perhaps the "user_write_access_begin()"
variant).

The masking is very cheap - literally just a couple of ALU
instructions. And unless you can actually measure some real advantage
of avoiding it, let's not add another helper to this area.

We spent a fair amount of time undoing years of "__get_user()" and
"__put_user()" cases that didn't actually help, and sometimes only
made it hard to see where the actual user pointer validation was done.

               Linus

