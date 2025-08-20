Return-Path: <linux-kernel+bounces-776828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4535BB2D1E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B191891C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 02:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FCB1F416B;
	Wed, 20 Aug 2025 02:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC5TYdIx"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86EB52E403
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755657039; cv=none; b=ove9xR55UHIlufJ0PfvX0zFjtBryK1eJ3iDtTwchk2kEcPX/jeSs4jsJs1rPM6kdD82KKlE6Ij2k0Xz0CtiDzOi23eHjIWQ+DERr5GiHIRxZ4LauFbGyJVgsJkNK5FKLyiKcTkFRP7Hcbo/9Psu87F2yLYVus/DEOcTky+0TkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755657039; c=relaxed/simple;
	bh=dnPR+j+/0vH+fSk8M+SdilglPAKMc5DUN83yjz++SlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cK4/RUu1TVUT4N6bBwJL4AbQqwvxx+vg+LMIbCVYK202I/PxjwaivRDXRB5QQLaYJhXZq/N5uEN9UGm0H5Fz95ktwlOWJ6+fNv6fdUpcCffvlkS84HSLmwFi2juOzaveWC2Xfg+waBcMZyr8KJ9L2AXeltXjq+IZmopmjAvI6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RC5TYdIx; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f3edd4so43665415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 19:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755657037; x=1756261837; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBLspprFztDG6+Qc7Fdl3/57LW5xmP9NJiJ32and0f0=;
        b=RC5TYdIxKA5aKUJ4RfyTeG7cGuZzEAyqH9alRBl1ztS6FLRzXUPrkMv3mAn+polz12
         3faoBkCeA20G02WV2Gk4Ao/rPYXQyuia4NooZuTWq438cXrMlbGU8n4KPzqBsCB3tCDa
         aqWoXL7+VU2ePjjpzaSq4ssG4b4VSGcCNiss7eUe/3INfN6XPUncRh7qEYsgH3thlxzi
         Mf0pYWv5XeL/u/tL63pvbFoKk+PZ8VDl/hTkdB6Li3vklqlb55Bg+xzPEkD9cyfT5G77
         3jWrlzgLwiZz5HYwprL/ckpUa/hexCdAPN/pjxkXqho9nY2fGxBjNFyZdfh92aoNd+zH
         QYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755657037; x=1756261837;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WBLspprFztDG6+Qc7Fdl3/57LW5xmP9NJiJ32and0f0=;
        b=oXYCORe0AhD13E/bnTgHmP3U0tuRHQ+sMV1n/acsgpAeK3k8X0Pno/HuzY8XRwS0Sk
         uG3sX1aURLQ1FfA0n6lf1BhJVb5VsB1lTNDTL71NOJLMrsvocH/V+lFtridITkb1XLyb
         SqE7WIJUjgeQNQrErUaCCUQuZ3aVApd5eoobhsqRC0S6XHWRbitLzKBySnv4MXfueWuK
         1MKEHS8CUBJ45mO2ylJIoROtkusFdzqV6D16MQTj8B38+Tm+zL5GHQLCd8UFfqYKzTBc
         SH9yAb9b7KAMPtepb4Lr/J2JsK8YBpXOvuUcZ7ee2OrlT80veUUMosPVssBqrSbklyH4
         04Fw==
X-Forwarded-Encrypted: i=1; AJvYcCU3qiT501lmrsgxcboF2PvvQZsn1ZpBVLFx4RaMj3+MqiHF6NPEQhdPgsCissJrI2BrmQysg5acnqefOrw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIm+ij2TSwr+gr7gpylWRfGYa6xb8xtRoeOZPgkUMGrFV5jPt6
	12CQ3QE/e4pXtoYa56p/YbDaP2whCJBMOLkeFSzkacSCoCBRTy7aRJmp
X-Gm-Gg: ASbGncvxlJEk6XIhugWYBY3SvcubkQczUp1w+oFD/d/7Z6iiE1HCQhb4cu6WNc8Ok8u
	7dDSJ35yD8JKS3AI46ZaWXnGdaPiop3PMDtsmFXCGOt30fuYbg4WiLD/eeDC3GHNA4dHC4ytJGc
	xK8FecTSEk5gp7hPcaFYFcwVzRJpTiLkuKlEqE2bXgUJcc0gFFpOrJXpNasTLtt4jCdZQq5Jk/r
	Ams92DRDIqaRLjsCSw/t3smu6ZYju/i3uptjIRqKzA/1lLOi5UTJ7A2f+uuduJzvMjcKzFzaNhz
	WruiwSj4yQg84QmRUBMl3yPPqSvXFQSnQQ9lUI1I4zn8xLgVO1y4dI02x/nopb7E+2iKeGmBw5T
	ImSA03r/EvXNVGfqHn1Kr
X-Google-Smtp-Source: AGHT+IGLN6/IE/ONxayhxMru/n5hlswUbEMiZ+nUf3HnpdaEUno4s7c46v0prUlmyY7rIbErGmDIYQ==
X-Received: by 2002:a17:902:e74a:b0:240:96a:b812 with SMTP id d9443c01a7336-245ef1728ddmr16515215ad.24.1755657036687;
        Tue, 19 Aug 2025 19:30:36 -0700 (PDT)
Received: from localhost ([159.117.70.219])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-245ed514ec6sm10616305ad.136.2025.08.19.19.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 19:30:36 -0700 (PDT)
From: Nai-Chen Cheng <bleach1827@gmail.com>
Date: Wed, 20 Aug 2025 10:30:31 +0800
Subject: [PATCH] drm/display: remove dead code in
 drm_edp_backlight_probe_state
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-drm-dp-helper-logically-dead-code-2-v1-1-34421f4a7442@gmail.com>
X-B4-Tracking: v=1; b=H4sIAEYzpWgC/x3NQQrCMBBG4auUWTsQo4HoVcRFzPy2A7EJExCl9
 O4Gl9/mvY06TNHpOm1keGvXug4cDxPlJa0zWGWYvPPBRe9Y7MXSeEFpMC511pxK+bIgCecqYM9
 nH3MMJ8HjEmiUmuGpn//ldt/3H6bCSpR1AAAA
X-Change-ID: 20250820-drm-dp-helper-logically-dead-code-2-428c853deb95
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev, Nai-Chen Cheng <bleach1827@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755657032; l=1205;
 i=bleach1827@gmail.com; s=20250730; h=from:subject:message-id;
 bh=dnPR+j+/0vH+fSk8M+SdilglPAKMc5DUN83yjz++SlY=;
 b=sSnGAQmYvuBlMPlBySv7ODjuBt6ADkJzz4dI6N5kWwoGXBf2MRiq6DHDh8HSSqloPQoJsporV
 KXBaR0fekm1BPmnuY9u9HoZE25em87dxI1rfV2XgoiXI65mtKmJhra/
X-Developer-Key: i=bleach1827@gmail.com; a=ed25519;
 pk=jahFPRplw20Aaim8fIt8SxlFMqkHbJ+s8zYBGbtHH5g=

In the error path where ret < 0, the ternary operator "ret < 0 ? ret :
-EIO" will always evaluate to ret since ret is guaranteed to be
negative. Simplify by directly returning ret.

Found by Coverity(CID 1649044).

Signed-off-by: Nai-Chen Cheng <bleach1827@gmail.com>
---
 drivers/gpu/drm/display/drm_dp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
index 1ecc3df7e3167d13636e194c4aab44ee8979aa11..654d466183d5ccdefcb4029dc4efc199f3b7b6ff 100644
--- a/drivers/gpu/drm/display/drm_dp_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_helper.c
@@ -4227,7 +4227,7 @@ drm_edp_backlight_probe_state(struct drm_dp_aux *aux, struct drm_edp_backlight_i
 	if (ret < 0) {
 		drm_dbg_kms(aux->drm_dev, "%s: Failed to read backlight mode: %d\n",
 			    aux->name, ret);
-		return ret < 0 ? ret : -EIO;
+		return ret;
 	}
 
 	*current_mode = (mode_reg & DP_EDP_BACKLIGHT_CONTROL_MODE_MASK);

---
base-commit: b19a97d57c15643494ac8bfaaa35e3ee472d41da
change-id: 20250820-drm-dp-helper-logically-dead-code-2-428c853deb95

Best regards,
-- 
Nai-Chen Cheng <bleach1827@gmail.com>


