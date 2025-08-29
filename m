Return-Path: <linux-kernel+bounces-792301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D5EB3C27D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B68173F59
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4E35082D;
	Fri, 29 Aug 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XXtNS6Cc"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C234A32B
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756492337; cv=none; b=Dw14/R4QxYdHhyxOIA2t99bzmLnGKNOi/OK7qcYhNNwuB4TmpH+gpc/0X3AEh0DW0FDWs9Jkr/E9azmRHJEpMj0TFmEleHG6zGfolUIOy8lNITfQQLMn7YzEChMEqBTeZaSuF3SfsgCzQoxD5qlP0+xfJIQcuHKWo7ovWJozkQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756492337; c=relaxed/simple;
	bh=0NjasZ0/PCPhPe9CzlDUIBAY0i8uA2ErDICpHagXJZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv98YWDsfJqlAXeL+WwudvucRJq3TBVVXOXggQE3Ryh9LSyObjiJEYGe2LJAOAYHKBUWmYZ+kAgM6IjgMhUZDkfNAeuUmePj32jXv52GSu0FkOH0buOG+EYMSD6fUmf2dMGc7YAVQvFGVt/FPUizKGR66ST6v5W/qIl80oiF+hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XXtNS6Cc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so340014766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756492333; x=1757097133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4PHAh511rPGE+8F3ucAdvrwVlVrQ6G4xQcacWJ3jlqI=;
        b=XXtNS6CcmJX++DL1Ym1NvDcb66Qri8Mj+dmKsSa5lT6Hr+LfLWS1TTDgDh9ew0gPQr
         iPFLASK2rQxZP922S4RF+l43qfuNN/g6iAc2vtqGsdKBqJ2/D/O/OvwqimrLWllxiIOm
         vbwP7NdJjHWnoUvFMyYO87VG3Ql7zgMoVpxmOIgOtoXzTbdF0g6AXG1Wu4gu/Gun1CuX
         WidoLvzm89dhLNOkrRv2i/pyqSKC/gP/TdjuBKDuc3GqraFiyD7aNjliZ1ssbF4bYMk9
         mKGkeuwRMKapPk9Ofcbo8k5MhvnLPwNqKa/P1GUQpmk/AVaN1NNgDZiYD4B/AHOvjh/6
         WrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756492333; x=1757097133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4PHAh511rPGE+8F3ucAdvrwVlVrQ6G4xQcacWJ3jlqI=;
        b=SdHasUF5Rhhlf5ABIazwH3KwRrHnZ2HACdIIxAigaDRk2rY9Lbz0gHuILoCE1tInqM
         rKzDV7OhElykyx1AlFboaWtRbQfJMEFhDSD/CqddzSExDx1re92DQRaadNp7/SV76pZF
         opFWPd1T57mBLjnCxZyPC321OM6yB3+vX90p3nAYRmFfEuTVe36mPpiCayqrK5AS4rHW
         PdpNlUr56Z3pljShuuUxVPmunE5lrG/rKrK/WohgOuzXZfrOddlux9S6hKURcLqynC1S
         gizE7/KYKLiJVyOAinhzdzmJ6f5T59k6cXvYEKTlKV4q5VdvfXHb3VKPsKSOyYnO944e
         QCfg==
X-Forwarded-Encrypted: i=1; AJvYcCXgMN4O5LnRTxMO4rnHNM+9+7ZcBVXp+dVjvXvnPIx0r8avLJ5RoJ6fVOZBWjOuL4khvT7+ld4cZ4u/d+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxzY+lR12CNAlqs0eLr1LT8aszQcSZ49vl/3A8Bd45KqU4/j5o
	Yeeob5ycHOjdT+CLlJYgV/4Doe1Z7zJ6vKOXhYjrKRz7WQsXx0P4S01UMeh8bRRe2ME=
X-Gm-Gg: ASbGncvvTI7M5yfIwaenGh0612HUrg3FRDNMMpipKNGs0V+Dc50gQXs61x5PKn6C8A+
	ihedCECPnIFYc0DStqeKwqcNBnvEuQNCXKziZfy/HURiYEh++MUkXfdf7Qm0zNOTxrbYJYgY2Jj
	IiSs4vhRkbTTu+f+6AHJ0lq1bpQBj63yawDi1XTtPOttKbU8eNVdD6Ss9Y04aqzUJEzD7GPqoGJ
	zzRvasD8dSGHYf4A+4q6flEJ3SfsYrvwBZLf1NFK/3KEf/cJCs6HuZ3gciEDBjTgvLcuqEyovI0
	7XE3j5Az8EnyHCZludrfu244R95PYyKB7H8eFSfH0QTVnm1KAiWY1oaXZYAS/CDA8DPRg8JJWMt
	EFHkASZGxH6OCZmJzGKuS77RH7GBvSVPH1S7dX+AL/KdOVC28+GVB2hgKe4VFhyVY4yH4zPIpBO
	GasSS7Bs+DSG19tEVloalDrQ==
X-Google-Smtp-Source: AGHT+IHpRiCf3ba1lpqbF53lceFqttZcUMtU+GGQbLjq1PiES95G84yXDwAe7MA7Rac08dyDihP+Vg==
X-Received: by 2002:a17:906:9fcb:b0:afe:b2be:6109 with SMTP id a640c23a62f3a-afeb2be6285mr1262333366b.59.1756492333347;
        Fri, 29 Aug 2025 11:32:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefc7f1174sm257964466b.9.2025.08.29.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 11:32:12 -0700 (PDT)
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
	surenb@google.com
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 07/12] parisc/sys_parisc.c: add `const` to mmap_upper_limit() parameter
Date: Fri, 29 Aug 2025 20:31:54 +0200
Message-ID: <20250829183159.2223948-8-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250829183159.2223948-1-max.kellermann@ionos.com>
References: <20250829183159.2223948-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For improved const-correctness.  This piece is necessary to make the
`rlim_stack` parameter to mmap_base() const.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
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


