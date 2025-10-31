Return-Path: <linux-kernel+bounces-880110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5473EC24E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8861A663D2
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C16329E6C;
	Fri, 31 Oct 2025 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qsccBlWM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C8A2E8B9C;
	Fri, 31 Oct 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912036; cv=none; b=ob0XPPpv1puE+fCVFoBm5JJ/En0hwWxDpdxjVTyKBf5HM1GpQfx2gfHJ1ThnM1zP/pft8R/mfrGBgwrCk190wXm1N4u5y+glRB+8gt5HVmeXD2cT4L7D5JnuVINgLiVEHFga3qNxDw5S1EmyiS7JZerLhzmhGK06JaEQc71rmws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912036; c=relaxed/simple;
	bh=SDd4mBlkeUTWsBdfubSSDSqZM77oOIAxyGbT/JP1GFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VTVeMyQZAV7AjzluFF0SnvjCN/Uh5V8CzeISQZVfLd2wywA44IGiTCBHcbsY7rktjYN3wzyZ74cyILORp+8Wof1Iapw2HPQhPM0X1thbtA9RvWW77bdekgG1wFtgCFcSmwcr/83cbVpg4qMWJBvh84N1+hkKdlRm8X3u/te96DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qsccBlWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DA7C4CEF8;
	Fri, 31 Oct 2025 12:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761912035;
	bh=SDd4mBlkeUTWsBdfubSSDSqZM77oOIAxyGbT/JP1GFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qsccBlWMTPUGQq8CJm55Gja33/YFqV6mSTDFyl0r5aRN8rBkkJChCsiAjHINOPdOT
	 E19EKKzKxtxwl5Q2IJ935/4Xxk8fwA2uEG7T//OOgug1BvcPQctfeQaKw3exIvIb/l
	 hX8vFzYc8jq4oK+wHcm2GOr3L3IPDHCqTr6LKwLbUoTfEqN0iDCiHVCA+EaQlWvsoP
	 AXV8iiJ6QMj+9n4h1FAAH06r/3MgLnTvPA15Vs8gYB88TfKZRFNup2r/JGHk+4KM6N
	 VJNBjgjDOC8L9Q5iA9dZIR9ynNgj/5VGBu70ACLxg+CvofEvz1yiIfThqp64auvRTQ
	 jbb8TpvQn+u8Q==
From: Philipp Stanner <phasta@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 1/2] drm/todo: Add section with task for GPU scheduler
Date: Fri, 31 Oct 2025 13:00:14 +0100
Message-ID: <20251031120014.248416-3-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251031120014.248416-2-phasta@kernel.org>
References: <20251031120014.248416-2-phasta@kernel.org>
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
index 9013ced318cb..835e799ddfe2 100644
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
+3. Document the new alternative in the docu of deprecated
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


