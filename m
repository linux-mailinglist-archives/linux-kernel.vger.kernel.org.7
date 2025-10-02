Return-Path: <linux-kernel+bounces-840254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FE2BB3F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 065433A73FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 12:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8736E311C37;
	Thu,  2 Oct 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhl9EF9F"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625FA311957
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759409750; cv=none; b=bfhGAKTudAirjhWUNjoosuKc+EGziDtLnafyYlbYKZ0ugKbM0+5ZgW6vz67H33E8anYOGR8LO7EdBUxCnfbhZzbQHYqIFNDBzHx/YvJaUkmyIguYKGR8Nz44UZfYOd+kj2FKJ8vDw6aD0Y4BF5dVp6WVYQ1WMu0itg350FCL4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759409750; c=relaxed/simple;
	bh=fak1x7u6QjeJLvthEEWVG8U8+j2kAQGpv7pJ0KElavg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gom79/X41SSF0o4uDhZ8RwXX3bUR0V6c7yLAD2k5qXS1opw8O5T1jdRqlPPHJ6c3IK2Fb3noT0mFCEniGrkj3aw2O0cAV+olJkuf7gy6erhnaRFjOUZeW69XQT3Pckk6JCTVOsP9T0dTVS8NMr6LTKbDLF+/DG5asyV5Pthg53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhl9EF9F; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77f605f22easo1032587b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 05:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759409749; x=1760014549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJKixBnmE478kGZ+GgFsDt+ITdYACcgY7ioQS8r/oGI=;
        b=dhl9EF9FwUKUnmtTaj21fF+rKEq1ZT3x9Lo9Me7HtOjocW6eEuXKFYCiXs9xr9fINF
         qjQY1VPcGwMgETi+Ijb0OOeRzsM9f7ZxWXUMm79oXpw/UwAwvVMogQFgllYs1GsOD7EM
         MErO1Q8aYno/5EMlr7ZnNIdI+Ir66o+2FYQeFKoVAIjC9tWOaUfXQ54nNwlF0cUCYgWk
         1ESeAevyq2Kf7+7G7GYUxOx2kV7BN4l/rUAhFIn8M6a8B1J2AK5si6Ymt4v4/9H560xF
         ruD4M1FelN3IJQX9a550gSB5T6IrSK9Dq7e+vSIkUAjFfB9BvmQurLpDp+6OcxdB3wMM
         zi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759409749; x=1760014549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJKixBnmE478kGZ+GgFsDt+ITdYACcgY7ioQS8r/oGI=;
        b=e4eRgpnoM+6jM5N4BdYcYKXCPfT28Ys85NlDxLheIoZnn3YkM2tAG9ZgcDkUGzl07g
         c8+X5B9WW01Ui1e1j9pShroL0N0YM512PArL1U6YKMOH94oTj9On3eRZ35CB7xn0huIT
         4evjWTd3GXH407vMs6J57M2YT4Q6XiQgNVMFm/V7Pd6O8/2nOlV9GDA/VMck88KT5VMQ
         Bp/tr/QOrGiCgG6tQq0qtwQXB1GNqfQ3iyiKYTQe7Bs7X3y9HhIULYLDh0R+Fa6Twvbu
         64UIeCQWtSVNDlqylIrAG0UqC5g/5/JP0SufXdgIhXNopQMOmO+VqpplIyI3vnbJnjca
         ftNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT9F9HWSImjSckcT/p8pt0AxrfxX1L+cGPmM9rR/Mfe01TOa1ykqCdfZ0d6vN/61FHUKwj79UkZ4vG1+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YybaIBZy8218MZ4Ng+CFLvBNEPWYcObiLSdvQYi9QN8HiMZEcR0
	IJkhZCMVuJVAM/aJZaMXJDmzWs3GuhbgjQWp0mOXRTH++bNQxdbLaIHY
X-Gm-Gg: ASbGnctrTsqonLS3wNApxjjDs3px4uLGbvDGIaE3Ib+yq1Nxu/K6a7l4bLoLrM00Ovo
	zp0MlW+QPlbcDGmDvKhougSt6TOmHKWj8KTpBe07RFnBGdWPlpYXVQnKu5/B3GompUBniOKu95U
	JcSLbs+wWswevYwXoDDJyIyNle761TTkvcU1MIwFufax8LeY5RF/uBpmQ30S8W/E+6Rbw/uWws4
	dku+HdGeBc7LaPjL4qYwjhXAPAwvLERDaINZmCTEMlqabDyHmzfeF89enTf9KaEjnTVkcIVgk3U
	68XvXGtUQ6PdjSl4A9IljRQJGt4ra4zwX0SFDEodLU1JuMMLQTxcZ23JOGSHfQYuX7aMpIfaPsY
	jsYKqF6hLV8ZCE4mfSidVGrogxbmMix7HrbEFhnad+WChWsQ=
X-Google-Smtp-Source: AGHT+IEXlSEGCReTXDSDLwHVI1dX1cLJG7c7lxdNNuysBOzqp9JYRTzMQXY47Kt2ZLlng9HpZPzO6Q==
X-Received: by 2002:a05:6a00:4f94:b0:780:f6db:b1af with SMTP id d2e1a72fcca58-78af420a72bmr7689110b3a.16.1759409748735;
        Thu, 02 Oct 2025 05:55:48 -0700 (PDT)
Received: from fedora ([2405:201:3017:a80:9e5c:2c74:b73f:890a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9a2b9sm2165556b3a.19.2025.10.02.05.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 05:55:48 -0700 (PDT)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Jan Kara <jack@suse.cz>,
	John Garry <john.g.garry@oracle.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: [PATCH 3/4] statmount: allow for "unmounted" mounts
Date: Thu,  2 Oct 2025 18:18:39 +0530
Message-ID: <20251002125422.203598-4-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002125422.203598-1-b.sachdev1904@gmail.com>
References: <20251002125422.203598-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With "unmounted" mounts getting added to a separate umount_mnt_ns, we
need special handling in statmount in order for it to work on
"unmounted" mounts.

unmount_mnt_ns has no root mount (it doesn't really make sense for it to
have one) and "unmounted" mounts have no mountpoint. We handle both
these things in statmount and output the mountpoint as "[detached]" in
case of an "unmounted" mount.

Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 fs/namespace.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0b4be12c02de..29d0e692b365 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5365,6 +5365,12 @@ static int statmount_mnt_root(struct kstatmount *s, struct seq_file *seq)
 	return 0;
 }
 
+static int statmount_mnt_point_detached(struct kstatmount *s, struct seq_file *seq)
+{
+	seq_puts(seq, "[detached]");
+	return 0;
+}
+
 static int statmount_mnt_point(struct kstatmount *s, struct seq_file *seq)
 {
 	struct vfsmount *mnt = s->mnt;
@@ -5589,7 +5595,11 @@ static int statmount_string(struct kstatmount *s, u64 flag)
 		break;
 	case STATMOUNT_MNT_POINT:
 		offp = &sm->mnt_point;
-		ret = statmount_mnt_point(s, seq);
+		if (!s->root.mnt && !s->root.dentry)
+			/* detached mount case */
+			ret = statmount_mnt_point_detached(s, seq);
+		else
+			ret = statmount_mnt_point(s, seq);
 		break;
 	case STATMOUNT_MNT_OPTS:
 		offp = &sm->mnt_opts;
@@ -5743,17 +5753,20 @@ static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 	if (!s->mnt)
 		return -ENOENT;
 
-	err = grab_requested_root(ns, &root);
-	if (err)
-		return err;
+	if (!is_umount_ns(ns)) {
+		err = grab_requested_root(ns, &root);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Don't trigger audit denials. We just want to determine what
 	 * mounts to show users.
 	 */
 	m = real_mount(s->mnt);
-	if (!is_path_reachable(m, m->mnt.mnt_root, &root) &&
-	    !ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
+
+	if (!is_umount_ns(ns) && !is_path_reachable(m, m->mnt.mnt_root, &root) &&
+		!ns_capable_noaudit(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	err = security_sb_statfs(s->mnt->mnt_root);
-- 
2.51.0


