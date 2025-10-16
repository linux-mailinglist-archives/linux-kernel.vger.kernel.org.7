Return-Path: <linux-kernel+bounces-856744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33878BE4F47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 075A24FF5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2AD224AF7;
	Thu, 16 Oct 2025 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfUVWd2i"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1232AADA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637421; cv=none; b=qfIV9G/lj5G+YLOmHic9J0z7Z78WeGvCXkcaTk3sOdDAjBfqyQ4irf2gzY0eIDGZ2EZcbctbPKyCcHCmR8qJY75iLva1/zT0ZOfwD+8kTUGfdoB4R/SvZxdy3hpLbRjBUuCmNOQajv+9APeKTJO8wKdepoIPAhwLX84DQTNA40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637421; c=relaxed/simple;
	bh=DucwR7lmblXtGrecWIP/cobvknXDh7rKPktRZoHlgCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRKIh4Yx1Cd5yNagQWxcpbPwOxOWtUdyM3xCu2uC1fxMS4sINHb+TAQ5w7Z5eoVIEMO0H/n0YUDXZyjw/NQ/z5q+mMzE3X9zOz5MDfyMEWhYHBqEepF1aWakU+KBfcv4Npe1N/gYdn7p84yd2AmFxpCBNRT5Q1d7e35JRgRPmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfUVWd2i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47117e75258so1321195e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637417; x=1761242217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1SpBeUqpFn3lQrpk1/03vxKE+csOcXH6zxgB4nY+oo=;
        b=mfUVWd2iNjJQ0uxwwwoLrW0XxPOVmS/ZykD4+MKD47cdA8vquzfjW+pvJGZcyGa4R4
         s8vrY005NwnjP6EztSnN32V32/Ol59Jy5LOUFlABQwHnBiyoh50Cs9RKBCcvg+nofMqx
         mEWyKOaWYf8S/b3uzP6h0WIe7CYFnJQvwpYSA4k1IuS2COhZEITqFFAjAIXYMX0F0+Ss
         kOjuaF2NvZxQ4POz4Cd8/XIOwEs1nJY/ROwobX84I4mEccNJhb2ITAmWS11D6h5B5UO/
         pe4TujaF3o+fHENWvR8DHJd6Aos41cEk3NIvWxXQnFakO3Dpb7jK7eus5agthyQlk/AW
         x0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637417; x=1761242217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1SpBeUqpFn3lQrpk1/03vxKE+csOcXH6zxgB4nY+oo=;
        b=LT+vjnlmNQJUcr5DVNjKHV4JJ84yuJZbwbZtRpxCGqyBRXExqLDUB+wuaAc3nYBxMi
         /I6+Wg/uUOgAafcXBQC7koUy6cWsz+fzPbc78B5RhABd1VxWf2aQNcdEdZY0NMqw8F4b
         kZUMdkq+JbadEEhphzhrTrhCsnCGh+gP3jFr9idhcLVvwURly1ltF8rM6CT+eWFSvvMZ
         GtAMIjbGa8zxbX3ZzPimWCml3k/zzC1NMq9nqxdUayCnOy6lVWsEry53CVMhWsGOFYBJ
         AWPhEhJAA5VdIT/e2rr9JcgzoTNV1Mimvsqaw8QtoAMY3RvdyDN5hwmfA8csr1bJxtcd
         5QRw==
X-Forwarded-Encrypted: i=1; AJvYcCWdXY6lh2C27VBgkDba8injieI1QhOrcJYm+eKKENto0LQXI/CqXMC/TO+ans1oCAShuq2l79D2bqbKcS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/77L/u8jnHbulvpwHo0fYHTeBxAIlT0uMq3WOClrBzAUwAkMX
	eLIvf7VzoTtJTm02skzdlXm6X2KCPRNGPM/wcqS/waj6FPiurnPIawu3
X-Gm-Gg: ASbGnctZuztJkl78i1n9jtapYB1wPk+asLy++As2Oe2nrTPZ38vr8cB1v932W2v5TCd
	VsO8EdZ38Gv39vT/3W928i/4ZP8xi/zEeQuc+Vvd0TAEz6kf7HaNcKwJtXb+JDDGvDh2EB6qVYD
	A5cYcED5C60pOyOQdd9J0dk+Bbn/6RgNXFW64Y55dWVOt7VJdv7iUp2qR1KzpAOP9Jr2fR1rGQe
	wbVBzTnvz5wk7WAp4GG9XCQS4syWeb0X2EDzZT+fSQOCpKrRNN2k2U59y4J8ZyFyfArlwCYs2t0
	LCnlTyJ7/z+vO6QYCiNpzUga6I3D+VA22XkYfeFY1KPLbAgsSdr24EMoesy81/PvmvN2lacDEDN
	aEg7X69KEwDrr8iTnQa7PVxGtAWk2qXW+hMiAvZdCtyG6gexLSB1QnlaGcZREvuyjl1/Ur+qkMP
	A=
X-Google-Smtp-Source: AGHT+IH8NCXDHXN/QY9FgnYZ+eb63qPdeppxf26DoLioBmlgRGZ+ohwvaUIyXkL2ywEOCG9q5RVZcg==
X-Received: by 2002:a05:600c:4e8e:b0:471:a98:99a6 with SMTP id 5b1f17b1804b1-4711789b11emr6597505e9.11.1760637417449;
        Thu, 16 Oct 2025 10:56:57 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:57 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	sebastian.wick@redhat.com,
	xaver.hugl@kde.org,
	victoria@system76.com,
	a.hindborg@kernel.org,
	leitao@debian.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Mark Yacoub <markyacoub@google.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v7 13/16] drm/vkms: Remove completed task from the TODO list
Date: Thu, 16 Oct 2025 19:56:15 +0200
Message-ID: <20251016175618.10051-14-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016175618.10051-1-jose.exposito89@gmail.com>
References: <20251016175618.10051-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the configfs related TODO items from the "Runtime Configuration"
section.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 31a3880ad83c..364b574a8cae 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -233,21 +233,14 @@ Runtime Configuration
 ---------------------
 
 We want to be able to reconfigure vkms instance without having to reload the
-module. Use/Test-cases:
+module through configfs. Use/Test-cases:
 
 - Hotplug/hotremove connectors on the fly (to be able to test DP MST handling
   of compositors).
 
-- Configure planes/crtcs/connectors (we'd need some code to have more than 1 of
-  them first).
-
 - Change output configuration: Plug/unplug screens, change EDID, allow changing
   the refresh rate.
 
-The currently proposed solution is to expose vkms configuration through
-configfs. All existing module options should be supported through configfs
-too.
-
 Writeback support
 -----------------
 
-- 
2.51.0


