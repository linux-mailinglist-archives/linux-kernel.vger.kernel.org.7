Return-Path: <linux-kernel+bounces-821534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FCEB81934
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0666264BC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666022F546D;
	Wed, 17 Sep 2025 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="A6bOL42y"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64D17996
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136765; cv=pass; b=qzYiBFcl4E2WEk8klBhDnOiGERQ7siEOYUgxfm6NM9XLNMyiYmAub1yrmrSrL3KTlX9vlpudBgB6n818rD6sQfPyhrPWVHjJYBq4f/DJux1qrCHkhTqq2SEgHAPWId7aRETeKAZ+Cgj/UMpKBtIiQ7ngNpeSMz42LU7sPViIYm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136765; c=relaxed/simple;
	bh=8ENWGcFryPZWd6VgenQL/xfsA7bqNa3goR7My2Jx6OE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eHZkMiosMinVjqrZW8hc+u3Nwa8Lo8lPLrxNSWaMtur48jC3jczxOjSmWosLCEk7nkI2E7ymtzl8KmUC7XUGg/YyuTX1OQqQa+vOf55+68UsvgrGLVF9VcwsW+h80B5aM7+IXp6uY8UPn22XaDoU9K+80HJm3ktPRRHOqKrrtls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=A6bOL42y; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758136754; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CFXqqsEzdlDQ8CYNVRMfOa69ih4jTFJ6mjpxBhZbKi6RfC3rJsMRGes8ih9GC0diSsqAaqWHxwJC6LQrnhLp/abZdqOCyVMX7avfEULlg3UXLy3bnEUOgISv6MTtEQil46wU+66BGSrfqd9Nzb5gu0Tp8ehNC3dAoqEUWSEuik0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758136754; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sfusrheosWlV+dZvZITI2LHNCR/+f7VloSWM8+KsWIQ=; 
	b=HnOucdcDGzgfzQim6NOvqBo4KCb8F2kDCKKhNuqXxC/50kc7MS3uPl4Q0075pjBmK16J1KIvklk0sgQyQVrmQofXMBl/rHlz0CEcgq3bh1+fAfI5CbpuWudR6H76MYEtNQHjh7p9v9nrdYTFPeSnIGwQX7zkw0JLfPYIFDeU/Gc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758136754;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sfusrheosWlV+dZvZITI2LHNCR/+f7VloSWM8+KsWIQ=;
	b=A6bOL42y6MCoxgO3feM6bhS/1Vi+EZ+H4osUFftcDqdXvZ7FnlYFV2ZMMRZcU0C7
	/dQFhIsYxNHf0Opj4cQbJnTsPeXi7rauzRTqcMIVqyuUYWGCNarv02avEBofkPpK64C
	Ask/ye0mnExM/D5gk1Ut7VmBSHYJucU3o5TziebU=
Received: by mx.zohomail.com with SMTPS id 1758136752272980.873728931391;
	Wed, 17 Sep 2025 12:19:12 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v4 0/4] Introduce Panfrost JM contexts
Date: Wed, 17 Sep 2025 20:18:36 +0100
Message-ID: <20250917191859.500279-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series brings the notion of JM contexts into Panfrost.
UM will be able to create contexts, get a handle for them and attach
it to a job submission. Contexts describe basic HW resource assignment
to jobs, but at the moment that includes priorities only.

There's a MR for a Mesa commit series that makes use of these changes:
https://lore.kernel.org/dri-devel/20250904001054.147465-1-adrian.larumbe@collabora.com/

Discussion of the previous patch series revision can be found at:
https://lore.kernel.org/dri-devel/20250912132002.304187-1-adrian.larumbe@collabora.com/

Changelog:
v4:
 - Iterate over all the indices for the scheduler entity array when creating,
 releasing or otherwise destroying a job context, in case someone would want to
 implement compute support in the future.
 - Add R-b tags to other patches.
v3:
 - Cut down number of available contexts per file to 64.
 - Conservatively restored JS thread priority back to 8.
 - Rework of the context destruction and scheduler entity release
 logic to avoid races and that no new jobs are run after ctx destruction.
 - Refactor privilege checks when allowing high context priorities.
 - Checked that uapi struct padding fields are zeroed in ioctls

v2:
 - Core and L2 cache affinities are not longer part of the context uAPI
 - Individual JS priorites are no longer possible, and the same context
 priority is applied onto all the JS and scheduler entities.
 - Minor changes in the debugfs knob to reflect all the above.

Boris Brezillon (4):
  drm/panfrost: Introduce uAPI for JM context creation
  drm/panfrost: Introduce JM contexts for manging job resources
  drm/panfrost: Expose JM context IOCTLs to UM
  drm/panfrost: Display list of device JM contexts over debugfs

 drivers/gpu/drm/panfrost/panfrost_device.h |  11 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 150 +++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 195 +++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_job.h    |  25 ++-
 include/uapi/drm/panfrost_drm.h            |  50 ++++++
 5 files changed, 391 insertions(+), 40 deletions(-)


base-commit: a3ae3384be7704fcf41279f13190bd8a11204bea
--
2.51.0

