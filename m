Return-Path: <linux-kernel+bounces-754437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B6DB19448
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D267E18952EF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE5E263F5F;
	Sun,  3 Aug 2025 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP86U9vo"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2E8139D0A
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 14:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754232816; cv=none; b=DvcRl0QsRdtg+D6kITzJMeLy+MIQRIGtfNAQ4e8IssHdQswvYAND3w+3e5JiXBs/oLLRKRN9RkijPxfE2gXXFZcdRxmIe7UO+XiLPN2H74XxJazYnamxUyaRp7ia/wUPwuiKQNMPkJUu7iKMYD16IGhd24YaYK+QKf9Z/vDhPHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754232816; c=relaxed/simple;
	bh=8LwxGs95ejTe7aecFJ9nEj38WiF6hQPSPReL5hDVI5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyBUFLQ/Y5WbY/0D/y6B/nSOUTiifO32dMx4u8g730diMtm5eIGFQlXZ59Qtn8kaLqg8e5Ixke21GNT/EyGT5RD8VewSAvyJJ6AjGYz/Sn+I4dF+N0m1+Jo3peeccbK0XaofNt4VHhCiX6+qUhGADir5kZdQWmgYU8k3JgO+Ozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP86U9vo; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3be5c0eb99so2542169a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754232814; x=1754837614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65e6t/SjYYD4CDwos6zfiw9BrumFhwHDyV3mHwUX8zs=;
        b=YP86U9voWxW799g8sjGNf6vNqCstiTNDZbfccO8EZG1VJtcn9SxKTAWItMujRluOaI
         gifsaxdu71dTSqZsyyREfP0vaxArrQQRZL4hw99TeWfltcTvWwFqtYDn6XC2KWx5E32B
         5SWZVgtRWBO8zek1oteMZbNyNxQ3llRfgFT4vhJn/pvOay5lHYNkeMlPmYzQrU4hfQZ4
         wanorQgpD/aMnELqoXyo+1OealbMiNwm7/CXlmP5hvYcp6VhE+SCozvMQ2/owZUqoyfq
         I2tck1Hfzz3xrDWUMvaBGxhBw6usaql1KiBXbjSJGweA7daLQAy70o6hpsB+kKYUwlx0
         9iLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754232814; x=1754837614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65e6t/SjYYD4CDwos6zfiw9BrumFhwHDyV3mHwUX8zs=;
        b=l6ddhvHd4hztNLJMX1xRyEXlcMQ7N++AK/LDTRmX8f4cTUcob0meVCMc8IgcsZbaZS
         QqMXskI/2Vk5B9EentvtOxPwTfxJx8nu6QwbCT1ExcaonTslqUTqlIJNGr2k3bLIg8RZ
         f/BUaIibBo5EbMGSkM0Ga9y/Kc6pxNjki+OTjITC9tRez/6z2L+ZotrL2qVJUDfpdht4
         +YfNllTKkrdqBnS+u6xSVgeoMG3JrVjqbUPWvYren4da+4HOpagGMgXPFEfwfNrno9Mw
         FjZChb8YAinqQjbDnzVkach0hz80SZz9MEeWfBlFP8S3rJLFyvH3W3XJSt3dxAauEFiU
         Ypyg==
X-Gm-Message-State: AOJu0YwAC9wS0Z0qNbdk563fUXkSxsHAf+3muR/+69ZvnBExzHBtVLlK
	o+hgdbZWYOlWQJztjloGVGbTVWVtSqNLGBv7C8tx5QN+ujPHfRlpJ+O5so+wpao=
X-Gm-Gg: ASbGncs28sqmBWsO9kWKxNuEpMKIIy5FZOQv8nlPbmSioxhHObnjbAzF0ulV0svolyg
	v/HMj2wv9rR74Pkq8o9jQRCYB4vI9qUOo8EEd1Bb0rIU9KnGc+j823RGezHDVNSlHssuuD96s1j
	L/5DxfCVvnbj4Nxp0BBmllxHNUcUGLGX/bQRfsPbK28n7Oa/W5Eu/ZClRH6BZx0OVovEoVFVUN6
	OaH++WvIdsMIpAkuvfyX5rssSPtas6GKwSeWJTLH58iZaG3ZEZOYumBQ5l8tpXh23eHl9+eEfny
	TIcLtpsRf+qn132F/5W5SgbYPkDLo0aVh2+C0pkS/9lwuAdC7L4JmNiU2CMqgaayQaUgJSvDXMy
	ogZPfjrta0WqvcJwVF770uIZfQOH+xaLlOxOHWAA=
X-Google-Smtp-Source: AGHT+IFQb9larIFLk6+H90OqacBuWDy0Jctt44C7ca3zqUgTd+KOFZ7uQX9hZmLd2WirXo4NUnVniA==
X-Received: by 2002:a17:903:234c:b0:240:7f7d:2b74 with SMTP id d9443c01a7336-24246fcb700mr80066095ad.30.1754232814139;
        Sun, 03 Aug 2025 07:53:34 -0700 (PDT)
Received: from VSPRIME.. ([106.220.185.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm88475825ad.79.2025.08.03.07.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:53:33 -0700 (PDT)
From: vsshingne <vaibhavshingne66@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: vsshingne <vaibhavshigne66@gmail.com>
Subject: [PATCH 2/2] docs: drm/amd/display: Document 'mcm' and 'rmcm' in mpc_funcs struct
Date: Sun,  3 Aug 2025 20:21:13 +0530
Message-ID: <20250803145113.7149-3-vaibhavshingne66@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803145113.7149-1-vaibhavshingne66@gmail.com>
References: <20250803145113.7149-1-vaibhavshingne66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: vsshingne <vaibhavshigne66@gmail.com>

Fixes kernel-doc warnings by adding descriptions for the 'mcm' and 'rmcm'
members of the 'struct mpc_funcs' in mpc.h. These members were previously
undocumented, leading to Sphinx build warnings.

No functional changes; documentation only.

Signed-off-by: vsshingne <vaibhavshigne66@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 6e303b81bfb0..d941aff89645 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -305,6 +305,8 @@ struct mpcc_state {
 
 /**
  * struct mpc_funcs - funcs
+ * @mcm: Set of function pointers for programming MPC memory color module (3D LUTs, bias, bit depth, etc.)
+ * @rmcm: Extended set of function pointers for redundant MPC memory color module (includes power and fast-load)
  */
 struct mpc_funcs {
 	/**
-- 
2.48.1


