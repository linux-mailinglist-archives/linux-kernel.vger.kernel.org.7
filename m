Return-Path: <linux-kernel+bounces-807429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0357B4A449
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3407A6F80
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E07223D291;
	Tue,  9 Sep 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Wpx+iIFp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BCD2405EC
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404519; cv=none; b=gsXipoNa0XQjEO9wPRPsl0SWZ7GSn8hwo3GWr4VGEuvrReJulG7qAsiMPeqZShjOuLwt1uZmyJrY6rrxojSYYl+KBtjijYpf44KxwzlGLiFVVZILO5KrrSc/7x57/J1pHw7lT5tlyk+tgXTU50PpmS1N7BKUbZ89XQAj7CujxqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404519; c=relaxed/simple;
	bh=NlyQX/DsiHcnJuIAXF6bG9cuQ3pMOI7QfUs1ALbUdgI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=P/biJpQzU6zONZIVCPNty9g0lstlX4L75TnbLVDMmdzqLWOKlFUiTwnYtE8Qg+mRjXrfo81gNk4gEKFOLLoPOCIUX9XSx0aiAsvcqJ0CEc5g1iwXDkAM3XNLSjjTOVjWHZb4NIo6yF/DIZdwWT+FXAz64eYBXieC4whC3iDzA2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Wpx+iIFp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so31923265e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 00:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1757404513; x=1758009313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iJIUW/B6bBAlSl449fLp237f72bGDVB2XXvWmb7Dlu0=;
        b=Wpx+iIFpXxgkYTHAU5srBCzcGqY2sWcueYPHzmBoNfAhfOMfjFJ1Xe3jXTu8jufIAH
         LMPgRkUPl7HfXchY9Ipra8ev7LzXtr/i+2n1AELAMfr/xT2nFeb8/gXql+I7f/xNbW7z
         XuytxPToBxuU5XE1NGvQ+o+fDJmd8Wu3dbtLWtt8AqMjOfR+7R+rasfvU6xVFpSFFo1T
         kOebvEBrYEPamdXMxnC6GS+xcpPfDwZyZ+GvowblAhRtpgPmrnELePhi5HOa62WMqHHj
         O6Va90KOYzFAoe6hZwoxhsK3de0Bsi11kAyeGTulNT54VSYMoF8s3I1+PzWc4XvEJgah
         tXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757404513; x=1758009313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJIUW/B6bBAlSl449fLp237f72bGDVB2XXvWmb7Dlu0=;
        b=ALc9OKUZd/tpvM+c607DZCX3OGTIR8NFuF/p5Lw/v4lOciHAnjBE9fqxq/Upp9dEZX
         wfTvgAvjtr7WDJQ/O8pllM0bX+a8VlMPDiKV77lHKkY7X0hPse13FDTKXVWPO17zs92f
         NtnrBpapXPKw1p4RvwkTH2SsTwtI/tt8h7iGt/Kty3KKqGe+xhaRAi8QoE6oT2lTbn1L
         cYoQCqkvt+MQDmZE6rC+5akosZojVkhuPP/Addpl5iMXiArGEZ/N9JQwhlYrDqEVNmv/
         5F1eEshALQgVZkG1DrbV52dWtUwmE7xUB7O3Aybrc4BVuB7qaDk1ygh2IEs/SrCbL+ZV
         YcMg==
X-Forwarded-Encrypted: i=1; AJvYcCWWLybBL8MP8uqXUqjSql2gOSXYou/JEqP8VkLhHYtNRqM50qmuk0nkGM3v1w+tWkLDRa7auDbNNvS5kDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGYfAZLPz0ai33Nw1/wmZGU9An/gBOJ5+tWHe23BDeGmXgdpJ0
	uZrRLJ/G4qwMH2Jkg90mDG9VA8mzUS0iPsPPdkos9emGoM7RkSnJ1SD2rSt8mv1U7PU=
X-Gm-Gg: ASbGncsC7n954xcQ+Iw20habjSytRiA4wIq9jwOVv0wH1hZna5IqtsejHbZlVfe0VHX
	qJ/OgIkllD9YnSGr/ZSOgJ56krbXL4k5iDrFOC56EhR2vH+NHdx5R/I7St+JBGZIawpCmq2z183
	Qb+1jUy0iz4BIyUAPz37/SXROkczt0yPv/Sdgbftm85bcoWqitV3dwbGYxc4GwOXIvsouTlQRtg
	11RisOZlCm2lc5vmQjFtXKFIArhw8Veama4fUslbCxqCqueS+KHrPdgIKpeUyjcyM01YXdtIusW
	qbThTggOZ9erABNT3FNTBcKaBpMwy0xjSpArdbFWr8J08j86erMJ5TN4ikebAH3j3XYu4UwOhJd
	19WbrSuyHqVbcF4jzGXM5Lg8XgZaFRixSe1EEFiJPpX2/EkwsqLfV1Da79KoCIij9K2jkDz0qFh
	y/kh3wUmpi9YpDr43mM5U9qN4=
X-Google-Smtp-Source: AGHT+IG4sby9AdCMPvTTLfJtOsnOjswT0sfnstoRYm2t4KB0Ukqf4iZMlcLigEkFw3eJlviQgaxtCg==
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id ffacd0b85a97d-3e6e931f910mr5542854f8f.61.1757404513482;
        Tue, 09 Sep 2025 00:55:13 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1b3000023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1b:3000:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e75223f5d7sm1492229f8f.53.2025.09.09.00.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 00:55:13 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/namespaces: make ns_entries const
Date: Tue,  9 Sep 2025 09:55:06 +0200
Message-ID: <20250909075509.810329-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global variables that are never modified should be "const" so so that
they live in the .rodata section instead of the .data section of the
kernel, gaining the protection of the kernel's strict memory
permissions as described in Documentation/security/self-protection.rst

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/proc/namespaces.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 4403a2e20c16..56e81f0273fc 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -12,7 +12,7 @@
 #include "internal.h"
 
 
-static const struct proc_ns_operations *ns_entries[] = {
+static const struct proc_ns_operations *const ns_entries[] = {
 #ifdef CONFIG_NET_NS
 	&netns_operations,
 #endif
@@ -117,7 +117,7 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
 static int proc_ns_dir_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct task_struct *task = get_proc_task(file_inode(file));
-	const struct proc_ns_operations **entry, **last;
+	const struct proc_ns_operations *const*entry, *const*last;
 
 	if (!task)
 		return -ENOENT;
@@ -151,7 +151,7 @@ static struct dentry *proc_ns_dir_lookup(struct inode *dir,
 				struct dentry *dentry, unsigned int flags)
 {
 	struct task_struct *task = get_proc_task(dir);
-	const struct proc_ns_operations **entry, **last;
+	const struct proc_ns_operations *const*entry, *const*last;
 	unsigned int len = dentry->d_name.len;
 	struct dentry *res = ERR_PTR(-ENOENT);
 
-- 
2.47.3


