Return-Path: <linux-kernel+bounces-873387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5705C13D25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336133AE6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E193002C8;
	Tue, 28 Oct 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFzeK94G"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26852FFDC0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643649; cv=none; b=BA9VlN5bMsPkLbRURXY65MkFP7JkI14EbgxyRiPbQi4fSwn8zUYT8HH74upvSmMVEvOkAlSjAQMhZYwo0uz0ZB/0w94Dim3QAcicyrAVC9dKudWNjlD0BgKHuGubIZ+pvXazv5Wn/Ap6PTHOeuOI7VM5DcBp1VVTX/A4MExFzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643649; c=relaxed/simple;
	bh=2nzO/Lgis0CGEF4PRwALL8keP37eKj0EffWsyrHfk8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POdlOQvowCBNUczmq4xiOpPzuv8N7P++QArDFTSO/6ZGtQX1BN3jBPo9u34eBr8PM7u0tpfCv6nO5ndWzGJkVqr9ul9gI8kfEuFLs2FZOIpIENV+LQm679z/aWC7RyQgvdO9pHu/ae97QPNLD8g6/EXNmbNlas+L3a6FKLuvexU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFzeK94G; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4270a3464bcso4391674f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761643646; x=1762248446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Fa94rq4LY4WzohJQBw+1+fnrKto/qSLOJsPZx6Z7XI=;
        b=gFzeK94GevHbhOMiC3e73zh2DVpGzeNYpfuermoLx17CgcM1z15E0c7VRnKDatBmJ9
         jBfbONzCHIDfmkUHshBA01wOYhy7sios20iu02Ik00nZHUM4tWkWWSHSA9CM3zEyFn6P
         BpUBQe3jLgkj3+jUqgzA8PIVc9kGACoPAYrDjZeNcOJWpMKKCyuHGDhm63G3N7WQ2CZ2
         1DkV+0ij+AhS1S6s/bO0/fbzdUsOIK9RVU6t41G06Ox5M/drv9NGsVvIuFivpw1IJaeX
         PF0SVq6RaPCfVb7CZxPQOijIHwDp+xe6SQ67OSGT31LA3hK/5LiY9Dh7Jk6bXRJMayVY
         Zu+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761643646; x=1762248446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Fa94rq4LY4WzohJQBw+1+fnrKto/qSLOJsPZx6Z7XI=;
        b=s/434klr1wU0kq9cMmeBMPPO9pOyYx+i74kNYqY1z0ROmpyuo3dSkd89F5DLIUUN7M
         p3AKGzSm9oW+bqDukOP2CFZ/xZPI6e9qVw2dRKdDX/RLws6z6GPrWHpshIiDBi2w0Su8
         mmOWlzhprXLmeCunUvhBaLTKjRt3EyH/boKvaOtBqsR43RZ9+ayI380ZXIJkHR7/Ex9c
         q0sd2ZUhreQnWkKEg1RUMRsxztOHKtDxrwbUUFGjSV6c3ZEbz/r6wn3ntQthZAJpIVqH
         57RPtR35WZMkVjYIWa4l4u8bxc3WYEdGiLd9P59cZ/lBtm88mgW4fG/Wm59OfnIOHfwM
         edYg==
X-Forwarded-Encrypted: i=1; AJvYcCWteXo0tRTkWe8sr7v6eQ5UTfsTRjFD1fHtWsRT7kDvV8CbABS24j0yJXiPXEsO4EviAHyKoP2BiXIFYGA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v8v13V6EqJh9AQx5qCABtUq8NJfv/5PO3ue/HOCoZonQwGxd
	2jQm0Z5T68E+ryGjn7qQJ4ygEJVZusGvuX1ETtnHXLeU4HtzZk+fyFnD
X-Gm-Gg: ASbGncukivget1+JV7seJhtaR1xMLL2tMt8uBsyh5VAqk4xtDQkbQJlz5T3oYlGazY+
	6gRFFECXdKIbODsiyWXmexhLURhT4GoGZgchov1nss9YIWiYWTy9evz07SAu0jFelAsN4C2YPvy
	1UsAjhEnMU11bOOfwKgAZHWKz9+wz/zAt0jZECuzToxVtS1B520Ly9+T09kZ2y2fjQH4MjD5SEa
	nfAch49O0tbQdgBslev38DzyR1e2AETwABG5AO0l81d33u+luFIiUf4+hXQPmCeOsTpmd+AN18b
	uPOnTfE3n6Saj/2nsN/cSLAZy1frVjDsvqxNF4TvxcJSjuoVOXpCbTdLd8CtnGf+3G5XF0AYc9y
	M/EN6CKv/ykXbYbIqq1gEx6ZEnQlTwYMai46yXoE38GWfHe+l+X8uyUhVBMQNRVWifSJCYaK31D
	wD3hwilUBZB7Xn6YszRS9EOcQ0NZSlMTAMnGbQ9n3SDQ==
X-Google-Smtp-Source: AGHT+IFF5YJfFnpTtTAVxGmV5ZlBFo/mf4gYcQP7jzA5jKthEnOt4UjCXc6otkG5ppk07jpyxXmDJg==
X-Received: by 2002:a05:6000:25f4:b0:429:a7f1:bdda with SMTP id ffacd0b85a97d-429a7f1bf31mr2313106f8f.47.1761643645777;
        Tue, 28 Oct 2025 02:27:25 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm19408803f8f.21.2025.10.28.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 02:27:25 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:27:23 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Subject: Re: [PATCH v1 2/6] units: Add value of =?UTF-8?B?z4A=?= *
 =?UTF-8?B?MTDigbk=?=
Message-ID: <20251028092723.3403d122@pumpkin>
In-Reply-To: <aQB55GjWQL3VD1MO@smile.fi.intel.com>
References: <20251027143850.2070427-1-andriy.shevchenko@linux.intel.com>
	<20251027143850.2070427-3-andriy.shevchenko@linux.intel.com>
	<20251027193033.69728215@pumpkin>
	<aQB55GjWQL3VD1MO@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 10:08:04 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Oct 27, 2025 at 07:30:33PM +0000, David Laight wrote:
> > On Mon, 27 Oct 2025 15:34:51 +0100
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  =20
> > > There are a few drivers that want to have this value, and at least one
> > > known to come soon. Let's define a value for them. =20
>=20
> > > +/* Value of =CF=80 * 10=E2=81=B9 */

Thinks - should non-ascii characters be allowed in comments.
They can cause grief.

> > > +#define PI	3141592653LL =20
> >=20
> > Is that the right value?
> > IIRC the next digits are 58979 (I used to know the next few as well)
> > which means it should be rounded up. =20
>=20
> Right, today I have the same thought that actually ChromeOS driver has a
> off-by-one issue there.

Not as though it is likely to make a difference.
If any code needs anything more accurate than 3.1416 it probably cares
whether the value is rounded down or up.

> Btw, do you know if we can have compile-time divisions that can make 32-b=
it
> constants out of the 64-bit input? DIV_ROUND_CLOSEST_ULL() doesn't seem a=
llow
> that.

Not sure, I did wonder how much thought had gone into the LL suffix.
The value used will fit in u32 - but then any maths becomes unsigned.
OTOH using LL forces 64bit maths on 32bit - not good.

I suspect it would be better to drop a digit so the value fits in a
signed 32bit variable.

The other issue is whether scaling by a power of 10 is even right.
If the code has to rescale the value using divides you really want
to divide by a big power of 2 not 10.
So multiplying by 2**29 may be more useful.

	David






