Return-Path: <linux-kernel+bounces-725209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F6BAFFC05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08399585C5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302EC28C2D6;
	Thu, 10 Jul 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4Rd86GL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BBE28C852;
	Thu, 10 Jul 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135578; cv=none; b=NcSylyHzS+rMttgF8BqTM1ufh7sbtGxd+24evKnM7ZdBNtuDJYUmnTjQU3+JA+BugOs+RlVsmEDC6mGhIqV2y9M+Q4tp/DUXM9UXM56s1EgWnJATwBvD0MiR8E1z6UnM2XmU9d8o0C13BH1IrOGNkcP4K4cYr6Xea33hfm5ekjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135578; c=relaxed/simple;
	bh=ep8Eq8Ul5Jm88O24OTfGWfQ8o1w0XeUZ6vU1CQsFRfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N93TQ4wMQfrmLXSPpEXWPlxdTuME2M/SKb1jWsISNErIr8YpUu2o6ROrOLVwBqXDC/1ncHfkF4o5ugrF2zqpsUAFLedRi43JVeU/sfJx0tlowqRE+XsX5kVIX0J9rLfdpr+mCUoibuJO19WNcchH+CuKJyivSvsaROZfzJGGjfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4Rd86GL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC49C4CEE3;
	Thu, 10 Jul 2025 08:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752135575;
	bh=ep8Eq8Ul5Jm88O24OTfGWfQ8o1w0XeUZ6vU1CQsFRfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O4Rd86GLdzCSVaoCp1D9tS3nPaaxvaes5LYcaSWm7ZZBSJ3JVdRd+OFCVbhITccJL
	 XxixiLvEwXFCCL5tZVY67hky46WI5o5E08buA7VDwEJQkYSEzHej1Ww44rvNq0l8c7
	 Mi0sA27qZCP7C92YhoFnE9lILN9Ceb35eu9xCl3LmC6rbN0+HLr/AWQFnljkTn/dh/
	 Plnz/cG4aqyBnHIhfmAEQS48RPvdjchYfY1jGkgYz1SbfFMZ9YexRLEj01twSC9C35
	 JfstIxh5zKjs5ipwG63g2u8vnXeQeOIqc4wfCT9razcfFSBZvf1LQewjhXxzY+jYHI
	 4biqNjWCv9mLQ==
Date: Thu, 10 Jul 2025 10:19:31 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250710101931.202953d1@foz.lan>
In-Reply-To: <20250710091352.4ae01211@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
	<20250710084119.3e5c1ced@foz.lan>
	<20250710091352.4ae01211@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 10 Jul 2025 09:13:52 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 10 Jul 2025 08:41:19 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>=20
> > Em Wed,  2 Jul 2025 16:35:24 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  =20
> > > Building strings with repeated concatenation is somewhat inefficient =
in
> > > Python; it is better to make a list and glom them all together at the=
 end.
> > > Add a small set of methods to the OutputFormat superclass to manage t=
he
> > > output string, and use them throughout.
> > >=20
> > > Signed-off-by: Jonathan Corbet <corbet@lwn.net>   =20
> >=20
> > The patch looks good to me. Just a minor nit below.
> >  =20
> > > ---
> > >  scripts/lib/kdoc/kdoc_output.py | 185 +++++++++++++++++-------------=
--
> > >  1 file changed, 98 insertions(+), 87 deletions(-)
> > >=20
> > > diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_=
output.py
> > > index ea8914537ba0..d4aabdaa9c51 100644
> > > --- a/scripts/lib/kdoc/kdoc_output.py
> > > +++ b/scripts/lib/kdoc/kdoc_output.py
> > > @@ -73,7 +73,19 @@ class OutputFormat:
> > >          self.config =3D None
> > >          self.no_doc_sections =3D False
> > > =20
> > > -        self.data =3D ""
> > > +    #
> > > +    # Accumulation and management of the output text.
> > > +    #
> > > +    def reset_output(self):
> > > +        self._output =3D []
> > > +
> > > +    def emit(self, text):
> > > +        """Add a string to out output text"""
> > > +        self._output.append(text)
> > > +
> > > +    def output(self):
> > > +        """Obtain the accumulated output text"""
> > > +        return ''.join(self._output)   =20
> >=20
> > I would prefer to use a more Pythonic name for this function:
> >=20
> > 	def __str__(self)
> >=20
> > This way, all it takes to get the final string is to use str():
> >=20
> > 	out_str =3D str(out)
> >=20
> > With that:
> >=20
> > Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org> =20
>=20
>=20
> Hmm... actually, I would code it on a different way, using something like:
>=20
> class OutputString:
>     def __init__(self):
> 	"""Initialize internal list"""
>         self._output =3D []
>    =20
>     # Probably not needed - The code can simply do, instead:
>     # a =3D OutputString() to create a new string.
>     def reset(self):
>         """Reset the output text"""
>         self._output =3D []
>    =20
>     def __add__(self, text):
> 	"""Add a string to out output text"""
>         if not isinstance(text, str):
>             raise TypeError("Can only append strings")
>         self._output.append(text)
>         return self
>=20
>     def __str__(self):
>         return ''.join(self._output)
>    =20
>     # and, if needed, add a getter/setter:
>=20
>     @property
>     def data(self):
>         """Getter for the current output"""
>         return ''.join(self._output)
>=20
>     @data.setter
>     def data(self, new_value):
>         if isinstance(new_value, str):
> 	    self._output =3D [new_value]
> 	elif isinstance(new_value, list):
>             self._output =3D new_value
>         else:
>             raise TypeError("Value should be either list or string")
>=20
> That would allow things like:
>=20
> 	out =3D OutputString()
> 	out =3D out + "Foo" + " " + "Bar"
> 	print(out)
>=20
> 	out =3D OutputString()
> 	out +=3D "Foo"
> 	out +=3D " "
> 	out +=3D "Bar"
> 	return(str(out))
>=20
> and won't require much changes at the output logic, and IMO will
> provide a cleaner code.
>=20
> Thanks,
> Mauro

Heh, on those times where LLM can quickly code trivial things for us,
I actually decided to test 3 different variants:

- using string +=3D
- using list append
- using __add__
- using __iadd__

Except if the LLM-generated did something wrong (I double checked, and
was unable to find any issues), the results on Python 3.13.5 are:

$ /tmp/bench.py
Benchmarking 1,000 ops =C3=97 1000 strings =3D 1,000,000 appends

Run    str+=3D        ExplicitList __add__      __iadd__   =20
------------------------------------------------------------
1      25.26        29.44        53.42        50.71      =20
2      29.34        29.35        53.45        50.61      =20
3      29.44        29.56        53.41        50.67      =20
4      29.28        29.23        53.26        50.64      =20
5      29.28        29.20        45.90        40.47      =20
6      23.53        23.62        42.74        40.61      =20
7      23.43        23.76        42.97        40.78      =20
8      23.51        23.59        42.67        40.61      =20
9      23.43        23.52        42.77        40.72      =20
10     23.53        23.54        42.78        40.67      =20
11     23.83        23.63        42.98        40.87      =20
12     23.49        23.45        42.67        40.53      =20
13     23.43        23.69        42.75        40.66      =20
14     23.47        23.49        42.70        40.56      =20
15     23.44        23.63        42.72        40.52      =20
16     23.51        23.56        42.65        40.66      =20
17     23.48        23.60        42.86        40.81      =20
18     23.67        23.53        42.73        40.59      =20
19     23.75        23.62        42.78        40.58      =20
20     23.68        23.55        42.77        40.54      =20
21     23.65        23.67        42.76        40.59      =20
22     23.73        23.49        42.78        40.61      =20
23     23.61        23.59        42.78        40.58      =20
24     23.66        23.51        42.73        40.55      =20
------------------------------------------------------------
Avg    24.60        24.78        44.67        42.30      =20

Summary:
ExplicitList : 100.74% slower than str+=3D
__add__      : 181.56% slower than str+=3D
__iadd__     : 171.93% slower than str+=3D

(running it a couple of times sometimes it sometimes show list
 addition a little bit better, bu all at the +/- 1% range)

In practice, it means that my suggestion of using __add__ (or even
using the __iadd__ variant) was not good, but it also showed
that Python 3.13 implementation is actually very efficient
with str +=3D operations.

With that, I would just drop this patch, as the performance is
almost identical, and using "emit()" instead of "+=3D" IMO makes
the code less clear.

-

Btw, with Python 3.9, "".join(list) is a lot worse than str +=3D :

$ python3.9 /tmp/bench.py
Benchmarking 1,000 ops =C3=97 1000 strings =3D 1,000,000 appends

Run    str+=3D        ExplicitList __add__      __iadd__   =20
------------------------------------------------------------
1      28.27        87.24        96.03        88.81      =20
2      32.76        87.35        87.40        88.92      =20
3      32.69        85.98        73.01        70.87      =20
4      26.28        69.80        70.62        71.90      =20
5      27.21        70.54        71.04        72.00      =20
6      27.77        70.06        70.22        70.92      =20
7      27.03        69.75        70.30        70.89      =20
8      33.31        72.63        70.57        70.59      =20
9      26.33        70.15        70.27        70.97      =20
10     26.29        69.84        71.60        70.94      =20
11     26.59        69.60        70.16        71.26      =20
12     26.38        69.57        71.64        70.95      =20
13     26.41        69.89        70.11        70.85      =20
14     26.38        69.86        70.36        70.93      =20
15     26.43        69.57        70.18        70.90      =20
16     26.38        70.04        70.26        71.19      =20
17     26.40        70.02        80.50        71.01      =20
18     26.41        71.74        80.39        71.90      =20
19     28.06        69.60        71.95        70.88      =20
20     28.28        69.90        71.12        71.07      =20
21     26.34        69.74        72.42        71.02      =20
22     26.33        69.86        70.25        70.97      =20
23     26.40        69.78        71.64        71.10      =20
24     26.44        69.73        70.23        70.83      =20
------------------------------------------------------------
Avg    27.55        72.18        73.43        72.57      =20

Summary:
ExplicitList : 262.00% slower than str+=3D
__add__      : 266.54% slower than str+=3D
__iadd__     : 263.42% slower than str+=3D


Thanks,
Mauro

---

#!/usr/bin/env python3

import timeit

class ExplicitList:
    def __init__(self):
        self._output =3D []

    def emit(self, text):
        self._output.append(text)

    def output(self):
        return ''.join(self._output)

class OutputStringAdd:
    def __init__(self):
        self._output =3D []

    def __add__(self, text):
        self._output.append(text)
        return self

    def __str__(self):
        return ''.join(self._output)

class OutputStringIAdd:
    def __init__(self):
        self._output =3D []

    def __iadd__(self, text):
        self._output.append(text)
        return self

    def __str__(self):
        return ''.join(self._output)

def calculate_comparison(base_time, compare_time):
    """Returns tuple of (is_faster, percentage)"""
    if compare_time < base_time:
        return (True, (1 - compare_time/base_time)*100)
    else:
        return (False, (compare_time/base_time)*100)

def benchmark():
    N =3D 1000       # Operations
    STRINGS_PER_OP =3D 1000
    REPEATS =3D 24

    # Generate test data (1000 unique 10-character strings)
    test_strings =3D [f"string_{i:03d}" for i in range(STRINGS_PER_OP)]

    print(f"Benchmarking {N:,} ops =C3=97 {STRINGS_PER_OP} strings =3D {N*S=
TRINGS_PER_OP:,} appends\n")
    headers =3D ['Run', 'str+=3D', 'ExplicitList', '__add__', '__iadd__']
    print(f"{headers[0]:<6} {headers[1]:<12} {headers[2]:<12} {headers[3]:<=
12} {headers[4]:<12}")
    print("-" * 60)

    results =3D []

    for i in range(REPEATS):
        # Benchmark normal string +=3D
        t_str =3D timeit.timeit(
            'result =3D ""\nfor s in test_strings: result +=3D s',
            globals=3D{'test_strings': test_strings},
            number=3DN
        ) * 1000

        # Benchmark ExplicitList
        t_explicit =3D timeit.timeit(
            'obj =3D ExplicitList()\nfor s in test_strings: obj.emit(s)',
            globals=3D{'test_strings': test_strings, 'ExplicitList': Explic=
itList},
            number=3DN
        ) * 1000

        # Benchmark __add__ version
        t_add =3D timeit.timeit(
            'obj =3D OutputStringAdd()\nfor s in test_strings: obj +=3D s',
            globals=3D{'test_strings': test_strings, 'OutputStringAdd': Out=
putStringAdd},
            number=3DN
        ) * 1000

        # Benchmark __iadd__ version
        t_iadd =3D timeit.timeit(
            'obj =3D OutputStringIAdd()\nfor s in test_strings: obj +=3D s',
            globals=3D{'test_strings': test_strings, 'OutputStringIAdd': Ou=
tputStringIAdd},
            number=3DN
        ) * 1000

        results.append((t_str, t_explicit, t_add, t_iadd))
        print(f"{i+1:<6} {t_str:<12.2f} {t_explicit:<12.2f} {t_add:<12.2f} =
{t_iadd:<12.2f}")

    # Calculate averages
    avg_str =3D sum(r[0] for r in results) / REPEATS
    avg_explicit =3D sum(r[1] for r in results) / REPEATS
    avg_add =3D sum(r[2] for r in results) / REPEATS
    avg_iadd =3D sum(r[3] for r in results) / REPEATS

    print("-" * 60)
    print(f"{'Avg':<6} {avg_str:<12.2f} {avg_explicit:<12.2f} {avg_add:<12.=
2f} {avg_iadd:<12.2f}")

    print()
    print("Summary:")
    # Calculate and print comparisons
    for name, time in [("ExplicitList", avg_explicit),
                      ("__add__", avg_add),
                      ("__iadd__", avg_iadd)]:
        is_faster, percentage =3D calculate_comparison(avg_str, time)
        if is_faster:
            print(f"{name:<12} : {percentage:.2f}% faster than str+=3D")
        else:
            print(f"{name:<12} : {percentage:.2f}% slower than str+=3D")


if __name__ =3D=3D "__main__":
    benchmark()



