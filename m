Return-Path: <linux-kernel+bounces-643385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5692AB2C04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 00:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E92A174A44
	for <lists+linux-kernel@lfdr.de>; Sun, 11 May 2025 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B8F263F5F;
	Sun, 11 May 2025 22:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="QxvMXDJm"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426625A2B0
	for <linux-kernel@vger.kernel.org>; Sun, 11 May 2025 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747003706; cv=none; b=P2fwRhMp9SkdvhgDs1gyw3oyLOJx70jiDmrJcjGJQINUJ/76SOjuEZoUQX6rGbGmypoIsQOV1EvwJaIcIKRw+wZvUgbVcAtnb1LZeczVAZwOx3TCvQ2Fk6wejruMVNA7P9v3MNzFgsC76T1+k78T9I+/YSSp8Ym+1np3AEQXo6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747003706; c=relaxed/simple;
	bh=meQWEp0Ak2ySI1drhnYG2qe+wCoyacC4Atd00+01mOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ONjYhM76pM+Tsk0jERGr4YNDT7tY6Xbqlg3LP90RukUHJl9DK86Gcv/XwxWGZ4vso4P2e9JB2Xup98ZHGO4u/hsvoMWscRLqT88QAVOQWH7HMhnHWZqq3I7IJTU2GektDc7H2m8YvJf9KDg3wKvePIfgCE3ELDj2T1vTpFTAaHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=QxvMXDJm; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=lJX/DnbKx2vqXxOxF0p4mRt/XD3WEMGW5IGNHdLbHaQ=; b=QxvMXDJmIijPGOq1kaMmDSVGru
	qDW94J5cHKezI7oJ0mxQnduzPX+lL60SvP4ci+vhzFnorDglh8wTJmiiPJvZTkmEOfGBcJZo8q5Fd
	ym009ed6qz0oTIS53QA/OMTLGEf1fkeIEOoBgQaVHMnS859ClqG9z8vorkQkkWw1dH3obM58gGMEl
	3hFuXehOec1hVeA4mk3who7LHgROPvkchXYC+PV1TKLzdc5H1jqF7IyevjDIi1QPhvLBJo+jiVxwV
	CdlCwhdqfvHXxyk0N9wSXohI89xKGitzY/nHXVmtmGFT6pXuVK1sqH+J3X4q5f8P+RtqWR9Q8GBeq
	OIIigHkQ==;
Received: from [191.204.192.64] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uEFNb-006nqn-TI; Mon, 12 May 2025 00:47:56 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: "Alex Deucher" <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	siqueira@igalia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	"Raag Jadav" <raag.jadav@intel.com>,
	rodrigo.vivi@intel.com,
	jani.nikula@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 0/3] drm: Create an app info option for wedge events
Date: Sun, 11 May 2025 19:47:42 -0300
Message-ID: <20250511224745.834446-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset implements a request made by Xaver Hugl about wedge events:

"I'd really like to have the PID of the client that triggered the GPU
reset, so that we can kill it if multiple resets are triggered in a
row (or switch to software rendering if it's KWin itself) and show a
user-friendly notification about why their app(s) crashed, but that
can be added later."

From https://lore.kernel.org/dri-devel/CAFZQkGwJ4qgHV8WTp2=svJ_VXhb-+Y8_VNtKB=jLsk6DqMYp9w@mail.gmail.com/

For testing, I've used amdgpu's debug_mask options debug_disable_soft_recovery
and debug_disable_gpu_ring_reset to test both wedge event paths in the driver.
To trigger a ring timeout, I've used this app:
https://gitlab.freedesktop.org/andrealmeid/gpu-timeout

Thanks!

Changelog:

v2:
  - Rebased on top of drm/drm-next
  - Added new patch for documentation


André Almeida (3):
  drm: Create an app info option for wedge events
  drm/doc: Add a section about "App information" for the wedge API
  drm/amdgpu: Make use of drm_wedge_app_info

 Documentation/gpu/drm-uapi.rst             | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  6 +++++-
 drivers/gpu/drm/drm_drv.c                  | 16 +++++++++++++---
 drivers/gpu/drm/i915/gt/intel_reset.c      |  3 ++-
 drivers/gpu/drm/xe/xe_device.c             |  3 ++-
 include/drm/drm_device.h                   |  8 ++++++++
 include/drm/drm_drv.h                      |  3 ++-
 8 files changed, 64 insertions(+), 9 deletions(-)

-- 
2.49.0


