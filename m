Return-Path: <linux-kernel+bounces-873870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC99C14F90
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 492C964005A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10A821A425;
	Tue, 28 Oct 2025 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbIWaBei"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFC21257A
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659175; cv=none; b=m/5RXg3K7niBQUoLHXkbPLdzUEu0KEdmGImVqFeykptGHJUctRWMlqfDvmfDSt40Ie7+cwnbc4w7HnreWbZJYBi8Qyudbc6Mnl9HBSCqwa8mOGy00dQ+SWzr9pxZOJSQ1UZpmNt5Dv1pHFzwJ4JoN+Y+OOlkEl9KhIgWQOyLZPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659175; c=relaxed/simple;
	bh=LlBb+fjEXY7pk5bLYeRPSGKs235lp02bYGC9Yerww5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CY+VVFetWw41bIjfUs2cIQL5ZfSWjy75hKAGc3VvsXM8CdTJxWZBngeLoa0JeRMdmjAE8Empt6pZn7Jv4mDPMArxZhmcRJbUyrHrPLe4vZ3yJbhsM6HJ9S84+urdAZUnB08R88L/0zTx8zgQ0Gu1kv1WKs9q3byA2t4GYVuQxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbIWaBei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D961C4CEFD;
	Tue, 28 Oct 2025 13:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761659173;
	bh=LlBb+fjEXY7pk5bLYeRPSGKs235lp02bYGC9Yerww5s=;
	h=From:To:Cc:Subject:Date:From;
	b=nbIWaBeiEYMseuyMZPlLpTCcCAWZ+d4qj/0opPJvaTB2UecTlKEnY6AYxodojKA0d
	 aFE6qBst7TuCBV7AxhcfHz30XbTxNSxPDF1JGJ2UWSOkwyxUFP1SXCpRUYMylpbOuJ
	 5Q0smUVG9B+sThYBACe8XjEpLS71QsDLltnxN9+fU/KVq6DPtDYzjBHcfHj+ckGLOn
	 cAX2xGsD+u8ObwTRKPDjk2BDQON/feCriS2me2CXM8oLBAIz4JfZW11p1NvXZPtENZ
	 505iBHXpxsc41AfzpS3FSrLENLGuL/fQ7ale6Tpvo10kZtnJi15LyJM7GJsKtD0qfU
	 md7OiTlGssrqA==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/sched: Document potential forever-hang
Date: Tue, 28 Oct 2025 14:46:00 +0100
Message-ID: <20251028134602.94125-2-phasta@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While implementing a similar feature for drm_jobqueue I was looking for
inspiration in drm_sched and found this problem here. Now I have two
problems instead of one ^^'

Anyways, this is not a huge issue since it's unlikely to occur – but we
should document it.

Philipp Stanner (2):
  drm/sched: Fix comment in drm_sched_run_job_work()
  drm/sched: Add FIXME detailing potential hang

 drivers/gpu/drm/scheduler/sched_main.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.49.0


