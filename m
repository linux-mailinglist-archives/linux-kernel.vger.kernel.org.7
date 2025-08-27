Return-Path: <linux-kernel+bounces-788561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E31AB38671
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888E417BF24
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347A52777F9;
	Wed, 27 Aug 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="RtcFH+kF"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6651C1E0E08
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308081; cv=none; b=Y44UdbbRWXKwneRiMEET55jDr4jbzmuUVAksIZ0dycYR+bISVRGTrJ6fcSL5GwpklJcDT4y/y3P2kJ4e3Btt7IiVIhnM3SRCCINYjye7+jLuFGmE39LH9djLURXH0SqonIv/irnNPtAZx+xm4yI1lmoE10BQ2AuDUuYpDFW/hUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308081; c=relaxed/simple;
	bh=NZb/XQxNvXIHwGL6dW21ujPK36mbVwDasZUJTJxKSz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K14SHA/Q/8CcfAAba7SIkm/Xp8thwtOhdaVfkhV9C7LWbHutfoACwmPDgcfX8MLNEW+whekQEJoy6OpLBv8e6PWgNvV3gxEyzAsHe94tJp61ThowUGG0OsklXJ0JvY29UJzLLye/3WQXUkFxpDECCgHBLN7LKdJHi5NWYBf96WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=RtcFH+kF; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.10])
	by mail.ispras.ru (Postfix) with ESMTPSA id 9174B406B8A5;
	Wed, 27 Aug 2025 15:21:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9174B406B8A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1756308076;
	bh=yu0k9+2rr2NU5BBwcwAL/g6ooWau34KHsv081LC7puE=;
	h=From:To:Cc:Subject:Date:From;
	b=RtcFH+kFhdSQ/RQ4H65InHnK3puUJoCRuTewSwyQrdjHuWlATNeiul74+X1JQI9A0
	 cTbP8Hnip4vkDxHAFZjV88yszHWeHX0qI4F86OhID/XbRzekrga3J3OnFoyMfafxhf
	 OErrWZMT/ztGYnuCLQRwIZrYTX+0+ICS1DbWnB1c=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Alex Deucher <alexander.deucher@amd.com>,
	Melissa Wen <mwen@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Hans de Goede <hansg@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH v3 0/2] a fix for connector modes leak in amdgpu driver
Date: Wed, 27 Aug 2025 18:21:03 +0300
Message-ID: <20250827152107.785477-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch is a prerequisite exporting a convenient helper at
include/drm/modes.h used in the second one fixing a leak in amdgpu
driver.

v2: https://lore.kernel.org/dri-devel/20250819184636.232641-1-pchelkin@ispras.ru/
v1: https://lore.kernel.org/dri-devel/20250817094346.15740-1-pchelkin@ispras.ru/

Fedor Pchelkin (2):
  drm/modes: export drm_mode_remove() helper
  drm/amd/display: fix leak of probed modes

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +++++-
 drivers/gpu/drm/drm_connector.c                   |  8 +-------
 drivers/gpu/drm/drm_modes.c                       | 15 +++++++++++++++
 include/drm/drm_modes.h                           |  1 +
 4 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.50.1


