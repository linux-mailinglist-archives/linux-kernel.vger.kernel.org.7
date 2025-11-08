Return-Path: <linux-kernel+bounces-891723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 225DCC43543
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09C314E30C0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A2283FE5;
	Sat,  8 Nov 2025 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIvaghjJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB9E15667D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640424; cv=none; b=gT2lhO6LoMsblb58d2HjtSBf7rQHZm8VQY9ZflzWzXvaUx4E/m6ZHUgadhxL+NudGtO+5hx72Gr03Xi0TCi/CkVSdw0YzVtTTB9N/YdmFcUOY5Sh57oAlf8UYaUxgTdtCy3xTCEKyZRwjDTGWrk4qV5jPpA4bdfGpCxF1E61MXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640424; c=relaxed/simple;
	bh=Pm/DxhbDb4cY3sNJJXvwLPHrxcnuKprInC7CbE5rkL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TP+pIrPeuq5E2/vU9GdWTG7xqMosSI91rZzkVyGDgK27Le2UYx983Z2NL/eMrwqmuhmeGyZ4S0zV/bxrM/7W+2zsJIrm3d88OLc0mkAoAb4ICALObVHPN/8Z83YJvccpvKdk8X5wO+Y9v9UT0sZF6OJWvPY3TW3nBvj/qVjXhqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIvaghjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48A60C116D0;
	Sat,  8 Nov 2025 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762640424;
	bh=Pm/DxhbDb4cY3sNJJXvwLPHrxcnuKprInC7CbE5rkL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIvaghjJynxhsOKVfbHVBl6BqCEiDQk9mt6k3DPqdnmgwRSlOnOWkeuqYqcukh1fX
	 btIkGINQVGffwyRiOMIVsqmMib0Kgd3ttDFYfTPxC6JwF57CDGSwAt8GQwzG8HNHGG
	 /kPg8dNR+WCu2uMQ2MWpCFFdryat59JoNIYIRSanXDq1cEVHC8TiwmcDnHhYQHzZrN
	 DETBykGa3pGGv3/+PBmoNEKZJ32vwENJ/TSHhpFlKvlT0CM8cTRNvidPvw5LwSiuoX
	 32jARqDt9BOwKEbDDKUoTH+YVuvCSmIFA0YUAmpA3wEl8U6U8lNiBY2VTQZ7Iu7U1F
	 mv4CT6Fbi9NUw==
Date: Sat, 8 Nov 2025 23:20:19 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/4] Add ARRAY_END(), and use it to fix off-by-one bugs
Message-ID: <cover.1762637046.git.alx@kernel.org>
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
that they should never be used, suggesting to use

	a + ARRAY_SIZE(a) - 1

instead, with <= instead of <.  This is bogus, as it doesn't scale down
to arrays of 0 elements.  Such arrays don't exist per the C standard;
however, GCC supports them as an extension (with partial support,
though; GCC has a few bugs which need to be fixed).

---

Hi!

This v2 has the following changes compared to v1:

-  Rebase on top of v6.18-rc4.
-  Rename ENDOF() => ARRAY_END(), for consistency with ARRAY_SIZE().
   [Reported-by: Andrew Morton]
-  Add a useful cover letter.  [Reported-by: Andrew Morton]
-  Add a fourth commit, replacing all cases of a+ARRAY_SIZE(a) in mm/ by
   ARRAY_END(a).

See the range-diff below.


Have a lovely day!
Alex


Alejandro Colomar (4):
  array_size.h: Add ARRAY_END()
  mm: Fix benign off-by-one bugs
  kernel: Fix off-by-one benign bugs
  mm: Use ARRAY_END() instead of open-coding it

 include/linux/array_size.h | 6 ++++++
 kernel/kcsan/kcsan_test.c  | 4 ++--
 mm/kfence/kfence_test.c    | 4 ++--
 mm/kmemleak.c              | 2 +-
 mm/kmsan/kmsan_test.c      | 2 +-
 mm/memcontrol-v1.c         | 4 ++--
 6 files changed, 14 insertions(+), 8 deletions(-)

Range-diff against v1:
1:  90ab26558138 ! 1:  35255c1ceb54 array_size.h: Add ENDOF()
    @@ Metadata
     Author: Alejandro Colomar <alx@kernel.org>
     
      ## Commit message ##
    -    array_size.h: Add ENDOF()
    +    array_size.h: Add ARRAY_END()
     
    -    This macro is useful to calculate the second argument to
    -    sprintf_trunc_end(), avoiding off-by-one bugs.
    +    ARRAY_END() returns a pointer one past the end of the last element in
    +    the array argument.  This pointer is useful for iterating over the
    +    elements of an array:
    +
    +            for (T *p = a, p < ENDOF(a); p++)
    +                    ...
     
         Cc: Kees Cook <kees@kernel.org>
         Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
    @@ include/linux/array_size.h
      #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      
     +/**
    -+ * ENDOF - get a pointer to one past the last element in array @a
    ++ * ARRAY_END - get a pointer to one past the last element in array @a
     + * @a: array
     + */
    -+#define ENDOF(a)  (a + ARRAY_SIZE(a))
    ++#define ARRAY_END(a)  (a + ARRAY_SIZE(a))
     +
      #endif  /* _LINUX_ARRAY_SIZE_H */
2:  ec7553aa4747 ! 2:  acd8bcbb05d3 mm: Fix benign off-by-one bugs
    @@ mm/kfence/kfence_test.c: static bool report_matches(const struct expect_report *
        /* Title */
        cur = expect[0];
     -  end = &expect[0][sizeof(expect[0]) - 1];
    -+  end = ENDOF(expect[0]);
    ++  end = ARRAY_END(expect[0]);
        switch (r->type) {
        case KFENCE_ERROR_OOB:
                cur += scnprintf(cur, end - cur, "BUG: KFENCE: out-of-bounds %s",
    @@ mm/kfence/kfence_test.c: static bool report_matches(const struct expect_report *
        /* Access information */
        cur = expect[1];
     -  end = &expect[1][sizeof(expect[1]) - 1];
    -+  end = ENDOF(expect[1]);
    ++  end = ARRAY_END(expect[1]);
      
        switch (r->type) {
        case KFENCE_ERROR_OOB:
    @@ mm/kmsan/kmsan_test.c: static bool report_matches(const struct expect_report *r)
        /* Title */
        cur = expected_header;
     -  end = &expected_header[sizeof(expected_header) - 1];
    -+  end = ENDOF(expected_header);
    ++  end = ARRAY_END(expected_header);
      
        cur += scnprintf(cur, end - cur, "BUG: KMSAN: %s", r->error_type);
      
3:  c94e42e85c13 ! 3:  781cce547eb2 kernel: Fix off-by-one benign bugs
    @@ kernel/kcsan/kcsan_test.c: static bool __report_matches(const struct expect_repo
        /* Title */
        cur = expect[0];
     -  end = &expect[0][sizeof(expect[0]) - 1];
    -+  end = ENDOF(expect[0]);
    ++  end = ARRAY_END(expect[0]);
        cur += scnprintf(cur, end - cur, "BUG: KCSAN: %s in ",
                         is_assert ? "assert: race" : "data-race");
        if (r->access[1].fn) {
    @@ kernel/kcsan/kcsan_test.c: static bool __report_matches(const struct expect_repo
        /* Access 1 */
        cur = expect[1];
     -  end = &expect[1][sizeof(expect[1]) - 1];
    -+  end = ENDOF(expect[1]);
    ++  end = ARRAY_END(expect[1]);
        if (!r->access[1].fn)
                cur += scnprintf(cur, end - cur, "race at unknown origin, with ");
      
-:  ------------ > 4:  094878542457 mm: Use ARRAY_END() instead of open-coding it

base-commit: 6146a0f1dfae5d37442a9ddcba012add260bceb0
-- 
2.51.0


