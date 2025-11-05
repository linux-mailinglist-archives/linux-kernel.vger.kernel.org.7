Return-Path: <linux-kernel+bounces-887430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774DEC38371
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF6E1A23730
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA2A2F25F4;
	Wed,  5 Nov 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VxRa6ZtC"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88A2EAD10
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382443; cv=none; b=LLaAvcrq4vD4E8+xE5n3ENo9KJPJFechizZmyCrtjRPjV0PGmZoRH0evTi2kPIMZQqRZmuoJqfSPXUqefm2dNikJ1ApPhzG9bCNfluYN3Etcj4kMjrozalLHGQitil/WewOSXndf8KXcC43gOlyLPUoIBFHkd4Mz/n4M9doT/ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382443; c=relaxed/simple;
	bh=3hkKug39+4TR4kkH+vcZdCG4VPG2upJqx/o/C7wpd00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbVWQHG8I/wQkBdbDjoB3wsOAnpJAAH+j7wFs7Wzl8dsE6XoKJqznAaNCRR+jidf3TbX9n6/EatybvLZuYG40+ONDVeSfbgyS0f7VxJ1i2uUG1ZGC5F9ja8wZnqZRoAS24tELl2pZ+SxXgt7ikjgTxrSB8NmjFIhTTa8V0zkwy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VxRa6ZtC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4e896e91368so4205661cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762382441; x=1762987241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21qXQLNolzTFs72n7I5BKiJh68f8xT8gJueGc1dJJD4=;
        b=VxRa6ZtCzV+zt07vfnfPMV+vIf0aiHjWdM0Bc0Qxjfm9w/+vca4DDEXC4+RU92H83Z
         97JoncfaGwE3Wboe29SFoxDJLJdJhS4HQo7cN+LQBGJJIp2NnqAyYbugFi02Ma3CYnhv
         qXWfcHAib1C9vYm1bxIh8gleG81U5/hIUvXnmCqlzK6VCBYhwqUTHrQzKVTja72q49+W
         Ljj8CSwwgNGzNh2vf9dEQ8ZZTVNMEdGSkmLioe0KklQyEWv0/WX7AKxKjT6HcwwzlIYw
         LiqaruRrX6MXtkfA4oVWgM+VBIlUoPcDFbAlZupMMrL+JbHkPlzsLRsmAb79jbaQhkZY
         szYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382441; x=1762987241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21qXQLNolzTFs72n7I5BKiJh68f8xT8gJueGc1dJJD4=;
        b=JiD1MHVYgilW4v4iEwZrqaSU8XUYbfyD83PzYm4Nqd849x2H2MYutuC8JLwueb4pYc
         XhaW9UiQ6MUxGkE/hWokY22sRZayXMJE5g8uQJCgkGKOsKbajEPnTNcEEc7WzGBy1N47
         RZxO8dIeiH7ejuaF3ETWnUgVuuARIFykpGVlrBaHkiupq5fZnGJoNyto2w/7YVwaX55+
         i1tpbI4rURLsXttpHzo4CJVWaoFz7F3KkAo4Bt9D4F2Wufxzc0EzJfJMkckHCoKfh6qa
         yejvb2zXeZTcR7KzibJ8ru/57Rhe1EQ2T5FZL4bdHAybW5SsWJibmbzrBSnFmJSUckFO
         lw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs0uOh6zJwj/gHHrX55GjRk113fx9LzWbslnFzTKm0hz30zNFSy4qrG2A3Bo1gUBdiiuV27xGu2r8t7/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YysksiKotZ2U/CcA2e69WXq9W2Ihh/9HKH1cSa+IffFzzCJycvz
	Va6zLtrGzQhKKy7D1rEIBSZiqkpzC/Ua0teQ0MegzMJzecMiu209CpqCzqc7/yj44tMdzUrAz6s
	QuXJJHdnihqzesI96krg9cFxm0vwK/kFyxXzbzNwW
X-Gm-Gg: ASbGncs+E5jRErcues6Nf7p2t1P13+SJoT9nWjuk/vv/5nYM0j87e6KqXFiKxLoReYP
	fnGTdJ0AVwYC6NaH221P6H68ae3O8BYZjrKI3tK6U+UvI8/SL7SVty9lXRidwKg7rbQZDYR/WAa
	/4c2bhVQIsP4lqSZkKtKdpe5+6DBzWi6bN1lN/0bDf8XX3Hu/pLW+WPoLkq2bOApb0Ndovs15uM
	qb/XpTwxYRx75JwLK5QCgw5IIUAV/yyGlomMmoHTncP1Kj+84c71ZMUws/qGng0L2D83Jklwwth
	0Zt7ZM2PuYNQY39EozRnwSAJhV3U
X-Google-Smtp-Source: AGHT+IFg+F2Ata6x8dN1l6gIoGdg4pDHv2N8V5ZQ7hPdvjQ3qX8P61Yda6M7LKoKh7JHKEcIv79ez6Ma5pah8Xu0zFc=
X-Received: by 2002:ac8:5ace:0:b0:4e8:aa15:c96d with SMTP id
 d75a77b69052e-4ed7262dd8bmr60160061cf.55.1762382440446; Wed, 05 Nov 2025
 14:40:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030-lid-switch-notifier-v1-0-c58dc9b1439d@google.com>
 <20251030-lid-switch-notifier-v1-1-c58dc9b1439d@google.com> <a4zd7uzo3aigyrhturbpgtcsm2slmtqefivky2bfhqiupcc5aj@iorbkwz6ief4>
In-Reply-To: <a4zd7uzo3aigyrhturbpgtcsm2slmtqefivky2bfhqiupcc5aj@iorbkwz6ief4>
From: Jonathan Denose <jdenose@google.com>
Date: Wed, 5 Nov 2025 16:40:29 -0600
X-Gm-Features: AWmQ_blBi6SaJ6LdIS9vwxJQp5_1zspGepznYlOnd7E2qDS8FYULJpsyRNqnRec
Message-ID: <CAMCVhVP+LW27iLXttyFegRj_HMHheYrZtj4uuERLN0uqUjkR6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] Input: Create input notifier chain in input.c
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thanks for your feedback.

On Wed, Nov 5, 2025 at 3:55=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jonathan,
>
> On Thu, Oct 30, 2025 at 02:10:40PM +0000, Jonathan Denose wrote:
> > To expose input events to other kernel modules, add a blocking notifier
> > chain. Publish LID_SWITCH_OPEN/LID_SWITCH_CLOSE events through this
> > notifier chain when input_handle_event detects events signaling the lid
> > switch has opened or closed.
> >
> > Additionally, export a function which allows other kernel modules to
> > register notifier_block structs against this notifier chain.
> >
> > Signed-off-by: Jonathan Denose <jdenose@google.com>
> > ---
> >  drivers/input/input.c | 13 +++++++++++++
> >  include/linux/input.h |  7 +++++++
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > index a500e1e276c211d1146dbfea421a3402084007f8..b342b1ff138ccc58d4623ed=
cf1152bd85d7054bf 100644
> > --- a/drivers/input/input.c
> > +++ b/drivers/input/input.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/kstrtox.h>
> >  #include <linux/mutex.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/notifier.h>
> >  #include "input-compat.h"
> >  #include "input-core-private.h"
> >  #include "input-poller.h"
> > @@ -62,6 +63,8 @@ static const unsigned int input_max_code[EV_CNT] =3D =
{
> >       [EV_FF] =3D FF_MAX,
> >  };
> >
> > +static struct blocking_notifier_head input_notifier_head;
> > +
> >  static inline int is_event_supported(unsigned int code,
> >                                    unsigned long *bm, unsigned int max)
> >  {
> > @@ -367,10 +370,20 @@ void input_handle_event(struct input_dev *dev,
> >               if (type !=3D EV_SYN)
> >                       add_input_randomness(type, code, value);
> >
> > +             if (type =3D=3D EV_SW && code =3D=3D SW_LID && !value)
> > +                     blocking_notifier_call_chain(&input_notifier_head=
, value ?
> > +                             LID_SWITCH_CLOSE : LID_SWITCH_OPEN, dev);
>
> I would prefer not having this directly in the input core but rather
> have a lid handler that can then use notifier chain to forward the
> events further.

Ok, that makes sense to me. In that case, do you have a recommendation
for where the lid handler should go?

It looks like drivers/acpi/button.c initializes and handles the lid switch,=
 so
would it make sense for it to go there?

> Also, here you are running in atomic context, so you need atomic
> notifier, not blocking (or you need to involve a workqueue).

I'll use an atomic notifier in the next version.

> Thanks.
>
> --
> Dmitry
--=20
Jonathan

