Return-Path: <linux-kernel+bounces-864780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F904BFB896
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390D9466FFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE2F32861C;
	Wed, 22 Oct 2025 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHDy824P"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C6919D074
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131076; cv=none; b=LC/DP67L0hAFxN2IcThuiESFVB9E9q0kGu3ahi91G2ktqXHEbPEfJ6xf+f65NV31VQhv2qwp+9FDBfoZlIVjLt6m0wk+DldXgQYG6CEDpFkoExL/dlvKwuZ3CwvxRNYkbNzNYLJROzw2w9u368Eg9pUQJRKca6jNQuYeFcKfyHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131076; c=relaxed/simple;
	bh=dPOpm5vBn3gdpvLHuFodqR7mnIn1IG6DinUEZR0SOkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lLNxPy3SJ8M0Lepn3Al56pe5XIJj7v/gpFMd47KDL5egUCjHGoMKMXRITumY6Ckl+YQKCMI9lC32W2NGVRz3qRxyo3j9WCV6xekZhLEGPnC6n23mVsa+QxVPdog1fcbG2hs31wIEmdtOpoOKZfmp6Tx/mneyjLitgnusbGJjxfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHDy824P; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47103b6058fso6138605e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131072; x=1761735872; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEafg9Klu5zOL06Nglfzdv2mgxyWpLG/yLgQwga+NA8=;
        b=oHDy824P/FMBqmFZwktACi54CazSymctzVxokRz1ie82/Y+bssM8MoqKSRrXrHKtcI
         RWr7RiPYP4Xta3uNcoPLzlGqBrrMa1xCDlreHFXOnyd8/CfiHtNme0Z/7sDDmiBlf6Pq
         lODifHQ7QEgxXQuXcZcJqJEGhV5av3Z2T/ozfSNDBWNizr8Tn8J2J5huBZuBYYnpgPkH
         C83G+CMYcw2dRaDBfBNp41GSFe6dO7B5gwEJf0kMIPLaf/WG6vw8GfYqX3MVIctWUs+p
         M/pDZv9/hX/DNh4BYAAPvmeRwxc9UR4MkRudsB3F9f96AzYGyds7HckK0qEaac7GCCxG
         pADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131072; x=1761735872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEafg9Klu5zOL06Nglfzdv2mgxyWpLG/yLgQwga+NA8=;
        b=dcJVllV/1/dVuL7F+shbVz5/4TNkaL7QMkwfA+OoX6o+Igjfbvq8tlow2gQDk0XdcF
         7HWWrbO8s6addtgyy69Pycm6emoij1EOK9tNKufoC4l34TDT0/psbZGiCbDXU8ZHvXM1
         QmK6ox/1y2SF51uAMDMiOI1gCZGW7hUvc4kdw8Q3pGvkdDeJQdRNAIZm6VkiPlFSf+K3
         FT3MR7yfX5LMVaIEQ1j9TLscDq+ibwDp4LCm6t51LbkqvQV/MipaNdq0wXMGSjqOSvxV
         kgHFIPLJlMuZrWjT1NT2neIM5iPlF1vReGLEqW1RGPQy4KSmImdZCI/fKWXuCuH+kwM3
         vmfw==
X-Forwarded-Encrypted: i=1; AJvYcCWcXpgYRFvIKHSLSxxYEOCsu74p/kQrP2z6uGWGeROtxgroFLBBu5vaHXFW8NKiSFHLx85CmU/dBmRTUFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEWimseuguaKpCcK68hcb17rfThlstf/mS6uXLZKSSHCWsbhO
	f/UNWJJUSxcklUaaztQsJtNETVnouxMNbItFgnZvKzL/sO0vqZfW6xysymKdlPkFCug=
X-Gm-Gg: ASbGncsIAlEzWtb6Lk2RF9N6+fYRhSwhsKstXK2+Fuw6bnqQ7txguIkHo/nNb4k2gUr
	/vxq7oVDRy5qs50ZCLCxYVU7qCnbq0o1lZ1YNQymEjd3jErsmt+g3eD1cION10r4dznG/Ofi/Ba
	gerb6mPegoXOZKpztIajNRZ6zvXMugdOqKu9GsVm7eQ57dETeQQEvQCnml5sz0NxjzBCrWpIxah
	ya7otUBEbXMnHxEB4wRxsPTjaC5LOcsJnJT222ohZ1Ppt11qDtfMLf4xbkMORC4nDy4TmVy2zkk
	CaSHLcqx3WvV3S1MuBvX9hyspRaZ4k8+5ZlLEGL0Yx04WOAdSOwGIgxAukXdoIq7ekWeC9GoHox
	kW8N6Y09mQaIg7QfVxSybnV7jm/FJYOFRapTE3Mz3tefOFTQl+BPBI5ybnI+VgaR8KN1qP7DJ/N
	OwKDE+Aw==
X-Google-Smtp-Source: AGHT+IEvzeQmuJZVlQvxOVzt5DBIbtifvWSq41OHqDirBuHQNqktljPPP8+Q3xqBRDvi5bTZGQ8Z5A==
X-Received: by 2002:a05:600d:4265:b0:471:1e:ebe8 with SMTP id 5b1f17b1804b1-475c6f5d0edmr6359645e9.10.1761131072473;
        Wed, 22 Oct 2025 04:04:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-475c428a534sm44924865e9.6.2025.10.22.04.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:04:32 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:04:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/amd/ras: Fix a NULL vs IS_ERR() bug in
 ras_process_init()
Message-ID: <aPi6PTnGfpG02RgK@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The kthread_run() function never returns NULL, it returns error pointers.
Fix the error checking to match.

Fixes: ea61341b9014 ("drm/amd/ras: Add thread to handle ras events")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/ras/rascore/ras_process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_process.c b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
index 02f0657f78a3..1d2f136fbe2b 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_process.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_process.c
@@ -241,9 +241,9 @@ int ras_process_init(struct ras_core_context *ras_core)
 
 	ras_proc->ras_process_thread = kthread_run(ras_process_thread,
 							(void *)ras_core, "ras_process_thread");
-	if (!ras_proc->ras_process_thread) {
+	if (IS_ERR(ras_proc->ras_process_thread)) {
 		RAS_DEV_ERR(ras_core->dev, "Failed to create ras_process_thread.\n");
-		ret =  -ENOMEM;
+		ret = PTR_ERR(ras_proc->ras_process_thread);
 		goto err;
 	}
 
-- 
2.51.0


