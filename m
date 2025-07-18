Return-Path: <linux-kernel+bounces-736325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D695B09B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C0E1C43B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 06:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919220D51C;
	Fri, 18 Jul 2025 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpOHdG/j"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403991FC0F3
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752820708; cv=none; b=WjUXh8F9a/Af6iLUuihgIiqlxTndsrSQYGIydUgJo847gbvpVFxvIwRbKNZ1P189csFZWJEpiyDF8fLIBAkJfnyUzIOTO/83dbF/2mlY9KMXroY9DiI1McbHeZph21uCK+4rwJiFLVd9MFxCPZF3pzMfTn6Fw+tNCOO38/GrfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752820708; c=relaxed/simple;
	bh=la+UV63XqcBZfya3E0cPUwJvVyjE7bMAlX4v5xaf9n8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kaR4pbyqCy1HNbix1UKZIrp2/mRDgoD/ujM8YgJ3Ayp50lmbXqxtUqzFm6qRwq5FlTSam8BxiVnG/RCY5FtpZ+3FILDWFIGHZ+bjlk/Ry18w3puV0bU/5xqSiiWgNkuNf5mjfMmac1vyWphFecBj1bEUzpbPWCKU4fDKgt4CFP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpOHdG/j; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23694cec0feso17250665ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752820706; x=1753425506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HoPAphUAO2EbnrVJOWchFSmkzTMAMEzinf+ttewuTA=;
        b=jpOHdG/jVLALgF7Ig1I/T3PMygxLb/ZZGdj2hlFiX2jw8AzEv5f/hVvL6sgcdQclWL
         Rmc6ZhZuh883yRaDlzy5KpJfaA2Pe1EoltuqFES87LasJVaNMgLN4ET3rxfqpLO/a4ME
         qivuA0c17VYFsFeDSm4nwusOSAnfzwin2KXUMLseYB0esY1uX8U3tCgBk3IqvPcplx+/
         WeSMmUQzIv/la46FXgcK4ixZCRtVXcfN3V1QaJyikOdcujuXOVAo4FZ5TGMobaAaB1lF
         Oib4kLubZ8BRsf1QQOLdvr9StUz0mjk2jPKfJkXwOjgbB9kpSvreCENZhtf+GocFt5nq
         huUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752820706; x=1753425506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HoPAphUAO2EbnrVJOWchFSmkzTMAMEzinf+ttewuTA=;
        b=vTJiT5Kuh4T2Jluie4K3usjeCpwyj7SkYddWyZKkKLcXGBfkYC0CzveMjsJANdlvlT
         M+wcc8sXUcwZ1K9YO5TiWc7nXqJbewd0XLVOPJwjSfjsn+8lhLClyN1LrfYVmLcb4jKU
         uBpKUk0llNGTF/w6qUkOBv+UmS0S2ZwYZ7X9O41Aa9n9oY0mZBWPhV9Uss/CjJFS3MxD
         HWqNFKGHT/9G70XCVXuVyrMsH6iCpGH+A7D8F+Wl5SyP6Ft1dGnZrzZ4eJOX7n1b/ozZ
         5O36UoIFMkBg3koMJSMXYV1pHe1keNuq0PQZZonnn0Dp/7Y7mfbZJ2CW/VqVaDpT5Ktf
         mktg==
X-Forwarded-Encrypted: i=1; AJvYcCXUpyZS9ViUqzX1BQQZeJlZg5LiwhhUfRl+hUdDh8d5C57d82mDesN4FxnZcm2DSiGGFyd+rlabNl3K7gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrZI20aP2bTqHLqLdugHYLl7S3okA07rc51LPU6Ys9ad3+tdBc
	v0W2XE+njJJ4op7B/OCkfWE5GqMQWQTteq7R9ZmEblgpIftubEiscwzJ
X-Gm-Gg: ASbGncvvXroZvGbb+h3xcxGm6SG/HtqE1PIXHiv+/LvBW2V2iABlgGJS+yl8IDeIjI0
	PKbI9uKuitiaFV/TfAiFJfmrgt7YtNFugZyhlyjM7l+HD9xWzsLcTnOpnyh2khKT+0p7eq7bLXR
	Ujq+iYsaLHkd4cq4XKfSGo4kD2yAAJrdMEfrQOivsEyldLWKC/Po9/HsYLRrrZNcME4FXYCZdMM
	sJ7nlPJY1xAgFlCHooHqALNIJrlmcvadkw0TmDcSQDQwdZoFA8qJoglBsi37Lz/YNjUY8w7Ts9X
	tHqtSXuSHG4iXvSRt5RwGhipmTpvWSzxV+e0JhN3z2ts2NS0asZjmF1/lETtYE+b9MV1kmQF4R4
	YFLKqCCUSsW7WqKXZAaq94+vye3XHKfaROucr7+xwprq7pTVu/bzVKmMjLByigED+7lI=
X-Google-Smtp-Source: AGHT+IFp8AtRv5Y7qXdM+APL+mOXgsmxrfKFtB3gAqBR/xbtDUOhFIRPdWEM7pbZErustHR8TXsb5w==
X-Received: by 2002:a17:902:cccc:b0:232:1daf:6f06 with SMTP id d9443c01a7336-23e24f94735mr120545195ad.47.1752820706354;
        Thu, 17 Jul 2025 23:38:26 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23e3b6ef68dsm6638495ad.205.2025.07.17.23.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 23:38:25 -0700 (PDT)
From: Chia-I Wu <olvaffe@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] panthor: save task pid and comm in panthor_group
Date: Thu, 17 Jul 2025 23:38:15 -0700
Message-ID: <20250718063816.1452123-3-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250718063816.1452123-1-olvaffe@gmail.com>
References: <20250718063816.1452123-1-olvaffe@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We would like to report them on gpu errors.

We choose to save the info on panthor_group_create rather than on
panthor_open because, when the two differ, we are more interested in the
task that created the group.

Signed-off-by: Chia-I Wu <olvaffe@gmail.com>
Reviewed-by: Steven Price <steven.price@arm.com>

---
v3: fix new kerneldoc warnings
v2: save to panthor_group on panthor_group_create rather than to
    panthor_file on panthor_open
---
 drivers/gpu/drm/panthor/panthor_sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a2248f692a030..9987aeb4608bc 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -641,6 +641,15 @@ struct panthor_group {
 		size_t kbo_sizes;
 	} fdinfo;
 
+	/** @task_info: Info of current->group_leader that created the group. */
+	struct {
+		/** @task_info.pid: pid of current->group_leader */
+		pid_t pid;
+
+		/** @task_info.comm: comm of current->group_leader */
+		char comm[TASK_COMM_LEN];
+	} task_info;
+
 	/** @state: Group state. */
 	enum panthor_group_state state;
 
@@ -3389,6 +3398,14 @@ group_create_queue(struct panthor_group *group,
 	return ERR_PTR(ret);
 }
 
+static void group_init_task_info(struct panthor_group *group)
+{
+	struct task_struct *task = current->group_leader;
+
+	group->task_info.pid = task->pid;
+	get_task_comm(group->task_info.comm, task);
+}
+
 static void add_group_kbo_sizes(struct panthor_device *ptdev,
 				struct panthor_group *group)
 {
@@ -3540,6 +3557,8 @@ int panthor_group_create(struct panthor_file *pfile,
 	add_group_kbo_sizes(group->ptdev, group);
 	spin_lock_init(&group->fdinfo.lock);
 
+	group_init_task_info(group);
+
 	return gid;
 
 err_put_group:
-- 
2.50.0.727.gbf7dc18ff4-goog


