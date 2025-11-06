Return-Path: <linux-kernel+bounces-889053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 139DFC3C9B5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417C8561BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AF93321B9;
	Thu,  6 Nov 2025 16:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Es1QkEdA"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEC330F555
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447506; cv=none; b=A4wG8AZXV4dONySNEnXQRUo4if3/7yhQYzs7T4LKtQ8nCYrX1yGRARLMLmKZmb8Y2K/3udTahqlhZN0DSZg6H6fRFpCrLnHqWuJwWhreIK0Hpyu86Lmm4LO3ka83lZUBwaBdEzw5pkSG1Lh1qctqKX53G5AylELG5CYheurIRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447506; c=relaxed/simple;
	bh=X9BEWwB0FNpTpkWJhm+qaXY0I7iml0fSupTwank2kMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rMcZ4mWRG5Kg2yCBPCudHaYc/X87HPhvZP1BHd7onWgSaPZ/ZQws6KhE0Y/9mkSc48B8k4ebTBD50n5us8aUL3hrNDc+yjcHYnXie/yw8nfwxQnTps3lpEPneJE80c0qgKVyCl2sQRemJVTIJO6W5WYQWJWIkpVr+6pVCyJZ3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Es1QkEdA; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-786a317fe78so10440137b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762447503; x=1763052303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCzuZ/teXYU7yevuP9B3flHK19xr/xlr710i4rE8skU=;
        b=Es1QkEdA/zBpIPzi+HGQl/7UQTc0u7rQ8nQ0oNHOJvYpsDrh52P+nfcZ1rRMFmekG8
         oWKW1fPLFi0yEr9g8nCV4eIarl2Kv6/bIY91CoJxqjC4yot5jHJvoora0gdiknA3GU5/
         RdStclCYNas64mysPuwfygU09X9y4gu0ZUbgVKQIBgM9pLWf4tzdiQpuBD/RsrJTUmiL
         o/sCo5ZnjxyWXd/cYR+X3YeriM6gB0Nn6LZO5rVnBQNmPEwaWl+/x71i20PG8OY4Fi+S
         cbK27KlFofPjN4icMa0L/Tu7aA857zVeADmHxcoOlL6BaEvh0ikqYMl4fChbZSHxKrt/
         O3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447503; x=1763052303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCzuZ/teXYU7yevuP9B3flHK19xr/xlr710i4rE8skU=;
        b=DwY2/8xArGpqPkrz49vdD9BCQMlPw3JrTBGsNNSYUxswwt7A6RU0yJvddut8/Sims7
         tiN7wgdU9lDbyRvDmu4z5Ua4c/HtqdQnraIi/Hld6KnnUEVLIYclAl7nyt08rdSvyAE1
         hnqWpXY693lWZ1MylDWlxJeZEN/GS6LaKlgBF6f3L5TFtgeVKQs5NSDC2Yom//ms0TWA
         mLeSSlhSEh2WcbxAMXqdoKtoiigB+9AavP5NrLGkDnT01dzxnWWsRlxOV3fk2ZpY37oC
         geqYQ1WxoZWWEbr2TBXubCamc7rnRo7JX5osj3CuAgRilP1ChPVIXvzvjW34Cjn4nOVz
         560A==
X-Forwarded-Encrypted: i=1; AJvYcCVmLo4SgUHrF99lKwdT7HqeThSspoDiAGDDce5aIUrr68l0Dlwt3tn+k9OzW6kO3VxKuuFBHRbKuLvLGos=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqzmkzJn5Dc/54robi66xGW6yFl7sv56ngN+YNLXA33YWTksJ
	Eo9U5DdN9oR9fcPXPu0uyRvEIjAee71j129VwlttsDWPg+oX8mHSRPia
X-Gm-Gg: ASbGncvt9CeemAG1nrrFsSGIYOR+cZYDKkGMaenUsiCdVaBnpjkNk/6OVVcDzSE0lba
	C7cgzJkmnnncwsqmiIKPma07e3wHXhnK6oOc9+Squ65DOweuIZz61DkyF/1UJDPcRRqets+1Ul8
	0BpZEfyM8utonrIpacz9nJo5xKgrFtXjwt4hJC7tOT4E0a3OxJMWOfHrlBDWJtPOZL1iZr1j7Pe
	dEQeZXPDQ27zHyBKZYEahar0hsdjaLQJ4qOmIVJa2AIqJVcWpBDKkU2Iyt9zyYdauDkKqpMmlhE
	Fp2avwI/8XrjhAonRoiF4/GA0F6q3SzY2d8ZbF0oC105lwSGkWmkeg9/fas+RpnPTXJrFjvOM8Z
	dPPVNcYUENJwA12RdpNbxqoBrIZoKn1/94KQ+Us3zQEocsOavv4qPvkNDsZ2rgaABbAmn2B+mVE
	lciKSczUN8vvWV0ffAmEhZ/z3J8A412b8DwfA6vR9uPwU=
X-Google-Smtp-Source: AGHT+IFgqblsjDg64jVhZU34czKFHTApBwHTvzKvobAZn60rv4BaSs97biLpVcByf7R85pQynTZCWw==
X-Received: by 2002:a05:690c:46c3:b0:786:45ce:9bd3 with SMTP id 00721157ae682-786a41b2455mr71656237b3.34.1762447502815;
        Thu, 06 Nov 2025 08:45:02 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b13b6954sm9471997b3.5.2025.11.06.08.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:45:02 -0800 (PST)
Date: Thu, 6 Nov 2025 11:45:01 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/26] Non-const bitfield helpers
Message-ID: <aQzQjSMOSrUIgMCL@yury>
References: <cover.1762435376.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762435376.git.geert+renesas@glider.be>

On Thu, Nov 06, 2025 at 02:33:48PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> <linux/bitfield.h> contains various helpers for accessing bitfields, as
> typically used in hardware registers for memory-mapped I/O blocks.
> These helpers ensure type safety, and deduce automatically shift values
> from mask values, avoiding mistakes due to inconsistent shifts and
> masks, and leading to a reduction in source code size.
> 
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant (e.g. it
> comes from a table, or is created by shifting a compile-time constant).
> To avoid this limitation, the AT91 clock driver introduced its own
> field_{prep,get}() macros.  During the past four years, these have been
> copied to multiple drivers, and more copies are on their way[1], leading
> to the obvious review comment "please move this to <linux/bitfield.h>".
> 
> Hence this series
>   1. Takes preparatory steps in drivers definining local
>      field_{get,prep}() macros (patches 1-11),
>   2. Introduces __FIELD_{PREP,GET}() helpers to avoid clang W=1 warnings
>      (patch 12),
>   3. Makes field_{prep,get}() available for general use (patch 13),
>   4. Converts drivers with local variants to the common helpers (patches
>      14-24),
>   5. Converts a few Renesas drivers to the existing FIELD_{GET,PREP}()
>      and the new field_{get,prep}() helpers (patches 25-26).
> 
> Alternatives would be to use the typed {u*,be*,le*,...}_{get,encode}_bits()
> macros instead (which currently do not work with non-constant masks
> either, and the first attempt to change that generates much worse code),
> or to store the low bit and width of the mask instead (which would
> require changing all code that passes masks directly, and also generates
> worse code).

Everyone please send your tags. I'm going to merge it in
bitmap-for-next before Monday.

Thanks,
Yury

