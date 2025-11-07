Return-Path: <linux-kernel+bounces-891117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 813EFC41E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CEB54E7C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF30314D03;
	Fri,  7 Nov 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="tKXxgKOL"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394EA314A99
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762555809; cv=none; b=X4EZbFk8T7CmD/CmyF30kyf4xxqigV3jcL7wQEjYogOizLgLstL6O0t07wNJ3mLfPZr8+0vI8XC4ZR7/3qNfBF5HvLC2TNCO0M4j4aCKUqIr2zNWoZbC2zzBeoS+U4XfA17mFfL3K/nKtsyp8UiOsdHStTCphwB55s0JlYPE/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762555809; c=relaxed/simple;
	bh=UCpXheq+ISF5ooL3BArG9j5Ni7nrQ94FnST2TGVI9qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S5hvr1VN1tuT+MBbw6K846c5EaR5FaA/pmJ3mh/o+1m8pdVx/1k+FIdWpoYcYJTBtdEojxVFx+Xy4TGaIz2fEf0S3GMOoAis8uroprWgqE5G4IFMviDVO1SjrXeo2A4pTYA2RVXboLG0OKq3YZE8zhVXXc9nASPk9igwId+q5iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=tKXxgKOL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e89de04d62so10149531cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762555806; x=1763160606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCHR6ylRLZZ9pqd+jMer6/IGdndwoE5PhK5YE6dS19U=;
        b=tKXxgKOLQJx65x89wlHUjXEms19V2h4+fJag0WnIJD5oEG/ILVml5bMn3kzA7LHKDD
         LoQdZb79TEU0fFHEdNl4l22hrCtI6XV8X/jowNCQvk0BBSWLp7FemAeYB11k0uAvNb7V
         lgfICkxQx5DM7N94uYFET8BHEPw5QZfJIzV8alY5IYe45jTno/a5NixiBZ1VsLouSE6z
         k6i4CxCDOAQIkmBhb/f18FuKH9Iu6OVyW7xn5oYvaATF3mWOYCaHW+Ytm/K5ENzoTYZ7
         3wiIgHSuVrFFM5Gic9V9B2gxUDC60XHGkWXocxp36ukAuwShuqz/V3LH8hgfXHKzLCF8
         d5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762555806; x=1763160606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCHR6ylRLZZ9pqd+jMer6/IGdndwoE5PhK5YE6dS19U=;
        b=YrxRaeJct6Utwem7l2Wh4Befa/vOd5wyW68MBX9Lqy1Yq9qj2vY1Kl+q6iOAktl8Oh
         EcR6HjG5XMeizYbOZXe89OEYPde46yQwbOfyZGsRi8pN643XRTzALW0zhfOC04/K7R2L
         PZBOBh/BhW/nJvqynWnFlSWw2sebr3kZ4+ltgHJUTGTOoCJVwx0ThrH3EKnfKmZccSfN
         adsOmPShXOKGP45DhLb0gIdw4P4IYpFannV//d1SDwvB1OGKnaBYLH4klY3jAnxGpLl5
         R08blaaeStQqBgCG4BmJJnCCAEjj2aQ9dkAj5q3LkN0lfmpseSa63kL7+HlQMDJ56M4Y
         GUKw==
X-Forwarded-Encrypted: i=1; AJvYcCVx1lhEm3XzJVjgy4CZCcatQbAmABBpmr9zaNpACZcCDeiAwF35pklZkvp6o/lVhNGYmYdo6+RRu+P7qak=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHCaFDfl1kKGDQumefxO4f/wpG/jg9nm5OUZf+VlbLaxCU0Xfj
	JropIS3SrT5BIxPMy5zRUQpWKsezU9LokLmUgNb1oG0ZRRVYWMnhNLnLgSE83d5lJxs=
X-Gm-Gg: ASbGnctm3LviggLNoDIbaxu/S7xus69uk6rCzlF/n6mKIcy8ACPd4rMoRU9+gS/w9P8
	2Z31OQFb/dXc1W9MgJ7Rfuw3G91uTwWSQFOudpo6YUpEv3GUMjxXWsdRqh9ocn8jsMzjqAbkKFo
	GQhxFQGkBwhn7SEuOslsNzUHylJk7wJqSWPMJ+ioJjlZzh24Lf5P3vEN9MrohZSNchsT2COG3Ze
	eHXsSH7kuIlu+GfI3Hs4hkTeNca9R8mNPVuF5GGMVWXP1CThtAREN9MHHXbNyT17pa8NOmKPSA3
	ybP7cvql9fzXlply7rBGuc/7/tDCsf8gZZ4O1AUOnrj4C7kA1+bhXxa0Yrhfoj8KuJ0lTktoq0R
	mYDJVTIjYbwfo5qtpp7oV5FLblkhFYDfM12Ug+Wfpvz7Dy3sM7donyZWRzcEQ1607Fyi7y8oH91
	qgW8hTg6o8kg2L6Ekpr0XVwWZO94d3fcQQPtEey4DW04rWIvZkX4Idvsfw6uPJu6AgBwoRt+bEo
	p9plTE4MS+8YA==
X-Google-Smtp-Source: AGHT+IFFPECdAOsGcbR+MEazzzIO7MJP4xCB0/B2/FxsL9mdOEjwM8IeKSGUWcVdouQFvc3wSAz+tg==
X-Received: by 2002:a05:622a:120f:b0:4ed:6e79:acf7 with SMTP id d75a77b69052e-4eda4fa468emr10231361cf.41.1762555806006;
        Fri, 07 Nov 2025 14:50:06 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57ad8e6sm3293421cf.27.2025.11.07.14.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:50:05 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH 1/9] gfp: Add GFP_PROTECTED for protected-node allocations
Date: Fri,  7 Nov 2025 17:49:46 -0500
Message-ID: <20251107224956.477056-2-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107224956.477056-1-gourry@gourry.net>
References: <20251107224956.477056-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GFP_PROTECTED changes the nodemask checks when ALLOC_CPUSET
is set in the page allocator to check the full set of nodes
in cpuset->mems_allowed rather than just sysram nodes in
task->mems_default.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp_types.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..2c0c250ade3a 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_PROTECTED_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,7 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#define ___GFP_PROTECTED	BIT(___GFP_PROTECTED_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -115,6 +117,7 @@ enum {
 #define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
 #define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
 #define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
+#define __GFP_PROTECTED	((__force gfp_t)___GFP_PROTECTED) /* Protected nodes allowed */
 #define GFP_ZONEMASK	(__GFP_DMA|__GFP_HIGHMEM|__GFP_DMA32|__GFP_MOVABLE)
 
 /**
-- 
2.51.1


