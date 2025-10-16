Return-Path: <linux-kernel+bounces-856743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83235BE4F44
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 19:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66085E3054
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8E32B99C;
	Thu, 16 Oct 2025 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il8D6OHO"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B01329C59
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637420; cv=none; b=QyRATXoi3huYFhV2C1AZt1GYYpn25C4uAFDU7o5etnG7xboVKMIOmTODs1YgPnYc0brnC4BbSHkpAco/vL6IaC5+h5bC8afEXGAFqFH8E4faNJiGuZHES9QwVT0tba9C7HxTFOKOX4PkOvPqXbA+QT27VLpM3cpGKtzHlPOHfD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637420; c=relaxed/simple;
	bh=KGbJjkAhO4ZtbIcLNNS+V46g0SvaYr39Omc5oPOXd1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4VUUYsDS/7iphcXlnEHjTAGE39J4dgBHNUdwNM1Wg5tGT49G0tkj5dg/l8MwRnr0Q84r0RiOLtUo6jZqEL4JFfn7CaesYwV2iR6EtijyGjGXm8aEWAYlPg0RBMmweOQ8AigrMla/Gpag+2x4gtKL0SQuTXV1KF425XfXO+ZQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il8D6OHO; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-426edfffc66so716197f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760637416; x=1761242216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDIBd/5GJWbfmYIhSedRYcdjoF/UyHPs/JoC64uZgbg=;
        b=Il8D6OHOqGnT4tMCoEVJJvS2N96gKu1xoNH3bLqfHVJRipg1FZg2R+v7P7pPFVgm01
         2kpZQCiYtKZtmjO+WlNGtxOaH+iRrSKx+mxRyAtwtsRg23hoznmq6Jpb+26ZXEPSKDbS
         w0qNjPOp9ruvwniwXQe29JBWq+YUCQUkV1MrkdRml4lvgJZJGGaVjExLhuU6ie9VhQBA
         ZpuPRe3wMQVL6aIIbhnRE2f7/G8WJSkGWIEdAIRs9OnuEia2QrtqXPePXC93Q6accxvF
         F334WwujdMdt7O/1NlC8rZazxASaLCOETc0qFIoN7S4Uv0UwQoviu0RucRTHQQEuX4N6
         72iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637416; x=1761242216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDIBd/5GJWbfmYIhSedRYcdjoF/UyHPs/JoC64uZgbg=;
        b=QlAbKpZlha1THl3MfpzIT68o0r14Rz9WX+xEMMUdV5cCTcH/ytSs7qwVw1N/H+7V1k
         m9mF9Z6JtWzpIa0fQKWVJL8Dnkl8hDwlOj2VlhljGO132FdSa3xq23cdZ43KTUsFTzXE
         MTp110DiTgxuWNhOt/re+u/jlgxXWEgwAZ4NPWFJLZDf0gyekVGHEs8QwJCHHpcPWD76
         cBJUBVBYU5eD3K2Igc+g4Q3zHP9P5C5p3F7fDDVhUz2mykx6gQyhQPjx8iACopfkCxi7
         huMMzsRhQISA8E1pHcqrB3Zl5b4/MlfjR2jfuVULaduG4u4/b8koqJln96GNYTCrfZjg
         jk/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHuHo42glitVyTz7ba7MfjgCCr4XLntiyYqazcXDlvRIzLC80G1GSiBg8toj+NTCDtP1QJirUJzV1DnFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFVRalp/r+XlAN3869u7MDd95Av9Ae0ziUA7Jx3C2QF8m78ff
	+9tqn+30rNoFf3/mltJ20y6PtlZ5BNigJ5sX1NbutxCxKHx9e5xZRkZe
X-Gm-Gg: ASbGnctQpWlzBRnO9vE+aGAqFk8Q35iDlx0WRw6ghYV3N4TbzNy+yg9dhZipFpLRO40
	jN/kIJQ1SC6XglKsxm+kT+pkjsbc81dVso51aXY1hD2i0qrh0noxOx1mcKeZR/zjX/ZiKNFENZ4
	A9TSHdc7X6jPHVrsttpR9SZ9uaJdD0OZ4W7bAE5yJ+sjj1fzhPOJ7UgZHjizCC5W4u7gLg9RUZU
	qEgMsbs7hDXHfsFd4/YjBZhKcVlVa+j4UC/cpWcHkJ/6ZvnkU1jU/fqk38Qxw4vKAreL/smcbx8
	sFjuWap+ZTk9G9HWPhy6+7WDwDJB64djetYKwJSfezOq0og9I0qP6cwJY3YMAna81xca7dTQy87
	DAIJj+JysZQhxtOibWpaiT8ue+VKza/jqkLHesvwgcqASTT7vT0rxZlCl3OuqP0J+x8O8iJlRoE
	8=
X-Google-Smtp-Source: AGHT+IGcsJNQXUWM38WX59x6HV9qVAN223pS8C2g1oQg+KVg67lXv4toau5LU5uGbjwtrz4LccKf2w==
X-Received: by 2002:a5d:5f95:0:b0:3f4:5bda:2710 with SMTP id ffacd0b85a97d-426fb6a7461mr3088172f8f.9.1760637416228;
        Thu, 16 Oct 2025 10:56:56 -0700 (PDT)
Received: from fedora ([94.73.33.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe74sm35344023f8f.35.2025.10.16.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 10:56:55 -0700 (PDT)
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
Subject: [PATCH v7 12/16] drm/vkms: Allow to configure the default device creation
Date: Thu, 16 Oct 2025 19:56:14 +0200
Message-ID: <20251016175618.10051-13-jose.exposito89@gmail.com>
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

Add a new module param to allow to create or not the default VKMS
instance. Useful when combined with configfs to avoid having additional
VKMS instances.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index c1f23e6a4b07..6d299903fab2 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -50,6 +50,10 @@ static bool enable_overlay;
 module_param_named(enable_overlay, enable_overlay, bool, 0444);
 MODULE_PARM_DESC(enable_overlay, "Enable/Disable overlay support");
 
+static bool create_default_dev = true;
+module_param_named(create_default_dev, create_default_dev, bool, 0444);
+MODULE_PARM_DESC(create_default_dev, "Create or not the default VKMS device");
+
 DEFINE_DRM_GEM_FOPS(vkms_driver_fops);
 
 static void vkms_atomic_commit_tail(struct drm_atomic_state *old_state)
@@ -219,6 +223,9 @@ static int __init vkms_init(void)
 	if (ret)
 		return ret;
 
+	if (!create_default_dev)
+		return 0;
+
 	config = vkms_config_default_create(enable_cursor, enable_writeback, enable_overlay);
 	if (IS_ERR(config))
 		return PTR_ERR(config);
-- 
2.51.0


