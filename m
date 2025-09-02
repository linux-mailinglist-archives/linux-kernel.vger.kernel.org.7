Return-Path: <linux-kernel+bounces-795836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782AB3F889
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B34E52000A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCA2E92A3;
	Tue,  2 Sep 2025 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSvf1ZRW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809292E8E14
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756801998; cv=none; b=Ca3apEzAUPMk9UL/9rQN0niHr2Nvj7rn5HkoDaOLfKz0hZZHKl8B8LEqydmuuraj71FdpMadXvw3qw7FwTKVNe467CXTzMcDWn/v5DBHbYmul6jwQc4pYoxDvD8dWssI+v06VvASzWT1F8MzRPr5uO9BD4eNBQ3fn6IprtqjhfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756801998; c=relaxed/simple;
	bh=tgHDqH0C2lxD8T1iP02FKrEoh+NLndcjoc9fVjgWywI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PIUeq4ev0JqpqnFsV2eaSEfy4r4D1ZKiJlLrHyeV7CxleRe7vPULz48YcZGT/vduM+8W285zXqWX9sY8+zeZAgp7lek1V12XcPyPGIVzl7HcHZQUnSDSxt9Z7/yg3YuhnsWkRjLFMOjv4QxgW7rTypqCNhjGhfN5c7+l3dgJD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSvf1ZRW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFD8C4CEF8;
	Tue,  2 Sep 2025 08:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756801998;
	bh=tgHDqH0C2lxD8T1iP02FKrEoh+NLndcjoc9fVjgWywI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GSvf1ZRW043A+UcKUKqeHcK77lMflTHce9vslIVN6tX0h1WQO7X+d209fBd0Fg5IB
	 mb/L0aSOeNYDVIur9m57FnCU92BZ0JrLft879cwqD92WY6N2hPon0s7bAOA3op+Lr6
	 JJzOqHDthW9vi5gGk7FjvnV8QF1jlNc/cTww3IkFSg1s9ghvysA+OweXqhRESDrr6N
	 hvG3bbz0RSc7qbckco5LgeUYnM3pLSguRa/5XZ1e9sUBT8cJdvVRL2QUtKIU4TSqWK
	 40+vu2Y7OQ/gCkRLJNluhS94ExUYV+uIzoneeW3pZUB04l0Pf1L24vBfow5oBdTdyg
	 +WMEOwSswVOJw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:31 +0200
Subject: [PATCH 03/29] drm/atomic: Fix unused but set warning in
 for_each_old_private_obj_in_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-3-14ad5315da3f@kernel.org>
References: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
In-Reply-To: <20250902-drm-state-readout-v1-0-14ad5315da3f@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=mripard@kernel.org;
 h=from:subject:message-id; bh=tgHDqH0C2lxD8T1iP02FKrEoh+NLndcjoc9fVjgWywI=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVm/1EHQJlu5+OudfzbIK1pk3de3eV6Y8jkm6vfZ7s
 utU1bDqjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRzdKMDW84hRw38p3z4nR9
 stLG/9DDWVL+Jf4/erjupE784eMhoXM3W7rG9Op/0WVOgTFvf98WYazTY+H4YOQZmega/d87P32
 3bpzdmlSHw6vqT/sGsxU5WPF1nhZb/0Kf3dDcfm7ogb573wE=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The for_each_old_private_obj_in_state() macro triggers a compiler
warning if the obj parameter passed to it isn't used in the code block.

Add a similar workaround than in most other macros.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_atomic.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 689a29bdeb4a06672ab6fffecb513d58ff6e07f9..f13f926d21047e42bb9ac692c2dd4b88f2ebd91c 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -1112,10 +1112,11 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
  */
 #define for_each_old_private_obj_in_state(__state, obj, old_obj_state, __i) \
 	for ((__i) = 0; \
 	     (__i) < (__state)->num_private_objs && \
 		     ((obj) = (__state)->private_objs[__i].ptr, \
+		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
 		      (old_obj_state) = (__state)->private_objs[__i].old_state, 1); \
 	     (__i)++)
 
 /**
  * for_each_new_private_obj_in_state - iterate over all private objects in an atomic update

-- 
2.50.1


