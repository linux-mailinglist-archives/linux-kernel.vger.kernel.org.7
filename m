Return-Path: <linux-kernel+bounces-830764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85356B9A747
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9589117C3F5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB62313533;
	Wed, 24 Sep 2025 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDcp2xYN"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C403128B1
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726032; cv=none; b=D0EeoCF67bxoKRka3eOroKq/6TpyP+09KKj+9/uxZTmV4nYSLrgOAmBAc5pW4kAmaaLgzWv4nRMEiloUKchzr0UW6IP8oyKiDUK77r523VNZwk+5qW07Uy2SkOZ8sd+AwzcIKTyNQc42/HNACWoROe+CnYxv7/js1IGy43mtoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726032; c=relaxed/simple;
	bh=qDMukE+vGFaZgPAnzYH5a2YY1R/PccU0PwTyvnM0oxg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I/Ewj4Fmx6tRDJqWy4e2X8VdN4CAAUSyUfnibgKrsa/fBFdKmVoRoMsA98+8dZkTY+TLxYzkba9+Z44SqOHlzbHTU7rXh5Rdo1tsjVqqRhusJ2jz4J5WI56nnNSxbMg9NPGVltOl/zXn46wwoRHphzQO8mPwQWWbbOxQ5fr0c3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GDcp2xYN; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-40657e09e85so826715f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 08:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758726029; x=1759330829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oP8jWp4MkINOH7Jswzd6ZODnFl0qB6e1xzS3CEKeQl0=;
        b=GDcp2xYNYT0h1c/L6kwFXyvgWnk/38WWVtqaheANUHHs6d7S8leklwmrq6nAUpdAFb
         BVuP1ynePhqlCyCeaxElyoiiIGJFzCULiqIlxZ2hd2kdPoitelijiAE6G3O0UFyVB2o0
         HnJNMHxInqVKPecnBxYz3jLQDtZoq6fRbfL0g/Arcxetj6hFcnsEBuvwn0CRj/na7Crd
         T/VcizgT+btSrUNmKPCskfwMGR6zEFS6j5M7T1nmrLOnn6r2kLBkG7qOgKbFz0g709kN
         tHNR/KKZiuhD2UmOs/uk5CnawkDsFJ8GsMZE1kLEiYt5JckqNARMCsy9Y8gRc0ldGG5X
         qBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726029; x=1759330829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oP8jWp4MkINOH7Jswzd6ZODnFl0qB6e1xzS3CEKeQl0=;
        b=o+AGTN7ghHDq64COic2MNca21JQm2QcGQVTWzkgTExY1d8JICvw8QOoa2/Rz45PalB
         WE4y8R44E3BakIzQ+t1MmM+lHqeB2i0yv9eaFWvXPbCxZdFevurNJ0zWV6CoHORvQqTy
         C6y4gsKrFq2BP05MkSkBmYB1f1h2ntsN87hytb2dI4aj6wgKXi2P4MDaeDvxvxkHSjpA
         oJwab5NexS7rDPuKGPGLclaocIffJb1HuytyJTVwhZj46FpJ39sQV6Mrx9y8AvZhkdU2
         scpsoA7ABt5VqslwMkVH0S4hSeK0OyvIpXjxHWeEtTIfkZDp84y/gZFw9vTzO8dgjaAD
         cZMA==
X-Forwarded-Encrypted: i=1; AJvYcCVXk4/erDpR0L6J4JUsmcfhT4RlVAugApasxPfRohVofEnIsc8XrWyKMQDzKGkHEJW5TjpR0+vmC7cyttw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz18RceoowOTRNrthLbG7wGoowgHrDHPrw5/AXzAtrdcXA9GQxN
	jeILeUTHjT/n0MxQ1j+kJWKvK1NQeIwUsb6ORBs+mJ3xQ56kuInV9MjAcMDHf/fMibCmSfAtu/w
	n10OirrGWkiCqaw==
X-Google-Smtp-Source: AGHT+IHodywAlVICR2SlEwjI/nDMWsb7c+Q0rCIs295IEGPrhzAjMAXo4iCffE/QGARjzAt8FOBx8w/TD0aqww==
X-Received: from wrvh13.prod.google.com ([2002:a5d:548d:0:b0:3ec:e12a:e26])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:240a:b0:3e2:ac0:8c55 with SMTP id ffacd0b85a97d-40e50f5651fmr215557f8f.55.1758726028587;
 Wed, 24 Sep 2025 08:00:28 -0700 (PDT)
Date: Wed, 24 Sep 2025 14:59:55 +0000
In-Reply-To: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250924-b4-asi-page-alloc-v1-0-2d861768041f@google.com>
X-Mailer: b4 0.14.2
Message-ID: <20250924-b4-asi-page-alloc-v1-20-2d861768041f@google.com>
Subject: [PATCH 20/21] x86/mm/asi: don't use global pages when ASI enabled
From: Brendan Jackman <jackmanb@google.com>
To: jackmanb@google.com, Andy Lutomirski <luto@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	mingo@redhat.com, tglx@linutronix.de, akpm@linux-foundation.org, 
	david@redhat.com, derkling@google.com, junaids@google.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, reijiw@google.com, 
	rientjes@google.com, rppt@kernel.org, vbabka@suse.cz, x86@kernel.org, 
	yosry.ahmed@linux.dev
Content-Type: text/plain; charset="utf-8"

For the same reason as with PTI, ASI means kernel pages can't be global:
TLB entries from the unrestricted address space must not carry over into
the restricted address space.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8fd34475af7ccd49d0124e13a87342d3bfef3e05..45bbe764ca4e0abc13d41590dc4ff466180cca31 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -249,8 +249,9 @@ static void __init probe_page_size_mask(void)
 
 	/* By the default is everything supported: */
 	__default_kernel_pte_mask = __supported_pte_mask;
-	/* Except when with PTI where the kernel is mostly non-Global: */
-	if (cpu_feature_enabled(X86_FEATURE_PTI))
+	/* Except when with PTI/ASI where the kernel is mostly non-Global: */
+	if (cpu_feature_enabled(X86_FEATURE_PTI) ||
+	    cpu_feature_enabled(X86_FEATURE_ASI))
 		__default_kernel_pte_mask &= ~_PAGE_GLOBAL;
 
 	/* Enable 1 GB linear kernel mappings if available: */

-- 
2.50.1


