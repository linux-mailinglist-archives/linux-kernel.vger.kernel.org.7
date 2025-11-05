Return-Path: <linux-kernel+bounces-887436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC86C383A7
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F8D3B8F49
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D9F2F28FB;
	Wed,  5 Nov 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B4zLD8SS"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D8280024
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382694; cv=none; b=Gd1hNjgkBlb1CVXACGYb3cB2k9D2k8p/8Rlntg14F3zKTZ695dPofYhYaf4R6HLU0vpFa8jU9OFz7NxGUrOl+U7oIUTs6Fo8zil1JaZ8nHn29pcgUUuk67N6mbzzoEEw6R2Eh4eLn4u/8yFJaYAkmfmP/X4gH6H9uoykBKJMwRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382694; c=relaxed/simple;
	bh=Rfcd32YdQrSKTTIJhfyQ2q3eg0O2ceic4Me1fRNtgcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLymf/iq6iS0r8cYjz85SiEiza3fvNs65bxhu3daJ2H8+uKyCN1Co3fKUE7XMUhhObtK+543slqLI8XwAA8uWnh5rBBo7LKji7KaKb+XGnSe5BIfppcLz1aFCreF6x21cPN5W91vq0WStBRxIZ30OGA+Fo3vsnZupqyfAKotwnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B4zLD8SS; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-587bdad8919so3334e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762382690; x=1762987490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgIOheg/lLalcENSGd1F4iLfzJbxxpBaQERuk+3AcBE=;
        b=B4zLD8SS5Rm5amdzt/juFBvG8AnGemurx1bS2ROumoKw8D2k5vyPLN75/gp5/wwmMd
         60UmdLdv2XG5CBkqap7BeOnNp5ymrvvrpMK4uhzwNEyeBgbXW1XeD/jjDwFqxAROXIZB
         2t9D5iLOPplrRU5JYPPayILuszAOPmnbPswS2aINNlWiC7GCR0fwOC7DtAp4wUOl+BfL
         S4QmtiMxBea+U+qH3UEsSAZcF7i7Ghf0GsSSoJunSZk//J4Mz7c8futC7xhF38lUC527
         GVJ1ObwrlTOoSjP3ATYJsggo8tLGyGfAj/6DbAIblOvLd/7Hmgfc8MMi4sGS57hWvtO8
         hq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382690; x=1762987490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BgIOheg/lLalcENSGd1F4iLfzJbxxpBaQERuk+3AcBE=;
        b=lu0PoMiLu8jlIAIbHjLADBv9P3IadZCvQLTeat/O3giEyfUhbAQ59oiUlJAQHimoAj
         fJGgJl/pG0jVTUKR6GcVvZN+9Y0UYKMyRl+fbiUD6wyWQwjgrZrZMwLUta20FZOHBWf1
         Qb43hpxvE1r3eGOapoPUhF+OiDNd8V9ifwVnt4lDE+fOF+oqVGzYIng8JS94RdVx9YHV
         Z/gqeuzOO5ehhXVYuqEwh5v2z+LWdE69q8E6p4rF8zyMVJMIRhqyiImqr2jGdWIvWoVn
         rpE9nJkCqWjj7UK1PpNvmrMALUmPFtKMfeEckSUq+u4g/5xSxBp0ey25yzA8L1ajLvep
         3RRg==
X-Forwarded-Encrypted: i=1; AJvYcCXFcFircRo3quc0C0+tr4Tb8KgrNbUWxlNJm++7ZucCqAzhbC5oKCwozwSdEor1J+5JMZQCk+dnamlBfjc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tjJMjbwTjlI20BugzDFzmrvKQqXwT7naI1mQwSb9F/VVxt08
	LvL6rarsZm21D3LLYve3BhQ1FDvQXY6FAP3VTkaZtpCobZvGvAecAljC/BvfpH47bzk0AbMC/TN
	2d++ljVMNsy0P/rXeIWd6YF68aFyLejV5vqIzABGk
X-Gm-Gg: ASbGncuK7Rup810dvPjzpPJhJgVHQkSYT6GBsMHbBaPdHw/CtqcFoD3nzZPhzMCHErx
	ae3+VfrGtEbn8bBQlySyg2/D/PXLCV6R8Z4VvQThTpPHh4XwQILp5rKITOp7Zq5gbbJXsXTpQTj
	ODXVdfumsV60nhNaWm7lQQ1OeXztD/S8mEUO1ufOfHtYMOXe3a3eYN0tPMfNTSh2F/MPRcmS3Bk
	qtiEx1y3xAlTgvUHpfOukTlE1dLc1CWT4DpK+iogiZiTf/Z7b4HiYLYll/LiYPPpI0qbxEyoY/U
	GDf2IlKZgWd4iEF8FGzK+i6BKw==
X-Google-Smtp-Source: AGHT+IEwNDS7oXmRblTAtZDOw4CbfUPumRYiH6vlEKG5nMLy9B3pflCGWRq0205gorfW+S/l+mmsLnn9/oI8vbZ/kWw=
X-Received: by 2002:a05:6512:78a:b0:594:33e9:a7fa with SMTP id
 2adb3069b0e04-5944c837b2cmr37142e87.7.1762382690195; Wed, 05 Nov 2025
 14:44:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105200801.178381-1-almasrymina@google.com>
 <20251105200801.178381-2-almasrymina@google.com> <fa6ace55-fb4a-4275-bcd0-c733a788d2b9@kernel.org>
In-Reply-To: <fa6ace55-fb4a-4275-bcd0-c733a788d2b9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 5 Nov 2025 14:44:37 -0800
X-Gm-Features: AWmQ_bnGBOuR1d1ffOXzQatkX0qufbklhADtkuZMiEvw53WQAzxhm25wVfneE90
Message-ID: <CAHS8izP3phG1FzAztGM-6P4gXopBGdNEXGODuvPasU+DH+7reQ@mail.gmail.com>
Subject: Re: [PATCH net v1 2/2] gve: use max allowed ring size for ZC page_pools
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, ziweixiao@google.com, 
	Vedant Mathur <vedantmathur@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 1:58=E2=80=AFPM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 05/11/2025 21.07, Mina Almasry wrote:
> > diff --git a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c b/dr=
ivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > index 0e2b703c673a..f63ffdd3b3ba 100644
> > --- a/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_buffer_mgmt_dqo.c
> > @@ -8,6 +8,8 @@
> >   #include "gve.h"
> >   #include "gve_utils.h"
> >
> > +#include "net/netdev_queues.h"
> > +
>
> Shouldn't this be with "<net/netdev_queues.h>" ?
>

Yes, will do.

> And why include this and not net/page_pool/types.h that you just
> modified in previous patch?
>

netdev_queues.h is actually for netif_rxq_has_unreadable_mp. I did
indeed forget to explicitly include net/page_pool/types.h for the
PAGE_POOL_MAX_RING_SIZE. Will also do in v2.

--=20
Thanks,
Mina

