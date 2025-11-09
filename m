Return-Path: <linux-kernel+bounces-892080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83336C444CD
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 19:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422C43A0791
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7CF221554;
	Sun,  9 Nov 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a0GBkoTL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941A721885A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711614; cv=none; b=BSeq8xFKnaKvEfatkzwTcrzPHksAl805mZzdipXO6IeWgzFXV9z0wzNTtC3noAt3Cppt49ab/yfxuXv1GhvluEHvP1KuC8fEmXSln3ItYH74rqxbofMkfMP7htUcgNukiHkGDeuB+tRBXsZIVj9t0gQ+EJA6+Yda9sPmXNWWXOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711614; c=relaxed/simple;
	bh=Jyr7Advpmrp/1CXXyDKOLNg7W6MBf8xRQAccFc4INxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWQy8uvlrm7f2BUnHZdMGj8yuR4mzO25RPxK6TZYqXCLg1nXxGh4Fs2A6ZwEACgmkHeJrXD2lSXqF5T76bPZg/vhixNGVDVendARYAnerta2S7/P8nESyOBu7tWBgfG/GGWuB7NX7FYCVAnqeQtC3BDo18whs5wo2CkVKl9Zhf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a0GBkoTL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5552CC116B1;
	Sun,  9 Nov 2025 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762711614;
	bh=Jyr7Advpmrp/1CXXyDKOLNg7W6MBf8xRQAccFc4INxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a0GBkoTLiucisSat+h25ppOAFgAegqvUxdUtTs5Nk0rTPhy15MOS68GznbscGK5rT
	 mi+aEJadB1f7qTq2pjsoXaVgesLIKFdlr2NIExfvOYDCKvc6NJoEqWsLGSCX2Lmjh+
	 2NGQdojgnMGUR2BwCwr41SVkshdRCei2h2KnBeCeRxOHaiz6Vwc0gYJf0KVSkfTXAb
	 2kB7ylipQrRAkYtOFFB+btd7ShBG04R1Reyfh0LAYf1spO2NzfJGh0mrgWSLAB23bs
	 Nffz7yGvfL0urnkkTwWVO4tF0BOf+ZQ6frVykZAY3iWTzxzawWAXnogLuQSdq3qWPd
	 WVwVE6jVwwHtA==
Date: Sun, 9 Nov 2025 19:06:49 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/4] Add ARRAY_END(), and use it to fix off-by-one bugs
Message-ID: <cover.1762711279.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1758806023.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1758806023.git.alx@kernel.org>

ARRAY_END() is a macro to calculate a pointer to one past the last
element of an array argument.  This is a very common pointer, which is
used to iterate over all elements of an array:

        for (T *p = a; p < ARRAY_END(a); p++)
                ...

Of course, this pointer should never be dereferenced.  A pointer one
past the last element of an array should not be dereferenced; it's
perfectly fine to hold such a pointer --and a good thing to do--, but
the only thing it should be used for is comparing it with other pointers
derived from the same array.

Due to how special these pointers are, it would be good to use
consistent naming.  It's common to name such a pointer 'end' --in fact,
we have many such cases in the kernel--.  C++ even standardized this
name with std::end().  Let's try naming such pointers 'end', and try
also avoid using 'end' for pointers that are not the result of
ARRAY_END().

It has been incorrectly suggested that these pointers are dangerous, and
that they should never be used, suggesting to use something like

	#define ARRAY_LAST(a)  ((a) + ARRAY_SIZE(a) - 1)

	for (T *p = a; p <= ARRAY_LAST(a); p++)
		...

This is bogus, as it doesn't scale down to arrays of 0 elements.  In the
case of an array of 0 elements, ARRAY_LAST() would underflow the
pointer, which not only it can't be dereferenced, it can't even be held.
That would be a footgun.  Such arrays don't exist per the C standard;
however, GCC supports them as an extension (with partial support,
though; GCC has a few bugs which need to be fixed).

This patch set fixes a few places where it was intended to use the array
end (that is, one past the last element), but accidentally a pointer to
the last element was used instead, thus wasting one byte.

It also replaces other places where the array end was correctly
calculated with ARRAY_SIZE(), by using the simpler ARRAY_END().

Also, there was one drivers/ file that already defined this macro.  We
remove that definition, to not conflict with this one.

---

Hi!

Changes in v3:

-  Fix commit message.
-  Remove old definition from "drivers/block/floppy.c".
   [Reported-by: kernel test robot <lkp@intel.com>]
-  Use definition of ARRAY_END() with array notation.  There's work in
   the C committee to make array notation slightly safer than pointer
   arithmetic.


Have a lovely night!
Alex


Alejandro Colomar (4):
  array_size.h: Add ARRAY_END()
  mm: Fix benign off-by-one bugs
  kernel: Fix off-by-one benign bugs
  mm: Use ARRAY_END() instead of open-coding it

 drivers/block/floppy.c     | 2 --
 include/linux/array_size.h | 6 ++++++
 kernel/kcsan/kcsan_test.c  | 4 ++--
 mm/kfence/kfence_test.c    | 4 ++--
 mm/kmemleak.c              | 2 +-
 mm/kmsan/kmsan_test.c      | 2 +-
 mm/memcontrol-v1.c         | 4 ++--
 7 files changed, 14 insertions(+), 10 deletions(-)

Range-diff against v2:
1:  35255c1ceb54 ! 1:  2cb4ddff93b3 array_size.h: Add ARRAY_END()
    @@ Commit message
         the array argument.  This pointer is useful for iterating over the
         elements of an array:
     
    -            for (T *p = a, p < ENDOF(a); p++)
    +            for (T *p = a, p < ARRAY_END(a); p++)
                         ...
     
         Cc: Kees Cook <kees@kernel.org>
    @@ Commit message
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
         Message-ID: <37b1088dbd01a21d2f9d460aa510726119b3bcb0.1752193588.git.alx@kernel.org>
     
    + ## drivers/block/floppy.c ##
    +@@ drivers/block/floppy.c: static void floppy_release_allocated_regions(int fdc, const struct io_region *p)
    + 	}
    + }
    + 
    +-#define ARRAY_END(X) (&((X)[ARRAY_SIZE(X)]))
    +-
    + static int floppy_request_regions(int fdc)
    + {
    + 	const struct io_region *p;
    +
      ## include/linux/array_size.h ##
     @@
       */
    @@ include/linux/array_size.h
     + * ARRAY_END - get a pointer to one past the last element in array @a
     + * @a: array
     + */
    -+#define ARRAY_END(a)  (a + ARRAY_SIZE(a))
    ++#define ARRAY_END(a)  (&(a)[ARRAY_SIZE(a)])
     +
      #endif  /* _LINUX_ARRAY_SIZE_H */
2:  acd8bcbb05d3 = 2:  831155f02bec mm: Fix benign off-by-one bugs
3:  781cce547eb2 = 3:  d8128f0c8b9f kernel: Fix off-by-one benign bugs
4:  094878542457 = 4:  9646a1d194a5 mm: Use ARRAY_END() instead of open-coding it
-- 
2.51.0


