Return-Path: <linux-kernel+bounces-832395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01919B9F3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 047B77A95FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E658A2FE072;
	Thu, 25 Sep 2025 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arhJRmS+"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75842F3C00
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758803307; cv=none; b=GpI8iYHhEXE7v3oksun2hYZ7EuU9TcU6LrZaKtd28AzqngD2epTDnrBF3DyuM3Fb+XoaH7qx1VfVUoaj3O3rIaDkFXY3XskVQMZYDNwq3a92mPxnGnhjo6zKKIZQ7bDEIKddSdcB5Biyx2Im5OvKM4hc4+cmOFWyyAV0dCFZH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758803307; c=relaxed/simple;
	bh=n+Npa7HxFe6GydJe9QQHI1j2Gl2iX/SizqTe5U1vWuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TVSJYBM6Nu6psfFvG82MB9kxpSyYhyMJWA/mJ4RTBH24HfZqaTyCc4pTQKpaMLaQOVYjc4buk4dKOocRx+CdnEUIntWWevcowEj8jWsaupkbfq8lmjyFd14TRdvGi/PgH+wilV5YHGuTrKQyWRTCBVr/zarmI7Sf1XIwc3WVtKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arhJRmS+; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-8cf4f90b6f0so72558839f.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 05:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758803305; x=1759408105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cPSfZsGw7TX5UGkY7/kJizo+KvLE8uMTFRrfjAd897s=;
        b=arhJRmS+Km7y4VrrAbQ15m4egArvN3KpuQvpKpC0h+60vQjpYZo8desnOaesKK0smo
         rfYungrGkUOmfb4g6e7qS3Oqj79kLh2kC6HiyVPjEOPLTpKZ/olLytDo18vJC1qdiWJt
         bFPr+9Z+2gHBHTcM95w8fNmeYdTllXn5MkYuMsF4CIVeGowH8CNrOnnjCkRsWzGYVIYz
         wYwSVqD9Wnujo5ZD+9n+LG+trwJs6qHuPECW4ehJEWrElOE0K2IUhmT/pGSD/7txR05c
         KF42boluL6YHjHb9IO1+wAIVWvP1KpXRu3P1XOZrET70NpF1NKWZnwdFGDaNYhtMauB9
         QBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758803305; x=1759408105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPSfZsGw7TX5UGkY7/kJizo+KvLE8uMTFRrfjAd897s=;
        b=r6QY2+SFIawjwMJKJvIkyBwPpwBi50gwdsjvIC7rAunAknOrC84EgDO0fLOqyT4Ies
         5Bhw8N7w1YVcsN/9uWB7awAho38TmIie/LOA6xBrt/6ZggexbSNGWJRRZSEKoKmynbV3
         PArvp+vpoflWIqGmSjfsgBwRQ6cB+lEqyHi281fsI7KI3cTB4SuDIsbqmk0wbwK3+AHM
         6epbcizpuWPORBJ80PSl2gp1T8QHegZcVJlEhABy60tzued1CXwrc2++P/LSvz352UeH
         zoX6NxifzbcJ1PhL4F7IN6EkSMxwMy9xqWYJM9q5JyIOb3JXYdGIB4HMKmquEonr7zwO
         Wekw==
X-Forwarded-Encrypted: i=1; AJvYcCUDDpjtj4SXde+lBzO5p01LEZx7V6MdNjuH/X+mKgBfLB5EGpUMvOCl0cM1UlSXjmA59CXlLevEISqPcjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+Myx0gxcCNvsqO26h/udEglP9QvABZeDDk2Sk6Q6KQZHM5Pd
	Y+DGPay8r3TN97Dnl55Qn7OgueM6wiFakvRobC07N9DHm5FgIwX4l/Qh76sRGx22
X-Gm-Gg: ASbGncuPanYYF1j7PRIRdLBYhho+1FWX2ILzhnYPsI1K+dmKQEeFNYnzC7c40bnMv5M
	IP6t5tlNiSbulD/wUk9w6LIAbuGgvzIW1i2Pi9HYfst0lv0afXWaUtR3xdTd9yxY0n4R1g8vxVL
	E5lC6n/VT98AWq2WQIBmqNSQCwMQXGi8nPwIH8ZdIri/8fhgriPBvx4j6z94LnccD3X9G2+SL8s
	DjsEev/jn6PfLrDDkL5HBnIOLJys6hYNjdqtdNTLDSHgiD2eVfHOxkMQvQ3AEzeXmwssmw0StD4
	C9R24DxjRqp6tD/kbhOGUJG/mg1MJe/LEBiDF2qXd7/zmjNQxoRNIFsd6Zdnd5vOnueLJqY6aNg
	S/bxMfxVN35DaEK44Y+ElGhRwJ5CLcMs3U5XG8c6TktqIoRaQUJgG/REs
X-Google-Smtp-Source: AGHT+IEuMMUPS//JklNGnOQsAvqh7k2xGg93mFxoo3yy0fiAmwe3+/f1l+tIeLAmveKtS9CTO/DPqw==
X-Received: by 2002:a05:6602:2b8b:b0:876:adf1:b263 with SMTP id ca18e2360f4ac-90155d6f121mr523173439f.6.1758803304705;
        Thu, 25 Sep 2025 05:28:24 -0700 (PDT)
Received: from IU-KL9VVWHMWT.uits.iu.edu ([2601:801:180:e310:a9a9:ec82:aa70:f956])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-904100c3cfcsm70867439f.23.2025.09.25.05.28.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 05:28:24 -0700 (PDT)
From: "Randall P. Embry" <rpembry@gmail.com>
To: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
	v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rpembry@gmail.com
Subject: [PATCH] 9p: fix sysfs output overwrite and clean up typos
Date: Thu, 25 Sep 2025 08:28:02 -0400
Message-Id: <20250925122802.72580-1-rpembry@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While diagnosing a UID mismatch issue with 9p shared folders
under UTM on macOS, I noticed a couple of small problems in the
9p client code:

  - caches_show() overwrote its buffer on each iteration,
    so only the last cache tag was visible in sysfs output.
    Fix this by appending with snprintf(buf + count, …).
  - v9fs_sysfs_init() always returned -ENOMEM on failure;
    return the actual sysfs_create_group() error instead.
  - a few minor typos in comments (e.g. "trasnport" → "transport").

These changes improve debug output and readability without
altering core behavior.

Signed-off-by: Randall P. Embry <rpembry@gmail.com>
---
 fs/9p/v9fs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 77e9c4387c1d..e3e6890718a0 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -438,8 +438,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 		v9ses->flags &= ~V9FS_ACCESS_MASK;
 		v9ses->flags |= V9FS_ACCESS_USER;
 	}
-	/*FIXME !! */
-	/* for legacy mode, fall back to V9FS_ACCESS_ANY */
+	/* FIXME: for legacy mode, fall back to V9FS_ACCESS_ANY */
 	if (!(v9fs_proto_dotu(v9ses) || v9fs_proto_dotl(v9ses)) &&
 		((v9ses->flags&V9FS_ACCESS_MASK) == V9FS_ACCESS_USER)) {
 
@@ -450,7 +449,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 	if (!v9fs_proto_dotl(v9ses) ||
 		!((v9ses->flags & V9FS_ACCESS_MASK) == V9FS_ACCESS_CLIENT)) {
 		/*
-		 * We support ACL checks on clinet only if the protocol is
+		 * We support ACL checks on client only if the protocol is
 		 * 9P2000.L and access is V9FS_ACCESS_CLIENT.
 		 */
 		v9ses->flags &= ~V9FS_ACL_MASK;
@@ -561,7 +560,7 @@ static ssize_t caches_show(struct kobject *kobj,
 	spin_lock(&v9fs_sessionlist_lock);
 	list_for_each_entry(v9ses, &v9fs_sessionlist, slist) {
 		if (v9ses->cachetag) {
-			n = snprintf(buf, limit, "%s\n", v9ses->cachetag);
+			n = snprintf(buf + count, limit, "%s\n", v9ses->cachetag);
 			if (n < 0) {
 				count = n;
 				break;
@@ -601,9 +600,10 @@ static int __init v9fs_sysfs_init(void)
 	if (!v9fs_kobj)
 		return -ENOMEM;
 
-	if (sysfs_create_group(v9fs_kobj, &v9fs_attr_group)) {
+	int ret = sysfs_create_group(v9fs_kobj, &v9fs_attr_group);
+	if (ret) {
 		kobject_put(v9fs_kobj);
-		return -ENOMEM;
+		return ret;
 	}
 
 	return 0;
@@ -669,7 +669,7 @@ static int __init init_v9fs(void)
 	int err;
 
 	pr_info("Installing v9fs 9p2000 file system support\n");
-	/* TODO: Setup list of registered trasnport modules */
+	/* TODO: Setup list of registered transport modules */
 
 	err = v9fs_init_inode_cache();
 	if (err < 0) {
-- 
2.39.5 (Apple Git-154)


