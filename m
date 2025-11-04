Return-Path: <linux-kernel+bounces-885495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845DC33217
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19AB34E8F22
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1162D061C;
	Tue,  4 Nov 2025 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="euKRhBKI"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24FE220F37
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 22:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762293991; cv=none; b=a+1odUTzIBgp+/iEoJy+P9hfQq54j1fomeFGb6ibK3OEy0PD/4LsHI94D3NtvxWUyquGBBhXx3/Shjtk0L4zOD3uEl7UtZ94rLg4p/bDCosr3sr2yecHpyqtUfvS1fzDAWvW3SXZyU123VL1ncT4HFkcH63wKkrfP/xDAu8pCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762293991; c=relaxed/simple;
	bh=MB7A1vTXVybnoioucy3wrWv8+Jn81ohbURENXs0pUhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VXwBojTDf2SOF5NAhXYZoRuAlxhBuUkbfS6x6iqlvoFBQEeQonQX8lKrfdW4MYgNZ77F24qYdYUUq9/lssYW2NaH5a57gJcTZ2wCVE+9YWAYFF3CXvAX0xiE5KXBJKe62WjpSp8I8XHMyJIoF01ToOPAMcnXzSWKMUqH8NPoSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=euKRhBKI; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63bea08a326so8565043a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1762293987; x=1762898787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OSolmfNCqKzaq21h0SNVzfu+X5TQh0oCJL/32vsBw0A=;
        b=euKRhBKIhWHlUZkxH305vxstP7Up+UBimPKJf2S7Zqp9MZgiwdRb0ELLzSvQ/k97uL
         Jbo4vlxjodsD4q3wpI9ZYnzGr52CxYpxSADXRkQriDZUhG43Xts3HejRCPIwBhGfaRKc
         d+jzfU4oN+OJLpXHWuTxKCSrXM2vtBu6EGrgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762293987; x=1762898787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OSolmfNCqKzaq21h0SNVzfu+X5TQh0oCJL/32vsBw0A=;
        b=jY1xNHree4qSRPdTVrs+gZGyhyemhCMfyT4fJgXXhM7GgktGqTz0G70Rld0MbhRBH5
         2mtBRjvl6Rorag7lWw+D4M38YP89/EYIO3zTN4nHBKx/5e388ZRIkTTQVTXCLylGPLmX
         HGGj3J8V44c/kMFzrpk3VUa4ujF4lyHNsaGD0J2IYoo5ne8K1lgbOPwC+z3T5+vuByIv
         VAnVFY22f4BnTT2B4gnYnm5n4fE1MmvagTuRH642pLBoutERZnXdnS8vUBi+hy6nw2fl
         CTT9vWNFnnGXpOD0OxrPdqnAEKN08tB0zwKup+4sV6LsPAhzjO8FXYqu/59294sp55hF
         szhA==
X-Forwarded-Encrypted: i=1; AJvYcCUr9sdFkNcHjNv+7DemrNonSURomzY3QYVvDU5GixbAJrzyM+7st869ElT40gquEVKQNOocUpPxlqr/yhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztYe3EyUPCv2FgELMUb4d22IXmcdp2mHMy+EjY0tae3P/2Ph4i
	m3DRNH8fLkEjkrUzbU11S21ZVIrFOyNa+V3SJO+2BJlDXA9W1ZWW2Qu33cMljhBygfCKLz616nr
	ecPXtdTM5IQ==
X-Gm-Gg: ASbGnctQ/aBlnHpsULXAES6/ykGVh1L3OpasGwnW9FE9ewCdvHWIyzgyZ2hEQZVWeWp
	LPDusutLnlxtgV9pZPmJbllu1kUYeJErjmcBQeDSpFY80/lc7L/P133Taei/Csf8nJmGFl4kcWM
	MN1yf8eVBUtuYOr42AgjJDZYozKXmJ1/X7XncNr7cft4UD7JkgTaM3tr3vFb73iMWh3y3v9fdaP
	NzxEeZ8Qz+1DzvM/fF04NUAoj3j2ful/vxMj318xmURxHzHq31KsXpaRwGAtvHQ4vnhBtUrbhy/
	g4rKgDLBak/sSBE+INkJFCZ4noSxIHz7OeuVKR7ZXD/5k+Z2s9N83xLQwHwB/xZa5Q3W6XyjPKn
	52QRD2Bo2YpAkB1FuvYgM1VxCTs0tkIwJkemHiliRbCkmMGNURd8/yLu1GR3O5FuyY1Ydh17Qmh
	iHFxbJYX0u5BxNDDukqWZQ9yE5ntH5ruTW2lBMvh1oJ4675kw+Ag==
X-Google-Smtp-Source: AGHT+IFM71dJtvVt4y3XYuUCufOaJMN39l6M3ThA7lRbw17ohntxlbuVCxHs36LRUQwKteS+HyZ6eA==
X-Received: by 2002:a05:6402:1d48:b0:640:7402:4782 with SMTP id 4fb4d7f45d1cf-6410568513fmr685956a12.0.1762293987049;
        Tue, 04 Nov 2025 14:06:27 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640ed469107sm2417381a12.17.2025.11.04.14.06.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 14:06:25 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640c48b3b90so3742698a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 14:06:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpay2xirGES8amvUnwEjCLjmdhCbHk+QeBLepQcLr45sVl08T7plkntMN9sZpySBWGgjA/VA3A7I4Kk4M=@vger.kernel.org
X-Received: by 2002:a05:6402:1e92:b0:640:96b8:2c36 with SMTP id
 4fb4d7f45d1cf-641058b31fdmr653807a12.11.1762293983503; Tue, 04 Nov 2025
 14:06:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
 <CAHk-=wimh_3jM9Xe8Zx0rpuf8CPDu6DkRCGb44azk0Sz5yqSnw@mail.gmail.com>
 <aQozS2ZHX4x1APvb@google.com> <CAHk-=wjkaHdi2z62fn+rf++h-f0KM66MXKxVX-xd3X6vqs8SoQ@mail.gmail.com>
 <20251104201752.GEaQpfcJtiI_IxeLVq@fat_crate.local>
In-Reply-To: <20251104201752.GEaQpfcJtiI_IxeLVq@fat_crate.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Nov 2025 07:06:05 +0900
X-Gmail-Original-Message-ID: <CAHk-=wgoajqRhtYi=uS0UpmH61qE=tBCwb8x3GG6ywZUqWY6zg@mail.gmail.com>
X-Gm-Features: AWmQ_bnsCqWH_iYKP_EdZA2WzLcUhVAfQWPyoyRVWTol-RWkziiQu5qj5FOPxAo
Message-ID: <CAHk-=wgoajqRhtYi=uS0UpmH61qE=tBCwb8x3GG6ywZUqWY6zg@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Borislav Petkov <bp@alien8.de>
Cc: Joerg Roedel <joro@8bytes.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"the arch/x86 maintainers" <x86@kernel.org>, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 05:18, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Nov 05, 2025 at 04:07:44AM +0900, Linus Torvalds wrote:
> > In fact, Josh Poimboeuf tried to do that __get_user() fix fairly
> > recently, but he hit at least the "coco" code mis-using this thing.
> >
> > See vc_read_mem() in arch/x86/coco/sev/vc-handle.c.
>
> So Tom and I did pre-fault this whole deal just now: so we need an atomic way
> to figure out whether we'll fault on the address and then handle that result
> properly. Which we do. So we only need to know whether it'll fault or not,
> without sleeping.
>
> So the question is, what would be an alternative to do that? Should we do
> something homegrown?

So I think that since it's x86-specific code, maybe something
homegrown is the way to go. I mean, that cdoe already effectively is.

With a *BIG* comment about what is going on, something like

        pagefault_disable();
        stac();
        unsafe_get_user(val, ptr, fault_label);
        clac();
        pagefault_enable();
        return 0;

  fault_label:
        clac();
        return 1;

but any other users of __get_user() that aren't in x86-specific code
can't do that, so I do think it's probably better to just migrate the
*good* cases - the ones known to actually be about user space - away
from __get_user() and just leave these turds alone.

              Linus

