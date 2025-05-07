Return-Path: <linux-kernel+bounces-637696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23CAADC26
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D6F1C222BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 10:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1D02147F6;
	Wed,  7 May 2025 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FBHGeRui"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E864A21019C
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746612251; cv=none; b=ZDDwXtAtQyAQnEKEziygZRzdLV4iag02iIPZ37smC2SbZy2vSidnfKDWA3R9QGi/vAtddbjanug3Ag+4xmLLSORk0edo13sJnDbKa+i07fu4IxgWhfkR/Hgdb5gK5Vqa+g2f+u8pqUGQ2Of/3O98JzeqJXL2rtWdLU+fCmXpL90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746612251; c=relaxed/simple;
	bh=+5OdA0oEnVokN1rpaxGvi2C+sVk9jnywPeQTetGSAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyTf/TUrFvZ3uKEmDVCi/lfRLTguawtxiSP1TiV57aNewFoor5FN4WCjUPLp4ajBHZkAcKqrSqpbTZd//7b6wDYVxoSbl0enYkRijsA3lwDwCIh7nzijmwALqIAFgw3jQa3wMyx4BtFj4LGa38TdCWO0Vtn2/JPqyN+WKLVGR7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FBHGeRui; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1efbefc6so4942118f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 May 2025 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746612247; x=1747217047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o4drvJJUgYEZxCfccWRhpTUQplm3nJwkaeKuYVaNajo=;
        b=FBHGeRuiP/D5ULFDX4C8tJN50BJFtLetYxx3xI3Ym3Lq1O2sZSHPTyEDoo2uLNs2tJ
         x3phYgvnPlIniqPl4b132a33+qNykw9umaiz75PKaIqprOGaI2MkJRk7h0IUd4mco5aQ
         qECR3O7YxPTewhqrGPzYsBilX+zUy5MnEMG8rXjFe+hCk/2KloiSoPLKzZ54JLtW5ehW
         wzI08cZi4JxsBNLxz1w00rxRUrXsIP0lhNmZFrHb9GvUp7LCmmv03wTbtSZlb75hUISp
         wtypzjvPQFuBzFXWjJ9tGvflPtnraZcQJvPTA57GAEoLrGJ9zl5VL6EV1GebgbHgEzGS
         P45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746612247; x=1747217047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4drvJJUgYEZxCfccWRhpTUQplm3nJwkaeKuYVaNajo=;
        b=RYPNJdPjx+PIDw7yZlbmTrjz7I5tec0T+C2HvJtsxvt+ya5R0bvB9c7jVOnnvMz+bd
         3vSgzQiHMcPl7P5oqp1m0L1ZCpF5DV+BVtrqunY5VZX8AguG266o1cBtK+GDMCHGKUUr
         5LSZvWBo6CFYiFVs0mlKXj0lRDbFXgg412OMLgF2Y36NmLKwP5B0eUBNQ0UD+V9P1ivI
         gHIDiRVN2nEx4v4ZC77oc04hbdBqP0UsmAqfCySzj1sNkAXUiR1D2SEo+XEoUQ3VAyka
         064yl13O1HNghqZwNi5hlaKQOHw4DIli+JqNL16u3fJ4YiYcRUdiNgWjEU2NKL/HogIN
         uIKw==
X-Forwarded-Encrypted: i=1; AJvYcCV0r6wE2iJmWbizO4IpFn+rf+f9RjcZZ7y8R2uiS2ahZgjCKfrL5dDfh8CsOCuEXVJFZmYcjSXCgIZMplA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeQ7HG03KqGlVxMjE5riXTehFLAfNtGgwuogH8c1lOqn3CpYWt
	/LpHPodEWKNoU6H5n9TFlD80dlQpdURbLr2aFB0j27HH2XIi1/ZPrUCk3JivpO8=
X-Gm-Gg: ASbGncudS7gCLMHjJ6gsWNE/noDU0iG+6W+/Dl5KEGcM1c5N9UIhsNQDioa9dgO1VX8
	bYrvKzyZPUmtOhVIhxtjXUn5+3BI4B0EWCP24Ksb7cOWTEjILf4HIZMNPclFpAguvDylxKAbmoz
	e+9HWZt4ymRWHmL87J6sKkwElassAfJafn95+gA1crFyddAGieeB+aMk6VQbNkR0VUVVwe49gNh
	jhI7vQrMGUKWZy+1N43m0dvNreq+JrvKjDVpRWKu3Q7LIqHAU1ccqG0E8bQ3+KDmWqtUrMQFuVK
	4aDyGC0gMhvMTA2NVydVU+wlq4m1FKncbYLfvu/jo9LtqspfJ2FXhJMsqs+l9qOw1iCBB6HPsga
	XaGJP45M=
X-Google-Smtp-Source: AGHT+IEaSN+8g1NFKyP/wiEuCt2qNtlAySEQ9Eluq9F9UG0pScqdYhwwvlQsl1TiQ3pW5g9bViorNA==
X-Received: by 2002:a5d:53ce:0:b0:3a0:b72a:b36 with SMTP id ffacd0b85a97d-3a0b72a0ce2mr649663f8f.36.1746612247148;
        Wed, 07 May 2025 03:04:07 -0700 (PDT)
Received: from localhost (p200300f65f00780800000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f00:7808::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a099ae7cc6sm16743937f8f.55.2025.05.07.03.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 03:04:06 -0700 (PDT)
Date: Wed, 7 May 2025 12:04:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>, 
	Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/4] pwm: userspace support
Message-ID: <yvpdeff577l72zxbtz2a2pwghzk3app4dfntjfgijdultauvea@dqkaek7tbbos>
References: <cover.1746010245.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2rfq35pycrfzygjr"
Content-Disposition: inline
In-Reply-To: <cover.1746010245.git.u.kleine-koenig@baylibre.com>


--2rfq35pycrfzygjr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/4] pwm: userspace support
MIME-Version: 1.0

Hello,

On Wed, Apr 30, 2025 at 01:55:57PM +0200, Uwe Kleine-K=F6nig wrote:
> after the feedback I got from David on v7[1] and some internal
> discussion here comes a new version of the patch.
>=20
> Apart from rebasing to a newer base (current pwm/for-next) the only
> change in the relevant patch #4 about return values from the
> PWM_IOCTL_SETEXACTWF ioctl. Instead of returning 1 if the request failed
> to apply exactly, return -EDOM.
>=20
> The earlier patches in this series prepare that and implement a
> similar change in pwm_set_waveform_might_sleep() to simplify also other
> users of this function. Patch #3 is only a documentation update that is
> not strictly related to the userspace chardev, but reflects the changes
> in patches #1 and #2.
>=20
> Feedback welcome.

I hope that no feedback is good feedback and pushed that series. The
first three patches to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

as v6.16-rc1 material. The last patch only to pwm/for-nexxt which I will
push to next after v6.16-rc1 to give that a long time in next before
going into a release.

Best regards
Uwe

--2rfq35pycrfzygjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgbMBEACgkQj4D7WH0S
/k43Kwf+MCeLEQtaqRQp3PKuwsCxXrVgqiIWBtSxhmcZpHfDOqHkAYPzfe5mHgaU
r4HpXdFemnQ5KcQFqbjSkhwO7pxWewfO4MOjXgL0TdKUKwsKE7yoB+Cd4wM219AD
cLeRtxR97DUCM8eH4mludOJ9ooD+HdnMXKskRlUik4yPmaqU3eNFVjHsndqOo43B
jqGkB1/MiDv+NupH1VWeRD4ruZ19yGXup1/JGaNmnG3Gz++jxGMZ5SpsPaHS5Ej/
/rnP5ihOWSpUUCx6VFibZwukq2TcI8nDjzm27IxdOZB/K182Kbqb5ZIaKzXZGVv7
ctJjAnZoDNrXZyA751C9WBE8kYlgQQ==
=FhI5
-----END PGP SIGNATURE-----

--2rfq35pycrfzygjr--

