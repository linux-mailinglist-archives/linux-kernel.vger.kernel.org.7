Return-Path: <linux-kernel+bounces-794548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FF2B3E312
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A9B3B5AB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689C3451D5;
	Mon,  1 Sep 2025 12:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XP7+ZoAj"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9A0341ACE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729845; cv=none; b=Y5gh97J1acPD0o+gEYJ8ZPGAzmyNAYyVixUQP8fFS2Q7vWTbNtCfmaJ87uDIQB5c7IRCx+J6h8/w51pi5tBcIwz/KXkHpadmsEVfzIOohkaeKl5vtzjCGY0hAcd1KNO+cn3Yx7wMPTWAuhk0lppcmzdHIZfr/UbtJg9XjuaUC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729845; c=relaxed/simple;
	bh=JLsm20nRUfCdVD6uJy+GUl3NfrLb9BR0ocnDc7c6Sws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJeP3NwpqHFvLjhl5DfJc/y2bMdtCWKP3DT/wrOPJQ7n21S1YGkH6ax2zGamEIH2zyz6E5DLBsqiY2mT3Z+QP5UgxgoZVbQ5xyg1U4HufQV23Wna5nYYWTHDJYHjy+Y25pwTRtf7ejAnpI9ZWariXmJU1hPDvj3CM1r+dqROO/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XP7+ZoAj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61cf429f4c2so7230002a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729841; x=1757334641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbWUBNes5mrbySu+U4Jj7Tp5fvMH1UIkvlFNU4FTVkY=;
        b=XP7+ZoAj2t+s/GqoFImqvaRcFKXis5a6i5gTR8BK58n5jcvvJvZHMf6vUAHpplIU51
         +SbrYotB8qxVo1h8sLJ84e8ImOgY98uja9OZndbkvHgLgHteEOLQ8edqMl6Eb4uivxya
         /9x2ggMJocoeC/7pAFQi6yrww/lmHDMRDlytUnW84ZYu9FuRZff8dkS5bL1Mc5k7iJ7+
         eChSaNk0sssJNnCct0MtOPjNu3J554hm5e77ImZd9KhHTI6Zn+8DWLjh/cTWTLUamb2K
         B3JEl57OmmcqJ/CZNam1VstrIWRULwuzdFIApVWAKSIKeChVcrm3dkw9iffdQEDGUfmx
         5ADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729841; x=1757334641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zbWUBNes5mrbySu+U4Jj7Tp5fvMH1UIkvlFNU4FTVkY=;
        b=LdOFMbEf6bQRAtnerOu9yxn1Nxgbjk3p+0+YBv7qGCpU8UGmQvcK0Nzb6GV5w5D7nf
         N5WqkwSGa+PYypnyptjYqj8erRH3VCFEECD/aWIIk0kzqax/Q6y9bKwtDNdjWC+hY4TU
         /ag7w7gy7dDfdiY0pvR6T/LHx+HZQSN8N0m/jZbEdowVUj4Kiek+zsl/p6/wFcy3faOO
         s2JcwNUp/mJiXKklg+tTPMQJflnZ2TqaJh3IICuerKVjc7tYjIAMiQvgLYpRBw+IUXgM
         4taP/cQRH39YxcDitcRvWv9WTYW6k7QT3p7twlLoCLuMtu+rFQKGnpnR/LywsmpwpjUX
         T94Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8Pqqgdq82IlrfgOY1vJmejW85fknnsrsAttTIChhoc3NMNn1KB56AZYpKF49LBq6CWPnjvzrnBiiXTcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySJEDa5VSQhm28ymuVhu+cSXPGcFSzmTJRbct0mHPkI2RfeFrl
	GN53EMX6a0bz4E14Xc+nnXWzCKG2Tae19hAMav29UcmkIGP4CEb5DK5GDR4D7lmdv4Y=
X-Gm-Gg: ASbGncvMgzrROo89j2avBa3ebzHZGkRvYYHe9wgKh6/iBLd5Lf+DPTUMXlm/q4U3RPu
	mqPall56lkUWPQacOrEpYwVdYKNsc4pyNo6YZoSivnzz8jV2h/cwgFAP3SVvvn43B+69Axu1JGQ
	9H0R29tp33NXhyriViPkSKmp8QHyLVloGZn+PpKsrTwmhHCHEVjejXOOFfjMjsstBXbXoI8bb2W
	ghEPVnuI77gyLKJwEmwrkYtPIgM4tkdu7n6GpYnTpLM55MyTpjZJig0qb57i3PeeNYObjKvQUT6
	jGsuEws346Wg4Woi4u9FFRnyXEKj5Ye7nfrZwSZ3a+2Wb0dm5ntHo6emA1Syn4tqH47itBtKTbG
	xX8PWKcIIwxPKc1YZi9zrVWvbg9c3uP9Hzlsk9KXeSVGBXXiMVdItttuBseWELrmB3TisXQLXr6
	kAclIPV6aJX/82gTor4kJwpLf39aAVuEyK
X-Google-Smtp-Source: AGHT+IGRe72s+UHTnGokGr7x1pyG7G81cHBjYzB5waC3bIIZTDAVVMuEn5lgB7KxjuKhIwvrTnRPsQ==
X-Received: by 2002:a05:6402:2554:b0:61e:ae59:5f04 with SMTP id 4fb4d7f45d1cf-61eae597256mr563365a12.27.1756729840654;
        Mon, 01 Sep 2025 05:30:40 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:40 -0700 (PDT)
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
Subject: [PATCH v5 04/12] fs: constify mapping related test functions for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:20 +0200
Message-ID: <20250901123028.3383461-5-max.kellermann@ionos.com>
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

We select certain test functions which either invoke each other,
functions that are already const-ified, or no further functions.

It is therefore relatively trivial to const-ify them, which
provides a basis for further const-ification further up the call
stack.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 include/linux/fs.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3b9f54446db0..8dc46337467d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -537,7 +537,8 @@ struct address_space {
 /*
  * Returns true if any of the pages in the mapping are marked with the tag.
  */
-static inline bool mapping_tagged(struct address_space *mapping, xa_mark_t tag)
+static inline bool mapping_tagged(const struct address_space *const mapping,
+				  const xa_mark_t tag)
 {
 	return xa_marked(&mapping->i_pages, tag);
 }
@@ -585,7 +586,7 @@ static inline void i_mmap_assert_write_locked(struct address_space *mapping)
 /*
  * Might pages of this file be mapped into userspace?
  */
-static inline int mapping_mapped(struct address_space *mapping)
+static inline int mapping_mapped(const struct address_space *const mapping)
 {
 	return	!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root);
 }
@@ -599,7 +600,7 @@ static inline int mapping_mapped(struct address_space *mapping)
  * If i_mmap_writable is negative, no new writable mappings are allowed. You
  * can only deny writable mappings, if none exists right now.
  */
-static inline int mapping_writably_mapped(struct address_space *mapping)
+static inline int mapping_writably_mapped(const struct address_space *const mapping)
 {
 	return atomic_read(&mapping->i_mmap_writable) > 0;
 }
-- 
2.47.2


