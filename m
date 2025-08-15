Return-Path: <linux-kernel+bounces-771034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 163E0B281EE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACACBA2853
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5D22F383;
	Fri, 15 Aug 2025 14:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="jgjuMlIo"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370242248BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268356; cv=none; b=SkTxsGZOleBGKVtDP+iMT4QT5xlIKWDw1xDMJBiAEe7wWVQ1ORxyns2nXeHERDA9lSpj8+ux5ptN3m2JWZ8g0FXlPzA1MiOd788E2PA3OKYJHHlgawXOhAK0yYJlvVVdW6hC0elUZkpkCpumQ6Gtp6V2Q5GKYUKIP06q9lAGihI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268356; c=relaxed/simple;
	bh=O0MP8KZwZzoCuMItUb5xHUP4lzs/O8K3Xj0FuWpVb3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgOum94fJJFNuDc2wbtD1w/wxqZ3Niq5HHafedReC+f7bV9m2Iw/iZqv0ejuujNLgMQayob2PG2q5D+Xzl6qeeoSroToiBnp+nzYWC0hrjIQ2WYXV7/KlySEj12CH/uyb1uuufk2xJbb6fNOyAIK6CaiSpdFcqgZFThTSMxKI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=jgjuMlIo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so10420235e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755268352; x=1755873152; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8FXQf+9ghxPzhtvwrtvyY02+a0FGz0lPsLgvTccoTfc=;
        b=jgjuMlIopCNE4eHRfW5bWZ7IzKi5/8hjWx5REXm/5ha20PNbMxLwutj9GkW2phl9bT
         Wg+0pKnEcWq2qoouyGbQ75RJEZZiv1M5oDdZrDd7Jl/oPFin+P/rQquvt1131w1z8nDK
         Vkp5Cn+gcGFsoiNZHRMkSo3nGSAj+ZS3RZBELtTOVOeGNmzUk5CcKIeoUUF7emvJiSsI
         2sk6suB+wX5IQpXFKJADYbvl5Cut03v3soLiNO7/qCI8SeZHYhMP+WAuz3cVdXdKcXhp
         Cp8E4yoIDXGJDQz0uiaRqFwSnJ2yPENUInFEzOp7Qw5Xm+9rNy8ctOXu0KxASRpMXIo/
         kOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268352; x=1755873152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FXQf+9ghxPzhtvwrtvyY02+a0FGz0lPsLgvTccoTfc=;
        b=lXcianniYlPIRuyHIlyCPoc5uZtcWEUeUzMK2eMed1mGfTMHACd3ZLRWTHHHQgEgKz
         RCj5x6+JYEjoP6WMI/gwofBFsllzwFtPG7krjjISJmxfXBefLXNSZ3R79HNaVqh2Snwx
         A5esRCZBeZs0PpT9BZnecg8KZ46cVfqfQIbasqhV+LmzGRW/Oa5696SfbGHzloo7sPFM
         hz/x6loqxF4PZ1tNhdVqubeD4sE28h48XLeVgPB13TYB96tpgP+o//gIGfkmA1YDHsz9
         GTPoGve89n+Oc+sSuwcdiXY1smGNbbiLWx1eCPNB8hLv/8/Xj3p9kwyGXPFwPoLGo7o2
         7gtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7g/kJyvBFiqDSc/oTAxraSUF2xOGlTBkJvLsGjb0EhtpYOSX/D3l6M+tjSApdSmcRLL9F9sW46NwM1lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVGtFwzJQ/z1FvovTgAcOc/gS0S1K1b+Wrozj5F8lPPzF9LODM
	H8vGiGSvpqHWkkUYl/BT2joBpftEpSScRGKByfT2XhNtBaGsfqIay5kR50wYVfPQ7K0=
X-Gm-Gg: ASbGncsedxLIEQCo3c1m3lfMm85B0hi9TwDMIEGluQqR7xUsnjht7c1xc38sWaZ5+GL
	ATda6HqgdU1RDlDU/C4pRnyoWOMKaEtTnkCANK+3j9/Ylhr10AkBDZRYi6I7GHe4wLJNL5Scbto
	Rs0JSzJbYIaX6GTgJ4uuwcpT8AKR/5i+wc7Fp9TJWVpJzvDTVKHN5D5C07rINje80oRT/sKE1rz
	9UZyTnmQzcxhSS7TT52DXuvSUZfYLX1Psvs2iuc1DlRyJucqC71pqR5xKCCcdtCGmg+3VMDJZ5C
	y7jlSPZ12h/L5HUxRfKzQRp3e3Oaj143/DJBRl05n1MvMdjlHsORh3+1CpBY9GnUWqoN2/vpTJq
	3tMJqS1LwLaSjDgeqqe3ufgJ+szZWgy9QJ7NQQD2KkNdoz+XGUvq78ze/6vWceoiWh3cbk4kPim
	Ay+wVHQA==
X-Google-Smtp-Source: AGHT+IHnSLhDMqXcwx68Y9138TqJ+c1Cuo3gefZ8a2Oj1eAADjXvGhxdolw2Wdfb2t12ox2676R9IQ==
X-Received: by 2002:a05:600c:45c9:b0:459:dde3:1a27 with SMTP id 5b1f17b1804b1-45a2182f2d2mr19947185e9.26.1755268352274;
        Fri, 15 Aug 2025 07:32:32 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74ad27sm64461825e9.18.2025.08.15.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:32:31 -0700 (PDT)
Date: Fri, 15 Aug 2025 15:32:29 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Doug Anderson <dianders@chromium.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: Replace deprecated strcpy() with memmove() in
 vkdb_printf()
Message-ID: <aJ9E_W4Z0n7EzjUw@aspen.lan>
References: <20250812132621.119641-3-thorsten.blum@linux.dev>
 <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=VnvUUG7qE_RDKfos1H-baZUT8V5vKx2QNRX14OZ0QnwA@mail.gmail.com>

On Tue, Aug 12, 2025 at 09:24:55AM -0700, Doug Anderson wrote:
> Hi,
>
> On Tue, Aug 12, 2025 at 6:27 AM Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > strcpy() is deprecated and its behavior is undefined when the source and
> > destination buffers overlap. Use memmove() instead to avoid any
> > undefined behavior.
> >
> > Adjust comments for clarity.
> >
> > Link: https://github.com/KSPP/linux/issues/88
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> > Changes in v2:
> > - Use memmove() because of strcpy()'s undefined behavior with
> >   overlapping buffers as suggested by Doug Anderson
> > - Compile-tested only
> > - Link to v1: https://lore.kernel.org/lkml/20250811170351.68985-1-thorsten.blum@linux.dev/
> > ---
> >  kernel/debug/kdb/kdb_io.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
>
> Much nicer, thank you!
>
> Given that the old code was officially relying on undefined behavior
> of strcpy() before, I'd personally even add:
>
> Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
>
> In any case:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

LGTM... and I agree that this is bug rather than a clean up so am
waiting to hear back on the Fixes: .


Daniel


PS Feel free to roll all three kdb patches discussed recently into a
   series so I can pull in one go ;-) .

