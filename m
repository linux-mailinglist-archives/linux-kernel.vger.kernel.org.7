Return-Path: <linux-kernel+bounces-842169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFA3BB9220
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 23:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 570A0189A987
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C66A201004;
	Sat,  4 Oct 2025 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6whSd9z"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EED9478
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759614454; cv=none; b=Pr3sUMLtnfwKoDV+tLgKz6K6z4Kc0Y84idyUV5/+cGsJzM3VHBClht6zD4V+AhTjD5m0OTbjBga6oxTc8cY4EwOfeZMq4D2LEUrHzE8ReBnx2hQtJyvek5qZT4fRJKjKhPqPjtaIQzK4Oe+U6XzbH8Znx1jbSd6/DqFKiKmfPPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759614454; c=relaxed/simple;
	bh=135EOhoKTKFqwmoxLeVvMWCOwk5PnK2lNA1ueQEBRko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBi6whkg+1HzOnkgczfVJOv2TskX3mHD6PIR2VOCiQnCwInaeUedJ6XeWAUCc0E1+GnKTpWeOpWCdisO7nCl+z0opT6fsbXt37Ono5Q1xehskaOjrHJdgQEXeQNq9w/bqtht6M1KFjDIGPxge5xWz6gThxg1Lz+S6J/1iO0LVJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6whSd9z; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f343231fcso2232604b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 14:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759614453; x=1760219253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=K6whSd9zTxskxIP1/HWMWN5BjsEVeeYfDVDSzjhzsns4SeCEK6bSEAG6Ts/sYcrcmy
         QouEK5nTRmvKPDxcBrXR8YBPZ2Spa500Xf392uUpl+/efexvHu0m/uiy3vOie2IO8SKD
         opwdQFVopdaMBen7Ysm7MdNkDWdAFSLElbCi+pAjeq4XQlBp4t7xv6wupI2OS6xxx5fE
         tfFCD/GYjzNLqaMbXW1JZ9kxTa3RIaRLczOPEwmcgRd491esenwvB66yqopTig8fNQse
         ltOqY/e8BMixdo0Mv3jZ6PItMmyDNsnDVWNEg8Kf55r0oOS9ilM26hsqKMzqYSgfzhby
         w2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759614453; x=1760219253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=JVtF5KrX1sgdCfQjo2upaLe1gzkJPCH3llmp4DNcQUYtLo0+tHTIOm+lZAnkZOx6YM
         EatnzYXoIkPCO7fuJ89VCzCrKNgcV6U7ZMAvjhAyb6bWK964YCWk3GsU4mPnwEfW1n6J
         0v61brGVV5al9YLPX+0Lvndf+pxRxk2Mn336JUcLJ2lPgTrXd9ArNc8Bza+Ottgicysj
         FgRjco1rZN+P4nJS4ARWKTbaKauZRwFap6zn3YGuzeqCeaygX2b7GOMe/6o7nQ6Srgrv
         foH4K/ZBuUr6cGcjxBaJ3AF88fZTL9o7LNu9taZTMYWwJfs+G2Npa1pEhf8jxvio4TAZ
         jwXg==
X-Forwarded-Encrypted: i=1; AJvYcCUbp4f+NNeQRrzNnD8ijvmrp+OkGRT9lmdxMsWfqhIbyHvzg5JRbmhhRllO5mXBxVhbWX5bKQL6qsi8pU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy12IsASUlJGJYc1CE1c1joj1+ptUpBK8yMvBa/5R6WCXKFbVU0
	o/t09qc1beRBvTx5Z4UxA7ZCFLT7t5HfP3QZrenoYoyA9CTf+L68h5JD
X-Gm-Gg: ASbGncvFWzSrs2NTsKQd3/TGBMYEmc1IvQL97S9cPlVZpcwOvvrj6pxMsTqpDBBP12j
	6sth5Bs10xhM5+VEgKYwS+00xYKK/wrATT6dYHQN10qTLUsXhnyqBf1A3Ac4VoL2DbVhtwBZH6W
	/htcVr4VWuQBv9Mc49L0jSwidNLcLlTmcPehnrSL5Jo2+IiYb3/fuifqCrINIhPeWsZZU38Zpcn
	o1l2YYVoTk9f7CiwnWuWcI08rZg2RM05j66ujBFo0bLrmRnrM7PykspNczQA8NGwhbLjtGEpnpD
	t6sx+k94Q4IUdSRm44UsNCFyCIapReaXJtBe5pcXfTyxvM+QBK84lqL6PVz/tpJy+cR2sR84V+B
	QEVW5cb29wwEN75KHCzcsqL6qsM8elz2oDRgJHzSh9xvf8BqVYKaGt8trHco=
X-Google-Smtp-Source: AGHT+IGz6mhFK6fAuTtELr1lJpt66OJ1dv0uue/uWlvY8bvgOy1dnpl3I6auqwtpvKyYMtmKCTi39A==
X-Received: by 2002:a05:6300:210d:b0:2b6:3182:be1e with SMTP id adf61e73a8af0-32b61dfbde9mr9335033637.12.1759614452275;
        Sat, 04 Oct 2025 14:47:32 -0700 (PDT)
Received: from archlinux ([36.255.84.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0209005asm8614408b3a.81.2025.10.04.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 14:47:31 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH RESEND] selftests/cachestat: add tmpshmcstat file to .gitignore
Date: Sun,  5 Oct 2025 03:17:23 +0530
Message-ID: <20251004214723.1827194-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tmpshmcstat file to .gitignore to avoid
accidentally staging the build artifact

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/cachestat/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
index d6c30b43a4bb..abbb13b6e96b 100644
--- a/tools/testing/selftests/cachestat/.gitignore
+++ b/tools/testing/selftests/cachestat/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_cachestat
+tmpshmcstat
-- 
2.51.0


