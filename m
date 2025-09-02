Return-Path: <linux-kernel+bounces-795838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BCB3F893
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7D01A84EEC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497A2E974C;
	Tue,  2 Sep 2025 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7LRzvje"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208062E9733
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802001; cv=none; b=lMLvAWmZqRJSP1wrHhtXjFJ/X73MZA4W2qDyr/m5/NFLEU45swJLBtV+EhMOFAfwu6mSp7Lk9AgkXc+JBJCW5H6FZr1Azci9XZl6Z5C/eksCYxOooIfBQLpbdERbIROqeDpcIh1R6kAiPvoW7+IuaEmN9SrsMf+bjwt+1CB11Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802001; c=relaxed/simple;
	bh=uSx8gxP4bhNu5Nz4ZWIuRfI4kUACjD7tGQ0Jp8coKBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Voo6Rpnn2UuqByF28ho3SRm+IcULysF675T6KVLqHL/sxdiy/DxoMUZ78tENj9EEbmmQjDregmMopbRteGAAbfPmgo0YG+QfxB7VyToJ8SAo6JVfYEVZPjopd9SMrevRUrPwuIRHGwAHrvXWqu8GwhPi/h8adJZI7FfuUHa5KeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7LRzvje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608BFC4CEF8;
	Tue,  2 Sep 2025 08:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756802000;
	bh=uSx8gxP4bhNu5Nz4ZWIuRfI4kUACjD7tGQ0Jp8coKBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q7LRzvjetM6f92/xddbunTpDsoStUcxjc428/OHH+Lt0A93m0hOnGE7EqXJYteCpt
	 rawRyZzWPW/3l8B/u3ra2ixG0Er5YSEKW4j3d0MO1Kg7jGqFN7cMXVjP4ZzV/xQEAM
	 8OHjyr7aQmoUBTx8M78Avxxzf++BWrcyrXoI1FMfZECQ6H48EtnrzzS5XrG6EiWn8I
	 JNiB+BZ6Roj8Wo/Mjk7Nbd3S51dJHS6qTJFWkKi5ZpYQQvdaQ0aKB8kyC4lsQSE41g
	 GkNp72SO/MoOAI6PUpiCn6adTefbq26FKusWIAn8KyIgdMXJ12x/HM45GaGXZZv+/I
	 GMV7XQb0Ytz9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 02 Sep 2025 10:32:32 +0200
Subject: [PATCH 04/29] drm/atomic_helper: Skip over NULL private_obj
 pointers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-drm-state-readout-v1-4-14ad5315da3f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=843; i=mripard@kernel.org;
 h=from:subject:message-id; bh=uSx8gxP4bhNu5Nz4ZWIuRfI4kUACjD7tGQ0Jp8coKBs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnbVm/7HLDqv/qMaqFbwnc+T1g19WQfi3Cz1YWF7au+/
 7t2Zeu1yR1TWRiEORlkxRRZnsiEnV7evrjKwX7lD5g5rEwgQxi4OAVgIl+cGGvFXvBlLVgUPGvB
 51QX0alme27t0ev+vtOF84T05AnfOdenbp8tEnto+sGZ61/dkN//R2IXY8OxqiXrmNK2/1LbxH2
 8t/bzUb7tR/7+2Sdo3J74r/Z37OELdaZhQRJ9V+c9bLVjf7Cw5ygA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index b356d26faad4acaa25c1fe6f9bd5043b6364ce87..9b198610791d19c7fd276ca59264a961d21caf43 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -295,10 +295,13 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
 	}
 
 	for (i = 0; i < state->num_private_objs; i++) {
 		struct drm_private_obj *obj = state->private_objs[i].ptr;
 
+		if (!obj)
+			continue;
+
 		obj->funcs->atomic_destroy_state(obj,
 						 state->private_objs[i].state);
 		state->private_objs[i].ptr = NULL;
 		state->private_objs[i].state = NULL;
 		state->private_objs[i].old_state = NULL;

-- 
2.50.1


