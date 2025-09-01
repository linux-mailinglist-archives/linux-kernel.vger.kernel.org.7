Return-Path: <linux-kernel+bounces-794557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492DB3E344
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248EB7B162E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BE9350859;
	Mon,  1 Sep 2025 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="gtXNzD/T"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C2A32C330
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729868; cv=none; b=jh2oZft3D/XQ4jRC2VWjQ3y6xXe0ZifNrduFHBpg5jXGBv6KsHSXkoCNvVRc56QuQpPWR0hNk0A7FrqEjzL0qrYxKgyEbTz+xxJiNS2LGXFqacFY7hsWg3EuIxSuVpDssrmpflIQj9q2i5jXZ9ws5Xs4LejeDG6PL/AIxXxQ7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729868; c=relaxed/simple;
	bh=KDOJlWebDr1r9JKcB/6qXXsMuiPZ+GrvsOQJ8M+vAGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYmMmTUQ7bVtfS+7QsLZd7eFJHAOqGVsq4iyO5Xbh6gvRGMjBXTzMPL8dvxgE0DMmhaCw9/rRS1A17uso01c2BjcezXH7T6Rgn5625aF8hWNgoXFcbZRzhtLZKf0X+RApCerkWRyUFYmUzUxzPhBbihyqn8nTisvPhT7rMfMBjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=gtXNzD/T; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-61e425434bbso1806045a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729865; x=1757334665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZckJdWYT65mLwvxCWKoPCArrn6/MXXjzKwssfU7w+U=;
        b=gtXNzD/TCTMFDUpyENiLVyNAO8B0gcHqkZ0pNB2JQD9WreRoTBa/5WgZVLl6fEPdIS
         bv5elSdUhPOYrl6zB4YbiCTnbOzghPPW8FJAk8Tm3heL74VqRTl6FdTQvVmw+bt5xgA9
         rNzk6GcMb2+4nQcy7TmU5UcWHlzMTgCx9brQD+mE2wBYz4HKnQD0B8gBSrkEPl5sM81X
         unWNz/2JpYKfDozUtw7lq2r2eYtwGhzaVHXQVitDDOH787vo5y0eXKaeL60b+ow0Ksq6
         QKh+fFnBGPU1r1vGrfbbIlfUJbzOzBNY71h42Kls8+EUVLqCTJibA8i/qd/bSrXhszlO
         3Png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729865; x=1757334665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZckJdWYT65mLwvxCWKoPCArrn6/MXXjzKwssfU7w+U=;
        b=ZgOtf4PtiwvsrKVSUb/GJE6uiai+1IP/H0gqv0/LCywlhD5ncf/O1W4MHb8fsPncvV
         5GJMqDad0UT4NgXF6EEtsO9inyo81+JsxHTAzkOmxYgiDpW4CUVRc7KYM5lENTUHz2pj
         mWgtdinNY+3zCpZoHhpgLCy0/Os9alR9FJv47xeyhXcwkuvxc52LZqBsRcDcuydH0OhM
         CIyFzcdadirjLFoV+zAqQB18bmTlM1srzrTPPOhVDejsM/3syrfO8Ex5G0vJnqtSogF1
         XUzQHfrOlNzXmO5dAzO9geUfHmpOKCgXPXpjRdrdsi4V3czWo/mWqMvvmJf3J4+AfOYd
         IyKw==
X-Forwarded-Encrypted: i=1; AJvYcCVOEpZXMCQDOG5pCQmvK3Ljkf0ZEq86PnUJrV6QQFMt8leIT+uW/5+qzH945MU8NCKhuyI2sjeFqzUDo6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFG03Jsy+lLMEMGnAOxpSdWT0wbnR16EfebyOrcn/FujxON+P
	WM3YdLrsxq7XaiGFoLX0/UpEfi6GrbDCn1dNIz/u/PB/p+dqnC0nsF1Qim9h6SfZnQKL7TZr8qZ
	ii0hBw/4=
X-Gm-Gg: ASbGnctb9/0oaptz/9o1QK2xKyiyHtci8ZOmkLoPStCNka6c/nSVqcwxFBc5/WJdJ/U
	oJb4df9/4hDiknlULinkr6TVEr/EqwbezDWOIFD4SeO1a4dXvJTMxyYVUg+gIJ/K4HHeuuxvtPi
	avJCLt7hH1FU7tO5B417VK8F4IrZB+Z4TahkHoCXQ+wARwXnNHshzEn1pIsf5bGSQCFkDimgxmX
	SqkcvSb3IS9maZvvCKBB+dX2GmkFvqqtkUZWCp0Vur478VlOHnzvNW81491q2LRUg1wOy0ceAd3
	TKUkI4kVKrlySw0WfTllFmIaZd6Dn6cEd/Fw+11YH7Hmfy+0Eq3WJ9Uoscasn5mOjNRqZFbJWOd
	tewr7igANyYPqPsvMJxhPlpQ0h/TNFkY9JPiXRusLptDCOzVz2p4PUz77aRQEK6qA2sLuiyEqho
	KdVvsuhK96g7p9CZNyC5qdPiywM1gko+2I
X-Google-Smtp-Source: AGHT+IETxUI3qvvcJof3qThaTHBjP7BahOV3yuMasi46ZJMakvC6EwAs8jjOUppbppRZ2B64GjsX3A==
X-Received: by 2002:a05:6402:5207:b0:61c:5cac:293f with SMTP id 4fb4d7f45d1cf-61d26869f4fmr7390296a12.6.1756729850374;
        Mon, 01 Sep 2025 05:30:50 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:50 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	willy@infradead.org,
	hughd@google.com,
	mhocko@suse.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	vishal.moola@gmail.com,
	linux@armlinux.org.uk,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	weixugc@google.com,
	baolin.wang@linux.alibaba.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	max.kellermann@ionos.com,
	thuth@redhat.com,
	broonie@kernel.org,
	osalvador@suse.de,
	jfalempe@redhat.com,
	mpe@ellerman.id.au,
	nysal@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-parisc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 09/12] mm: constify ptdesc_pmd_pts_count() and folio_get_private()
Date: Mon,  1 Sep 2025 14:30:25 +0200
Message-ID: <20250901123028.3383461-10-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901123028.3383461-1-max.kellermann@ionos.com>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions from mm_types.h are trivial getters that should never
write to the given pointers.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/mm_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d934a3a5b443..46e27ee14bcf 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -632,7 +632,7 @@ static inline void ptdesc_pmd_pts_dec(struct ptdesc *ptdesc)
 	atomic_dec(&ptdesc->pt_share_count);
 }
 
-static inline int ptdesc_pmd_pts_count(struct ptdesc *ptdesc)
+static inline int ptdesc_pmd_pts_count(const struct ptdesc *const ptdesc)
 {
 	return atomic_read(&ptdesc->pt_share_count);
 }
@@ -660,7 +660,7 @@ static inline void set_page_private(struct page *page, unsigned long private)
 	page->private = private;
 }
 
-static inline void *folio_get_private(struct folio *folio)
+static inline void *folio_get_private(const struct folio *const folio)
 {
 	return folio->private;
 }
-- 
2.47.2


