Return-Path: <linux-kernel+bounces-859756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3BDBEE7D0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 16:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AA8A189A839
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B8A2ECEBC;
	Sun, 19 Oct 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="acCkHefd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9982ECD3E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760885615; cv=pass; b=BpUOkUYmiCfKQQ47Y99GVInZxhFw0akX3LY2z/DUFUujTXDWGlBjxIPeMOs6d1Cbr/0KGKoEeccqpDxBK5k/t6cY/X/7N0U42AOBpQd1an03b37yaZumOCCYCE3JpgzDEEQ4Qw21C8qRJvXglRzyr+//rfB5kXperwaM9SylqYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760885615; c=relaxed/simple;
	bh=D9o6Wdywys+ncqaeAndfFaLqrxH06GvaPfz82Uii4g4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3M7JXpPaTYNf1hnnoVAV9L6tuLsZ3HcrAiVNMI6oyOj/LaDY5dygwx6V7abet9GAVN1B3TjLrMdSelfjYiioCiBOzyXnZn28RJlwK4Lr4Mmvir5kt6DstcGNPci3GW9OtFSpfdAB9JoOSpaNRv5Hzj/w1WkJPkTWlW7Mj8cEBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=acCkHefd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760885598; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=fmcMGRHawDMuZEbByUIRkB6FrM86fq/xIFrsnikF9dCJhHxzHOUTItpoOCemsgql8T1x+yuKbwJ3hrScwhSbNwxOOULWdtTfKpCZ92l/Jhlk1CscAPZIBYMiFO32Ij50lbzJuN1Q03UVJ97xt9aWLT9VQ2h96Chdvo3H6YC8jb0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760885598; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=P6kEW3wN0rHqfBXpozU2ypbUV29Nmsf7GP6NvILWeBc=; 
	b=TlTpQ15b0vo1+EQVBDgjOcrWBn7VTCJzcTitKxFNjGi540GJmpH0gafceEgJiTOPWeNCzO9XRS7sgMqrKqRRWv/XuZRuvRdOyluWJQ//doArd2JNzfTDMtx44VrilDia6kBU1/lsLWkpiXqNnb0GEdtk1wA3aRNu5cj2LuKAhjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760885598;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=P6kEW3wN0rHqfBXpozU2ypbUV29Nmsf7GP6NvILWeBc=;
	b=acCkHefdIYeSU+3p1FAtMODeKZFjV7W6Nz11xWSBEAewuWwncMZBVOZSusx1dI9E
	1A7MpnT2tIjbqr5mlozpp8BREFhD09xS8C0dbAObVph28EWow3gWrXS22xSoJyH6TN0
	+0nDjAFibnO5SFbxZU306aJWkRt0MEURGxzG3ftA=
Received: by mx.zohomail.com with SMTPS id 176088559705027.752504860143745;
	Sun, 19 Oct 2025 07:53:17 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v7 10/12] drm/panfrost: Remove unused device property
Date: Sun, 19 Oct 2025 15:52:15 +0100
Message-ID: <20251019145225.3621989-11-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
References: <20251019145225.3621989-1-adrian.larumbe@collabora.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
index 0e3adfbcbdcf..02ccc05e23bb 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -715,7 +715,6 @@ static void panfrost_mmu_release_ctx(struct kref *kref)
 		pm_runtime_put_autosuspend(pfdev->base.dev);
 
 		clear_bit(mmu->as, &pfdev->as_alloc_mask);
-		clear_bit(mmu->as, &pfdev->as_in_use_mask);
 		list_del(&mmu->list);
 	}
 	spin_unlock(&pfdev->as_lock);
-- 
2.51.0


