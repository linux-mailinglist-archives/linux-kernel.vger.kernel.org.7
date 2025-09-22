Return-Path: <linux-kernel+bounces-827714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EE7B927C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 19:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D1BE167505
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E53168F2;
	Mon, 22 Sep 2025 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adLy/KTd"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBD3128CD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758563592; cv=none; b=dKlICFZkUyDbs240HyIJnM/7sd6GnhcLpMP3InuDGtitarWcuU6EuNi7fCS3zu8eQKR4zDCRVPH94pDr4bVPnWy2yks4unF65E1/kJHX/J/odzXxZjzEkMJOi51SgkAmtExd6Pj8j2eafGqh+LlIoecwI1Y2HtwTBtityivklcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758563592; c=relaxed/simple;
	bh=W0IBqEn4vKCxJysl6LgMrpm5cVfjcQPQF0Y/qKrqeYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jjt5LfEs5wQ4rWKIY82IGKO8c0hv5DbNzea0KVo6KbwTzNhmFG2UJMlUYtp+SA1JwJs9XEfWTm6FUiz0c2l9eLUZ9lJGL+hczQF7r/aR275fRPjYuv9w+J26Ef2RFeP58UdZ5E2NixqU6QZrjDrTKDQvJE1SjQYw5vp69Zp4uNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adLy/KTd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso3595267b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758563590; x=1759168390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PW7jSTm6gj52V8YlRuR1GgS0xiUlm6k3Tk0zo1+DlE=;
        b=adLy/KTdxIt+nxwOmJ3d7wGRo2ttZdkxdsx+AwbaWpeYkPhaKe+eD/CR8VUG1YSjAv
         bipg8PUVKJhDCmU79BZmyni8qXSORklWvya9tE3rUcF7BPVs/GV203v1EYW3laUnFy1v
         V6e223sNCxHIPU3zQHOfumV5dDB8Ger86PkaZ85RoksyjCpKvyBZU126VxR6DsaSI1cx
         gaZUpVLfeoE/sjPwvoB7LVbeYtyqguLcwrvWOTyYbG4ctVO2EqJpreM1e35jOqYLpt5N
         nljqKCs9/HcHpJlRUHNb7GbmZ5RgauZjjCwSaNMoPXsPysKLFa55H9xsu8fTj5eV3nL5
         Fdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758563590; x=1759168390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PW7jSTm6gj52V8YlRuR1GgS0xiUlm6k3Tk0zo1+DlE=;
        b=It+alxVf8YYzlXqfRT09kXipJuStBcc22ea8ZP3i2HURtqT6a1tqC2i2FrEjAZHdU/
         XGXdxmAfPgiEquWSDfTKvrJz2uqjPgzDXCro7Pv2aD3aOas1WQhVSBS42yk1RYHRjKEk
         9YvcURJK1nOJWbKRXysCqFPTsJ2lNFZgtWmmK50rn9jVkEiu2tAKGjQk76W21KenJsaP
         mJcVKQsOrFoQblBfIIw/mK/NOJUyKn8itH7/bHsf5TCq4cDq18twKh5jRoo0O5u8fFaI
         Vaz4KG23Df0BZ64TXA4RqlIpZQCDv3D+xs8D88Ik1Zvy/FyMGOXRIPQkIhPTvTthwvd6
         KOsg==
X-Forwarded-Encrypted: i=1; AJvYcCX8xxJhR7x7Q0JRapvaj/+F5t0IwumG3+nTv8H8FEPSWhyJXrhqIL4CM+ILj1mmOsGJsSlsfr2KUsCGmeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQ2pEkgDcEwYxHCNI9CBdTZDTUhC79Ix29qo5nK5uWeyT9qGX
	0rIurm8fc/M/9TYjo7xFtk+6zbmsV8VOHj+c/AfKEo9eow5RSD3KvkM9QsNFFg==
X-Gm-Gg: ASbGncvYJq6gAI3UikBzHEpuom1kReoc4c8tHpjIKxrtQdRdXsn4J0vKrJ8HrI3Fopb
	N5U1VRhBZGmYuMPYXehMGktS3mT/7aUODLUkhTRDDyeoBn2H2W7x88SIdg1I1WxZMQqSYJAJPdo
	83nrFZ2Y++m7KPfyYFgdCfbjO67RDONqyXt4u79cSBdlv1oXo4eLtQBr4/0faapABgTocbsYBqU
	OUZCEQrA5NhOo8/4WZuc60GojjdgLSslfnqqqKwJMUE7mIeErqpnrNrKt1WT++aVBYGZAq4/Aql
	b9DOg1qfM60sQPCZ7uIIe5ZWSAXim/38hQOfDTK04tdq1MIaYHIh8rk/nOf9fgdWphLzijoQWf7
	hIEaAqv3kOaLVUKzx2OyY08n464dttwWaE1UD3jM=
X-Google-Smtp-Source: AGHT+IHXcGCJS70xReRq+Wy3QVb3T8j7BoFqDnjWo5Uiys9rv583dMTnMXyGMLcS9mpOIkkI1dAQew==
X-Received: by 2002:aa7:8892:0:b0:771:fa65:ae6e with SMTP id d2e1a72fcca58-77e4e9b283fmr16807554b3a.17.1758563590323;
        Mon, 22 Sep 2025 10:53:10 -0700 (PDT)
Received: from itsmeut.. ([103.215.237.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f2c8aa554sm5040797b3a.34.2025.09.22.10.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 10:53:09 -0700 (PDT)
From: Utkarsh Singh <utkarsh.singh.em@gmail.com>
To: agruenba@redhat.com
Cc: Utkarsh Singh <utkarsh.singh.em@gmail.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	rpeterso@redhat.com,
	david.hunter.linux@gmail.com
Subject: [PATCH v2] gfs2/sysfs: Replace sprintf/snprintf with sysfs_emit()
Date: Mon, 22 Sep 2025 23:22:22 +0530
Message-ID: <20250922175237.37474-1-utkarsh.singh.em@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/filesystems/sysfs.rst mentions that show() should only
use sysfs_emit() or sysfs_emit_at() when formatting values returned
to user space. This patch updates the GFS2 sysfs interface accordingly.

It replaces uses of sprintf() and snprintf() in all *_show() functions
with sysfs_emit() to align with current kernel sysfs API best practices.
It also updates the GFS2_SHOW_UINT macro to use sysfs_emit() instead
of snprintf().

Signed-off-by: Utkarsh Singh <utkarsh.singh.em@gmail.com>
---
 v1 --> v2: Code style cleanup and maintainer updates 
 
 fs/gfs2/sys.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index c3c8842920d2..487fff098465 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -59,7 +59,7 @@ static struct kset *gfs2_kset;
 
 static ssize_t id_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u:%u\n",
+	return sysfs_emit(buf, "%u:%u\n",
 			MAJOR(sdp->sd_vfs->s_dev), MINOR(sdp->sd_vfs->s_dev));
 }
 
@@ -68,7 +68,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 	unsigned long f = sdp->sd_flags;
 	ssize_t s;
 
-	s = snprintf(buf, PAGE_SIZE,
+	s = sysfs_emit(buf,
 		     "Journal Checked:          %d\n"
 		     "Journal Live:             %d\n"
 		     "Journal ID:               %d\n"
@@ -140,7 +140,7 @@ static ssize_t status_show(struct gfs2_sbd *sdp, char *buf)
 
 static ssize_t fsname_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n", sdp->sd_fsname);
+	return sysfs_emit(buf, "%s\n", sdp->sd_fsname);
 }
 
 static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
@@ -150,7 +150,7 @@ static ssize_t uuid_show(struct gfs2_sbd *sdp, char *buf)
 	buf[0] = '\0';
 	if (uuid_is_null(&s->s_uuid))
 		return 0;
-	return snprintf(buf, PAGE_SIZE, "%pUB\n", &s->s_uuid);
+	return sysfs_emit(buf, "%pUB\n", &s->s_uuid);
 }
 
 static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
@@ -158,7 +158,7 @@ static ssize_t freeze_show(struct gfs2_sbd *sdp, char *buf)
 	struct super_block *sb = sdp->sd_vfs;
 	int frozen = (sb->s_writers.frozen == SB_UNFROZEN) ? 0 : 1;
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", frozen);
+	return sysfs_emit(buf, "%d\n", frozen);
 }
 
 static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -194,7 +194,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
 {
 	unsigned int b = gfs2_withdrawing_or_withdrawn(sdp);
-	return snprintf(buf, PAGE_SIZE, "%u\n", b);
+	return sysfs_emit(buf, "%u\n", b);
 }
 
 static ssize_t withdraw_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -397,7 +397,7 @@ static struct kobj_type gfs2_ktype = {
 static ssize_t proto_name_show(struct gfs2_sbd *sdp, char *buf)
 {
 	const struct lm_lockops *ops = sdp->sd_lockstruct.ls_ops;
-	return sprintf(buf, "%s\n", ops->lm_proto_name);
+	return sysfs_emit(buf, "%s\n", ops->lm_proto_name);
 }
 
 static ssize_t block_show(struct gfs2_sbd *sdp, char *buf)
@@ -408,7 +408,7 @@ static ssize_t block_show(struct gfs2_sbd *sdp, char *buf)
 
 	if (test_bit(DFL_BLOCK_LOCKS, &ls->ls_recover_flags))
 		val = 1;
-	ret = sprintf(buf, "%d\n", val);
+	ret = sysfs_emit(buf, "%d\n", val);
 	return ret;
 }
 
@@ -437,7 +437,7 @@ static ssize_t wdack_show(struct gfs2_sbd *sdp, char *buf)
 {
 	int val = completion_done(&sdp->sd_wdack) ? 1 : 0;
 
-	return sprintf(buf, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t wdack_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -459,7 +459,7 @@ static ssize_t wdack_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t lkfirst_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", ls->ls_first);
+	return sysfs_emit(buf, "%d\n", ls->ls_first);
 }
 
 static ssize_t lkfirst_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -492,7 +492,7 @@ static ssize_t lkfirst_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t first_done_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &ls->ls_recover_flags));
+	return sysfs_emit(buf, "%d\n", !!test_bit(DFL_FIRST_MOUNT_DONE, &ls->ls_recover_flags));
 }
 
 int gfs2_recover_set(struct gfs2_sbd *sdp, unsigned jid)
@@ -550,18 +550,18 @@ static ssize_t recover_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 static ssize_t recover_done_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", ls->ls_recover_jid_done);
+	return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_done);
 }
 
 static ssize_t recover_status_show(struct gfs2_sbd *sdp, char *buf)
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
-	return sprintf(buf, "%d\n", ls->ls_recover_jid_status);
+	return sysfs_emit(buf, "%d\n", ls->ls_recover_jid_status);
 }
 
 static ssize_t jid_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return sprintf(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
+	return sysfs_emit(buf, "%d\n", sdp->sd_lockstruct.ls_jid);
 }
 
 static ssize_t jid_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
@@ -626,7 +626,7 @@ static struct attribute *lock_module_attrs[] = {
 
 static ssize_t quota_scale_show(struct gfs2_sbd *sdp, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u %u\n",
+	return sysfs_emit(buf, "%u %u\n",
 			sdp->sd_tune.gt_quota_scale_num,
 			sdp->sd_tune.gt_quota_scale_den);
 }
@@ -679,7 +679,7 @@ static struct gfs2_attr tune_attr_##name = __ATTR(name, 0644, show, store)
 #define TUNE_ATTR_2(name, store)                                              \
 static ssize_t name##_show(struct gfs2_sbd *sdp, char *buf)                   \
 {                                                                             \
-	return snprintf(buf, PAGE_SIZE, "%u\n", sdp->sd_tune.gt_##name);      \
+	return sysfs_emit(buf, "%u\n", sdp->sd_tune.gt_##name);               \
 }                                                                             \
 TUNE_ATTR_3(name, name##_show, store)
 
-- 
2.43.0


