Return-Path: <linux-kernel+bounces-856366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D90FBE3FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B4A1A655AA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A62C3469FB;
	Thu, 16 Oct 2025 14:47:10 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE203451B8
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760626029; cv=none; b=dEdkKpXfff8afgOaDgOMq7SJt3GmRa+5cTBnEi72oHoQC7cPoTvcu2Uw2cP2zaBCo4JbbRSpSmAXgXTeZDztW7kpHv/OwpTJkjkO5cRLNcRn4JW7/YlfiAMe4Gs3K70yPnyVFaEypYFNyHM2s6rWVEjh9W3kgQPhU3WOQ7D2fUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760626029; c=relaxed/simple;
	bh=vxd5viqIAF53p9qHcx2+SSC6DWLKIshKJ2YVAGNmP6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez2UUf1tbJFYzUSyhSnSySZuA/30wLPhYiGnnk38Zv/iALLmN9VGXqG3tFPP1yIyHdjdHC3vbXQ2UG8styOuJNjsmxkmm0F7YU3lSy1PQi7kOoMDQJ377ByBCmj5GoULnAsksEtgjKnOcBMyiq9xEhXUsPj0ebZzKx/2ru8md8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=yonch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-3c972dec6easo517756fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760626025; x=1761230825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkeQ5GVzAIUDDgYC2BBLNxE47r9RQHz/6gTcvpiCb7E=;
        b=WEyuGW7fOZ5FtQ5vTzRpceyv/k6s1sZ4Nb5JyMiXdTASPdlTYBrJUbPeTGub9RUcfU
         Dr1879doOxONdt7wTxtmkv78ocBSX/lypUwxqDi0O7PD1xyIUYWQefEqKOEb0myrjqPa
         L/w5P5azM4qs3Ou+WhknSCfkspKut7qPvuDE6XZUhREV8H5Skx71JA73sz0LTFweVtaj
         +WKDkdQ1Pywbdz5helAPjpbCFAzKpyXeA97bYrtSn2bCsn7IC+m49npljH8tBVZ6lBPt
         nkyhGj1pw2+3kIHhPUe8mc41RZ9gmoQvO6ybVNNbMWnAnY5YhcpALvXc5UHwUUKhpRUp
         fy4Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4o8DNIHZGaiHbVx+zRrv0Gdw3PzbJE2cein3cyYZEMEoBXkbjcHI0H8y766HbVpcJ2RSMUDj1hDni7vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOzPrZxEIEj1EYNlfjlYM/pmy8VSirnsvZd15He73MdHHEXw9T
	VKAhskxbvavxmxMttgy0kTt+ZDKO4/QRdRDvxpz8vYY8KGA8JViojVU1
X-Gm-Gg: ASbGnct11Hm36cFPfGtHxCcQempNOKs+qgSltcM4zmUNZ4GvsqoPHMaKkfRSa79jKFz
	DhkUtfXROCdSsqYuC3sX/P1qkqKQ5mHuu1bbLaJnBrHASXN235u/Yz1gIa6+58gluBA9rHQlff6
	yiHlrOcc0uEPsAqWhM+qq4fJiosLkspfjWFa/2oIs7aM4kGGuxPN9C9XDPe7ENsqKXBBhCI2OEB
	xjbD3qqcrKBb75MlBIkewtf6dc8qdCFjVoKRamhujaGx3APjImyVUj2Wi0Hbbhlz0RCQ/j2t8jg
	btyeoQ95N7JFdJ25w4MsLLEx2IKqPeAt1pokrVGKGxbufbi9kCfY+ILqRvga931+ANjJIZBPr4K
	rni4+Ijn7A0xQM/YjIDpWd/kcWaUlm6M4ERzBNkGhbD45PgbwJ4/qn3Fz4h6A4kIxkgVzObDNoz
	J8p68u3db2oJMHd3DHnwCj7uBkzupRa+FAgd34SqkOqO6HrOZ2lsX4ZPd6
X-Google-Smtp-Source: AGHT+IHad8QU7400Suvztwz7R3TknwRXuPTBhGJThjhex4bA27wajLbo4tHyKKwflCEojRIUm28PFg==
X-Received: by 2002:a05:6808:14c5:b0:43f:507f:ced2 with SMTP id 5614622812f47-443a2f1b8camr127533b6e.23.1760626025484;
        Thu, 16 Oct 2025 07:47:05 -0700 (PDT)
Received: from localhost.localdomain (syn-067-079-108-173.biz.spectrum.com. [67.79.108.173])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441cc812f24sm3678018b6e.12.2025.10.16.07.47.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Oct 2025 07:47:05 -0700 (PDT)
From: Jonathan Perry <yonch@yonch.com>
To: Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	James Morse <james.morse@arm.com>,
	Roman Storozhenko <romeusmeister@gmail.com>,
	Jonathan Perry <yonch@yonch.com>
Subject: [PATCH 4/8] resctrl/mon: Create mon_event_setup_read() helper
Date: Thu, 16 Oct 2025 09:46:52 -0500
Message-ID: <20251016144656.74928-5-yonch@yonch.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251016144656.74928-1-yonch@yonch.com>
References: <20251016144656.74928-1-yonch@yonch.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the selection of monitored event from the kernfs seq_show
handler to a helper function. This provides a single setup path that
the resctrl PMU will reuse.

Add mon_event_setup_read() to encapsulate domain lookup,
rmid_read_init(), and selection of the valid CPU mask for the read.
Rework rdtgroup_mondata_show() to call the helper before reading.

No functional change intended.

Signed-off-by: Jonathan Perry <yonch@yonch.com>
---
 fs/resctrl/ctrlmondata.c | 71 ++++++++++++++++++++++------------------
 fs/resctrl/internal.h    |  2 ++
 2 files changed, 41 insertions(+), 32 deletions(-)

diff --git a/fs/resctrl/ctrlmondata.c b/fs/resctrl/ctrlmondata.c
index f28328c49479..d1e4cf6f2128 100644
--- a/fs/resctrl/ctrlmondata.c
+++ b/fs/resctrl/ctrlmondata.c
@@ -594,32 +594,16 @@ void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask)
 		resctrl_arch_mon_ctx_free(rr->r, rr->evtid, rr->arch_mon_ctx);
 }
 
-int rdtgroup_mondata_show(struct seq_file *m, void *arg)
+int mon_event_setup_read(struct rmid_read *rr, cpumask_t **cpumask,
+			 struct mon_data *md, struct rdtgroup *rdtgrp)
 {
-	struct kernfs_open_file *of = m->private;
 	enum resctrl_res_level resid;
 	enum resctrl_event_id evtid;
 	struct rdt_domain_hdr *hdr;
-	struct rmid_read rr = {0};
 	struct rdt_mon_domain *d;
-	struct rdtgroup *rdtgrp;
-	int domid, cpu, ret = 0;
 	struct rdt_resource *r;
 	struct cacheinfo *ci;
-	struct mon_data *md;
-	cpumask_t *cpumask;
-
-	rdtgrp = rdtgroup_kn_lock_live(of->kn);
-	if (!rdtgrp) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	md = of->kn->priv;
-	if (WARN_ON_ONCE(!md)) {
-		ret = -EIO;
-		goto out;
-	}
+	int domid, cpu;
 
 	resid = md->rid;
 	domid = md->domid;
@@ -639,30 +623,53 @@ int rdtgroup_mondata_show(struct seq_file *m, void *arg)
 				ci = get_cpu_cacheinfo_level(cpu, RESCTRL_L3_CACHE);
 				if (!ci)
 					continue;
-				rmid_read_init(&rr, r, NULL, rdtgrp,
-						     evtid, false, ci);
-				cpumask = &ci->shared_cpu_map;
-				goto perform;
+				rmid_read_init(rr, r, NULL, rdtgrp,
+					       evtid, false, ci);
+				*cpumask = &ci->shared_cpu_map;
+				return 0;
 			}
 		}
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	} else {
 		/*
 		 * This file provides data from a single domain. Search
 		 * the resource to find the domain with "domid".
 		 */
 		hdr = resctrl_find_domain(&r->mon_domains, domid, NULL);
-		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN)) {
-			ret = -ENOENT;
-			goto out;
-		}
+		if (!hdr || WARN_ON_ONCE(hdr->type != RESCTRL_MON_DOMAIN))
+			return -ENOENT;
+
 		d = container_of(hdr, struct rdt_mon_domain, hdr);
-		rmid_read_init(&rr, r, d, rdtgrp, evtid, false, NULL);
-		cpumask = &d->hdr.cpu_mask;
+		rmid_read_init(rr, r, d, rdtgrp, evtid, false, NULL);
+		*cpumask = &d->hdr.cpu_mask;
+		return 0;
 	}
+}
 
-perform:
+int rdtgroup_mondata_show(struct seq_file *m, void *arg)
+{
+	struct kernfs_open_file *of = m->private;
+	struct rmid_read rr = {0};
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+	struct mon_data *md;
+	cpumask_t *cpumask;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	md = of->kn->priv;
+	if (WARN_ON_ONCE(!md)) {
+		ret = -EIO;
+		goto out;
+	}
+
+	ret = mon_event_setup_read(&rr, &cpumask, md, rdtgrp);
+	if (ret)
+		goto out;
 	mon_event_read(&rr, cpumask);
 
 	/*
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index dcc0b7bea3ac..486cbca8d0ec 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -366,6 +366,8 @@ void rdtgroup_mondata_release(struct kernfs_open_file *of);
 void rmid_read_init(struct rmid_read *rr, struct rdt_resource *r,
 		    struct rdt_mon_domain *d, struct rdtgroup *rdtgrp,
 		    int evtid, int first, struct cacheinfo *ci);
+int mon_event_setup_read(struct rmid_read *rr, cpumask_t **cpumask,
+			 struct mon_data *md, struct rdtgroup *rdtgrp);
 void mon_event_read(struct rmid_read *rr, cpumask_t *cpumask);
 
 int resctrl_mon_resource_init(void);

