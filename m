Return-Path: <linux-kernel+bounces-621356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62964A9D838
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 08:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE91780F8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 06:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D951ACEC8;
	Sat, 26 Apr 2025 06:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kItm1LyY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C17481B6;
	Sat, 26 Apr 2025 06:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648042; cv=none; b=S6BVd4XMUIpnpOPe7B51IVl/rbqFjb7ipmcVgYm5gcMs/2xAArZLQDoymDSUtUFkv0WQNob0W+8R7pojaFZTbiXrlf5YCzP79ey4LUG5X8n1iQ5jDNAFEYKRO8w6Vq0TiUnymg6CDTUYy/6I98hIWQQuOhnXzn0ziHy2k05D3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648042; c=relaxed/simple;
	bh=tgnkQjbME95yyx26he3+PrzzkQMxy8GR11SY9HIto2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K6Gm2ZLeZKBGrZS67jXkMAWfVyzwHBSqMRDIMdwyLIExbz1wPp/mSMxLmBMdJF8IYupnJSOQWJBeEkKOoRwTzH5+g+8qgJ1ZfAVIiDkWwcwls5G1CBTBBSdpckgCLeOIhBq6e/PvEyjVPgtZJ1VipCGl9UO4cDzBA13Y83PpO+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kItm1LyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588B0C4CEE2;
	Sat, 26 Apr 2025 06:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648042;
	bh=tgnkQjbME95yyx26he3+PrzzkQMxy8GR11SY9HIto2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=kItm1LyY5xe3XMkcah/akXlxaFMBxPlQEXLELtW+ZTB0PCEvXfhO7nJD8tqW5xCPq
	 RYXNKKUgo5CtfJoLq5RaUJt7spV6y+vpcO7sqgjjFZ5ssDGtWAQRA66eJwe0kYNjDi
	 LrJGf7qcqOJr6sLFCbTXk3+0PeW/K6V8DP2sY3vP9IToZRzEECjPKXVOhlzQbgx/uW
	 lFnxwqR/CDp5o7hY6+en4WlUXpAFmYzCAuRy0si4c7U5Y4RFIuJ1i/Xw0LgAmwmBS9
	 HXaU7pSvkQTwXKGCHOwdJScRIlLhlhXdVGPkGvQJSN65n0ItpcjG+JHFv0KX4H5TYy
	 PxESg/+v7ZFxg==
From: Kees Cook <kees@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Kees Cook <kees@kernel.org>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Matt Roper <matthew.d.roper@intel.com>,
	Gustavo Sousa <gustavo.sousa@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Gnattu OC <gnattuoc@me.com>,
	Nitin Gote <nitin.r.gote@intel.com>,
	Ranu Maurya <ranu.maurya@intel.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Angus Chen <angus.chen@intel.com>,
	Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] drm/i915/gt: Remove const from struct i915_wa list allocation
Date: Fri, 25 Apr 2025 23:13:58 -0700
Message-Id: <20250426061357.work.749-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=kees@kernel.org; h=from:subject:message-id; bh=tgnkQjbME95yyx26he3+PrzzkQMxy8GR11SY9HIto2Y=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk8lcvipJa8W+WvvlcpZW4B19WOZr7wTpaktT2P8/bYz 1qi0n2xo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKzeRgZHqX/1Z20lO/fpmST CSeKjqsuzK5R+NfpXLpwx6T9HaY+gYwM+4K9Di5fy3b3GQN3+v+q1KpHB+aUti25s6tcaGI61+M SBgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct i915_wa *". The returned type, while
technically matching, will be const qualified. As there is no general
way to remove const qualifiers, adjust the allocation type to match
the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Gustavo Sousa <gustavo.sousa@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: <intel-gfx@lists.freedesktop.org>
Cc: <dri-devel@lists.freedesktop.org>
---
 drivers/gpu/drm/i915/gt/intel_workarounds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_workarounds.c b/drivers/gpu/drm/i915/gt/intel_workarounds.c
index 116683ebe074..b37e400f74e5 100644
--- a/drivers/gpu/drm/i915/gt/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/gt/intel_workarounds.c
@@ -156,7 +156,7 @@ static void _wa_add(struct i915_wa_list *wal, const struct i915_wa *wa)
 	if (IS_ALIGNED(wal->count, grow)) { /* Either uninitialized or full. */
 		struct i915_wa *list;
 
-		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*wa),
+		list = kmalloc_array(ALIGN(wal->count + 1, grow), sizeof(*list),
 				     GFP_KERNEL);
 		if (!list) {
 			drm_err(&i915->drm, "No space for workaround init!\n");
-- 
2.34.1


