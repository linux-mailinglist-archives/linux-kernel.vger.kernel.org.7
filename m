Return-Path: <linux-kernel+bounces-811698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F30B52CB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFFD188156E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B63D32E88B2;
	Thu, 11 Sep 2025 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3OBXkpl0"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D952E7F05
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757581784; cv=none; b=awWTZdQDOGDS1yJBOI2NkdXDidWmq7QS3sH2RTyxPnIzRCwrzve9LLRhNo3upCrcFhX1DTY0S9j0+XWnXIKDF/2GGjQytx6+LV7wJT4es/tyIk61XqKGK/qqUCYYzAPimFszkoW526OQ/CuEE7qjAIG1oe+uu7XUUlbM9JjPlpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757581784; c=relaxed/simple;
	bh=JT1E/i13IvgijLvsZgi5MJnurKxqHwmoQNRgLsvfswI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FoG4eauqDqjR4/Ag2Ips6BwrOPPHHxJ0nR277r20NcmHMiIeme3ID0eDWcgJiEpbTLqSgQhG8viKyYfEeluK++VajuJywO/wSu9bY4twxsHWaoOd5RlLDKyqN4IvCKIArTIiWGI0BG0k3GKavcJJxRebzUoSGilAar1pt5I8M8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3OBXkpl0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45de54bfc36so62995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757581781; x=1758186581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxEShyOg4SZ+IMoKLAaBbydOFhFdrPhOe5T+ZRDMQXY=;
        b=3OBXkpl0Yb7tRn6h87HAOSWyw6rfT3MIV2tIulna6MX4Tjw3WBOaYiFBkC/w6UOmRu
         QnYl1Y7aCov1ocddp2jeNw93CNlAMNY5bmlFPzrBs1wBNt02p237WzAiXR3ZXNLOM1/J
         tuQbJMUQMBoJv/7+PU5pet0FHxmIi+iCH/eVNEQjft0+5/39Tgu8M9ojy5LHThaey4tX
         TW98rUrcxLHsbGwTIdJMno9tlwuHfXltXENnzzLTKtm30oBCimpLKhZH31Q5Y5Y8NyHm
         +m360rF5mfm7LiVDXVZjtBNeXdApecBQ1xOP3MesSRf35Rnv+pwMjcvCgVLFsKKAXaPQ
         d8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757581781; x=1758186581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxEShyOg4SZ+IMoKLAaBbydOFhFdrPhOe5T+ZRDMQXY=;
        b=wppAYC7QGeAD7VflDH9LIZ5/1YEBCOME0+4wqe6aX1v5YTaYf8TyxTIsjrAwfrKy0U
         pDp3jJCLwdteEE2U9JxMGyG7xpCmgEe0Fls7O3/Fw+FEZcyC1qM2Tuj1KsnrZEQfjsHE
         v47Kk2tA0p9XxbdQhcFW8IQiKyXL2QZJQqY5ZNeknC3MV5sW/c8gH7GvbHzk2CtMyawL
         bA51gRUK5opRGPMNBZgWxmAiDlba9vtQvSifJv7fEYOEevSUfBUYOrIQIf1Un3HBdbeD
         M7OVxcd8YwDn2ANgTvSVQ2mNsmekU7VD6ozygf+R0q60sfveYpYxhUSniDT1sXuxohkR
         VzKg==
X-Forwarded-Encrypted: i=1; AJvYcCUpI9Ur0HySb9GM0TrAkrZypIYga4cD9jZKgjbDIs1Rtn6t1lZoHqEnkZb/ckd+jpujaeEun87o07jEg80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpuYeW5TkVrqUZ0YZKnBSQUP7Od4U3XlABSGPJ1m31Nyb4MzI
	RwqtGcQ+li84xGsqxV8ulZ6lBGuRum3Wkz38l5sVliz4WU7rQIzy8jbCgiixlYgK2XRXYPEZOSZ
	hFs93T3W0oyju6O8FY9ESeWU13bIbHGcgVm+DlxgB
X-Gm-Gg: ASbGnct48nhQGVpj7dixu/E1O6XAEkuLuq3EITzPaTz/H7+MvzgWR8uEbETARIYAE4v
	dX2Uij3MFGmf3e8TT7zEHtQd43LgRF9wmKV2TMNbwCmujlFQhdhAs3JoQMccl08GIM6X5X222wr
	pTJSVg5nWK8Vnax75LX8hilGCQXhV4oeq3T1lQfb0FDbF9GYMI1QkdXFi2w2tUSlU9aFIMPLq/n
	LWF3OjMmZynXGm2fJnbAS7j2M/trtKjMBpoeZa6WH7Q/vDlbXo=
X-Google-Smtp-Source: AGHT+IG23s6lNfR+CIiGz37h46KPzj73nsB2N9PYmLBmAclhypIuYA90jnuGk8OXVbrv7pA6aVf7+DkgSS66RpI9vKg=
X-Received: by 2002:a05:600c:a105:b0:45b:9bcb:205 with SMTP id
 5b1f17b1804b1-45df820dde8mr2449225e9.5.1757581780459; Thu, 11 Sep 2025
 02:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904114854.1913155-1-khtsai@google.com> <2025090651-unifier-award-3e0a@gregkh>
 <CAKzKK0oi85bnyT3Lq_TXz8YwFrmBxQd8K1q7hRDv-Oww75F_tQ@mail.gmail.com>
 <2025091132-scenic-avalanche-7bec@gregkh> <d37497c1-904e-4a04-a300-a60a21bcc212@linaro.org>
In-Reply-To: <d37497c1-904e-4a04-a300-a60a21bcc212@linaro.org>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Thu, 11 Sep 2025 17:09:13 +0800
X-Gm-Features: AS18NWDiHIY9N4ZCiQdyx0zzB8O3b4PZd9Duf2w8OPrCyF3a8vCGUcWSwdxFcJ0
Message-ID: <CAKzKK0q5xRpR9hW=j-Hj6LNjogPK6jELRqB0Ob+VF6TbSve4bw@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix NPE in ncm_bind error path
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, zack.rusin@broadcom.com, 
	namcao@linutronix.de, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg, Krzysztof,

On Thu, Sep 11, 2025 at 4:49=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 11/09/2025 10:35, Greg KH wrote:
> > On Thu, Sep 11, 2025 at 02:50:15PM +0800, Kuen-Han Tsai wrote:
> >> Hi Greg,
> >>
> >> On Sat, Sep 6, 2025 at 8:15=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> >>>
> >>> On Thu, Sep 04, 2025 at 07:46:13PM +0800, Kuen-Han Tsai wrote:
> >>>> When an ncm_bind/unbind cycle occurs, the ncm->notify_req pointer is
> >>>> left pointing to a stale address. If a subsequent call to ncm_bind()
> >>>> fails to allocate the endpoints, the function jumps to the unified e=
rror
> >>>> label. The cleanup code sees the stale ncm->notify_req pointer and c=
alls
> >>>> usb_ep_free_request().
> >>>>
> >>>> This results in a NPE because it attempts to access the free_request
> >>>> function through the endpoint's operations table (ep->ops), which is
> >>>> NULL.
> >>>>
> >>>> Refactor the error path to use cascading goto labels, ensuring that
> >>>> resources are freed in reverse order of allocation. Besides, explici=
tly
> >>>> set pointers to NULL after freeing them.
> >>>
> >>> Why must the pointers be set to NULL?  What is checking and requiring
> >>> that?
> >>
> >> I set them to null as a standard safety measure to prevent potential
> >> use-after-free issues. I can remove it if you prefer.
> >
> > So either you have a use-after-free, or a NULL crash, either way it's
> > bad and the real bug should be fixed if this can happen.  If it can not
> > happen, then there is no need to set this to NULL.
>
>
> ... or there is a second (wrong) free somewhere else, which would crash
> and this NULL prevents it. In that case there is a real bug which,
> instead of being solved, is being hidden by this NULL assignment making
> it even more difficult to find and fix later. :(
>
> Usually that's the case I saw when people null-ify pointer after free.

I really appreciate you taking the time to explain this. I see your
point clearly now: my change could potentially mask the real bug
rather than fixing it.

I'll rework the patch to use the __free() helpers for automatic cleanup.

Regards,
Kuen-Han

