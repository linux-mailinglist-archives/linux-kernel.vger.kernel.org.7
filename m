Return-Path: <linux-kernel+bounces-867588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368BC030B8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0563AE4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5659C28DB76;
	Thu, 23 Oct 2025 18:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="s0yNVa/e"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5B283FEE
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245044; cv=none; b=CtUyf0wUJg5Kt83KPx+8TmtkYYjFLJauQnLYN7wJDCeq9ZuYJs8jyfRDblvbBYqy0l0VsZaboRrSJdO5VxVZfcOCg/Wi2jx2kXtzcJZiVY41bID3jXClH9Dz5lqKGgyK77FSBsa0JwIVm81tlNjcSO03U8cw13cgu/dr93it0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245044; c=relaxed/simple;
	bh=PYp52JdL1zIXM3tFl6ymQmTmBEsgbvGo+/rL6L5cfGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LuKZx41SvJdprYgcWejQm14IVZiIBfbqqCArTfgU0cP+p3MZoCcQAVyejRmk5ow3IjWSdBm3lRFjVEsBCvzLo7INurSEcxO0VJlm3fD1zL4DOfsEbN6X78oxkR1LVOxvpNVZ6AE6t6y8l5s0ajZRcBCHJiPupnIWbzzXtNyzdS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=s0yNVa/e; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-58d29830058so1010073e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761245041; x=1761849841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FILWuJP7z4ne8yyln1112yG3l4Q4g1VKcs5bhTHsJnM=;
        b=s0yNVa/eJZhfoD3bMLT1xWtZBJPc1t8A/Zn2xYvJEgb/5MtqNO0u6wsuFrM8+isO8U
         a8RqaMEzvq4KU+ucS1pGmFbO1lJkh200XIxtI+uKBrtnG6LYvmZhKlbST26f1dgZKE1G
         dOKkExTkR8MKfeKYs7aXi148bX5ANT4YL2UKuU8MsQpC5zW3VrySCfAv6AqUxxr4U7+w
         YLQx0lhCkihrCpKURL10BMLreCwmNrK2c+SVDNma9CEgKoPeWpeXS4Dtfjcr7DRXw/5I
         R22ChlayhU94emhkIFIMNElmKGF4HJbaff2HtFXiz2ZXhy5tspL9shNNfuFjMpURLrzh
         TvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761245041; x=1761849841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FILWuJP7z4ne8yyln1112yG3l4Q4g1VKcs5bhTHsJnM=;
        b=SAsXKz1QaXUCC+DrdMtu2yVajTat0XBog6BeLwwUFiYSHYrcQkXjAd+AcWinyuy8LX
         1oKdVKyE0tgg8M6tFsKbx2xp6V/W3tUfKWAfALHmJ5GoT9/d7+YtFNC0HZXUy3ef/pKO
         cTMeJ9jxxgf+X94iP5HUNas8RvWHoC+ZjPQwg8PZ5mkEt4PTz5JAjmuv5JNT1SwQdpLt
         leSkbBaaQGRFBcO8X11cgSQEa8LaLrE8dka8S1TMGCkt6LlHeXWmUsr03/hFgoJAoKV1
         SW8uz7kWrq/mwdwlIe10u35QaVnCFqypHHPO5WTsul84f8lBudWgT5h40HeX0gFmFmX0
         +kxw==
X-Forwarded-Encrypted: i=1; AJvYcCVSMPIhTidMwLg17en8ah4fR7mg+mgiqIDWsZA6rf2XDvQpbqxzvyrRMHP/j3K67B8X0rCeUcNs68hex8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHq4M8vMdV2u7F96UymMKc6H3RkHHgqN0uIqCGD7fBZM6/mJZO
	FOAkGZMQBrfBnTQ/M2kU1cAZFzt0Dfg0IDkbOXuz808hF+KKePx1zIuGDteWGcvn1+ZyPegvVk1
	s3s2omRUAk1uUJv2S/gOvnueW/XqXPLoyeYQtDlZfwA==
X-Gm-Gg: ASbGncvETlY+9KpHbwwVaKUO2UsmxHXc4NQt43i0KI8iN6Dmnrf+dAj6sty7sv2tdN8
	e8Y5byxg5AGjZ5oSsrnDlt/nwvqR1oOpPqnyoqlVjATxtAb+UdA1Af+Mftm1E3V6HAkbQZF8o7y
	U1cklin5I6rHr4ogJEOpebE1DGBxe0HwwihboPms/dpY8Q3mooCEcQjpPagL37OFtKOxpNh5Deb
	AijRABP/b0pJefb1/gunyfNt7WBWlw/c2i9eraAdN1mIzFS4vpZCqGLP8BZ7oLOlqgx+mNiMV+7
	DiPHEpx300r3IGSgg7U89mRzLA==
X-Google-Smtp-Source: AGHT+IHraJus61bT3Hr2N07s+Ur3YCVMAET0C9pakpGhymtxfywdhGOWwy5gv3wy+GpPvNZ0Z7OpA/pQbI51BbDb264=
X-Received: by 2002:a05:6512:3b1e:b0:58a:fc55:883a with SMTP id
 2adb3069b0e04-591d84eb531mr9214189e87.4.1761245040819; Thu, 23 Oct 2025
 11:44:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
 <20251022-gpio-shared-v2-1-d34aa1fbdf06@linaro.org> <aPj3fCYj-NQdDSQT@smile.fi.intel.com>
 <CAMRc=MeSFKRo1rHq5ENzKqws+gOAX=-nCsGtw5MXvsOwJr=XpQ@mail.gmail.com> <aPkQi_Zn-17JKG0s@smile.fi.intel.com>
In-Reply-To: <aPkQi_Zn-17JKG0s@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 23 Oct 2025 20:43:47 +0200
X-Gm-Features: AS18NWCf9BHk3M78U-yTtMgDQhhnI1g2CI7k-KfJvPnPOvApY9tkkzNXTL8vud4
Message-ID: <CAMRc=Mdah6ve68h=d93VHXGij7KAQiGWuOGtzX_7VSPsCi=bbQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] string: provide strends()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 7:12=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Oct 22, 2025 at 05:36:33PM +0200, Bartosz Golaszewski wrote:
> > On Wed, Oct 22, 2025 at 5:25=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Wed, Oct 22, 2025 at 03:10:40PM +0200, Bartosz Golaszewski wrote:
>
> ...
>
> > > > +static void string_test_strends(struct kunit *test)
> > > > +{
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "bar"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foo-bar", "-bar"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foobar", "foobar"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("foobar", ""));
> > > > +     KUNIT_EXPECT_FALSE(test, strends("bar", "foobar"));
> > > > +     KUNIT_EXPECT_FALSE(test, strends("", "foo"));
> > > > +     KUNIT_EXPECT_FALSE(test, strends("foobar", "ba"));
> > > > +     KUNIT_EXPECT_TRUE(test, strends("", ""));
> > > > +}
> > >
> > > Have you checked the binary file? If you want this to be properly imp=
lemented,
> > > generate the suffix. (Actually making the function static inline make=
s my point
> > > really visible)
> >
> > Andy, this is bikeshedding. This is literally the least important
> > piece of this series. It doesn't matter for the big picture whether
> > this is inlined or not.
>
> It's definitely not a bikeshedding. I try to keep a bit consistency here =
and
> I don't see the point of bloating a kernel (binary as well) for the funct=
ion
> that just a couple of lines with simple basic calls.
>
> Also note that with inlined version strlen() for string literals will be
> calculated at _compile-time_! This is clear benefit.
>
> Really, library code is not as simple as dropping something to somewhere.=
..
>

Ok, whatever I'll make it static inline.

Bart

