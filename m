Return-Path: <linux-kernel+bounces-879676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2FEC23C11
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43934FAD0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6964A329C67;
	Fri, 31 Oct 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EygcnUOL"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0021F5434
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898099; cv=none; b=osCwAsHN8rtPGrZVqBpQhr7iyWFHF2d6RHPIbEK0Wq32dZ+WEwGXm//4Gyyw2V1a25EIj2TKtiLg5CmUful2xjfLhhS45vvFkL3yvua5aC89DuC9K4btxRQ0841QxST8TULeETd8k36mHDeJk+4RIU//EpNsxe2R9p9Opg/bKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898099; c=relaxed/simple;
	bh=CzB7puzpaIg4J5iJ4aYQ3T5femYSZ2tisd4ljWkriQk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kWCtHigR3rbEyDSl8XMQ9rCkVU7HiekAGIPx82dsm7s9Oi/B4wQIWfLE/GXcb9HxxbI0oT0h4GQr19HsQKrWXBsFniajhezYzaZZnL6X7tJuVEv5rCjByliOK+yPDhZ2l1rx5pH5wNen6hEPshqmxUVo9EgCaEP4wkbKXAQZnlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EygcnUOL; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so3030588a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761898096; x=1762502896; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CzB7puzpaIg4J5iJ4aYQ3T5femYSZ2tisd4ljWkriQk=;
        b=EygcnUOLoLGkEq3c6sES639A2R/ouoOdcsDgffdnu4Hmh8qd4ZlFXsFwserDdnwhUt
         B88Y3Z6PoR2Df4tQaqWi0jgLfRyQbzxoo9pfUEO/dGnfz4whSnc/tG8CjcJucaf/8Ti4
         zK4HusCTCmJZHX6FnX0SB5EWo82VqdjBpqIB8/2ZUFRCqBp1vRmovfy9yYw7GAhfQ807
         4KkEWlpnjjafGQld4R75VsTCMAA8+dF0qHAILkM6yWBcakud4abf/RicuWd0+i/N5UYV
         p3TjrohuRQGLDKf6jQ7QnuWW0H79sV6EhmsHzQavcdFsFhQBD9Ixh9+bQjHtfEYSeXH4
         Z4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761898096; x=1762502896;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzB7puzpaIg4J5iJ4aYQ3T5femYSZ2tisd4ljWkriQk=;
        b=lNh46mTGaBq70ekmcUHL7iE34wWacWYo3uh8P4wtCDhxLMx+uMZRZ0Rf74epgLnB6p
         RCUziZufXZz7B2O4jzULJlSzQe8gyWWpE0WHhIGE1mM9bwoi9WhN5KI3dYQWu7wE0aR8
         jDCjt9nnKF3/3R63vGcVn9LdI5pAOw0BMT/SbJ5jWBmhOEA4tExZfXR5z+6zWYK+M7aM
         wA48w1+G2xroEWyvcpeN8RKph2ntVQlCBlDHRxTL9jEpBJPH6qQX1lCduKEzARwbNPdY
         L5IRYsE0ItxgdTajZid+eIZFpBthqt7SmRUHY14938FphcbF5SehLB8aGpWzqzmNDdnB
         HMgw==
X-Forwarded-Encrypted: i=1; AJvYcCWjMrn67yvL9uBjX8fpEyPKVhg3tMPfqLB6FKs0w3YZUVXzUmYz7MZfljAonLV5dngmMS4HiIjfToswJ4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0USQqzuL8KAeUGjSPsrl7QqxJZx+eWOqFn47sJZEcKIzxFsB1
	n4TpeZtXiQxkFm8EEYIaCDKYdvtnjGF0O1+4UMzF5+NQMup3MTyJGKjpzVabDiENpaw=
X-Gm-Gg: ASbGncvp5U9eXWyB7bMPNviZq7i79/niyI4S1PzBhPAaiT30kw25w4y7obOquwaSrmA
	7rdQ0u24OXC1JjGWkkNwEK6UbyGlQfO/zkxBJwhCjiEHlQQ9YPX5YwagyZmq1wsGczMDFoGGxMH
	js5LY8777R1cs7lV7+1O9thYSKBCYqNFtjqagdVc8i9dc8DSK7o3tGOM9dgt8H2nz4Y1oyFn9oF
	PW8CUzoPVyaIZSo18wHZ7Y/p7lMXEP/o74Oq8ao440G6HrNv0+PAMMLxTgIqI76p6NynL50C2pb
	TaJ9/HXGuUCTtCuOljJePYx+ZHX09YTqhZ0R0Zu+B49Lbae1ePKJFDRccAqi3Vbo/Cx/QAikU86
	IhFFvtp9rp0aGdFTlTwJw0DbSix1yzoLpxgUeg2kxJORJQOuJmMQT+fz6QE6/kJnCgQxPkE/vy4
	J0J0BgsnnuJ4G84aguxjbJfJz4OjbOr33uzTrd03injG4Ctxp+Ow==
X-Google-Smtp-Source: AGHT+IFs6OpBylfnRV7ubkY2/lHlHIFJ6CS/jmWmal20du9mmcOwOV8fb1bm1XtSMxm869tePKbLmw==
X-Received: by 2002:a05:6402:42c4:b0:633:7017:fcbc with SMTP id 4fb4d7f45d1cf-64076faddecmr2151846a12.15.1761898096076;
        Fri, 31 Oct 2025 01:08:16 -0700 (PDT)
Received: from [10.203.83.168] (mob-176-247-67-93.net.vodafone.it. [176.247.67.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b42821bsm1034663a12.22.2025.10.31.01.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:08:15 -0700 (PDT)
Message-ID: <a1e678aec0d978408704970faa16fccef4ea214d.camel@baylibre.com>
Subject: Re: [PATCH 2/9] iio: imu: st_lsm6dsx: make event_settings more
 generic
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 31 Oct 2025 09:08:14 +0100
In-Reply-To: <aQOV6cDVTJ-5uyCz@lore-desk>
References: <20251030072752.349633-1-flavra@baylibre.com>
	 <20251030072752.349633-3-flavra@baylibre.com> <aQOV6cDVTJ-5uyCz@lore-desk>
Organization: BayLibre
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-30 at 17:44 +0100, Lorenzo Bianconi wrote:
> On Oct 30, Francesco Lavra wrote:
> > The st_lsm6dsx_event_settings structure contains fields specific
> > for one event type (wakeup). In preparation for adding support for
> > more event types, introduce an event id enum and a generic event
> > source structure, and replace wakeup-specific data in struct
> > st_lsm6dsx_event_settings with an array of event source structures.
> >=20
> > Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> > ---
> > =C2=A0drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 21 ++-
> > =C2=A0drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 136 +++++++++++---=
-----
> > =C2=A02 files changed, 96 insertions(+), 61 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > index db863bd1898d..05689887f7ec 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -221,14 +221,23 @@ struct st_lsm6dsx_shub_settings {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 pause;
> > =C2=A0};
> > =C2=A0
> > +enum st_lsm6dsx_event_id {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_EVENT_WAKEUP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ST_LSM6DSX_EVENT_MAX
> > +};
> > +
> > +struct st_lsm6dsx_event_src {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct st_lsm6dsx_reg value;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 status_reg;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 status_mask;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 status_x_mask;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 status_y_mask;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 status_z_mask;
>=20
> you can use st_lsm6dsx_reg here.

Do you mean replacing the status_* fields with 4 struct st_lsm6dsx_reg
fields (one for the global status flag, and one for each axis)?

