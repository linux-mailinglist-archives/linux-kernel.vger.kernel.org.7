Return-Path: <linux-kernel+bounces-863171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9B2BF72BA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DBDA19C278A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3CB33FE38;
	Tue, 21 Oct 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="S2q5QIMA"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340CF33FE20
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058159; cv=none; b=A1ncfxVqwpv1MGTbRZSwtek0jz8QK1rkUkIxnIfU60tgrz2P5bB/hx565DR+tfL2Ds6uR8w2PYfhRXTFD5CtbNHYwsY76jK0y7nYvNlB5YrFHxHuYk8uMBTwD8fpomJ6kIC/5xhZkxUeg5PkubVag2VpZJHflZjSLRC2+315inI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058159; c=relaxed/simple;
	bh=W2POVoQrYUSZPm1A3yimS9utpyJqHWo6t34zYlrDD9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwbWc8MJV1elMe4TOtnR67xnu5DXSRq2sqq7/iHzL2FeIbPhJ82qbCIZxQg2a/WKLz8xzjPKmyn4TKgHCNDyqUkw/IR77+n4j2k/sgMGZhf3bFCkgiuoC5JsmrJVD9NMQytycocOKC+2HBeraBRxIsh4Qk/7Uw8M7C+Opvnc2Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=S2q5QIMA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso6502415e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761058156; x=1761662956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2POVoQrYUSZPm1A3yimS9utpyJqHWo6t34zYlrDD9M=;
        b=S2q5QIMACELbpbw3BFkBp/ESgGRjNmUqDzIVGS32uUicB+JK9ljXMfHmxs+McXOoCU
         0UP1wC+Is2yy1abPxZmVo7zj5ySOcXaNSgMmJgXyomXLBECmjzEWKM5oPAwdzYi9fta2
         NwL0jk28BbuRXNHI52s2+e0kxLs9WSvOicja4pvzkMKDYEHpqUlvjmP/j/Tp5bdwoVqp
         gvUnH8GkCdkNEzuiaeeaj2CqJXHcNKz/V/g44BCf3+M7EYaYPCo/2lIiRDVtiXb61krj
         4tpMmCZJ88R0GUYlGvuJvRScYHB2M7o+cZfnHyyrORHe1xjmnC6ZVXnSTAdubGslsgqQ
         8ekg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761058156; x=1761662956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2POVoQrYUSZPm1A3yimS9utpyJqHWo6t34zYlrDD9M=;
        b=H4rO01E3zyagnJaoLTId4iKLs2UC97z57ogfHvf8LAxOEVuOroVvd1+uVL2lCcyduW
         AsIbZ/ZEHuSXZBPCrmvNZbOoTLpPEg3kK3yxnH/1ahwxTjJeWWxB+AS4trc8oNQoRlPQ
         Fki2k+lbCDfFW1NvQ247GlVKpi5MXFSv2PrUfndBKgoYK/+xwh/bzxRIzk4mAD0t8mV3
         nPnBCfQlsxxvV/xyTIY2QfHGquzHE07gO9luyftfdhfjGf3mJTrWU3xQvtbwY4Sf08Lf
         ueI03Urbx1eBUuNyC0WGu6wjKUZ6xQgCPkTivCAOWY931H04bzlsDMCCkM7ic3CA4OCj
         gp/A==
X-Forwarded-Encrypted: i=1; AJvYcCW4jWCwzajRIsOShrcL8KF/dUcauEvMS5K7hx7JPBt9JQrSgwatV4oFszzgI41u/OcXhOs9jVjtP8Ebn5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Uff42s3T9RAsfpGsnnxaZHbNaJHmVma1BIrF50OzkWcT2tyN
	m2Rfm4t4k76FDGFus0xTPidAPMXgee1qcDtu2NaL5mrWdlVnwLcxYeYsbgXAZttLsvsnCsUirxI
	8vLlLi8T/FcuZrs4VEYHSzeXh0rGtzR9I+HGA60oAHHxRm88r23SKpg0=
X-Gm-Gg: ASbGncuumFYJ1rjbUDMgjeMEOJxE7AbEHqM9qZIAk/Q99wjijjbASq1AB9eLHh4MbFH
	6GhHWK2JbhdSv+WvlWDOPtazMC2qWw3YFLJKHlGk7RJHLwhmoMXYw9ajwkGw4ZhwGTaoAts6BF2
	cnmKPJrxEDwou/v8rgseYhedkMl3wdZgCFRN/9XemTPkkojweXloC7Rvj6IPjlKLoJGq9AFZ1OL
	xDI/IP/V2zrKhq3giYfPjsuc+AGdQQkNsOWbyFkSdDjdck8nhUQMaqRYeoND6dhz6NdijcPwTAV
	tHtfM6YyYzPf0rMO2qBTvFRgn68=
X-Google-Smtp-Source: AGHT+IHHKA/c0dnWyRU1/iLjLRkY7tyq+bIgrghSWb7MxAig1bIW1157IfXsr8EXnJ7WeHo/HrV20fw8YRwsJS23Kmk=
X-Received: by 2002:a05:6512:3ca6:b0:572:1f0b:5ef3 with SMTP id
 2adb3069b0e04-591d84e398dmr4722237e87.11.1761058156385; Tue, 21 Oct 2025
 07:49:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-fix-gpio-idio-16-regmap-v2-0-ebeb50e93c33@kernel.org>
 <20251020-fix-gpio-idio-16-regmap-v2-3-ebeb50e93c33@kernel.org>
 <CAMRc=MeFZTDk4cgzEJNnkrJOEneFUBLwtKjkpV3-cLSm=xsxNg@mail.gmail.com> <aPebhGETy_3MIwkf@smile.fi.intel.com>
In-Reply-To: <aPebhGETy_3MIwkf@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 21 Oct 2025 16:49:05 +0200
X-Gm-Features: AS18NWBSKJhK7qYwfMnb3aaDS0lyPca9mQ0P-5mXERBibCAphYq6tUO01p7bilc
Message-ID: <CAMRc=McPP6obWpnd7Y7duJDC=NLAOE7bjFN-iytDJ524nDr9mA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gpio: idio-16: Define fixed direction of the GPIO lines
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: William Breathitt Gray <wbg@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Michael Walle <mwalle@kernel.org>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 4:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 21, 2025 at 09:21:38AM -0400, Bartosz Golaszewski wrote:
> > On Mon, 20 Oct 2025 10:51:46 +0200, William Breathitt Gray
> > <wbg@kernel.org> said:
>
> ...
>
> > > Cc: stable@vger.kernel.org # ae495810cffe: gpio: regmap: add the .fix=
ed_direction_output configuration parameter
>
> > Turns out, this requires commit ae495810cffe ("gpio: regmap: add the
> > .fixed_direction_output configuration parameter") so I cannot queue it =
for
> > v6.18. What do you want me to do? Send the first two ones upstream and =
apply
> > this for v6.19?
>
> Why can't this be pulled from some IB/IT as part of the fix?
>

These kinds of things should be signalled before applying the patches
that should go to an immutable branch. I would now have to rebase the
my for-next branch. Also: the commit in question brings in a new
feature, not a fix.

Bartosz

