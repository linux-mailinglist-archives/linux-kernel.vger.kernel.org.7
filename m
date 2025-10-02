Return-Path: <linux-kernel+bounces-840234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED84BB3E70
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D523AF132
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF69E30DECA;
	Thu,  2 Oct 2025 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTuYne41"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71F9296BC8
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759408509; cv=none; b=SzprnCpxtLAKEM7TnbZv/gtHXAsIc10VUTvHUlNgEqqtqFTngn3s1gV7M2Tb5kREbOPLphxG0JWy6i1ugpZOsgiyz17MlyE4+fqWCQs2qnweVHk3Xg6vwKwif7CBX/PlL6jlldjBstdBmgswn4xFCjVMk7wVdzFMRi2txZApHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759408509; c=relaxed/simple;
	bh=M1O0ZDHQgKrSNajdTRJmNysyvXY+2ntQWhwdWUINF2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HMTVXDHW/CjxLh6tDkArR+LlO+7MT2twLhrVgdOc1t3Y5YI+5rDC6jeKfgLOgQLJBWha4lGe08ssasHsi2ygi7dOb0zMiKByiZmZ+DdoMmYd6rGIAFhZnh3hb2tB5oOm33NHuzpo0/9C5qSsgf9BJpr/u56zS/bkkHXL/Cn6lhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTuYne41; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso724675f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759408506; x=1760013306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wiohunQzlxy1wJLX8ESOSQebIPrb5Yx3wUhdRqNbUmo=;
        b=LTuYne41+H9j6PbS9O7lUpIIJLCifMtcVlkN5LTakMFX+qqyDXr29F5EMsFGnE/cuB
         6UzWx51XdoRfXou23uHGmrq35pmKdISaKTACnIIaLsqLN98Duaqw7dN9x3wotQRFmXo5
         JfBMhryxs9YXYYTVRZdGmfcaywVoH4pW232UcNWJ/2s/7jqrMeNutt5QLQJnBrb4OudA
         zEliuQSnyw+C+vIwjortq9Esw1OJ9SQ4DNzTTbzFFjVMFkxcSgOdQMBt9nw+jaYHlsK5
         bWKxnhcE7ZlmLYnBwe+Au9Em5cf9gs3kCVccQB4+0DmmWnl2HzhrmIK1YS7vW44fuqno
         jbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759408506; x=1760013306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiohunQzlxy1wJLX8ESOSQebIPrb5Yx3wUhdRqNbUmo=;
        b=EdvDgFhlMDFOKMvVT1E2MSwObbZQfs3OC+MDej1jchyBl/8qOdw9G7VnulOVIz6AeQ
         PEaqYNLLVz523imCP/Hwd8orOcNpLNHeKyHSIUPyGoqAhtgpCUBWxiMU6PIMdiMSmJAp
         Z7MpbgSIpftATz1fBVvI2Y6jASaz0d516ZQIZRUcOLNHbvDiWS3EpRlF/nCZGGGuabD3
         oFnR2QPiwMAomBuSln/RLrnPn9FbDS0XyrBDPP5bHCBrVpl8xDdGF2QzHZUxOOVD/EWt
         Ev3dWcUz+vnZSCc+QiWPrgqqaqzQMZvZD9AJK3gmm4Lou+x5Dhwcecl+oPF+exegOqip
         bKgA==
X-Forwarded-Encrypted: i=1; AJvYcCVpVhDKBHTVTMeu7icLV1MnBm6ZsDEmoERhx+ZZLc7Q6Ckuagamv/CTx/5zOM2RjDYRUnQT+r0zlMzEzeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLC8WLy0xINW2j64IvEtDvuodfB50tOoISxhAw6A6KRc0hDFep
	DQ95w2c5zPkfYstBmg6SXKAAW2wJ5T5fJRaQnocI8Da0qdOVx79mv4Co
X-Gm-Gg: ASbGncsVygUJ/b8IEUGLdvnwHZIpbSSUocs/M2it7Wh4NXfp78S7kzJ8ePNTxsssBpr
	l/74dQz+yeOMdHC8liTxYOJN4H4xCi523TstW90E7jyOllOaMZyFJpKGkHJDdaBEu/LDkTZyK/n
	fBK2umn/GlfORFK0cO/pdzH0eUmbWjNTDb0ZZHCi2/0sTe1hjuW7fcnlZSr4FHSNDqRe68AM9Zw
	/M4MAGb7XVxIUHhdCqtlIwxNhwM5mEIu21yiCsOHH8QQspawiLI09b/JFahtJeW+Cq7bNdvvPDM
	Cxqs045URtExISJgHVs2mjNxjAxgr5T0Wmyi4YbeJJPX39h7D4W9/iUTRpaeLubBDPMtvnTRuGQ
	uoJGYJSHZO8KbXYp24sMfKkx7X0ov2mR4p2EaPvZNAd/AVMC32IlZN/DkvqtC2BCWR7pPxFiEWS
	zi5YRB
X-Google-Smtp-Source: AGHT+IFz8zQ0y7qc4oeft0IMTcDcHyKWcXph7kOA6fb9S5FIHDbOTttgY0hxxnzNKQ04CBzWjJsubQ==
X-Received: by 2002:a05:6000:25c4:b0:3e2:c41c:bfe3 with SMTP id ffacd0b85a97d-4255780b8f6mr5803400f8f.38.1759408505571;
        Thu, 02 Oct 2025 05:35:05 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:607d:d8e6:591c:c858])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe9bsm3533304f8f.22.2025.10.02.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:35:05 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] drm: renesas: rz-du: Drop ARCH_RZG2L dependency
Date: Thu,  2 Oct 2025 13:34:52 +0100
Message-ID: <20251002123452.146610-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/G2L DU driver is now also used on other Renesas SoCs such as
RZ/V2H(P) and RZ/V2N. Restricting it to ARCH_RZG2L prevents enabling it
on these newer platforms.

Replace the ARCH_RZG2L dependency with ARCH_RENESAS to allow the driver
to be built on all relevant Renesas SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
index 34d515eb798b..8bbcc66ca3f0 100644
--- a/drivers/gpu/drm/renesas/rz-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config DRM_RZG2L_DU
 	tristate "DRM Support for RZ/G2L Display Unit"
-	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on DRM && OF
 	depends on VIDEO_RENESAS_VSP1
 	select DRM_CLIENT_SELECTION
-- 
2.51.0


