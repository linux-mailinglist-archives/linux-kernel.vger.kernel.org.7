Return-Path: <linux-kernel+bounces-817878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60AB587FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F83C7A257D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 23:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855A82C0F64;
	Mon, 15 Sep 2025 23:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgEfHtQt"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CFC18DF9D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 23:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757977461; cv=none; b=LDceW0dQetnwRSglFK9piq4Ljnb/WGmUswwF4HP1DTOIfmuJlne1Q6V8IKTM8bBwGh6ltQIxNfo7RrHGpAduV3Vpac19CHE0U7H0Yd0uCZISxZUJpnQm1IQ4D7SRMXo9x0+niInLwNvU6etYLFCIPmXhUyAoClnxkFscHVFeVzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757977461; c=relaxed/simple;
	bh=pAkzeID34wI8ncFL7Ly+so1dhJ7exgAX7JeYh3yEaCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldiRd3CTUSqVDFNKiG+ef/eHVkdfGPHxouojfITFRzWQc9KQR7C8S8aSUDoTm6OHgeOo6s8dPFBFGDCsWMqNzA/5ZV4E1utcchl1fTEGNy6JBbX9lzA5CsinXB7Mxtz4IgUVMJ7Hkk088lxzbjKR0U6XUD9TlhCcp8q5vSfwHyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgEfHtQt; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4b78657a35aso49491cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757977458; x=1758582258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p4xhFRKYQhwXJkuDc/EEUioctulqeJUCai7qoY8dBkE=;
        b=sgEfHtQto8Of/wm8bzyo7oj7BUv91g7foquOsVEABzO0LZsnMW0HWkbm+mLL+QekoT
         EC3AU+a1NCqJXdYdL/i5vMPfeNHzsHeQsGx9DNTn+qfbLV/h2us6QlLGCd7KVth3Z3gc
         CT0sd3ljFkq2Tt7akRSjQtYF1xLYX+jnRJgUtEozRC6iyIts5lq6Ma2PT7ryDjf4+OIm
         4q+nJZwXYxb7D/Lm3EbJBLcQt8qIrBX7WsiZHK8rA01QrGn2DmX4FFeHWd5XKqhQmZEV
         YVRIzuup9oIZncDhGHPxOo6IErCyGKSwe6OOd6RJ9t79ZB8+5C2uYB6lWNZHLVN4uFFq
         8xaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757977458; x=1758582258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p4xhFRKYQhwXJkuDc/EEUioctulqeJUCai7qoY8dBkE=;
        b=qcghyiqI8yN4iUdgU8bLD5WhdiIyH25PCHGPM8ozy6OuMzeU40nANmD98SWwPUMlOJ
         jEIRDUDS5yShvLOCZAg0KGmFSISF12P3LBwj/bQjOoheOt3MB9aY1NY4PTNofF7Z/bUZ
         uelKAfqGlt8QkZhBBLu2fysYImSe37Q6f1drFGugJc9Ye1ElnKCpEMv9WLp9JFaboVK4
         LH1rcR25U+I8l4xvyYezu9Oucil8M/4/y0KBWd7Qf5zb60wy5ydxkt0w4kaVh3vRQtm1
         IZQs7csrl7N+yASm3d4IBAyoQOdzmYDYSdDz+YJ8ZrCqVO+IeqBvX95jKQST9AOdBiMn
         dFJA==
X-Forwarded-Encrypted: i=1; AJvYcCU4a6DaVAL7pW5l6gfUJca2HrHjp4okDjhXWL/CNi5hZObXF1nWMumJIorlAbQrCaCcka+Mp5cayogmUjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwmLe41GwHv1V5wnhKjRXvwgmwZx8OIdIJUIuflzBiH9AgYiR
	5wcqiIfJnClG0sO6LzLH7229unBlS4XlMdlheLoUgaTorAmszMhcKGkNbkBOtY+M9ABq9onypo6
	uZ/BgWCq3/bU7jjkEPD45Zl15EzrwjbgRASlHnAej
X-Gm-Gg: ASbGncviNZdkQE7M+UTAJ4N/oUpfNWoNKJSwHEsXqdu+FUI/ZjAfmMnSSCAkyupFk1p
	Fho08TB0QHKAIWuFbwSJFlEdFu408Gev08LncTi/h6vidsEq+AkFWrdKD12alu8Uzu0F3m9WKcq
	ztZPXH4V1tYc7uCCir10PQUSFanjvCjXzAyKhQmDVfrYiaZdim6yTHSXShlomP9OsWAKPvgXeKP
	F1VUyQefzAkzeyUIZTCLeK0ICR70bOAq/lDEoSnZllW
X-Google-Smtp-Source: AGHT+IFHHkGyyY8CB0ND1VTmYtN2gUUS8oMVbxVprvwqGNNzj2Kgq8bXC60x7DfHID1D8kjmNG6duvd5/ZOeDEgLVlE=
X-Received: by 2002:ac8:7c56:0:b0:4b3:1617:e617 with SMTP id
 d75a77b69052e-4b7b2d81b34mr1194421cf.11.1757977457970; Mon, 15 Sep 2025
 16:04:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909234942.1104356-1-surenb@google.com> <20cafc1c.a658.199394de44e.Coremail.00107082@163.com>
 <aMLvCCZbmpSE/aql@devbig569.cln6.facebook.com> <902f5f32-2f03-4230-aab0-a886fd8e4793@gmail.com>
 <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
In-Reply-To: <20250911143132.ca88948c48df874f71983218@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 15 Sep 2025 16:04:06 -0700
X-Gm-Features: AS18NWBsZ6p05tPWyvjbKjMLvzq3s3vldcjpufEELtGglP0Q6Ltxk0Uz6ecdD3E
Message-ID: <CAJuCfpF7NaUJk7fwPQ7-V6DPaTo4eqL-5Xxs7iO0nzNDS9N7nQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] alloc_tag: mark inaccurate allocation counters in
 /proc/allocinfo output
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>, Yueyang Pan <pyyjason@gmail.com>, 
	David Wang <00107082@163.com>, kent.overstreet@linux.dev, vbabka@suse.cz, 
	hannes@cmpxchg.org, rientjes@google.com, roman.gushchin@linux.dev, 
	harry.yoo@oracle.com, shakeel.butt@linux.dev, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 2:31=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 11 Sep 2025 12:00:23 -0400 Usama Arif <usamaarif642@gmail.com> wr=
ote:
>
> > > I think simply adding * to the end of function name or filename is su=
fficient
> > > as they are already str.
> > >
> >
> > Instead of:
> >
> > 49152*      48* arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_cre=
ate
> >
> > Could we do something like:
> >
> > 49152      48 arch/x86/kernel/cpu/mce/core.c:2709 func:mce_device_creat=
e(inaccurate)
>
> Can we add another row, saying "the previous row was inaccurate"?  I
> guess that would break parsers also.
>
>
>
> I don't know if this was by design, but the present format does provide
> extensibility.  It is basically
>
>         NNNN NNN name:value name:value
>
> one could arguably append a third name:value and hope that authors of
> existing parsers figured this out.
>
>
> Whatev.  I'll drop this version from mm.git.

v2 is posted at:
https://lore.kernel.org/all/20250915230224.4115531-1-surenb@google.com/
Thanks!

