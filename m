Return-Path: <linux-kernel+bounces-832512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A536DB9F8CB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612013B79F9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05E12652B2;
	Thu, 25 Sep 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxeNLm0D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7182367C5
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806444; cv=none; b=cSMm8aLvyuhgT9t4Wdqj3aPp/SA3b/ZNq7Mt29KGojRpjm+azBheHR6Rh836t3mAx3cW93Y8PMg+anp2QssracETm2uWvTFdRleqGrYy40dzu9v5YWDIT7+Kkr5iPV25ekdljki8IoL6NPNk8eFpYCR2xXrKA6iaat5BfVixpZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806444; c=relaxed/simple;
	bh=x8LCJhegC97O6xERC5LDearaauqtJIxIIcuU8JYgDQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVAjgKsP13Q9Rch2zPXbbfE9YrrYsTq83WFk+j8DtS0zZiQqtxvBsuJMzWgBypxaT6OtOcotehC3WaUsfk7Lvba6C4GcdnT44x7z+c/0dRqQUStXqWcgt+2MMynwXX3O0SlZXi/Kn2dcWXbIxRhgxr4Id+YDa7ZpOvM7r5O2NPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxeNLm0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7BFC4CEF0;
	Thu, 25 Sep 2025 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758806444;
	bh=x8LCJhegC97O6xERC5LDearaauqtJIxIIcuU8JYgDQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxeNLm0DZWNdN7BMMB3CuQoBsPHFjJYTQ53k4EOVbDH5FO/5+WOseIpE3pWzT13LJ
	 VTJ5tt7YEN6pasYHgBhtU3mg6z0dRUv4KBPhaB8v58Jng2au8Jr+xOhyOx5nRSurNV
	 r8ooLZd5lc27XKJ2bdcLJudFZdipZgBTb0nlwqpYwNrzPObtolPLiJPRRSEIMcSzWX
	 eiRd6p6rM3tNuEpUpcD0NbwgRtBqFuff215OHpEtBgK9D5vAtDw/rWK8xehkEjZm9P
	 iqs1OOawbFZveOXGIFboTNMolqpy3CQLmH6Td8EWLz/BrxRFZUe8/T5O7rY/DWdBHU
	 zbNu4IUSNsIYw==
Date: Thu, 25 Sep 2025 15:20:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Marco Elver <elver@google.com>, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Michal Hocko <mhocko@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v1 1/3] array_size.h: Add ENDOF()
Message-ID: <0b3d2fde03a0b11643d5a9bb56d7a903c58320cf.1758806023.git.alx@kernel.org>
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

This macro is useful to calculate the second argument to
sprintf_trunc_end(), avoiding off-by-one bugs.

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
index 06d7d83196ca..781bdb70d939 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,10 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * ENDOF - get a pointer to one past the last element in array @a
+ * @a: array
+ */
+#define ENDOF(a)  (a + ARRAY_SIZE(a))
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.51.0


