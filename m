Return-Path: <linux-kernel+bounces-827660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B5B92573
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 692E37AA83F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1302D3112B6;
	Mon, 22 Sep 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcmpjiOO"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B51ACEDF
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758560671; cv=none; b=l0CqtXWpirHlsC3SpcCqnGw6vnwGdunV1UCHdx3f4tjGz+eZ14UeUqZkcGuPghRGeF/bJ8tPtHbqBBZSOHU8gS6xuiBpa3MZN8YnkAP0vMy/YQJJJYb7f19V7rNc97QjPodk8CAfTzBGBav37FzrrLptxI2kENjfDOfcRbxwEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758560671; c=relaxed/simple;
	bh=wyAJ+dw6+0xkuSAfp7XvJJhDyY7mJhDVkZ4H6eaoR4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S9Xp1koxewn7pDAHdyUz+zZscSw1po1ZiiCQTf82XgIoa/IR5ebGhBFWwTR9QJkxfNGDQFG8rMOlv7BQwQZsBZZ5GUGGmR2IIndWmIRyVPiEllNeWByl3i29P7SNfR0cAnMUsQa2jmY5oAPr1NGah0BSWCvv0fiPa3LT3wTrjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcmpjiOO; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b555ed30c1cso136044a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758560669; x=1759165469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc77MFzorwqtfxO6TersZ0PGs14XrPU5kx6kkJpwm/c=;
        b=HcmpjiOOpf8e5AQHZMZp9svlJUVb/NIp/dc9deEL57QdmbYcPFCnxn/c0lOWE5I6JT
         o5PyfA0jxrHfke1q/6ZfbV9SRU+e72U+shym6PaN36EZuw+8rWERoC2ybpKYgq4sKE/t
         7F7ZXv8c+8g8KNp7JTaNa2aLIKIRDUI117XzdvXFvErt+91DVFR5Ksxt2Lo/R7taftns
         W4eLuNZoLa0yJ72A6q4t3x1JKT2PeQbuZOYTToBAOVyrlNH6oQgUsjgt3ZgSqKkWNPCH
         kNLWuiANP28SbFeNySX6GSnfrHPUTWfcEaaquiGqZLwGFwCyfJpNHrUSOS9u6dm3d1yC
         ou5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560669; x=1759165469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nc77MFzorwqtfxO6TersZ0PGs14XrPU5kx6kkJpwm/c=;
        b=t/UY6yoQuu12Ebm+EBjwPai6ejsyRpQRYOqeaQ2GzlP9WpUz5RpEz5TJah1ysi49dm
         gQkI3diuMaJt2wnm2rCwl3xsN0uCSFSjAIKDTL4hXl6EH1NzZPf0nBG7SXBE3wzEhN9X
         pkd+proUyy6pZPo9tGQbZeVh9VIcE1FhnP9HaUcEF6iq/4NwkXWqNDOI+gNWTGx1B8Qt
         83J6pyOvKX5unA2U/PYCK2oFpgwxDPNlq/yebb//KCFh8TNXmGCL6mKBGlyj7kPYSwhb
         JRpwWT2A8cdVrR49jPWngMF6Gu1PHks8QWvlEMa6DY48NMISFUypdrVg+CbA3bPCaeX1
         8Sog==
X-Forwarded-Encrypted: i=1; AJvYcCX6O+CmD0MACZsxPka6fCsaTIBKeVbrKUL0MiCdO+hsUTFyx9eEDuI4+9rymEcHIracfSjjNFX9soNnfQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8nukITsW5YHrLcZEoQ64iZM/rKa9jNj+s4M1qlZQteVpDY+tF
	bpnK+CX4/0SeMCN34dnm23qkuUTODJLnyO3aNFUsZZMLeUiuTku3lui8
X-Gm-Gg: ASbGncuO8qASyIjURbIYvGxgDq7KuWA+4yYHT8xpBlQdUWBVi/TVbCVjLB08XiHyHxa
	T+3+l5nSzyhBHMXEss2LHfl5rsHDKJEM2yKTF8kuexrIfymwX4k0sC+qOVicrXLtegZzJzbKgDk
	0Kf443moidCp1u3dq1e8XxoCxT4myBlzDOc/LIPOYETIkuNbKfpMbbHy/92SnsRH8D1jodJ7VrL
	+BbjEQbl8CK3C9At3qsip9FBnSBMaLIG38ZK0CWRHHLN/mnaPH5HBvGne0oQvL+Mgh0omLGE8Z6
	dZlynOJHezgDa6W2U47ISOTVuTkkbSLHsFGY8L6LaKMxti3HYjau3qm8pwL4+yxflX/+DBgUkOb
	kEnz1lJfMHpUTyjaK+IA7n/n9lizIfX9F5vLZrrUITTAdu42evpSr1q+Ohg9HajEvMEiPqy5wzx
	BfAj6BaPmDgjbr
X-Google-Smtp-Source: AGHT+IGsd8HkhcTtxst8+Dgce85bwqndE2KThGl7pjmFBv8FiVKOmjblKihFJmQw3vbhuDw9HB4q/A==
X-Received: by 2002:a17:903:b48:b0:264:1afd:82e6 with SMTP id d9443c01a7336-269ba5628fdmr135333825ad.53.1758560667816;
        Mon, 22 Sep 2025 10:04:27 -0700 (PDT)
Received: from debian.domain.name ([223.181.114.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980310e41sm138227825ad.108.2025.09.22.10.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:04:27 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: vbabka@suse.cz,
	akpm@linux-foundation.org,
	cl@gentwo.org,
	rientjes@google.com,
	roman.gushchin@linux.dev,
	harry.yoo@oracle.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	I Viswanath <viswanathiyyappan@gmail.com>,
	syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Subject: [RFC PATCH] mm/slab: Add size validation in kmalloc_array_* functions
Date: Mon, 22 Sep 2025 22:33:57 +0530
Message-ID: <20250922170357.148588-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported WARNING in max_vclocks_store.

This occurs when the size argument fits into a u32 but is too large 
to allocate, i.e., when it's between KMALLOC_MAX_SIZE + 1 
and UINT_MAX (both limits included)

Add validation to kmalloc_array_noprof() and related functions to 
return early if the requested size exceeds KMALLOC_MAX_SIZE.

This seems like the most reasonable place for this guard.

Would it be a good idea to move the check down to 
the lower level functions like __kmalloc_node_noprof()?

Moving it up is not a good idea because
max_vclocks_store shouldn't reason around KMALLOC_MAX_SIZE, 
a mm specific macro.

Should the Fixes: commit here be the one in which this file 
was added?

Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 include/linux/slab.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d5a8ab98035c..6db15c5b2ce7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -943,7 +943,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
 {
 	size_t bytes;
 
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
+	if (unlikely(check_mul_overflow(n, size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
 		return NULL;
 	return kmalloc_noprof(bytes, flags);
 }
@@ -973,7 +973,7 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
 {
 	size_t bytes;
 
-	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
+	if (unlikely(check_mul_overflow(new_n, new_size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
 		return NULL;
 
 	return krealloc_noprof(p, bytes, flags);
@@ -1013,7 +1013,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
 {
 	size_t bytes;
 
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
+	if (unlikely(check_mul_overflow(n, size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
 		return NULL;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node_noprof(bytes, flags, node);
@@ -1059,7 +1059,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 {
 	size_t bytes;
 
-	if (unlikely(check_mul_overflow(n, size, &bytes)))
+	if (unlikely(check_mul_overflow(n, size, &bytes) || (bytes > KMALLOC_MAX_SIZE)))
 		return NULL;
 
 	return kvmalloc_node_noprof(bytes, flags, node);
-- 
2.47.3


