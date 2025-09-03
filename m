Return-Path: <linux-kernel+bounces-799300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A6DB429C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED6E1BC5D62
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565D368092;
	Wed,  3 Sep 2025 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ktdeg0io"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C303362093
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927302; cv=none; b=W6NnGInhosb0EspndUe+JPmuwRnxzgBuIidxrV8M4y2C803057BmuQhnl3OYepCMR4FxDdWQmuttqw449399VJRWrVwWNuq6/UYGnPiXpB+yPoMa2vU6xYRzSNDUgWXRXsJncioRMXg5wHXSSt8U981L0t2w1u5afBo6hY1mh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927302; c=relaxed/simple;
	bh=FD8F5bgARtC6YI1MwhdaCFAJugS/OZVdoGBcoorXEJw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mg7EkRxqm6eM6ISAYrjHbrypG13dNLnhUVBlgORbs48GfunA51Ah1hRVkcdN518KXbX1N+GAaDs4f4iMHBw6D2QSC2fhncPh1Jz/I16Uy/iNxkXpWnxLLi2oPBxyBwgASjoUiFs0X7iS1b15CKrTo4gDSRzaHeGo2xZYeNDWGWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ktdeg0io; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77251d7cca6so245033b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756927300; x=1757532100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBIcDNX+xCHFfbh4zBaxGqDtwHNN/sHrxYwH+z/LwHU=;
        b=Ktdeg0ioXtX5dx7KgQpW7iRmfdHKjocB2YAvg665xeNjDpmmjDA1pPHI/63P+j5YNe
         jH9qosTvDp++v1pXOM+3ytpLCNOAaaoVoSDcfPRzuilQJVMIGhrTStjTFRn7ICe3/kQL
         SIS15G6/e71hEko0wMIOKuWG9sfz5LnAWSOB5vU35GzAV20MDjq9UhdDRRs9AwNm//yx
         ItiPKeWiZk1SphD9Lq6QeaaptAV9v43zZAZjzBw4N5Pc+cUv4wZT+tqA8znu/gv4qWka
         CatGbG1bSALoBn0uX57IFMbcxdFqHii7mq0ok5yQZdKLnOElRcAP380gnQs9Y8Rq+qmb
         71gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756927300; x=1757532100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DBIcDNX+xCHFfbh4zBaxGqDtwHNN/sHrxYwH+z/LwHU=;
        b=r3OloAwH7hBeXPTJ5LSWcC1lKo/Uf2Nqv306nU1ijvuqrHjrNmsTsu347HphKWgAEs
         TsSPUgpCQHnsBLSNkYNTZKiUb2S3pmycDGOIc18dcRYMozTPmBJzQVe6WHsu9RRPxWcn
         7N3TpbqHWStlzjHtEzdl+ghBbVQFNg/+JFcneuom120ncPXy911Zhz0XorTDPfwo+b2o
         dTY9ZeTO6B2TIdHvtoAi9A/SRfmj0he3hqJ+y+svpZseS14nIxlOs1gzTtct7HAG7sIu
         C6AUz6Req4YoobqTQ05FQgqJ5OiiR9BwboOcaTo2c34quNNbstNLQi0vNbM1kOhYqkmg
         kYTA==
X-Forwarded-Encrypted: i=1; AJvYcCVNl1400mLOOE+IvDizA8ptifiEdJg+YQn6HpurCRCptsFKgajuqXeaiv+pr6yS83WiewZUNmvGMc8BabA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGGleUQnz91Nr4Ql+gjQ/jGMQnmLPHCF5ACjFlsOXWRYAr2n+2
	LvgzouaRW/2yo5E8decDzNz90jcolNW8hzZrfwFDRUYWSyVHmAiC7Xjn
X-Gm-Gg: ASbGncvdNXSCf50G1KfulujX7FR3qR7seaf28AjMEOZAYV+qXXJWl0XjZFnk/dBEBrw
	NuPWrd4gmGHmKVtFLdSspwa6trR9WtlXzAlLRzxaDoNVwRSCy+1roa5x1GVrxRjVBfwJcJz/MYQ
	gIsJ01L/5wq+hNiGot/25ilw7ZR6EyFodFS0B0wRky0zA4W5kuV3khRnxCS0+7x3aU5feqSupMZ
	m4s2L4GL8bapvkWc5+4ACAkfyqA+ZVvszQWLpFZLt1RJAi4O4hZYGQRzch0XX/LCAk8F38ZpcEq
	s3OrFvSUN7tr4NsXFBu2VMvhu06Zy2TqR63ab4XQtIHSwCjFLL+OaG6YPdKCmD6qhNx17oZBK/A
	S+jM5l9uDPmos/WHvrYZWrErs6rP4ZO/v2CrBiwj56jiNnAQ14gTO7Mw/rDN1QSo8KMnCsIUuWn
	BfE/zdeOOebO68RJ9q0+mq
X-Google-Smtp-Source: AGHT+IHkUA0mvnPsSgAVcR0DWhFOtjq0L19JNHkwKaF4QEsd4iWX2t/nKLi2cu2yEzfKlnG22mmhUw==
X-Received: by 2002:a05:6a20:3ca3:b0:243:d1bd:fbca with SMTP id adf61e73a8af0-243d6dd4e0bmr22695905637.2.1756927299624;
        Wed, 03 Sep 2025 12:21:39 -0700 (PDT)
Received: from localhost (185.3.125.34.bc.googleusercontent.com. [34.125.3.185])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7723f4858e6sm13840352b3a.4.2025.09.03.12.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:21:39 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Grant Likely <grant.likely@linaro.org>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/panthor: validate group queue count
Date: Wed,  3 Sep 2025 12:21:33 -0700
Message-ID: <20250903192133.288477-1-olvaffe@gmail.com>
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A panthor group can have at most MAX_CS_PER_CSG panthor queues.

Fixes: 4bdca11507928 ("drm/panthor: Add the driver frontend block")
Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com> # v1
Reviewed-by: Steven Price <steven.price@arm.com>

---
v2:
 - move validation up to panthor_ioctl_group_create
 - add Fixes tag
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 9256806eb6623..4c202fc5ce050 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1094,7 +1094,7 @@ static int panthor_ioctl_group_create(struct drm_device *ddev, void *data,
 	struct drm_panthor_queue_create *queue_args;
 	int ret;
 
-	if (!args->queues.count)
+	if (!args->queues.count || args->queues.count > MAX_CS_PER_CSG)
 		return -EINVAL;
 
 	ret = PANTHOR_UOBJ_GET_ARRAY(queue_args, &args->queues);
-- 
2.51.0.338.gd7d06c2dae-goog


