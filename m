Return-Path: <linux-kernel+bounces-823406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B4B8655A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9003AE590
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E5B285073;
	Thu, 18 Sep 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5aUatVN"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80555283FE6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758218207; cv=none; b=luwSd4tcnLA7ozTC1xa1V652Sta3myfUOrxgUgymhU9UgyrPpwu5b16HjNay6r0K8cfeb7661IUZ1ho8Biq3PlfVP2qgAqrmy/xYf+N9RYyXvP2Zd7Z7862dDffRBIxRuf6zUY8KC5/4qgaSFcbU2E731eZX2B16j05mEqYBC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758218207; c=relaxed/simple;
	bh=U8iHdE1DU42lSzhiPs8MNTQ6En/hzji2xtgp/3h/Nak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PyAkCIGoSkkMqd13WDEyS7LNnjqfR2un4HPgjghy3npv24CqzYWIoRXhUimixDK+z4OCPgLa6NJ/qgRsB1Eec86CSWTMwuKyju7bOtBHUxErqq8W2sTbA7NnTkdT65T0CFeE6YPU9mf2gp/RBFgRKFe1QpU183WaeCqFHqy+tW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5aUatVN; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e9042021faso889612f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 10:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758218204; x=1758823004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdvxtgG+W0bP4h9lSXAZ6eBdnNjpx+XRSyEW/uzBUNU=;
        b=Z5aUatVNbXaEGRGtBpVop6/YYuJH6Xv/hHN262iv+e/E8ktbggZ/1FDXDqNUaxhPnS
         +q6HY5x1KOxC0Uqt8j8LrZEQE4O292RRD0QsRjSsVQzhQxrusWMed8u/xN1oovzZQfCZ
         djA+DoVnjYZzZCr3O0kGrKPJ51cFtLT/n8X/mAApErXYPmI/hquVF1NtodKit+M2/3om
         HoDJpJWT3ZfQmJi2DcO87kQFEJwqiPoYMRQTnieQT3ZdfmG60x7AQPfC9f1W+GLfIHFx
         8PeRUbhH2GSeMyFyu2MSTMS0ypjDpzViRvny2TE9cb2/rEy0vHfO7Tf+3NqiNGf0ASjR
         S+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758218204; x=1758823004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdvxtgG+W0bP4h9lSXAZ6eBdnNjpx+XRSyEW/uzBUNU=;
        b=kqGzDoeTGuhBS9CE+Xzr2W6Q52r9q5qMmAEE21UBVmlCMFa0sfE7w36pCjYlO0PYo2
         vW5ry9M9oYrUjBOZSsGjPMPzoxT36JeWxmZ3iH6HC6dVfYq5NNpG33Kd7+kiWiPpelpm
         MshGe260/hmjga4KQsdP6xHPZaZ54vy9hNjTX1VgDYyC1UIMjAbyU8fdLmFFyMox3YLa
         GYZIaCRhcEx0T9zj7jzbNu3K3wm7AQl61wYJ4fgl2J6o4WCIjVOWuwInuEltehV57cYG
         28IBpxuHpk2ApA0s35ATLok85d7YbkVf1J6fi6889IoEKu/RAashBEguyrl1alP9IGSN
         6MPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqemrjW749fbRZ1lnobQ3hbGqLa8eyhVPG2d3qyDAirIjYRtHUOXaYbLxe3At6X8UHGG16gehKDQrj7ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmFYk3DVHEssZ1Lpwq+8ziw58R0rbFArPVF2T/nbomwevWMk7
	PaHtf57q8RyQ1KPqfkk0klPi4w7pzOricqydQQbbJNJ7/ym/j7Pm7eVp4gev6u8U0AM=
X-Gm-Gg: ASbGncv8VXg7xsXXcvpGVJjz7uz9+pu34+3lVa9YUngv03c38sx8TOGC0Djm4cM4M8j
	1lQviULSlpCqV9/KA4nAYz+IuXinM/ju0cGOxigshZBQe70ozrIRuiwx2x5d2FD11P+9AmJoVw7
	2+0uRDYHkAhyJJjdcUYp8eXg7WIBGOCFswK5BW6M3/u6x0ivyvqzFSrDesTgdJhesDZOTtCVlmW
	P5pOMwPyxC6k2p7bE6KwCKphr2xONF5XbhluAWwA7Zq/OlynF9bfsOySSCb11327yMthho04XZY
	wy1CLrkuEyV6/IxWlwpgyMXNeaO8g1v9xBeBJCEbthJaGSmpdeT6QdgBpazeBu1v4qI5rz5TG0U
	rJ9aZcdeWNfYXte40CVF+3vfWF9HDK8SHoIr4soMTNobV
X-Google-Smtp-Source: AGHT+IG+LlafBp1zHMJXHSQ3atVCRalq4bFvAwyFj+H8A+XPdD7ZEb4MccJq0WgSxA9gQ0ZMkg+RYQ==
X-Received: by 2002:a05:6000:1885:b0:3d1:c805:81e with SMTP id ffacd0b85a97d-3ee7c925550mr136862f8f.4.1758218203390;
        Thu, 18 Sep 2025 10:56:43 -0700 (PDT)
Received: from eray-kasa.local ([88.233.220.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7300sm4369752f8f.34.2025.09.18.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 10:56:43 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH] Fix: ext4: guard against EA inode refcount underflow in xattr update 
Date: Thu, 18 Sep 2025 20:55:46 +0300
Message-Id: <20250918175545.48297-1-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

syzkaller found a path where ext4_xattr_inode_update_ref() reads an EA
inode refcount that is already <= 0 and then applies ref_change (often
-1). That lets the refcount underflow and we proceed with a bogus value,
triggering errors like:

  EXT4-fs error: EA inode <n> ref underflow: ref_count=-1 ref_change=-1
  EXT4-fs warning: ea_inode dec ref err=-117

Make the invariant explicit: if the current refcount is non-positive,
treat this as on-disk corruption, emit EXT4_ERROR_INODE(), and fail the
operation with -EFSCORRUPTED instead of updating the refcount. Delete the
WARN_ONCE() as negative refcounts are now impossible; keep error reporting
in ext4_error_inode().

This prevents the underflow and the follow-on orphan/cleanup churn.

Fixes: https://syzbot.org/bug?extid=0be4f339a8218d2a5bb1
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ext4/xattr.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 5a6fe1513fd2..a056f98579c3 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1030,6 +1030,13 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 
 	ref_count = ext4_xattr_inode_get_ref(ea_inode);
 	ref_count += ref_change;
+	if (ref_count < 0) {
+		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
+				"EA inode %lu ref underflow: ref_count=%lld ref_change=%d",
+				ea_inode->i_ino, ref_count, ref_change);
+		ret = -EFSCORRUPTED;
+		goto out;
+	}
 	ext4_xattr_inode_set_ref(ea_inode, ref_count);
 
 	if (ref_change > 0) {
@@ -1044,9 +1051,6 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
 			ext4_orphan_del(handle, ea_inode);
 		}
 	} else {
-		WARN_ONCE(ref_count < 0, "EA inode %lu ref_count=%lld",
-			  ea_inode->i_ino, ref_count);
-
 		if (ref_count == 0) {
 			WARN_ONCE(ea_inode->i_nlink != 1,
 				  "EA inode %lu i_nlink=%u",
-- 
2.34.1


