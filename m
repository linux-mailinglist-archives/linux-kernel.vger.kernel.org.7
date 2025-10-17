Return-Path: <linux-kernel+bounces-858268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC29CBE974B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8845D35CA91
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3433506A;
	Fri, 17 Oct 2025 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwJzMIJV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742E2F12D2
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713395; cv=none; b=GS3eLITvIPHMZbBAg05YRRZRvbTKkqj3ZlJAtcyw4l66NLGl0V3VOK5CUhjDWlpvg6GiRnPGnTfTUlYAY9t3flCrF/kkM9FbjIK2KYcOSkc6G57+sdMVmaGijH8lde4XzvjNrgR4VTASFwyTttcZMyAhMq/lNH/DnA+7lgAqhUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713395; c=relaxed/simple;
	bh=DepML/g+us2sXe9XTL0BD4vVQGz+k9RHd20BL/60JyQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TSp/j+Y32ObPir536xwZW8NdHC43wgCCIbbNT8ovx3jvakf6Jms2Uaa0fC054+D/2TCP5D4/cb8OFQh1y/sVvKGndOTkLUH//I9J0om9+sFElbnO9Nve5rir49FX6aMXFduPjvGW6PtOOKoi8Gw5dV/Zx+JukqcMUczOUVyM+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwJzMIJV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4710665e7deso9871325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760713391; x=1761318191; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DepML/g+us2sXe9XTL0BD4vVQGz+k9RHd20BL/60JyQ=;
        b=SwJzMIJVJNWXP2Nw28DNaPYoN+kr+z75YehipFT0qO0fWm6VyAUlfLY+kZKxcYZgmp
         sMQLw6cPqWLLtN2XcWTH5EFMpGGUkb4yTIRmS2SVjDS4iwZecZzkHdLjW+V9a2NUBgYa
         hkFmkUIPfDOmrL7poci3rdrqoJs9VjY0s19cvNcGA3DnSSx0/LqrBujveHhx/xfCZnsh
         RXi5mSUcoSsH94iQMMdWtIcbTodbeYPbIjxZtaZLZSLbR+gku8jcd0s0fN7B1CCUc2xn
         j7X+oE5JENi1kOD3J6wRMOWgQMUpo26n0VZ7iRSZb0vac+z8aBsSHGc/q84bsbZ0OSet
         NGrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760713391; x=1761318191;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DepML/g+us2sXe9XTL0BD4vVQGz+k9RHd20BL/60JyQ=;
        b=ngTVpByVQfJBXE6H1GZ242pQhBm6LhwkMexkhxb1SvYjKZno0+CWdOx/gCxFvFrgwp
         svHtorLKhzsxM8DHxbgivPkwEPve8hPAAHTcm7Qf7qYqBrOz0d2C9WYGI/Xn+CI6Vie1
         u2i5GpzpxAmJTBcgIxByKCSLvtgAMEdLZdAsS8yYcCALpdmH/YABv6CA8Snt2i4dytWm
         Fadb5NKHzI7N5JYDAwWwjpOwmXguGz6kQepUFLeZNkD+pwY5nfmSc1KUzd3Ta4hA4pnL
         ymxNsJ1ghmqccxFW/tKnGvRalhQKY+mrCu8YdBsBwORuGtKlbjozGuxCBk1bOQP5485U
         9cCA==
X-Forwarded-Encrypted: i=1; AJvYcCXDVwK6m3M+QcPeV0lq2TCCAGSWttf0vMX8mSq26MRQDz1oql7in3SKKzMwO87jiUg7YRQYhBzkTJrsFqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu699Mm6xSk33LnCz+gp5QiCYh1qTxj1t2a/xesd1JFKhiOU5A
	O/+h1GSEPKBFpY5LnvMqwwhW92MV89GfddV6v1z/hKUGir7PdRSatYwV
X-Gm-Gg: ASbGncsVy2ByPbixvT0PQWc8mzDzbGLiRxCCrfHYC0NQnlHxwK8hq2QqNgcUOryuEhI
	Yh70pP7/hr3V2+0mW0nNvtN4LMirNetf5Ju7dAWzayMb0j64uq6qXPEzTAFMRP5+fxcJC7pFTbh
	mcIKGtY/hQMwie3y42CsuxFRyeV5F4wyO1fsWfPq8l0QhougS8E694I7IkHXoXUv1b7SsC3cnYX
	SQP9VAH7MHZPJdPmJyInFR8nlnADwdje3oxVHpzHnFlZ0siEXD6HplkghtMI58Oyp9Cth4zwfCd
	G8dDH4f98OESVyz4p6TP9i0nN9iikW+Kn03uQKR9aJhWizLeRgwG9SyEGk5YxzhU+cgDWllHx0m
	7NF2aZb//kEp4wmVc3ztWcTErG1Bcbx8Q5XqL4YzvlJgj5U+9fNvW6VK7/vrYrVK21isvLzoomp
	fmtRoL/oLS
X-Google-Smtp-Source: AGHT+IFV+Ku+oz8pC4XsMoHhutoyVvOyd/uH27Kd+20XJX5VgjNw5pkgK986EJBySxY2sA+BVs8iUA==
X-Received: by 2002:a05:600c:8b30:b0:45d:f88f:9304 with SMTP id 5b1f17b1804b1-4711791cbcbmr30598905e9.30.1760713390600;
        Fri, 17 Oct 2025 08:03:10 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426f2f72e18sm19966547f8f.0.2025.10.17.08.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:03:10 -0700 (PDT)
Message-ID: <d56b48901843a7a3f7e6543e46eadb3901f58bfe.camel@gmail.com>
Subject: Re: [PATCH v5 5/7] iio: adc: ad4030: Add SPI offload support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, David Lechner
	 <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jic23@kernel.org,
 michael.hennerich@analog.com, 	nuno.sa@analog.com, eblanc@baylibre.com,
 andy@kernel.org, robh@kernel.org, 	krzk+dt@kernel.org, conor+dt@kernel.org,
 corbet@lwn.net, Trevor Gamblin	 <tgamblin@baylibre.com>, Axel Haslam
 <ahaslam@baylibre.com>
Date: Fri, 17 Oct 2025 16:03:42 +0100
In-Reply-To: <aPIqCrvaPQZg7Lo8@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1760479760.git.marcelo.schmitt@analog.com>
	 <c12569f251962ad6034395e53cd6d998ce78a63f.1760479760.git.marcelo.schmitt@analog.com>
	 <e677f27a-787a-433c-8516-99ff1d33f2c6@baylibre.com>
	 <aPIqCrvaPQZg7Lo8@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-17 at 08:35 -0300, Marcelo Schmitt wrote:
> On 10/16, David Lechner wrote:
> > On 10/14/25 5:22 PM, Marcelo Schmitt wrote:
> > > AD4030 and similar ADCs can capture data at sample rates up to 2 mega
> > > samples per second (MSPS). Not all SPI controllers are able to achiev=
e
> > > such
> > > high throughputs and even when the controller is fast enough to run
> > > transfers at the required speed, it may be costly to the CPU to handl=
e
> > > transfer data at such high sample rates. Add SPI offload support for
> > > AD4030
> > > and similar ADCs to enable data capture at maximum sample rates.
> > >=20
> > > Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> > > Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> > > Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
> > > Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
> > > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > > ---
> > > Change log v4 -> v5
> > > - Made Kconfig entry depend on PWM and select other features.
> > > - Reused ad4030_exit_config_mode() in ad4030_offload_buffer_postenabl=
e().
> > > - Dropped common-mode voltage support on SPI offload setup.
> >=20
> > Curious why you chose this. I guess it will be fine to add it later
> > if anyone ever actually needs it.
> >=20
> I had coded that in a way I think would work for the dual channel devices=
, but
> it didn't really work for single-channel adaq4216. And yes, if anyone ask=
s
> for offload with common-mode data, we shall probably be able to it that l=
ater.

I guess that if someone really wants it, the data will still be available i=
n the
sample. But yes, it would be nice to properly support it at some point.

- Nuno S=C3=A1


