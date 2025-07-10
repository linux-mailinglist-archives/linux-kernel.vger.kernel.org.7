Return-Path: <linux-kernel+bounces-725414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7B5AFFEC6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9D7916CD05
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C32D5C90;
	Thu, 10 Jul 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3gFOjpq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A02D5C82;
	Thu, 10 Jul 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142239; cv=none; b=WCyL2DZsTIP3MDSuOrPPWOc0iJ+/KULh3nLafVepYIJRG3WCZ0h5CYgUdDIVpjyBs1T/idTPBUbik1US2S3izcwJ2D0OP5EapIv3mdtyuG1Gfw/wLmNVAPAiEef9BoLoyURcFQ/PCxy5ippso5NQZ+TapYE6EsErHavf4dxHTlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142239; c=relaxed/simple;
	bh=EFAbvbz4kgzNcghP/5fX0eFqMXfR6XRR/Ibwqj/hjzg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uM182/qtNwMtBObQxzK7OTU54Ve6Zb8uRy8zTCklxNezco5MACBwrrTqMyO3WQ0qUpUdXsP+N3B3c+LIaDZOdRzseQgBMUCSsCYgGFjoD7RIiv/O5nq1bRKTQu3X0HwK6xJpaw2Z6HSmm/1NJA/E8uE1lmPt4XbrZqZ9RYjFnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3gFOjpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D8C4CEE3;
	Thu, 10 Jul 2025 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752142238;
	bh=EFAbvbz4kgzNcghP/5fX0eFqMXfR6XRR/Ibwqj/hjzg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h3gFOjpq0IY09WV+esonaR0N2BuUvgHz6iz1Sf8uLgYeseaCYFfyqUu8rP4HXsxST
	 Fd9qBZzSHspPfzMlXVHw7VxUVBMMvm3l2awbMVbxr9JccMSmXErSJmNH1+m5SoBj/n
	 5GjLrRhEgdAiZCqzosWkfNtjf+wnLH4KE8YCrB+7mZj55ju/jeZ6/6hqdVqV0P9zxo
	 v5Y2rtc9QBUOrvULy+vu3IkurOcyMtoTwkB9qvx8hF8GqdwBSrEJuA/7FX8/ePQzDN
	 9wL3i6ZFESEX9/c8hlC6oh4r3Tc5DpbH7KCHjksZY/ksds1bFYRt5chc9Qoq41vksq
	 LBGUN6tCzsRUg==
Date: Thu, 10 Jul 2025 12:10:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250710121033.42db5ef3@foz.lan>
In-Reply-To: <20250710101931.202953d1@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
	<20250710084119.3e5c1ced@foz.lan>
	<20250710091352.4ae01211@foz.lan>
	<20250710101931.202953d1@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Thu, 10 Jul 2025 10:19:31 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 10 Jul 2025 09:13:52 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:
>=20

> Heh, on those times where LLM can quickly code trivial things for us,
> I actually decided to test 3 different variants:
>=20
> - using string +=3D
> - using list append
> - using __add__
> - using __iadd__

Manually reorganized the LLM-generated code, in order to get more
precise results. Script enclosed at the end.

  $ for i in python3.9 python3.13 python3.13t; do echo "  $i:"; $i /tmp/ben=
ch.py 100000 10 1; $i /tmp/bench.py 1000 1000 1; done
  python3.9:
    10 strings in a loop with 100000 interactions, repeating 24 times
        str +=3D       : time: 25.21
        list join    : time: 72.65: 188.18% slower than str +=3D
        __add__      : time: 71.82: 184.88% slower than str +=3D
        __iadd__     : time: 67.84: 169.09% slower than str +=3D
    1000 strings in a loop with 1000 interactions, repeating 24 times
        str +=3D       : time: 24.29
        list join    : time: 58.76: 141.88% slower than str +=3D
        __add__      : time: 58.68: 141.54% slower than str +=3D
        __iadd__     : time: 55.48: 128.37% slower than str +=3D
  python3.13:
    10 strings in a loop with 100000 interactions, repeating 24 times
        str +=3D       : time: 28.01
        list join    : time: 32.46: 15.91% slower than str +=3D
        __add__      : time: 52.56: 87.66% slower than str +=3D
        __iadd__     : time: 58.69: 109.55% slower than str +=3D
    1000 strings in a loop with 1000 interactions, repeating 24 times
        str +=3D       : time: 22.03
        list join    : time: 23.38: 6.12% slower than str +=3D
        __add__      : time: 44.25: 100.86% slower than str +=3D
        __iadd__     : time: 40.70: 84.74% slower than str +=3D
  python3.13t:
    10 strings in a loop with 100000 interactions, repeating 24 times
        str +=3D       : time: 25.65
        list join    : time: 74.95: 192.18% slower than str +=3D
        __add__      : time: 83.04: 223.71% slower than str +=3D
        __iadd__     : time: 79.07: 208.23% slower than str +=3D
    1000 strings in a loop with 1000 interactions, repeating 24 times
        str +=3D       : time: 57.39
        list join    : time: 62.31: 8.58% slower than str +=3D
        __add__      : time: 70.65: 23.10% slower than str +=3D
        __iadd__     : time: 68.67: 19.65% slower than str +=3D

=46rom the above:

- It is not worth applying patch 12/12 as it makes the code slower;
- Python 3.13t (no-GIL version) had very bad results. It seems it
  still requires optimization;
- Python 3.9 is a lot worse (140% to 190%) when using list append;
- when there are not many concats, Python 3.13 is about 15% slower
  with lists than concat strings. It only approaches str concat
  when the number of concats is high.

With the above, clearly str +=3D is faster than list append.

So, except if I did something wrong on this benchmark script, please
don't apply patch 12/12.

Regards,
Mauro

---

Benchmark code:

#!/usr/bin/env python3

import argparse
import time
import sys

def benchmark_str_concat(test_strings, n_ops):
    start =3D time.time()
    for _ in range(n_ops):
        result =3D ""
        for s in test_strings:
            result +=3D s
    return (time.time() - start) * 1000

def benchmark_explicit_list(test_strings, n_ops):
    class ExplicitList:
        def __init__(self):
            self._output =3D []

        def emit(self, text):
            self._output.append(text)

        def output(self):
            return ''.join(self._output)

    start =3D time.time()
    for _ in range(n_ops):
        obj =3D ExplicitList()
        for s in test_strings:
            obj.emit(s)
    return (time.time() - start) * 1000

def benchmark_add_overload(test_strings, n_ops):
    class OutputStringAdd:
        def __init__(self):
            self._output =3D []

        def __add__(self, text):
            self._output.append(text)
            return self

        def __str__(self):
            return ''.join(self._output)

    start =3D time.time()
    for _ in range(n_ops):
        obj =3D OutputStringAdd()
        for s in test_strings:
            obj +=3D s
    return (time.time() - start) * 1000

def benchmark_iadd_overload(test_strings, n_ops):
    class OutputStringIAdd:
        def __init__(self):
            self._output =3D []

        def __iadd__(self, text):
            self._output.append(text)
            return self

        def __str__(self):
            return ''.join(self._output)

    start =3D time.time()
    for _ in range(n_ops):
        obj =3D OutputStringIAdd()
        for s in test_strings:
            obj +=3D s
    return (time.time() - start) * 1000

def calculate_comparison(base_time, compare_time):
    if compare_time < base_time:
        return (True, (1 - compare_time/base_time)*100)
    return (False, (compare_time/base_time - 1)*100)

def benchmark(num_reps, strings_per_run, repeats, detail):
    test_strings =3D [f"string_{i:03d}" for i in range(strings_per_run)]

    # Create benchmark execution order list
    benchmarks =3D [
        ("str +=3D", benchmark_str_concat),
        ("list join", benchmark_explicit_list),
        ("__add__", benchmark_add_overload),
        ("__iadd__", benchmark_iadd_overload)
    ]

    # Use all possible permutations of benchmark order to reduce any
    # noise due to CPU caches
    all_orders =3D [
        (0, 1, 2, 3), (0, 1, 3, 2), (0, 2, 1, 3), (0, 2, 3, 1),
        (0, 3, 1, 2), (0, 3, 2, 1), (1, 0, 2, 3), (1, 0, 3, 2),
        (1, 2, 0, 3), (1, 2, 3, 0), (1, 3, 0, 2), (1, 3, 2, 0),
        (2, 0, 1, 3), (2, 0, 3, 1), (2, 1, 0, 3), (2, 1, 3, 0),
        (2, 3, 0, 1), (2, 3, 1, 0), (3, 0, 1, 2), (3, 0, 2, 1),
        (3, 1, 0, 2), (3, 1, 2, 0), (3, 2, 0, 1), (3, 2, 1, 0)
    ]

    results =3D {}
    for name, _ in benchmarks:
        results[name] =3D 0

    # Warm-up phase to reduce caching issues
    for name, fn in benchmarks:
        fn(test_strings, 1)

    n_repeats =3D len(all_orders) * repeats
    print(f"    {strings_per_run} strings in a loop with {num_reps} interac=
tions, repeating {n_repeats} times")

    # Actual benchmark starts here
    i =3D 0
    if detail:
        headers =3D ['Run'] + [name for name, _ in benchmarks]
        print()
        print(f"\t{headers[0]:<6} {headers[1]:<12} {headers[2]:<12} {header=
s[3]:<12} {headers[4]:<12}")
        print("\t" + "-" * 60)
    for _ in range(repeats):
        # Shuffle execution order each run
        for order in all_orders:
            run_results =3D {}
            for idx in order:
                name, func =3D benchmarks[idx]
                run_results[name] =3D func(test_strings, num_reps)
                results[name] +=3D run_results[name]

            if detail:
                # Output results in consistent order
                print(f"\t{i+1:<6}", end=3D" ")
                for name, _ in benchmarks:
                    print(f"{run_results[name]:<12.2f}", end=3D" ")
                print()

            i +=3D 1

    avg_results =3D {}
    for name, _ in benchmarks:
        avg_results[name] =3D results[name] / repeats / len(all_orders)

    if detail:
        print("\t" + "-" * 60)
        print(f"\t      ", end=3D" ")
        for name, _ in benchmarks:
            print(f"{avg_results[name]:<12.2f}", end=3D" ")
        print()
        print()

    ref =3D benchmarks.pop(0)

    print(f"\t{ref[0]:<12} : time: {avg_results[ref[0]]:3.2f}")
    for name, _ in benchmarks:
        is_faster, percentage =3D calculate_comparison(avg_results[ref[0]],=
 avg_results[name])
        direction =3D "faster" if is_faster else "slower"
        print(f"\t{name:<12} : time: {avg_results[name]:3.2f}: {percentage:=
3.2f}% {direction} than {ref[0]}")



if __name__ =3D=3D "__main__":
    parser =3D argparse.ArgumentParser()
    parser.add_argument('-d', '--detail', action=3D'store_true',
                       help=3D'Enable detailed output')

    args, remaining =3D parser.parse_known_args()

    # Then handle the positional arguments manually
    if len(remaining) !=3D 3:
        print(f"Usage: {sys.argv[0]} [-d] <num_repetitions> <strings_per_op=
> <repeats>")
        sys.exit(1)

    num_reps =3D int(remaining[0])
    strings_per_op =3D int(remaining[1])
    repeats =3D int(remaining[2])

    num_reps =3D int(sys.argv[1])
    strings_per_op =3D int(sys.argv[2])
    repeats =3D int(sys.argv[3])

    benchmark(num_reps, strings_per_op, repeats, args.detail)


