Return-Path: <linux-kernel+bounces-853517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55EFBDBE19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BC1C1890DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84FB1DF748;
	Wed, 15 Oct 2025 00:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="GOlClg6i"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90B1DDC08
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760487063; cv=pass; b=pBlZmrJ4R0+sj7Yt0FFbZsn8NtgVs56rV3xufCYo105qwjIg0sapBCjV+uHQSq/tnIvyqaRlGRXHEMjVBUrzU3Awub6woC5fXt+iJyxozrPxXJEdG1SxnuMywqkvY6jjNpluG0TgU4GcNyXBH3GM8jJcEtAyeItXrcNMYojSx40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760487063; c=relaxed/simple;
	bh=fxLnFjMtM2ri09FioMa+MnPHqxq867jFDmTGBqIEtbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHeSrwnY783WbtoAO8S9pKPWzdEmovihIdCqfTnBYR6irrS8SQFLXEs5d7QEBEAfl2CItN0sojym4uw8nwqwi7BxKQcVRWYnUD4MGhZdKP73smdLh8Ehj5uzuiASKTapRPuVa1SOBQ6qKqqbxORlWVUtD32MQ9GE4nAXTtxLfgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=GOlClg6i; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760487047; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FiqKRchBy/UOwvv35ApcwqAxGt0Ia1z3IdRbEBNBITCy5G2VAw/iMuB8flAbDHcUHtDbBqB9EakYLDKVJB7B9TMfv2J8WlrXOi4bC2quMo3An4DFSTXst8xdeNIQDWk6YXdOmeB/v3WWRIGLrkgPWqrMoEFhfrzKIYO0LqiTDPo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760487047; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N9xGpiHlxZl3wnv51uuxkUFFWgYoH7QahEAd4MQTmOk=; 
	b=HGctZZ9/Rg7TZWeznqB+XRp//vApYMkR/e1IlZIYl5kG2crV1Ew1fG4ROUhDo6iAfxxPC3shil4WrtthgdbYLmpx+5dxje6HBUpZaVX0cCvGJO3qMZd3b1D9oEQ3zDhrjSbrHTnb2/a8AfUR7AURj4+NF6Qamt/yaxqoy8PSHpA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760487047;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=N9xGpiHlxZl3wnv51uuxkUFFWgYoH7QahEAd4MQTmOk=;
	b=GOlClg6ikI6AyOV44ILPyP6jc/UztQFZtd7ggJ4xBi3bSRM+psCT+Vj0waOl8uxr
	nHfA6d3277Si4a5jAdn0vx3pY22Fvw3MfHaTAXme9I+aDkImFzMqjmUGkG3/aaxRsEV
	RNm5hBNDAfEWJ12NSkbWltQ0oSQ2kGtUq8lQLWX8=
Received: by mx.zohomail.com with SMTPS id 1760487046429914.2439824041805;
	Tue, 14 Oct 2025 17:10:46 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v6 10/12] drm/panfrost: Remove unused device property
Date: Wed, 15 Oct 2025 01:09:16 +0100
Message-ID: <20251015000930.356073-11-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015000930.356073-1-adrian.larumbe@collabora.com>
References: <20251015000930.356073-1-adrian.larumbe@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The as_in_use_mask device state variable is no longer in use.

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_device.h | 1 -
 drivers/gpu/drm/panfrost/panfrost_mmu.c    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/gpu/drm/panfrost/panfrost_device.h
index 45d77cda8b89..e61c4329fd07 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.h
+++ b/drivers/gpu/drm/panfrost/panfrost_device.h
@@ -147,7 +147,6 @@ struct panfrost_device {
 	DECLARE_BITMAP(is_suspended, PANFROST_COMP_BIT_MAX);
 
 	spinlock_t as_lock;
-	unsigned long as_in_use_mask;
 	unsigned long as_alloc_mask;
 	unsigned long as_faulty_mask;
 	struct list_head as_lru_list;
diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index 099e6797b2b5..867da6fc755b 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -713,7 +713,6 @@ static void panfrost_mmu_release_ctx(struct kref *kref)
 		pm_runtime_put_autosuspend(pfdev->base.dev);
 
 		clear_bit(mmu->as, &pfdev->as_alloc_mask);
-		clear_bit(mmu->as, &pfdev->as_in_use_mask);
 		list_del(&mmu->list);
 	}
 	spin_unlock(&pfdev->as_lock);
-- 
2.51.0


