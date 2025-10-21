Return-Path: <linux-kernel+bounces-862845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F0DBF663D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D2454452D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A76337B8B;
	Tue, 21 Oct 2025 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vrorYfRI"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CF337B89
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048111; cv=none; b=Qnqm/e0TCd60+EFcqcyMy9MUksWeFRpRMqKbGf4w3yDnfxvKqvXP7gRHKbfGSsoxBham6WWdJOPefqvlK7PQMUrcNIlDnjUpikfraxhev7m9FSD9FDaO1ITZ+Nuo7R8NSzK6/aXdRNtHO2a0k4kVsM4IzH3gn5qiNHHONkLtdc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048111; c=relaxed/simple;
	bh=bZXvcmrwiqFdE5FnI2F10KyfUkHipgWQLFLykYzthmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nrla2BRXW5O6EbzF65/EjGCWYrh6+tKxuwQlRF88cZDHRD+kh+9kjR3YcQr8qPktGxdPM8KcxVb2lOZ1OhW14OPkPGkXIIMP7J4KdMwJGbdKV41NUmAOn4B0Dw6WHkUK0MM5G3dgHoUyekZ6ocdXmIcYgb9xIPFqzboCJ8cpQn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vrorYfRI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b3e9d633b78so371508566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761048105; x=1761652905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wgwh9cwVHsbMC5K6M6/EyI07IwO9cpIjbpF77rsOEac=;
        b=vrorYfRIgFhx9f1mhYe809WyJwHJjOm5k6xTrze/7RovgBRDAWReBmJmPVWpj4ufng
         j2PDP4BMzX2XdB6fWuASeYPZfsDCxl70pfCuf+ebkU6ClwwO4yzUfF+PjI6h26IUK3P9
         ExPoj8C1/+Pd+MbFZclBhLxxFnWCwTfgX0vB7aH16TggAMR7jC+8k/1NlV60vo3nDT2D
         3iri0jkVqK/rFxzZP3RtrppCMo6TQh+E1uLI34t2VEX4yzWmtsW0kK9wRhvUgUscCqIO
         89StBZG/yk7GNVnsSFAFWximCZ2p/3OX8cF9eaZu1Tf6HJ8nbtFegB1DLQgOojYP00Bq
         MC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761048105; x=1761652905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wgwh9cwVHsbMC5K6M6/EyI07IwO9cpIjbpF77rsOEac=;
        b=It2XIjNfZkhFdVkH12V3LbqSj2FFXR7oyBDXxzksV3zgdc49uzrUs7Y48HmUsRNZ32
         +0GTvD8Z0AtcZZ5R67W5pJJKPxnmvWu+yu4326rLGpa8FdqNPtORu0P5F5LRzb8zE7Cn
         t9HXsRufCkxJwy2ZmnMsdZ20nHwR7KJK7Eq0qT6nPfx2hGn5J6QlChzMmDB21e314Zhu
         qlYiS8xqpWUr9VuGtOXgyZKFu025EpO78KxgCosuMQDyhm1fiDcdjGL3D8gKK3zQFfT2
         8wWBAQCJOOJa9qEuT3Jnw7DaNm2gAi2Nq7DLgtqGbVF4WgEUunQ5l2sWlvnPAB82rCnG
         KsoA==
X-Forwarded-Encrypted: i=1; AJvYcCW9S+vimRvMvP98kjFjp5b9gRd84krD2rTgH17Sw2ntfTkFKk4dpKM/7qlKABLn+EGRzPrhQIhSgZVRA3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+mIdpmfqJso5j0lDlMgou8iMdngcqrhO4Pp6b1hCjOkTiHIGP
	dH+SRsuZvbUU0BIZBNT1XPCQPIqGsWV8q3yyoUeiQZSUfjC0V6Gx6T2FwQcvqR9/W8c=
X-Gm-Gg: ASbGncs+98iEciynLHefkrqr4xqKuDQ/9g0ZfgkQhQy02ISPEWxDv/1R9RjZi8dhhMP
	/UOL0bLAWgjFjLO5iqWh17INbyNvYNz/Dh3Vo0TNY9YMiAI4RKUBibZJ1D5KqCHQhF+/d8Kf5Oy
	SqjWUXvdluRyFIQyPit7v/+cNTUIKmJPmGwsrho76F6wPpxR9E8hjA6JsgFe6ZxcfXZPvBNjUII
	1tX+E/6JUpxbbvzhCkA+tU4HXcRqr79/mxiRZU9ka4NKU8eF8g3E8sEKShmuK+ID9wyIs/5aXj3
	iNxyvDrJ6N5ZoTkS9EcYiW3GqOBRTR18q+Nk9SN0hmSoyQ07bg+AS/SnxuRZoacoyjj5wK2zNdZ
	2wN9R98JfUGQ0eevR8n2L5mlpbB6fU/baxyF7t3nuXcE0KkeAtN0a2rDzL+po4HFbZ43EoqWs5Z
	d1Rp759zVINn9+cO3AZYo+Mm0RdrgMym2R5TN7SKB2KrIo4oYm0/YI
X-Google-Smtp-Source: AGHT+IH1nPleni9XNmedQl+tk4HZ8QdCV9hvvlDneyhLhIkfQecIPCtvQUYFEpYBM8gySs7eAhTLGQ==
X-Received: by 2002:a17:907:c295:b0:b4c:629b:aa67 with SMTP id a640c23a62f3a-b60552bd57bmr2354712666b.32.1761048105344;
        Tue, 21 Oct 2025 05:01:45 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b65eb952046sm1052735466b.70.2025.10.21.05.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 05:01:44 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:01:42 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Breno Leitao <leitao@debian.org>, 
	Kriish Sharma <kriish.sharma2006@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com, 
	skhan@linuxfoundation.org, Menglong Dong <menglong8.dong@gmail.com>, 
	=?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Aditya Gollamudi <adigollamudi@gmail.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
Message-ID: <yc3bcn76b6jcdcbnoegwi6bigccor32fuevg66o2lqdewem7dc@nvujb2gazknq>
References: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
 <v3zyf7pp64yd4kakqniq4thjf2egb3kavkwzgoqt6ye5cuqkys@jmkcwst6lrn2>
 <67e75a68-7a03-46bb-ae40-b1a8f24c0b16@suse.cz>
 <20251014103439.GU3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qpjbuyiyjkmliatq"
Content-Disposition: inline
In-Reply-To: <20251014103439.GU3245006@noisy.programming.kicks-ass.net>


--qpjbuyiyjkmliatq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
MIME-Version: 1.0

Hello Peter,

On Tue, Oct 14, 2025 at 12:34:39PM +0200, Peter Zijlstra wrote:
> On Tue, Oct 14, 2025 at 12:13:23PM +0200, Vlastimil Babka wrote:
> > On 10/14/25 11:56, Breno Leitao wrote:
> > > On Thu, Oct 09, 2025 at 07:48:18PM +0000, Kriish Sharma wrote:
> > >> The variable 'cpumask' in mm_cid_get() was assigned but never used,
> > >> causing the following build error with -Werror:
> > >>=20
> > >> kernel/sched/sched.h: In function =E2=80=98mm_cid_get=E2=80=99:
> > >> kernel/sched/sched.h:3743:25: error: variable =E2=80=98cpumask=E2=80=
=99 set but not used [-Werror=3Dunused-but-set-variable]
> > >>  3743 |         struct cpumask *cpumask;
> > >>       |                         ^~~~~~~
> > >=20
> > > Thanks for the fix. I am hitting the same issue in my builds.
> >=20
> > Let me add why this years old small issue became much more problematic =
in
> > 6.18-rc1. When I want to test my own files I'm developing on with e.g. =
"make
> > W=3D1 mm/slub.o", the W=3D1 hits earlier in:
> >=20
> >   CC      kernel/sched/rq-offsets.s
> > In file included from kernel/sched/rq-offsets.c:5:
> > kernel/sched/sched.h:3718:18: error: variable 'cpumask' set but not used
> > [-Werror,-Wunused-but-set-variable]
> >  3718 |         struct cpumask *cpumask;
> >       |                         ^
> > 1 error generated.
> > make[2]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Er=
ror 1
> >=20
> > So I can't get to the part where I test-compile my own code with W=3D1.=
 So
> > fixing this ASAP in 6.18 would be appreciated, thanks!
> >=20
> > FWIW I've bisected this to commit
> > 378b7708194f ("sched: Make migrate_{en,dis}able() inline")

There are several other submissions of the same patch with different
commit logs; I found:

https://lore.kernel.org/all/20251002-sched-w1-v1-1-a6fdf549d179@linaro.org/
https://lore.kernel.org/all/20251009194818.1587650-1-kriish.sharma2006@gmai=
l.com/
https://lore.kernel.org/all/20251015091935.2977229-1-andriy.shevchenko@linu=
x.intel.com/
https://lore.kernel.org/all/20251020221728.177983-1-adigollamudi@gmail.com/
https://lore.kernel.org/all/20251017073050.2411988-1-kevin.brodsky@arm.com/=
=20

Also Krzysztof's build bot is very unhappy:
https://krzk.eu/#/builders/135

> People using W=3D1 and WERROR can keep the pieces. Anyway, this is a much
> more coherent explanation that the original patch.

Can we please get this fixed even though you don't bother about W=3D1
builds? There seem to be others who do. And note that even

	make W=3D1 drivers/pwm/

is broken due to that, so it affects also maintainers who only want W=3D1
for their own subtree.

Regarding the Fixes line: Vlastimil Babka bisected it to 378b7708194f
("sched: Make migrate_{en,dis}able() inline"), but I think this is just
the commit that made the compiler notice that. IMHO Andy identified the
more plausible commit with:

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_ci=
d")

=2E

Note there is a lkp report about Andr=C3=A9's patch (i.e. the first in my
list above) at
https://lore.kernel.org/all/202510041546.DvhFLp2x-lkp@intel.com/#t. I
don't understand the issue found there, but maybe someone should before
the patch is applied.

Best regards
Uwe

--qpjbuyiyjkmliatq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmj3diMACgkQj4D7WH0S
/k6v/QgAhS2Jka1LwEk92EsrO9RERXTvprpqM0j+r4lBT41+7AKJcWbjDbsZ1Wie
Nm7Qm5Zxr/et7ouiklRby4t2vgiYVzx3nUq8PZGZB906qaCXLQ0hwU0D2OsTi6sv
/7Yb1VWv1N1tb6IVBEL2IapHh6T/I2Q4DSuQoPfrPZPzTY/2wt4wHEIP6SeDfsbE
++hAoEhGrbQsARuNm9RtS2qiKTaaDJaMALMlIZ8YP5wMCzp1a71+A7dL1haRwVvZ
hSvkmqfZhVyxu9zrBbJ81lsF7lOWEHytQsQiBfVRXa3MmnfnfNRs4gjiceID1QC1
eH34L8Y6NNNSDJ91wEg//NYW6Vbm/g==
=1lqb
-----END PGP SIGNATURE-----

--qpjbuyiyjkmliatq--

