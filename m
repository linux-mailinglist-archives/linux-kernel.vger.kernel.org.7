Return-Path: <linux-kernel+bounces-794549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DECB3E31E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7A76189CC5E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE79A34573D;
	Mon,  1 Sep 2025 12:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hZ5F/T7b"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEE3451A5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729846; cv=none; b=sMx52tProqD9akVl7QSIe6KoTeQhk7fl/ouPaJC1kLlG9r4zAi99pdwjuNadZrkArNotUBcCY2ayHTD7VQImTsmuHr21Fx3S083gJddRLZTN2079FnI8O7DRC6XLafOSirhHUi6NaPC2Of2FPEODMlcB6V4AJCX473iPSym4NEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729846; c=relaxed/simple;
	bh=+cxA2vPSNHRr3wvM2KI++2tH84Pma8OrgGCHv4aVaOg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVAAqDNpDosQCBsPGP2wDx8KB0OZ68DZNhVSI5hSb4dTPt/q9BYK2dxPusKq/4ete/MpZ4jJUjC8Qve8NADzqcgzK9eHGhpnkafU3r0WHuMnA/O1F81Ew3Qe8RgPgA5vpk6+dQ7j4V8BSJd5AFuoKNgAHK7kWuDCj6/RbiByt5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hZ5F/T7b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b5ae1e8so4338882a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756729843; x=1757334643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qlcCpJbD4nPkPuY3yUCOwN5ViUagWq+iHpO5z1mw7KA=;
        b=hZ5F/T7b5ogdP2zIwS2beyZHiGHk1+XC2eeXxcULdlvnW1Qfwq3v3qhdS3HzZ/ke6i
         5aofx44Vci3okcSvD+NJ5d8aUUe81DaRYRI62gRGHaQ356kUTRWx4PGjmcbA7+R+Kk0W
         w5CIFFJJ5MwUK8wOchLuAQ+cRzKPe2L0SPg0C9B92RKpjNxYzM8HJ+ZB9Jvd4NqCxnuc
         FosDiN5pEmLLsAP/Xh7OUY6aKsvmoVYIgNzs6L/oiewJa/5mjN6m0MCx3Jo0RwHJf72I
         eE9i/UnBEou8WSX3ZjYyB3V9cbrUZX3eF8vQR8yykRh+Wj/Fw04dXjpcJtR9Yx5tP11D
         Mpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729843; x=1757334643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlcCpJbD4nPkPuY3yUCOwN5ViUagWq+iHpO5z1mw7KA=;
        b=kgy94i3jAUJVLewwymJfoEUG1oIekv32ts2fWwkpx5Irj+zNsZX1U4U9gDOGEBd0ev
         ay+lTsMGkESGELlrcDfTufgiASChfpi00+hcMLdxjKP+tYDD/0NNWiS7WL+wOaAnd5tT
         IH5D+GyQ70OAi4xANeqobiHZkHkEP5wiIKaPZqucjbdZ2BXeIN7ca2Td/6g1GMMjESXU
         GNHgtEWu3TrQhpkPOUYwgeeO89mm5GJdyiM7gkDmdzCYbpM98vfk9wuyVQrthg9ulplL
         wVPzC81RqQ1Ff3tju4ZlsJ0zCECb0c3riR6rzW22B8U+4WC3kqmn3QyV5yEvXWPoBRWX
         Xn8g==
X-Forwarded-Encrypted: i=1; AJvYcCVt6X3D3u4HfhNL6eqasbDat4A1RrXG2F68miCw1Kd9NdPSeOADJCPYADEuciVyyEqgqQlEH91Zdt/Av9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmgMNXnbO13o6pybvLCM75o/aUJCqgrzktRRLvj9V1g+NvKuTt
	L2jXpiOTLYxNrev0c7j5eeuNCDruEfxyfZraRao+3HQqgqxc8/DN4aZc8LM9ZzQcNuU=
X-Gm-Gg: ASbGnctPuBavKS4Q2ZDuf4+eV32ZnIhd22zeO41MA7r9qSCrmHlrFt+AOI2oe0JXV4I
	Vx95VsWj4ne4rN2za6mHRoNFngtRIdewjFyiSGV8x4wjeaW4dyoHrPeJTAzZ8mMeBhgJXpxiS5o
	iZDf/gt4frA80ub02XCyEtGfWV4PkiU5EkAI//mY00niHlqHWRIBbA1lcvRJk9gLIgWge5oOs33
	oiiTN91B9jW9K4pG22kcAxui/01QILfSsMISfSipSDhCA/JG9wqea9HgBDaU13LY7heCgHZrtlq
	D7zSQrU6DhryCSm97Koh2xASUwGGW8ejzF6JagIXtP0UW1hEl7QVrJD6zw1R2wMVeCVOhNNqPHM
	KP4sdprh1ZL7uOK/us45b7ac/Zz4h6gxqcQcfo+7/YjCtVNUQowdENGTm/ADEUopjt8Q9sBdxdD
	ucc4LPrWkpc1EnzhPZw2dFow==
X-Google-Smtp-Source: AGHT+IFO4D7bAoVhJtV1jctvP5v6tn3ybzaRVaB/XhRQIb32ZxZbdyWzguubllrCoRGqVBHHdeayTw==
X-Received: by 2002:a05:6402:52cb:b0:609:9115:60f1 with SMTP id 4fb4d7f45d1cf-61d2699f676mr6340759a12.16.1756729842457;
        Mon, 01 Sep 2025 05:30:42 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61eaf5883b6sm255566a12.20.2025.09.01.05.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:30:42 -0700 (PDT)
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
Subject: [PATCH v5 05/12] mm: constify process_shares_mm() for improved const-correctness
Date: Mon,  1 Sep 2025 14:30:21 +0200
Message-ID: <20250901123028.3383461-6-max.kellermann@ionos.com>
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

This function only reads from the pointer arguments.

Local (loop) variables are also annotated with `const` to clarify that
these will not be written to.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 2 +-
 mm/oom_kill.c      | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 18deb14cb1f5..f70c6b4d5f80 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3840,7 +3840,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 }
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
-extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
+bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm);
 
 void drop_slab(void);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 17650f0b516e..6a888a5de2a4 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -490,12 +490,13 @@ static bool oom_killer_disabled __read_mostly;
  * task's threads: if one of those is using this mm then this task was also
  * using it.
  */
-bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
+bool process_shares_mm(const struct task_struct *const p,
+		       const struct mm_struct *const mm)
 {
-	struct task_struct *t;
+	const struct task_struct *t;
 
 	for_each_thread(p, t) {
-		struct mm_struct *t_mm = READ_ONCE(t->mm);
+		const struct mm_struct *t_mm = READ_ONCE(t->mm);
 		if (t_mm)
 			return t_mm == mm;
 	}
-- 
2.47.2


