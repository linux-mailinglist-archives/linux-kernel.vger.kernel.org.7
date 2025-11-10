Return-Path: <linux-kernel+bounces-894019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CB8C4918F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3769C188D160
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280833859D;
	Mon, 10 Nov 2025 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QrNStBGi"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C80320CC3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762803408; cv=none; b=ubQSCjyfm36pM9c5tpcqvL8gUmbztejVZ5lVAt3z6LnGF1jwEtohF3UH9IstkEh0jsnWb37Amlrpi+VJaDaKUwTLrtwhMz9CKRcXV6rBSPEWnmYc7rtBBA54q16K+DYaTBlk2r7DtY9naaDUxpriqhW4Zmf8VrZYCiZQHqnhGuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762803408; c=relaxed/simple;
	bh=Qb6H7e1GNWYpx0zXiNhXMGNENsZMqUmvk6ZdQdT4edo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEdDATKH9NONybgVTotrndOmAm+0fxpqNbgSWO+tJq06fkb3RluAL48tJnGlMtLebWnJwXsCeKBLulNVOqQ/Wefxx9+JGFkeunA9r+mALaFILRuMsY/E2D4sBoD6pc4vg4gKg55R5oiID43oZbMaIXA/MsvYI+Su/tk9G7uoadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QrNStBGi; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477770019e4so25000855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762803405; x=1763408205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttljqdD72/jNbbr6++0E5iGMaW+W1pbD4ZT9pbcKYcs=;
        b=QrNStBGiWDUZx3mO75v0MJoAf3lxxekO/SsAXoI/m/+9kQfm1dKl0o78R/7Ywn6lUS
         XEMvaansFXbwAEa1tJjIxmxsXJl+7GQeRrLLZqtr/Q41Ta6lNdK9EvOuBeTHY/RoD0qe
         yhi2Fdh+FxxJS/FDa37ZyKreCdyf2O0u2AYphJk9N6+2mPuzUlQ3tvACaFd61FcsHrwn
         VYOCReFKZgq129RgB1eyCQJkhbhso6IjVn7/RlukLNA32sIEPqKnUDDq94e7aT++4bE+
         dkPPobWfX8ueSjzOYAcD4KM5JgPgwz2Y1KNm+A1j2N2POxMySnxZI5Qh0LTUTqOBt2Ci
         040g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762803405; x=1763408205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ttljqdD72/jNbbr6++0E5iGMaW+W1pbD4ZT9pbcKYcs=;
        b=xRt/R+ox4yer4FnWcM7tiDelVUhwJNvy6PV4ckd8HIaP3VIAr8lDFmFPrTtqnzt5nX
         /ylI9mAeR+TAeq3S2H6yc2o5+8lMlp3Bx+xqz1d4HohZV0i65Y8liGprkyFOdVhZAG5C
         RRzcF/+vFBpuOJmeSYB6noquyBx3npnzOPTc2BoRCdTOfVDHFELXKdMFElhI/FH8FbW2
         oRynYse3Yf+1jDbqq95W+VhKyipmAL1fDedLqHehHZRrE+tGso0qzXoUs/xWU3Xxy1hT
         eYJ5cEkeIni7oOO06BUtg/vazccRxSIYTVbPLOfMRnpIDJanHTBaJbMTb/1oxJOviQYY
         /D9A==
X-Forwarded-Encrypted: i=1; AJvYcCXTyGrnRHL73AhoJekV6YfxDHTHDosDbnwHQPNhal+oYRUWIB3MfbV0g6NbKrnOtm9Xsv1/7iX7c4nE/IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYANvC4tPj+Ibg5ry1fvzuFbXEltmtGufZau6gcvr2vVFo4joN
	Fr+92S5ck/XRbDUFvuPHg443Kf/VvzJ2Z6OBuqOWqTibATIjOlT25Cmwq81jhGpes1M=
X-Gm-Gg: ASbGncv9yJUQ5hTYr+3V6uaqzh5zfH9Mp1SRkkAG9RIShGAI8iwR6W4l9Kb6ARXTd/f
	Qq0/ukMfKWv7KqFrjErO77yf5ZGMvzvMysHF11PFNKXKMIQmYFNvaSdFWdE8otiMtSC2b2qoyAj
	WT4R0SNt4oKNrMHjG778hb7ieapc1CJJkmjlcMhzFf0cJwSjc8ETwyMLf8jBultZR99m1r2Cicf
	d/fuv0ofbliCo+8QsCihB+qgFOyeeOtkryti0xOytN1LItZG1Wz40D7jyy4lHfqom1fEL89QhFZ
	Zq+sgxI/CD1PizXQ65YJyK6gWh5/x3XjI5d3aTnPFrTDmGKaok80b5q/fZDhJQOhu1V85R65ZSz
	0c1GCcfRW7kO3gbNNZeLmsqMJ8aI59F0a7d4Nm++Mci1KyLwagFvuP5gVmghOWkrc1x3Qtw3Q/k
	ktmAu6bOS/0vdUP2FCMOKJ
X-Google-Smtp-Source: AGHT+IEO5WOovwJKqZKjVkptEaFPi6rnDgcRpgzt4kQKQklLd5lgVA5XjA0MXpmNh6UDE1IOSEX41g==
X-Received: by 2002:a05:600c:4753:b0:477:54c0:6c3b with SMTP id 5b1f17b1804b1-47773224fe0mr86578935e9.2.1762803404642;
        Mon, 10 Nov 2025 11:36:44 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce32653sm336766725e9.13.2025.11.10.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 11:36:44 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Natalie Vock <natalie.vock@gmx.de>,
	Maarten Lankhorst <dev@lankhorst.se>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH RESEND 1/3] docs: cgroup: Explain reclaim protection target
Date: Mon, 10 Nov 2025 20:36:33 +0100
Message-ID: <20251110193638.623208-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110193638.623208-1-mkoutny@suse.com>
References: <20251110193638.623208-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The protection target is necessary to understand how effective reclaim
protection applies in the hierarchy.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 0e6c67ac585a0..a6def773a3072 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -53,7 +53,8 @@ v1 is available under :ref:`Documentation/admin-guide/cgroup-v1/index.rst <cgrou
      5-2. Memory
        5-2-1. Memory Interface Files
        5-2-2. Usage Guidelines
-       5-2-3. Memory Ownership
+       5-2-3. Reclaim Protection
+       5-2-4. Memory Ownership
      5-3. IO
        5-3-1. IO Interface Files
        5-3-2. Writeback
@@ -1317,7 +1318,7 @@ PAGE_SIZE multiple when read back.
 	smaller overages.
 
 	Effective min boundary is limited by memory.min values of
-	all ancestor cgroups. If there is memory.min overcommitment
+	ancestor cgroups. If there is memory.min overcommitment
 	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
 	the part of parent's protection proportional to its
@@ -1343,7 +1344,7 @@ PAGE_SIZE multiple when read back.
 	smaller overages.
 
 	Effective low boundary is limited by memory.low values of
-	all ancestor cgroups. If there is memory.low overcommitment
+	ancestor cgroups. If there is memory.low overcommitment
 	(child cgroup or cgroups are requiring more protected memory
 	than parent will allow), then each child cgroup will get
 	the part of parent's protection proportional to its
@@ -1934,6 +1935,23 @@ memory - is necessary to determine whether a workload needs more
 memory; unfortunately, memory pressure monitoring mechanism isn't
 implemented yet.
 
+Reclaim Protection
+~~~~~~~~~~~~~~~~~~
+
+The protection configured with "memory.low" or "memory.min" applies relatively
+to the target of the reclaim (i.e. any of memory cgroup limits, proactive
+memory.reclaim or global reclaim apparently located in the root cgroup).
+
+  root ... - A - B - C
+              \    ` D
+               ` E
+
+The protection value configured for B applies unchanged to the reclaim
+targeting A (i.e. caused by competition with the sibling E).  When the reclaim
+targets ancestors of A, the effective protection of B is capped by the
+protection value configured for A (and any other intermediate ancestors between
+A and the target).
+
 
 Memory Ownership
 ~~~~~~~~~~~~~~~~
-- 
2.51.1


