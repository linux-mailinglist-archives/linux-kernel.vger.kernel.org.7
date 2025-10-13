Return-Path: <linux-kernel+bounces-850187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2699BBD2309
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C3188F9DE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB1B2F5339;
	Mon, 13 Oct 2025 09:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltTFxs4l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDB523F429
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346088; cv=none; b=B1IRVL7gIsssg7fZ/CBbqeySF8saI2Xi9LYqlneP9xDrUwrV8YeJM8cEEV8CdQ+QnL+yldq4m9i6ZBd5GO29EpjlRmggPBjSoe0TS+G/e94lfjkBb1Eq9rge4H87A0DPKuACJyfMgJzkLbweyu9YU2FNZCbN0fcii+gr2baLB1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346088; c=relaxed/simple;
	bh=PUVPVKDMQ8AW8ONm8isXy8IF8Y+8DpKbP240A2K/4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uz37IfAmNuWBf77hDmoNBStgt2mIpHOQsJmZUiBpEXOvDCRHb097uEXjZ7Wt2mDLiSuhS9XTqDzBdymd5kItNY7R7AvKRBp1/7DsLMa2oT6GMnz3cWbyO09TNk8F4/8Boc4t4GiprSx4XoR5SxgLLMXbN4N5GtCPPi+034+hbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltTFxs4l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66412C116B1;
	Mon, 13 Oct 2025 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760346087;
	bh=PUVPVKDMQ8AW8ONm8isXy8IF8Y+8DpKbP240A2K/4Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltTFxs4lX2XDLPKqfuaxKXZ7Tn8xJ4K4cHvljXIen2nNL51d7uSuKIOpP9AXnWB3Z
	 lb8Mhvko8dTdtcPqJ0FVbEUroZFci84ozP+qsc2KHdPlBaqBAE8KASVt8LhA2+z3yd
	 8Paxm8LPWdldlYipY61zmeh/QTQ06QVOUHU+HDU50j3lR0uPfsDZyplYyCVnjxJsNu
	 vAhfoeqxfcD0AWdxl/4SdSdyYaxBTV5fbPnub09MiKaPBgJ1Bo6HF0/6JeBLkEUqLC
	 toTejyL65+tqBJZOk+yosJ+609dZOK877Baf+A+nGFm+d1O+/tf6ltpKUFLLlEV6wh
	 u3OOI0unDbFsA==
From: Maxime Ripard <mripard@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maxime Ripard <mripard@kernel.org>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/atomic: Change state pointers to a more meaningful name
Date: Mon, 13 Oct 2025 11:01:21 +0200
Message-ID: <176034607170.51549.15195045845360719384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008-drm-rename-state-v2-1-49b490b2676a@kernel.org>
References: <20251008-drm-rename-state-v2-1-49b490b2676a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 08 Oct 2025 15:11:42 +0200, Maxime Ripard wrote:
> The state pointer found in the struct drm_atomic_state internals for
> most object is a bit ambiguous, and confusing when those internals also
> have old state and new state.
> 
> After the recent cleanups, the state pointer only use is to point to the
> state we need to free when destroying the atomic state.
> 
> [...]

Applied to misc/kernel.git (drm-misc-next).

Thanks!
Maxime

