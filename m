Return-Path: <linux-kernel+bounces-787380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFDA4B37565
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A2B94E29DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 23:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3591F306D47;
	Tue, 26 Aug 2025 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XhInzqTM"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2FE30101F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 23:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756250202; cv=none; b=Ejx4DKfW5r4wRIU7/buR4AENb+xsvMNk0SyKogRAnlWkR7xtB12Z8j07tz5P9/fiqerKBzD/gqZpoElgTNzDi6gjd2ht1mk0VDakv7F67KOGgzwsuMEN3HwzwHA3nddYmPxLBHUz0e+lJa3lbujJ93SYxziz3spCyxsJECsrOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756250202; c=relaxed/simple;
	bh=/fBqzc3yn80C+Clra48ZRyN+Wew+iSqN6ghgdIhxSrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dthNMb/kiyjmBZQ1ACLwGyiaVcwQyebtOv+ntJ0BcwQJIzX1cENE6qLfiO1i73XwjKjCB6KXfNdWDHDoWVeVHJvzBiLLFCQsR5BwJkvskmyTuo39ly2nzh9y3zvjKo0sdcusQFo596JH0pY9+mPvo/fMLwC/c+zBjGOa7jprEic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XhInzqTM; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61c4f73cfa0so5442724a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756250199; x=1756854999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qetrqf3MczqPduYKizayxhW6O6ZOA8BdxBOfHLUC1/Q=;
        b=XhInzqTM6YJH7dv+5FQe61ZQ1eXiz+6U52MHEcCidDyang8d8CV1gDdQ+wCsSMi9Od
         bJioiZ7tHrwcXbvyFSuk25LG/GiVy+CuicDGcIHSAYTdPXww92NEVYpQWbQzdnbBq5ec
         cy9vF4LWxqZGPSc3bW39ushsBYo44NzeI4KIq25kKvVxBr62Fg54KREzAZs2NLL0h3dL
         cdyOn1pQHzLyToUPzyP6mocub1lVXAot7Rf3+IHEmmN8NZH9ZnrgJelv2RezLpuypRhJ
         Yx2NnwiPuZ0F5ge1HNrpb7lFHODrnKpFFA2exQQFwDqlBmZpRSTeWvL6YUsARvbUskch
         jnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756250199; x=1756854999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qetrqf3MczqPduYKizayxhW6O6ZOA8BdxBOfHLUC1/Q=;
        b=p9DS8B/Oj3VNL2Gt13khvPo3NUNnXw4qAFcSbwSsJqIkQMHcilexoErm40c2d815H3
         LVQLAGJrzKeIh8yOcNpKBsYkL6MepjStnv7L6gCan6T9p/fTqpkVSaHdEUDdaSViC3e3
         mSdiO/xu+hkNEBzut1705H5PC98HOe669COwEuy+U1WCaMDwcRBwIhjdRZYNIjS4nFSq
         N2ic5yX0v8/yTx7jshWrhiTkvTQlKa2m6Lm9kBjsyRwGu7/ccotubLYS8BXPz+pQdYIY
         5ln3W9vSkJ3/y7JutbP+fwB3rYbJQhzzTL+MVAVu/M4bWzIi4IAyrzSxS9SD6dKqheZz
         jT7A==
X-Forwarded-Encrypted: i=1; AJvYcCX0px5Mr52w0bOg1v7lJ8j5GLzcWHWY7Ut8bzN7YJ2ll8KYQtTglgIzMVhmofUyTQjbeNWDOQ4nLhsnw3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6I5tG7a8wfbSdM/12i9YH/HUD/GhzvrSIcu+H1lz0BwOVeXJO
	cjJgOYkthtx5DYH5L2IS+nJAkz/Ntl3Q7+Myn/dDo8buK8ZuBmJrG5mgO8t8mUrlHi4=
X-Gm-Gg: ASbGncvibTMDStYeipCcM59s5LrIzS2JqxXL0px05WT6F7FVfV57qci1rP2B2OVPQhS
	as+Yqkf+vp+G+T3lIb3pT2klHlgideFjQkm+DUNboSZbGT8zxZdPOADasbD1ejRqQt8OKDYNYC3
	s3T4Nlm7ItD0yoXw3ExNr3ZCDeHkq1+i/i0c4myCi69ZyR1i01lMuUGrzl68z0FJKzogGQCjGJP
	UgkXsMfe50Yif5f2v9xgzMi22qM/BtBA0IcoQYWp284LBViDr9FUIY/461BMDWC5tLswBUxiEkl
	ZJgFgM4UnpG5ogPqE819nkEkVBA8/C66vDzEtAITbEB1xBFtMO98nVU/wmBSrnfeJRm83I+8g7I
	cCYZoLdmcJFtjtKSRXA3zfNCmJ8zI+aaWYD3c0UsNKdR/xaBqFs8LOBtIRnhrLTSIBrQgAZI9jB
	2VANW9bcEnrxP/iK4z56gu5PEZ7SuT94Eq
X-Google-Smtp-Source: AGHT+IE74yfqVMKiPyh0C08W2ABt3qXIpU354P0qAPryu5ETmoDrG7LlzRcdx7ZJnXUVlOl7635fBw==
X-Received: by 2002:a17:907:7e9c:b0:af9:8c1f:b290 with SMTP id a640c23a62f3a-afe28f6a866mr1381335366b.29.1756250199096;
        Tue, 26 Aug 2025 16:16:39 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afec3251fdesm23170666b.77.2025.08.26.16.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 16:16:38 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	chrisl@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 2/2] mm/swap: add BUG_ON(folio==NULL) to folios_put_refs()
Date: Wed, 27 Aug 2025 01:16:25 +0200
Message-ID: <20250826231626.218675-2-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250826231626.218675-1-max.kellermann@ionos.com>
References: <20250826231626.218675-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not legal to have NULL pointers in a folio_batch.

However, the Ceph code does exactly this, and a refactoring patch gone
wrong has exposed this to folios_put_refs(), see
https://lore.kernel.org/ceph-devel/aK4v548CId5GIKG1@swift.blarg.de/

I believe this should Oops instead of crashing due to NULL pointer
reference (guarded by is_huge_zero_folio(), which may silently hide
the bug).

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 mm/swap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/swap.c b/mm/swap.c
index 3632dd061beb..07ccda00e7ee 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -952,6 +952,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 	for (i = 0, j = 0; i < folios->nr; i++) {
 		struct folio *folio = folios->folios[i];
 		unsigned int nr_refs = refs ? refs[i] : 1;
+		BUG_ON(folio == NULL);
 
 		if (is_huge_zero_folio(folio))
 			continue;
-- 
2.47.2


