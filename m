Return-Path: <linux-kernel+bounces-894300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 980A4C49B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 00:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCAE188B0F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5544C2FF672;
	Mon, 10 Nov 2025 23:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IikgJAJY"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E991B0413
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762816262; cv=none; b=gRKXEW9cDYO/OjKTtuLjtxtRnhGQJ1LX+CuDTdV3bZOcX9fjvobh9m6cPPb/qRzMo6ZaAzExWEeCM8pO4Z9izLhr2SzhBsEz21NbrnqqyTN/Aj7nKzDhTbGE31g+myL1ahYTJJFcQ1Vg0oULkSFMIYs5GTpF27DYlMOKJkitzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762816262; c=relaxed/simple;
	bh=oy4PYXmHoEtc6GzRMLznOBsBdCS3C8+y7ilLIEcWVkc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHDyFwnDyRrTNsgK9STQ/6mHB7Fw1dL1Na+io2EIXlr3obj9eRNs7mQle0d90/jF4SjLaR2vuVmG5z4x9372n79rkMsXbkC7xZY3qblbeR0A6iV6qRubIpNHiXENt5bVKu2uDSs4SmWxoGPSxlNKSN+EBObVn2RisfCCPlu+Fss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IikgJAJY; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-559836d04f6so2269880e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762816260; x=1763421060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fe3hpRNA8+2yS1IV8mVqev+0HjRgVaWf6xg9qC+EZWY=;
        b=IikgJAJYO7ypEHKSOQQPU5bB6Wqg+NOJJ1px1OuYYpexLXY+TOFyOhuUoh4lDe+mHY
         gZEnzo8N1OFy+CNZ3o56j4KxD8/7ZmdL8CgrKFlrQQKOAZOLGsQur1AG8Kbpmdtt+1rb
         xAapAcu5NisXX2kqJGBThKt/2EBDfI0JE2gUYfSn11Kx41wycdCG6Texa264b1Oj8dNd
         d511ID1xfWJ4LYJsFt1jjp3Pl2jUMtrC4RklFe/ftbWvRpgD9EUjz7KBuFGD/BFBZ8fv
         rplH1gtEgWIHe2n2kXmscSMvGyIEdsK1p73sF53EDkUHAG9A8lyQ6Hsy5xIanivjZBmv
         mRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762816260; x=1763421060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fe3hpRNA8+2yS1IV8mVqev+0HjRgVaWf6xg9qC+EZWY=;
        b=wksjnuuUzbJsobpFssVc3N6zwDx3EsFSF6ptFnnB+Rv/wLfw9rWGs0XwjrnWO619iv
         EOEkAV69pBOjn+Ck/rbUmORrJjJGRYk2qzmn9HnJfK7g681dAQAjjbKKnHp4j0odGQPp
         eFzbg0kYoxczqfhDEg7ECI6UdthbVQXsTzd9NhClDOzU5x2ZtXi8oTdDofwDT3lcFMim
         WLY8A389PqVsMUuL/nYHpyxzJPxMbavMClZMxTjngmlb8tBpAiY9bCUwS9IJMVkHmY2l
         AdiNIst4cMePTbHDCI2JfXCxuAGh26VhR2eSUZSD7UddN9xDJHxahgeO0BDC0hMt+eg0
         WrMA==
X-Forwarded-Encrypted: i=1; AJvYcCXuKJ5fFdu10Z9sSqGOR+amhWfejEhaShZDE1aP/YUZpOrDtcfRpk0ZHICr1DvS7BBIVBu8FCu+adegM7U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Yt43tDxWmLt7JR20sYTyHdMZhJd+oKXwKXiiLWbE/2F+0gNM
	pu+fwXqYYSy8PgF21v2bajmcTJhbW2b+1NeZHEfmaO0l3+NRAyA1SQp9ruvDS0/b1e8ZrIMSyle
	dX4IHsR278uPN1oK/M1HRzHorQeCdUnRdbR75JefS
X-Gm-Gg: ASbGncttQxnvuKkbEb9kxxybxKXJ2wA0yikq80kFUoPGM2N0JsYj/5cxj0B3cOGzggB
	AKmlkaehYAIBI787g+kY23aVqO/Eh2txQOgM7FUgO4CUQYFBfHRC2FzQWVhGT5UfkI7+A/36Gaw
	TXTTJQRHMJ/zlbeAXxLBhi86xVLZ1lE1oiIp1RU8lXb4AcV3Si/ZXo0pB2PlKJNlPdxzDtOd+re
	HMXC6wG6Fcj449p6apXZm3K5zReWBsGz1vtlkO9Dv70q7jgsnhc5wky+/6Ea82c1GUWtpg=
X-Google-Smtp-Source: AGHT+IG10pMqFikx6RT/tqFrSskWIl05KHs+Ee/7So6I7n//cYDrDuZ+0tQc4Cge9MmUfj2dpGGMRK/SP0GpB1MqStk=
X-Received: by 2002:a05:6102:6c9:b0:5dd:87d8:b4d0 with SMTP id
 ada2fe7eead31-5ddc47cb960mr3853994137.36.1762816260026; Mon, 10 Nov 2025
 15:11:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107222058.2009244-1-dmatlack@google.com> <aQ6MFM1NX8WsDIdX@devgpu015.cco6.facebook.com>
 <aQ+l5IRtFaE24v0g@devgpu015.cco6.facebook.com> <20251108143710.318702ec.alex@shazbot.org>
 <aQ/sShi4MWr6+f5l@devgpu015.cco6.facebook.com> <20251110081709.53b70993.alex@shazbot.org>
 <aRIXboz5X4KKq/8R@devgpu015.cco6.facebook.com> <aRIoKJk0uwLD-yGr@google.com>
 <20251110113757.22b320b8.alex@shazbot.org> <CALzav=d2w1Q4_P2AjfM0aantjtdKW_1jRUMprRQiC2SCk77ewg@mail.gmail.com>
In-Reply-To: <CALzav=d2w1Q4_P2AjfM0aantjtdKW_1jRUMprRQiC2SCk77ewg@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 10 Nov 2025 15:10:29 -0800
X-Gm-Features: AWmQ_bmDZciMUKGHoSS8OLtj-UmPvjMnOPIRPcTeX7KbdqztKskzw8EnCLWnFe0
Message-ID: <CALzav=djghffsrexibhTK5AGsNe=QmHNfm-64NSP0OAGE+K6MQ@mail.gmail.com>
Subject: Re: [PATCH] vfio: selftests: Skip vfio_dma_map_limit_test if mapping
 returns -EINVAL
To: Alex Williamson <alex@shazbot.org>
Cc: Alex Mastro <amastro@fb.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 11:45=E2=80=AFAM David Matlack <dmatlack@google.com=
> wrote:
>
> On Mon, Nov 10, 2025 at 10:38=E2=80=AFAM Alex Williamson <alex@shazbot.or=
g> wrote:
> >
> > On Mon, 10 Nov 2025 18:00:08 +0000
> > David Matlack <dmatlack@google.com> wrote:
> > > AlexW, how much time do we have to get AlexM's series ready? I am fin=
e
> > > with doing (3), then (2), and dropping (1) if there's enough time.
> >
> > I'll certainly agree that it'd be a much better precedent if the self
> > test were initially working, but also we should not increase the scope
> > beyond what we need to make it work for v6.18.  If we can get that done
> > in the next day or two, add it to linux-next mid-week, and get Linus to
> > pull for rc6, I think that'd be reasonable.  Thanks,
>
> Ack. I'll send a small series with this patch plus a patch to replace
> iova=3Dvaddr with iova=3D4G, and we can use that as a back-up plan if
> AlexM's iova allocator isn't ready in time for 6.18.

I think we have a good chance to get the allocator series ready in
time for 6.18 (AlexM is quick :), so I'll hold off on sending a v2 of
my short term fixes.

