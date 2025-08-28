Return-Path: <linux-kernel+bounces-789571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D375EB39779
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DDD463359
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBF22EB846;
	Thu, 28 Aug 2025 08:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="YV+8xV04"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619582EBBA9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756370909; cv=none; b=tSvWHm1v8KdlKtspYDMjp+VVsQepNvukmabARXEJmqceToySDyd4Piz9RakIMzIZ66APlfCDqPaw/OlCBUoq+TwdSpXVPztF0vUa9k1e7aqnwCXbR9lOzqs4qZA7C5VrHGIiZLmd38y0m5AhJ3AEa+gNbmVDkNbPd4jvAWjEk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756370909; c=relaxed/simple;
	bh=/uk4qpjQH4Gut7f4XSF24X/bv9Y9SrG4nDtgHQgsgTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1cYoyqWi7b0yIDYj5DZEMyVSm4C5hI/dn3Cj5SWHH4HopEPK3asEu/wou+6qbBlkwTICju9yub2n+sCc3J7yFXTji9ClRgqOyJFEPQVKJEC1UlHJnpkz36yDpZhfRMnVlAK7tedh68MyXNEeyDN5GrS7NnivcwRVQxqd/5gYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=YV+8xV04; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so3476577a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 01:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756370906; x=1756975706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=po5t56gupEUroA6hj2hKHRirq45/Eh6BqU6ENRqwXCo=;
        b=YV+8xV04eDVjKkFYFLEH64a9GWuoC0+Wc3WHkSnQfxQsvZe49YYtznepby1Z3SCxDy
         Apa+Hp22PORqOTT+CFEfw83y+e1gDRb7OQmAWySJEJBZqJqshSCjM8zAGM60grprvf+Y
         5n7J5MDC7GBhDb/gOHWaAUWkTqB1K11vr1zxFhPbr/5XY7yrrGdP6gdzbbgchjm+VaIH
         sRZ0Xgf8/rIWU4u4mAoYtPCBystS0QD7ubYMjGAbZve7FqKuHkiWNzUZrW9lDR5Vr0zk
         m9fEw/jzTSw+KspnuO7kao+1YFod0nSlkF/Jrk+3quGSg7LLGFAQ/3APnHGgdbXPQYzb
         +Bvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756370906; x=1756975706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=po5t56gupEUroA6hj2hKHRirq45/Eh6BqU6ENRqwXCo=;
        b=DQDEqWXqXT9m2tH1bzIqBxJvvNKRWh3xaN5+226LmjNTAQwX+YSjttaycko3MGbN6/
         pIGOLlAb5R5yAI4xoGa95LCmdqxxrl/v5dx2A2BfYQ1vtaPJbgFv+6S8udcVaTn59T1+
         ZmDgD3vWdTZflhphPxNBI8MRwBYwEoUqiAinUt3jTELdUPCFHTvNTqRLCFjzoMq+LFVh
         cY94bRjpoL3FgnyQU/wsB+shi26zKoUGBnrDS8sTRI2k0ydGQ9WAQpgJiNAmTEV0WklS
         qvFUKWkUGGmPJ6Lm6KKePFhyvnvKiyhIhSSf4rIz1oc3tDsubS0UcjWbTB9v61Rcr0s0
         cVuw==
X-Forwarded-Encrypted: i=1; AJvYcCUOMOM/V87m3ZaNmuf9Bj33S8ZRl/MXf0apteUDmuo7i11ENDmLv4SPTy3HEN2HM5snuNnqwBVM/JZB3kE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhkG9rXzNwrBqBKKqRXuGM5/X/V7JhLnIhRLSl2aROhsOHucnM
	iqdMapZbVAWEUnZna7QRdzNziPNfWyQVzV58UU4W4Qlei6vs9w+Van+aq6yXPhs5a0g=
X-Gm-Gg: ASbGncsqu5zPeC36ZMI9xsVjqx+IoluvXvBYzJSRphWC+9a4szWtqUG+QOuPM7EMW3J
	MoW06+Nw7+b7o3L0Lz7uUq6vzWRmRo5YyFFrKXJ2DrNyUfm1sVIViJKVWuN2PESvo8iUFI80oBh
	6GFmWhG3iFXGY6uv5M9fnW2lASsydpZQH95QRbQqjJEUHZLWBMlQGK3PTuTgmdN/pAC+lYo5nro
	37QQFWbU/KAXehLPUghbync/k7O3/iySoYUBJP7W9S/OTCog3lNUg8EO3oyARW6k6D/FG8MkJX3
	NKKQEYO2nfQfPTI1J3VvigllJXnEi9PBGGVM+gslVC5JwiHvnHWTfuxLWcxpSmzca6WFeL3QkNc
	Qx58iB76MH+Z5EhVeJz475K0IcoWpsLs3zXVjNZG21tMmDZuHpbHBweZZPzAqLo9oAEV+jK7yDX
	CB6ElHQsSyUUg+dkosaMABbfMhYE1r4de0
X-Google-Smtp-Source: AGHT+IEwSMufyxIazeK4EN6r3xqwf4pSdVAWUgiAPZLRoOf/5DVGbNYWNx+rE4X+wLoHpKnHe4pjbQ==
X-Received: by 2002:a17:907:6e89:b0:af9:23b:9f9 with SMTP id a640c23a62f3a-afeafecbe4cmr668160966b.24.1756370905526;
        Thu, 28 Aug 2025 01:48:25 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe90c8f85fsm697372366b.8.2025.08.28.01.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 01:48:25 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v3] huge_mm.h: disallow is_huge_zero_folio(NULL)
Date: Thu, 28 Aug 2025 10:48:20 +0200
Message-ID: <20250828084820.570118-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
References: <0de24b30-70ad-498f-9eac-01596c8713df@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling is_huge_zero_folio(NULL) should not be legal - it makes no
sense, and a different (theoretical) implementation may dereference
the pointer.  But currently, lacking any explicit documentation, this
call is possible.

But if somebody really passes NULL, the function should not return
true - this isn't the huge zero folio after all!  However, if the
`huge_zero_folio` hasn't been allocated yet, it's NULL, and
is_huge_zero_folio(NULL) just happens to return true, which is a lie.

This weird side effect prevented me from reproducing a kernel crash
that occurred when the elements of a folio_batch were NULL - since
folios_put_refs() skips huge zero folios, this sometimes causes a
crash, but sometimes does not.  For debugging, it is better to reveal
such bugs reliably and not hide them behind random preconditions like
"has the huge zero folio already been created?"

To improve detection of such bugs, David Hildenbrand suggested adding
a VM_WARN_ON_ONCE().

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
v1->v2: using VM_WARN_ON_ONCE() instead of checking huge_zero_folio
v2->v3: use "!" to check NULL; removed the #include
---
 include/linux/huge_mm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 7748489fde1b..96ac47603d97 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -479,6 +479,8 @@ extern unsigned long huge_zero_pfn;
 
 static inline bool is_huge_zero_folio(const struct folio *folio)
 {
+	VM_WARN_ON_ONCE(!folio);
+
 	return READ_ONCE(huge_zero_folio) == folio;
 }
 
-- 
2.47.2


