Return-Path: <linux-kernel+bounces-892127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FDC4465F
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD37188BC13
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B0239581;
	Sun,  9 Nov 2025 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogCcESOC";
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKmNxuWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602A1238C07
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=10.30.226.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762717696; cv=fail; b=roDiiExYvuPFXbvGyIzikgUL6lhjTNAaDdsJrAk5PkAy8WU/fEeKGMHDPYZGR3BedKmK/ViODl3HOybJOqBpSl3mj6kAbcX12kCSbwHnCUGOrV6G0Ygi8q4m7HIuhyxj90SMDAX6l4eIzGlm0rKJ35OfFvm475AdFftXVF/UALI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762717696; c=relaxed/simple;
	bh=2xVmGhP0PFx/hs6+oME8OSKXBynf/1IS5/aMFkAz6UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNh6JTPWTEM3i28qd6af5IEj3voAL4DkL3QCOXDf4iCpcL6/KavELlLG98I4NPUMwvdZ4sqTr4deFAog9AN+R3g+QNtTei3uE3i929w8O5LcPtwuN8e0n+PGRJ4hL0RKBuO5RHkHdSSq8s2ztjy+MpjnvtVtCKtwMCg/UV4FtAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogCcESOC; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKmNxuWv; arc=fail smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4070FC113D0;
	Sun,  9 Nov 2025 19:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717694;
	bh=2xVmGhP0PFx/hs6+oME8OSKXBynf/1IS5/aMFkAz6UI=;
	h=Resent-From:Resent-Date:Resent-To:Date:From:To:Cc:Subject:
	 References:In-Reply-To:From;
	b=ogCcESOCjEbKlpovqoBLwPD3lyWUupl8NLsJB7JwkkTKIThNgTysqv0mqc3aHUNJ9
	 CXM6jqoTUqviwjez0e96bCVoDrbo5vcTAz8BSiN2BQjWLaKDUTf2TZU0QjkcmBjktf
	 SOwqdP44fOp45/6zuS7raSP6v8ddenC65Tp7V2XUESeEeK4rliE5R+CF6bjjsAn+s8
	 o4O4YomG4u9oqgXJi+2zpLZrTnO0utMujwF/KyEMMLslib+PqfFr0VGrqRI4ddH7kO
	 8prBwsn29LN1GCCuHksxV9PPSFPfwTPjNnW6DPcZNk42buSn9wucKpQTAMSLL3nCoh
	 qwW46pOf+pdZg==
Resent-From: Alejandro Colomar <alx@kernel.org>
Resent-Date: Sun, 9 Nov 2025 20:48:12 +0100
Resent-Message-ID: <hrhy24kbmnbh3y57mtx5vch2555zcqmu7ffxxp5fggyi7lqpmb@r4uqr3dmxu7w>
Resent-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Received: from mp0.migadu.com ([2001:41d0:303:e224::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by ms17.migadu.com with LMTPS
	id kHFEHk/vEGmbfgAAqHPOHw:P1
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:19 +0100
Received: from aspmx1.migadu.com ([2001:41d0:303:e224::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	by mp0.migadu.com with LMTPS
	id kHFEHk/vEGmbfgAAqHPOHw
	(envelope-from <alx@kernel.org>)
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:19 +0100
X-Envelope-To: foss@alejandro-colomar.es
Authentication-Results: aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oKmNxuWv;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alejandro-colomar.es; s=key1; t=1762717519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CNXDhEfUs2p7rqxHrG1BCgqb9DusTf8GED65ME2P2Z0=;
	b=cXczza5G+yiWra1Bd8u6zJY7gSq1EA8DTkYIi7Ow9Q1jMF2OUHZUGtlfBbcLhSxaqN5Mtm
	mvUViOHniv0WVOkl1WNnvRhLDc4Mjh0CDtU28cpCpl9XzxrZ0RS6pKbMPkwfSJHi9kD6T4
	0hfeV1yU1sjjdVTkbYIfxDZ41NriMtoSSMuOM5H7s2LN4NKfHZxr7DiS3AP7d0P7MdmTF7
	kp2qMmN3BIPB/vTp/f5YiWrdccJtgOwUgeyXs3Mf7AwR8XqAPKd7dlONsp0z5tq2898PNl
	b2pta82qdFp0HtAxBMf4dD8sLGX8FtA2ZTdFA6vO8WIfBp8R32Rjv80DHZHG5w==
ARC-Authentication-Results: i=1;
	aspmx1.migadu.com;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=oKmNxuWv;
	spf=pass (aspmx1.migadu.com: domain of alx@kernel.org designates 2600:3c0a:e001:78e:0:1991:8:25 as permitted sender) smtp.mailfrom=alx@kernel.org;
	dmarc=pass (policy=quarantine) header.from=kernel.org
ARC-Seal: i=1; s=key1; d=alejandro-colomar.es; t=1762717519; a=rsa-sha256;
	cv=none;
	b=QWB5bcsJF4o1lz/dQMUj3rMQy1/6CBCcvtMoKZ8K1lypkT9bFIDQSt9OAzK3HL8qM4tIKq
	Ts1aNE3UlZ+3tOjxyFY/4yPlyh0wb5Rrv/S9jjXiBr+95DU0qULHWpRA9YdaPLE1gu52DY
	6Jdcyr8fbxxMeSVpJqdMEiKqQoj9cNXEptuYVB4l8cbFA5xwcFerRS8/FsmQF/G0oO44Fv
	uUiBmiVxFO5kxjnEA45sggVCfjGATI68yfYmgLEJ5DoW6ifFBFRkzuberKeel9PlTjNBGU
	IxTLpp8qsto6yJorM2NckSydPtdf0hhRSk5p0OFm9r6LsJO9lS2al3PuL+dS+w==
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by aspmx1.migadu.com (Postfix) with ESMTPS id 26403CF27C
	for <foss@alejandro-colomar.es>; Sun, 09 Nov 2025 20:45:19 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8A1ED439FC
	for <foss@alejandro-colomar.es>; Sun,  9 Nov 2025 19:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix)
	id 80D89C4AF09; Sun,  9 Nov 2025 19:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B71CC4CEFB;
	Sun,  9 Nov 2025 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762717514;
	bh=2xVmGhP0PFx/hs6+oME8OSKXBynf/1IS5/aMFkAz6UI=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=oKmNxuWvf3uefHLZJ7tATBa0Bxw4do44LKQyPZeQJnvgPAtNUF5i/Erz1EfP8Vqbw
	 HfeOoXT6kWox/YmfnGRsin2G/8m/3u4qm/4IhXieh2EdfhYQS5Rxr8BcrQMF+lclSr
	 qa3FPhrF0GnAOB7/oNrstfo4XBQRdSjfGJZbGMaNPfhy4GK2t+vULJOS0GkeF6Cocy
	 FLHf1v2HUclu4yL8jR1vdJ3ANzJO2jLeii7Oa9Ux4mCkdGYFfkeeJ46Y7ZwSsNq4qW
	 aKvnCzXlJRVCKWKyUJUVYUvvmA6h78kzO5kYoui3Z7pkV1PsIs2dAfC9O5KVYhWVts
	 3J8enbum/k27g==
Date: Sun, 9 Nov 2025 20:45:09 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Marco Elver <elver@google.com>, Michal Hocko <mhocko@suse.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH v4 1/4] array_size.h: Add ARRAY_END()
Message-ID: <9f87d6208a6c754ed0e322cc51a92e0ed6e59123.1762717358.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
References: <cover.1762717358.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1758806023.git.alx@kernel.org>
X-Migadu-Flow: FLOW_IN
X-Migadu-Country: SG
X-Migadu-Scanner: mx12.migadu.com
X-Migadu-Spam-Score: -3.17
X-Spam-Score: -3.17
X-Migadu-Queue-Id: 26403CF27C
X-TUID: a3t4CK2y0IT4

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
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>
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
index 06d7d83196ca..0c4fec98822e 100644
--- a/include/linux/array_size.h
+++ b/include/linux/array_size.h
@@ -10,4 +10,10 @@
  */
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
 
+/**
+ * ARRAY_END - get a pointer to one past the last element in array @arr
+ * @arr: array
+ */
+#define ARRAY_END(arr)  (&(arr)[ARRAY_SIZE(arr)])
+
 #endif  /* _LINUX_ARRAY_SIZE_H */
-- 
2.51.0


