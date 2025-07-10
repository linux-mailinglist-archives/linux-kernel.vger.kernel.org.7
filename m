Return-Path: <linux-kernel+bounces-725456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D45AFFF56
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020381886B94
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E72628B7C9;
	Thu, 10 Jul 2025 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzH5hYqJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F21119CC28;
	Thu, 10 Jul 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143520; cv=none; b=JfvlPTICssVZBgB6XtZU6asgPmlZL1d4lRMpRfuinko161e7HD8jBco6NFImMA2FG19W4/D0hPKLJVqUMVUtZJ+UqJEj1b2NsmpS9iuYF0r0ch3LU0+LU3YFY4tQDU1LRcAziHQGreeFWeJUvmqVQp4NrGsJVVbyUWDRUhvtEdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143520; c=relaxed/simple;
	bh=WMgjjmkjy+Mq6iqOOm4Jpqjda2TzLBHPu7Kt0XFUo4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXT6AjScXgs8lW4NnSMaWAPc6hR4o0zEPGrNxKUQId7L2UQ6y+23ctwOFs8sKXmcGNODy3WMW/Th8TfMCn6v/iAb8w21TcFvvmF7bamR65K8GtGJKaaL1RK7PA7KwqxZIXrKYARS3O5RYmF7PU+xhapQw1fr0ijj5ZVNNH85ar0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzH5hYqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD290C4CEE3;
	Thu, 10 Jul 2025 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752143519;
	bh=WMgjjmkjy+Mq6iqOOm4Jpqjda2TzLBHPu7Kt0XFUo4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OzH5hYqJXQscepER85OG/O8fwFsd5j3sxkShS6mBktptBE73HVrRRk7sAdHz/O6dl
	 hQ92DyMEkdTtuervypikSm6Kjhkppe3IaYJaH5/sd/RjcQ0Dpg3Uru478sUHusr3Mf
	 9m0EC5b+xVGvp4hJEBlkCMticELI9LTo0PtgXUBl9XGfHyAEESXAPobGol57NzbYJF
	 NKQO73UrW/mAZWR8ruoM2svOZjndP6wjQsJuwSI/KJ81HCuEHcz55MhEvTM5SEjhaD
	 g8DvmHS+08hwn4H9twdwr1PKjP25n763EyRM+iI1GqBfKzBNbU2FqvbgmhzGiZRh/7
	 VxelM/9YNMKiw==
Date: Thu, 10 Jul 2025 12:31:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250710123155.1045831d@foz.lan>
In-Reply-To: <20250710121033.42db5ef3@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
	<20250710084119.3e5c1ced@foz.lan>
	<20250710091352.4ae01211@foz.lan>
	<20250710101931.202953d1@foz.lan>
	<20250710121033.42db5ef3@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 12:10:33 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> From the above:
> 
> - It is not worth applying patch 12/12 as it makes the code slower;
> - Python 3.13t (no-GIL version) had very bad results. It seems it
>   still requires optimization;
> - Python 3.9 is a lot worse (140% to 190%) when using list append;
> - when there are not many concats, Python 3.13 is about 15% slower
>   with lists than concat strings. It only approaches str concat
>   when the number of concats is high.
> 
> With the above, clearly str += is faster than list append.
> 
> So, except if I did something wrong on this benchmark script, please
> don't apply patch 12/12.

And I did: I forgot the final line at the concat code to get the
result as strings.

For explicit list:
	result = obj.output()

For implicit ones:
	result = str(obj)

Yet, the conclusion is similar. With Python 3.13:

    $ for i in python3.13; do for j in 1 10 100 1000; do $i /tmp/bench.py $((1000000/$j)) $j 1; done; done
    1 strings in a loop with 1000000 interactions, repeating 24 times
        str +=       : time: 41.42
        list join    : time: 127.33: 207.42% slower than str +=
    10 strings in a loop with 100000 interactions, repeating 24 times
        str +=       : time: 27.15
        list join    : time: 39.19: 44.36% slower than str +=
    100 strings in a loop with 10000 interactions, repeating 24 times
        str +=       : time: 24.84
        list join    : time: 30.70: 23.57% slower than str +=
    1000 strings in a loop with 1000 interactions, repeating 24 times
        str +=       : time: 21.84
        list join    : time: 27.85: 27.50% slower than str +=

Explict list concat was between ~30% to ~200% worse than str concat.


Thanks,
Mauro

---

#!/usr/bin/env python3

import argparse
import time
import sys

def benchmark_str_concat(test_strings, n_ops):
    start = time.time()
    for _ in range(n_ops):
        result = ""
        for s in test_strings:
            result += s
    return (time.time() - start) * 1000

def benchmark_explicit_list(test_strings, n_ops):
    class ExplicitList:
        def __init__(self):
            self._output = []

        def emit(self, text):
            self._output.append(text)

        def output(self):
            return ''.join(self._output)

    start = time.time()
    for _ in range(n_ops):
        obj = ExplicitList()
        for s in test_strings:
            obj.emit(s)

        result = obj.output()

    return (time.time() - start) * 1000

def benchmark_add_overload(test_strings, n_ops):
    class OutputStringAdd:
        def __init__(self):
            self._output = []

        def __add__(self, text):
            self._output.append(text)
            return self

        def __str__(self):
            return ''.join(self._output)

    start = time.time()
    for _ in range(n_ops):
        obj = OutputStringAdd()
        for s in test_strings:
            obj += s

        result = str(obj)

    return (time.time() - start) * 1000

def benchmark_iadd_overload(test_strings, n_ops):
    class OutputStringIAdd:
        def __init__(self):
            self._output = []

        def __iadd__(self, text):
            self._output.append(text)
            return self

        def __str__(self):
            return ''.join(self._output)

    start = time.time()
    for _ in range(n_ops):
        obj = OutputStringIAdd()
        for s in test_strings:
            obj += s
        result = str(obj)

    return (time.time() - start) * 1000

def calculate_comparison(base_time, compare_time):
    if compare_time < base_time:
        return (True, (1 - compare_time/base_time)*100)
    return (False, (compare_time/base_time - 1)*100)

def benchmark(num_reps, strings_per_run, repeats, detail):
    test_strings = [f"string_{i:03d}" for i in range(strings_per_run)]

    # Create benchmark execution order list
    benchmarks = [
        ("str +=", benchmark_str_concat),
        ("list join", benchmark_explicit_list),
        ("__add__", benchmark_add_overload),
        ("__iadd__", benchmark_iadd_overload)
    ]

    # Use all possible permutations of benchmark order to reduce any
    # noise due to CPU caches
    all_orders = [
        (0, 1, 2, 3), (0, 1, 3, 2), (0, 2, 1, 3), (0, 2, 3, 1),
        (0, 3, 1, 2), (0, 3, 2, 1), (1, 0, 2, 3), (1, 0, 3, 2),
        (1, 2, 0, 3), (1, 2, 3, 0), (1, 3, 0, 2), (1, 3, 2, 0),
        (2, 0, 1, 3), (2, 0, 3, 1), (2, 1, 0, 3), (2, 1, 3, 0),
        (2, 3, 0, 1), (2, 3, 1, 0), (3, 0, 1, 2), (3, 0, 2, 1),
        (3, 1, 0, 2), (3, 1, 2, 0), (3, 2, 0, 1), (3, 2, 1, 0)
    ]

    results = {}
    for name, _ in benchmarks:
        results[name] = 0

    # Warm-up phase to reduce caching issues
    for name, fn in benchmarks:
        fn(test_strings, 1)

    n_repeats = len(all_orders) * repeats
    print(f"    {strings_per_run} strings in a loop with {num_reps} interactions, repeating {n_repeats} times")

    # Actual benchmark starts here
    i = 0
    if detail:
        headers = ['Run'] + [name for name, _ in benchmarks]
        print()
        print(f"\t{headers[0]:<6} {headers[1]:<12} {headers[2]:<12} {headers[3]:<12} {headers[4]:<12}")
        print("\t" + "-" * 60)
    for _ in range(repeats):
        # Shuffle execution order each run
        for order in all_orders:
            run_results = {}
            for idx in order:
                name, func = benchmarks[idx]
                run_results[name] = func(test_strings, num_reps)
                results[name] += run_results[name]

            if detail:
                # Output results in consistent order
                print(f"\t{i+1:<6}", end=" ")
                for name, _ in benchmarks:
                    print(f"{run_results[name]:<12.2f}", end=" ")
                print()

            i += 1

    avg_results = {}
    for name, _ in benchmarks:
        avg_results[name] = results[name] / repeats / len(all_orders)

    if detail:
        print("\t" + "-" * 60)
        print(f"\t      ", end=" ")
        for name, _ in benchmarks:
            print(f"{avg_results[name]:<12.2f}", end=" ")
        print()
        print()

    ref = benchmarks.pop(0)

    print(f"\t{ref[0]:<12} : time: {avg_results[ref[0]]:3.2f}")
    for name, _ in benchmarks:
        is_faster, percentage = calculate_comparison(avg_results[ref[0]], avg_results[name])
        direction = "faster" if is_faster else "slower"
        print(f"\t{name:<12} : time: {avg_results[name]:3.2f}: {percentage:3.2f}% {direction} than {ref[0]}")



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--detail', action='store_true',
                       help='Enable detailed output')

    args, remaining = parser.parse_known_args()

    # Then handle the positional arguments manually
    if len(remaining) != 3:
        print(f"Usage: {sys.argv[0]} [-d] <num_repetitions> <strings_per_op> <repeats>")
        sys.exit(1)

    num_reps = int(remaining[0])
    strings_per_op = int(remaining[1])
    repeats = int(remaining[2])

    num_reps = int(sys.argv[1])
    strings_per_op = int(sys.argv[2])
    repeats = int(sys.argv[3])

    benchmark(num_reps, strings_per_op, repeats, args.detail)




