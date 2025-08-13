Return-Path: <linux-kernel+bounces-766307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C1CB244DF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E20D3AFADD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 09:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F812EE5FE;
	Wed, 13 Aug 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abdePrQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295AA2D5A14;
	Wed, 13 Aug 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755075740; cv=none; b=KEv4drnD5qTN9xDy/m6UmiO6njo81S0uLk4sgALROa7nQh0XRu5SKh2iudXIspG39LbUr/2bHVoEKDJqf0bTsf5yVNqmGSgKz0EyNaeXQ7SVTUof7IOPS3uoOv0vPuT3pDR3Jw3J6iF2CS/L0Cj5ldKYDBiVlhu4+qsxG3w+D2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755075740; c=relaxed/simple;
	bh=h+p/fSpmB+ipwZsfm4b5k67r69UE7hzZ+uGkLTG7blA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZ8P32p5kafnDuIa5a1WeVCuic5eX3NMUt/Aasu0x7Sc+74mshWOoANEnkTsXVtg2hVAsY1g+JUB2Gw8IEyh0Sn8XfcikCk0tzrvOASHoYcs/aGfIzGEqt/08qWuCvMntEJqorDrMZ52nQESM9La7h8VSAcjvWDxOFEfn15mwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abdePrQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AB6C4CEEB;
	Wed, 13 Aug 2025 09:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755075739;
	bh=h+p/fSpmB+ipwZsfm4b5k67r69UE7hzZ+uGkLTG7blA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=abdePrQ4VU4UKdp0JnKF+VbzFmtaNUWikLqrKF5iLiKwDV3Ess2c6W9wSnvYSUJnD
	 6DhTjUrgdVqD35Kg+Ly3QWUQ7UPa6mFDizQI6EctpVt2TQn+NMidsNzGiQkManlQxf
	 ShAeHAUke91AFfd7KdnysjCGCGzKUWo0yDtdpRDv/OPjLWfOBasD+ZKOfuMz6ykukh
	 i1dkXt7IymSioTYKBHer4XSXEoBoXIHLST9MFYDV8SkFKgPCgwSAnbQJtoO9USKHiH
	 jkPb5C4Fdln5Hp+Lbpm1XBMilvUGvxqZwOdTEppffvAJwW+t4nAQHas7cinlJOYp3a
	 MOKnnLWZkeXlQ==
Date: Wed, 13 Aug 2025 11:02:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 6/7] docs: kdoc: tighten up the pointer-to-function case
Message-ID: <20250813110214.4da8553c@foz.lan>
In-Reply-To: <87a544ceh0.fsf@trenco.lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-7-corbet@lwn.net>
	<20250813003902.2fc82b54@foz.lan>
	<87a544ceh0.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 17:22:35 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > On Tue, 12 Aug 2025 13:57:47 -0600
> > Jonathan Corbet <corbet@lwn.net> wrote:
> >  
> >> -                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\].]*)\s*\)')
> >> +                r = KernRe(r'[^\(]+\(\*?\s*' r'([\w\[\].]*)' r'\s*\)')  
> >
> > Heh, it took me a couple of seconds to understand this concat, as I haven't
> > seem concat pattern like that before (maybe except for some old C book
> > I read a millennium ago that I barely remember).  So, IMO, it became harder
> > to understand this way. I would either remove the extra two ' r' from the
> > string or write it as:
> >
> >                r = KernRe(r'[^\(]+\(\*?\s*' 
> > 			  r'([\w\[\].]*)'
> > 			  r'\s*\)')  
> 
> By remove the " r" you mean glom the pieces back together into a single
> string?  These long regexes are hard to make sense of, I do think it
> helps to break them into logical chunks.

At least for me, it doesn't make much difference: I still need to
read the entire thing to understand what it does. The extra ' r' in
the middle of it, adds extra noise.

> Certainly I can split it across multiple lines if that helps.

It is OK to split on multiple lines. 

Btw, I tried to use re.X:
	https://docs.python.org/3/library/re.html#re.X

on one of the most complex regexes, which would be the standard way to 
document complex regular expression (Perl had some using x flag), but
it didn't work.

Still, I think that we should aim to have something similar to it,
e.g.:

                r = KernRe(r'[^\(]+\(\*?\s*'  # some explanation
 			   r'([\w\[\].]*)'    # some explanation
 			   r'\s*\)')          # some explanation  

for the most complex ones.

---

Side note: reading just this out of the context - as one would do
when reviewing such patch makes is hard for one to tell exactly
what c prototype patterns the above is trying to catch.

Adding some explanation for the pattern may help, but, IMO, we should 
go one step further and create something like the enclosed unittest
logic (placed at tools/docs or tools/docs_unittest).

Before merging kernel-doc patches (and/or inside a CI job), run the
unit test to check if this won't break anything.

I suspect that creating something like this won't be that hard,
as we can modify kernel-doc command line to generate a list of
all cases it currently handles, storing the original kernel-doc
macro. Then, ask some LLM to clean it up, dropping cases that
have the same pattern.


Thanks,
Mauro

---

The code below is just a prototype. On its current version, the
tests run, but them all fail. My main goal here is just to give you
a more precise example of the kind of tool I'm thinking. If you
think it is worth, I can work on it later on.

Btw, I have somewhere on my internal scripts a replacement method for 
unittest.main() that provides a better summary when verbose is disabled
and have a command line argument to enable verbose. If we're willing
to do that, I'll add it to the final patchset.


#!/usr/bin/env python3
# SPDX-License-Identifier: GPL-2.0
# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
# Generated with the help of DeepSeek / Deepthink (R1)

import argparse
import logging
import os
import tempfile
import unittest
import sys

from textwrap import dedent

# Import KernelDoc parser class
SRC_DIR = os.path.dirname(os.path.realpath(__file__))
LIB_DIR = "../../scripts/lib/kdoc"

sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))

from kdoc_parser import KernelDoc


TEST_CASES = [
    # 1. Basic function parsing
    {
        "input": dedent("""
            /**
             * simple_function - Basic function
             * @param: Description
             */
            void simple_function(int param)
        """),
        "expected": {
            "identifier": "simple_function",
            "return_type": "void",
            "func_macro": False
        }
    },

    # 2. Static prefix stripping (pattern: r"^static +")
    {
        "input": dedent("""
            /**
             * static_fn - Static function
             * @arg: String argument
             */
            static int static_fn(char *arg)
        """),
        "expected": {
            "identifier": "static_fn",
            "return_type": "int",
            "func_macro": False
        }
    },

    # 3. Function macro (#define)
    {
        "input": dedent("""
            /**
             * macro_func() - Macro function
             * @a: First param
             */
            #define macro_func(a) do_something(a)
        """),
        "expected": {
            "identifier": "macro_func",
            "return_type": "",
            "func_macro": True
        }
    },

    # 4. Complex return type
    {
        "input": dedent("""
            /**
             * complex_return - Long return type
             * Returns: Pointer to foo structure
             */
            struct foo *complex_return(void)
        """),
        "expected": {
            "identifier": "complex_return",
            "return_type": "struct foo *",
            "func_macro": False
        }
    },

    # 5. __attribute_const__ stripping (pattern: r"__attribute_const__ +")
    {
        "input": dedent("""
            /**
             * const_attr - Function with const attribute
             */
            __attribute_const__ int const_attr(void)
        """),
        "expected": {
            "identifier": "const_attr",
            "return_type": "int",
            "func_macro": False
        }
    },

    # 6. __printf attribute stripping (pattern: r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +")
    {
        "input": dedent("""
            /**
             * printf_fn - Printf-style function
             * @fmt: Format string
             * @...: Variable arguments
             */
            __printf(2, 3) int printf_fn(const char *fmt, ...)
        """),
        "expected": {
            "identifier": "printf_fn",
            "return_type": "int",
            "func_macro": False
        }
    },

    # 7. Multiple prefixes (static + inline)
    {
        "input": dedent("""
            /**
             * multi_prefix - Multiple prefixes
             */
            static __always_inline int multi_prefix(int a)
        """),
        "expected": {
            "identifier": "multi_prefix",
            "return_type": "int",
            "func_macro": False
        }
    },

    # 8. DECL_BUCKET_PARAMS handling
    {
        "input": dedent("""
            /**
             * bucket_fn - Bucket params function
             */
            DECL_BUCKET_PARAMS(a, b) void bucket_fn(void)
        """),
        "expected": {
            "identifier": "bucket_fn",
            "return_type": "void",
            "func_macro": False
        }
    },

    # 9. Function pointer parameter
    {
        "input": dedent("""
            /**
             * fp_param - Function with callback
             * @cb: Callback function
             */
            void fp_param(int (*cb)(int))
        """),
        "expected": {
            "identifier": "fp_param",
            "return_type": "void",
            "func_macro": False
        }
    },

    # 10. Malformed prototype (error case)
    {
        "input": dedent("""
            /**
             * bad_func - Bad prototype
             */
            int bad_func(missing_paren int a
        """),
        "expected": {
            "expected_error": "cannot understand function prototype: 'int bad_func(missing_paren int a'"
        }
    },

    # 11. Name mismatch (error case)
    {
        "input": dedent("""
            /**
             * expected_name - Wrong prototype
             */
            void actual_name(void)
        """),
        "expected": {
            "expected_error": "expecting prototype for expected_name(). Prototype was for actual_name() instead"
        }
    },

    # 12. No kernel-doc comment (edge case)
    {
        "input": "void undocumented_func(void)",
        "expected": {
            "expected_error": "missing kernel-doc comment"
        }
    },

    # Add a lot more here
]

class TestKernelDocParsing(unittest.TestCase):
    """Dynamically generated test cases for kernel-doc parsing"""

    def setUp(self):
        self.config = argparse.Namespace()
        self.config.verbose = False
        self.config.werror = False
        self.config.wreturn = False
        self.config.wshort_desc = False
        self.config.wcontents_before_sections = False
        self.config.log = logging.getLogger("kernel-doc-test")
        self.config.src_tree = None

def make_test_function(input_str, expected):
    """Factory function to create kernel-doc test cases with file handling"""
    def test(self):
        # Create temp file with test content
        with tempfile.NamedTemporaryFile(mode='w+', delete=False) as tmp:
            tmp.write(input_str)
            tmp_path = tmp.name

        try:
            # Initialize parser with the temp file
            doc = KernelDoc(self.config, tmp_path)

            # FIXME: this part still need adjustments
            export_table, entries = doc.parse_kdoc()

            # Verify parsing results
            if "expected_error" in expected:
                self.fail(f"Expected error but parsing succeeded: {input_str}")

            # Find our test entry (assuming single entry for simplicity)
            test_entry = next((e for e in entries if e.identifier == expected["identifier"]), None)
            self.assertIsNotNone(test_entry, f"Expected entry not found for: {input_str}")

            # Validate results
            self.assertEqual(test_entry.return_type, expected["return_type"],
                            f"Return type mismatch for: {input_str}")
            self.assertEqual(getattr(test_entry, 'func_macro', False), expected["func_macro"],
                            f"Function macro flag mismatch for: {input_str}")

        except Exception as e:
            if "expected_error" not in expected:
                raise
            self.assertIn(expected["expected_error"], str(e),
                         f"Expected error not found in: {str(e)}")
        finally:
            # Clean up temp file
            if os.path.exists(tmp_path):
                os.unlink(tmp_path)

    return test

# Dynamically add test methods to the TestCase class
# This has to be outside __main__
for i, test_case in enumerate(TEST_CASES):
    test_name = f"test_case_{i+1:02d}"
    if "identifier" in test_case["expected"]:
        test_name += f"_{test_case['expected']['identifier']}"
    elif "expected_error" in test_case["expected"]:
        test_name += "_error_case"

    test_func = make_test_function(test_case["input"], test_case["expected"])
    setattr(TestKernelDocParsing, test_name, test_func)

if __name__ == "__main__":
    unittest.main()



