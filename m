Return-Path: <linux-kernel+bounces-722590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB06AFDCA3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24869582454
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336861A2C27;
	Wed,  9 Jul 2025 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oyp8YL6Z"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525B145B3F;
	Wed,  9 Jul 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022850; cv=none; b=B/ewxM68O9e84jYAWS3bFcJoLCRmGuJUz8PrsjUcpgOsOfmtMD9I3SD7lclluPOYF08VGETwSOzT5Jus7cnw5fXn61Bowxq3eopaaqW7WwEI6Dtcy0q1XRMNVde5YN5K8+szelF8BDZjTbhTmIkJFseB6CMY+fT4J6TDzImpqLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022850; c=relaxed/simple;
	bh=0MULHU7ToE1y24HCVFh8DYPWr9UIZ8/yXBxYBDmNcrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9w2jAecX6FOVhu4a0Lpnq1vVvKEcJ0K5Al0LxgKZE612VXk+36FTBeHgY0++n6xjSiywl6WM09Guw3BiHgOQG+1JJ3HMpOT/+LZhs1BBA0iYuVzOAt53j7rn6nZ0E4zG8P/1kWFTqHoR/h/64b6Jn1pHufqFG9YWNNO0BLsdM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oyp8YL6Z; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so4647568276.3;
        Tue, 08 Jul 2025 18:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022848; x=1752627648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1rQEZ3P3BWEkub0MmK+N1X97w+uXKLbRycfS2a+MLc=;
        b=Oyp8YL6ZxV5UXy+AGWNr+0crcECSvtABWdbOJ/PFkDx/oP31hR/ZT8+GWssvGsQKW3
         fU2nafqiHTh8xcFMzz0z/xBSVVFUlX87KbQYK1BnbnCzci0Kgx/fFIk5sBE71J6680ra
         OIE201g2Nnj7D/N06JeKP/TbptjuGpLOS01nAaReV3vD2E3qX6ETVOkNHcbk7d5UkMrU
         ls7JZc7NVWofKe3YsSUeMoBau2CYZ6Dxlu7U0IAP7W5/u4mK4Yuy/eknDI2BF6YFZKHK
         2IRIhpsq/NYBUuUZMGM0xarC/QHzc7WprCNlVVmFVsLb1c3ogBEGgNMSpEj2Q9vNR95O
         8qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022848; x=1752627648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1rQEZ3P3BWEkub0MmK+N1X97w+uXKLbRycfS2a+MLc=;
        b=LUndbWjq8HSKa4hgGOUbSBljT+Fw4M+WmI6UZlq/bLHG6pETPN4HK/Z5FSXhc8Hexb
         HSpI+V6FSEys1YKC/XkJz9hqvxPlP/P7igvGLn/CNFoe9Epk97bgrD+DolQX/mq3iTsq
         FmR46eYrjwhU+YuUVFZPDXDg4KuLURODs56+BConQyu4A0/Nj/MyMCd3JRTZDCw2JljG
         +oy2zTv8bz2BBtyoJSuinvRcYVY4NMxHKpy3/sI/DSXmGGqk+T0bOKqNfH2jREPg719W
         V/Vm5PcAbuyLeSTKx/1qr43E7qaLgkPKVx143Uy36YMax6HQxt8S4ayQxnP3JhpDpE5M
         uD2g==
X-Forwarded-Encrypted: i=1; AJvYcCUIwIaggTRVpwy2/taqIX2+XwgQ7WxEmz56TrRliBt8yzMq6J8/MtzQJIkjqifRteWuUy1oGyhfsXcIYh1X@vger.kernel.org, AJvYcCWPjbGJceik3TUBzhIIL4zFwL+2uZs2eRR5kjnCjtAWEFKiE0gIrNYXMty+sucWwSG83kDo8StqamE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMgs0vcqLAXSQzwF2iwGmhvgr7A957PoHOqlG+nVTBmlxBGv2
	eyoDlH/479x3ABGZ1/2fOIaIfkiY+NtD1m2Xd0NlAoZ7eXWf15fVDoBp
X-Gm-Gg: ASbGncvdRwipMdMhQITTAaTUTroC9+iR4t0b3XOyJXMpQXDfbW9kubKTRgxfrQ3uruG
	IN/h/88lrQ36xsn/VDmVtBuDyjEFZezMgG9meXDte2Ctd7DJGVx/KrGZfxh1b6ASrhS0geVOzaS
	YmI8sqCiPPU7wIfTMpCYYz2epbrRNa+0qTry2DIYitnEeDjTBpZrOOu5kHN4YF8z7yqGexZIizs
	QVGP/UwnkqCyEYfCW826sAdtEvy7lKiksN5js5x86xjX/nGdsA6eikIp8oG8slyRjp7FxqZEP1t
	d0wCc3bZimogBf9Cxcs5u29oISDK6ibQFSyPGYJO/wAX4ObcHD7vXWbkMa9fNWhnbiRwf8mzW0M
	2HT0Y2Y0=
X-Google-Smtp-Source: AGHT+IH2cQxk/EywgLp+UgmsKikCG6qPU3Rfx8V0pFOQ6x3T288Qg0dLaeI6mBOGtVGc7IHSd5hNEA==
X-Received: by 2002:a05:690c:680f:b0:70e:15e7:59e2 with SMTP id 00721157ae682-717b1c36f17mr11095217b3.24.1752022847915;
        Tue, 08 Jul 2025 18:00:47 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:47 -0700 (PDT)
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
Subject: [PATCH v4 07/13] mm/damon/core: Commit damos->migrate_dests
Date: Tue,  8 Jul 2025 19:59:37 -0500
Message-ID: <20250709005952.17776-8-bijan311@gmail.com>
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

From: Bijan Tabatabai <bijantabatab@micron.com>

When committing new scheme parameters from the sysfs, copy the
migrate_dests struct of the source schemes into the destination schemes.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 62acfd5cf4ea..8d54bfc3ce0e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -943,6 +943,41 @@ static void damos_set_filters_default_reject(struct damos *s)
 		damos_filters_default_reject(&s->ops_filters);
 }
 
+static int damos_commit_dests(struct damos *dst, struct damos *src)
+{
+	struct damos_migrate_dests *dst_dests, *src_dests;
+
+	dst_dests = &dst->migrate_dests;
+	src_dests = &src->migrate_dests;
+
+	if (dst_dests->nr_dests != src_dests->nr_dests) {
+		kfree(dst_dests->node_id_arr);
+		kfree(dst_dests->weight_arr);
+
+		dst_dests->node_id_arr = kmalloc_array(src_dests->nr_dests,
+			sizeof(*dst_dests->node_id_arr), GFP_KERNEL);
+		if (!dst_dests->node_id_arr) {
+			dst_dests->weight_arr = NULL;
+			return -ENOMEM;
+		}
+
+		dst_dests->weight_arr = kmalloc_array(src_dests->nr_dests,
+			sizeof(*dst_dests->weight_arr), GFP_KERNEL);
+		if (!dst_dests->weight_arr) {
+			/* ->node_id_arr will be freed by scheme destruction */
+			return -ENOMEM;
+		}
+	}
+
+	dst_dests->nr_dests = src_dests->nr_dests;
+	for (int i = 0; i < src_dests->nr_dests; i++) {
+		dst_dests->node_id_arr[i] = src_dests->node_id_arr[i];
+		dst_dests->weight_arr[i] = src_dests->weight_arr[i];
+	}
+
+	return 0;
+}
+
 static int damos_commit_filters(struct damos *dst, struct damos *src)
 {
 	int err;
@@ -984,6 +1019,10 @@ static int damos_commit(struct damos *dst, struct damos *src)
 	dst->wmarks = src->wmarks;
 	dst->target_nid = src->target_nid;
 
+	err = damos_commit_dests(dst, src);
+	if (err)
+		return err;
+
 	err = damos_commit_filters(dst, src);
 	return err;
 }
-- 
2.43.0


