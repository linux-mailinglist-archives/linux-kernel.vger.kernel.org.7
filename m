Return-Path: <linux-kernel+bounces-814101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9174B54F47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958855A3BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CF5302CA4;
	Fri, 12 Sep 2025 13:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="P5UoZH71"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87CD30149A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683250; cv=pass; b=EyMisrzwKgcHAmQhVHkpZGUej08KkqEM/HnzlkIV7PntebD/8eK3hK2lhV0nVJzf2Ida1iTnFChzJaL+NNpVr33b1IzIH3xwJ/dZ1oT9oKl2D3Aj9JIlFxjRhZJXQUDr06Jb+srP6VpKAAI/QEWZ6MFqkeejYXNa6BErYmoQjs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683250; c=relaxed/simple;
	bh=XJTIZ8Ccca7W1Zav6mboHC0ZmxIQdttfc29sPoGiCSo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jQDxSS4QWMUAkTNOUjC1aWreKvsxzohbJfGQTGYtn4I0H/8/6F1pyI/2hD0qmFL+/So3hXXFi1IiwxFYH6We8ym6+hwknf1pkLXItph+N865+k/TIndxhpog4S6FgvdXOyUQ7lD3C+EfOIgBg9rw484jEc5roBCWnRwbZlallVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=P5UoZH71; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757683240; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Po5/1egBXNp4xGZsrJYA8tKqH+i0iesZWhnWwHVYBtW3lsga1tjt5StUj8j5dueV2H0aGcCn8wa/HPSzsi87zu7v132tO7EVYtCraPFD0nIdpPkq1V2QZspPrtBjp4tty1hlqv/+Tt4UJp993Y6ZqaA13b5IBlHj+tUrCR4uluk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757683240; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QHndbBCfSJRBzBTzOScCJS2U2fT010SvPmxn2g/i2Q8=; 
	b=idYsgCkK590c+YMoLRlFXP0m52FOqby2v1+aJTGLK39poFt94VBgRaH4HLz2RIRByIt7H2fxUX9KpJynO/bYrHaa2i4PoIgYCRl79ZDYj5kZxYMpfUBxi1/Tp5pTOspDebceBE2++638lsEhCIOaNEF6MkzoGmbq2EpSg7MBjqg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757683240;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QHndbBCfSJRBzBTzOScCJS2U2fT010SvPmxn2g/i2Q8=;
	b=P5UoZH71qQIt2th13/FDLyMxX5pVD6kw6BfDEZVCE0aO5gWCp4SZ802ObDW/6iRR
	25MOX1CpLomb3LkSj3LJWZ8d/gM1Q2xdNae5E+SLPaLrlana7PYMP2McuPakyqIz1/D
	k90SKrd7fwCiQcdz+PxIeP3zfJI6VqaZP7/EiGwY=
Received: by mx.zohomail.com with SMTPS id 1757683238342162.86189655538965;
	Fri, 12 Sep 2025 06:20:38 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v3 0/4] Introduce Panfrost JM contexts
Date: Fri, 12 Sep 2025 14:19:11 +0100
Message-ID: <20250912132002.304187-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series brings the notion of JM contexts into Panfrost.
UM will be able to create contexts, get a handle for them and attach
it to a job submission. Contexts describe basic HW resource assignment
to jobs, but at the moment that includes priorities only.

There's a MR for a Mesa commit series that makes use of these changes:
https://lore.kernel.org/dri-devel/20250904001054.147465-1-adrian.larumbe@collabora.com/

Changelog:
v3:
 - Cut down number of available contexts per file to 64.
 - Conservatively restored JS thread priority back to 8.
 - Rework of the context destruction and scheduler entity release
 logic to avoid races and that no new jobs are run after ctx destruction.
 - Refactor privilege checks when allowing high context priorities.
 - Checked that uapi struct padding fields are zeroed in ioctls

v2:
 - Core and L2 cache affinities are not longer part of the context uAPI
 - Individual JS priorites are no longer possible, and the same context
 priority is applied onto all the JS and scheduler entities.
 - Minor changes in the debugfs knob to reflect all the above.

Boris Brezillon (4):
  drm/panfrost: Introduce uAPI for JM context creation
  drm/panfrost: Introduce JM contexts for manging job resources
  drm/panfrost: Expose JM context IOCTLs to UM
  drm/panfrost: Display list of device JM contexts over debugfs

 drivers/gpu/drm/panfrost/panfrost_device.h |  11 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 150 +++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 195 +++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_job.h    |  25 ++-
 include/uapi/drm/panfrost_drm.h            |  50 ++++++
 5 files changed, 391 insertions(+), 40 deletions(-)


base-commit: a3ae3384be7704fcf41279f13190bd8a11204bea
--
2.51.0

