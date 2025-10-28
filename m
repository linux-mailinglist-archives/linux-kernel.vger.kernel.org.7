Return-Path: <linux-kernel+bounces-873470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665AC14029
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 263AB3A6CD5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521733019C6;
	Tue, 28 Oct 2025 10:06:51 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74A7202F70
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646010; cv=none; b=cOJTib+Q1dowSPHoFDB6q+CnythzseRNpTWPlGKIuKzbK9+VtSXGOnio8Ym2Zy22uLbN3IDVQnOPgaWqgg0e2YEVN7rrQDIx236KKI+s6sHDWtjNQooPp+nJJi7VBn9LszBxoD+CiMV+kIiQgfGmKmLUcvDgKEabXG98mJql8+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646010; c=relaxed/simple;
	bh=C0cl/2P4MKAuyFstYlzwdi0CmTWdgcZkNWb+AYWSAC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sQqonxBrIvUhiN08AvZI0o1zLbozvBxk3MEXpqc4HwN7jQt9lnU88lrSzvFJhhqTUBNtkClrNaSty8CKDAw2ggCcnm4Jb8GTVRWswVDIGCnVKn9vS1TRv8jCSErdI1MxtLGyi9bowmwxRR1y0GAOthLnv1GvndIVxdxmTTlpIHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: ca1cbda2b3e511f0a38c85956e01ac42-20251028
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:7e21202b-5fbd-4966-9d7a-2f78413668f8,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:2b600168f7e49529e3d19fd91175a3fc,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850,TC:nil,Content:0|50,EDM:5,IP:nil
	,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:
	1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ca1cbda2b3e511f0a38c85956e01ac42-20251028
X-User: liqiang01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1876996662; Tue, 28 Oct 2025 18:06:36 +0800
From: Li Qiang <liqiang01@kylinos.cn>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Li Qiang <liqiang01@kylinos.cn>
Subject: [PATCH] drm/modeset: Remove redundant __GFP_NOWARN from GFP_NOWAIT allocations
Date: Tue, 28 Oct 2025 18:06:32 +0800
Message-Id: <20251028100632.132744-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
GFP_NOWAIT implicitly include __GFP_NOWARN. Therefore, explicit
__GFP_NOWARN combined with GFP_NOWAIT is redundant and can be removed.

Clean up such redundant flag usage in DRM modeset lock debug code.

Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
---
 drivers/gpu/drm/drm_modeset_lock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_modeset_lock.c b/drivers/gpu/drm/drm_modeset_lock.c
index beb91a13a312..58eac20a8138 100644
--- a/drivers/gpu/drm/drm_modeset_lock.c
+++ b/drivers/gpu/drm/drm_modeset_lock.c
@@ -88,7 +88,7 @@ static noinline depot_stack_handle_t __drm_stack_depot_save(void)
 
 	n = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
 
-	return stack_depot_save(entries, n, GFP_NOWAIT | __GFP_NOWARN);
+	return stack_depot_save(entries, n, GFP_NOWAIT);
 }
 
 static void __drm_stack_depot_print(depot_stack_handle_t stack_depot)
@@ -98,7 +98,7 @@ static void __drm_stack_depot_print(depot_stack_handle_t stack_depot)
 	unsigned int nr_entries;
 	char *buf;
 
-	buf = kmalloc(PAGE_SIZE, GFP_NOWAIT | __GFP_NOWARN);
+	buf = kmalloc(PAGE_SIZE, GFP_NOWAIT);
 	if (!buf)
 		return;
 
-- 
2.25.1


