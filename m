Return-Path: <linux-kernel+bounces-799583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C4B42DF2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2E43A9341
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018A7C8F0;
	Thu,  4 Sep 2025 00:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ix6YKSoo"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05F4C6D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756944687; cv=pass; b=jq8zfe35rB7kQJnIJI6K8+/8/y0VHAMuZyfNbRs+oTvIbuQLfSlyOaC6rbf7lGMKDOBlp1tM17+6p/M0a2dcDmm58xn9GKu1yZj3vvgZJu3gExcdsu7D+jqdeawA3k2WUGqrTAA1dxF9uvMUEazHKvz4H7+QwTuLFHgB8nL57bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756944687; c=relaxed/simple;
	bh=S9JpQ7vxEI2OzMDoZMbMWkKGhLOU7Fivc4+BWvaevPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m/3cCOl9zJ50sSKNl9Xy9Fjp5SrRvA6HikRJV7dxMhrlKZ7V7NV/5K/qdsfrXcPT+hyqwmIsMcc+x84hGZDf/T97TLy2DnuQOmnQrVrNhig/EFZ8ari6nrQNqUyksE2ipIhsbPnHy6o1OCzHPFQGRm4KFqHWuhoJLO/JnWC/XzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=ix6YKSoo; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756944675; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YGw19DBBhZRtx3DXPyWGYhAePb8+Qx7rxVJfaA3Hkhk0Qt839VTTwWKiOZFCrCPDa5VpoWLHm5DPQrgX9ymtC9GBEF3f8gUSU+CwPqHtSumFSSTvnwX8lcOJENCi6Gez00O/MyMcFrcp/rX7aKPj2xeENQIDSqyLqbZdqKuqdaE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756944675; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8QB3tXwdnZjNmeTTqSWouN9zP030O6r4HM1ip2LE6Ng=; 
	b=XMzjLcH3H7keY2WuLQ7CGhECMf7bv2sXBXg/b55un7xEYf3Vw7lPFpQu1hhgbbGpU6QMAxGkt94uHmnnhdFK5nvFt+9uDdiXcYgE+XGady/8dhWbVQlXOnOPcs6A2EH/j5ol4RtiiEa3sL/hyVlk7wm4EQqop+D4vrv8oF+gXlY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756944675;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8QB3tXwdnZjNmeTTqSWouN9zP030O6r4HM1ip2LE6Ng=;
	b=ix6YKSoovhPc5vZmTzU/AVRYj9CXdJLPnGJJkpK6O/vWCTHHnsLOMiVudofv/Abb
	5uX+Ftv+rE/XelA9eB4zaSwZIbqIHVpiS2Od87xDs2hEfyh3q6u/I3f5/ilulnznVBR
	YosloCDkbHHfWPwN++giM7t7R5SPnR6J1D76+XNk=
Received: by mx.zohomail.com with SMTPS id 1756944673141489.5436021490781;
	Wed, 3 Sep 2025 17:11:13 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Steven Price <steven.price@arm.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH v2 0/4] Introduce Panfrost JM contexts
Date: Thu,  4 Sep 2025 01:07:58 +0100
Message-ID: <20250904001054.147465-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.50.0
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
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37075

Changelog:

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

 drivers/gpu/drm/panfrost/panfrost_device.h |   4 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 147 ++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 203 +++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_job.h    |  25 ++-
 include/uapi/drm/panfrost_drm.h            |  50 +++++
 5 files changed, 388 insertions(+), 41 deletions(-)


base-commit: a3ae3384be7704fcf41279f13190bd8a11204bea
--
2.50.0

