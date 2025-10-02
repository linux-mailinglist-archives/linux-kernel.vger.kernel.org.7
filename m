Return-Path: <linux-kernel+bounces-840001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22D6BB345B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2483219E2A3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCDA313539;
	Thu,  2 Oct 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eg3qDZfA"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC642F361F
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759394021; cv=none; b=g8V3FZEmnajVRpbCl1cUYSJeUfIeUhQRRGnusAGOaIztQYTGMM8sSBVCJo5qtVfnni1NRJ2WwRZ0PhTF1et/+YoULIaQ4dpYl2XvW28zcSG5VCmyIc5ltxF7ub74Zra1cESqrrTfrO6/9uu/MhPO3GMe+WhjbpqKqlLXw25ejPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759394021; c=relaxed/simple;
	bh=VUn0hFGRPODeVa/MzbiuBzzDqAKnT3J0AdauWCw0CO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuchWhokr3e1dm7lSnC4/FKkIhVsJ8nR3Uo37XMa0YQjI0hr3cNhAnGziIycRPNQrfxosElN1xjqlvv6zccUvZ5hsIowSflmFIdyvv6v6d2GlTc6C85BhelFQSKtHxR1hlRTvJbtayIlJXXm9I2MsUOK4HSV659hO0vPi9LJHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eg3qDZfA; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso2624550e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759394016; x=1759998816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCnWTNE47EKUFdNbhO9xh7Mmv5d7MGU177iaBEqF0KQ=;
        b=eg3qDZfAnyNP/5dG9RiUbkT9joDN8dswm3lHEidhkw0bfqa93CsLQQHZk57Xk4mmZ+
         v+u5HLpQI2DduDv/lVSE1NIOPJHGXf/XXTbFbLX5qSfmE6Fwg+WTDX4Hi/GS4NExRTIW
         89vKLWdNBEkthBbwDGARCjsfYqThOtyUjQdUQvp+Nu2/erPYF50Gz8cve9vAUPPbveTg
         rwjrUUUMJ8y3g8kaCUOZ0l1sYjpxxBLZNYUGLpg1mltE9rFyXgWkwoY0gWkSr04iRdTf
         EO4dDym7FYWsXZSymNT9ZUjWSs6kQJvaPewmSmuSOJKPsT0+wuuJ4e0I7cl0iBmmlnuo
         cyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759394016; x=1759998816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCnWTNE47EKUFdNbhO9xh7Mmv5d7MGU177iaBEqF0KQ=;
        b=EOCV7XN45ZvWK4AaknS8GXUZ/Ny8rBgNYYM1LG4pKfC44k00zir9khM8vB0FyKxM3H
         rH4dd0OumzHzFt5Qhgm7ynnXIlcVqftKki/71AVQTVA/SSM2HSEQfnilsRLtAoMaWAeH
         0KNQ9yUcA0gSij6SyN3blwfN+yidPGfLODHXxuF8NilGyix+xdCxY4BXWdxs2gAUKMW3
         lPZCYV1A69uuk39TOGWEVzNaKw2OgCx/W4bpQ9ifKZd8grviHxdr2eWajW7t8zlyVGpG
         snnMfQAbOUAU6ekQEIiBpgKqmgU0Yd4hpvO5CcnqCgr+A1RBWIcXfaxznF8KTZ/jb0xE
         BhMw==
X-Forwarded-Encrypted: i=1; AJvYcCWJVkt8Fh9KrEdpjn75QJcoOXnCnzvBDofJfQiN1lauYkYV9Pl9vpS1yCCyTo+Z/+aEaiz55Z3Cppq0dBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcyLNrTp0jYrPCehj/qG7O2AxnrsmqMzXm4Sv5AhnAq53VYNy+
	gEYTx7zLy6L8ON/4R+061sEfqv4LAtb9kgHXISmiD6rbTYZIRbbOcI9Y
X-Gm-Gg: ASbGnctWI3negblHaIK00T4QhJUcjCEVWdlt6UgY8vG/APnXZ5WHoTJrqsY1pgw/3CD
	YapFMzwQ6oHvwzgUWzcVhASRqdQAhIRu8DkQHmirEYVNsOVdOJao32BqsIGr68HOplio4wRIEFO
	WeVvJflM/p8KChuSWBQKqPj9h/tZrrrqgolAU5Y431gBsQhGHeRi7E2bzBB1f8NRn38l7xDnPWk
	Z6qtsYYpUSZl3YnQUShClcsozk8/1qayHK9e4raCKibropgLB6KxvwEqEXga82gS5tcS42Kc8B6
	EKnhQCjMSwwp3EbRNBCRmHOjpQEhojDRbvTaeM/eAoBBDswlmczc68MgVN8HsQvbfKPRcbJZJew
	45m0q+fk2mv9oQef2k5O7RCpSK7G/oL+gxWx+/MczhW4ZtZIjY4ccg5mHLyILUtgRmXxHawz1UK
	x2Ux0MBtDT3iNMokmpUDHY0xmNhVZ7AtgZtvqPKnlv
X-Google-Smtp-Source: AGHT+IHjcjwtFqspT76BDrqWmxGqO8qvZJDfBRE/OUo2b+yHt06K2O/V4pEtvb4W9p4Ul/oCXQ8WRg==
X-Received: by 2002:a05:6512:401a:b0:58a:ff9b:2234 with SMTP id 2adb3069b0e04-58b00b3d66amr894765e87.2.1759394016142;
        Thu, 02 Oct 2025 01:33:36 -0700 (PDT)
Received: from localhost.localdomain (broadband-109-173-93-221.ip.moscow.rt.ru. [109.173.93.221])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0114033dsm632852e87.53.2025.10.02.01.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:33:35 -0700 (PDT)
From: Alexandr Sapozhnkiov <alsp705@gmail.com>
To: Karol Herbst <kherbst@redhat.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Alexandr Sapozhnikov <alsp705@gmail.com>,
	lvc-project@linuxtesting.org
Subject: [PATCH] gpu/drm/nouveau/nvif: fix a null dereference in nvif_client_ctor()
Date: Thu,  2 Oct 2025 11:33:30 +0300
Message-ID: <20251002083332.11-1-alsp705@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexandr Sapozhnikov <alsp705@gmail.com>

If the name parameter can be NULL, then you should not do 
strncpy before checking name for NULL.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
---
 drivers/gpu/drm/nouveau/nvif/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvif/client.c b/drivers/gpu/drm/nouveau/nvif/client.c
index 3a27245f467f..3cfe420b5156 100644
--- a/drivers/gpu/drm/nouveau/nvif/client.c
+++ b/drivers/gpu/drm/nouveau/nvif/client.c
@@ -69,7 +69,7 @@ nvif_client_ctor(struct nvif_client *parent, const char *name, u64 device,
 	} nop = {};
 	int ret;
 
-	strscpy_pad(args.name, name, sizeof(args.name));
+	strscpy_pad(args.name, name ? name : "nvifClient", sizeof(args.name));
 	ret = nvif_object_ctor(parent != client ? &parent->object : NULL,
 			       name ? name : "nvifClient", 0,
 			       NVIF_CLASS_CLIENT, &args, sizeof(args),
-- 
2.43.0


