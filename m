Return-Path: <linux-kernel+bounces-842147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B724BBB915B
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 21:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 243324E58A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E414285CAB;
	Sat,  4 Oct 2025 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0NEMVE0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511B946C
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 19:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759606791; cv=none; b=KUDP7FSS+4fSNdk5feyqhdqfSsVJCS9LlvUnv78Xm7CiSlWJ7qKKcU4fJ1uJ3foWTytoBOnjlGm+bzYU67uZcnplMrCRuB+yc8AhgW4JWP59DkLL2/keX+gf12cH2/RprwLIg5p7D38ahZlrXXzqnBVl7C7KlvKq83GuJMTJtac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759606791; c=relaxed/simple;
	bh=dxXN9lbmp6hnz5RwAgvb7gxnLU1TsQHNwx8yCIl2X3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qEKqFL4q+Bkl6jTodgHfX/TNGuVIOR468209r2m7i9pgT0VzP4iJfygAsBb21lclZiG+gUNRZySpU0vs1wiygtd/eDp2LQeA/AbmBpcoad46+sNT6JcFrtV+FXyHGfUADeeLxqwXOMgBZjGljoA3JAD0sV9QtoE4PL83YMFpbWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L0NEMVE0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7841da939deso3264693b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759606789; x=1760211589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EwGSliX1mVD9XKBDtx3vbuVXJahwpcA8bWgLzGN9Qo4=;
        b=L0NEMVE0FguGlOIKSQH2VQt9lwqEgxHEXzbk618LCSZU0YewtlojHRrMp1z2R6UmhS
         /wjg8hsfWftn5PtzJiIgYb7icuWuReI/olBOy0KTYbH2JHm6xXHMmzgWxLNHyqnqZpPr
         AjuYwhrYCgt6DuHisAL05MREE/NN0yobbMeRSU2NEmuWBtG2zaRNmfwMZYepBavh6ThK
         e7GRBSPsjaTDjpiWs/5fh7MlaDHww2E+XeZPzKH1TZhUTcgOJfBSUR+/o1NpcqesTgdC
         z/j44WOp3j/OZydR2Wz9r8+fljutD45KgV6s+5/CHEk19DyCJOL0TU2eq0rEeoyipbAH
         zeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759606789; x=1760211589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwGSliX1mVD9XKBDtx3vbuVXJahwpcA8bWgLzGN9Qo4=;
        b=hTnWE7BD/yo+cQE4BhmHHY1dXMbrLXkEEyGrDd/6dlUPujfvvJFKu1VrHiUL/r/FHi
         vMdu/cD2fDxbP9Laet3hreCNw499UNbt+gYLHJSfQBa/cKMG9j4WLDcrJYsSE7gC9bi5
         3pNwJtcJAmbMSiznW9Hmb+merNqLkWnKHnV9fxg/78zk1Jr6U9Rro6Ozn3ExkPYj8zZg
         CNImVu974q33J6ar9HriXT3aIIJ9sn7SYM0wvnj4wEtC00pXSQkPhp9W1+VpDgSGAuvG
         qTN70ma4oeUCQBc+lDnaSYvY7THAtNF7u/m7JGcE6+8Uv305RhqlQvvUXn9seqd9v8mW
         Ia1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXmEGhuFQKIPfOzaA+hITql8JJdKVyR4OeCZcg5fxFyiBH7csvKORwqNYxqpFIYzB+H4NvYOOQjvT5lUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP7KDPnYMqJi8l+6+FpuMAOF3+b+RziYTnb20DMT01bKr3xaa1
	9Vyi+5w5Wd8TOlKrrsXkQgjl3fp/WZ1bUOqrZuiU4ZuQfLyxINDH29GU
X-Gm-Gg: ASbGncvLHwT38WwZaUvByAxu7zVGCdl0+vQkf5N/cNZyuQw3zIuACJDZfM+3hcjUvJP
	RUDstRfEKrqbW6UN+UVpL9YY3QrVkzHNacEsJjAFekYyykKQNhZpsaOZNXExsrk3YlwVOJt6Dw1
	ah/YZTvoHVBGntAuH296tekI2bai1dnOfF83Owemd0Zwwf1vMGlffTLPS2osYUCjXHPt5lQ7C/B
	Irz3mvBHf4FaKtgb+IT2ifaOwJQ5oQhEEHdOxQn6IuDCrYRO3OcgAN/HdePJSORyB+5GjqFdKfW
	tKKLU2zH/lIQP9kqsA1bjdtQL0E9c5ROwsxhg+qnYFb1DvfUJzzNA9tLOZgmGmrbYamhbgtAs/x
	5UWBoicaTS+ttnrgjxROK9gI0pNWBNk2QkqR2HO1LKVYl/qocImLBA1fge7kET5758j59iRacb9
	ME1DlFxdoW5x3nMJRvPO8EV2kwgblTMQhI4jgb+x8SFAOoL3EqHg==
X-Google-Smtp-Source: AGHT+IEH2gB4/3w8XRUHtUUFFuezhIFiSmbnR5x6+r4LyWsU3mw2nOMIyBl4ufOiSwukwPVKjaMQnA==
X-Received: by 2002:a05:6a00:2d22:b0:781:1660:76c3 with SMTP id d2e1a72fcca58-78c98a4c141mr8622664b3a.6.1759606789550;
        Sat, 04 Oct 2025 12:39:49 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b02053584sm8239177b3a.50.2025.10.04.12.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 12:39:49 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dakr@kernel.org,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] gpuvm: Fix kernel-doc warning for drm_gpuvm_map_req
Date: Sat,  4 Oct 2025 19:38:25 +0000
Message-Id: <20251004193825.1466728-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

WARNING: ./include/drm/drm_gpuvm.h:1083 struct member 'map' not described in 'drm_gpuvm_map_req'

The struct drm_gpuvm_map_req has a member named `map`, but the
kernel-doc comment still refers to it as `@op_map`. This patch
updates the documentation to match the current field name.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 include/drm/drm_gpuvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_gpuvm.h b/include/drm/drm_gpuvm.h
index 8890ded1d907..476990e761f8 100644
--- a/include/drm/drm_gpuvm.h
+++ b/include/drm/drm_gpuvm.h
@@ -1078,7 +1078,7 @@ struct drm_gpuva_ops {
  */
 struct drm_gpuvm_map_req {
 	/**
-	 * @op_map: struct drm_gpuva_op_map
+	 * @map: struct drm_gpuva_op_map
 	 */
 	struct drm_gpuva_op_map map;
 };
-- 
2.34.1


