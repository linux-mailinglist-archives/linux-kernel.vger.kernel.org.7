Return-Path: <linux-kernel+bounces-794186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E61ECB3DE11
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0AD318823C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD363115BD;
	Mon,  1 Sep 2025 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="DXEQX+bY"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64C530F7F2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756718380; cv=none; b=MFFIc5Dv/TZciiiM5TJ0A74Mjr5SZ5XP4+5vBkI7hf9N3Dh5iGLrmhHaT8f95gu7ZD7FAVqTPzNh8H80L3R6Ug52/u/xtE99hYmR31ZAFpFL8qQ8ZL8gvhPyUJMSLEA0ILX9+2FmAvUxXDb6aBT9mA0wI8IrM0ZFyCh4HmYdIzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756718380; c=relaxed/simple;
	bh=XjuAxYKBI3IkXJfvQ3kH8dgkzun3QXNzWiHOIferAsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnZAcquRx1xAGyfxsrQqLorj0gO4fs9rCNnk7BYx6iJmYXsOYu318bw94gvvfQCDpGrf6cr63hEZElIqR3rIly1Kkxo2T2HeBq639LKoOeEu1Og8HyY6KE4ofiCGbbiCvSP15O+cqQLw7J1PcNV+KO9znYqLDJJrxG9LX8EO878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=DXEQX+bY; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b03fa5c5a89so214550666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756718377; x=1757323177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3Upj2m2g1j8fphq8NY5txcaBLQgQOVfeQ4k3TdopfU=;
        b=DXEQX+bYXq70Y1f5UkdcIks7JtRa0eSzATZtvDlSFczs0bR/6gCc+iha9hYpBv0ou/
         DXtUscRboTKPE3UCnkjZVHlVGx5L+U4UIzZf5jdPFRBcRgNYr96+JFDtcG1L1+1msW3f
         GfbRMvobUrjslmll54nCCGegclrrk7XCDPRf4fQ1Fpj7glinQMqK9ML8YPwwvBJ27XIN
         6FVMPrptovnDEZaNGEubw1typaLX9/REsDD3L8Ygwwb2YgVjfz/wz/K1fhIRGk9K0iRH
         eRnK1iz4C7sEhvPt68/W1yPZ0Q5SCQ14h3GbbTsbXPX8BkT+V0Lqe1FNMh/UgEgDtaCa
         HbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756718377; x=1757323177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3Upj2m2g1j8fphq8NY5txcaBLQgQOVfeQ4k3TdopfU=;
        b=CDmiz6EJ9xWZQWzLU0gW2L/IuNVNe1Jzbv4ieIX7Ms9S2k0Vgj9Rg7ZUdthPOUSHlB
         TuaGVxF1a9aPPYOV306+yEvPl45IJRnmQ2X7EmgX1icOlNUmjS7AEjuD/rhtnFo4yR2L
         /vyY3/Cx8Yo2ykQTFQSTYiG+xw/5HFYzTxDg4KXecSYKi+eMnUD6c2Cl6N4wOjspa/pT
         4RU8vgMW3tdv4fYpp67uzQxocT3c9OreDKV4g433/hz6hffRQFLViZFjUXSbv5sBd6On
         Vc+OZ0BU63j3+TXo1KOVcz4zbY8cNMajv78YJZ6UGnvQ1RygIEBRWmJbyO7E+r/Tyn44
         UbQg==
X-Forwarded-Encrypted: i=1; AJvYcCVt0beAvqGEvVWrrdXsvLpxIzrfxcZwiYEH1PI46NeP6D7SxPA/V/1xO5mYgZv65pTxK6R/l9FvOaoVKo0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8p59tFC1XdKXiXt1SFvqg/qiIpu97fQh9QNQgmaR3WCdXz8Mx
	6/yVGWLyErxZ70iiLJ6n5r5dRvOv5d4UKQWNjcM7nwuCfaVhNKKvNu4KtU4h9yaDtB0=
X-Gm-Gg: ASbGnctRTyMZcXs7aK2F3Ct1pEWBfxBhYQORthHBVUdpB0/tcSH5Buow7AU4ZM+Krc0
	ecvpIlogzcITQmzMka/G3s9o7uQ2qetjf5wxvgu/So8ZTb2piRmdGbmLpQEJ5Wt7W8P+NodJEx/
	o+612wOxKT8boUbBPMwETVXBkGc9Gn1OAebZJciwFkRVShsL+JWDwk++suWQC5hWy+CjMB6HUrq
	1jD3ozxl2WpQf1h2NusFEa1f6dNZTwj2FbWrbOZyvFi6peAP3HJrsGsNp9ocuxtc6x+5aNuFHik
	HUyv/qSwExvtzelXCzsD0XkbS8lklMVDeqPtR6kKgPsQyiAlFXB995DCNnRKWyTeV2XLMBpJpEJ
	1zJ+bvJFtmu64O4oYlErGwfljcBaCKBrZOuY4fk7COJebtUzbBzqqfrNwT+oVHgPEysCCMs1mZp
	7S8pB6jwMi7bNebBUkx9hrlOI25EFUQamd
X-Google-Smtp-Source: AGHT+IHU03tJneIRXPXjJBcv8U2Bz02uUMfdpAyBKwgR6+o6K1xVYVpx/SIyHdw8wkNyrhH8/CTQOg==
X-Received: by 2002:a17:906:9f8e:b0:afe:c6a0:d116 with SMTP id a640c23a62f3a-b01d8a6b6ffmr681548166b.18.1756718376821;
        Mon, 01 Sep 2025 02:19:36 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b01902d0e99sm541005766b.12.2025.09.01.02.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:19:36 -0700 (PDT)
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
Subject: [PATCH v4 07/12] parisc: add `const` to mmap_upper_limit() parameter
Date: Mon,  1 Sep 2025 11:19:10 +0200
Message-ID: <20250901091916.3002082-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901091916.3002082-1-max.kellermann@ionos.com>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory management (mm) subsystem is a fundamental low-level component
of the Linux kernel. Establishing const-correctness at this foundational
level enables higher-level subsystems, such as filesystems and drivers,
to also adopt const-correctness in their interfaces. This patch lays
the groundwork for broader const-correctness throughout the kernel
by starting with the core mm subsystem.

This patch adds const qualifier to the rlimit pointer parameter in
parisc's mmap_upper_limit() function that does not modify the referenced
memory, improving type safety and enabling compiler optimizations.

Functions improved:
- mmap_upper_limit()

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 arch/parisc/include/asm/processor.h | 2 +-
 arch/parisc/kernel/sys_parisc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
index 4c14bde39aac..dd0b5e199559 100644
--- a/arch/parisc/include/asm/processor.h
+++ b/arch/parisc/include/asm/processor.h
@@ -48,7 +48,7 @@
 #ifndef __ASSEMBLER__
 
 struct rlimit;
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
+unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
 unsigned long calc_max_stack_size(unsigned long stack_max);
 
 /*
diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_parisc.c
index f852fe274abe..c2bbaef7e6b7 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(const struct rlimit *const rlim_stack)
 {
 	unsigned long stack_base;
 
-- 
2.47.2


