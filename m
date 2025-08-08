Return-Path: <linux-kernel+bounces-759628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC4B1E056
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 03:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0B481890DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 01:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D38149C4D;
	Fri,  8 Aug 2025 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bcj+Qnh/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC43125B2
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 01:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618002; cv=none; b=qapAHlZKkl0LQgcZXfhMnAcSC0iktMumPr8tzRJJsXQ/fmrarlUOypYMUArFXmHC90JTMBaZbv6tN+shwfimyfB2o41ujxIM1UVFMHfe7EsylDWIkWdRHjV6I07gYFUnrLCfqqkskENImsj/Gx5Ao/Q89p9mFJSWHnx0gtlLB1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618002; c=relaxed/simple;
	bh=iIu1jxd7l2LT2Rc7YePMPgDUuAm7xrutv5M7OqRJRTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c4IJ3VF00YdagAb7Lbi5AoM9rjPE9STzBhklEQru91WPsqy9yEEKPEva6v8bfgpmWREwcaDqs4nbkhHIZYnCCvOyVWytjuD7xqPJWryb1QJhRIlJjOrE+7yAVe8FVuwL144eq46Uj59TF7f/m96cA38xeVNtScWqlXIHItdSIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bcj+Qnh/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754617999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=C4HQvGM6gCq5UjAgrjI0OpaDtFtWs4L4CZMG/k70A2M=;
	b=bcj+Qnh/QKDAi9MVMZenu/mNNowY+dDIWf3FCw5ndwhDqOIuw/Dvd0FY85Jk06Mi47Ovsx
	0P7QDJ+5blpys2jlURcEEFfPrEG0+uJ+NIbgdsdUS1RP5/HarTo4r1gfxy/4psp++32nCW
	1+dFkIupjadrIGVBkFdvXYGAfcn8Vhg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-Kf4YjHeMNUeK5Sv-i9dGeA-1; Thu, 07 Aug 2025 21:53:18 -0400
X-MC-Unique: Kf4YjHeMNUeK5Sv-i9dGeA-1
X-Mimecast-MFC-AGG-ID: Kf4YjHeMNUeK5Sv-i9dGeA_1754617997
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24004ac2ecdso25984085ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 18:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754617997; x=1755222797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C4HQvGM6gCq5UjAgrjI0OpaDtFtWs4L4CZMG/k70A2M=;
        b=u+6fo0aUpP3aPc1xYtbMamfBNTkc94pFUFRioAsu1oZS67GcBwnBGQoLMb/HBtLkE7
         JDFm9+5m4Qb5mf3NrTYADl5hFh6f0kbA9zK/85Ph0TwSrwcUU2EPE9MiH+FIcrVRRkLu
         j9Ks3LNiWFFP265hEU11iVolzl/l5k4B26ewPee8NnfePvrAIp33+ZfDwv+/p86QgAVe
         Uy2bLtoG1IZTjaNBDH5TQcljugnzXs6KDhB1MIUWF4vtXdqZD7Z1/Nadn7TpsTnG4p76
         cQlb2b0Q8mTCf7qixOgUQqQfCa68GtpBKifyjIEinFtuV/cIlAvkWhM8oBDagNKbR4Mw
         z8Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUKFLke54VQK5ecV9/2FKzHkGAqzD5qu5aoTS+616ZM1HPn92szmapS6qQNYtnoRFnmR8cC9ZGj1A5Abp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9+qYtIBBeKisdu8VWticfCl07o8fyIiDlpsQru1FkB+obvFSJ
	/z5PluR4R/mDa9pU2wgCrgKJ4liVC1gmF9kfHEsHU6x0iJLth4sPsQwb6YkOZmH1nXJJslxPOSZ
	CLPKFUoD+L5skPMIGyaUrp5am0BoEzNtLl5M1XJxag7l0vF7zT1D8Zq50p7+okzJJNg==
X-Gm-Gg: ASbGnctu7TykQaNwVEXScH4ERRwWtYrClH/dAOaczPfdq5HBcQLeXfEQAdW91hDmLDX
	eKWe3ehio0AognmaKE/N8o5G6Rvc9ovHL7qkfOIEbsaMTNPent/qh6YgExCq5J78XeBmvgRhLhf
	AYs469xmJz8Gkj+vp/Ws3DNWJhsq4UHo/4FLyXkqbYFOXUwP0z3p1KTC45BNy7rj6QnVMYjc6TN
	n2xRZYjmAf2Kk2ZZ6bn3cREWoBggMQxG2MGA5XNiayeUNhxZ2w++VoJd1V4WRMRBAWAMpQ0bjCS
	tFyx3NYmtFze7vX+D10J7sNeRjRRj+IpLfuBgNOSJE1fOj4g0Q==
X-Received: by 2002:a17:903:98f:b0:23f:f96f:9de7 with SMTP id d9443c01a7336-242c22fa800mr17636725ad.51.1754617996949;
        Thu, 07 Aug 2025 18:53:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzC3BF1Wywtk0aqa949HqgY/0heAREy/DrGTfFtCkpL8S7xC6IQT6f8gsYFcsQ3Ak6gssjzw==
X-Received: by 2002:a17:903:98f:b0:23f:f96f:9de7 with SMTP id d9443c01a7336-242c22fa800mr17636425ad.51.1754617996551;
        Thu, 07 Aug 2025 18:53:16 -0700 (PDT)
Received: from f37.llcblog.cn.com ([2408:8212:9001:4210:b99d:5e23:c671:cb6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769e9sm197365815ad.111.2025.08.07.18.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 18:53:16 -0700 (PDT)
From: Lichen Liu <lichliu@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	rob@landley.net
Cc: kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	weilongchen@huawei.com,
	Lichen Liu <lichliu@redhat.com>
Subject: [PATCH] fs: Add 'rootfsflags' to set rootfs mount options
Date: Fri,  8 Aug 2025 09:51:35 +0800
Message-ID: <20250808015134.2875430-2-lichliu@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CONFIG_TMPFS is enabled, the initial root filesystem is a tmpfs.
By default, a tmpfs mount is limited to using 50% of the available RAM
for its content. This can be problematic in memory-constrained
environments, particularly during a kdump capture.

In a kdump scenario, the capture kernel boots with a limited amount of
memory specified by the 'crashkernel' parameter. If the initramfs is
large, it may fail to unpack into the tmpfs rootfs due to insufficient
space. This is because to get X MB of usable space in tmpfs, 2*X MB of
memory must be available for the mount. This leads to an OOM failure
during the early boot process, preventing a successful crash dump.

This patch introduces a new kernel command-line parameter, rootfsflags,
which allows passing specific mount options directly to the rootfs when
it is first mounted. This gives users control over the rootfs behavior.

For example, a user can now specify rootfsflags=size=75% to allow the
tmpfs to use up to 75% of the available memory. This can significantly
reduce the memory pressure for kdump.

Consider a practical example:

To unpack a 48MB initramfs, the tmpfs needs 48MB of usable space. With
the default 50% limit, this requires a memory pool of 96MB to be
available for the tmpfs mount. The total memory requirement is therefore
approximately: 16MB (vmlinuz) + 48MB (loaded initramfs) + 48MB (unpacked
kernel) + 96MB (for tmpfs) + 12MB (runtime overhead) ≈ 220MB.

By using rootfsflags=size=75%, the memory pool required for the 48MB
tmpfs is reduced to 48MB / 0.75 = 64MB. This reduces the total memory
requirement by 32MB (96MB - 64MB), allowing the kdump to succeed with a
smaller crashkernel size, such as 192MB.

An alternative approach of reusing the existing rootflags parameter was
considered. However, a new, dedicated rootfsflags parameter was chosen
to avoid altering the current behavior of rootflags (which applies to
the final root filesystem) and to prevent any potential regressions.

This approach is inspired by prior discussions and patches on the topic.
Ref: https://www.lightofdawn.org/blog/?viewDetailed=00128
Ref: https://landley.net/notes-2015.html#01-01-2015
Ref: https://lkml.org/lkml/2021/6/29/783
Ref: https://www.kernel.org/doc/html/latest/filesystems/ramfs-rootfs-initramfs.html#what-is-rootfs

Signed-off-by: Lichen Liu <lichliu@redhat.com>
---
 fs/namespace.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ddfd4457d338..a450db31613e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -65,6 +65,15 @@ static int __init set_mphash_entries(char *str)
 }
 __setup("mphash_entries=", set_mphash_entries);
 
+static char * __initdata rootfs_flags;
+static int __init rootfs_flags_setup(char *str)
+{
+	rootfs_flags = str;
+	return 1;
+}
+
+__setup("rootfsflags=", rootfs_flags_setup);
+
 static u64 event;
 static DEFINE_XARRAY_FLAGS(mnt_id_xa, XA_FLAGS_ALLOC);
 static DEFINE_IDA(mnt_group_ida);
@@ -6086,7 +6095,7 @@ static void __init init_mount_tree(void)
 	struct mnt_namespace *ns;
 	struct path root;
 
-	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", NULL);
+	mnt = vfs_kern_mount(&rootfs_fs_type, 0, "rootfs", rootfs_flags);
 	if (IS_ERR(mnt))
 		panic("Can't create rootfs");
 
-- 
2.50.1


