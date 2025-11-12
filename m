Return-Path: <linux-kernel+bounces-898191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BA36CC5487E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C274434943F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38BA2D9786;
	Wed, 12 Nov 2025 20:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0BQiRuI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC14E2D8393
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981194; cv=none; b=WW9Yprvjzztx/t1V2npdecOYyNeJA8nDAKHk5zhzvt98etkVcy2HnFiQLvieQNbzJQCUOCbbE5hFIDFlrn4cbMnafd30tZe5gbrLhAKQ9IwQNIcayYzNviTviTQwCN5O0PuZwQy4LtOlIlbb1UTVCErANCfOxeqFhEfFOwamQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981194; c=relaxed/simple;
	bh=OFcsN8lyJwveVxrkupD2JW5JVs50LUEqi2+bHWzTdpM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oU91eX/a5l9vmgRDUzi+UhdDE9umJZcezEu3ffr/VajXpfMFVs+Fhm/K+eFyeTxKQ2uICx5O8imXsApXsbWtel5cxovKaaH+BV/ErhjEewbkXgBVmDE90fZx/Z4XM8+NaZ7C3lKLYo+njRiFmeR/1c2Lzv0Gl9/Z2EpRyuD8A80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0BQiRuI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79788C4CEF1;
	Wed, 12 Nov 2025 20:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762981194;
	bh=OFcsN8lyJwveVxrkupD2JW5JVs50LUEqi2+bHWzTdpM=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=d0BQiRuIe2pgYVE8onmzuoYcbS/8eFpEryROm9cpuGVxE/pVXxf5b8AL20MGQDXLq
	 R/KSYvnlw6IjNJYDoHYb52QgaG2DzVBPlb6g8/Xog5NPyLX10Zfp52ngMEQeKEvsQv
	 OqsFvHgvot6sR7ZH2hbaID2/A5vvrC9Wo8hkHbalzRwnCtWxCRB8FacyWfvEripiDU
	 hdA4L5Lv/y8sidRNCxwR1du76jSKLwQClgcEECKuF4bq4XSDisJWWRiUdcN2NYANgS
	 jvwxs8kSqv/f5bVygBc3XSqcEprkB8in6e2AjV3H9gf7DQ/E1ALavuFa+KCKEZ1c+j
	 rJWi040LahwwQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3F0A4CE0876; Wed, 12 Nov 2025 12:59:53 -0800 (PST)
Date: Wed, 12 Nov 2025 12:59:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: bartosz.golaszewski@linaro.org, p.zabel@pengutronix.de
Cc: linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
	bigeasy@linutronix.de
Subject: [PATCH -next] reset: Remove unused variables
Message-ID: <8e6ec20e-8965-4b42-99fc-0462269ff2f1@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Neither reset_lookup_mutex nor reset_lookup_list are used anymore, which
results in build errors, so remove them.  It would be best if this were
to be folded into commit 205b261463ff ("reset: remove legacy reset lookup
code"), the better for bisection efforts.

Reproduce on armv8 with:

tools/testing/selftests/rcutorture/bin/torture.sh --duration 10 --do-none --do-rt

Fixes: 205b261463ff ("reset: remove legacy reset lookup code") # -next
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 22f67fc77ae5..93575d5064a5 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -25,9 +25,6 @@
 static DEFINE_MUTEX(reset_list_mutex);
 static LIST_HEAD(reset_controller_list);
 
-static DEFINE_MUTEX(reset_lookup_mutex);
-static LIST_HEAD(reset_lookup_list);
-
 /* Protects reset_gpio_lookup_list */
 static DEFINE_MUTEX(reset_gpio_lookup_mutex);
 static LIST_HEAD(reset_gpio_lookup_list);

