Return-Path: <linux-kernel+bounces-868347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22BAC05065
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27263B541E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF5302CAE;
	Fri, 24 Oct 2025 08:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gycaGLTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDC9302756
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761293712; cv=none; b=JFz6qCzAVPQbyV/VnkVf3rZv5vjARmuM/RlbVeQwVfu+JhARIp/LmFPSpgGdYjHQFe0hr127MBMrPkiG787G4lISWec3Fb9J/3wFgihS2tGmLJLjM9fcJl3ou7NGbXqqZC2RT9+5dQK/3rE+FV92ZcjcFGekNx4r9xDX4e/CwHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761293712; c=relaxed/simple;
	bh=49SlPs0GtTNvbbpkzvJqX5+myNBId64ehKG2ocaYIl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7/2HDg9AoStr8YGtDgctwVs/Vzmd5YD+halcS7kF0EQ+tGOuW+yWdB8dPoEzZS9oEc+/F/AKg11vn2adZ3usgP/JZJ0ctSHSYB7obkNLU6U38eWdWSbXkd5JqHPZOLs+9ek0IotxrEYhhJjJ9zDokVLurO/r/U32OCa5RV8+I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gycaGLTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB152C4CEF1;
	Fri, 24 Oct 2025 08:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761293712;
	bh=49SlPs0GtTNvbbpkzvJqX5+myNBId64ehKG2ocaYIl8=;
	h=From:To:Cc:Subject:Date:From;
	b=gycaGLTbn6eObMR4+zP6K447DrVnmm//xfPqTnANoNvGwrN7uOq4biTY3s87P4KsY
	 R6wT6/KNbXzfDNOxMFiRY44io30OYQxVur1cJ6jfvDnz7hjKUUPqNQrUZgUrZ3DIrH
	 ndd16rjuRLzICCXNvRHz1AYqZG4p0125G2IvFig32VxhUa5LoFnpU+GcK52BN8w6b2
	 mKYAO9gY9okBDm4+rVCOFrQmtH/zz67CIab6usU7jg2XnBYciFWO8Q5MHo4loxq+G1
	 sL5XVRqCcj2Ptp2U0W+ohdhjCJ/7KF6ePpJVOK+K2N8MN6eQOoudADPUiJreQa9KuD
	 VdkywpXDWplGw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Maintain spsc_queue through drm_sched
Date: Fri, 24 Oct 2025 10:15:00 +0200
Message-ID: <20251024081459.164634-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Back in the day a specialized lockless queue was designed solely for the
DRM GPU Scheduler: spsc_queue. This queue's only user is drm_sched, and
there is no dedicated maintainer entry for the queue.

Add the spsc_queue header to the DRM GPU Scheduler MAINTAINERS' section.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5889df9de210..efafe2b3517c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8580,6 +8580,7 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/scheduler/
 F:	include/drm/gpu_scheduler.h
+F:	include/drm/spsc_queue.h
 
 DRM GPUVM
 M:	Danilo Krummrich <dakr@kernel.org>
-- 
2.49.0


