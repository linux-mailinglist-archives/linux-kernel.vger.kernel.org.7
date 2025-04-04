Return-Path: <linux-kernel+bounces-588175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C2EA7B577
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 03:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFAF17A70FE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Apr 2025 01:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D212B94;
	Fri,  4 Apr 2025 01:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qaxRiP9a"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C785F79F5
	for <linux-kernel@vger.kernel.org>; Fri,  4 Apr 2025 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730774; cv=none; b=WiW/uyHBF6nf9O/TxROa3vM0R0Qjc5iUt/CBQTJisM2Jxa88zA01XKuL/QuQQRsyXWg89Cn6RfeYflszbAHmz/2rPXOdirBE1RA4KtGDiI1GEJvNWB7M2F+Z+3rNWn1f4bqEi16ICC1Nkgt3MHW3GTd1ykV/gtGtFh6GKu6mSEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730774; c=relaxed/simple;
	bh=DtZAQweiMSk6FZO1f5P958x1appT4pTK+EhZwOYt7vM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PIk4XUrzllz9XO3y+4xb5QY1nZkgRoFYQaPVxR1WFQXbW1UhOJW4NVQjq1HrFUoJK7E7ZjgT0yrBEdpKNdl6j2SIYhs3Sw47ffcLF1s4gkHkDQl6nPSvYKNC6DzSsNH2rfSNcazGm2z1xCut2il0KKueUotorc+M4vxtX3IMXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qaxRiP9a; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IewN7pKcqzoLoYsB64biI0KFLTJjsc/YYNl0t3Vqevk=;
	b=qaxRiP9aYtHeilLBF8FCIQ45S/UjgcGyx6omZ6M/mvXLulgLOqbAdA3pE2FbrgtIyaBqoG
	89LFcAdVpvcB9y6uDF1bjFGyqXBqg4p+84wElumr1tNxpPXxEeT2etlnB1O6mjp6CBLc0P
	mmnfNCj/jQFj/TNcZQhhvOV0A7mhhsc=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2 0/9] memcg: cleanup per-cpu stock
Date: Thu,  3 Apr 2025 18:39:04 -0700
Message-ID: <20250404013913.1663035-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is a cleanup series which is trying to simplify the memcg per-cpu
stock code, particularly it tries to remove unnecessary dependencies on
local_lock of per-cpu memcg stock. The eight patch from Vlastimil
optimizes the charge path by combining the charging and accounting.

This series is based on mm-everything-2025-04-03-06-03. The main changes
from v1 is collecting acks, adding warning in patch 1 and rebased on the
latest local lock changes from Alexei.


Shakeel Butt (8):
  memcg: remove root memcg check from refill_stock
  memcg: decouple drain_obj_stock from local stock
  memcg: introduce memcg_uncharge
  memcg: manually inline __refill_stock
  memcg: no refilling stock from obj_cgroup_release
  memcg: do obj_cgroup_put inside drain_obj_stock
  memcg: use __mod_memcg_state in drain_obj_stock
  memcg: manually inline replace_stock_objcg

Vlastimil Babka (1):
  memcg: combine slab obj stock charging and accounting

 mm/memcontrol.c | 196 ++++++++++++++++++++++++------------------------
 1 file changed, 96 insertions(+), 100 deletions(-)

-- 
2.47.1


