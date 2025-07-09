Return-Path: <linux-kernel+bounces-722587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D3AAFDC9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77D758227B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D22AD2F;
	Wed,  9 Jul 2025 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzWc4BSr"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DBF18F2FC;
	Wed,  9 Jul 2025 01:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022833; cv=none; b=JpPyTsXE4UcDOvmN2MLtEG+h4hQqxzTnRrhVNqB0LpBHuiG4aJbhLPXo6p7LbqvD07quqKSz1DrivMWCZJ/tmNBbGpAFG46K7kGaWLe891sEhJSmPaxfYjSpwc+DH/UHSdN+jrrrCKYTbpJv9jABuNMaEjixQ36bsGtBDt0GmA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022833; c=relaxed/simple;
	bh=kBGVCYlBO0JURIWpfIht3mgfCTHSB2GXv7bsD1cphHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdtVcJLYvT5jEgqTs4R76d9OE1CxriI8ex9AFFV3TapyVcZikiH9HRSPL0/guIjsFQs7JG/ApjZkmqFwhdw1Cn9/b4dCIOURRHNJSFpu+NpFRMBQ4GJfaptYbGczjwaudTWurBZFIxtEZXc1jmxuyPYLxLqoDdQZqw5iK/gdDAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzWc4BSr; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e898de36cfbso4273306276.1;
        Tue, 08 Jul 2025 18:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022831; x=1752627631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRqZ7kP81Zaq1arwauUEMN4RtZnPWf0LKmXEbv9bw+8=;
        b=RzWc4BSry9ffeFjy8MbvRLPy+2nNcqR8GIQCZv4Zmo7y6myXdbaCq3I3EhFR2M68/3
         jIRO1FBz25s6b8TBy6XVPy85cIevPlNvGhUFnqjztGor/m4tSCyaOlI5I+7GUFtmHS0W
         UTr92mrLL6WWFzDqy73RG3vfkOVTPyrVp5qu4skJmk6iyoF2nhXNSua6qdBqwLnO494G
         wPq8CjB+PS1IOYVxGVq6MYaYPcJ2sz7KlDEf4lChSshAq0rC6HqqJW1P98KV9ISW/q0/
         /RpZJXu/Zt0wXq5lbBrUSc06cA0gGv2CmWXUoZY3z4rOshzFvXrRK+wlnL/wPxYa2Tx7
         nYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022831; x=1752627631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VRqZ7kP81Zaq1arwauUEMN4RtZnPWf0LKmXEbv9bw+8=;
        b=DocxukEeSWCG44H9ps0K1f4UCuCxolvraukRthJMRwpDggC6HCZxfy3ACpr79gYSdm
         V0+3wk8J8YSt51mrYgZyC2Lb9h7XfwDLK24HfkhpQmuBsbVjaPXopKM61/4IhyCw0H5T
         WLrPw1cz7wsXMTwWoSpYXClNynVi1kWFO6bNm8EayDqEzkVVNsTx+QHQgGLS3VeB2SpS
         ESCBMZ62gXwLjuCyKByszDO6DZ6fbE2bJp9nC4leCaH6ytknK0NglBfznPJ0WFkTCdZj
         gmAF4/9PUvIpOKGIl8CcYGHR9+ahFi0+kCTDHulViXqtMzlai0jATyTZ3lvQNGGh2eNs
         YXQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnnSPMT0S+VZDFf+JpOI2NznyoYJvQKJzhC7U/H1AI17MxSQ0fkTpVDGCAvEUT0vu/FnZV+L1hB1qr8kR+@vger.kernel.org, AJvYcCXKxsJ8C4xQohJY4N07GPW/NlrxUiH2TiP6bKF+DdcaWmfR9/lNFTzpa8Y6uNjOPmNFbddGV9UfIlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxivxAltzrHxMaJdeRr/iu2Y2Vucd1EY/mZp2xXqa0IJuZRwXz
	NrKXbOCxdU476RU/SzuoGsDgurSCPANhPbTT5nxSVu9NLkjtLMF37k2n
X-Gm-Gg: ASbGncuc7/kL7zb4BHBuA9BRf6aSbQdmzzOuIgb5gYTxbvw9kE6vlyZIfI7+GWWeIBw
	FAccQGvS4TB8sAAvXdAaseJtvbzaAeYIKEOF3s26qpRMrbt5AHNzb8DamalbSeK4KqDCuFqUwRq
	vt74VBw9YBgsnzB2zxyvluF/0C/dbR3YsOK1QqDuNXZgMYb9u9AV+ehwiGeM6t7I60Aei7MZ7ML
	TVJVIAHNcTc7ThLdy0NUaApuSff50/e/L4NOwXllbtHLLfHwQ8P40O2DIff1ukPNWPEJswz5n3F
	djC0Am/gWBO4anXXjLkiLHHzi8K1MDaahmwYiUdr2KEMtXzjYqfZu5xPYg2rLuj0ldsYTnWL4EF
	duiWh67OmoPcJfAzASA==
X-Google-Smtp-Source: AGHT+IFFk12vBHKfYShm0xwUy70JkBS9iNu9v3bAoNdevYxQvMw6G4nHxm7r8pPOOSVJOc1J+GaBlQ==
X-Received: by 2002:a05:6902:2846:b0:e84:3769:d7e1 with SMTP id 3f1490d57ef6-e8b6e0dfd76mr1151677276.8.1752022831313;
        Tue, 08 Jul 2025 18:00:31 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:31 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 04/13] mm/damon/sysfs-schemes: set damos->migrate_dests
Date: Tue,  8 Jul 2025 19:59:34 -0500
Message-ID: <20250709005952.17776-5-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Pass user-specified multiple DAMOS action destinations and their weights
to DAMON core API, so that user requests can really work.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 mm/damon/sysfs-schemes.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index b9434cdaacdc..74056bcd6a2c 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2576,6 +2576,29 @@ void damos_sysfs_update_effective_quotas(
 	}
 }
 
+static int damos_sysfs_add_migrate_dest(struct damos *scheme,
+		struct damos_sysfs_dests *sysfs_dests)
+{
+	struct damos_migrate_dests *dests = &scheme->migrate_dests;
+	int i;
+
+	dests->node_id_arr = kmalloc_array(sysfs_dests->nr,
+			sizeof(*dests->node_id_arr), GFP_KERNEL);
+	if (!dests->node_id_arr)
+		return -ENOMEM;
+	dests->weight_arr = kmalloc_array(sysfs_dests->nr,
+			sizeof(*dests->weight_arr), GFP_KERNEL);
+	if (!dests->weight_arr)
+		/* ->node_id_arr will be freed by scheme destruction */
+		return -ENOMEM;
+	for (i = 0; i < sysfs_dests->nr; i++) {
+		dests->node_id_arr[i] = sysfs_dests->dests_arr[i]->id;
+		dests->weight_arr[i] = sysfs_dests->dests_arr[i]->weight;
+	}
+	dests->nr_dests = sysfs_dests->nr;
+	return 0;
+}
+
 static struct damos *damon_sysfs_mk_scheme(
 		struct damon_sysfs_scheme *sysfs_scheme)
 {
@@ -2638,6 +2661,11 @@ static struct damos *damon_sysfs_mk_scheme(
 		damon_destroy_scheme(scheme);
 		return NULL;
 	}
+	err = damos_sysfs_add_migrate_dest(scheme, sysfs_scheme->dests);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
 	return scheme;
 }
 
-- 
2.43.0


