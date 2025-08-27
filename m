Return-Path: <linux-kernel+bounces-788777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC500B38A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 21:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4E73A341B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290B2E0921;
	Wed, 27 Aug 2025 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VLKqlCiF"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748F275AF9
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756322689; cv=none; b=uL2JOxoJuXrmv5T/Z630wgtRzbTNayEkRS3t+KF4VB2+hzjMoFzdijlIbi4A7Qpw1aE1thOw6P7i71yiRc3BZ1PlnRBHyPnrh9bQ/yJmR6RbbVehAxSfdlrLWgAlr5RiIdqGh1AdtZJUqIKgo5ZSw+1/5GfDuXG1D9w2ovucccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756322689; c=relaxed/simple;
	bh=nDyDk7Appk/phu2FkCYalV/0D0HJgDI2+clJwnrK4kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T70/C2j+ncrAqo2Ce/jTS1TvBaygV16uGjFzXGl1aRgiuYagfidO5eSRZ7aYD6j1NR0bMBB/8qMHkmcWVF64wlMIh4NLnC6+zCenFYUuFyKsPiefwEYCF7cj6Urk9XgmGYzr/KlfchDi/yj40niOGhPrzo7wrHTG2kGF7+0LLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VLKqlCiF; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cbc8259fbso226978a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756322685; x=1756927485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g+X4Fejj0KpirEOqCpH1ofp+/ux4qvnE2+QS5K8M9VE=;
        b=VLKqlCiFMHL8M1kAfm3w/eus5aBlarSxVJZLQMHcBs7CaFohtK3dbV9wSlULE+IJIM
         0WgfsqjKputK3K4PX0l2BlqSgpmB7EzO6ncYDHdy0DimRU+urMaV3Ig2dL2S0VykOmoe
         eCi1YXdhscbGOP+CuFw3gC8qxLFGSX0FGaVRbz76tbeb7ehT+uPc67uOLeb8rkG6r5u6
         ZIQieVfhPQ0ishxYnoTV8FXpoyYt0I+0tHnO0wKCSjrUYFiYu1NQa0w3v5fhd1tJ5+J6
         T+pQctZ3U7oMICknS6HgQl16yapiHE7euXviaOwDUQLqUOHI14/92/K1DwitSk+eVicr
         LggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756322685; x=1756927485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+X4Fejj0KpirEOqCpH1ofp+/ux4qvnE2+QS5K8M9VE=;
        b=i1MK5ExsvYVQjmmWIQ0oCdD2B55m+D/AuzMfHmg/0kBHcK8IVBM7F0JbXB4GFcZwXr
         r7T1BoauvXPk3v0jhkEzJ7GWJXECSFyPEpmxUhM9ZwD/dR3OtstG4EE5JJtDUxEkl9Hs
         y04eE8wAanwa1p1i6TFgw8X462212rGd518NllzQlNK2PxjwxTaCyh1UO8cNHH4/iQ4Z
         10tN9Qw18RpilS8x9m6tME6eAvkYm/Az76jl51w3MdoHYHbr4/ARR7xn1rbwgUX+0Xro
         cSQ+hi4s0vgHR1+IfwSNMPxatEjwE/Qb46S08LY1Fzs9kfgfnEifAQGrep8A90ZsAF7u
         uMyA==
X-Forwarded-Encrypted: i=1; AJvYcCXAd6mkzQsTda26IZXdLTHcHHYSYmbrgE5Znz1ByrlYcn9B93TNjYj6YmSJxJtm/iZIM/z3jmYM9nz6Kds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4GN+SsGtop/S/3s1/UDJzHmu/psKNQVGRiC1/iKUs+M/kSTm
	239MQNaIe7Z2iSSH2OXjjCVykxJ+UXAAeVgbt/25vujKsPc+PUkdYUoOt8GxRlW3Ebc=
X-Gm-Gg: ASbGncsxQojX9dKDS1+2wSD8bLLGq4KRxIEyeGZIKkycUWFn9DeCvtz8EgCAH6ggvs3
	qfS7YM2ggSs+7kiKmhyMO4ouxYAoRJXVjXCtnJugqrYBv7TZKk2hAhjCiBDBtxyjJk9qKaKCqr1
	lm5o74+UAOt5Mls5JvREzLtOpkGR1toi7BJBHf5Wd8AK6UWD+/NEXnRM6pwYCW3Q6vKJ4GMMXNM
	YpRUlQhO/U0U+tEW8uHhJ2M7JK8MRAUZc/14+eyWQA7OV3juxbPQq7SSUaLf6iz5hgtwMGaooZe
	tA5lLHvP4vmId9xjNPU1TGSlgeXxQbTwQLYS6Js//dh2mdSPC3e36juYWDYowYa+zzLscKIBwh1
	0zhny3pZbv/5ChsBSskS8fY4GhkQAbtIbZSkawNAxDKystv3WTYIgzKpt2rDwnZ8n1kL5BXdOMp
	WxYQ3p1pdCXrQdtyWLw7kUgQ==
X-Google-Smtp-Source: AGHT+IH1hgTRKxlBmdv3/+s0r8qrOSStemv1ar3m/W6lDxjJATxhY6Fk1qCy6ohGFpWQa2Uc9uQQXA==
X-Received: by 2002:a05:6402:354c:b0:61c:9a23:fe9e with SMTP id 4fb4d7f45d1cf-61c9a23feabmr4788581a12.14.1756322685347;
        Wed, 27 Aug 2025 12:24:45 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cb7ce92bdsm1486735a12.10.2025.08.27.12.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 12:24:45 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Slava.Dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] fs/ceph/addr: remove redundant field `nr_folios`
Date: Wed, 27 Aug 2025 21:24:41 +0200
Message-ID: <20250827192441.475831-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This variable was added by commit 590a2b5f0a9b ("ceph: convert
ceph_writepages_start() to use filemap_get_folios_tag()"), but it was
redundant and unnecessary right from the start, because it was just a
copy of `fbatch.nr`.

This patch just uses folio_batch_count(&ceph_wbc->fbatch) instead, but
keeps the filemap_get_folios_tag() return value in a new local
variable because calling folio_batch_count() would add unnecessary
overhead when we already have the return value of
filemap_get_folios_tag() in a register.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8b202d789e93..179141aeaa26 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -597,7 +597,6 @@ struct ceph_writeback_ctl
 
 	pgoff_t strip_unit_end;
 	unsigned int wsize;
-	unsigned int nr_folios;
 	unsigned int max_pages;
 	unsigned int locked_pages;
 
@@ -1033,7 +1032,6 @@ void ceph_init_writeback_ctl(struct address_space *mapping,
 	ceph_wbc->strip_unit_end = 0;
 	ceph_wbc->wsize = ceph_define_write_size(mapping);
 
-	ceph_wbc->nr_folios = 0;
 	ceph_wbc->max_pages = 0;
 	ceph_wbc->locked_pages = 0;
 
@@ -1129,7 +1127,7 @@ static inline
 bool can_next_page_be_processed(struct ceph_writeback_ctl *ceph_wbc,
 				unsigned index)
 {
-	return index < ceph_wbc->nr_folios &&
+	return index < folio_batch_count(&ceph_wbc->fbatch) &&
 		ceph_wbc->locked_pages < ceph_wbc->max_pages;
 }
 
@@ -1668,21 +1666,23 @@ static int ceph_writepages_start(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, ceph_wbc.index, ceph_wbc.end);
 
 	while (!has_writeback_done(&ceph_wbc)) {
+		unsigned int nr_folios;
+
 		ceph_wbc.locked_pages = 0;
 		ceph_wbc.max_pages = ceph_wbc.wsize >> PAGE_SHIFT;
 
 get_more_pages:
 		ceph_folio_batch_reinit(&ceph_wbc);
 
-		ceph_wbc.nr_folios = filemap_get_folios_tag(mapping,
-							    &ceph_wbc.index,
-							    ceph_wbc.end,
-							    ceph_wbc.tag,
-							    &ceph_wbc.fbatch);
+		nr_folios = filemap_get_folios_tag(mapping,
+						   &ceph_wbc.index,
+						   ceph_wbc.end,
+						   ceph_wbc.tag,
+						   &ceph_wbc.fbatch);
 		doutc(cl, "pagevec_lookup_range_tag for tag %#x got %d\n",
-			ceph_wbc.tag, ceph_wbc.nr_folios);
+			ceph_wbc.tag, nr_folios);
 
-		if (!ceph_wbc.nr_folios && !ceph_wbc.locked_pages)
+		if (!nr_folios && !ceph_wbc.locked_pages)
 			break;
 
 process_folio_batch:
@@ -1712,8 +1712,6 @@ static int ceph_writepages_start(struct address_space *mapping,
 		ceph_wbc.strip_unit_end = 0;
 
 		if (folio_batch_count(&ceph_wbc.fbatch) > 0) {
-			ceph_wbc.nr_folios =
-				folio_batch_count(&ceph_wbc.fbatch);
 			goto process_folio_batch;
 		}
 
-- 
2.47.2


