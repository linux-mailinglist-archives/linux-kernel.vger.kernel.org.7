Return-Path: <linux-kernel+bounces-789155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 841F7B391BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048623ACBF7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844125B663;
	Thu, 28 Aug 2025 02:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Lc2rwN1t"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9A1A9FB8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756348515; cv=pass; b=Q8G9Z45HxtrRBVIl1nuKkEtlu0D7YQzaN7/ESz5X5nhBV9f5/hqMQtPBUwfDiAzf7EjAaj+vPsBiLcDZRWOjN1RItTE94gmTaMPKJxPtU6lhJLIYCQemBSHdCcNBMnsfay7OGJyE0DySwwhmQqrCxpJ1T/7lHcR/v6HBTQcNafQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756348515; c=relaxed/simple;
	bh=fZ4wDCPJnAkUec9luQsPxpb57A4UCMp6VpgVjj3/JGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZvuVK0VYctYA5f/GKQxIk2NYEn0amY+uvfSUbRVmwdMJb+WYq/ZEpmrhBHEfeYMpNv4ZIPqJfpgXzZqfKoRZMxZ2tQTUlH3q7vFhlOz6JzV7iGS3CQMcODjqRxhxSySK7k5SNFobFYeZMq2QisFlwstsGguhT9r/U7zF8bkpHlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=Lc2rwN1t; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756348503; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IBKrafhpz/+6faHHFrXVSzsS7vuhdJBIAUDLPtiBZvopqN87ZOh3gefQnL2HMB8za4InRngzXSfw+i3Ep8EFMRT4G3rn3FNFaC9vex/yTscArVdGbvDOk25o/iad/pZg8b6C+Ir0Y1aRddhPMWbbFSJkeLZkcfYrA1tbg7goPO0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756348503; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8Q7OTYSNjYnaiJukdzrTqRn402H4JDcPMAA2S6KRFdo=; 
	b=TiNryiQ/68qpAPNeBx9cEU6L2hlUc0tENJXd/+LG4otUVs5WzWlQ0MNINqXJ5kXMpWbHMtuG4HZINxrYKqkpUWvyi5sUiZtIQXOSmYoKGTIxA6OBaTpR31AAtOG67415Zh66SygrJuHtY92AfdLeXZupsceJswP+lMi32fpl4og=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756348502;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8Q7OTYSNjYnaiJukdzrTqRn402H4JDcPMAA2S6KRFdo=;
	b=Lc2rwN1tPYWvyvObc0sht+qWAjW14+wyRCqknv8HvvBPr8q9hRthXvEqWkLuGBZ3
	5mdwjt+Vik7k7frGgGKO+0CBeqIwxl9+wggGfN9CyGRVz8bvu/0ibDsNUSlMUPtmCK8
	XXzVszg/HNH1ZjbwcLpHkwS/MDV2mtaOxPjBLmDM=
Received: by mx.zohomail.com with SMTPS id 1756348500386647.143849521538;
	Wed, 27 Aug 2025 19:35:00 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Boris Brezillon <boris.brezillon@collabora.com>,
	kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Subject: [PATCH 0/5] Introduce Panfrost JM contexts
Date: Thu, 28 Aug 2025 03:34:03 +0100
Message-ID: <20250828023422.2404784-1-adrian.larumbe@collabora.com>
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
to jobs, and also their job slot priorities.

A Mesa MR with UM changes that leverage this new kernel driver feature
is still in the making.

Boris Brezillon (5):
  drm/panfrost: Add job slot register defs for affinity
  drm/panfrost: Introduce uAPI for JM context creation
  drm/panfrost: Introduce JM context for manging job resources
  drm/panfrost: Expose JM context IOCTLs to UM
  drm/panfrost: Display list of device JM contexts over debugfs

 drivers/gpu/drm/panfrost/panfrost_device.h |   4 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c    | 152 +++++++++++-
 drivers/gpu/drm/panfrost/panfrost_job.c    | 270 +++++++++++++++++----
 drivers/gpu/drm/panfrost/panfrost_job.h    |  27 ++-
 drivers/gpu/drm/panfrost/panfrost_regs.h   |   6 +
 include/uapi/drm/panfrost_drm.h            |  93 +++++++
 6 files changed, 494 insertions(+), 58 deletions(-)


base-commit: 5c76c794bf29399394ebacaa5af8436b8bed0d46
--
2.50.0

