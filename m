Return-Path: <linux-kernel+bounces-823581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE424B86E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B171C86677
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609731C583;
	Thu, 18 Sep 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="GC/xuEH8"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE2275113
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758227113; cv=none; b=kWXv+rCm58CRl770mbWrOm/upEtWQTUc9htE5w5PbZUh4vs1Cw1wz4oxD26NOGtFG9B5n0caEAGp2eNOwGZ/GQM43Y4HHc3tCLxQAY2NUEXRS7NH9D/ORSw4U8+iFYUplpgiWIqLuBJuzsp7lFb8bIFqv+A34La65RWXFSOE2TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758227113; c=relaxed/simple;
	bh=V6fpCITFEhwyPfxcyqcnpSbV/gb5n3gRRVAciHZTQzk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M4RM/78rVuZWo2DlqtSxwvn8dOJbIftCH+vRb6rkTkKXsiWiKlZuNmb254r4sGsxECgl1fqyuqLLgPIugUYcaJCpV6wlKgYdaUHHe4E4OUT14sIuSDxhldEVUwJn/QRCSHJvHedDwAMXOs/ByL+3eldRWTOJqu0rPcZUfely5Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=GC/xuEH8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KSWSMnfsKClm3CO88jw/F2wXZZE8FuFNwsBo3LfrVLE=; b=GC/xuEH8Z2NhexrDp/215Iw+4X
	f1z996qAxQavumwdFkSFH3aG8BVR02CnMLnpCDz+7O81/pSHn5y+GWjpV+JBT+E5xsLMLo0BZL1C1
	zv4EM0SECk6tHLGHdMMKrf3ApbBL8/GtCMZ0PxADGO1gAw5CSCWW5R1BjNuoc6Z+mJtiY6zWlpjis
	vwD0bvxKj/heUoMW5uoRApfzxxQrSKButwethC4cVt4c+ZQ/T6ghpfmjH8qP3+M5ifMmmB21BltFs
	LKYYGPAwZLeuN5Gwr7470UTUqbdR2bhLO68YgetNTzfBnx6NQA7QoyABc4VaDoc+4yZyJpboetIcm
	T//wTLnA==;
Received: from 179-125-87-227-dinamico.pombonet.net.br ([179.125.87.227] helo=[127.0.0.1])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uzLBf-00Dp3q-IW; Thu, 18 Sep 2025 22:25:03 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH RFC v2 0/3] drm/ttm: allow direct reclaim to be skipped
Date: Thu, 18 Sep 2025 17:09:23 -0300
Message-Id: <20250918-ttm_pool_no_direct_reclaim-v2-0-135294e1f8a2@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRmzGgC/32NwQqDMBBEf0X23JRNRNSeCoV+QK9FQqobXVAjS
 ZAW8d8b7L2XgTcDbzYI5JkCXLINPK0c2M0J1CmDdjBzT4K7xKBQFVhjLWKc9OLcqGenO/bURp1
 iNDwJIqywNKrLLUESLJ4svw/5Ex73GzSpHDhE5z/H4SqP6eeW+M+9SiFFkb/QmtJWKa/cm5HNu
 XUTNPu+fwG+xEa0ygAAAA==
X-Change-ID: 20250909-ttm_pool_no_direct_reclaim-ee0807a2d3fe
To: Christian Koenig <christian.koenig@amd.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
X-Mailer: b4 0.14.2

On certain workloads, like on ChromeOS when opening multiple tabs and
windows, and switching desktops, memory pressure can build up and latency
is observed as high order allocations result in memory reclaim. This was
observed when running on an amdgpu.

This is caused by TTM pool allocations and turning off direct reclaim when
doing those higher order allocations leads to lower memory pressure.

Since turning direct reclaim off might also lead to lower throughput,
make it tunable, both as a module parameter that can be changed in sysfs
and as a flag when allocating a GEM object.

A latency option will avoid direct reclaim for higher order allocations.

The throughput option could be later used to more agressively compact pages
or reclaim, by not using __GFP_NORETRY.

Other drivers can later opt to use this mechanism too.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
Changes in v2:
- Make disabling direct reclaim an option.
- Link to v1: https://lore.kernel.org/r/20250910-ttm_pool_no_direct_reclaim-v1-1-53b0fa7f80fa@igalia.com

---
Thadeu Lima de Souza Cascardo (3):
      ttm: pool: allow requests to prefer latency over throughput
      ttm: pool: add a module parameter to set latency preference
      drm/amdgpu: allow allocation preferences when creating GEM object

 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  3 ++-
 drivers/gpu/drm/ttm/ttm_pool.c             | 23 +++++++++++++++++------
 drivers/gpu/drm/ttm/ttm_tt.c               |  2 +-
 include/drm/ttm/ttm_bo.h                   |  5 +++++
 include/drm/ttm/ttm_pool.h                 |  2 +-
 include/drm/ttm/ttm_tt.h                   |  2 +-
 include/uapi/drm/amdgpu_drm.h              |  9 +++++++++
 8 files changed, 38 insertions(+), 11 deletions(-)
---
base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
change-id: 20250909-ttm_pool_no_direct_reclaim-ee0807a2d3fe

Best regards,
-- 
Thadeu Lima de Souza Cascardo <cascardo@igalia.com>


