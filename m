Return-Path: <linux-kernel+bounces-891724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46845C43546
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 23:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C801C188D11E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 22:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E7528B407;
	Sat,  8 Nov 2025 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjC/sQ5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165915667D
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640430; cv=none; b=GtSpHyMDj2uaG4l42sGZJoaEqTIoUNxJSbWkgPT3vB9pnzNyV3QzUfmwvc82xPvjlz/28dkAzLHFXDGiUTq3bPevcE1W6If6hLv0f6Bx7qzeiZud96uwfZQ+7dWT8mXiYek0RICKB10eoCD+xqffISm5r5cM0F0KENChQboA0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640430; c=relaxed/simple;
	bh=D2bxUCipdqgy7ofKUDd0lFuuVmbC9ePnY5k6K23h/+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dnLoWx7qY6eAaHRstoIKz5lerdjujfYbD+aAtN/cYooaoK3HbOogOlAlTKKBYU1FjYqdMXAwf46EGEMPKyMqh+is601zjy5Fw3uOCaSK4EiASaM4GQ4UhG8zqBEsYSH4r4oq5e9gJ27V8pAI21QMzVRB7yJHvWSt1oT144e81lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjC/sQ5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FEA9C16AAE;
	Sat,  8 Nov 2025 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762640428;
	bh=D2bxUCipdqgy7ofKUDd0lFuuVmbC9ePnY5k6K23h/+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bjC/sQ5NuPgCSuQWV9UNlNlM7oSf8INiIMXyM5IyWARrTDxQhQparEQEzmO008a+9
	 +ksw2FOBK9HDXnno1WGQYC8tlQPmW2pcs8t3ZlHihy7s7D8hE9wnkAWpa0CP3TFuC0
	 o6kQuLG2BKyCbbzkblrvbNEExVT4jKm5V4PrrA5umEhAiRwY87Xixt+TEwbKzN64QO
	 xaD9nKTAmf+mqWpw6y0j38FMacqQMZSvMkQSjJF+V5zvJosAhTZ2dl/wfgOkSKBbUb
	 bso9E9v+s0CYMaMh+8FWOz0rrpllhIitDv8Sf0gJ1WVbQwxXDUtK7xX7Y+q/F7k6Gf
	 GPHy5UZg4tQDw==
Date: Sat, 8 Nov 2025 23:20:24 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/4] array_size.h: Add ARRAY_END()
Message-ID: <35255c1ceb54518779a45351dcd79a3c1910818a.1762637046.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1762637046.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1762637046.git.alx@kernel.org>

ARRAY_END() returns a pointer one past the end of the last element in
the array argument.  This pointer is useful for iterating over the
elements of an array:

	for (T *p = a, p < ENDOF(a); p++)
		...

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Marco Elver <elver@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
Message-ID: <37b1088dbd01a21d2f9d460aa510726119b3bcb0.1752193588.git.alx@kernel.org>
---
 include/linux/array_size.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index 06d7d83196ca..62382973078e 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,10 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * ARRAY_END - get a pointer to one past the last element in array @a
+ * @a: array
+ */
+#define ARRAY_END(a)  (a + ARRAY_SIZE(a))
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.51.0


