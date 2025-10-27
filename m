Return-Path: <linux-kernel+bounces-871152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1743C0C875
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 734734F6C54
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08912F25FD;
	Mon, 27 Oct 2025 08:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3nkzana"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7732ED844
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555271; cv=none; b=BkMJGdce2nATZYczmiBcYLV67gjB2F8qZj2J6dXmdHIks12uTnirzx8EMII87rKqhk/BjeDtZVYeASCz8rJJBzayyv57XcAhlN/GQ8nY7I2irl8TRnidD24guL2+AqsG5koIGm1tMFHumQxM9gMXmAXo0o00vz+jgdgJ3ib2PTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555271; c=relaxed/simple;
	bh=FylS99QsA9gxDMDoBp+srgkQTQf25jWk722m3FG0juU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FVqUKexy5GSwgkPbOfz+lOtx3N0/wwhW3argEvhQegejJicKzI1jGIii1cVkGFSvzyGJodCj3ACN5OYrBChFYbjh9KyVGh16aBUll3igp3eNygLaPiNJnZiPQQM1QuorKQ3MnTNx2mA5UG3jEKTbT6EFSeRLnLAG/RxXNPAc6dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3nkzana; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso7107520a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555268; x=1762160068; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FylS99QsA9gxDMDoBp+srgkQTQf25jWk722m3FG0juU=;
        b=B3nkzanaTS+DCfJQQdTa9/I8Bw/9RQEZandVY4kuTqat0+LCgUjY8hJYQovj8rRxgK
         unfwJ9eu2+A3c9UTGMG4Hkm/NcaO57Lfm/6HREEUbRFZMYfDA7ujWLrKA1rlA1oa8RnZ
         VN8Ae2qIp16R43Z0H+k3FotvDr+qBOiYHbe6vnJkkTCteBtiHdAOAkG3vFdJ/9D5UCVs
         tPOigPLMWOJMwf0wbfA3a3AQSKlpxAhA5+xIpxFR3Ia/z8ntNjo3HnjS4SOovWOMvqD3
         JBIMaWd4gsJVnScBRAR6lAtkeDFESAnxSKwQ5dRSHhpeyqVI8d5QQc0ZykA21y8xZ1V3
         UyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555268; x=1762160068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FylS99QsA9gxDMDoBp+srgkQTQf25jWk722m3FG0juU=;
        b=a05z94P7wipMV0bR263v9zz42yGY1E+2eAiqA+Y26pZ0x1aOwqPXzaR2jDAPc5WieX
         1vsaKH3CmBZZA9QMeEofXiElRu6rQ6mmswl6OYp2cxK/5p7/l+wOEy7/29YJsqi53MrC
         FJlej82myGl2UUErPpeQ0DcAlPzp1jlJVrv+3nH3i0CmAHJ+R4SBJsq1W8NFXmlRwsiO
         7wOdtVtxARF2Ypm0IFgue3Sd/68j5wnq5Gq3/bmYN2k0LkepZfbc3Pn3RROgGs1+/PNI
         MIF8U1dOO2WIOqI++mXUSqU0CfwR36GF2KOCHVlimFLBm8/t54JvajHtqjqV0kweZln3
         ighQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3wJRcXyGK5G727RdvfUlzLGhI9IJ73YXIh2S+jPc1KwvJwLwU0y3EbTHEhH/AIiMIvrTTm6LDwt6EYgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc+Vi1LSIykfqzT9Y68M70kKZG2k8WzgtcOHp6PgxfbuXePeMS
	Gswa4VZku3uThcrERqrw98CtrO5wC+uCTV6azbuT3O3UaPvvnwT71FSh18BoWacvwWliz7ByZ6b
	NDWvE7XU9ABgtAtmTv1Whcojl4Tdq/FU=
X-Gm-Gg: ASbGncsp+IpRAO+4mmgJMC84IgT3u+yrPUL3hXRZBrKaF2DLdR+3bufWm5IrYMHByHc
	7UTwX7ay+rGLsS7Iu5Lvtuy5TVVpaQZnjyTjpwEG8jl+jb7sgTVNKEOBHoiWulucgjNhJ6fAg0C
	WEXeJuJC1/HPm5QzaDEDndG20OcZxff4+lrB4/7BwRkIOvu1z1UuCV59vIVNCnLZJ+BM0hNfmhx
	EbuCXUputq9MoAKW/1r4MCya/4Yo0yFtFmRevulNrYySNhfAUBDDPOXM5Z8osKg9UDICHzE
X-Google-Smtp-Source: AGHT+IEEwsR8ydlzzYHSrluue6vFNPLtag30nDyQMzqddTjn2d1HRqClZfBAQvsrpP8VYxX+CJLuItx4f2kKSyEP5D4=
X-Received: by 2002:a17:906:c14f:b0:b6d:604a:b89d with SMTP id
 a640c23a62f3a-b6d6ff25f30mr1222691966b.33.1761555267505; Mon, 27 Oct 2025
 01:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025102008.253566-1-kriish.sharma2006@gmail.com>
 <CAHp75Vc=LeYEowm4HOa4iPJSMQmu75ch-wbKT4WNOyWvYH3u9A@mail.gmail.com> <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com>
In-Reply-To: <CAL4kbRPy67Vkq1A_H_E=B99+M-09s7xWMYHCMPYFaCG0nMWWnA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 27 Oct 2025 10:53:50 +0200
X-Gm-Features: AWmQ_bkG2lho3tGefkbYnxp0Rg5zaX9UQwGIMCg14KvNjAU9MvWOzf6DdMthcZw
Message-ID: <CAHp75VcB9yLZq31zHa8wuE2DtxJ0j5hoco3q=F4WG8yDuTrtkg@mail.gmail.com>
Subject: Re: [PATCH] iio: document @chan parameter in iio_backend_oversampling_ratio_set
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 25, 2025 at 5:12=E2=80=AFPM Kriish Sharma
<kriish.sharma2006@gmail.com> wrote:
> On Sat, Oct 25, 2025 at 7:05=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > Is this the only issue with the kernel-doc? Can you run manually
> > scripts/kernel-doc against this file (with -Wall) and check, please?
> > The change itself is okay, FWIW,
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
>
> Thanks for the review!
> Looks like I missed another warning in the latest linux-next:
> Warning: drivers/iio/industrialio-backend.c:1069 No description found
> for return value of 'iio_backend_get_priv'
> I can send another patch to address this if you=E2=80=99d like.

You can combine in one patch, there are no strict objections for
fixing all (small) kernel-doc issues in one file at once.

--=20
With Best Regards,
Andy Shevchenko

