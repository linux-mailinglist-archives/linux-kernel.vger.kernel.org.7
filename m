Return-Path: <linux-kernel+bounces-734900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D726B087E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 10:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACDC4A5DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA4227B4FA;
	Thu, 17 Jul 2025 08:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxex3T4f"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198FF27A468
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752740976; cv=none; b=uBEie8Z3QHf4fWoSrIKz17xUyeikDcWnJr27KjAUo3dUfzvNj07XxEab1mdBUJAb86SdfGHV3eu3apFAqYnVhPj1VHBPXP6vjnZbnWWPcqYElbkJht1o50HnmJhN3LTmuBPLNdoJqmO3p+K5jjvp6RJb2QdqqeHLmWCxVCnOFTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752740976; c=relaxed/simple;
	bh=XqiowG+l0Nxs9GLy6dmHjnh4ak5anCiWuXdqfg+G29k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lIb0bsoJvV1vj/OSgnqVfcm7KVnoOqMPQNVGpE15zJlxA4AKJySNjTo6DFRsL4aOj06zJhzytOkr7oVslb9LrcVJhYO/9adOuKFiD7Ir0GH8+zOVPGWYAG7JQ/IiXi/7tq1e/C/sbKm3G0tOwPQ67LUonx40LilYPL1qRRlNiNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxex3T4f; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3134c67a173so721960a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 01:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752740973; x=1753345773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqYi9PdsDJTXopQfcWUwzUVolKIRDF/kwJRt8Q/I3jw=;
        b=Dxex3T4fpWigRqUwurCw3rxVesJ37a1hB5gE1pGPxeqyWsNf86OL9SePGzWd06oAu+
         N6/bFwPo2vJEMa8uDjs6NDTMW4jNB2fbqtpkDmdv+zcAC1AA0Or/7LvGEykfV3iM011+
         QLh5Nb6eXo6uyLsno2V2v1QZDS9dZSh/ztOqskoVRlE9zLNnqP62yuzKw3YqrIQUot1l
         oSy1DY55P4a+uLHX8Qbdt58YlvR/DS2sQdbOUmMxa+YtEgeH2Xs82ulbngh7tkhTFXRv
         ZyzLPao18oB30G8lKQ8gajF0BSWMzhhLIGAfA/4GzycuI6Ue3OS118PZtGosm4wFoCQd
         RQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752740973; x=1753345773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XqYi9PdsDJTXopQfcWUwzUVolKIRDF/kwJRt8Q/I3jw=;
        b=qxuFS0uRCkvaBQiTTmxz8FfycEpDs9NP6XaC8jw+/8o1vwU4Y1Qwg2kLLnQEvn8lzZ
         O134qP69TFrcKwfFKo+S4QofhEXo1WTuUUiBRrJr1V5Ep69mVzhBlKGC6sEBV0yStqVp
         N1J5dPGbXS6V1jujkgEk2QheWsuKTEuVInSNV6Kl+w+anhvbu7ez7CoR0hiMfXNpPSVm
         C4T8Lun3OgpAnD8zDFe0Ev6H4SH2GMtIabW0lIbz8n78RJKVaGCa2b53aRcbJRnFw/9i
         rjEjr9hyjXpC/v4hZG71UgxCVDIs5Ni+R59a5+P5jRGKhzlOSTqTbpfQeZjfYRw6eEeJ
         1Xuw==
X-Forwarded-Encrypted: i=1; AJvYcCVXba5jpXCRBul71eD+KCkrtoK9yJibxV+wgcP7JSSjwQxalukM0EQ7vrnFOviW1P4z6E5akyjC2bZ/XCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rETaM4XMYVQQNdfHqQ++NfyyxD7gu8azXll+aiJ3cxc0U+Kf
	DpCP11kZxe/zwXhf2QadASCn+wbr16mv9FjyGOT6qXlCmxHOQ5YaAcVj
X-Gm-Gg: ASbGncvrKYAwF4HgWuhWlq8wMGG/wnGHFRHfEGnjzYTkOW/nRXsQt2cQgSpUFWOo0uJ
	jGIQwGkPeu5Ly8IpUJ0K+mmz51nZX1l0Pk7GFUanJcDK5Z3pB7LmZ/mLN7N5uanUut4l2bYm82I
	tIeaTmm4NJvl4Zn0ZRkmjtqwWCm6br49X+fGw6Z1KhMc3qACvspeasU/n+XpgeGCnRgBCTh8kpY
	M55F0n3M7yGiqGm4uREmcGVkpaV5/1X+lEKB8ukP4Jzrieg/XfhCPikUTcVUqzKLZFQTNI/14WM
	PjBfLqjDxNM9tYXyb26f4O14JJBgIatLQ9v7eY5YkMBu9Fsz0jgITGHyKdlO1LhIKQtRjeZ2Vh3
	cNvm28byK20aUAtRNRkeNllHf6UkhDdAlmikvYuP617xQci2lxbo=
X-Google-Smtp-Source: AGHT+IEhkib5hMOst8cwMktP+0uxDRjlFNVOmYJ34pQwI5EC06b55pmPkhYmCf1YyIZYXzTTgreE7g==
X-Received: by 2002:a17:90b:3c8c:b0:311:da03:3437 with SMTP id 98e67ed59e1d1-31c9f47ccd6mr8609679a91.27.1752740973312;
        Thu, 17 Jul 2025 01:29:33 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb603aee1sm533126a91.30.2025.07.17.01.29.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Jul 2025 01:29:32 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	yuzhao@google.com,
	yuanchu@google.com,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	lorenzo.stoakes@oracle.com,
	kinseyho@google.com,
	hannes@cmpxchg.org,
	gthelen@google.com,
	david@redhat.com,
	axelrasmussen@google.com,
	zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>
Subject: [PATCH] mm/mglru: Update MG-LRU proactive reclaim statistics only to memcg
Date: Thu, 17 Jul 2025 16:28:45 +0800
Message-Id: <20250717082845.34673-1-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

Users can use /sys/kernel/debug/lru_gen to trigger proactive memory reclaim
of a specified memcg. Currently, statistics such as pgrefill, pgscan and
pgsteal will be updated to the /proc/vmstat system memory statistics.

This will confuse some system memory pressure monitoring tools, making
it difficult to determine whether pgscan and pgsteal are caused by
system-level pressure or by proactive memory reclaim of some specific
memory cgroup.

Therefore, make this interface behave similarly to memory.reclaim.
Update proactive memory reclaim statistics only to its memory cgroup.

Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 mm/vmscan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f8dfd2864bbf..bc92ec338065 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5545,6 +5545,7 @@ static int run_cmd(char cmd, int memcg_id, int nid, unsigned long seq,
 	if (memcg_id != mem_cgroup_id(memcg))
 		goto done;
 
+	sc->target_mem_cgroup = memcg;
 	lruvec = get_lruvec(memcg, nid);
 
 	if (swappiness < MIN_SWAPPINESS)
@@ -5581,6 +5582,7 @@ static ssize_t lru_gen_seq_write(struct file *file, const char __user *src,
 		.may_swap = true,
 		.reclaim_idx = MAX_NR_ZONES - 1,
 		.gfp_mask = GFP_KERNEL,
+		.proactive = true,
 	};
 
 	buf = kvmalloc(len + 1, GFP_KERNEL);
-- 
2.34.1


