Return-Path: <linux-kernel+bounces-795319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9ADDB3EFED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B504E484376
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87AA27780E;
	Mon,  1 Sep 2025 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fd7uB6P5"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0543E27586E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759838; cv=none; b=CJGQkCkUEbtedRmqwejtfEG0ZM3yWJ+NCdx4hEmweIzRG3YYI1xF9nbeA5QWyfv07dOwCpzpzSx0CL7GVbfUNT2/nXIhToKq+PC0URTk+1NXrcS5QNbGYHcjjBRog8lSfGTe2YfydX0HuGpspHScy25R8LfsVy6WjNesFSTIk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759838; c=relaxed/simple;
	bh=9ZBLOgc8o7e4sYGe9wP+1FqjAVbgCQ4ajZen8ILi1mU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv6hh+5EDx2/1xG5gWiFjPtWqaS06PrJL8+OwKGPWkbFU3THg2lQpd1bDpljU8eRDecGVRt6thO/hnlJBckf+y1MdGBH8L84r04zrhZHbc/fd1HyUOMG9YxE56sRk+gj/zQr/hsAEcK3U5oVjC28Yc111Ksw+KIMQpSuAi/MWDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fd7uB6P5; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae31caso905450666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759835; x=1757364635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOUVRSUkKssTlOViJjAfm2Ry0I5gABWdPNOlGM2jpT8=;
        b=fd7uB6P54iPwC2UabKzsiHRweWKdRQtn3DyA4wJAfMScLZN1S+Cup8/pYYTAplSMEb
         oiBSDgN/cMndhVSnK3dy1F1xDzRmlHH4c+pwq64ndLkUHnyHTx8yv1/dfzMz3ypiPfn4
         8UHqEA9DVSmFJ3D1GH+q+8zaqZoBGK01uE8ypp59GqicaNHlQRnIbnL3xuQLNvvPatap
         hJ9P0AdKWfhJjWVQvuXfj3mCv1DMb9NxwlVnYUV9Vzq9E09vInVSwjrAf6Q9VRmB9P6s
         RdfdiJFKP0QNJy+RQC9MFfF+tm0mX1+QjBw9kw0Ow79PUijkwu5E1KqjA6WhcmNf3ZG+
         Tz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759835; x=1757364635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOUVRSUkKssTlOViJjAfm2Ry0I5gABWdPNOlGM2jpT8=;
        b=OGCiHRFTGmMAF2n8nMCvExQnmLUX2uXOGim6CpUozwHYxMoOCFAXlpJdOX+L1JbNtg
         TtPdq3J4ShGf3ItCQhPSb6ArzJPjI5b+5CZTuvjcx7/YqKttEQVe2FqjWT+qRh0856+p
         IQrrL7BYM4yHcc5f/S1Kz1tFxJB63Ni7XfT4x1+Iyw+UqI6oOaIas1mJflH96WPqklE2
         BG1m6SiaFjaX5rijkZY/ckxThvSS5gbIzIqruAGIlNolqShptCsFp5QGcY5k4rqCbsQd
         fQRq4NPMkmMIyw4bxMHbE4Vn5lVxjw4TXrll10IEjUb2G2/y+F1Byus7MeYU0QOm6jPx
         Ui9w==
X-Forwarded-Encrypted: i=1; AJvYcCW7G7ZA+RiEZyf/9TSwGmoTdo6IWYnW9MUrj754zKOSL32U25oY+Z560CIXp5KhEnfaOs35yJm0WjewrDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN4YC9UcbXWyrSNI5t3UegMVg65F0EltOke3QMt/ESFt0QS1YN
	UZkYGXDi6TNyeUA4bv1+F+TRABTTJDcw5l/hsukkP9wgkkfqNH5GubyXE2MDbK162Z4=
X-Gm-Gg: ASbGncs7uMbHg6rkkFXiFJzja79U7mldCYY81turpUnl2phN8Ifbhs9ElDQNEG6rH9Q
	IbL8E0b42auPW76efBSUW8azWmbi8DaQRkUpQERXxFUdmSjLjeci1VxrVJj8wFdVBXIrcWEABkH
	sqJeeuq14zG6yW5PgsEUX13AN3NExaPC4Y5fYlA6GmN6Q3HOHS9dwn74iSeaJ877eq8YbjXoooO
	JkmqF8jikk+MArwFvN+4vUd78YpUiIqGif7IVftECky6rsXDvyccxnfPX6FOTdJlKJmjeChEao5
	Kpe3yulHCV3wy+SlXf2FmU5tOeoK8oIa3ZZN1T07w//HZNBU/9KF2SL2lBg+bQsQ86aF0AEO4W0
	A0u7+QjjtjbPw9qJVDcPAazlCYd339DeyWmmzdBmFfUvqjvsnjEkrQVQ8rJVHz3YqG41UxqFeH0
	JwU6Lpp/pisXFj4ahH+XxO+Q+QnymQVT3M
X-Google-Smtp-Source: AGHT+IGigtKDXFUmdSAlFGcDTy1NmHrauWomJBx5FIkz9t/2ArUf43T05qd7+gJYKJea9RCwhs03Aw==
X-Received: by 2002:a17:907:e8f:b0:afe:8f28:fd5 with SMTP id a640c23a62f3a-b01d9719057mr990403866b.41.1756759835180;
        Mon, 01 Sep 2025 13:50:35 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:34 -0700 (PDT)
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
Subject: [PATCH v6 04/12] fs: constify mapping related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:13 +0200
Message-ID: <20250901205021.3573313-5-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901205021.3573313-1-max.kellermann@ionos.com>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/fs.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..0b43edb33be2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,7 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *mapping, xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +585,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +599,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2


