Return-Path: <linux-kernel+bounces-728893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C30B02E8D
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 05:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140037A1532
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 03:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B51197A6C;
	Sun, 13 Jul 2025 03:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/59x5Bt"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDB17A2EC
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 03:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752376129; cv=none; b=ZfBFF8F9gJFrfmItcoiWEEXXLmKHFKBHxCwxy6JzZSZnddWlHnIznrfAWHq/xF31o/hQpceot2kFcJ0dfIgYKWhVYfGCHU/Y6h5XLAdGRghm0mgPELqzUIekq3faA0wQWCEABTg/lkUNQgugs/p0ZGEQBvVp3rzWsuBbeLwvAo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752376129; c=relaxed/simple;
	bh=bKUld+c9HOC3spoF7vkYWWhSmbQ15iaU7hKlYlFxYp4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRluyCBv36gRZoRNV1r/emIG8eNrJseWxfuzx9atu6QnZ+Yucax8MCu8491p+Sx1bi/DXN7QwBfnoYeYizI2mm36/k46qr6zw5f0mtEe3aCKk+wNhNGaM/3xOvA4FhdhO4iMgA/S38B9jRIAQ300kA2nt7H0YO9gQSQ4aXICRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/59x5Bt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-23636167afeso28932445ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 20:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752376127; x=1752980927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jbn60TvpqcjemJ/r4zyupMTU5+LuSYLNJ8MkoKMnnh8=;
        b=j/59x5BtBUquuYBtXPFN/uovqb2pc7iOcROxx+WTwlQbTR0ifot2FH/7rCvUwZOMcf
         pePl6fqEFnyn5vEXC/OdcaFl1fFGse6nHviowJe8C3wdyriIv7qiFi6olgaQp/S1nrUR
         g4QT4bNqfPglU5D9D4OwSypawWk4Qy5ppPu7GXqinadhZPTtmxDqbHTq/OXBFmWU2/Ok
         JajKXt2kTEPlUswsW9+oAwkUgK+PpQD2hxn9RZ1w8OeZ8ko4bYlMTt0DcvmPOusDiW8I
         PvXEh/7Su/99zAdoTEd3nlakYbu5+sceKLzPxgCdAgCv4mD/hZohPwB0yLcYYq2ps0Xg
         /e+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752376127; x=1752980927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jbn60TvpqcjemJ/r4zyupMTU5+LuSYLNJ8MkoKMnnh8=;
        b=EdpQPxExHXuoYz0a3/qczwY/zDU2EmtXGQAd+KINp99QPOF1oHbL15DpksMb4hIrgb
         xRngyZNrg+ehoqO64zWVWk3ler6HsDcHPHSwVzcdKq5TjVw6xPKWzVOOwob9JR1fMOuO
         o2QolJ8i0BONxDdzCyi4H38R2Ubw/aDbXNOhxyxYM0cgSOEMygxJDecci8AcGygoG6rj
         gDGkocR+QG40idw30X0aJciOK0dP2QpR4cYgYFMxkgqnsT7ULtzn2xw0UKIfEpCRzLT2
         x85JNH+/qvGXBcVUBKeNyUVEoph/e3SOK7U7+AQVvO9VHzyVZzjKu0s+Tae76bYKqdXO
         6N9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjBVGibLEwHPH0Vt7WC68Z6wFZCfWqqbetA5zUVhNJTGZT1a7wBd/lNTkzhJywnO8mz4W4+PGgX6XOv68=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHO1fJa1SJ/v/qPg2d1mHVoLrcO300dSduz2aynT36lW/UucKE
	5dGLcuhSDb4GBtJ2rudlnH3wloOXQeuT+8GkWVctfXNIVpeKPe/SMFon
X-Gm-Gg: ASbGncvgYCGSjiYUdrkZW8419jlWcvqy9OhFNO5iWrgsBGv/TQNewaHMpXi2jaqfMRq
	2bZvBr6EBDYPepPYGHbrVLjOurrb7qZxDoeKSsHRIAU1WyHGsBezo0Oj5YJxPYAWaMSRgpgrSl9
	/w5i/iwcUqZ0QSkeGCLzosEppf7SKNTdFeicVuy4Bts2Wuecn0o+WxW7DDNIUuCGbMZ0/o5lSmC
	vFj15h4vzNGSUlH2CR0J7WBgnNSlGa96WWvYHfgkyI6zoZknvYLzMxcISo25ip7uvswGrYvbIMm
	bRSwiVfm66tP3SUc2ovbfBURqsG+iIQcFUeWiHMawAtxdaYcXWOgb+hXzGOw6737/2YUR32kEPe
	1g16NsFaacdHsJ1g2cz3V0TJxR3iuVW8JgplUQYBtevThDwoz8GtCgQrKRVN/gtnQbGQ=
X-Google-Smtp-Source: AGHT+IGRurgG0gcgcuy8jSsUVy6ISTkI7Jpskf7HLDGGtwflEJua4uLny1RkZFF7c7d6ug6kAXwPcA==
X-Received: by 2002:a17:902:db08:b0:234:8e78:ce8a with SMTP id d9443c01a7336-23dee3a62f4mr114608565ad.48.1752376126802;
        Sat, 12 Jul 2025 20:08:46 -0700 (PDT)
Received: from localhost (212.18.125.34.bc.googleusercontent.com. [34.125.18.212])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de43226d9sm71023865ad.116.2025.07.12.20.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 20:08:45 -0700 (PDT)
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
Subject: [PATCH v2 2/3] panthor: save task pid and comm in panthor_group
Date: Sat, 12 Jul 2025 20:08:30 -0700
Message-ID: <20250713030831.3227607-3-olvaffe@gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250713030831.3227607-1-olvaffe@gmail.com>
References: <20250713030831.3227607-1-olvaffe@gmail.com>
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

---
v2: save to panthor_group on panthor_group_create rather than to
    panthor_file on panthor_open
---
 drivers/gpu/drm/panthor/panthor_sched.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index a2248f692a030..823b0fe678ba6 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -641,6 +641,15 @@ struct panthor_group {
 		size_t kbo_sizes;
 	} fdinfo;
 
+	/** @task_info: Info of current->group_leader that created the group. */
+	struct {
+		/** @pid: pid of current->group_leader */
+		pid_t pid;
+
+		/** @comm: comm of current->group_leader */
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


