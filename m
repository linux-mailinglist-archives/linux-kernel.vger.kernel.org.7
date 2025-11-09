Return-Path: <linux-kernel+bounces-891921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 308F6C43D0A
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 13:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C11994E4DC4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522962E7BA3;
	Sun,  9 Nov 2025 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4pf0aKg"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242E2E11D7
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689790; cv=none; b=ZbF4rn0JIQB+gXRlFcPztydTMO9j2nRBh49enbT1Vk6lrKrtJYnkhFgLbCnrlWAwujUC8QCAxxMH8uZzd4s/LIC9Wkd/tSeP8Y0N0DJYNurcmIRiO5aNocRVaUa/lkaBjc6fPBASEH64+iiHXglqn9dR9PWSeeDhuT1P/1pCF8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689790; c=relaxed/simple;
	bh=qxv9oP1S4VQrVQ/WUkjRbwz93uUoCYdrmXkz6+1+qEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h2lYdHDsqiME0rtzVnjaWXqqEblwn1Za35RC8lW4OohGqjZePuzpYpZXAm56zmS112Q1yWyDLdMc64ACWKNLd/8s5uLiB0ELbCykv+cMU2JEWFCVutuXTpia89Q0/DIGjCRWzu+w86bOnldje75XNPDpZ9OdrgorYk636kbb+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4pf0aKg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso1034410a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762689785; x=1763294585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhv3s6l+/V0AVNQ6yZgHV88airWpT9eUaCudXwyxKRw=;
        b=O4pf0aKgdNZtPmz3A03L+8ya2nc1NnoP+3ocdwjilDmcAzPLBe7rXLv6094vJvdTN6
         9kS+85umdip1HVUEWoeFmPjOtfPGM9x6aIrvG5GpvJaGT3Ik24GN3MKnywlFXWQxKEU0
         j9iGKmCcmUNLvaOvaUr9JCoKgH+LqDYnVujNXqyRMTRVKjlFWieNave4CmNDUUGLmuru
         Ny7YR/jU4oX8n+TA/PijAmHQnziq905aIbTFtrvBAiQs+PoTNGlI8hxweOAQLue44ww2
         ctKjeeGamGOaqmF3bN9D4CKsFPpJTV3IO7vWstG5p1SJmmwZ8AU02nyTY1TLdF9oRYYY
         a76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762689785; x=1763294585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhv3s6l+/V0AVNQ6yZgHV88airWpT9eUaCudXwyxKRw=;
        b=v+iD0vOgH903CDEfFb/HDH/C6xCcPu1VFz58dCLtH/FtW4cXsPkypzQLVcWz7JRoHd
         AlS6jc6mhbd0sUh383Wq34JNYC039pySaeTLnBUL92b0pLOfLzKCPDSU5maRAt03i52n
         oXNBKVM79thkSSAkS/4hXBOaPuFUeG8ohQZcLJm+U9/aEUd/JH9/K3yEBMsO/f7awBo0
         5jMVtANAYu7tDJdV+HloxNjvzlvV3dDTEgBRsPRxCL482pO6cYJR5yv/j7OhPHLy9GUw
         /Qc+RzRtX6tXz3tlVjq4tjABMV+CakeBezqV65omxZkDspDSUCBniDM0sv0N/rh6BZ6/
         GP6w==
X-Forwarded-Encrypted: i=1; AJvYcCU5VW+a+9pzpZhh83e7NCzsUEnfnhIUQtSHU+GhU5rJXm8HdvLF37f0SYh1ZH2eKp5tjP2LFgsYjL9ToSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YybCtKpBXwjM/yUUgRTsfTp+cW0T8gE+YW/PcDhFRGCoOi3oND5
	R5ijsPI4ilcLGzIpxa+konK4qJ4D8KCfquthwMb60FiRWFHTKWsnJVXsSSVPTQ==
X-Gm-Gg: ASbGncsou/TSxtXg5T/WfkgJZR7FArNyS0V/9OvZat4n8v9Z492JVzDydpbVg/+fcOj
	gDKsrDKG1QjBxaXBaI0ZHsXJqYnxMEwyAH2OZJnbdPAaoj6Y+dNNBqh9RLN+6biH8f+e/bS0Qom
	Ni1vTjt0HttODOFBk9K9ob7Y82QggJTcZCfJ4JSinxlN8p90os4dhwo2kSPuKXgZIsnuem593XO
	5NbFTfZ9EiEZXm8fWTj2UJ0PWbeF5tNgwca44VPTCLMID1sc2IT2BX0WEaHfWIeRwiaY3fgyLbm
	vkE14G/VTlTJzhSYdZTsOvFJKENgmDapY7QjolcvxUxPD+HoshKg3sCezdn/u7K/WGTNi3vCZ13
	XFfG5npC6lOrMZCaHFc9wtac4BPVBg7HM/p2KeKDEft3tagR/IEsEycveV05RosedWtliZzWfWt
	ZLdRylLrnpHFEOTO8X3D5G71u0rj35S4BoZf3S55lgl3EvYWIX
X-Google-Smtp-Source: AGHT+IE4B3XToGQDvImXqeLOymkkS7RFjZtOpBbs/n5FSVyFAWBKofw6zy/heUB61w1ZfdFoc2KFsg==
X-Received: by 2002:a05:6402:13d0:b0:640:b7f1:1ce0 with SMTP id 4fb4d7f45d1cf-6415e6efb3dmr3652910a12.23.1762689784947;
        Sun, 09 Nov 2025 04:03:04 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e9d7sm8775732a12.36.2025.11.09.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:03:04 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [MEH PATCH] fs: move fd_install() slowpath into a dedicated routine and provide commentary
Date: Sun,  9 Nov 2025 13:02:59 +0100
Message-ID: <20251109120259.1283435-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On stock kernel gcc 14 emits avoidable register spillage:
	endbr64
	call   ffffffff81374630 <__fentry__>
	push   %r13
	push   %r12
	push   %rbx
	sub    $0x8,%rsp
	[snip]

Total fast path is 99 bytes.

Moving the slowpath out avoids it and shortens the fast path to 74
bytes.

Take this opportunity to elaborate on the resize_in_progress machinery.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I don't feel particularly strongly about the patch, so if there is
resistance and I'm not going to argue for it.

Spotted on the profile while looking at open()

 fs/file.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 28743b742e3c..d73730203bb5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -641,6 +641,35 @@ void put_unused_fd(unsigned int fd)
 
 EXPORT_SYMBOL(put_unused_fd);
 
+/*
+ * Install a file pointer in the fd array while it is being resized.
+ *
+ * We need to make sure our update to the array does not get lost as the resizing
+ * thread can be copying the content as we modify it.
+ *
+ * We have two ways to do it:
+ * - go off CPU waiting for resize_in_progress to clear
+ * - take the spin lock
+ *
+ * The latter is trivial to implement and saves us from having to might_sleep()
+ * for debugging purposes.
+ *
+ * This is moved out of line from fd_install() to convince gcc to optimize that
+ * routine better.
+ */
+static void noinline fd_install_slowpath(unsigned int fd, struct file *file)
+{
+	struct files_struct *files = current->files;
+	struct fdtable *fdt;
+
+	rcu_read_unlock_sched();
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
+	rcu_assign_pointer(fdt->fd[fd], file);
+	spin_unlock(&files->file_lock);
+}
+
 /**
  * fd_install - install a file pointer in the fd array
  * @fd: file descriptor to install the file in
@@ -658,14 +687,8 @@ void fd_install(unsigned int fd, struct file *file)
 		return;
 
 	rcu_read_lock_sched();
-
 	if (unlikely(files->resize_in_progress)) {
-		rcu_read_unlock_sched();
-		spin_lock(&files->file_lock);
-		fdt = files_fdtable(files);
-		VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
-		rcu_assign_pointer(fdt->fd[fd], file);
-		spin_unlock(&files->file_lock);
+		fd_install_slowpath(fd, file);
 		return;
 	}
 	/* coupled with smp_wmb() in expand_fdtable() */
-- 
2.48.1


