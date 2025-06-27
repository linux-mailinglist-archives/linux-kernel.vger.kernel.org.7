Return-Path: <linux-kernel+bounces-706885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16486AEBD50
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 18:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5203E189843D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CD72EAB6B;
	Fri, 27 Jun 2025 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayz8TZAF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27212EA474
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041590; cv=none; b=iZJyaJeAFYL6mX4OfvFcuSSad1C2uF4P9HZSYAZmU2SITWhY1qrAYtSh9s7mHu3WmUotxBqJhSf5NLAND9VxJrnLsUEmmlW198ioymgYhVhYjVxm3WuPg0R7Y0aoicrDv1h9JI/he4uBRrt9MH689V2i0OWz2XejkZPf662m0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041590; c=relaxed/simple;
	bh=I60zwGjY6Dgklboh4xcYQEBVuQgXueLMk6Nbi/S2r3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMclqvU7st4ZpxcqzcB9A5Gm67SzhGeTSTknoR3v/QlgSMcI7zTowB4nK/ySQcQZE3Z1bPTbnUB+4C0o3Ojq6hCpXETPM/DKeuig3UcFCTQYYKd3boOqWklJ/GpGmbyNc8mfOiAceyEXuE+Es6M2VQsxoiy9L/8NE2KP9AW5IBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayz8TZAF; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751041589; x=1782577589;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=I60zwGjY6Dgklboh4xcYQEBVuQgXueLMk6Nbi/S2r3Q=;
  b=ayz8TZAFAdurf7mur8ajVOY3HW+UyufaUIQ/laNzl8sId4rnyWucqEMi
   XnPakna3TQvrGWxFP9zFkQEEoP4E9ZdrPbxRQ5W1KeiQ81WSWAsf8fVHy
   vyPSduY1HvDo7fiTG+/VYrQOHCT+lSvTEV+BNaDwBg+eg6VS1RY0XHkKI
   +KjYqvqqe6WE8jjGKX2ccZ//ogag4zSpkzeO5c6I2GvuH35uk8pN4R0ff
   kQeNKmbNwMdvka1Fc8ljFO7kGE5p38PW704dK3LLgdv8w1Adma92ruRXo
   GJ7F0NtwS9tBt3Sie/2/0fnYlfUJKZ3Yv63s5Qf97BaX+cWQr+4inRequ
   w==;
X-CSE-ConnectionGUID: XR4L7xfhRxaXmKypMnhBQQ==
X-CSE-MsgGUID: rWwNLDkfS3OkvIJuGGEN6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="75906897"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="75906897"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:26:29 -0700
X-CSE-ConnectionGUID: sJjwlm7FS5ic52X6843q9w==
X-CSE-MsgGUID: Yp6hdJbRRCa9NVDFcRUyLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="152944718"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.146])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 09:26:25 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, Imre
 Deak <imre.deak@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Matt Wagantall <mattw@codeaurora.org>, Dejin Zheng
 <zhengdejin5@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] drm/i915/ddi: prefer read_poll_timeout() over
 readx_poll_timeout()
In-Reply-To: <aF67cxjlfWiWMx-4@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1751023767.git.jani.nikula@intel.com>
 <59bcc15dd4debf00ee0c7b430a3b701462ac9de7.1751023767.git.jani.nikula@intel.com>
 <aF6UOCLdO0fGHGA9@intel.com>
 <f922ec0a42855e17228d3f22d7291b389abe2df0@intel.com>
 <aF67cxjlfWiWMx-4@intel.com>
Date: Fri, 27 Jun 2025 19:26:22 +0300
Message-ID: <1b5d73351eda2d86437a597673bd892baf90fafa@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jun 2025, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com=
> wrote:
> On Fri, Jun 27, 2025 at 04:34:23PM +0300, Jani Nikula wrote:
>> Internally the macro has:
>>=20
>> #define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
>> 				sleep_before_read, args...) \
>>=20
>> ...
>>=20
>> 		(val) =3D op(args); \
>>=20
>> So you do need to provide an lvalue val, and you need to be able to add
>> () after op. I think GCC allows not passing varargs. IOW you'd need to
>> implement another macro (which could be used to implement the existing
>> one, but not the other way round).
>
> Just get rid of the 'args' and 'val' and it'll work just fine.
> Then it'll be almost identical to wait_for() (basically just missing the
> increasing backoff stuff).
>
> AFAICS this thing was originally added just for reading a single
> register and checking some bit/etc, so the name made some sense.
> But now we're abusing it for all kinds of random things, so even
> the name no longer makes that much sense.

Yeah, evolution not intelligent design.

> So I think just something like this would work fine for us:

LGTM, with the _atomic version for completeness.

Want to send it to lkml?


BR,
Jani.


>
> diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
> index 91324c331a4b..9c38fd732028 100644
> --- a/include/linux/iopoll.h
> +++ b/include/linux/iopoll.h
> @@ -14,27 +14,24 @@
>  #include <linux/io.h>
>=20=20
>  /**
> - * read_poll_timeout - Periodically poll an address until a condition is
> - *			met or a timeout occurs
> - * @op: accessor function (takes @args as its arguments)
> - * @val: Variable to read the value into
> - * @cond: Break condition (usually involving @val)
> - * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops).=
 Please
> - *            read usleep_range() function description for details and
> + * poll_timeout - Periodically poll and perform an operaion until
> + *                a condition is met or a timeout occurs
> + *
> + * @op: Operation
> + * @cond: Break condition
> + * @sleep_us: Maximum time to sleep between operations in us (0 tight-lo=
ops).
> + *            Please read usleep_range() function description for detail=
s and
>   *            limitations.
>   * @timeout_us: Timeout in us, 0 means never timeout
> - * @sleep_before_read: if it is true, sleep @sleep_us before read.
> - * @args: arguments for @op poll
> + * @sleep_before_read: if it is true, sleep @sleep_us before operation.
>   *
>   * When available, you'll probably want to use one of the specialized
>   * macros defined below rather than this macro directly.
>   *
> - * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
> - * case, the last read value at @args is stored in @val. Must not
> + * Returns: 0 on success and -ETIMEDOUT upon a timeout. Must not
>   * be called from atomic context if sleep_us or timeout_us are used.
>   */
> -#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
> -				sleep_before_read, args...) \
> +#define poll_timeout(op, cond, sleep_us, timeout_us, sleep_before_read) \
>  ({ \
>  	u64 __timeout_us =3D (timeout_us); \
>  	unsigned long __sleep_us =3D (sleep_us); \
> @@ -43,12 +40,12 @@
>  	if (sleep_before_read && __sleep_us) \
>  		usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
>  	for (;;) { \
> -		(val) =3D op(args); \
> +		op; \
>  		if (cond) \
>  			break; \
>  		if (__timeout_us && \
>  		    ktime_compare(ktime_get(), __timeout) > 0) { \
> -			(val) =3D op(args); \
> +			op; \
>  			break; \
>  		} \
>  		if (__sleep_us) \
> @@ -58,6 +55,30 @@
>  	(cond) ? 0 : -ETIMEDOUT; \
>  })
>=20=20
> +/**
> + * read_poll_timeout - Periodically poll an address until a condition is
> + *                     met or a timeout occurs
> + * @op: accessor function (takes @args as its arguments)
> + * @val: Variable to read the value into
> + * @cond: Break condition (usually involving @val)
> + * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops).=
 Please
> + *            read usleep_range() function description for details and
> + *            limitations.
> + * @timeout_us: Timeout in us, 0 means never timeout
> + * @sleep_before_read: if it is true, sleep @sleep_us before read.
> + * @args: arguments for @op poll
> + *
> + * When available, you'll probably want to use one of the specialized
> + * macros defined below rather than this macro directly.
> + *
> + * Returns: 0 on success and -ETIMEDOUT upon a timeout. In either
> + * case, the last read value at @args is stored in @val. Must not
> + * be called from atomic context if sleep_us or timeout_us are used.
> + */
> +#define read_poll_timeout(op, val, cond, sleep_us, timeout_us, \
> +			  sleep_before_read, args...) \
> +	poll_timeout((val) =3D op(args), cond, sleep_us, timeout_us, sleep_befo=
re_read)
> +
>  /**
>   * read_poll_timeout_atomic - Periodically poll an address until a condi=
tion is
>   * 				met or a timeout occurs
> --=20
> 2.49.0

--=20
Jani Nikula, Intel

