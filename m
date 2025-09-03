Return-Path: <linux-kernel+bounces-798032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D792B4189C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 10:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7C86818A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AB22EBB83;
	Wed,  3 Sep 2025 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLXqTsoH"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5A2E1C64;
	Wed,  3 Sep 2025 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888316; cv=none; b=q/VTFsMBFY0dcOdbkLToNjRoSs8V+kBXXbYoQ6iqXKZwXckGNO2JqRyucSvoUK3b8A62bevNm8ijxcdKymK19Exh4hABBcgo00TqCt9vIVxpxxM4gPJBY/1fTStgFZBKexxFxRYKYy1L9nMJtUP5RnHZLtvtEgb0KINqL/vLCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888316; c=relaxed/simple;
	bh=KcHVV4axNshCxvOjQd00KlOruCNlxtn31N+sXiEB6VM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E8IqL2CZFK6Tdk+sY+b3CRMaXUBt50zmFR3ibnKZj9X9eoUWt4i4Wizg7PqkcTht3NJ+Z3nFUc7XXCZKClk/gaApZmv1MGzrkewlX4gkzF5L7Z3Fhec5dzwdLrsoq1kqkx+h9m6nN3w1gLwOZZq7MVKCdCbxZC+8p2Z9OkyXoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLXqTsoH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45cb5e5e71eso2049405e9.2;
        Wed, 03 Sep 2025 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756888313; x=1757493113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzE0Ws9fzpBnIfHQ6kswJP+ItsxGcArI8FqcHSIsRxs=;
        b=YLXqTsoH7nf2UH36aaP0qbhsJ8TqeqN1U3Osw02opnoelXKGHpLBIHfedzJHtbFG1X
         iCURpuf7tHnd+13YGxOlt4kr0MTm+g9daLkHA/Ts6nuO7F1vgAXhunmCg/oJkSmWBBUg
         vNhsZrco6g8BJ4YNFt9nkJ8bo189xjLlLQKvvo/F71doLic8udFiEWr9a2WPbvoh3Z/l
         cg7d3R8cXRfQJiku9J/DV3Tq9NE2kCWSPscbJSt/fCBMWZ2ON0S0fNhMuea9Kg1YdA/d
         Dtb5ZIHXc8JGz8ESnQCFltfINRh3Zv067a4+bOHeSrkNA8PMFo6wFm7frZdWw7nlzJff
         TUtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756888313; x=1757493113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzE0Ws9fzpBnIfHQ6kswJP+ItsxGcArI8FqcHSIsRxs=;
        b=YzxHYMPcQCZO/MRu4lpSncWru6Ngc/sT5HjJdBHDBcV8dNPR1ooAYOtkR4iLDcLCxM
         4F82Upj49i9AUTGEHuaI4Sv4DM1lxVlc1+FXrVw9DYL1FMkQkaf5hwNqgrxjbzekXqom
         UTpI+iuY+f0/LAf8Yl+wMl+PwswerN3jTLrmXCvAk7YSJyug9zQ3Wy17mhirHXwR3y8+
         wRrSOcwIUdDtpDK5Vob4Pxo8GF+WeuF9tHwBFQkScRJoOCS6Z6NYtGLWFO0z/GVAfJ+G
         1Qm+TP7fU7YFcd9z/k/AW+kFjdKiAElL3SQfgnuOO0MX8uWd1h8bmt9di5IkgzqORAiW
         WP9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW4Tpa7GUbRBGDP0OXohQ91BLfH5ZOoDEDhFZGUMyeLL3VTfWQEuxkFoMtXDk44jN2H1nnWUwhfp4Vp96k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZXYgOD2i0nR2rG5m/cQbWucIfrfTxNzSTLqZW2/kAv9JslCm8
	pEWnUkrmBPYTPxLPkfQcUbpaLa++Di3mSU5qwCavYUIKu7Ej8cIfS3Kj
X-Gm-Gg: ASbGnctlVzJCNSywsRRvYOM8jwpz64NraDeysJTPp+Q7j07TZ2GplBhMZhAJzVXuP1E
	ka5kbyvMFaFkD42O+uREyFeXVeMWRVHoQ57ElG0nt88QkCC7/bOkgIJKMnyubrmJh1+dFxuZVA0
	vvC6cdS0trtj68ggnh338AW9uc3zDDVxPr+EbmHeRIfD03Po3ROFZJESavyMbfYXOPBluL6ubhE
	Eyh1x06Li3+bmoSBxvKhxzOl1MnQM1DXCUY0Lf+F3Zb7ecdah0QFn+cj2KoSuI0LI0iBE41Mrju
	RDRZDK5keJWU86EU8LYv8NqpRcdKpCkPg7JCfPlfbXpKbJzUC8MY4ciM08buGTZGTduMalX7EMZ
	vxeZtVZBQl5k8nx+2ARkS
X-Google-Smtp-Source: AGHT+IGrZQIc2jiaG8pdcXw+gYZl+BbgX2ehStHEyKgFTJ1z7nC82zfpt9nkS8Xtp2AjuW9GcqmnZA==
X-Received: by 2002:a05:600c:3143:b0:456:1c4a:82b2 with SMTP id 5b1f17b1804b1-45b8555d6fbmr129315705e9.10.1756888312950;
        Wed, 03 Sep 2025 01:31:52 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b940bbc0dsm74727175e9.2.2025.09.03.01.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 01:31:52 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/sysfb: Remove double assignment to pointer crtc_state
Date: Wed,  3 Sep 2025 09:31:06 +0100
Message-ID: <20250903083106.2703580-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The declaration of pointer crtc_state includes an assignment to
crtc_state. The double assignment of crtc_state is redundant and
can be removed.

Fixes: 061963cd9e5b ("drm/sysfb: Blit to CRTC destination format")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/sysfb/drm_sysfb_modeset.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
index 963c380fea64..ddb4a7523ee6 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_modeset.c
@@ -238,8 +238,7 @@ void drm_sysfb_plane_helper_atomic_update(struct drm_plane *plane, struct drm_at
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
 	unsigned int dst_pitch = sysfb->fb_pitch;
-	struct drm_crtc_state *crtc_state = crtc_state =
-		drm_atomic_get_new_crtc_state(state, plane_state->crtc);
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, plane_state->crtc);
 	struct drm_sysfb_crtc_state *sysfb_crtc_state = to_drm_sysfb_crtc_state(crtc_state);
 	const struct drm_format_info *dst_format = sysfb_crtc_state->format;
 	struct drm_atomic_helper_damage_iter iter;
-- 
2.51.0


