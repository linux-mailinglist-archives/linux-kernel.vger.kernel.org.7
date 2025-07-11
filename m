Return-Path: <linux-kernel+bounces-727865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C754B020CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB69616DFE6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651FC2ED167;
	Fri, 11 Jul 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Sk6Bi764"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885A2AE6D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248801; cv=pass; b=RhWaPOCpqG5fWzLUbOWdV7Vk38X+cddMxBeBoptoN68qd1P9FaSrAbpnVoN+IMVQuYJOPN7En9B2lfNAS5y3iiZJbztGp/s1M9wbPXkCGp/UelJiIrcK3ccS2PD5MCDejiTTMqgHZ9tThlm3lSF1rmdVjDob8CpUOGbRfV8mpjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248801; c=relaxed/simple;
	bh=TumVvbYsWMvjktAMtnSywA47/WYLh/rGoZqWNNAEYLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KUcrE9BjX1J7waRDBxK446g3hfQBUFetADJVzIRAgxeoTJJgvNvbEWDZqN3rilj1PyC0/WxiSLn8qn7f5QZHw8figNtz0Qznp6pkn9kA2lLt9ephrGEq2vPhvU+4iO2LBYkrXkmchcriiiqHEJknxHc23K8qnzUKLLKKPfvK+2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Sk6Bi764; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752248779; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iDtDZbWsnekV0rCvmUANxNaCWNje5kWmBJ/Tlns63hgzvzP9jOTQcbnP25e8rnfSBAQFUvWojFgo03N2fu58oX59ifZKFY+cED3Fxcrc7JWILEPLHMdZpRaVMArTulwxIRGfgaQkVwmuAFdsP19zWUU0HSqWLmhsNxuhL+vaqaY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752248779; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ASHpOI276JmL7bsVLc1cZjd5B6X1k3J9nQa6Rj8VCzU=; 
	b=Di8ifHeTPLulgSrXYybvTd0+usoF2BRXoi8c1aE6edVMN/kwR9mwwFtO8kpgjeyd6rcXd1tPDg0s5UgUnyf/3/lk2ZM2i2Cm+gbMuR5F4Jm7VfEjydv8SMua69nTxutM7PTvdsuskhgkQ9F/gGlwMLKhWxQqVrldJzdj+SQA+HY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752248779;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ASHpOI276JmL7bsVLc1cZjd5B6X1k3J9nQa6Rj8VCzU=;
	b=Sk6Bi764BwsghtdlkliSfS9kxUUozEgg0xHF1heUEmx8E+aGE8V9RPwGDfuv3rVG
	A424FKbq5ec2B5D1yZr+/KFy/BFiPsKLOXldE6f+xeXZOc6RUtDqu7OQHiJUNlmWR1a
	N4AoEHGvGLPPoS4CDyjEiyHlzQgv7ErUCRT+4DDU=
Received: by mx.zohomail.com with SMTPS id 1752248777868590.8325993297874;
	Fri, 11 Jul 2025 08:46:17 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panthor: Remove dead VM flushing code
Date: Fri, 11 Jul 2025 16:45:53 +0100
Message-ID: <20250711154557.739326-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit ec62d37d2c0d("drm/panthor: Fix the fast-reset logic") did away
with the only reference to panthor_vm_flush_all(), so let's get rid
of the orphaned definition.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 11 -----------
 drivers/gpu/drm/panthor/panthor_mmu.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b39ea6acc6a9..ed3712f8d6a9 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -885,17 +885,6 @@ static int panthor_vm_flush_range(struct panthor_vm *vm, u64 iova, u64 size)
 	return ret;
 }
 
-/**
- * panthor_vm_flush_all() - Flush L2 caches for the entirety of a VM's AS
- * @vm: VM whose cache to flush
- *
- * Return: 0 on success, a negative error code if flush failed.
- */
-int panthor_vm_flush_all(struct panthor_vm *vm)
-{
-	return panthor_vm_flush_range(vm, vm->base.mm_start, vm->base.mm_range);
-}
-
 static int panthor_vm_unmap_pages(struct panthor_vm *vm, u64 iova, u64 size)
 {
 	struct panthor_device *ptdev = vm->ptdev;
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index fc274637114e..0e268fdfdb2f 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -33,7 +33,6 @@ int panthor_vm_active(struct panthor_vm *vm);
 void panthor_vm_idle(struct panthor_vm *vm);
 u32 panthor_vm_page_size(struct panthor_vm *vm);
 int panthor_vm_as(struct panthor_vm *vm);
-int panthor_vm_flush_all(struct panthor_vm *vm);
 
 struct panthor_heap_pool *
 panthor_vm_get_heap_pool(struct panthor_vm *vm, bool create);
-- 
2.50.0


