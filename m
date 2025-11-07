Return-Path: <linux-kernel+bounces-890514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FA1C403A6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C87A3B43D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0FF324B2D;
	Fri,  7 Nov 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trWAvWOR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4D321F5E;
	Fri,  7 Nov 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523845; cv=none; b=k+CBvZryU3AitVbwJoTVL8ZQ5yqIWXNwpa2/S+Ns65q4+TpXcEXqUXNdvkxjZN5JRb1kWKpVWD4zh/PPr8Z4EqxxgyUmdL3lNGbx55GtEx04dLg1tZgyqN+XMeFtPbswWQ6+gbFUvdUrNgX07MiW/4G905pNjVz6YG/NsOPws/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523845; c=relaxed/simple;
	bh=Z8U/akBsldXiiAXmfTRDia6T57dNa1mxa22yotGMNtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qVUQkjn3IUfeExLxy1P6FkHp03qeAShkvoVUroDOMxHFKHCMfohauRtGZ1k2Gasf0fNrh9FSjwS+hjQ247BgBLhVLDGm54uefwHNjk7WrzJhZJ5sHd/r8CKOn/3eZakELQOIdSFZUkfKbpFXZeGFdYaWfovPkTduRh/WfRL2J9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trWAvWOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81A4C4CEF8;
	Fri,  7 Nov 2025 13:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762523845;
	bh=Z8U/akBsldXiiAXmfTRDia6T57dNa1mxa22yotGMNtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=trWAvWOR9eqC8BxkMy6CDLWzGBj9gNBPrMD7XJW4DAu65A0bEzxzvNY3EDq5j8Slc
	 PZ5pg6Nfr11YJHQCZ+JyMWzIBMQs1kYHApIl+vkSCyIF6PHTJPcQY4lwLx8T91eBpI
	 oDElKg2AylMW4SeZoCAvcgiKAVNFL7S1g0575a71DMsVaP0J+KhGcg8cmahb2WUbgS
	 DsMWTd8lPy2KzJalhXpaf8IO9ncfkHQZYiVC6XGULKyLGeyL+IH9LhnQ6fkKX832Jt
	 pQ3HwVqztpAVOUlqbw9zganTTSxsQRpk+WC8RwtKGBpji1yYlZnXhBfqBpuKZ4xC+m
	 43YAwYv1ungnQ==
From: Philipp Stanner <phasta@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH v2 2/2] drm/todo: Add entry for unlocked drm/sched rq readers
Date: Fri,  7 Nov 2025 14:57:01 +0100
Message-ID: <20251107135701.244659-4-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251107135701.244659-2-phasta@kernel.org>
References: <20251107135701.244659-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Runqueues are currently almost everywhere being read unlocked in
drm/sched. At XDC 2025, the assembled developers were unsure whether
that's legal and whether it can be fixed. Someone should find out.

Add a todo entry for the unlocked runqueue reader problem.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 Documentation/gpu/todo.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 084e148e78c1..fc8bafd593d8 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -909,6 +909,20 @@ Contact: Christian König <ckoenig.leichtzumerken@gmail.com>
 
 Level: Advanced
 
+Add locking for runqueues
+-------------------------
+
+There is an old FIXME by Sima in include/drm/gpu_scheduler.h. It details that
+struct drm_sched_rq is read at many places without any locks, not even with a
+READ_ONCE. At XDC 2025 no one could really tell why that is the case, whether
+locks are needed and whether they could be added. (But for real, that should
+probably be locked!). Check whether it's possible to add locks everywhere, and
+do so if yes.
+
+Contact: Philipp Stanner <phasta@kernel.org>
+
+Level: Intermediate
+
 Outside DRM
 ===========
 
-- 
2.49.0


