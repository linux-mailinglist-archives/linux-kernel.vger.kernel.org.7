Return-Path: <linux-kernel+bounces-864781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB1EBFB887
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5065A19A5B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A4328625;
	Wed, 22 Oct 2025 11:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJx1bT2T"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A2320A0C
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131090; cv=none; b=tftYTDMr/rPkdjGG7dSbZgKkeW5TURiC7LYuqXUdiQTW4SBgWEkNMVnB1l90A1c3yFm2jc2Eo+Fe0jTfZzdcNDmKaNr9zAazBx/I8km00yrrsgTmFypP1dTKEB1PVUEcoGh4VSd/wYHmRu4gHLdoVEspwx3Ue4o45SMuqg3D+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131090; c=relaxed/simple;
	bh=fbnf82wilN+OInKBeOAmH7SupbMbH8ConaawoIHXamk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N6jo7wUa9RRkqLefqUmqM3BvABf0nd21mU0zP3sTZtAewAZ3/dsWCccDTVoZzCuo4j9OXz/6AfN8GHkPHfgJjdIYGH/PSNpFtqN/XDI6a3P1SzY+FARfquQeTw1oP2hycPYkNXi/g+xP4wDDhKg7iCSYgYXRqBYESpLXoGlsw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZJx1bT2T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4711f156326so52583795e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761131086; x=1761735886; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ec4fethFoS2+SPeTVw+Fwof3KrdKYWIF/kwJYkEKmFY=;
        b=ZJx1bT2Ta+/gas6V6KLQ0yqH2DsgFbKU6MUOk1SLPCzuZYdVw0pPkfvvwhZFWsYiUN
         Tv79scr8JZBRRkKSrRvjoZ1tL3fiCMYWvAEsfPc4/DWy2HvsSVKtt2llfIyUtSfosfp7
         GuGicd6mVL/f7yuBlWVdXPyptpSDn2ZGHT0qh+MCOiO31u5qdm7SiN65HslDeOwgyzcl
         XtmY94gjJVN7fh7mNMWRaa70JXXj9iO3B609h8g4Exs6z6KJxmoTOYrL6+HI06DQ6yLL
         tq227ffNak8KQwyhbp34lxfKqXEGYyhGPHjcWmaEIqbYyLonMFRGnpNS7oSeXHNzd6jP
         Ydew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761131086; x=1761735886;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ec4fethFoS2+SPeTVw+Fwof3KrdKYWIF/kwJYkEKmFY=;
        b=H6Iyou2OBMDIuRKKpejk0Ub6iMbU7+7vbjUtfbw49BE/ufzY7le61JbzyPYw4gdxVx
         Ey7dTzuMvIOZXXvfZOGZ/e95QvsHKBSo60ZGVtl9W2WNMQ4c6G7zpLKPJ7F3yN5Ib0At
         09HwEleaRDwr5kNC6GNZIazM+Jg1E4fwSljapRt72/QfyKolpCRBFX1AtyPwNmyGa9uw
         D3ErOQbidN/uD60VvdE56PuOAIQELXNgzoNDVYbeWQhtJ8i8lPmhtwVgD2iXh3EyBQMe
         q5PHjXxAch6BP55pfKYFylHSf5a7Vgt3OSNtKT5AvMNmOm7kZmIs8vLcOFr8wi9yQNPb
         92fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUASnYtOZwBVzzlOlrFVueMrBZKX1vrGyHt6BPzgEbFW1bkMeQnRTbu33wEQLuuDFsz1wvHUd65joTllwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuI6RjBZYn8uBDCCidlSK7PU5T/6zKX/zwBkUzV1k6ks/glH6r
	7sFHK8wsXGnwvqDrKJYiZyyvn0KNuErmqDCI7fRODsIMhghwFGIbPxhigsK++4aDq+U=
X-Gm-Gg: ASbGncvrx1rtmwjXH8N86UqEnQq4K9hMA8lFnDPeZfDr8ohq7RMrYZLqRlfEqsIm3gM
	a0HGF+UlzZtxHJ6ITfOTjnD04t/vimGNVrcmiN/zMGso7G8Sqp71W/4uX0J9AEX0egeb/YzH0kJ
	GYjJDJJyXaMTp3Xzg/NJNqIUfqiDtwns8oUTD3hWOE9MnW1g9HwoExPkxT/J9hY8vCeQ6WXiiP7
	vdZXi01waUMJ2DbZpMMOdCYNx0Eiix3EvkXovUuM6F0yDunDTnIuqiqvi5b1XYWuiuuWhwgbBuB
	0Mq9pJ+IYs+883ZKkEFX2k187ixaXtQednOFSQUgACYDuvXdQRl/Tqs54OGt+GbuuXaXLg8+QnQ
	qDtU7IosZfqb1J5XDKFejJ2tj9gos4ujnOqZDJBCa9iMsSvcDFw740q/SfphIBWUn9ctOAVtcCx
	KKQGjsT9bLdJh1ZrrC
X-Google-Smtp-Source: AGHT+IGMYkocvaBnPACpDrQqTQlINhZBUKIMjE+J1fPKEeBjdhwvP+lt5c1FWsAPVXg7BnBQuKDcjw==
X-Received: by 2002:a05:600c:621b:b0:46e:48fd:a1a9 with SMTP id 5b1f17b1804b1-4711791fbbbmr156254735e9.33.1761131085678;
        Wed, 22 Oct 2025 04:04:45 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47496d4b923sm33430975e9.14.2025.10.22.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 04:04:45 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:04:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
	YiPeng Chai <YiPeng.Chai@amd.com>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/ras: delete an unnecessary NULL check
Message-ID: <aPi6SqcrGtBvK24S@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The list iterator in a list_for_each_entry() loop can never be NULL.
Delete the unnecessary NULL check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
index 4067359bb299..03c4cddfbfd9 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
+++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
@@ -207,7 +207,7 @@ int ras_umc_log_pending_bad_bank(struct ras_core_context *ras_core)
 	mutex_lock(&ras_umc->pending_ecc_lock);
 	list_for_each_entry_safe(ecc_node,
 		tmp, &ras_umc->pending_ecc_list, node){
-		if (ecc_node && !ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
+		if (!ras_umc_log_bad_bank(ras_core, &ecc_node->ecc)) {
 			list_del(&ecc_node->node);
 			kfree(ecc_node);
 		}
-- 
2.51.0


