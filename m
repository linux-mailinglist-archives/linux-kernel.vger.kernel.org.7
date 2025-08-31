Return-Path: <linux-kernel+bounces-793299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0198B3D1AA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D7D3BC4BE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBD25783E;
	Sun, 31 Aug 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="A/muhf4e"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2854425485F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633184; cv=none; b=Jin/znNZUwySmJmEEKKp+62eAqyu34Oix9g9lKEaQhMKrcM2V/n52E9DuV6giLVOMw9FnvhrkkGJNRlHaygfXQkaEgh5PZgQLTHmZ6+2XDrXuMTKNpCB5TnmwqrA86Objvt7KrU+qBg4sg7kTGPKXWUCFUOScEuy2c/Ify5rijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633184; c=relaxed/simple;
	bh=ejSn0quWJbA0KnwQ52zQ5YlORsFpksDHeWoc9CICxbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9nLex+VKlwdY76L1VQk4du2ZKWd4krYYORo2leF4+GrK/sRSd55OW9BfDgrQj6DmMb+G0xWDImXeh2LpYzAxTohXyDBjYoOd2JfN9zI0SnoNnOdQ5rxW/3djvvi1kujgsGmXF5kWmKSEISOPseQmX5o6GbAG00PujMYS5px0y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=A/muhf4e; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb72d5409so608147666b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756633180; x=1757237980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI2up82+VzPNoEGOK0KS5pECnWl2zWb60qbdyWAfei0=;
        b=A/muhf4ej1CWlhwfo0sGG/UxBWpAZ1OsVDKasJLk2qxSU9vgHsE8P9QvH/UFYfA0PS
         Z9mimmS44UER5UWht3vTPfcOKxFWSn2jiTEdo+1rgOpBdy5tzY/ezuL5BVLlDnOQGCcH
         ssHpqdx47iW3QgZ3yNE0EkOcd0qEQq3P9HYHikOQScQwrfGnN1bS3JBjTIUIB77N0N5U
         3y/YXjqE24taC7CBo+j24PO70Kelm6EvEHviTMMu29cBftLeWSQq6gATGDuxxzwaCCLP
         0BpEGfUFSwGXgfdEy7+3eiSWbICj6ENkpUE2LhWs+zLR8FfnNs7qGyAb1ap24gzNj0V0
         pXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756633180; x=1757237980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI2up82+VzPNoEGOK0KS5pECnWl2zWb60qbdyWAfei0=;
        b=YoqfrD96U1hCMVbjfKpZaUYTfDOi1Cm2ELToyrT+v+2alqFyEi1WPV5OVHByAKIa0M
         PotvRkIDKh86SqD7I9V+UaXrEK8N6pAXg8mOxa5USfrSHLozLQ1YwCbe/rDmrktYDOAq
         jBsTWSh36YopTF8KxasHC3/0I5t5iIw0Mgrmd77cYnuFuKzw7efL+RHQCNgrdi3Z3aYs
         lvbN0lTZnoTtysluonZJid08O68omlovet4oBfx5cdgGKLCYUjZuxjxO5uCPwKJYHbye
         cEHpPL8whd9FKR3lTpf6gZ5ze5vvakaItdWEZHpzlyuAvcp8xxCy527n6M9KhXriGV0j
         /WKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN2WWs4TduioQFfn22iT1kPATY77ng4U7muvJ1tuGzJzkZA9IHYshg6MhF/y8qmbBIhucLS+0L8a74SzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWa20oM6YhV3N4fmtZXz0pTrDV6qlCEZOWxC+kTk8Hl+pkrT3
	L1v2Rw29pmvzXfLIP/ywJ8x6wMXVUUI+pms2u1oc7JqFZa0IKa/HH/cCggB4GlcdhYs=
X-Gm-Gg: ASbGncs/7QkQ1qlXCV1px9HRSr4cXgL8hmifEhknzBDnqPafvjFDSPazYlQgWNMbpeL
	DYIp14EjmptygTzsvg22zU/sw8zaAhvW+NsQIt3ILVG75T31MqyP96DMPhbV7jvb5KWXKrLh5O0
	Z4oTVrPNG/MfQFwMLE+gZSMRLkavdQ1DNVxxM7qri24pg39zFXbxRJ3w3a0NCffDNHngP5Ri8kv
	E0JIiaYJZFLjK01XB3JjrSLcX/cUd2RCVo0/iK71rzQa7IZHmZeRaIGwgborojLb5w4uJntM6BI
	7DNzjXlYIYSPapRpOv6H171IjmfyOPbwiJxteMyB7qmFO0tuxyfoPRvydCLkTuewu8G6uSZwAcw
	okhFO7Vysv8Kw4FBf46NDLuKOLFREeVYXpBVkM2yv/P3ViqDVzfAWZa7zdBrfsg4tEU+lBRMkNh
	+TZRl2Ux3h1HD3hKACANMTQg==
X-Google-Smtp-Source: AGHT+IFglY590tDBZGAnHSO9yYGk6iJO/gJRHJ6p8/Jsd/CDqMqAkjlpLSX7631ptCWtGbwIvRvDjw==
X-Received: by 2002:a17:907:1c91:b0:afe:c459:e663 with SMTP id a640c23a62f3a-b01d8c74aacmr415085966b.21.1756633180414;
        Sun, 31 Aug 2025 02:39:40 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd8656sm597512566b.56.2025.08.31.02.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:39:40 -0700 (PDT)
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
	vishal.moola@gmail.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v2 05/12] mm/oom_kill: add `const` to pointer parameter
Date: Sun, 31 Aug 2025 11:39:11 +0200
Message-ID: <20250831093918.2815332-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831093918.2815332-1-max.kellermann@ionos.com>
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/mm.h | 2 +-
 mm/oom_kill.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a40a3c42c904..1c18b89c2d28 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3840,7 +3840,7 @@ static inline int in_gate_area(struct mm_struct *mm, unsigned long addr)
 }
 #endif	/* __HAVE_ARCH_GATE_AREA */
 
-extern bool process_shares_mm(struct task_struct *p, struct mm_struct *mm);
+bool process_shares_mm(const struct task_struct *p, const struct mm_struct *mm);
 
 void drop_slab(void);
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 17650f0b516e..2620b32a8eba 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -490,7 +490,8 @@ static bool oom_killer_disabled __read_mostly;
  * task's threads: if one of those is using this mm then this task was also
  * using it.
  */
-bool process_shares_mm(struct task_struct *p, struct mm_struct *mm)
+bool process_shares_mm(const struct task_struct *const p,
+		       const struct mm_struct *const mm)
 {
 	struct task_struct *t;
 
-- 
2.47.2


