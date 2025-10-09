Return-Path: <linux-kernel+bounces-846782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EDDBC906F
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 621F54FB575
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9882E6CCC;
	Thu,  9 Oct 2025 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoHmkTYQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABA32E5406
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013026; cv=none; b=p7+F3JF2j6xlRFY/OQm/HX7VAtmHxjX8at+iXO8rd7/S9sEp/Y9en+n/bvhCkM8OdAGG2puyTeQsoOig7r3qfHGkj2v9mfStpEZ3kltDBIPAu+PrFYP1Be5/VWenJyCVu/eZHE7MbnIyzJ76NvC9HX/KldHbRkMn/kBPQyOqCcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013026; c=relaxed/simple;
	bh=M+3YAASa1CI+N7TinZJVxMAa56QlE5vpVGRMhWYveOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHpxkRgyrN1GTLXLqleyhswjAArsiuD14LNLBkxr6gm1vZAe1ekyrtABXS8rELI7t+jqDq7NyH3iUd6mAQprAwzQsHRL9tt018dWe144uFeYfC1nxrTs8Ur4XjtrWcVEK0WOyBWnUB29p/+eEixMGIi1EerXZgefY5AhpYmw1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoHmkTYQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760013022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fMM/vJwKTSF+IolScmN40UJvXxykm6btY/TgTkySF4o=;
	b=DoHmkTYQZPnb00zSC8XcPxblyG9TNbTkHeS6lOSeZucb9mntbLH/1OBeGSpoC442nP0iNR
	pBjRrvkELKrVGXXF9SHvjETnbsDvgKgkeSo0KCR1FZwNTxzQ+lcGQieGD+RjLhJa+kF1Q4
	bL1sEyPof8Tb6/uJMz9QC6r0shJWZWg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-6q2-DYFRMbmRMX3SUtQhhw-1; Thu,
 09 Oct 2025 08:30:19 -0400
X-MC-Unique: 6q2-DYFRMbmRMX3SUtQhhw-1
X-Mimecast-MFC-AGG-ID: 6q2-DYFRMbmRMX3SUtQhhw_1760013018
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A91C1956086;
	Thu,  9 Oct 2025 12:30:18 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.45.225.212])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6F26818004D8;
	Thu,  9 Oct 2025 12:30:13 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/6] drm/panic: Fix drawing the logo on a small narrow screen
Date: Thu,  9 Oct 2025 14:24:48 +0200
Message-ID: <20251009122955.562888-2-jfalempe@redhat.com>
In-Reply-To: <20251009122955.562888-1-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

If the logo width is bigger than the framebuffer width, and the
height is big enough to hold the logo and the message, it will draw
at x coordinate that are higher than the width, and ends up in a
corrupted image.

Fixes: 4b570ac2eb54 ("drm/rect: Add drm_rect_overlap()")
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 1d6312fa1429..23ba791c6131 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -429,6 +429,9 @@ static void drm_panic_logo_rect(struct drm_rect *rect, const struct font_desc *f
 static void drm_panic_logo_draw(struct drm_scanout_buffer *sb, struct drm_rect *rect,
 				const struct font_desc *font, u32 fg_color)
 {
+	if (rect->x2 > sb->width || rect->y2 > sb->height)
+		return;
+
 	if (logo_mono)
 		drm_panic_blit(sb, rect, logo_mono->data,
 			       DIV_ROUND_UP(drm_rect_width(rect), 8), 1, fg_color);
-- 
2.51.0


