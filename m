Return-Path: <linux-kernel+bounces-892081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF08C444D0
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 19:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D36F4E573D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6E221DB9;
	Sun,  9 Nov 2025 18:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDkCAdDT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E31521CFF6
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711620; cv=none; b=Jc5q0S6RD8aajEDSKxyfx8YERSQLal+AXA1ylhz3cRpR+VfSKDRnjekuAxhEAwdXuWjcyFptbca2zZcZh4lI0d3pcpUHHQZwULu1AsMosGhq2KbA0DRUM/166qJz9XUEOj/Tvs+3T2sUQHAh6L0Q2bb2LvC9/VLCORzVpnV+Ahc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711620; c=relaxed/simple;
	bh=NCUBtJbYbJUSM0PsF/hMhn60Ld0of4iArhANi0uVhgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb6yEtySAGbgV5JBvr/vVGXMo9folT27PQUk/B/n5tnjECtMXr6ZW9JvhwvnhosigeshJIf01EwCeT+XfgSswXrxRFxrYxWkYDWA5mN1oxdlaAoZuR9LaXQRUPtjFDOEA+KOh1R1kIMnG1XfVOU/EyjgiAzEVj7Z/+k0TvpiY0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDkCAdDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423E4C4CEFB;
	Sun,  9 Nov 2025 18:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762711619;
	bh=NCUBtJbYbJUSM0PsF/hMhn60Ld0of4iArhANi0uVhgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aDkCAdDTBKcWRXGOcI+UXsgw84QaqZW8IzPm/a5rL26dy7qe0gMOs2b6A+v9DgZj2
	 +DIGa0IqVmPRS/VbYmO4TJJYdIUvsj6jXaQrQ5yBqUR+cIN15YTt73BjpaPdLFmRgc
	 vCkxN7ZDOIWaOzuTDOqZDjpFyoH7hQBXCTHATd8m+SIsmvc0x6wH3gc2CAC2NYPxwf
	 SabU9UBOkBkGKWrKgWjHub/Rdr7mMOcbR4e8SQ1306D4JrbsjjG6JKhkTsnrDhrs8P
	 HGTtJ+zmeAlXnotgcVFov1Ztmv6+6SauSlmGzOAKT2Gt4meJIs6ftUeg0as/tFPkNy
	 SCdW6cr5zTyAQ==
Date: Sun, 9 Nov 2025 19:06:54 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 1/4] array_size.h: Add ARRAY_END()
Message-ID: <2cb4ddff93b3d3037ef8d094de94227982117f87.1762711279.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1758806023.git.alx@kernel.org>
 <cover.1762711279.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1762711279.git.alx@kernel.org>

ARRAY_END() returns a pointer one past the end of the last element in
the array argument.  This pointer is useful for iterating over the
elements of an array:

	for (T *p = a, p < ARRAY_END(a); p++)
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
 drivers/block/floppy.c     | 2 --
 include/linux/array_size.h | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 5336c3c5ca36..69661840397e 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4802,8 +4802,6 @@ static void floppy_release_allocated_regions(int fdc, const struct io_region *p)
 	}
 }
 
-#define ARRAY_END(X) (&((X)[ARRAY_SIZE(X)]))
-
 static int floppy_request_regions(int fdc)
 {
 	const struct io_region *p;
diff --git a/include/linux/array_size.h b/include/linux/array_size.h
index 06d7d83196ca..b5775b8f13de 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,10 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * ARRAY_END - get a pointer to one past the last element in array @a
+ * @a: array
+ */
+#define ARRAY_END(a)  (&(a)[ARRAY_SIZE(a)])
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.51.0


