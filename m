Return-Path: <linux-kernel+bounces-890512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21219C403C7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429F24F4FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15BB2EDD4F;
	Fri,  7 Nov 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfbHdMYQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711623B638;
	Fri,  7 Nov 2025 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523840; cv=none; b=AJ4LRabRuYcQKjEBlkuY+DB2tEQMQqwrZdGaczHMZONisJEMzlgXZwSua5Q/mmF3IrjuK1rvfk+/LhG2O2johQke4lRTBrs3GfyAHmzf0/1gzllS2ZlSjGj8Lw5F3N/h+m9KCIC6obsv8gnYDue6m0zYJlmCYukstO0QvV6YFlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523840; c=relaxed/simple;
	bh=8RsZViMTWd1WzBt3W/F82dZ7MmqFjjJxHgQxms7REVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LllqkqD7ERICyTtCkqmF+GFpw1FBPUKcf40+NIV+YSg8BLzx0Dhuot9hgwnMksms2TLIg8/z4lZdITWr8Zjw9u9eBgaocqY26jl6gCktKDar10hGT+N2sw0LdXTI1dX7L5AX07Bni/7KVxfKktvepnUkhQy4cmbI95IPztABF1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfbHdMYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01BEC4CEF7;
	Fri,  7 Nov 2025 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762523839;
	bh=8RsZViMTWd1WzBt3W/F82dZ7MmqFjjJxHgQxms7REVk=;
	h=From:To:Cc:Subject:Date:From;
	b=kfbHdMYQ0X9l4+8C+qL9Z/hpfGMStOnJU+deLUhsyYO5NLDMzkaZJv4jeMndtITbw
	 tIxIwHydiSCLdPTlHM0O8qWcZ1OU+QFGRkz10oGIq8UKR/cYYhXMysk86PLl6IRaVF
	 mSWY+3cC6PRvE1hInkTUPBvif/e101muZ2DDQfWxe0frDJLeVZzAvlsJcz44i7n8X8
	 NAYmgkqmgBcGnJn+Qmo4C0Lgno5ubAkg7yX+pUoqEnSyD8K7/HJKnVSLj8idr1Grl5
	 sIg5gZ4fGXkfTwpkpXhmmBMrs1X8mFBrnu2rVEOv49Qb3cBuVw8J+x9OXYEZiU9d1K
	 vFRAcPkGfGtTw==
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
Subject: [PATCH v2 0/2] drm/todo: Add section for GPU Scheduler
Date: Fri,  7 Nov 2025 14:56:59 +0100
Message-ID: <20251107135701.244659-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
  - Fix wrong list item index in patch 1.

The GPU Scheduler has enough problems to be covered by the drm todo
list. Let's add an entry.

This series is the succesor of [1].

[1] https://lore.kernel.org/dri-devel/20251023143031.149496-2-phasta@kernel.org/

Philipp Stanner (2):
  drm/todo: Add section with task for GPU scheduler
  drm/todo: Add entry for unlocked drm/sched rq readers

 Documentation/gpu/todo.rst | 45 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

-- 
2.49.0


