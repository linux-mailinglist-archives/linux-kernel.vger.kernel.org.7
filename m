Return-Path: <linux-kernel+bounces-795322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2762BB3EFFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188DE484E80
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E42027AC2A;
	Mon,  1 Sep 2025 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RqAwSCd1"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C2279DC4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759844; cv=none; b=NkJt6hA1PXTR+yEkeiKcWf8+9RzxwQSR80ogcr+4APmKRmh5Np4suZVBNpiK2l3Yk9IkBe1Vn1N7inbvScfpa+cyJAx1unKKPzZ9bAU1ZRnUz+wZzRVJGKmnsR2sS3wuoLrFN0qZYrDjVGCiOuzi1zGC9J1U4fDTn3hoxckGkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759844; c=relaxed/simple;
	bh=mdsrJUeGrkHnP8zL/eyQeyjJ3gnG2ENBLTOi4VtzzWI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiNlQgZQbqFJ3tkpsJ+TPYEoACw2BVXxyeE8ugOltMD/ytfu/tAFYvdI1thLR/cs5g9Vx0hE/axHeA+JnaUR0UnbzA1BZAUlF3D2pU8sIjOKSKMkSLhvaLHcOKGUnlOPSnIMSXMiNkNbpEohIGpVZm9bzXMQPSqCMpyPY4wT+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RqAwSCd1; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so10050679a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759841; x=1757364641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JbC8N+XiHIHVwpnYZGh3ddN7VzXCXgVoQGtIXVqNTy8=;
        b=RqAwSCd1/MuaH+RNfTQfJif/LUGNnb9+rRIeKmCE5gnIsAPL/QtpEw9jteEXBRg05P
         QbqDNV6IDuvYXvEzLhen9SU34igihvQEZEVcHV3cg5KCfbCpfT01SiZXYWFGNTBKD7xM
         Py+HlZzjhr+6Po5dPKpWKUvZVpEKbiNwEDzMdqEih1P1yiS9Y6eA277wuTIE9H++kXb0
         sn8hJrKBzDp7bK4ffQ37BpnMvwqA5BXpj/l5yO4UZ38YOGd+PD0l7R0Xp+sIaPsYntod
         zGt0Dtzei/Z6r8vFxt4C8/yDUuBS0WOPJdI0C/ypqTRxoaxz27nONjh0FPC+BdRsM+Wn
         qRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759841; x=1757364641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbC8N+XiHIHVwpnYZGh3ddN7VzXCXgVoQGtIXVqNTy8=;
        b=peJmFxI1eiUosR6bTVSqUAcTTuqEPz0cqh30Om4FICJBnD1jYAOSwJ0gqaJJedHhTQ
         kKDr1Km5vk3g3hTBc5xYTxtfBJ1mvJCBQVJqxqj5PhaCydknBgs8tqjxwItVw6u/VHRX
         9g79uislwgE/LeCeIlWwhfQnBg4GEM+3Iiqwx27l1wGr+/KXc4Zh2l3LeEZK8ve01YKV
         jhH/UFdHW86oSdKczoPJHpoQi6QLmN1URslF6fDjG1HzGIstySvYeCkTBUnb64HeLHtc
         KRlYFJZNor79QLzR6cD1ddlU2cSrU7tP7nInCzYKnUYVy0uPrNe9YXhapgHwTylHhxIz
         g0yg==
X-Forwarded-Encrypted: i=1; AJvYcCV5gWrTG7OKl7cqWwFHdflQNXzu718xmzQgBpS9FRa8yOlBtf4flTk1HUGmnSAREg+gSGwYteIuciI8YOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxaanTLd3PUTZ8yZTL336oqq8CxINqythtGIXjmbYqee/YR1n
	aP6hhYh8whQ4jDfF84WgHltEaWgDrwbtMvpUyueC5VSUyN4ovp2cW1xmhVWV/kD5uB0=
X-Gm-Gg: ASbGnctkqygVVIXGYWinNscyCOcRjp35A1Bwzl7Z6BH3s25aT4dR2a6Gx3ThpkFMUfZ
	2oDSoTfPy2SghP66gqtLhUS5QaX1QYPjAPCtOcwaxmVjqTMC8iC4GOInHbN7cCKq5qiTaKrX2Ux
	R8yLltTfMqm/JEsKvmKkaNz7Eut+if+IiL3DK0hsKMxjJqfSYMo2XsYnfyif//q3FE56NUXmL+S
	2ZRrUrQfqpj8smTJmOFbho27duLR0cQG3gMqh+Q6VCpWY5YWW5PJhCiHTMVq2h1+aDNNGv20cGu
	08QNF2lJBHTG2K19v90GwdRHpmp226dUZCTipbk+3Xe8lu9qMLF0hjYv0nvp7ppzymNb2N5D+nP
	JjtTMWpkdFNzQx3Z/Xcp5Ht9f1FnvObkZ+/IM2I6GtQpNj5rjR8M0vVPjMsqMaRqmd+Fh4G/izS
	8hZRnorUEBEHKnDAyVkVuykFMPVHW2Ph3C
X-Google-Smtp-Source: AGHT+IFaWDHYij5j1CBdsPx53clPCy+ttl9kO3s+0ZW4mKhtLHQkGphieDUSAGfH3AkYqVOXY7BH3Q==
X-Received: by 2002:a17:907:6d28:b0:af9:21ed:6ebe with SMTP id a640c23a62f3a-b01d9754485mr912367266b.21.1756759841055;
        Mon, 01 Sep 2025 13:50:41 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:40 -0700 (PDT)
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
Subject: [PATCH v6 07/12] parisc: constify mmap_upper_limit() parameter
Date: Mon,  1 Sep 2025 22:50:16 +0200
Message-ID: <20250901205021.3573313-8-max.kellermann@ionos.com>
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

For improved const-correctness.

This piece is necessary to make the `rlim_stack` parameter to
mmap_base() const.

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
index f852fe274abe..b2cdbb8a12b1 100644
--- a/arch/parisc/kernel/sys_parisc.c
+++ b/arch/parisc/kernel/sys_parisc.c
@@ -77,7 +77,7 @@ unsigned long calc_max_stack_size(unsigned long stack_max)
  * indicating that "current" should be used instead of a passed-in
  * value from the exec bprm as done with arch_pick_mmap_layout().
  */
-unsigned long mmap_upper_limit(struct rlimit *rlim_stack)
+unsigned long mmap_upper_limit(const struct rlimit *rlim_stack)
 {
 	unsigned long stack_base;
 
-- 
2.47.2


