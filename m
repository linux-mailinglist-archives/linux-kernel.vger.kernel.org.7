Return-Path: <linux-kernel+bounces-815742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01178B56AA8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 18:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 528241899546
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B005E2DC35B;
	Sun, 14 Sep 2025 16:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="H02C+NjK"
Received: from sonic306-47.consmr.mail.gq1.yahoo.com (sonic306-47.consmr.mail.gq1.yahoo.com [98.137.68.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3947F1E493C
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.68.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757867752; cv=none; b=W1saw4zd+nyB1O3IryqfCief46sPetK5G+ozZKm+l9iOimfxY3gd05oVU2TC4ilSorhpRW5ArKKUwBcovJulE4bVbL8ZUjy+N/uUlza54ql3/TxP/k+UgBIQPrbEmiJFuEobZ1ZEg7Hdv1C3cdqERzss2N2J2DX41oG8HSP9vN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757867752; c=relaxed/simple;
	bh=Jxx6k3erMJMJSRJBQyWk9D5CDUoFkqEuhIP53vaHNxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=YXzZSFKMnEi5xSji9YFYN/QEBB84mzcSbmKzKnoW7IMIRQQ/24ekrNFwxMI5aoWiCVimRyFi5MxqrTUso8tvElVPfekRlferJOgwmIBsHRhzr4rYrGr5RBhfZ0NnT+1m3cebKywMSSl6qra9QJp9WOqzFIUwGCnu4Cyih9O3Nwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=H02C+NjK; arc=none smtp.client-ip=98.137.68.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1757867750; bh=vM/gtEmAJoSfkWAjMw92+Y58qfB3JrZ/VALMKex+F7o=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=H02C+NjKMZs6Z0GkWQHIHSPkbh7dHJzcD1VpI4F4jQVZdy+F9Wi0uw1FMYgBj7PV/O7JIGNdXBaABwN24YcINqyp9fRuJbHQ3sHmlXrzkJ/j6S7mfTgdaftP6UgPSz9WRlnTycW4hG/oVyMjF3Eb8aRLd+F1snhaCLcddN1OinDBCxII/ZnWgjs2epxk6RDw1oHRQkt9Xq/H1jkF8k1cxlXz87B+j4wjUV8bltCkmrDsnHyvWZvqpWP59vbtoiWbSsEWWYJVt8k104HrY9dRiGdWFBMx1ukmriSyiESuIt3IbS4VK078G8pVCr0Fpru/F+bWGAXof4JZR8i72aEC0w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757867750; bh=ZvdI3crEeb9nWOsb0klEPNs8+3pzz2eqN60DGZDCbS3=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=exZKWqI3iwAHQyB2svoQKK/wI3VTithdZPJsAqKZRsQepH5uxXIStIt7VHcMEQcqtRrcXroSm2Ba+d3Zi4ztp1Zn/z8cd09wZEgOH5QRsgmyemcXyGIb/MUnXZ6Qq0wlmY9n/nnyJ4hgmFXLlWYF/TiM91KmiJmyq/Q7zu4VThjPT/S+xypKRMWdI2mrpKo7zo5SNlpctv9ALqe6Pl2FC6O6kjc8HqRR+Vn1cNh/a8SBFoGQeApCv6f7nvTok85cO+Ut+RMS3mXdHWHqxRMj+cJ7QCNgSdqgG1HyHlyoNriW4h60onDOB35Su9l08yexjSVChpBsxe4gcUoN4dBg5g==
X-YMail-OSG: DuGrgwsVM1maqw9S6GHksCwUZ1KyeF.CnCbA2PIrzUxOZToCOnkno3GPqJK3cC7
 JdhjxchcAm9yO0FxF3mWYwxRf9ULjdA6v9MDCFwz5TQXU8QGxy3AI1OIpP9iouq5GV.RWL9lxg8v
 bOoqF0B0DtH8AjU1k.KFNPDVMaOKzG_wlVlI3MIWRmkCktqskcAhH5afE5efWvHw5NIoSxap.guN
 yMZjx5KedZfWO6j8BqW3KZyJgkod9NKg7UR4r9aJbPkBpKunRMRSp9QOstczdUCLWuUTJd._xWi1
 nLWHZhQHMbXKPfiCmU2X3zWZq8n5xAu4fNZpVwA8JZggKKpmXxirBb4iK4BLmLkulMFb9hwiJPh.
 bIJm1Eh4iLlN5wKv9YBv_HwWOifTAavdQbq.uKTXoApK1fdQzu8yPoojOLzyFIXg6z1Zw0srdMTA
 Gg4Ud9SxNSDNngTpDGnaFast0qiSc92c6.BXs7AybD_D9pLpS_7fsP54DAfW0twnUY8qBTP.1Z1t
 5DjxY1vz4azQuMjzan5XKUpGlyC7Kyueu45xXeTAy8gLCvn2B9tp26Zxy6NfyZaGXKKQDE5a9oe9
 o5hHM3l9edTIB73pCPvePTsWUaPFwV1Cm2ZFFCR4j4obyMrQiwE4pj3Rkhg9HUl8bXDU_aWjeEbS
 hUEJ8scEZ8mFpzfYiK3AhH8PzMbsTFJ9wQBVrlZRwvBuFYrl4j1FZeYiIntTy4mYMnrPBZs7mBPv
 Z9Gp1xEx8.elfGlcVsV6RU5Al_JNe8G8V2CeVdue7kd2Du.xI.pZc1Y.QZsGJjsHGY8vZIER7d5w
 FtJdEy6HFnEYuOA12L.pjAQ7voCMzbP9iUixoIGbhT5Ez9qeatDVCU8m4w4z0fdCxntuW_SprXLe
 Py7CcVGkYnMW746snblgtoGJMtd4S6W7oKxgf6_GP2GWpWgZK7Gen_0Kb4g5zQZpKolQc0anTWZu
 GdZZ.4Ptp_QXkOZxnLFWo59zuphi6QpIr7OUA2Z1OnVANV28ULci.jqwmuLCjpe9Ved6FhA_DidK
 xgr.Be4cnCbNTsRUOMvKcdsW2CZ_dgML.QxDJ3v0iIFrKZUZd_x86nTGa1HsBALP_.cUCoNepmOF
 V6m2Ao827W0xASbwjBnyKgVx9dE_EPLM41hyOE7fHrfZxyzArXHEAISz6fvjV8vpExS9iYCWvKU8
 1HlA0cyKJu2PdOY1O7qwdZk0BzqWofw23kwyRyFIu_IBjeJBeaOXwyRDMktkDSTwz4kPOKuX_dZO
 CwpcFQwRrscC.s5qCuGNrZjqe50mtMp6J3EGlTMRh3KqptVd1BJ.QMnENNh5chnDFyFdjBaY0OAk
 RE1uQdnVrhgEK5VdMBjqYkO4tVt7ZnMtwT8CAhnT7RpChub07J3aCWBXfEIKW4oZU1fPTKtcdqMy
 KjLIkj9FOGjmWjEopntGGXN4anTImJbsDluXXOfzosPf9FAOJY0myn1lZkBo3TZuryNXIK87AXf9
 AkI0RBNxbJxstJd5XysaybnqI4m4Je3q85kfXxKEcH64ZHTFdxHSXm4jMm5_yMNhUhGTml5W4Wmp
 UftynWVnXQZ7J7.lUj5SYTtZHrTWV4OE5LS8JpCGgIJiXl0x8NFb3RwhhuU6gJGUPG3pJDHe4u3X
 yjfFu0rYDbUPgvct0lfoLPnBYt8haR6__c4AjGfGEBfLR66HtsZUtE96rPDlAyEIdeX_MGkluhuv
 TXHdYAiqsSDe5xh5eUlYRArfpcPUoxJ_nEKtjqXjKoTB3VK5TM.71CBftznkjqDB9QJzMrfqyBcR
 4elVgOPpSoiAyCEABB9d3AJr5QCFvadmrh6NqNNHYX18UzQcbA0Nca90DYaXwNyMYbGY7yaQhAab
 whYM5vG0jIvPI9G2S2gWbQKpEfFknLzzMpwxgHZgtEHgzQpziDRf4KpYQr5.MdOTYaXNvAKacGtd
 BGNZbLEi8QusGqn1H9ql4jcEaqr.T0u8jOGeaHchC4lFqZYrD1xHJByznqgG_yHE_34zNk_HfRF0
 3JV7rw8zy3E7q43M7z2084aC3wVPazXNxnn.6CJdtKcUdtDbupQahvll1TbsBAu46Uf3t_Vwk_y3
 4ad8IqsLWhXKRSZKHDRpdSJaz9ebxQSiweXxzGe5KEktNDpaZY84DyVla75.FF_dAIBqDy4Cg.9R
 _.R1eJ1rguRLbQHUn1e0bSwPim3W7sPcr0E8QtduvbAv9CFO8LY0Mdjd9yKzD2fRx3VUSF.zgPhn
 0WD4R.Lv1p1dzGDUK6qzsITAIv7Qhu2cHn0uqIePeOrzteXBDFhtNSf.g0aZdopMeD0dfvRC.NUk
 P7GuRiW8sSk6xD.d_RrUMb0CDxE7zLA00UAjx9S2ALIeUSdtcSA--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: 4a193f5c-7fd1-46f4-bcf0-ac13f7988e18
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Sep 2025 16:35:50 +0000
Received: by hermes--production-ir2-7d8c9489f-8h97t (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 663aa411e1d97799b38b5afe608e5826;
          Sun, 14 Sep 2025 15:53:20 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Ruben Wauters <rubenru09@aol.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: gud: replace WARN_ON/WARN_ON_ONCE with drm versions
Date: Sun, 14 Sep 2025 16:50:52 +0100
Message-ID: <20250914155308.2144-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250914155308.2144-1-rubenru09.ref@aol.com>

GUD is a drm driver, and therefore should use the drm versions of
WARN_ON and WARN_ON_ONCE. This patch replaces all instances of WARN_ON
and WARN_ON_ONCE with drm_WARN_ON and drm_WARN_ON_ONCE.

Signed-off-by: Ruben Wauters <rubenru09@aol.com>
---
 drivers/gpu/drm/gud/gud_connector.c |  8 ++++----
 drivers/gpu/drm/gud/gud_pipe.c      | 10 +++++-----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index 4a15695fa933..62e349b06dbe 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -561,11 +561,11 @@ static int gud_connector_add_properties(struct gud_device *gdrm, struct gud_conn
 			continue; /* not a DRM property */
 
 		property = gud_connector_property_lookup(connector, prop);
-		if (WARN_ON(IS_ERR(property)))
+		if (drm_WARN_ON(drm, IS_ERR(property)))
 			continue;
 
 		state_val = gud_connector_tv_state_val(prop, &gconn->initial_tv_state);
-		if (WARN_ON(IS_ERR(state_val)))
+		if (drm_WARN_ON(drm, IS_ERR(state_val)))
 			continue;
 
 		*state_val = val;
@@ -593,7 +593,7 @@ int gud_connector_fill_properties(struct drm_connector_state *connector_state,
 			unsigned int *state_val;
 
 			state_val = gud_connector_tv_state_val(prop, &connector_state->tv);
-			if (WARN_ON_ONCE(IS_ERR(state_val)))
+			if (drm_WARN_ON_ONCE(connector_state->connector->dev, state_val))
 				return PTR_ERR(state_val);
 
 			val = *state_val;
@@ -667,7 +667,7 @@ static int gud_connector_create(struct gud_device *gdrm, unsigned int index,
 		return ret;
 	}
 
-	if (WARN_ON(connector->index != index))
+	if (drm_WARN_ON(drm, connector->index != index))
 		return -EINVAL;
 
 	if (flags & GUD_CONNECTOR_FLAGS_POLL_STATUS)
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 54d9aa9998e5..3a208e956dff 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -61,7 +61,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
 	size_t len;
 	void *buf;
 
-	WARN_ON_ONCE(format->char_per_block[0] != 1);
+	drm_WARN_ON_ONCE(fb->dev, format->char_per_block[0] != 1);
 
 	/* Start on a byte boundary */
 	rect->x1 = ALIGN_DOWN(rect->x1, block_width);
@@ -138,7 +138,7 @@ static size_t gud_xrgb8888_to_color(u8 *dst, const struct drm_format_info *forma
 				pix = ((r >> 7) << 2) | ((g >> 7) << 1) | (b >> 7);
 				break;
 			default:
-				WARN_ON_ONCE(1);
+				drm_WARN_ON_ONCE(fb->dev, 1);
 				return len;
 			}
 
@@ -527,7 +527,7 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 		drm_connector_list_iter_end(&conn_iter);
 	}
 
-	if (WARN_ON_ONCE(!connector_state))
+	if (drm_WARN_ON_ONCE(plane->dev, !connector_state))
 		return -ENOENT;
 
 	len = struct_size(req, properties,
@@ -539,7 +539,7 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	gud_from_display_mode(&req->mode, mode);
 
 	req->format = gud_from_fourcc(format->format);
-	if (WARN_ON_ONCE(!req->format)) {
+	if (drm_WARN_ON_ONCE(plane->dev, !req->format)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -561,7 +561,7 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 			val = new_plane_state->rotation;
 			break;
 		default:
-			WARN_ON_ONCE(1);
+			drm_WARN_ON_ONCE(plane->dev, 1);
 			ret = -EINVAL;
 			goto out;
 		}
-- 
2.49.1


