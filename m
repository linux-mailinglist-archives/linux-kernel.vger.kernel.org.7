Return-Path: <linux-kernel+bounces-788530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15942B385EC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5703654BA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EB92773E3;
	Wed, 27 Aug 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PZSgVF+U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878B227702E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307572; cv=none; b=ai9ISkWwTskaYh3qCv4VbS4oLuq6MIiEe7w83uOEweLRlLtl6xuLAvedCi/3KvfGKy3mNu/giMwnLaTXF9jwxqJPOUhzV3aXMPD1pc3nafxTWEwnWE6riESiGOL30uC7VNBFAE9mTvQuhsTnW8M9oN03gfTgZCxzuI03q/HSEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307572; c=relaxed/simple;
	bh=EBPSGENkTcwztznrwhtBrxgFnzCYLtSKl6BkLZjU1c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1YvSbPGNvP+K1QMhWCiwC5NNBAmsoJ5aZ7HyhPMFamDdNNZSep3+ROAWozIPR47pkQW6zvh5iNnp+ilhuyU0vh6m7AQPFUyFIFg/TcHGIXZhvK8vH+ALf0aydPgV+ptuc4ZgUEWEkwDF527oC9BMCW80PoHDAJQfMdfFiS05lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PZSgVF+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF079C4CEF5;
	Wed, 27 Aug 2025 15:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756307572;
	bh=EBPSGENkTcwztznrwhtBrxgFnzCYLtSKl6BkLZjU1c8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PZSgVF+UQTzFbvQD+OJCASw7ojVoJ//PgyIDpDpBxZ/qvsNZBXl+ZcfWLI9gPQorp
	 QSoOP4VblCzR23UaNal0kPKVVTQozfHUNU+6ZqtX8XI9fTicZYzmbCFoQOWxVY/nRo
	 1ydumtnahPsSW+AZmvRh573YT65Qr1T3qxlxZcWV85ISUbstG3asgNRBXOTBso77x3
	 fNnNlNmuq+f70TEBMqbPgz+cCP9fCM4L2n9n4SjaYuiWsCereKyizbkkOZVmo5D2RE
	 uDmeywUBe4UqUaNgdq1B37Y3M//o94eJ92y+H4ne14tBhiO6AkasX0js7NslT7t7FL
	 XWIB87Js5sUDw==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 27 Aug 2025 17:12:34 +0200
Subject: [PATCH v3 03/14] drm/tidss: dispc: Switch to GENMASK instead of
 FLD_MASK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-drm-tidss-field-api-v3-3-7689b664cc63@kernel.org>
References: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
In-Reply-To: <20250827-drm-tidss-field-api-v3-0-7689b664cc63@kernel.org>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1844; i=mripard@kernel.org;
 h=from:subject:message-id; bh=EBPSGENkTcwztznrwhtBrxgFnzCYLtSKl6BkLZjU1c8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDBnrFVK2nZJXucLJzBdZ+crutUyV9bZtiY7FTrx+JRMEr
 G+9Sd7ZMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACYSl8lYn2uSO2Xm19+b7ZeH
 b8h/veFaE6PrY5Uo9rsTbL4/38jJVVHPf6w5enrKoed2VTPut3YkMNZpV8WV18Y7m3YXMwi/f31
 vidnx3vbZjcxsUkeb+qLU86VEpwQXT7+nm+ldOfv0sglhRQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The dispc FLD_MASK function is an exact equivalent of the GENMASK macro.
Let's convert the dispc driver to the latter.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index 6231e1aa07fdfa4ea1265b8239e561972dbba8f3..b5f09ed2f3700068bc39bef3630a86a33c16fabb 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -592,35 +592,28 @@ void tidss_disable_oldi(struct tidss_device *tidss, u32 hw_videoport)
 /*
  * TRM gives bitfields as start:end, where start is the higher bit
  * number. For example 7:0
  */
 
-#define FLD_MASK(start, end)						\
-	({								\
-		int _end_inner = (end);					\
-		u32 _mask = ((1 << ((start) - _end_inner + 1)) - 1) << _end_inner; \
-		_mask;							\
-	})
-
 #define FLD_VAL(val, start, end)					\
 	({								\
 		int _end_inner = (end);					\
-		u32 _new_val = ((val) << _end_inner) & FLD_MASK((start), _end_inner); \
+		u32 _new_val = ((val) << _end_inner) & GENMASK((start), _end_inner); \
 		_new_val;						\
 	})
 
 #define FLD_GET(val, start, end)					\
 	({								\
 		int _end = (end);					\
-		u32 _ret_val = ((val) & FLD_MASK((start), _end)) >> _end; \
+		u32 _ret_val = ((val) & GENMASK((start), _end)) >> _end; \
 		_ret_val;						\
 	})
 
 #define FLD_MOD(orig, val, start, end)					\
 	({								\
 		int _start = (start), _end = (end);			\
-		u32 _masked_val = (orig) & ~FLD_MASK(_start, _end);	\
+		u32 _masked_val = (orig) & ~GENMASK(_start, _end);	\
 		u32 _new_val = _masked_val | FLD_VAL((val), _start, _end); \
 		_new_val;						\
 	})
 
 #define REG_GET(dispc, idx, start, end)					\

-- 
2.50.1


