Return-Path: <linux-kernel+bounces-898426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E185C55457
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C40494E381B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 01:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA0B296BBF;
	Thu, 13 Nov 2025 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESTeipE0"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C53B1BD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997801; cv=none; b=m62kwpwsvKrNLWQt10kk9FzRtK2w/5TTM/E+zjjEpD1k23GO972VIWHyAhhYT6QMKl3t2SmOm0h1DGBmaVJEUveRSOPgLlYILIFs0HcJhI5ZBxiJTK1n0l/Yi/H9dDDWBCSioREg4uXYhcLqXf22s2E5yFM+tccHaieUV7ECR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997801; c=relaxed/simple;
	bh=bMdDBLNj03OoDLCv+IHb3i9hv5R5kNipckjW1y7Fk14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvfzTaWy59l9Q1yRZd7Qlvyc6R6EJ7UXrnwKgcQivG6gmFFIRFaolRCYuWpJgmcVs/qIvpOhxCRhAoUjteUeaFfll0uqH4QXR0XyGLNs+XTZhSm+qm+H9gSR8DjOJ2bBosxn6pfF/0pekhsA//NPX21Hjdb8lcORVb6U5Nq2Nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESTeipE0; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-657230e45e8so243777eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 17:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762997799; x=1763602599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3jgQtlJhc0lxfymO4tKYMAAUXywVaSmij9voL4WdtpY=;
        b=ESTeipE09Ouw4aTYaFw3XMRaJHgmimxe7+5EfWsKO0aQ3Ei1YroLbVQm0wYXTc2aBf
         OG/0Z1XGaC5sAFfy5jM4qeHymMrmsSl1I5kU7zcgNHwXFPSA3MtoQdzfduFkn7Dioocg
         X81tFxOJMOP61XPZwkPDKDSd5fYegg9jN4N1d+HAZ85nNuQ1jWbgOFKGgnbsOlH88oiO
         ZCGRLg2V/mqtEfUekuwioi1Flaa1D2pgG0opmqNk40I6G3JP3QzXIGl0PbdzqtJLxy2n
         WflAqpGt9WTEF1BfiFFEilGgcue0KWSjtCRIEP+KMx8N6hKwOTVZ6zhLjiqdNQ4/7Ynf
         jjTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762997799; x=1763602599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jgQtlJhc0lxfymO4tKYMAAUXywVaSmij9voL4WdtpY=;
        b=PjU38GN53ONAcwKXnS71ShF6y2UeP7S/0qQ/YmbR/lht/yqOc5J4HwSyfM7zlktMre
         yt1ods/i/x/8R+Ru7qfpnumWL8gdFN+S6GBTCqHLFcCK6U31IT9txs0garmEV5Yuh0/9
         W/qAUdLqlHsw4ocxiow78+t4PFVQSz6SIgJOoq6SxhtZ+guklgJMlRx5a7s3WpBvFY84
         LN3vVg1L+mfBBf4aGADyQvR92ENKSKRqXVdkxJvNHtA2FhN2qv+ULFnAB1GkLGS95l9l
         78cjOIfHM7s0+uM+2DSK+1DSgs9bSUhoaBUijO4bx7Gqx75rcVY53EbcfMSa+SkZJUaZ
         NTww==
X-Forwarded-Encrypted: i=1; AJvYcCVMx6RIFdCmbt0tbKIYE5YsqKAdtmD+yR5FL7dUVdQJoOALeg9dQ4BB2EWkSw5jxc501ZQIvRni9CrvjyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5zsFnTPjYLXL88+HkxoRvam9sFWGyFUqAmlYP7/okfzpqnOB
	ywAksCgB6Ml2Al34/cUY+WlcOEW2IwbwS+kphKkOfQlx3DagGmT5ioGI
X-Gm-Gg: ASbGncvy4psbSZGpXwc1Jk3NM4HoeH8tUMETsI4JI+DOgz0eOpjMGo82KgwS/bkRNZF
	5n0rYsL+HHbXacZU2iTgxIggcwjdrQpNacq0CLBClFSLFIG1OThhiuFBdZNfALJm0EFQ8T/4Rqf
	RPCXuri30jpEgI66j9SyIG501Ah3C7yP2inV8IEE7ZRdAInWKt9OAKY6BLywCI1FyEL2w1yQobx
	tpA6N8g+AWOrCryCZqscc5RaUDOaN7dNZjUIZ5bP6Ez9LXFxGv2cLq8hCCKtcYmPWKf/kOPxdsg
	537gAzTkl1TA3xB3dG+yOtd+Em1TEP8e65hXBQ20bIHafFu864GVQwjPTxM3//ovUo0h/vPaJ+N
	dCLGjGfhZ1GRD8eWeUWWSHgTsZssOnnJiLVw8citniCmXTgvowvEckgWB/qJjB4a8r1dYc3TW3h
	XA6PPNUYcVck0q9Eg7UP+R8rFlJ+bQdYjyrhTI4dymr52PU6giHzWt8+m6tO4vkMbdci0LOmo9X
	nTOfpMEEgmv0+QZOfxeSevAMN8T
X-Google-Smtp-Source: AGHT+IENjRfB0Wr8Tt+t2GzNl6io0GJSBGW6XHcXIqQoB6ahGHC1gEyI5aGELtUaPn+tkI9HjmtyHA==
X-Received: by 2002:a05:6870:247:b0:314:faa7:931b with SMTP id 586e51a60fabf-3e84c6ffc66mr1042812fac.25.1762997799104;
        Wed, 12 Nov 2025 17:36:39 -0800 (PST)
Received: from uacde259c55d655.ant.amazon.com (syn-071-040-000-058.biz.spectrum.com. [71.40.0.58])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3e852058dcesm486754fac.9.2025.11.12.17.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:36:38 -0800 (PST)
From: jayxu1990@gmail.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jayxu1990@gmail.com,
	rdlee.upstream@gmail.com,
	avnerkhan@utexas.edu
Subject: [PATCH] fs: optimize chown_common by skipping unnecessary ownership changes
Date: Thu, 13 Nov 2025 09:34:49 +0800
Message-Id: <20251113013449.3874650-1-jayxu1990@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Xu <jayxu1990@gmail.com>

Add early return optimization to chown_common() when the requested
uid/gid already matches the current inode ownership. This avoids
calling notify_change() and associated filesystem operations when
no actual change is needed.

The check is performed after acquiring the inode lock to ensure
atomicity and uses the kernel's uid_eq()/gid_eq() functions for
proper comparison.

This optimization provides several benefits:
- Reduces unnecessary filesystem metadata updates and journal writes
- Prevents redundant storage I/O when files are on persistent storage
- Improves performance for recursive chown operations that encounter
  files with already-correct ownership
- Avoids invoking security hooks and filesystem-specific setattr
  operations when no change is required

Signed-off-by: Jay Xu <jayxu1990@gmail.com>
---
 fs/open.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..82bde70c6c08 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -761,6 +761,7 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	struct iattr newattrs;
 	kuid_t uid;
 	kgid_t gid;
+	bool needs_update = false;
 
 	uid = make_kuid(current_user_ns(), user);
 	gid = make_kgid(current_user_ns(), group);
@@ -779,6 +780,17 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	error = inode_lock_killable(inode);
 	if (error)
 		return error;
+
+	/* Check if ownership actually needs to change */
+	if ((newattrs.ia_valid & ATTR_UID) && !uid_eq(inode->i_uid, uid))
+		needs_update = true;
+	if ((newattrs.ia_valid & ATTR_GID) && !gid_eq(inode->i_gid, gid))
+		needs_update = true;
+
+	if (!needs_update) {
+		inode_unlock(inode);
+		return 0;
+	}
 	if (!S_ISDIR(inode->i_mode))
 		newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
 				     setattr_should_drop_sgid(idmap, inode);
-- 
2.34.1


