Return-Path: <linux-kernel+bounces-793879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4DB3D997
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2A7179BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 06:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E5E258CEF;
	Mon,  1 Sep 2025 06:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="azLJ6YjG"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A924BBEE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 06:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756707160; cv=none; b=UO87Exwz/wUZiKQMn99heN1xEjRPZ1GjlRomVd7v4TzVx5diIONJtqpRg9uhYKx/R3E45YlJIJ2Bly/FtQhmILRvJOolwysSl0ZMKlYJyQjCW4mecVS6Od846Mk4yRhpozuvwLbjOmO2yMhxOZjZsi8KpvIpPe1mNTZkzgvEMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756707160; c=relaxed/simple;
	bh=olthDLJI/P25CY/9Yy1bG2Hq4xZWX5DBLYQeJhY9ucg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ekEd0PqTHx5M10DPR+A7obfVRZao93s/C71ep5yO7TRG3wZjHLCNfrp1QPu9sUYbIbNQBkSqI4+XXEHPgJ8QK7PoAtoCjQVl4+a6Etn3Qo7oc5yKTaqXMCa5hfORT2GW+vdLEG2jiMXxbLNkXT2hsp0xo5fEuASvooQKGtoxBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=azLJ6YjG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61d7b2ec241so1156239a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 23:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756707157; x=1757311957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDgr77Raexwz3O9eJEn4/d6TiABMKv+OO6Kr02/4yzA=;
        b=azLJ6YjG1d/7AKTWlngt25DoD5VsElUeqt6A8TEjuo8AovDj5PEJqqzojbDIcqcOUP
         RxgiOS7S8xz3mMephDI7gX557TpBcDvO2OeqZRzn037Sved8+9yORu+c0ECh1RX3gjFh
         B+eEP6Nlx0s94J+9P8onnP4lzsQh4Ay71cU7cz0gROrH2H+aW5AUEXya1dTzXrBBitqF
         aJhRvIzjKNuH6KYDbuT8dKlb24PgDajUoDdhyEG1AOpfHXBfDUdRObTjNNnpShWp0CTg
         hIkTFnoCJTmCQoOCK9MnhgkazHUTQ8YCE0vrukiPvOGmDGbBZtjukBs1gnb8WECBEH9T
         m4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756707157; x=1757311957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDgr77Raexwz3O9eJEn4/d6TiABMKv+OO6Kr02/4yzA=;
        b=Zn0Tgp9ZXc4/OLRWQp+qT8dS58VlwfffxHDeQfEzXGftzWyxo0AMQt+XIGlhi+G0Zn
         OlB06ynQLzX7bTAp1dRDbbFWISBKpoNzg6tvlCpFEgZoATxulucj7NLwlC9FsMIw+UDY
         J0VeO2Mgj5Pi0gCP9+Fub5f8kAiWk4sqWzybkaXBrWSIwn5wDrVBC3fsBTLAuVv+XVHF
         2CMf/4ctZGGWgIBpSUulPXlHx9Ma4aNUXNmB9/bquBo3hEonzUFZ4ye85Cij5HGZduIR
         Kx+muNcz/9vxaKcv9DKPOvdgOxaUIJ/HckH6IQ6886678eBJHNMxl8h/UYpo140wjQWJ
         w7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUxl62Ss2QFKySkVg9oSsVrCWzCX+LASmDYxtjEclf4V1IUfl6B56e4oy/vvIQfObLUQqkEW31Xps1dY+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCAyQu413jNBdl12WUXZfBP2NQkRis/EupSbsvf9NSgHRSPIKS
	6IIOB1FAC0J/0cXaFFJVwBOvSKqtHXerKu0dzLuqkXWrXqvDPL2iv4u5XaRMwpZ9Rpw=
X-Gm-Gg: ASbGncvBTCvnKA14vVxv8JZRSO8yBHvnFCX8NyFwakyYJEJqk9ZP3rmt2sHvi7paVf3
	TGT8uKqMCnbUWFbVWRliyDurt6goASbZkO+SAjCxAuI6XkJnlTpS0xLOx9dKN49dZZQjpfn5+gu
	SJ5QovgYwFVdOHhZ/K8ZduXqZdNHkhI/tNosU4RQlItlDs8ob1aqYXOWV5k0rieMmnBO5jJLM/7
	VKUe+K16Y4Fg6WJo15BaLb0KrcyiyptcIBhutWjmL5HysPsEHE36V7C6fmm89UnaFKCc1UE2/6b
	5UZWVLhM3vBxiT5cDcqOvTtXDvG/pnkxPt5kQyZ7sfaz6wd+zZn4xMPT3W2Vw09u9MW7NCl03lV
	BlqskXAC3Dw1sRhYqnkUQspkKRnyCfVajrw0aJdA8qU/nAyOAoRsUwu7zcyijJht5yJPIak2/NA
	PFfpPqx/qLVbWHFs1n9395qcMz4hTs6kTG
X-Google-Smtp-Source: AGHT+IHFcJKCkw/RTMX7106ev96b/+IR0if6QTDEGodFGX5ZCSVjZIik/iqJRJ/PVGIEAJZPuC7HJA==
X-Received: by 2002:a05:6402:44d4:b0:61a:8e5c:f4ef with SMTP id 4fb4d7f45d1cf-61d26c33dd5mr5229225a12.18.1756707157157;
        Sun, 31 Aug 2025 23:12:37 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc231561sm6374533a12.23.2025.08.31.23.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 23:12:36 -0700 (PDT)
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
Subject: [PATCH v3 05/12] mm/oom_kill: add `const` to pointer parameter
Date: Mon,  1 Sep 2025 08:12:16 +0200
Message-ID: <20250901061223.2939097-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901061223.2939097-1-max.kellermann@ionos.com>
References: <20250901061223.2939097-1-max.kellermann@ionos.com>
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


