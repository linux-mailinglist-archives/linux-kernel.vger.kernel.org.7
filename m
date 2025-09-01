Return-Path: <linux-kernel+bounces-795320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CBCB3EFF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE348202655
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C6A279358;
	Mon,  1 Sep 2025 20:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="WgByGC6N"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA98B2773EF
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759840; cv=none; b=elFYOdSBOLnUb9Inwu01wg1Wb+NmHuYE4G65BHoJLRzhcEFqYgXzw07sr/hQlxKgos3jm/0lGuGm96ous7d/jBoqu/d5OdFvr4jkKggZKWapcEKxVVDNmC6NlmESyY2ySQUzK/MS1qir3pTPZgf8wTVBokj+S8ax/ZzQFfuPWpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759840; c=relaxed/simple;
	bh=pIfWjTspfVpzMSCvftG/V3B9Wm60B/72pG+k5Selb38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNWjhpkOStiJbXliEIm3e71gdfM0jJXnQKzf/Ob31i6e2rAavsrAZoEPvdKDjhJwmTO9+IOeBOUfilgqg1PbUP5yM1Q4oSj+Lv2D40s3ZYBtyNy4sgKIigXC9tJLASBfEGsZSFtLqYLHFYo7rON9/y9U9kw6e8fDQDrZ1Q3ZWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=WgByGC6N; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-affc2eb83c5so413222366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756759837; x=1757364637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1NuH6wEtYyVWN8h/tjwWnU8YD95rrkeNOHDYWS/pAsg=;
        b=WgByGC6NSlJR76DFMsCh3TbOuWDHYmmut9svV5zqWVLCNb2irhPSefTDsy3Fgt1xAe
         /qZFWmgwyplyxGVhxeJBKnndKGspwrntEcGMqeGDtGCZiK19PtNEAkGkQKdvO7vKZCh2
         UO9hew9rsRZXQ0fjM5K1UJDO/+PYrxysRjn8132+uVCHCJ0H7R37uyX9DlAEniWYoHAp
         pdvbi0pcxU7/l9sV/Q6GcEh1iPXnejY6x/AQ8aHXUGQfKEFSKFk4wrGyyVj/VqetKIIj
         prE+bb+OrNfy+D9+paZyG3U6vLfEfQbVbzKBUM2Jva+/Mmmy91D3nJOQQmemKZ02jknX
         oYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756759837; x=1757364637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NuH6wEtYyVWN8h/tjwWnU8YD95rrkeNOHDYWS/pAsg=;
        b=CHR400TfaysEigFGVFWqkjttyvM88ZDM5tPawGIzBIksi/PIO0ne+qzK4jOrOSnyPt
         gW+WAz2q+uPTirAlT3XDiGUq4eo8JWdDzT/0u50A1uXc0Hha+jIpiOdt4YVYnFS79xo3
         lwFSp6ZQhp6n7RBmI0qGdkfbq9VFfz1vhE2WkshYwETYFHwSVlnYRcZJsAsXNZV/W+PR
         LwNhZuaw2wAR7L8hnzj0CMQ99OkgBF3PzH4Tp0GfzLpn4EcQDyl7BqtwE9OL6VKYNI1V
         JjyGYQVeT9Fio4j3XRjD1kcRd+XXjfg72u0KdOOW4ey3LYSSLw1yrezrOImYFL7Vuz02
         RLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdmABPajoXEFxLH8z0+79n776WB6oQuoGzZnn4kMaUpQv43vtygGdEP/o+u+c5PH8qk8mfS6nWjM7Jikw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxllHyLzurYQ7H8h+wSsNJumiB+o3hLxJ1XtCtYOPgfIthvezrP
	RZwMvqxT159giCqIT0+U3Q6hkevfXfs9Qd1qnVTZxpziir+SXqMNybo+XRBjd7S/8gg=
X-Gm-Gg: ASbGncsiJpZczswF+QuJKpFH6SyEwfpcQ0AF2aTx4vEZSz7RskSgSdLNf1VUE3r100t
	+pW9m8T+kqkWtlmA0cyqR6EAIXmXf7JjzQjvKZIEjlw7jLGH7jXaomZxFH/x4fNpY0Al5DpC7Ea
	X9/0peuV22XtbDm6kItDwx7d1Uc0xtJzJ/wBbrx9QHz6UKgYZ847SjJ1U4hAQfPgPuQTmd1wrM9
	s3ypOlNfH/FhB8Pfl6dhkELwzYNYLxKDdw9RHWRuSPuMIq9aUHSkjATl8P3koKgC6GifU4H8aBi
	kA8heZ0BLtf8xhflsyDbHhNye58H9Fy7ZbfJ14dw/FlkhfPJnFo1no/tDCraTO7ETF1AoA/3UZf
	Br5Lqw6eoM121+x51EVGaz3omQFawrbP7holKu2HhnMjEsd6CNRqq4fg+c7tUQ9rdiWQCVvlopG
	vwzLq9GHmFw5Lta5ezOkzq8Q==
X-Google-Smtp-Source: AGHT+IFXutjj9GtlvsHvyB1kBP2ci7mQOIWVVvptrXf9bm8LYmlGCi75h3LAGpjp/G/Rnzqw/keEdA==
X-Received: by 2002:a17:907:3e89:b0:af9:e1f0:cd30 with SMTP id a640c23a62f3a-b01df53b7c4mr910004866b.60.1756759837088;
        Mon, 01 Sep 2025 13:50:37 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd9090sm937339066b.69.2025.09.01.13.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 13:50:36 -0700 (PDT)
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
Subject: [PATCH v6 05/12] mm: constify process_shares_mm() for improved const-correctness
Date: Mon,  1 Sep 2025 22:50:14 +0200
Message-ID: <20250901205021.3573313-6-max.kellermann@ionos.com>
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

This function only reads from the pointer arguments.

Local (loop) variables are also annotated with `const` to clarify that
these will not be written to.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 2 +-
 mm/oom_kill.c      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index 17650f0b516e..58bd4cf71d52 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -490,12 +490,12 @@ static bool oom_killer_disabled __read_mostly;
  * task's threads: if one of those is using this mm then this task was also
  * using it.
  */
-bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
+bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm)
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


