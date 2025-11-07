Return-Path: <linux-kernel+bounces-890513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66895C40397
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156AF1889518
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890FB31C56A;
	Fri,  7 Nov 2025 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ+2Qw+d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF0731D72C;
	Fri,  7 Nov 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523844; cv=none; b=YLbrzU9+6vbqvpZ1yeR5XeVBENtR9dQIZ93vV3YY2RjoBqzhOsUWItD1vUBhdABhljqDQxdwxLVFaqVskUNJIJWxFdDHCZkyvi0leb2NZJ0RG7GKzTyzzEIURs+gvl+GEbeNMmC+Olb65IrIT4zn2/vYTAr45JCZrXBYPBe24ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523844; c=relaxed/simple;
	bh=zT7yJtnaqDGXDO589aaFEUqUScUGnxwCLG7F4lbEeTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjT9OKJAgeUJvkx4VqI2/6EXoXCt2zfQdEwNNvwqfYCS9rxfFlChCw58mIP4aVCDQyBUBgVgKVxJl7c06/2joPHVRqLsMOIFzSS5zVagJgDNOeiY6UAwpAAZFDvxBfU+LbPH7BSeI+RGXDBgkZcAfcQ3VWaA7zDqBCob1NXTuBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ+2Qw+d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F80C19423;
	Fri,  7 Nov 2025 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762523842;
	bh=zT7yJtnaqDGXDO589aaFEUqUScUGnxwCLG7F4lbEeTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uZ+2Qw+d62NRPggJZhj5nQqWclnslQbXHVlTuBTc5WDnQCVhk0C7xQuNMjMXYsbZr
	 tcg/Kv9BoHfAHNn5q7oxs+3irrVJnGjWlAf9sgOp6cXDuuUGvkDwdLMFG1pTJ744ei
	 E14I92eGwalKkixrWpxnXGNf4NgmnxVj31USHjrt9n/c3OFAmq8V5ncAtjWYgJQRWN
	 Hzgk9AWBYz5o9AntRmhs/4le9FncKlgTSeovjuCeTO8z7YoBOQnpGRHiMsKbUR1Gu1
	 JA8rz/zeiQ9xISUD8QkI0jD2BAWifSNmL463j99ZaPGjy66jh0LMaRePYpN9duXopZ
	 7XKHkH5wK/e+A==
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
Subject: [PATCH v2 1/2] drm/todo: Add section with task for GPU scheduler
Date: Fri,  7 Nov 2025 14:57:00 +0100
Message-ID: <20251107135701.244659-3-phasta@kernel.org>
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

The GPU scheduler has a great many problems and deserves its own TODO
section.

Add a section and a first task describing the problem of
drm_sched_resubmit_jobs() being deprecated without a successor.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 Documentation/gpu/todo.rst | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 9013ced318cb..084e148e78c1 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -878,6 +878,37 @@ Contact: Christian König
 
 Level: Starter
 
+DRM GPU Scheduler
+=================
+
+Provide a universal successor for drm_sched_resubmit_jobs()
+------------------------------------------------------------
+
+drm_sched_resubmit_jobs() is deprecated. Main reason being that it leads to
+reinitializing dma_fences. See that function's docu for details. The better
+approach for valid resubmissions by amdgpu and Xe is (apparently) to figure out
+which job (and, through association: which entity) caused the hang. Then, the
+job's buffer data, together with all other jobs' buffer data currently in the
+same hardware ring, must be invalidated. This can for example be done by
+overwriting it. amdgpu currently determines which jobs are in the ring and need
+to be overwritten by keeping copies of the job. Xe obtains that information by
+directly accessing drm_sched's pending_list.
+
+Tasks:
+
+1. implement scheduler functionality through which the driver can obtain the
+   information which *broken* jobs are currently in the hardware ring.
+2. Such infrastructure would then typically be used in
+   drm_sched_backend_ops.timedout_job(). Document that.
+3. Port a driver as first user.
+4. Document the new alternative in the docu of deprecated
+   drm_sched_resubmit_jobs().
+
+Contact: Christian König <ckoenig.leichtzumerken@gmail.com>
+         Philipp Stanner <phasta@kernel.org>
+
+Level: Advanced
+
 Outside DRM
 ===========
 
-- 
2.49.0


