Return-Path: <linux-kernel+bounces-880109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEDCC24E71
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F96F3AB6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA021D3C0;
	Fri, 31 Oct 2025 12:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QOKeUguv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5D12B93;
	Fri, 31 Oct 2025 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761912033; cv=none; b=kaWrH/dzjcN9DmrC73sP8jWMtAFuW3IMxiz2XRN/QDPUXfQabtRSyTtjcWqVTSpYev04F8tX6E3I4oyvP5XhI9x/QmCKOZb+UgNP94JfoeK0/tD6+y+aV3m1SybGPec+5EhwzvBXjjdTQqm5HfA7UJJchbJxjfEC2RefSL0ItmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761912033; c=relaxed/simple;
	bh=EOSfn/bp0y1y5/7RCIQRJdv2XS7cd/rWRnzyFY77eJU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCSIt/Qa50h+KRHEbGsy+l/ilpbBiwJqY9K6Rr6+POmTIvROJdSuWzTI4SfRrbq93i5KeOOKZtrBjfyuv1XW3obsJ8zKrVDvbP+HCNGBEz7G9fnf/ke9Mln1Rp42M6y8L+eprdtlnklZHLBgVdat/m3mv+P+R/67NDePaNungDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOKeUguv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E889C4CEE7;
	Fri, 31 Oct 2025 12:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761912033;
	bh=EOSfn/bp0y1y5/7RCIQRJdv2XS7cd/rWRnzyFY77eJU=;
	h=From:To:Cc:Subject:Date:From;
	b=QOKeUguvlX70RZ0IM/YpAOHGdANG/qRS5Tx/ucGffpJ6CuiCu1SRQxVxggF2bWt8p
	 0T/avhIHG26DQj+AaXUd8rLLSmLkWnz5MN8L4MsnjQFxsH7+fuPYX7avTIVlmuk3m5
	 7K/G/pWREDP8ievO5o0HnqEyYHV6tFiIx2KBFAzfCosnxLwbwJFMVeABIhzOI2tJUI
	 HpyTG/6rSOahwLUpE7oRtmgQBj/iUSXygjKBrc/IXnRRdigeDfSoUTkrCMu8FJjtFr
	 HcP9zPtKpReJjUAc3qxn2E8nCfVTEdFVfu5IvqyVd2PuONYASLgrYL4bPBXGnf9Eme
	 eOrtXqBTG5cgA==
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
Subject: [PATCH 0/2] drm/todo: Add section for GPU Scheduler
Date: Fri, 31 Oct 2025 13:00:13 +0100
Message-ID: <20251031120014.248416-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


